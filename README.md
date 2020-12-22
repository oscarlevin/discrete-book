# Discrete Mathematics: An Open Introduction

An open textbook for Discrete Mathematics, as taught at the University of Northern Colorado.  More information about the project is available on [the book's main website](http://discrete.openmathbooks.org).

The `master` branch here now has the source code for the 3rd edition.  Work on the 4th edition is done on the `edition` branch.


## Compilation instructions

This text is written in [PreTeXt](https://pretextbook.org) (previously called MathBook XML), so the primary source files can be found in the `ptx` directory.  These can be compiled into HTML or LaTeX files (as well as some other formats).  If you do not want to bother with this step or just want to grab some LaTeX to use in a worksheet or the like, the generated LaTeX is already provided in the `latex` folder.

### Preliminaries

To compile from source, you will need a copy of the MathBook XSL stylesheets, as well as `xsltproc`, Python, LaTeX, and `pdf2svg` and `make` installed (should be simple on Linux or macOS, but also possible on Windows---see some [PreTeXt for Novices Using Windows](https://pretextbook.org/doc/pnw/html/novices.html)).

Earlier editions, that did not include WeBWorK problems were easy enough to compile using commands like `xsltproc --xinclude ../xsl/custom-latex.xsl ../ptx/dmoi.ptx`.  Now though, there are enough intermediate steps that I've written a `Makefile` that keeps everything together.  As long as you have all the tools installed, this should make things easy.

You will need to open up `Makefile.paths.original` and follow the directions there (create a copy called `Makefile.paths` and specify paths to various things).  Also note that in order for my custom `.xsl` files to work, they need to know where the standard PreTeXt XSL stylesheets are.  If you clone `mathbook.git` and `discrete-book.git` as shown below, you will be all set, otherwise, you will need to go into the XSL files and change some things at the top.

Open up a terminal and in your preferred directory, clone the `mathbook` and `discrete-book` repositories:

`git clone https://github.com/rbeezer/mathbook.git`

`git clone https://github.com/oscarlevin/discrete-book.git`

Then change to the `discrete-book` folder:

`cd discrete-book`

### Compiling

If everything has been set up properly above, you can now execute the following commands to build the book.  First, no matter what output format you are looking for, you will need to enter the following.

`make ww-extraction`

`make ww-merge`

Then, to create a LaTeX file and PDF, you can enter:

`make latex`

`make pdf`

To make the HTML version, you first need to extract images from the source:

`make diagrams`

And then create the HTML files:

`make html`

If you look in the `Makefile`, you will see some shortcuts that combine some of these.


## Contributing

Any and all suggestions to improve the text are welcome.  Thanks to those who have already pointed out typos/issues they have found.  If you would like to make a more substantial contribution, please contact me so we can discuss how best to proceed.

## Previous editions

The previous editions have branches, and also tags.  Feel free to switch to those if you want to grab the source for those editions.
