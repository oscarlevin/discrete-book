<?xml version='1.0'?>

<!--********************************************************************
Copyright 2019 Oscar Levin

This file is part of PreTeXt.

PreTeXt is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 2 or version 3 of the
License (at your option).

PreTeXt is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with PreTeXt.  If not, see <http://www.gnu.org/licenses/>.
*********************************************************************-->

<!-- Conveniences for classes of similar elements -->
<!DOCTYPE xsl:stylesheet [
    <!ENTITY % entities SYSTEM "entities.ent">
    %entities;
]>

<!-- Identify as a stylesheet -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
    xmlns:xml="http://www.w3.org/XML/1998/namespace"
>

<!-- Override specific tenplates of the standard conversion -->
<!-- <xsl:import href="../mathbook-latex.xsl" /> -->

<!-- Intend output for rendering by pdflatex -->
<xsl:output method="text" />

<!-- %%%%%%%%%%%%% -->
<!-- Title Styles: -->
<!-- %%%%%%%%%%%%% -->

<xsl:template name="titlesec-chapter-style">
    <xsl:text>\titleformat{\chapter}[display]
    {\Huge}
    {\bfseries\thechapter} 
    {-12pt}
    {\hbox to\textwidth{\rlap{\rule[-3.5pt]{84pt}{4pt}}\rule{\textwidth}{.5pt}}
     \vspace{0ex}\slshape #1}
    [\vspace{-1ex}\noindent\hbox{\vrule height.5pt width84pt}]
    \titlespacing*{\chapter}{0pt}{-2em}{5em}&#xa;</xsl:text>
    <xsl:text>\titleformat{name=\chapter,numberless}[display]
      {\huge}
      {} 
      {-12pt}
      {\hbox to\textwidth{\rlap{\rule[-3.5pt]{84pt}{4pt}}\rule{\textwidth}{.0pt}}\vspace{0ex}\slshape #1}
      [\vspace{-1ex}\noindent\hbox{\vrule height.5pt width84pt}]
      \titlespacing*{\chapter}{0pt}{-2em}{2em}&#xa;</xsl:text>
    <xsl:text>\titlespacing*{\chapter}{0pt}{-2em}{2em}&#xa;</xsl:text>
    <xsl:text>\titleformat{\subparagraph}[block]
      {\normalfont\filcenter\scshape\bfseries}
      {\theparagraph}
      {1em}
      {#1}
      [\normalsize\authorsptx]&#xa;</xsl:text>
</xsl:template>

<xsl:template name="titlesec-section-style">
    <xsl:text>\titleformat{\section}[display]
    {\Large\bfseries}
    {}
    {-2em}
    {\hbox to\textwidth{\rlap{\rule[-3.5pt]{84pt}{4pt}}\rule{\textwidth}{.5pt}}
    \vspace{1ex}\thesection~ #1}
    [\large\authorsptx]&#xa;</xsl:text>
    <xsl:text>\titleformat{name=\section,numberless}
    {\filcenter\scshape\bfseries}
    {}
    {0.0em}
    {#1}&#xa;</xsl:text>
</xsl:template>

<xsl:template name="titlesec-subsection-style">
    <xsl:text>\titleformat{\subsection}
    {\large\bfseries}
    {\thesubsection}
    {1em}
    {#1}
    [\normalsize\authorsptx]&#xa;</xsl:text>
</xsl:template>

<xsl:template name="titlesec-subsubsection-style">
    <xsl:text>\titleformat{\subsubsection}
      {\large\bfseries}
      {\thesubsubsection}
      {1em}
      {#1}
      [\normalsize\authorsptx]&#xa;</xsl:text>
</xsl:template>

<!-- %%%%%%%%%%%%%%%% -->
<!-- End Title Stiles -->
<!-- %%%%%%%%%%%%%%%% -->



<!-- %%%%%%%%%%%%%%%%%%%%%%%% -->
<!--  Header/Footer Stiles    -->
<!-- %%%%%%%%%%%%%%%%%%%%%%%% -->

<xsl:template match="book" mode="titleps-style">
    <xsl:text>%% Page style configuration&#xa;</xsl:text>
    <xsl:text>%%&#xa;</xsl:text>
    <xsl:text>%% Plain pages should have the same font for page numbers&#xa;</xsl:text>
    <xsl:text>\renewpagestyle{plain}{%&#xa;</xsl:text>
    <xsl:text>\setfoot[\pagefont\thepage][][]{}{}{\pagefont\thepage}%&#xa;</xsl:text>
    <xsl:text>}%&#xa;</xsl:text>
    <xsl:text>\renewpagestyle{headings}{\sethead[\pagefont\thepage][][\itshape\chaptertitle]{\itshape\sectiontitle}{}{\pagefont\thepage}}</xsl:text>
    <xsl:text>\pagestyle{headings}&#xa;</xsl:text>
</xsl:template>



<!-- %%%%%%%%%%%%%%%%%%%%%%%% -->
<!-- End Header/Footer Stiles -->
<!-- %%%%%%%%%%%%%%%%%%%%%%%% -->





<!-- %%%%%%%%%%%%%%%% -->
<!-- Block styles     -->
<!-- %%%%%%%%%%%%%%%% -->

<!-- A general strategy: put frame hidden, and then use borderline to get borders.  This prevents hairline borders at page breaks, and allows for selecting just some sides for the frame. -->


<!-- "commentary" -->
<!-- Green and ugly -->
<!-- <xsl:template match="commentary" mode="tcb-style">
    <xsl:text>enhanced, breakable, parbox=false, size=minimal, attach title to upper, after title={\space}, fonttitle=\bfseries, coltitle=black, colback=green</xsl:text>
</xsl:template> -->

<!-- "objectives", "outcomes" -->
<!-- Default tcb, identically -->
<!-- <xsl:template match="objectives|outcomes" mode="tcb-style">
  <xsl:text>
    enhanced,
    parbox=false,
    fonttitle=\bfseries\itshape\large,
    coltitle=black,
    attach boxed title to top left={xshift=5mm,yshift=-\tcboxedtitleheight/2-1mm,yshifttext=-2mm},
    boxed title style={frame hidden, colback=white, sharp corners},
    boxed title size=title,
    frame hidden,
    borderline horizontal={2pt}{0mm}{RoyalPurple!65!black},
    colback=white,
    width=0.98\linewidth,
    bottom=5mm,
    center,
    after skip=2em,
  </xsl:text>
</xsl:template> -->

<!-- "assemblage" -->
<!-- Boxed title, borrowed from the AIM style -->
<xsl:template match="assemblage" mode="tcb-style">
    <xsl:text>
      enhanced, 
      frame hidden,
      borderline={1pt}{1pt}{black},
      sharp corners, 
      colback=white, 
      coltitle=black, 
      halign title=center,
      fonttitle=\bfseries, 
      top=3mm,
      after skip=12pt,
      toptitle=6pt,
    </xsl:text>
</xsl:template>

<xsl:template match="&EXAMPLE-LIKE;" mode="tcb-style">
    <xsl:text>bwminimalstyle, runintitlestyle, blockspacingstyle, after title={\space\space}, before upper app={\setparstyle}, after upper={\space\space\hspace*{\stretch{1}}\(\square\)}, 
      before skip={1em},
      after skip={1.5em},
    </xsl:text>
</xsl:template>

<xsl:template match="&THEOREM-LIKE;|&REMARK-LIKE;|exercise[boolean(&INLINE-EXERCISE-FILTER;)]" mode="tcb-style">
    <xsl:text>
      bwminimalstyle, runintitlestyle, blockspacingstyle, after title={\space\space}, before upper app={\setparstyle},
      before skip={1em},
      after skip={1.5em},
    </xsl:text>
</xsl:template>

<xsl:template match="&DEFINITION-LIKE;" mode="tcb-style">
    <xsl:text>
      bwminimalstyle, runintitlestyle, blockspacingstyle, after title={\space\space}, before upper app={\setparstyle}, after upper={\space\space\hspace*{\stretch{1}}\(\lozenge\)},
      before skip={1em},
      after skip={1.5em},
      colback=black!20,
    </xsl:text>
</xsl:template>

<!-- <xsl:template match="proof" mode="tcb-style">
    <xsl:text>bwminimalstyle, fonttitle=\normalfont\bfseries, attach title to upper, after title={\qquad}&#xa;</xsl:text>
</xsl:template> -->

<!-- <xsl:template match="definition" mode="tcb-style">
    <xsl:text>
      enhanced, 
      frame hidden,
      borderline={1pt}{1pt}{PineGreen!40},
      sharp corners, 
      colback=PineGreen!5, 
      colbacktitle=PineGreen!40, 
      coltitle=black, 
      boxed title style={sharp corners, frame hidden},
      fonttitle=\bfseries, 
      attach boxed title to top left={xshift=4mm,yshift=-4mm,yshifttext=-2mm},
      top=3mm,
      after skip=1em,
    </xsl:text>
</xsl:template> -->






<!-- EXAMPLE-LIKE: "example", "question", "problem" -->
<!-- Default tcolorbox, but with tricolor titles    -->
<!-- Each just slightly different                   -->

<!-- Example styling from CLP -->
<!-- <xsl:template match="&EXAMPLE-LIKE;|exercise[boolean(&INLINE-EXERCISE-FILTER;)]" mode="tcb-style">
    <xsl:text>
      enhanced,
      breakable,
      parbox=false,
      frame hidden,
      borderline west={1pt}{0mm}{MidnightBlue},
      overlay unbroken and last={
        \draw[MidnightBlue, path fading=east, line width=.5pt] (frame.south west) &mdash;&mdash; (frame.south east);
      },
      colback=white,
      coltitle=white,
      fonttitle=\bfseries\sffamily,
      attach boxed title to top left={xshift=0mm},
      boxed title style={colback=MidnightBlue, sharp corners, colframe=MidnightBlue},
      boxed title size=title,
      after skip=1em,
      before skip=1em,
    </xsl:text>
</xsl:template> -->

<xsl:template match="&PROJECT-LIKE;" mode="tcb-style">
  <xsl:text>
    enhanced,
    breakable,
    parbox=false,
    frame hidden,
    fonttitle=\bfseries\itshape\large,
    halign title=center,
    title=Investigate!,
    borderline horizontal={3pt}{0mm}{black},
    colback=white,
    coltitle=black,
    colbacktitle=white,
    before skip={1em},
    after skip={2em},
    toptitle=2ex,
  </xsl:text>
</xsl:template>

<!-- <xsl:template match="&PROJECT-LIKE;" mode="tcb-style">
  <xsl:text>
    enhanced,
    breakable,
    parbox=false,
    frame hidden,
    fonttitle=\bfseries\itshape\large,
    coltitle=black,
    attach boxed title to top left={xshift=5mm,yshift=-\tcboxedtitleheight/2-1mm,yshifttext=-2mm},
    title=Investigate!,
    boxed title style={frame hidden, colback=white, sharp corners},
    boxed title size=title,
    borderline={2pt}{0mm}{teal!45!black},
    arc=4mm,
    colback=white,
    bottom=5mm,
    after skip=2em,
  </xsl:text>
</xsl:template> -->

<!-- The following are blocks not yet styled (thus commented) -->
<!-- but could be some day                                    -->

<!-- <xsl:template match="&THEOREM-LIKE;" mode="tcb-style">
  <xsl:text/>
</xsl:template> -->


<!-- <xsl:template match="proof" mode="tcb-style">
  <xsl:text>breakable, parbox=false, borderline west={.5pt}{0mm}{red}</xsl:text>
</xsl:template> -->

<!-- DEFINITION-LIKE: "definition"   -->
<!-- Various extreme choices from the tcolorbox documentation -->
<!-- Note: a trailing comma is OK, and maybe a good idea      -->
<!-- Note: the style definition may split across several line -->
<!-- of the LaTeX source using the hex A (dec 10) character   -->
<!-- Note: "enhanced" is necessary for boxed titles           -->
<!-- <xsl:template match="&DEFINITION-LIKE;" mode="tcb-style">
  <xsl:text>breakable, parbox=false, colframe=MidnightBlue, colback=MidnightBlue!5, colbacktitle=MidnightBlue!70, coltitle=black, enhanced, attach boxed title to top left={xshift=7mm, yshift*=-2ex},sharp corners=northwest, arc=10pt,</xsl:text>
</xsl:template> -->

<!-- REMARK-LIKE: "remark", "convention", "note",   -->
<!--            "observation", "warning", "insight" -->
<!-- COMPUTATION-LIKE: "computation", "technology"  -->
 <!--White title text, but title backgounds vary    -->
 <!--by category, and remarks have sharp corners    -->
<!-- <xsl:template match="&REMARK-LIKE;" mode="tcb-style">
  <xsl:text>
    enhanced, 
    frame hidden,
    borderline={3pt}{0mm}{Thistle!20},
    borderline west={3pt}{0mm}{Thistle!75},
    sharp corners, 
    colback=Thistle!20, 
    colbacktitle=Thistle!20, 
    coltitle=black, 
    fonttitle=\bfseries, 
    top=1mm,
    titlerule=0pt,
  </xsl:text>
</xsl:template> -->



<!-- %%%%%%%%%%%%%%%% -->
<!-- End Block Stiles -->
<!-- %%%%%%%%%%%%%%%% -->


</xsl:stylesheet>
