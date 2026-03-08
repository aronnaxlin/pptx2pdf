# pptx2pdf

A small open-source-style command-line project for batch converting PowerPoint files (`.pptx` and `.ppt`) to PDF.

The main CLI uses LibreOffice locally, so it is a good fit for quick personal workflows, local automation, and lightweight document conversion pipelines.

> Status: experimental mini project. Review the output before using it in production workflows.

## Features

- Batch conversion for `.pptx` and `.ppt`
- Recursive file discovery inside subdirectories
- Automatic output directory creation
- Colored terminal output with progress and summary stats
- Optional Python helpers for alternative conversion backends
- Example slide generator for local testing

## Requirements

### Required

- macOS or Linux
- LibreOffice available from `soffice`

### Optional

- Python 3 for the helper scripts in `src/`
- Node.js for generating sample presentations in `examples/`

On macOS, install LibreOffice with:

```bash
brew install libreoffice
```

## Quick start

Run the tool directly from the repository:

```bash
./bin/pptx2pdf /path/to/presentations
./bin/pptx2pdf /path/to/presentations /path/to/output
./bin/pptx2pdf --help
```

If you want the `pptx2pdf` command available everywhere, follow the `$PATH` tutorial below.

## Add `pptx2pdf` to your `$PATH`

There are two practical ways to make the command globally available.

### Option A: use the installer

```bash
make install
```

Or run the installer directly:

```bash
./scripts/install.sh
```

This creates a symlink at `~/.local/bin/pptx2pdf` and updates your shell config if needed.

### Option B: add it manually

1. Create a personal bin directory:

	```bash
	mkdir -p "$HOME/.local/bin"
	```

2. Create a symlink to the project command:

	```bash
	ln -sf "$PWD/bin/pptx2pdf" "$HOME/.local/bin/pptx2pdf"
	```

3. Add `~/.local/bin` to your shell config.

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

4. Verify the command:

	```bash
	pptx2pdf --version
	pptx2pdf --help
	```

If your shell uses `~/.bash_profile` instead of `~/.bashrc`, add the export there instead.

## Usage

### Basic examples

```bash
# Convert every presentation under a directory
pptx2pdf ~/Documents/presentations

# Write PDFs to a custom output directory
pptx2pdf ~/Documents/presentations ~/Documents/pdfs

# Convert from the current directory
pptx2pdf .
```

### Default output location

If you do not pass an output directory, the CLI writes PDFs to:

```text
<input-directory>/converted_pdfs
```

## Project layout

```text
.
├── bin/
│   └── pptx2pdf                # main CLI
├── docs/
│   └── README.md               # detailed guide
├── examples/
│   ├── create_samples.js       # generates sample PPTX files
│   └── test_files/             # local sample assets
├── scripts/
│   ├── dev.sh                  # development helper
│   ├── install.sh              # install into ~/.local/bin
│   └── install_pptx2pdf.sh     # legacy installer script
├── src/
│   ├── batch_pptx_to_pdf.py    # Python helper implementation
│   └── conversiontools_demo.py # ConversionTools demo
├── Makefile
└── README.md
```

## Available tools

### `bin/pptx2pdf`

The main Bash CLI for day-to-day usage.

### `src/batch_pptx_to_pdf.py`

A Python helper that can try multiple backends such as LibreOffice, Keynote, or an online-service workflow.

### `src/conversiontools_demo.py`

A demo script for preparing ConversionTools conversion parameters and checking file-size-related workflow choices.

## Development

Useful targets:

```bash
make help
make install
make test
make lint
make clean
make package
```

Generate sample files with:

```bash
cd examples
node create_samples.js
```

## Troubleshooting

### `soffice: command not found`

Install LibreOffice first:

```bash
brew install libreoffice
```

If LibreOffice is installed but `soffice` is still missing from your shell, try:

```bash
export PATH="/Applications/LibreOffice.app/Contents/MacOS:$PATH"
```

### `pptx2pdf: command not found`

Either run the tool with `./bin/pptx2pdf` from the repository root, or follow the `$PATH` tutorial above.

### Permission issues

```bash
chmod +x ./bin/pptx2pdf
```

## AI authorship disclosure

This repository is intentionally transparent about how it was produced.

- The whole codebase was written by the Claude Sonnet 4.6 LLM model.
- Part of the documentation was written or polished by GPT-5.4.

Human review is still recommended before shipping changes or relying on the output for important documents.

## Contributing

Small fixes, cleanup, and documentation improvements are welcome.

If you contribute:

1. Keep changes focused.
2. Test with local sample files when possible.
3. Update documentation when behavior changes.

## License status

MIT LICENSE