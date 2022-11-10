<?xml version="1.0" encoding="UTF-8"?>


<!-- This file is part of the book                 -->
<!--                                               -->
<!--   Discrete Mathematics: an Open Introduction  -->
<!--                                               -->
<!-- Copyright (C) 2015-2018 Oscar Levin           -->
<!-- See the file COPYING for copying conditions.  -->

<!-- Parts of this file were adapted from the author guide at https://github.com/rbeezer/mathbook and the analagous file at https://github.com/twjudson/aata -->


<!-- DMOI customizations for LaTeX runs specifically for createspace -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<!-- Assumes current file is in discrete-text/xsl and that the mathbook repository is adjacent -->
<!-- <xsl:import href="../../mathbook/xsl/mathbook-latex.xsl" /> -->
<!-- Assumes next file can be found in discrete-text/xsl -->
<xsl:import href="custom-latex.xsl" />





<!-- Parameters to pass via xsltproc "stringparam" on command-line            -->
<!-- Or make a thin customization layer and use 'select' to provide overrides -->
<!--  -->
<!-- LaTeX executable, "engine"                       -->
<!-- pdflatex is default, xelatex or lualatex for Unicode support -->
<!-- N.B. This has no effect, and may never.  xelatex and lualatex support is automatic -->
<xsl:param name="latex.engine" select="'pdflatex'" />
<!--  -->
<!-- Standard fontsizes: 10pt, 11pt, or 12pt       -->
<!-- extsizes package: 8pt, 9pt, 14pt, 17pt, 20pt  -->
<!-- memoir class offers more, but maybe other changes? -->
<xsl:param name="latex.font.size" select="'10pt'" />
<!--  -->
<!-- Geometry: page shape, margins, etc            -->
<!-- Pass a string with any of geometry's options  -->
<!-- Default is empty and thus ineffective         -->
<!-- Otherwise, happens early in preamble template -->
<xsl:param name="latex.geometry" select="'papersize={6in,9in}, hmargin={0.675in, 0.675in}, height=7.75in, top=0.75in, twoside=false, ignoreheadfoot'"/>
<!--  -->
<!-- PDF Watermarking                    -->
<!-- Non-empty string makes it happen    -->
<!-- Scale works well for "CONFIDENTIAL" -->
<!-- or  for "DRAFT YYYY/MM/DD"          -->
<xsl:param name="latex.watermark" select="''"/>
<xsl:param name="latex.watermark.scale" select="2.0"/>
<!--  -->
<!-- Author's Tools                                            -->
<!-- Set the author-tools parameter to 'yes'                   -->
<!-- (Documented in mathbook-common.xsl)                       -->
<!-- Installs some LaTeX-specific behavior                     -->
<!-- (1) Index entries in margin of the page                   -->
<!--      where defined, on single pass (no real index)        -->
<!-- (2) LaTeX labels near definition and use                  -->
<!--     N.B. Some are author-defined; others are internal,    -->
<!--     and CANNOT be used as xml:id's (will raise a warning) -->
<!--  -->
<!-- Draft Copies                                              -->
<!-- Various options for working copies for authors            -->
<!-- (1) LaTeX's draft mode                                    -->
<!-- (2) Crop marks on letter paper, centered                  -->
<!--     presuming geometry sets smaller page size             -->
<!--     with paperheight, paperwidth                          -->
<xsl:param name="latex.draft" select="'no'"/>
<!--  -->
<!-- Print Option                                         -->
<!-- For a non-electronic copy, inactive links in black   -->
<!-- Any color options go to black and white, as possible -->
<xsl:param name="latex.print" select="'no'"/>
<!--  -->
<!-- Preamble insertions                    -->
<!-- Insert packages, options into preamble -->
<!-- early or late                          -->
<xsl:param name="latex.preamble.early" select="''" />
<!-- <xsl:param name="latex.preamble.late" select="''" /> -->
<!--  -->
<!-- Console characters allow customization of how    -->
<!-- LaTeX macros are recognized in the fancyvrb      -->
<!-- package's Verbatim clone environment, "console"  -->
<!-- The defaults are traditional LaTeX, we let any   -->
<!-- other specification make a document-wide default -->
<xsl:param name="latex.console.macro-char" select="'\'" />
<xsl:param name="latex.console.begin-char" select="'{'" />
<xsl:param name="latex.console.end-char" select="'}'" />

