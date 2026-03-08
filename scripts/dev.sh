#!/bin/bash

# pptx2pdf 开发工具脚本

set -e

# 颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log_info() { echo -e "${BLUE}ℹ $1${NC}"; }
log_success() { echo -e "${GREEN}✓ $1${NC}"; }
log_warning() { echo -e "${YELLOW}⚠ $1${NC}"; }
log_error() { echo -e "${RED}✗ $1${NC}"; }

# 项目根目录
PROJECT_ROOT="$HOME/dev/pptx2pdf"

# 显示帮助
show_help() {
    cat << EOF
🛠 pptx2pdf 开发工具

使用方法: $0 [命令]

命令:
  install     安装到全局 (~/.local/bin)
  uninstall   从全局移除
  test        运行测试
  examples    生成示例文件
  clean       清理生成的文件
  lint        检查代码质量
  package     打包发布
  help        显示此帮助信息

示例:
  $0 install    # 安装到全局
  $0 test       # 运行测试
  $0 examples   # 生成示例文件

EOF
}

# 安装到全局
install_global() {
    log_info "开始全局安装..."
    cd "$PROJECT_ROOT"
    ./scripts/install.sh
}

# 从全局卸载
uninstall_global() {
    log_info "卸载全局安装..."
    
    if [[ -L ~/.local/bin/pptx2pdf ]]; then
        rm ~/.local/bin/pptx2pdf
        log_success "已移除符号链接"
    elif [[ -f ~/.local/bin/pptx2pdf ]]; then
        rm ~/.local/bin/pptx2pdf
        log_success "已移除文件"
    else
        log_warning "未找到已安装的pptx2pdf"
    fi
    
    log_info "可以手动从shell配置文件中移除PATH设置"
}

# 运行测试
run_tests() {
    log_info "运行测试..."
    cd "$PROJECT_ROOT"
    
    # 检查主脚本
    if [[ ! -f "bin/pptx2pdf" ]]; then
        log_error "主脚本不存在"
        return 1
    fi
    
    # 检查权限
    if [[ ! -x "bin/pptx2pdf" ]]; then
        log_warning "修复执行权限..."
        chmod +x bin/pptx2pdf
    fi
    
    # 测试帮助功能
    log_info "测试帮助功能..."
    ./bin/pptx2pdf --help >/dev/null
    log_success "帮助功能正常"
    
    # 测试版本功能
    log_info "测试版本功能..."
    ./bin/pptx2pdf --version >/dev/null
    log_success "版本功能正常"
    
    # 检查示例文件
    if [[ -d "examples/test_files" ]]; then
        file_count=$(find examples/test_files -name "*.pptx" | wc -l)
        if [[ $file_count -gt 0 ]]; then
            log_info "测试文件转换..."
            ./bin/pptx2pdf examples/test_files examples/test_output
            log_success "转换测试通过"
        else
            log_warning "未找到测试PPTX文件"
        fi
    else
        log_warning "未找到测试文件目录"
    fi
    
    log_success "所有测试通过!"
}

# 生成示例文件
generate_examples() {
    log_info "生成示例文件..."
    cd "$PROJECT_ROOT/examples"
    
    if [[ -f "create_samples.js" ]]; then
        if command -v node &> /dev/null; then
            # 检查依赖
            if [[ ! -d "node_modules" ]]; then
                log_info "安装Node.js依赖..."
                npm install pptxgenjs
            fi
            
            log_info "运行示例生成脚本..."
            node create_samples.js
            log_success "示例文件生成完成"
        else
            log_error "需要Node.js来生成示例文件"
            echo "请安装Node.js: brew install node"
        fi
    else
        log_error "未找到示例生成脚本"
    fi
}

