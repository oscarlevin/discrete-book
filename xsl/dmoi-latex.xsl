<?xml version="1.0" encoding="UTF-8"?>


<!-- This file is part of the book                 -->
<!--                                               -->
<!--   Discrete Mathematics: an Open Introduction  -->
<!--                                               -->
<!-- Copyright (C) 2015-2018 Oscar Levin           -->
<!-- See the file COPYING for copying conditions.  -->

<!-- Parts of this file were adapted from the author guide at https://github.com/rbeezer/mathbook and the analagous file at https://github.com/twjudson/aata -->
<!-- Conveniences for classes of similar elements -->
<!DOCTYPE xsl:stylesheet [
    <!ENTITY % entities SYSTEM "entities.ent">
    %entities;
]>

<!-- DMOI customizations for LaTeX runs -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<!-- assumes this has been copied to mathbook/user -->
<xsl:import href="./core/pretext-latex.xsl" />

<xsl:import href="pretext-latex-dmoi.xsl" />
<!-- Assumes next file can be found in mathbook/user -->
<xsl:import href="dmoi-common.xsl" />


<xsl:param name="debug.exercises.forward" select="'no'"/>

<!-- Hack 2024-08-21 to improve layout of matching exercises -->
<xsl:template match="exercise/matches/match" mode="matching-statement">
    <xsl:variable name="premise-number" select="count(preceding-sibling::match) + 1"/>
    <xsl:variable name="all-matches" select="parent::matches/match"/>    
    <row>
        <xsl:if test="following-sibling::match">
            <xsl:attribute name="bottom">
                <xsl:text>minor</xsl:text>
            </xsl:attribute>
        </xsl:if>
        <cell>
            <xsl:copy-of select="premise/node()"/>
        </cell>
        <cell bottom="none"><nbsp/><nbsp/></cell>
        <cell>
            <xsl:copy-of select="$all-matches[@order = $premise-number]/response/node()"/>
        </cell>
    </row>
</xsl:template>
      

<!-- Old version of "geometry" -->
<!-- Geometry: page shape, margins, etc            -->
<!-- Pass a string with any of geometry's options  -->
<!-- Default is empty and thus ineffective         -->
<!-- Otherwise, happens early in preamble template -->
<!-- <xsl:param name="latex.geometry" select="'papersize={7in,10in}, width=4.85in, inner=1in, height=8.5in, top=0.75in, twoside, ignoreheadfoot'"/> -->
<!-- papersize={7in,10in},  width=5in, inner=.75in, height=8.25in, top=0.75in, twoside, ignoreheadfoot, hmargin={0.85in, 0.5in}, -->


<!-- Add newpage -->
<xsl:template match="clearpage">
    <xsl:text>\clearpage&#xa;</xsl:text>
</xsl:template>


<!-- Include a style file at the end of the preamble: -->

<xsl:param name="latex.preamble.late">
  <xsl:text>%This should load all the style information that ptx does not.&#xa;</xsl:text>
    <xsl:text>\input{external/latex-preamble-styles}&#xa;</xsl:text>
</xsl:param>


<xsl:param name="latex.preabmle.early">

</xsl:param>


<!-- Override default frontmatter pages: -->

<!-- Remove "half-title" leading page with -->
<!-- title only, at about 1:2 split    -->
<xsl:template match="book" mode="half-title" >
    <xsl:text>%% no half-title&#xa;</xsl:text>
</xsl:template>

