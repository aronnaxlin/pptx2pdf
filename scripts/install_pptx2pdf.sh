#!/bin/bash

# pptx2pdf 全局安装脚本

set -e

# 颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

log_info() { echo -e "${BLUE}ℹ $1${NC}"; }
log_success() { echo -e "${GREEN}✓ $1${NC}"; }
log_error() { echo -e "${RED}✗ $1${NC}"; }

echo "🚀 pptx2pdf 全局安装脚本"
echo "========================="

# 检查是否是macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    log_error "此脚本目前只支持macOS"
    exit 1
fi

# 创建bin目录
log_info "创建 ~/.local/bin 目录..."
mkdir -p ~/.local/bin

# 下载或复制脚本
SCRIPT_URL="https://raw.githubusercontent.com/your-repo/pptx2pdf/main/pptx2pdf"
SCRIPT_PATH="$HOME/.local/bin/pptx2pdf"

if command -v curl &> /dev/null; then
    log_info "从当前目录复制脚本..."
    if [[ -f "pptx2pdf" ]]; then
        cp pptx2pdf "$SCRIPT_PATH"
    elif [[ -f "convert_pptx_to_pdf_v2.sh" ]]; then
        cp convert_pptx_to_pdf_v2.sh "$SCRIPT_PATH"
    else
        log_error "未找到pptx2pdf脚本文件"
        exit 1
    fi
else
    log_error "需要curl命令来下载脚本"
    exit 1
fi

# 设置执行权限
log_info "设置执行权限..."
chmod +x "$SCRIPT_PATH"

# 检查并添加到PATH
SHELL_CONFIG=""
if [[ $SHELL == *"zsh"* ]]; then
    SHELL_CONFIG="$HOME/.zshrc"
elif [[ $SHELL == *"bash"* ]]; then
    SHELL_CONFIG="$HOME/.bashrc"
    [[ ! -f "$SHELL_CONFIG" ]] && SHELL_CONFIG="$HOME/.bash_profile"
fi

if [[ -n "$SHELL_CONFIG" ]]; then
    if ! grep -q '\.local/bin' "$SHELL_CONFIG" 2>/dev/null; then
        log_info "添加到PATH..."
        echo '' >> "$SHELL_CONFIG"
        echo '# Added by pptx2pdf installer' >> "$SHELL_CONFIG"
        echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$SHELL_CONFIG"
        log_success "已添加到 $SHELL_CONFIG"
    else
        log_info "PATH已包含 ~/.local/bin"
    fi
fi

# 检查LibreOffice
log_info "检查依赖..."
if ! command -v soffice &> /dev/null; then
    log_error "LibreOffice未安装"
    echo ""
    echo "请运行以下命令安装LibreOffice:"
    echo "  brew install libreoffice"
    echo ""
    echo "安装LibreOffice后，pptx2pdf就可以正常使用了。"
else
    log_success "LibreOffice已安装"
fi

echo ""
log_success "pptx2pdf 安装完成!"
echo ""
echo "使用方法:"
echo "  pptx2pdf --help          # 查看帮助"
echo "  pptx2pdf [目录]          # 转换指定目录中的PPTX文件"
echo "  pptx2pdf [输入] [输出]   # 指定输入和输出目录"
echo ""
echo "注意: 请重启终端或运行 'source $SHELL_CONFIG' 来更新PATH"
echo ""
echo "示例:"
echo "  pptx2pdf ~/Documents/presentations"
echo "  pptx2pdf ~/slides ~/pdfs"