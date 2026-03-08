#!/usr/bin/env python3
"""
使用ConversionTools API批量转换PPTX为PDF的示例脚本
需要ConversionTools MCP服务器支持
"""

import os
import glob
import json
import base64
from pathlib import Path

class ConversionToolsConverter:
    """ConversionTools API转换器"""
    
    def __init__(self):
        self.max_file_size = 5 * 1024 * 1024  # 5MB
    
    def find_pptx_files(self, directory):
        """查找PPTX文件"""
        patterns = ['*.pptx', '*.ppt'] 
        files = []
        for pattern in patterns:
            files.extend(glob.glob(os.path.join(directory, pattern)))
            files.extend(glob.glob(os.path.join(directory, '**', pattern), recursive=True))
        return sorted(list(set(files)))
    
    def convert_small_file(self, input_file, output_dir):
        """转换小文件（<5MB）"""
        try:
            # 读取并编码文件
            with open(input_file, 'rb') as f:
                file_content = base64.b64encode(f.read()).decode('utf-8')
            
            base_name = os.path.splitext(os.path.basename(input_file))[0]
            output_filename = f"{base_name}.pdf"
            
            # 准备转换参数
            conversion_params = {
                "input_path": os.path.basename(input_file),
                "output_path": output_filename,
                "file_content": file_content
            }
            
            print(f"📤 准备转换: {os.path.basename(input_file)}")
            print(f"   文件大小: {len(file_content)/1024/1024:.1f}MB (base64)")
            print(f"   输出文件: {output_filename}")
            
            return conversion_params, output_filename
            
        except Exception as e:
            print(f"❌ 文件处理失败: {str(e)}")
            return None, None
    
    def convert_large_file(self, input_file):
        """转换大文件（>5MB），需要上传"""
        filename = os.path.basename(input_file)
        file_size = os.path.getsize(input_file)
        
        print(f"📁 大文件转换: {filename}")
        print(f"   文件大小: {file_size/1024/1024:.1f}MB")
        print("   需要使用上传URL流程")
        
        # 这里需要调用 conversiontools:request_upload_url
        upload_params = {
            "filename": filename
        }
        
        return upload_params
    
    def batch_convert_info(self, input_dir, output_dir=None):
        """显示批量转换信息和参数"""
        if output_dir is None:
            output_dir = os.path.join(input_dir, "converted_pdfs")
        
        Path(output_dir).mkdir(parents=True, exist_ok=True)
        
        files = self.find_pptx_files(input_dir)
        
        if not files:
            print("❌ 未找到PPTX文件")
            return
        
        print("🎯 ConversionTools批量转换计划")
        print("=" * 50)
        print(f"📁 输入目录: {input_dir}")
        print(f"📁 输出目录: {output_dir}")
        print(f"📋 找到文件: {len(files)} 个")
        print("-" * 50)
        
        small_files = []
        large_files = []
        
        for file_path in files:
            file_size = os.path.getsize(file_path)
            filename = os.path.basename(file_path)
            
            if file_size <= self.max_file_size:
                small_files.append(file_path)
                print(f"📄 {filename} ({file_size/1024/1024:.1f}MB) - 直接转换")
            else:
                large_files.append(file_path)
                print(f"📦 {filename} ({file_size/1024/1024:.1f}MB) - 需要上传")
        
        print("-" * 50)
        
        # 生成转换指令
        if small_files:
            print("🔧 小文件转换参数 (可直接使用conversiontools:convert_file):")
            print()
            for i, file_path in enumerate(small_files, 1):
                params, output_name = self.convert_small_file(file_path, output_dir)
                if params:
                    print(f"文件 {i}: {os.path.basename(file_path)}")
                    print("conversiontools:convert_file 参数:")
                    print(json.dumps({
                        "input_path": params["input_path"],
                        "output_path": params["output_path"],
                        "file_content": params["file_content"][:100] + "..." # 截断显示
                    }, indent=2))
                    print()
        
        if large_files:
            print("📤 大文件转换流程 (需要先上传):")
            print()
            for i, file_path in enumerate(large_files, 1):
                params = self.convert_large_file(file_path)
                print(f"大文件 {i}: {os.path.basename(file_path)}")
                print("1. 调用 conversiontools:request_upload_url:")
                print(json.dumps(params, indent=2))
                print("2. 使用返回的URL上传文件")
                print("3. 使用返回的file_id调用convert_file")
                print()
        
        print("💡 提示:")
        print("  • 小文件可以直接使用 file_content 参数转换")
        print("  • 大文件需要先上传获取 file_id")
        print("  • 转换完成后使用返回的 download_url 下载PDF")
        print("  • 免费账户每月100次转换，每天10次")

def main():
    converter = ConversionToolsConverter()
    
    print("📊 ConversionTools PPTX转PDF分析工具")
    print("=" * 40)
    
    if len(os.sys.argv) > 1:
        input_dir = os.sys.argv[1]
        output_dir = os.sys.argv[2] if len(os.sys.argv) > 2 else None
    else:
        input_dir = input("请输入PPTX文件目录: ").strip()
        output_dir = input("请输入PDF输出目录（回车使用默认）: ").strip() or None
    
    if not os.path.exists(input_dir):
        print(f"❌ 目录不存在: {input_dir}")
        return
    
    converter.batch_convert_info(input_dir, output_dir)

if __name__ == "__main__":
    main()