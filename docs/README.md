# Detailed guide

This document expands on the repository root README and focuses on practical usage, local installation, and troubleshooting.

## What is in this repository?

This mini project provides three related tools:

1. `bin/pptx2pdf` — the main Bash CLI for local batch conversion
2. `src/batch_pptx_to_pdf.py` — a Python helper that explores multiple backends
3. `src/conversiontools_demo.py` — a demo for a ConversionTools-based workflow

For most users, `bin/pptx2pdf` is the only command you need.

## Recommended workflow

### 1. Install LibreOffice

On macOS:

```bash
brew install libreoffice
```

On Ubuntu or Debian:

```bash
sudo apt-get install libreoffice
```

On CentOS or RHEL:

```bash
sudo yum install libreoffice
```

### 2. Run the CLI directly

```bash
./bin/pptx2pdf /path/to/pptx/files
./bin/pptx2pdf /path/to/pptx/files /path/to/pdf/output
```

### 3. Optionally install it into your `$PATH`

#### Installer-based setup

```bash
make install
```

or:

```bash
./scripts/install.sh
```

#### Manual setup

```bash
mkdir -p "$HOME/.local/bin"
ln -sf "$PWD/bin/pptx2pdf" "$HOME/.local/bin/pptx2pdf"
```

For `zsh`:

```bash
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

For `bash`:

```bash
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

Then verify:

```bash
pptx2pdf --version
```

## Command usage

### Show help

```bash
pptx2pdf --help
```

### Convert one directory recursively

```bash
pptx2pdf ~/Documents/presentations
```

### Convert with a custom output directory

```bash
pptx2pdf ~/Documents/presentations ~/Documents/pdfs
```

### Convert the current directory

```bash
pptx2pdf .
```

## Output behavior

If you do not pass an output directory, the tool writes converted files into a `converted_pdfs` folder inside the input directory.

Example:

```text
input/
├── talk.pptx
├── deck.ppt
└── converted_pdfs/
    ├── talk.pdf
    └── deck.pdf
```

## Backend notes

### LibreOffice

This is the primary and recommended backend.

Pros:

- free and local
- works well for batch jobs
- suitable for automation

### Keynote

The Python helper can attempt a Keynote-based route on macOS.

Pros:

- native to macOS
- can preserve presentation layout well

Limits:

- macOS only
- requires Keynote

### ConversionTools

The demo script helps prepare parameters for an online conversion workflow.

Pros:

- useful when a remote conversion flow is acceptable

Limits:

- network required
- large files may need an upload flow
- review privacy implications before using cloud services

## Development notes

Useful commands:

```bash
make help
make test
make lint
make clean
make package
```

Generate sample PPTX files:

```bash
cd examples
node create_samples.js
```

## Troubleshooting

### `soffice` is not available

Install LibreOffice first. If it is already installed on macOS but not exposed in your shell, add:

```bash
export PATH="/Applications/LibreOffice.app/Contents/MacOS:$PATH"
```

### The `pptx2pdf` command is not found

Either run the CLI directly from the repository root:

```bash
./bin/pptx2pdf --help
```

or complete the `$PATH` setup steps above.

### Permission denied

```bash
chmod +x ./bin/pptx2pdf
```

### A file fails to convert

- check whether the file opens in LibreOffice
- confirm the file is not locked by another application
- test a smaller sample file first
- inspect the CLI error message for the failed filename

## AI authorship disclosure

This project is AI-generated and intentionally states that clearly.

- The whole codebase was written by the Claude Sonnet 4.6 LLM model.
- Part of the documentation was written or polished by GPT-5.4.

Human review is recommended before using the repository for production or business-critical document conversion.