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
    	{\Large\filcenter\scshape\bfseries}
    	{\rule[4pt]{.3\textwidth}{2pt} \hspace{2ex} \large\textsc{\chaptertitlename} \thechapter \hspace{3ex} \rule[4pt]{0.3\textwidth}{2pt} }
    	{0.0em}
    	{\titlerule\vspace{1ex}\huge\textsc #1}
    	[\vspace{.75ex}\titlerule]
    \titlespacing*{\chapter}{0pt}{-2em}{2em}&#xa;</xsl:text>
    <!-- <xsl:text>\titleformat{name=\chapter,numberless}
      {\Large\filcenter\scshape\bfseries}
    	{\rule[4pt]{.3\textwidth}{2pt} \hspace{2ex} \large\textsc{\chaptertitlename} \thechapter \hspace{3ex} \rule[4pt]{0.3\textwidth}{2pt} }
    	{0.0em}
    	{\titlerule\vspace{1ex}\huge\textsc #1}
    	[\vspace{.75ex}\titlerule]
    \titlespacing*{\chapter}{0pt}{-2em}{2em}&#xa;</xsl:text> -->
    <xsl:text>\titleformat{\subparagraph}[block]
      {\normalfont\filcenter\scshape\bfseries}
      {\theparagraph}
      {1em}
      {#1}
      [\normalsize\authorsptx]&#xa;</xsl:text>
</xsl:template>

<xsl:template name="titlesec-section-style">
    <xsl:text>\titleformat{\section}
    {\Large\filcenter\scshape\bfseries}
    {\thesection}
    {1em}
    {#1}
    [\large\authorsptx]&#xa;</xsl:text>
    <xsl:text>\titleformat{name=\section,numberless}
    {\filcenter\scshape\bfseries}
    {}
    {0.0em}
    {#1}&#xa;</xsl:text>
</xsl:template>

<xsl:template name="titlesec-subsection-style">
    <xsl:text>\titleformat{\subsection}
    {\large\filcenter\scshape\bfseries}
    {\thesubsection}
    {1em}
    {#1}
    [\normalsize\authorsptx]&#xa;</xsl:text>
</xsl:template>

<xsl:template name="titlesec-subsubsection-style">
    <xsl:text>\titleformat{\subsubsection}
      {\filcenter\scshape\bfseries}
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

<!-- LaTeX uses four page styles, and we use the "titleps" package  -->
<!-- to redefine the "empty", "plain", and "headings" styles.  The  -->
<!-- actual management of which style is used, and when, is         -->
<!-- controlled by LaTeX with help from PreTeXt.  You can use the   -->
<!-- "titleps-global-style" template to change which style is the   -->
<!-- global default, optionally in concert with redefinitions of    -->
<!-- the style.                                                     -->
<!--                                                                -->
<!-- We do limited demonstration with the head, and use the         -->
<!-- left-side of the foot to display information on which          -->
<!-- pagestyle is in effect, so you could experiment here before    -->
<!-- making your own style.                                         -->
<!--                                                                -->
<!-- Note: the templates will be placed after a "\renewpagestyle{}" -->
<!-- command, so should be an optional argument, followed by a      -->
<!-- mandatory argument with commands like \setfoot, \sethead,      -->
<!-- \headrule, and \footrule.                                      -->
<!-- See titleps.pdf in the "titlesec" package for more             -->
<xsl:template match="book|article|letter|memo" mode="titleps-empty">
</xsl:template>

<xsl:template match="book|article|letter|memo" mode="titleps-plain">
    <xsl:text>{
    \setfoot[][\thepage][]
    {}{\thepage}{}
    }</xsl:text>
</xsl:template>


<!-- general headings -->
<xsl:template match="book" mode="titleps-headings">
    <xsl:text>{
    \sethead[{\footnotesize \textbf{\thepage}}~~~ \textsc{\scriptsize{\ifthechapter{\thechapter.~}{}\chaptertitle}}][][]
    {}{}{\textsc{\scriptsize{\ifthesection{\thesection.~\sectiontitle}{\chaptertitle}}} ~~~ {\footnotesize \textbf{\thepage}} }
    \setfoot[][][]
    {}{}{}
    }</xsl:text>
</xsl:template>

<xsl:template match="article|letter|memo" mode="titleps-headings">
    <xsl:text>[\small\sffamily]{
    \sethead[\thepage][\sectiontitle][]
    {}{\sectiontitle}{\thepage}
    \setfoot[foot/even/headings/article][][]
    {foot/odd or one-sided/headings/article}{}{}
    }</xsl:text>
</xsl:template>

<!-- Experiment with "empty", "plain", and "headings" to      -->
<!-- see the effect of the above definitions (for "article")  -->
<!-- employed in the sample article                           -->
<!-- DO NOT set this to return empty text, errors will result -->
<!-- You can comment it out, and let base definition execute  -->
<xsl:template match="article" mode="titleps-global-style">
    <xsl:text>plain</xsl:text>
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
<xsl:template match="commentary" mode="tcb-style">
    <xsl:text>enhanced, breakable, parbox=false, size=minimal, attach title to upper, after title={\space}, fonttitle=\bfseries, coltitle=black, colback=green</xsl:text>
</xsl:template>

<!-- "objectives", "outcomes" -->
<!-- Default tcb, identically -->
<xsl:template match="objectives|outcomes" mode="tcb-style">
    <xsl:text/>
</xsl:template>

<!-- "assemblage" -->
<!-- Boxed title, borrowed from the AIM style -->
<xsl:template match="assemblage" mode="tcb-style">
    <xsl:text>enhanced, boxrule=0.5pt, sharp corners, colback=MidnightBlue!5, colframe=MidnightBlue!20,&#xa;</xsl:text>
    <xsl:text>colbacktitle=MidnightBlue!25, coltitle=black, boxed title style={sharp corners, frame hidden},&#xa;</xsl:text>
    <xsl:text>fonttitle=\bfseries, attach boxed title to top left={xshift=4mm,yshift=-4mm,yshifttext=-2mm}, top=3mm,&#xa;</xsl:text>
</xsl:template>






<!-- EXAMPLE-LIKE: "example", "question", "problem" -->
<!-- Default tcolorbox, but with tricolor titles    -->
<!-- Each just slightly different                   -->

<!-- Example styling from CLP -->
<xsl:template match="&EXAMPLE-LIKE;" mode="tcb-style">
    <xsl:text>
      enhanced,
      breakable,
      parbox=false,
      frame hidden,
      borderline west={1pt}{0mm}{MidnightBlue},
      overlay unbroken and last={
        \draw[MidnightBlue, path fading=east, line width=.5pt] (frame.south west) -- (frame.south east);
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
</xsl:template>

<xsl:template match="&PROJECT-LIKE;" mode="tcb-style">
  <xsl:text>
    enhanced,
    parbox=false,
    fonttitle=\bfseries\itshape\large,
    coltitle=black,
    attach boxed title to top left={xshift=5mm,yshift=-\tcboxedtitleheight/2-1mm,yshifttext=-2mm},
    title=Investigate!,
    boxed title style={frame hidden, colback=white, sharp corners},
    boxed title size=title,
    frame hidden,
    borderline={1pt}{0mm}{green!50!black},
    arc=4mm,
    colback=white,
    width=0.98\linewidth,
    bottom=5mm,
    overlay unbroken and last={
      \draw[color=white, line width=3pt] ([xshift=.05\textwidth]frame.south west) -- ([xshift=-.05\textwidth]frame.south east);
      \draw ([xshift=.1\textwidth]frame.south west) node{\LARGE \color{red} \Stopsign};
      \draw (frame.south) node{\textbf{Attempt the above activity before proceeding}};
      \draw ([xshift=-.1\textwidth]frame.south east) node{\LARGE \color{red} \Stopsign};
    },
    center,
    after skip=2em,
  </xsl:text>
</xsl:template>

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
    <xsl:text/>
</xsl:template> -->



<!-- %%%%%%%%%%%%%%%% -->
<!-- End Block Stiles -->
<!-- %%%%%%%%%%%%%%%% -->


</xsl:stylesheet>