<!-- We have to identify snippets of LaTeX from the server,   -->
<!-- which we have stored in a directory, because XSLT 1.0    -->
<!-- is unable/unwilling to figure out where the source file  -->
<!-- lives (paths are relative to the stylesheet).  When this -->
<!-- is needed a fatal message will warn if it is not set.    -->
<!-- Path ends with a slash, anticipating appended filename   -->
<!-- This could be overridden in a compatibility layer        -->
<!-- <xsl:param name="webwork.server.latex" select="''" /> -->






<!-- List Chapters and Sections in Table of Contents -->
<xsl:param name="toc.level" select="'3'" />


<!-- Exercises have "solution"s which should be put in the back. -->
<!-- Not sure what to do for homework solutions -->
<xsl:param name="exercise.text.statement" select="'yes'" />
<xsl:param name="exercise.text.hint" select="'yes'" />
<xsl:param name="exercise.text.answer" select="'no'" />
<xsl:param name="exercise.text.solution" select="'no'" />
<xsl:param name="exercise.backmatter.statement" select="'no'" />
<xsl:param name="exercise.backmatter.hint" select="'no'" />
<xsl:param name="exercise.backmatter.answer" select="'yes'" />
<xsl:param name="exercise.backmatter.solution" select="'yes'" />



<!-- Include a style file at the end of the preamble: -->

<xsl:param name="latex.preamble.late">
  <xsl:text>%This should load all the style information that mbx does not.&#xa;</xsl:text>
    <xsl:text>\input{latex-preamble-styles}&#xa;</xsl:text>
</xsl:param>



<!-- we co-op the "half-title" to create a colorful cover for tablet edtion -->

<xsl:template match="book" mode="half-title" >
    <xsl:text>%% front cover&#xa;</xsl:text>
    <xsl:text>\includepdf[pages=-,pagecommand={\thispagestyle{empty}}]{../cover/front.pdf}&#xa;</xsl:text>

</xsl:template>



<!-- Get exercise/solution links working -->

<!-- An exercise in an "exercises" subdivision             -->
<!-- is a list item in a description list                  -->
<!-- TODO: parameterize as a backmatter item, new switches -->
<!-- TODO: would an "exercisegrouplist" allow parameters to move to preamble? -->
<xsl:template match="exercises/exercise|exercisegroup/exercise">
    <!-- Start a list right before first exercise of subdivision, or of exercise group -->
    <xsl:choose>
        <xsl:when test="not(preceding-sibling::exercise) and parent::exercisegroup">
            <xsl:text>\begin{exercisegroup}&#xa;</xsl:text>
        </xsl:when>
        <xsl:when test="not(preceding-sibling::exercise) and parent::exercises">
            <xsl:text>\begin{exerciselist}&#xa;</xsl:text>
        </xsl:when>
    </xsl:choose>
    <!-- set up hyperlinks/targets here: -->
    <xsl:choose>
      <!-- set up hyperlinks when there is a solution or answer in the back. -->
      <!-- TODO: make this contingent on the switches as well -->
      <xsl:when test="answer or solution">
        <xsl:text>\item[\hyperlink{a-</xsl:text>
        <xsl:apply-templates select="." mode="number" />
        <xsl:text>}{</xsl:text>
        <xsl:apply-templates select="." mode="serial-number" />
        <xsl:text>}.]\hypertarget{q-</xsl:text>
        <xsl:apply-templates select="." mode="number" />
        <xsl:text>}{}</xsl:text>
      </xsl:when>
      <!-- otherwise set up number without links -->
      <xsl:otherwise>
        <xsl:text>\item[</xsl:text>
        <xsl:apply-templates select="." mode="serial-number" />
        <xsl:text>.]</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
    <!-- and continue as normal -->
    <xsl:apply-templates select="." mode="label"/>
    <xsl:if test="title">
        <xsl:text>(</xsl:text>
        <xsl:apply-templates select="." mode="title-full"/>
        <xsl:text>)\space\space{}</xsl:text>
    </xsl:if>
    <!-- condition on webwork wrapper or not -->
    <xsl:choose>
        <xsl:when test="webwork">
            <xsl:apply-templates select="introduction" />
            <xsl:apply-templates select="webwork" />
            <xsl:apply-templates select="conclusion" />
        </xsl:when>
        <xsl:otherwise>
        <!-- Order enforced: statement, hint, answer, solution -->
            <xsl:if test="$exercise.text.statement='yes'">
                <xsl:apply-templates select="statement" />
                <xsl:text>\par\smallskip&#xa;</xsl:text>
            </xsl:if>
            <xsl:if test="hint and $exercise.text.hint='yes'">
                <xsl:apply-templates select="hint" />
            </xsl:if>
            <xsl:if test="answer and $exercise.text.answer='yes'">
                <xsl:apply-templates select="answer" />
            </xsl:if>
            <xsl:if test="solution and $exercise.text.solution='yes'">
                <xsl:apply-templates select="solution" />
            </xsl:if>
        </xsl:otherwise>
    </xsl:choose>
    <!-- close list if no more exercise in subdivision or in exercise group -->
    <xsl:choose>
        <xsl:when test="not(following-sibling::exercise) and parent::exercisegroup">
            <xsl:text>\end{exercisegroup}&#xa;</xsl:text>
        </xsl:when>
        <xsl:when test="not(following-sibling::exercise) and parent::exercises">
            <xsl:text>\end{exerciselist}&#xa;</xsl:text>
        </xsl:when>
    </xsl:choose>
