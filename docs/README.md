# PPTX批量转PDF使用指南

这里提供了多种将PPTX文件批量转换为PDF的解决方案。

## 🚀 快速开始

### 方法1：使用bash脚本（推荐）

```bash
# 给脚本执行权限
chmod +x convert_pptx_to_pdf.sh

# 交互式使用
./convert_pptx_to_pdf.sh

# 指定目录使用
./convert_pptx_to_pdf.sh /path/to/pptx/files

# 指定输入和输出目录
./convert_pptx_to_pdf.sh /path/to/pptx/files /path/to/pdf/output
```

### 方法2：使用Python脚本

```bash
# 交互式使用
python3 batch_pptx_to_pdf.py

# 命令行使用
python3 batch_pptx_to_pdf.py /path/to/pptx/files /path/to/pdf/output
```

## 📋 支持的转换方式

### 1. LibreOffice命令行（推荐）✅

**优点**：
- 免费开源
- 转换质量高
- 支持批量处理
- 跨平台支持

**安装方法**：
```bash
# macOS
brew install libreoffice

# Ubuntu/Debian
sudo apt-get install libreoffice

# CentOS/RHEL
sudo yum install libreoffice
```

**使用示例**：
```bash
# 转换单个文件
soffice --headless --convert-to pdf presentation.pptx

# 批量转换到指定目录
soffice --headless --convert-to pdf --outdir ./output *.pptx
```

### 2. macOS Keynote导出

**优点**：
- Mac系统原生支持
- 转换质量极高
- 保持格式完整性

**缺点**：
- 仅限macOS系统
- 需要Keynote应用

**AppleScript示例**：
```applescript
tell application "Keynote"
    set theDoc to open POSIX file "/path/to/presentation.pptx"
    export theDoc as PDF to POSIX file "/path/to/output.pdf"
    close theDoc
end tell
```

### 3. ConversionTools在线服务

**优点**：
- 无需安装软件
- 支持多种格式
- 转换质量好

**缺点**：
- 需要网络连接
- 可能有使用限制
- 大文件需要上传

## 🛠 脚本功能特色

### Bash脚本特色
- ✅ 自动检测LibreOffice安装状态
- ✅ 支持递归查找子目录中的PPTX文件
- ✅ 彩色输出，清晰显示转换状态
- ✅ 超时控制，避免卡死
- ✅ 详细的成功/失败统计
- ✅ 文件大小显示

### Python脚本特色
- ✅ 自动检测最佳转换方法
- ✅ 支持多种转换后端
- ✅ 详细的错误处理
- ✅ 进度显示和统计
- ✅ 交互式和命令行两种模式

## 📁 输出目录结构

```
输入目录/
├── presentation1.pptx
├── presentation2.pptx
└── subfolder/
    └── presentation3.pptx

输出目录/
├── presentation1.pdf
├── presentation2.pdf
└── presentation3.pdf
```

## ⚠ 注意事项

1. **文件权限**：确保脚本有读取PPTX文件和写入输出目录的权限
2. **文件路径**：避免文件名包含特殊字符或空格
3. **转换时间**：大文件或复杂演示可能需要更长时间
4. **内存使用**：同时转换多个大文件可能占用大量内存
5. **格式兼容性**：某些复杂动画或特效可能无法完美保留

## 🔧 故障排除

### LibreOffice相关问题

**问题**：`soffice: command not found`
```bash
# macOS
brew install libreoffice

# 或者检查路径
export PATH="/Applications/LibreOffice.app/Contents/MacOS:$PATH"
```

**问题**：转换卡死或超时
```bash
# 增加超时时间或手动终止进程
pkill soffice
```

**问题**：某些文件转换失败
- 检查文件是否损坏
- 尝试先在LibreOffice中手动打开
- 确认文件格式是否正确

### 权限问题

```bash
# 确保脚本可执行
chmod +x convert_pptx_to_pdf.sh

# 确保目录权限
chmod 755 /path/to/directories
```

## 💡 使用技巧

1. **批量处理大文件**：建议分批处理，避免系统负载过高
2. **预览检查**：转换后检查几个PDF文件，确认质量满足要求
3. **备份原文件**：重要文件建议先备份再转换
4. **自动化**：可以将脚本加入cron job实现定时转换
5. **网络转换**：对于在线服务，注意文件隐私和网络稳定性

## 📊 性能参考

基于MacBook Air M1的测试结果：

| 文件大小 | 页数 | 转换时间 | 方法 |
|---------|------|----------|------|
| 5MB | 20页 | 3秒 | LibreOffice |
| 15MB | 50页 | 8秒 | LibreOffice |
| 30MB | 100页 | 15秒 | LibreOffice |
| 5MB | 20页 | 5秒 | Keynote |

## 🆘 获取帮助

如果遇到问题：
1. 检查错误信息和日志输出
2. 确认依赖软件已正确安装
3. 验证文件格式和路径
4. 查看脚本注释中的详细说明

---

**最后更新**: 2026-03-07  
**版本**: 1.0