<!-- Remove Ad card (may contain list of other books        -->
<!-- Or may be overridden to make title page spread -->
<!-- Obverse of half-title                          -->
<xsl:template match="book" mode="ad-card">
    <xsl:text>%% No adcard&#xa;</xsl:text>
</xsl:template>


<!-- Import custom title page -->
<xsl:template match="book" mode="title-page">
    <xsl:text>%% begin: title page&#xa;</xsl:text>
    <xsl:text>%% my custom page.&#xa;</xsl:text>
    <xsl:text>\input{external/frontmatter/title-page}&#xa;</xsl:text>
    <xsl:text>%% end: title page&#xa;</xsl:text>
</xsl:template>

<!-- Import custom copyright page -->
<xsl:template match="book" mode="copyright-page" >
    <xsl:text>%% begin: copyright-page&#xa;</xsl:text>
    <xsl:text>\input{external/frontmatter/copyright-page}&#xa;</xsl:text>
    <xsl:text>%% end:   copyright-page&#xa;</xsl:text>
</xsl:template>

<!-- Dedication style -->
<xsl:template match="dedication/p|dedication/p[1]" priority="1">
    <xsl:text>\begin{flushright}\large%&#xa;</xsl:text>
        <xsl:apply-templates />
    <xsl:text>%&#xa;</xsl:text>
    <xsl:text>\end{flushright}&#xa;</xsl:text>
</xsl:template>






<!-- Restyle paragraphs: -->
<!-- "paragraphs" -->
<!-- Body:  \begin{paragraphs}{title}{label}   -->
<!-- "titlesec" package, Subsection 9.2 has LaTeX defaults -->
<!-- We drop the indentation, and we pass the title itself -->
<!-- explicity with macro parameter #1 since we do not save-->
<!-- off the title in a PTX macro.  None of this is meant  -->
<!-- to support customization in a style.                  -->
<!-- Once a tcolorbox, see warnings as part of divisional  -->
<!-- introductions and conclusions.                        -->


<!-- <xsl:template match="paragraphs" mode="environment">
    <xsl:text>%% paragraphs: the terminal, pseudo-division&#xa;</xsl:text>
    <xsl:text>%% We use the lowest LaTeX traditional division&#xa;</xsl:text>
    <xsl:text>\titleformat{\subparagraph}[block]{\normalfont\filcenter\scshape\bfseries}{\thesubparagraph}{0em}{#1}&#xa;</xsl:text>
    <xsl:text>\titlespacing*{\subparagraph}{0pt}{3.25ex plus 1ex minus .2ex}{1ex}&#xa;</xsl:text>
    <xsl:text>\NewDocumentEnvironment{paragraphs}{mm}&#xa;</xsl:text>
    <xsl:text>{\subparagraph*{#1}\hypertarget{#2}{}}{}&#xa;</xsl:text>
</xsl:template> -->


<!-- Paragraphs -->
<!-- Non-structural, even if they appear to be -->
<!-- <xsl:template match="paragraphs"> -->
    <!-- Warn about paragraph deprecation -->
    <!-- <xsl:text>\begin{paragraphs}</xsl:text> -->
    <!-- <xsl:text>{</xsl:text> -->
    <!-- Get rid of punctuation: (change title-punctuated to title-full) -->
    <!-- <xsl:apply-templates select="." mode="title-full" /> -->
    <!-- <xsl:text>}</xsl:text> -->
    <!-- <xsl:text>{</xsl:text> -->
    <!-- <xsl:apply-templates select="." mode="latex-id" /> -->
    <!-- <xsl:text>}</xsl:text> -->
    <!-- <xsl:text>%&#xa;</xsl:text> -->
    <!-- <xsl:apply-templates/> -->
    <!-- <xsl:text>\end{paragraphs}%&#xa;</xsl:text> -->
<!-- </xsl:template> -->


<!-- "proof" -->
<!-- Body:  \begin{proof}{title}{label}    -->
<!-- Title comes with punctuation, always. -->
<!-- <xsl:template match="proof" mode="environment">
    <xsl:text>%% proof: title is a replacement&#xa;</xsl:text>
    <xsl:text>\tcbset{ proofstyle/.style={</xsl:text>
    <xsl:apply-templates select="." mode="tcb-style" />
    <xsl:text>} }&#xa;</xsl:text>
    <xsl:text>\newtcolorbox{proofptx}[2]{title={\notblank{#1}{#1}{</xsl:text>
    <xsl:apply-templates select="." mode="type-name"/>
    <xsl:text>.}}, phantom={\hypertarget{#2}{}}, breakable, parbox=false, proofstyle }&#xa;</xsl:text>
</xsl:template> -->

<!-- Actually, redefine proofs to use the amsthm env for now -->
<!-- Proofs -->
<!-- Subsidary to THEOREM-LIKE, or standalone        -->
<!-- Defaults to "Proof", can be replaced by "title" -->
<!-- TODO: rename as "proof" once  amsthm  package goes away -->
<!-- <xsl:template match="proof">
    <xsl:text>\begin{proof}</xsl:text>
    <xsl:text>{</xsl:text>
    <xsl:if test="title">
        <xsl:apply-templates select="." mode="title-full"/>
    </xsl:if>
    <xsl:text>}</xsl:text>
    <xsl:text>&#xa;</xsl:text>
    <xsl:apply-templates select="*" />
    <xsl:text>\end{proof}&#xa;</xsl:text>
</xsl:template> -->

<!--HACK: 3-23-19 redefine the qed symbol to be qed  -->
<!-- "proof" -->
<!-- Title in italics, as in amsthm style.           -->
<!-- Filled, black square as QED, tombstone, Halmos. -->
<!-- Pushing the tombstone flush-right is a bit      -->
<!-- ham-handed, but more elegant TeX-isms           -->
<!-- (eg \hfill) did not get it done.  We require at -->
<!-- least two spaces gap to remain on the same      -->
<!-- line. Presumably the line will stretch when the -->
<!-- tombstone moves onto its own line.              -->
<!-- <xsl:template match="proof" mode="tcb-style">
    <xsl:text>bwminimalstyle, fonttitle=\normalfont\itshape, attach title to upper, after title={\space}, after upper={\space\space\hspace*{\stretch{1}}\(\textsc{qed}\)}&#xa;</xsl:text>
</xsl:template> -->




</xsl:stylesheet>
