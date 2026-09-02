# Discrete Mathematics: An Open Introduction

An open textbook for Discrete Mathematics, as taught at the University of Northern Colorado. More information about the project is available on [the book's main website](http://discrete.openmathbooks.org).

The `main` branch now has the source code for the 3rd edition. Work on the 4th edition is done on the `edition` branch.

## Compilation instructions

This text is written in [PreTeXt](https://pretextbook.org), so the primary source files can be found in the `source` directory. These can be compiled into HTML or PDF files (as well as some other formats) using the following directions.

### Preliminaries

### Preliminaries

The easiest way to build output formats from the source is to use the
PreTeXt-CLI. To get this set up, follow the instructions in the
[PreTeXt Guide](https://pretextbook.org/guide.html).
You will need Python and LaTeX (required for PDF output and for any
`<latex-image>` elements; image conversion is now handled internally by
the CLI, so `pdf2svg` is no longer required).

This repo pins a specific PreTeXt-CLI version in `requirements.txt`. Install
it with:

    pip install -r requirements.txt

(Using a virtual environment is recommended, so this doesn't conflict with
other CLI versions you may have installed globally: `python -m venv .venv`,
activate it, then run the command above.)

### Compiling

PreTeXt build commands take a **target name** as an argument. Available
targets are defined in `project.ptx` at the root of this repo — open that
file and look for `<target name="...">` entries to see what's available and
what each target produces.

As of this writing, the primary target for building the readable HTML
version of the DMOI4 book is:

    pretext build web4

To generate a PDF, use whichever target in `project.ptx` has
`format="pdf"`.

Asset generation (WeBWorK exercises, images/diagrams, etc.) now happens
automatically as part of `pretext build` — you no longer need separate
flags for this. If you want to force a full regeneration of assets (e.g.
after editing a `<webwork>` or `<latex-image>` element), add `-g`:

    pretext build web4 -g

## Contributing

Any and all suggestions to improve the text are welcome. Thanks to those who have already pointed out typos/issues they have found. If you would like to make a more substantial contribution, please contact me so we can discuss how best to proceed.

## Previous editions

The previous editions have branches, and also tags. Feel free to switch to those if you want to grab the source for those editions.