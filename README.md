# 🎯 pptx2pdf - PowerPoint to PDF Conversion Tool

A professional command-line tool for batch converting PPTX/PPT files to PDF format.

## 📁 Project Structure

```
~/dev/pptx2pdf/
├── bin/                    # Executable binaries
│   └── pptx2pdf           # Main command-line tool
├── src/                   # Source code
│   ├── batch_pptx_to_pdf.py      # Python implementation
│   └── conversiontools_demo.py   # ConversionTools API demo
├── scripts/               # Installation and utility scripts
│   └── install_pptx2pdf.sh      # Global installation script
├── docs/                  # Documentation
│   ├── README.md                 # Detailed usage guide
│   ├── GLOBAL_USAGE_GUIDE.md     # Global tool usage
│   └── SOLUTION_SUMMARY.md       # Complete solution summary
├── examples/              # Example files and demos
│   ├── test_files/               # Sample PPTX files for testing
│   └── create_samples.js         # Script to generate sample files
└── README.md             # This file
```

## 🚀 Quick Start

### Installation
```bash
# Clone or navigate to the project
cd ~/dev/pptx2pdf

# Install globally (recommended)
./scripts/install_pptx2pdf.sh

# Or use directly
./bin/pptx2pdf --help
```

### Basic Usage
```bash
# Convert all PPTX files in a directory
pptx2pdf ~/Documents/presentations

# Specify input and output directories
pptx2pdf ~/slides ~/pdfs

# Show help
pptx2pdf --help
```

## 📋 Features

- ✅ **Batch Conversion** - Convert multiple files at once
- ✅ **Recursive Search** - Find files in subdirectories
- ✅ **Multiple Backends** - LibreOffice, Keynote, online services
- ✅ **Error Handling** - Detailed error reports and troubleshooting
- ✅ **Cross-platform** - macOS, Linux support
- ✅ **Professional UI** - Colored output and progress indicators

## 🛠 Available Tools

### 1. Main CLI Tool (`bin/pptx2pdf`)
- **Primary tool** for daily use
- Global installation support
- Comprehensive help system
- Version management

### 2. Python Implementation (`src/batch_pptx_to_pdf.py`)
- Multi-backend support (LibreOffice, Keynote, ConversionTools)
- Automatic method detection
- Interactive and command-line modes

### 3. ConversionTools Demo (`src/conversiontools_demo.py`)
- Online conversion service integration
- File size analysis
- API parameter generation

## 🔧 Requirements

- **macOS** (tested) or **Linux**
- **LibreOffice** (install with `brew install libreoffice`)
- **Python 3.x** (for Python scripts)
- **Node.js** (for example generation)

## 📖 Documentation

- [`docs/GLOBAL_USAGE_GUIDE.md`](docs/GLOBAL_USAGE_GUIDE.md) - Complete usage guide
- [`docs/README.md`](docs/README.md) - Detailed implementation guide
- [`docs/SOLUTION_SUMMARY.md`](docs/SOLUTION_SUMMARY.md) - Solution overview

## 🧪 Testing

```bash
# Generate sample PPTX files
cd examples/
node create_samples.js

# Test conversion
pptx2pdf examples/test_files
```

## 🔄 Development

### Project Organization
- `bin/` - Production-ready executables
- `src/` - Source implementations
- `scripts/` - Installation and maintenance scripts
- `docs/` - Documentation and guides
- `examples/` - Test files and demonstrations

### Version Management
Current version: **1.0.0**

Update version in:
- `bin/pptx2pdf` (VERSION variable)
- This README
- Documentation files

## 🚀 Installation Options

### Option 1: Global Installation (Recommended)
```bash
cd ~/dev/pptx2pdf
./scripts/install_pptx2pdf.sh
```

### Option 2: Direct Usage
```bash
cd ~/dev/pptx2pdf
./bin/pptx2pdf [arguments]
```

### Option 3: Add to PATH Manually
```bash
# Add to ~/.zshrc or ~/.bashrc
export PATH="$HOME/dev/pptx2pdf/bin:$PATH"
```

## 🎯 Use Cases

- **Academic** - Convert lecture slides to PDF
- **Business** - Prepare presentation handouts
- **Archival** - Convert old PowerPoint files for storage
- **Automation** - Integrate into batch processing workflows
- **Publishing** - Prepare slides for web distribution

## 📊 Performance

- **Small files** (~1MB): ~2-3 seconds per file
- **Large files** (~10MB): ~5-10 seconds per file
- **Batch processing**: Handles multiple files efficiently
- **Memory usage**: Low memory footprint

## 🆘 Support & Troubleshooting

### Common Issues
1. **LibreOffice not found** - Install with `brew install libreoffice`
2. **Permission denied** - Run `chmod +x ~/dev/pptx2pdf/bin/pptx2pdf`
3. **Command not found** - Run installation script or add to PATH

### Getting Help
- Check `docs/` for detailed guides
- Run `pptx2pdf --help` for usage information
- Review error messages for specific issues

## 📝 License

This project is open source. See individual files for specific licensing terms.

## 🤝 Contributing

1. Fork the project
2. Create feature branch
3. Make changes in appropriate directories
4. Test with example files
5. Submit pull request

## 📅 Version History

- **v1.0.0** (2026-03-07) - Initial release with complete toolset

---

**Happy Converting!** 🎉