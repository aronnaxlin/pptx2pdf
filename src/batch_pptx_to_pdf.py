#!/usr/bin/env python3
"""
PPTX批量转换为PDF工具

支持多种转换方式：
1. LibreOffice命令行（推荐）
2. ConversionTools API（在线服务）
3. macOS Keynote导出（仅限Mac）

使用方法：
python batch_pptx_to_pdf.py [输入目录] [输出目录]
"""

import os
import sys
import glob
import subprocess
import base64
import time
from pathlib import Path
from typing import List, Tuple, Optional

class PPTXToPDFConverter:
    def __init__(self):
        self.supported_methods = ['libreoffice', 'keynote', 'conversiontools']
        self.available_method = None
        self._check_available_methods()
    
    def _check_available_methods(self):
        """检查可用的转换方法"""
        # 检查LibreOffice
        try:
            subprocess.run(['soffice', '--version'], 
                         capture_output=True, check=True, timeout=10)
            self.available_method = 'libreoffice'
            print("✓ 检测到LibreOffice，将使用LibreOffice进行转换")
            return
        except (subprocess.CalledProcessError, FileNotFoundError, subprocess.TimeoutExpired):
            pass
        
        # 检查Keynote（仅限Mac）
        if sys.platform == 'darwin':
            try:
                result = subprocess.run(['osascript', '-e', 
                    'tell application "System Events" to exists application process "Keynote"'],
                    capture_output=True, text=True, timeout=5)
                self.available_method = 'keynote'
                print("✓ 检测到macOS，将使用Keynote进行转换")
                return
            except (subprocess.CalledProcessError, FileNotFoundError, subprocess.TimeoutExpired):
                pass
        
        # ConversionTools作为后备方案
        self.available_method = 'conversiontools'
        print("ℹ 将尝试使用ConversionTools在线服务")
    
    def find_pptx_files(self, directory: str) -> List[str]:
        """查找指定目录下的所有PPTX文件"""
        patterns = ['*.pptx', '*.ppt']
        files = []
        
        for pattern in patterns:
            files.extend(glob.glob(os.path.join(directory, pattern)))
            # 递归查找子目录
            files.extend(glob.glob(os.path.join(directory, '**', pattern), recursive=True))
        
        return sorted(list(set(files)))  # 去重并排序
    
    def convert_with_libreoffice(self, input_files: List[str], output_dir: str) -> List[Tuple[str, bool, str]]:
        """使用LibreOffice批量转换"""
        results = []
        
        # 确保输出目录存在
        Path(output_dir).mkdir(parents=True, exist_ok=True)
        
        for input_file in input_files:
            print(f"🔄 正在转换: {os.path.basename(input_file)}")
            try:
                cmd = [
                    'soffice',
                    '--headless',
                    '--convert-to', 'pdf',
                    '--outdir', output_dir,
                    input_file
                ]
                
                result = subprocess.run(cmd, capture_output=True, text=True, timeout=120)
                
                if result.returncode == 0:
                    pdf_name = os.path.splitext(os.path.basename(input_file))[0] + '.pdf'
                    pdf_path = os.path.join(output_dir, pdf_name)
                    
                    if os.path.exists(pdf_path):
                        print(f"✓ 转换成功: {pdf_name}")
                        results.append((input_file, True, pdf_path))
                    else:
                        print(f"✗ 转换失败: PDF文件未生成")
                        results.append((input_file, False, "PDF文件未生成"))
                else:
                    error_msg = result.stderr.strip() or result.stdout.strip() or "未知错误"
                    print(f"✗ 转换失败: {error_msg}")
                    results.append((input_file, False, error_msg))
                    
            except subprocess.TimeoutExpired:
                print(f"✗ 转换超时: {os.path.basename(input_file)}")
                results.append((input_file, False, "转换超时"))
            except Exception as e:
                print(f"✗ 转换出错: {str(e)}")
                results.append((input_file, False, str(e)))
        
        return results
    
    def convert_with_keynote(self, input_files: List[str], output_dir: str) -> List[Tuple[str, bool, str]]:
        """使用macOS Keynote转换"""
        results = []
        Path(output_dir).mkdir(parents=True, exist_ok=True)
        
        for input_file in input_files:
            print(f"🔄 正在转换: {os.path.basename(input_file)}")
            
            abs_input = os.path.abspath(input_file)
            abs_output_dir = os.path.abspath(output_dir)
            base_name = os.path.splitext(os.path.basename(input_file))[0]
            output_path = os.path.join(abs_output_dir, f"{base_name}.pdf")
            
            applescript = f'''
            tell application "Keynote"
                try
                    set theDoc to open POSIX file "{abs_input}"
                    export theDoc as PDF to POSIX file "{output_path}"
                    close theDoc
                    return "success"
                on error errorMessage
                    return "error: " & errorMessage
                end try
            end tell
            '''
            
            try:
                result = subprocess.run(['osascript', '-e', applescript], 
                                      capture_output=True, text=True, timeout=60)
                
                if result.returncode == 0 and "success" in result.stdout:
                    print(f"✓ 转换成功: {base_name}.pdf")
                    results.append((input_file, True, output_path))
                else:
                    error_msg = result.stdout.strip() or result.stderr.strip() or "Keynote转换失败"
                    print(f"✗ 转换失败: {error_msg}")
                    results.append((input_file, False, error_msg))
                    
            except subprocess.TimeoutExpired:
                print(f"✗ 转换超时: {os.path.basename(input_file)}")
                results.append((input_file, False, "转换超时"))
            except Exception as e:
                print(f"✗ 转换出错: {str(e)}")
                results.append((input_file, False, str(e)))
        
        return results
    
    def convert_with_conversiontools(self, input_files: List[str], output_dir: str) -> List[Tuple[str, bool, str]]:
        """使用ConversionTools API转换（需要联网）"""
        results = []
        Path(output_dir).mkdir(parents=True, exist_ok=True)
        
        print("ℹ ConversionTools需要网络连接和可能的认证")
        print("ℹ 这是一个在线服务，可能有使用限制")
        
        for input_file in input_files:
            print(f"🔄 正在转换: {os.path.basename(input_file)}")
            
            # 检查文件大小
            file_size = os.path.getsize(input_file)
            if file_size > 5 * 1024 * 1024:  # 5MB
                print(f"⚠ 文件大小 {file_size/1024/1024:.1f}MB 超过5MB，需要上传流程")
                results.append((input_file, False, "文件过大，需要实现上传流程"))
                continue
            
            try:
                # 读取并编码文件
                with open(input_file, 'rb') as f:
                    file_content = base64.b64encode(f.read()).decode('utf-8')
                
                base_name = os.path.splitext(os.path.basename(input_file))[0]
                output_filename = f"{base_name}.pdf"
                
                # 这里需要调用ConversionTools API
                print(f"ℹ 需要集成ConversionTools MCP服务器来完成转换")
                results.append((input_file, False, "需要ConversionTools MCP集成"))
                
            except Exception as e:
                print(f"✗ 转换出错: {str(e)}")
                results.append((input_file, False, str(e)))
        
        return results
    
    def batch_convert(self, input_dir: str, output_dir: Optional[str] = None) -> None:
        """批量转换PPTX文件为PDF"""
        if not os.path.exists(input_dir):
            print(f"✗ 输入目录不存在: {input_dir}")
            return
        
        if output_dir is None:
            output_dir = os.path.join(input_dir, "converted_pdfs")
        
        print(f"📁 输入目录: {input_dir}")
        print(f"📁 输出目录: {output_dir}")
        print(f"🔧 转换方法: {self.available_method}")
        print("-" * 50)
        
        # 查找PPTX文件
        pptx_files = self.find_pptx_files(input_dir)
        
        if not pptx_files:
            print("✗ 未找到PPTX或PPT文件")
            return
        
        print(f"📋 找到 {len(pptx_files)} 个演示文件:")
        for i, file in enumerate(pptx_files, 1):
            size_mb = os.path.getsize(file) / 1024 / 1024
            print(f"  {i}. {os.path.basename(file)} ({size_mb:.1f}MB)")
        print("-" * 50)
        
        # 执行转换
        start_time = time.time()
        
        if self.available_method == 'libreoffice':
            results = self.convert_with_libreoffice(pptx_files, output_dir)
        elif self.available_method == 'keynote':
            results = self.convert_with_keynote(pptx_files, output_dir)
        elif self.available_method == 'conversiontools':
            results = self.convert_with_conversiontools(pptx_files, output_dir)
        else:
            print("✗ 没有可用的转换方法")
            return
        
        # 统计结果
        end_time = time.time()
        successful = sum(1 for _, success, _ in results if success)
        failed = len(results) - successful
        
        print("-" * 50)
        print(f"📊 转换完成! 用时: {end_time - start_time:.1f}秒")
        print(f"✓ 成功: {successful} 个文件")
        print(f"✗ 失败: {failed} 个文件")
        
        if failed > 0:
            print("\n❌ 失败的文件:")
            for input_file, success, message in results:
                if not success:
                    print(f"  • {os.path.basename(input_file)}: {message}")
        
        if successful > 0:
            print(f"\n✅ PDF文件已保存到: {output_dir}")

def main():
    converter = PPTXToPDFConverter()
    
    if len(sys.argv) == 1:
        # 交互式模式
        print("🎯 PPTX批量转PDF工具")
        print("=" * 30)
        
        input_dir = input("请输入包含PPTX文件的目录路径: ").strip()
        if not input_dir:
            print("✗ 路径不能为空")
            return
        
        output_dir = input("请输入PDF输出目录（按回车使用默认目录）: ").strip()
        output_dir = output_dir or None
        
    elif len(sys.argv) == 2:
        input_dir = sys.argv[1]
        output_dir = None
    elif len(sys.argv) == 3:
        input_dir = sys.argv[1]
        output_dir = sys.argv[2]
    else:
        print("用法: python batch_pptx_to_pdf.py [输入目录] [输出目录]")
        return
    
    converter.batch_convert(input_dir, output_dir)

if __name__ == "__main__":
    main()