Discrete Mathematics: an Open Introduction (Instructor Version)
=============

An open textbook for Discrete Mathematics, as taught at the University of Northern Colorado.  More information about the project is available on [the book's main website](http://discrete.openmathbooks.org).

## About the Instructor Version

This fork will eventually contain a complete solutions manual (provided to instructors only) as well as additional instructor resources.  It is also the branch I will use to develop the 3rd edition, as well as eventual variation versions I have planned.

The public 2nd (and 1st) edition is available [elsewhere](https://github.com/oscarlevin/discrete-book).


## Compilation Instructions

This text is written in [PreTeXt](http://mathbook.pugetsound.edu) (previously called MathBook XML), so the primary source files can be found in the `ptx` directory.  These can be compiled into html or LaTeX files (as well as some other formats).  If you do not want to bother with this step or just want to grab some LaTeX to use in a worksheet or the like, the generated LaTeX is already provided in the latex folder.

### MBX Compilation

To compile from source, you will need a copy of the mathbook xsl stylesheets, as well as xsltproc installed (should be easy on linux or MacOS, but also possible on Windows---see some [windows installation notes](http://mathbook.pugetsound.edu/doc/author-guide/html/windows-install-notes.html)).

Open up a terminal and in your preferred directory, clone the mathbook and discrete-book repositories:

`git clone https://github.com/rbeezer/mathbook.git`

`git clone https://github.com/oscarlevin/dmoi-instructor.git`

To generate LaTeX, change to the latex directory of the discrete-book folder:

`cd dmoi-instructor/latex`


and run


`xsltproc --xinclude ../xsl/custom-latex.xsl ../ptx/dmoi.ptx`

This will use the custom thin xsl stylesheet I have created with some customizations.  It calls the mathbook-latex.xsl file from mathbook using relative paths, so it is important that you leave the mathbook and discrete-book directories parallel.

To generate html, change to the html folder.  We first need to generate the svg images from the mbx code.  This is done using the `mbx` script from mathbook:

`../../mathbook/script/mbx -v -c latex-image -f svg -d images ../ptx/dmoi.ptx`

You will need to have python and some other tools installed.  See the mathbook documentation.  Then to produce the html, run:

`xsltproc --xinclude ../xsl/custom-html.xsl ../ptx/dmoi.ptx`

## Contributing

Any and all suggestions to improve the text are welcome.  Thanks to those who have already pointed out typos/issues they have found.  If you would like to make a more substantial contribution, please contact me so we can discuss how best to proceed.

## Fall 2015 corrected edition

If you are looking for the previous edition of this text, switch branches to the Fall2015-corrected branch, which contains source files for the corrected version of the Fall 2015 edition.  Use this in case you have that edition or want to continue using that edition.

## ToDo

Lots of stuff to do before releasing the third edition.  See the issues.