# 清理生成的文件
clean_generated() {
    log_info "清理生成的文件..."
    cd "$PROJECT_ROOT"
    
    # 清理示例输出
    if [[ -d "examples/test_output" ]]; then
        rm -rf examples/test_output
        log_success "已清理测试输出目录"
    fi
    
    if [[ -d "examples/test_files/converted_pdfs" ]]; then
        rm -rf examples/test_files/converted_pdfs*
        log_success "已清理转换输出目录"
    fi
    
    # 清理Node.js依赖
    if [[ -d "examples/node_modules" ]]; then
        rm -rf examples/node_modules
        log_success "已清理Node.js依赖"
    fi
    
    if [[ -f "examples/package-lock.json" ]]; then
        rm examples/package-lock.json
        log_success "已清理package-lock.json"
    fi
    
    log_success "清理完成"
}

# 检查代码质量
lint_code() {
    log_info "检查代码质量..."
    cd "$PROJECT_ROOT"
    
    # 检查bash脚本
    if command -v shellcheck &> /dev/null; then
        log_info "检查bash脚本..."
        shellcheck bin/pptx2pdf scripts/*.sh
        log_success "Bash脚本检查通过"
    else
        log_warning "shellcheck未安装，跳过bash脚本检查"
        echo "安装: brew install shellcheck"
    fi
    
    # 检查Python脚本
    if command -v python3 &> /dev/null; then
        log_info "检查Python语法..."
        python3 -m py_compile src/*.py
        log_success "Python语法检查通过"
    else
        log_warning "Python3未安装，跳过Python检查"
    fi
    
    log_success "代码质量检查完成"
}

# 打包发布
package_release() {
    log_info "准备打包..."
    cd "$PROJECT_ROOT"
    
    # 获取版本号
    VERSION=$(grep 'VERSION=' bin/pptx2pdf | cut -d'"' -f2)
    PACKAGE_NAME="pptx2pdf-v${VERSION}"
    
    log_info "版本: $VERSION"
    log_info "包名: $PACKAGE_NAME"
    
    # 创建打包目录
    TEMP_DIR=$(mktemp -d)
    PACKAGE_DIR="$TEMP_DIR/$PACKAGE_NAME"
    
    log_info "创建打包目录: $PACKAGE_DIR"
    mkdir -p "$PACKAGE_DIR"
    
    # 复制文件
    cp -r bin src scripts docs examples "$PACKAGE_DIR/"
    cp README.md "$PACKAGE_DIR/"
    
    # 清理示例文件中的输出
    find "$PACKAGE_DIR/examples" -name "converted_pdfs*" -type d -exec rm -rf {} + 2>/dev/null || true
    find "$PACKAGE_DIR/examples" -name "node_modules" -type d -exec rm -rf {} + 2>/dev/null || true
    find "$PACKAGE_DIR/examples" -name "package-lock.json" -delete 2>/dev/null || true
    
    # 创建tar.gz包
    cd "$TEMP_DIR"
    tar -czf "${PACKAGE_NAME}.tar.gz" "$PACKAGE_NAME"
    
    # 移动到项目目录
    mv "${PACKAGE_NAME}.tar.gz" "$PROJECT_ROOT/"
    
    # 清理临时目录
    rm -rf "$TEMP_DIR"
    
    log_success "打包完成: ${PACKAGE_NAME}.tar.gz"
    
    # 显示包信息
    cd "$PROJECT_ROOT"
    PACKAGE_SIZE=$(du -h "${PACKAGE_NAME}.tar.gz" | cut -f1)
    log_info "包大小: $PACKAGE_SIZE"
}

# 主函数
main() {
    # 检查项目目录
    if [[ ! -d "$PROJECT_ROOT" ]]; then
        log_error "项目目录不存在: $PROJECT_ROOT"
        exit 1
    fi
    
    case "${1:-help}" in
        install)
            install_global
            ;;
        uninstall)
            uninstall_global
            ;;
        test)
            run_tests
            ;;
        examples)
            generate_examples
            ;;
        clean)
            clean_generated
            ;;
        lint)
            lint_code
            ;;
        package)
            package_release
            ;;
        help|--help|-h)
            show_help
            ;;
        *)
            log_error "未知命令: $1"
            echo ""
            show_help
            exit 1
            ;;
    esac
}

# 运行主函数
main "$@"