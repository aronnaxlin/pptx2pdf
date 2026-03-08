# 🎯 pptx2pdf - 全局PPTX转PDF工具

一个优雅的命令行工具，用于批量将PPTX/PPT文件转换为PDF格式。

## ✅ 安装完成状态

你的 `pptx2pdf` 工具已成功安装并可在全局使用！

### 📍 安装位置
- **脚本位置**: `~/.local/bin/pptx2pdf`
- **PATH配置**: 已添加到 `~/.zshrc`
- **当前状态**: ✅ 可在任何目录使用

## 🚀 基本使用方法

### 查看帮助
```bash
pptx2pdf --help
pptx2pdf -h
```

### 查看版本
```bash
pptx2pdf --version
pptx2pdf -v
```

### 基本转换
```bash
# 转换指定目录中的所有PPTX/PPT文件
pptx2pdf ~/Documents/presentations

# 指定输入和输出目录
pptx2pdf ~/Documents/slides ~/Documents/pdfs

# 转换当前目录
pptx2pdf .
```

## 📋 功能特点

- ✅ **全局可用** - 在任何目录都可以运行
- ✅ **批量转换** - 支持同时转换多个文件
- ✅ **递归搜索** - 自动查找子目录中的文件
- ✅ **智能命名** - 保持原文件名，只改变扩展名
- ✅ **彩色输出** - 清晰的进度显示和状态提示
- ✅ **错误处理** - 详细的错误报告和解决建议
- ✅ **统计信息** - 转换成功/失败的详细统计

## 📊 使用示例

### 示例1: 转换桌面上的演示文件
```bash
pptx2pdf ~/Desktop/presentations
```

### 示例2: 指定输出目录
```bash
pptx2pdf ~/Documents/work-slides ~/Documents/work-pdfs
```

### 示例3: 转换当前目录并查看详细信息
```bash
cd /path/to/your/slides
pptx2pdf .
```

## 🔧 输出示例

```bash
$ pptx2pdf ~/Documents/slides

🎯 PPTX批量转PDF工具 v1.0.0
============================================
✓ 检测到LibreOffice
ℹ 输入目录: /Users/aronnax/Documents/slides
ℹ 输出目录: /Users/aronnax/Documents/slides/converted_pdfs
--------------------------------------------
ℹ 找到 3 个演示文件:
  1. presentation1.pptx (2MB)
  2. meeting-notes.ppt (1MB)
  3. project-demo.pptx (5MB)
--------------------------------------------
🔄 正在转换: presentation1.pptx ... ✓ 成功
🔄 正在转换: meeting-notes.ppt ... ✓ 成功
🔄 正在转换: project-demo.pptx ... ✓ 成功
--------------------------------------------
ℹ 转换完成! 用时: 12秒
✓ 成功: 3 个文件

✓ PDF文件已保存到: /Users/aronnax/Documents/slides/converted_pdfs

ℹ 生成的PDF文件:
  • meeting-notes.pdf
  • presentation1.pdf
  • project-demo.pdf

🎉 转换完成! 可以在输出目录中查看PDF文件。
```

## ⚙️ 系统要求

- **操作系统**: macOS (已测试)
- **依赖软件**: LibreOffice
- **Shell**: zsh 或 bash

### LibreOffice安装
如果尚未安装LibreOffice:
```bash
brew install libreoffice
```

## 🛠 高级功能

### 支持的文件格式
- `.pptx` - PowerPoint 2007及以后版本
- `.ppt` - PowerPoint 97-2003版本

### 搜索范围
工具会递归搜索指定目录及其所有子目录中的PPTX和PPT文件。

### 输出目录结构
```
输入目录/
├── file1.pptx
├── subfolder/
│   └── file2.ppt
└── converted_pdfs/        # 默认输出目录
    ├── file1.pdf
    └── file2.pdf
```

## 🔍 故障排除

### 常见问题

1. **命令未找到**
   ```bash
   # 重新加载shell配置
   source ~/.zshrc
   
   # 或者重启终端
   ```

2. **LibreOffice错误**
   ```bash
   # 确认LibreOffice已安装
   brew install libreoffice
   
   # 检查版本
   soffice --version
   ```

3. **权限问题**
   ```bash
   # 确保脚本可执行
   chmod +x ~/.local/bin/pptx2pdf
   ```

4. **转换失败**
   - 检查文件是否损坏
   - 确认文件没有被其他程序占用
   - 查看错误详情进行诊断

### 获取详细错误信息
工具会自动显示失败文件的详细错误信息，帮助诊断问题。

## 🔄 更新脚本

如果需要更新到新版本:
```bash
# 重新运行安装脚本
./install_pptx2pdf.sh
```

## 🗑 卸载

如果需要移除工具:
```bash
# 删除脚本文件
rm ~/.local/bin/pptx2pdf

# 从shell配置中移除PATH(可选)
# 编辑 ~/.zshrc 并删除相关行
```

## 💡 使用技巧

1. **批量处理大量文件**: 工具会逐个处理文件，避免系统过载
2. **保持文件组织**: 使用子目录组织不同项目的文件
3. **预览检查**: 转换后检查几个PDF文件确认质量
4. **自动化集成**: 可以集成到其他脚本或工作流中

## 🎉 总结

现在你可以在 Mac 的任何地方使用 `pptx2pdf` 命令来批量转换PPTX文件了！

**快速开始**:
1. 打开终端
2. 运行 `pptx2pdf ~/path/to/your/slides`
3. 在输出目录中查看生成的PDF文件

享受高效的文件转换体验吧！🚀