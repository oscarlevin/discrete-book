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

<!-- "objectives", "outcomes" -->
<!-- Default tcb, identically -->
<xsl:template match="objectives|outcomes" mode="tcb-style">
  <xsl:text>
    enhanced,
    parbox=false,
    fonttitle=\bfseries\itshape\large,
    coltitle=black,
    attach boxed title to top left={xshift=5mm,yshift=-\tcboxedtitleheight/2-1mm,yshifttext=-2mm},
    boxed title style={frame hidden, colback=white, sharp corners},
    boxed title size=title,
    frame hidden,
    borderline horizontal={2pt}{0mm}{black},
    colback=white,
    bottom=5mm,
    after skip=2em,
  </xsl:text>
</xsl:template>

<!-- "assemblage" -->
<!-- Boxed title, borrowed from the AIM style -->
<xsl:template match="assemblage" mode="tcb-style">
    <xsl:text>
      enhanced, 
      frame hidden,
      borderline={2pt}{0pt}{black!25},
      sharp corners, 
      colback=black!10, 
      colbacktitle=black!25, 
      coltitle=black, 
      boxed title style={sharp corners, frame hidden},
      fonttitle=\bfseries, 
      attach boxed title to top left={xshift=4mm,yshift=-4mm,yshifttext=-2mm},
      top=3mm,
      after skip=1em,
    </xsl:text>
</xsl:template>

<xsl:template match="&THEOREM-LIKE;|&AXIOM-LIKE;" mode="tcb-style">
    <xsl:text>
      enhanced, 
      frame hidden,
      parbox=false,
      borderline={2pt}{0mm}{black!20},
      sharp corners, 
      colback=black!10, 
      colbacktitle=black!20, 
      coltitle=black, 
      boxed title style={sharp corners, frame hidden},
      fonttitle=\bfseries, 
      attach boxed title to top left={xshift=4mm,yshift=-4mm,yshifttext=-2mm},
      top=3mm,
      after skip=1em,
    </xsl:text>
</xsl:template>

<xsl:template match="proof" mode="tcb-style">
    <xsl:text>bwminimalstyle, parbox=false, fonttitle=\normalfont\bfseries, attach title to upper, after title={\space\space}, center, width=.90\linewidth&#xa;</xsl:text>
</xsl:template>

<xsl:template match="definition" mode="tcb-style">
    <xsl:text>
      enhanced, 
      frame hidden,
      parbox=false,
      borderline={2pt}{0pt}{black!15},
      sharp corners, 
      colback=black!7, 
      colbacktitle=black!15, 
      coltitle=black, 
      boxed title style={sharp corners, frame hidden},
      fonttitle=\bfseries, 
      attach boxed title to top left={xshift=4mm,yshift=-4mm,yshifttext=-2mm},
      top=3mm,
      after skip=1em,
    </xsl:text>
</xsl:template>


<!-- EXAMPLE-LIKE: "example", "question", "problem" -->

<xsl:template match="&EXAMPLE-LIKE;|exercise[boolean(&INLINE-EXERCISE-FILTER;)]" mode="tcb-style">
    <xsl:text>
      enhanced,
      breakable,
      parbox=false,
      frame hidden,
      borderline west={1.5pt}{0mm}{black!90},
      overlay unbroken and last={
        \draw[black, path fading=east, line width=1pt] (frame.south west) -- (frame.south east);
      },
      colback=white,
      coltitle=white,
      fonttitle=\bfseries\sffamily,
      attach boxed title to top left={xshift=0mm},
      boxed title style={colback=black!90, sharp corners, colframe=black!90},
      boxed title size=title,
      after skip=1em,
      before skip=1em,
    </xsl:text>
</xsl:template>

<xsl:template match="&PROJECT-LIKE;" mode="tcb-style">
  <xsl:text>
    enhanced,
    parbox=false,
    sharp corners,
    fonttitle=\bfseries\itshape\large,
    coltitle=black,
    attach boxed title to top left={xshift=5mm,yshift=-\tcboxedtitleheight/2-1mm,yshifttext=-2mm},
    title=Investigate!,
    boxed title style={frame hidden, colback=white, sharp corners},
    boxed title size=title,
    frame hidden,
    borderline={2pt}{0mm}{black!35},
    colback=white,
    bottom=5mm,
    after skip=2em,
  </xsl:text>
</xsl:template>

<!-- REMARK-LIKE: "remark", "convention", "note",   -->
<!--            "observation", "warning", "insight" -->

<xsl:template match="&REMARK-LIKE;" mode="tcb-style">
  <xsl:text>
    runintitlestyle,
    enhanced, 
    parbox=false,
    frame hidden,
    borderline={3pt}{0mm}{black!10},
    borderline west={3pt}{0mm}{black!30},
    sharp corners, 
    colback=black!10, 
    coltitle=black, 
    top=2mm,
    after title={\space\space},
  </xsl:text>
</xsl:template>



<!-- %%%%%%%%%%%%%%%% -->
<!-- End Block Stiles -->
<!-- %%%%%%%%%%%%%%%% -->


</xsl:stylesheet>
