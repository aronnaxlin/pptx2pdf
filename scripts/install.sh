#!/bin/bash

# pptx2pdf 项目安装脚本
# 从当前仓库安装到全局

set -e

# 颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

log_info() { echo -e "${BLUE}ℹ $1${NC}"; }
log_success() { echo -e "${GREEN}✓ $1${NC}"; }
log_error() { echo -e "${RED}✗ $1${NC}"; }

echo "🚀 pptx2pdf 项目安装脚本"
echo "========================="

# 检查项目目录
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
if [[ ! -d "$PROJECT_DIR" ]]; then
    log_error "项目目录不存在: $PROJECT_DIR"
    echo "请确保脚本位于仓库的 scripts/ 目录中"
    exit 1
fi

# 检查主脚本
MAIN_SCRIPT="$PROJECT_DIR/bin/pptx2pdf"
if [[ ! -f "$MAIN_SCRIPT" ]]; then
    log_error "主脚本不存在: $MAIN_SCRIPT"
    exit 1
fi

# 创建bin目录
log_info "创建 ~/.local/bin 目录..."
mkdir -p ~/.local/bin

# 创建符号链接或复制脚本
INSTALL_PATH="$HOME/.local/bin/pptx2pdf"

if [[ -L "$INSTALL_PATH" ]]; then
    log_info "删除现有符号链接..."
    rm "$INSTALL_PATH"
elif [[ -f "$INSTALL_PATH" ]]; then
    log_info "删除现有文件..."
    rm "$INSTALL_PATH"
fi

log_info "创建符号链接..."
ln -s "$MAIN_SCRIPT" "$INSTALL_PATH"

# 设置执行权限
log_info "设置执行权限..."
chmod +x "$MAIN_SCRIPT"

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

# 在当前安装会话中临时生效，方便立即验证
export PATH="$HOME/.local/bin:$PATH"

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

# 测试安装
log_info "测试安装..."
if command -v pptx2pdf &> /dev/null; then
    INSTALLED_VERSION=$(pptx2pdf --version 2>/dev/null | grep -o 'version [0-9.]*' | cut -d' ' -f2 || echo "unknown")
    log_success "安装成功! 版本: $INSTALLED_VERSION"
else
    log_error "安装失败，请检查PATH设置"
    exit 1
fi

echo ""
log_success "pptx2pdf 安装完成!"
echo ""
echo "项目目录: $PROJECT_DIR"
echo "安装路径: $INSTALL_PATH (符号链接)"
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
echo ""
echo "项目文档: $PROJECT_DIR/docs/"