# LaTeX templates for Unviersity of Skövde PhDs
This repo contains LaTeX templates for the PhD education at the University of Skövde. These include:

- Doctoral Dissertation
- Licentiate Thesis
- Thesis Proposal
- Research Proposal

## Requirements
- [TexLive](https://tug.org/texlive/)

## Installation
Upload the package to Overleaf or use the Makefile to build locally.
Test that you are able to produce the example-thesis.tex by running 
```bash
latexmk -pdf example-thesis.tex
```
If successful, you should see an example-thesis.pdf containing the example report in pdf format.

## Usage
1. Fill the required metadata for your manuscript in metadata.tex.
2. Copy example-thesis.tex and name it manuscript.tex. This is your main file for writing your manuscript.
3. Choose the structure of your manuscript, either everything in the same tex file or structured in chapters.
4. Choose how you want to structure your previous publications. Either as individual publications or ranked by high and low relevance.

## Useful commands
If you are comfortable with the Makefile approach, adapt the Makefile and use those commands.

- Using regular latexmk. Compile to pdf (using [latexmk](https://mg.readthedocs.io/latexmk.html)):
```bash
latexmk -pdf example-thesis.tex
```
- Clean (delete some of the auxiliary files):
```bash
latexmk -c
```
- Install Microsoft fonts (if in Linux):
```bash
sudo apt install ttf-mscorefonts-installer
```

Shield: [![CC BY-SA 4.0][cc-by-sa-shield]][cc-by-sa]

This work is licensed under a
[Creative Commons Attribution-ShareAlike 4.0 International License][cc-by-sa].

[![CC BY-SA 4.0][cc-by-sa-image]][cc-by-sa]

[cc-by-sa]: http://creativecommons.org/licenses/by-sa/4.0/
[cc-by-sa-image]: https://licensebuttons.net/l/by-sa/4.0/88x31.png
[cc-by-sa-shield]: https://img.shields.io/badge/License-CC%20BY--SA%204.0-lightgrey.svg
