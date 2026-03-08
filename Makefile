# pptx2pdf Project Makefile

.PHONY: help install uninstall test examples clean lint package dev

# Default target
help:
	@echo "🛠 pptx2pdf Project Management"
	@echo "=============================="
	@echo ""
	@echo "Available targets:"
	@echo "  install    - Install globally to ~/.local/bin"
	@echo "  uninstall  - Remove global installation"
	@echo "  test       - Run all tests"
	@echo "  examples   - Generate example PPTX files"
	@echo "  clean      - Clean generated files"
	@echo "  lint       - Check code quality"
	@echo "  package    - Create release package"
	@echo "  dev        - Show development tool help"
	@echo "  help       - Show this help"
	@echo ""
	@echo "Examples:"
	@echo "  make install    # Install globally"
	@echo "  make test       # Run tests"
	@echo "  make clean      # Clean up"

# Install globally
install:
	@echo "🚀 Installing pptx2pdf globally..."
	./scripts/install.sh

# Remove global installation
uninstall:
	@echo "🗑 Uninstalling pptx2pdf..."
	./scripts/dev.sh uninstall

# Run tests
test:
	@echo "🧪 Running tests..."
	./scripts/dev.sh test

# Generate examples
examples:
	@echo "📝 Generating example files..."
	./scripts/dev.sh examples

# Clean generated files
clean:
	@echo "🧹 Cleaning generated files..."
	./scripts/dev.sh clean

# Check code quality
lint:
	@echo "🔍 Checking code quality..."
	./scripts/dev.sh lint

# Create release package
package:
	@echo "📦 Creating release package..."
	./scripts/dev.sh package

# Development tools help
dev:
	@echo "🛠 Development tools:"
	./scripts/dev.sh help

# Quick development workflow
dev-setup: examples test
	@echo "✅ Development setup complete"

# Release workflow
release: clean lint test package
	@echo "🎉 Release package created"

# Check project status
status:
	@echo "📊 Project Status"
	@echo "================="
	@echo "Project: $(shell pwd)"
	@echo "Version: $(shell grep 'VERSION=' bin/pptx2pdf | cut -d'=' -f2 | tr -d '\"')"
	@echo "Global install: $(shell command -v pptx2pdf >/dev/null && echo 'Yes' || echo 'No')"
	@echo "LibreOffice: $(shell command -v soffice >/dev/null && echo 'Installed' || echo 'Missing')"
	@echo "Node.js: $(shell command -v node >/dev/null && echo 'Installed' || echo 'Missing')"
	@echo ""
	@echo "Files:"
	@find . -name "*.sh" -o -name "*.py" -o -name "*.js" -o -name "*.md" | grep -v node_modules | wc -l | xargs echo "  Total files:"
	@find examples/test_files -name "*.pptx" 2>/dev/null | wc -l | xargs echo "  Example PPTX:"
	@find examples -name "*.pdf" 2>/dev/null | wc -l | xargs echo "  Generated PDF:"