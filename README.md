# LaTeX templates for University of Skövde PhDs
This repo contains LaTeX templates for the PhD education at the University of Skövde. These include:

- Doctoral Dissertation
- Licentiate Thesis
- Thesis Proposal
- Research Proposal

## Requirements
LuaLaTeX as the engine, change that in Overleaf. To compile locally you can use [TexLive](https://tug.org/texlive/). The files are updated to work in TexLive 2022.

## Installation
Upload the package to Overleaf or use the Makefile to build locally.
Test that you are able to produce the example-thesis.tex by running 
```bash
latexmk -pdf example-thesis.tex -c
```
If successful, you should see an example-thesis.pdf containing the example report in pdf format.

## Usage
1. Fill the required metadata for your manuscript in metadata.tex.
2. Copy example-thesis.tex and name it manuscript.tex. This is your main file for writing your manuscript.
3. Supply the correct class options to the his-thesis class defined below.
4. Choose the structure of your manuscript, either everything in the same tex file or structured in chapters.
5. Fill in the frontmatter and backmatter environments as in the `example-thesis.tex`.
6. Choose how you want to structure your previous publications. Either as individual publications or ranked by high and low relevance.

## Class options to his-thesis
**One** of the following to set language:
- `english`
- `swedish`

**One** of the following to define the type of publication:
- `dissertation`: For doctoral dissertation
- `licentiate`: For licentiate dissertation
- `thesisproposal`: For thesis proposals
- `researchproposal`: For research proposals

These are optional and both can be supplied:
- `final`: Indicates the final version of the manuscript.
- `cover`: Create cover pages if supplied.

Example could look like this to create a doctoral dissertation in English, with the final format, and front and back covers.
```latex
\documentclass[english,dissertation,final,cover]{his-thesis}
```

## Specific commands for the template
### metadata.tex
```latex
%% Define partner company name and logo.
%% To be used if you are performing the work in collaboration with a company.
\partnercompany{Company AB}
\partnercompanylogo{img/companylogo.png}
```
If you are writing your thesis together with another company, supply the name and logo here.

```latex
%% The path to an image on the front cover, and an image of you on the back cover.
\coverimage{template/Manuscript/foto.jpg}
\coverphoto{template/Manuscript/face.jpg}
```
Sets the front cover image, which is optional, and the back cover photo which is required.

## Difference between thesis and proposal
The publicationtype of `dissertation` and `licentiate` are special, as they are requirements towards a degree. These will be typeset as a book, with special page size, contents, and colors. These follow the guidelines at the university [page](https://www.his.se/forskning/doktorandhandbok/disputation/avhandlingsmallar/) (in Swedish).

The two other deliveries, `thesisproposal` and `researchproposal`, are formatted as a report as they are not going to be printed. This means A4 sizing, report format, no empty pages between chapters, and larger fonts to correspond to the larger paper size.

## Printing a draft version
You can also use the `draft.tex` to create a printable version of your manuscript for review. Replace the filename in draft.tex with the name of your compiled pdf and it will take care of the rest. It will print the draft without cover pages.

## Useful commands for creating the pdf
If you are comfortable with the Makefile approach, adapt the Makefile and use those commands.

- Using regular latexmk. Compile to pdf (using [latexmk](https://mg.readthedocs.io/latexmk.html)):
```bash
latexmk -pdf example-thesis.tex
```
- Continuously checking for changes and recompiling, previewing the output.
```bash
latexmk -pvc example-thesis.tex
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