</xsl:template>





<!-- Create a heading for each non-empty collection of solutions -->
<!-- Format as appropriate LaTeX subdivision for this level      -->
<!-- But number according to the actual Exercises section        -->
<xsl:template match="exercises" mode="backmatter">
    <xsl:variable name="nonempty" select="(.//hint and $exercise.backmatter.hint='yes') or (.//answer and $exercise.backmatter.answer='yes') or (.//solution and $exercise.backmatter.solution='yes')" />
    <xsl:if test="$nonempty='true'">
        <xsl:text>\</xsl:text>
        <xsl:apply-templates select="." mode="subdivision-name" />
        <xsl:text>*{</xsl:text>
        <xsl:apply-templates select="." mode="number" />
        <xsl:text> </xsl:text>
        <xsl:apply-templates select="." mode="title-full" />
        <xsl:text>}&#xa;</xsl:text>
        <xsl:text>\markright{Solutions for Section &#xa;</xsl:text>
        <xsl:apply-templates select="." mode="number" />
        <xsl:text>}&#xa;</xsl:text>
        <xsl:apply-templates select="*" mode="backmatter" />
    </xsl:if>
</xsl:template>


<!-- Set up solution list -->
<!-- Print exercises with some solution component -->
<!-- Respect switches about visibility ("knowl" is assumed to be 'no') -->
<xsl:template match="exercise" mode="backmatter">
    <xsl:if test="answer or solution"> <!-- revmoed hint, those are not displayed here.  If I move hints to the back, I need to put it back here too -->
        <!-- Lead with the problem number and some space -->
        <!-- changed serial-number to number -->
        <xsl:text>\hypertarget{a-</xsl:text>
        <xsl:apply-templates select="." mode="number" />
        <xsl:text>}{}\noindent\textbf{\hyperlink{q-</xsl:text>
        <xsl:apply-templates select="." mode="number" />
        <xsl:text>}{</xsl:text>
        <xsl:apply-templates select="." mode="number" />
        <xsl:text>.}}&#xa;</xsl:text>
        <xsl:if test="$exercise.backmatter.statement='yes'">
            <!-- TODO: not a "backmatter" template - make one possibly? Or not necessary -->
            <xsl:apply-templates select="statement" />
            <xsl:text>\par\smallskip&#xa;</xsl:text>
        </xsl:if>
        <xsl:if test="hint and $exercise.backmatter.hint='yes'">
            <xsl:apply-templates select="hint" mode="backmatter" />
        </xsl:if>
        <xsl:if test="answer and $exercise.backmatter.answer='yes'">
            <xsl:apply-templates select="answer" mode="backmatter" />
        </xsl:if>
        <xsl:if test="solution and $exercise.backmatter.solution='yes'">
            <xsl:apply-templates select="solution" mode="backmatter" />
        </xsl:if>
    </xsl:if>
</xsl:template>



</xsl:stylesheet>
