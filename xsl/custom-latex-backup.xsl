<?xml version="1.0" encoding="UTF-8"?>


<!-- This file is part of the book                 -->
<!--                                               -->
<!--   Discrete Mathematics: an Open Introduction  -->
<!--                                               -->
<!-- Copyright (C) 2015-2018 Oscar Levin           -->
<!-- See the file COPYING for copying conditions.  -->

<!-- Parts of this file were adapted from the author guide at https://github.com/rbeezer/mathbook and the analagous file at https://github.com/twjudson/aata -->


<!-- DMOI customizations for LaTeX runs -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<!-- Assumes current file is in discrete-text/xsl and that the mathbook repository is adjacent -->
<xsl:import href="../../mathbook/xsl/mathbook-latex.xsl" />
<!-- Assumes next file can be found in discrete-text/xsl -->
<xsl:import href="custom-common.xsl" />





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
<xsl:param name="latex.geometry" select="'papersize={6in,9in}, hmargin={0.85in, 0.5in}, height=7.75in, top=0.75in, twoside, ignoreheadfoot'"/>
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
<!-- <xsl:param name="latex.preamble.early" select="''" /> -->
<!-- <xsl:param name="latex.preamble.late" select="''" /> -->
<!--  -->
<!-- Console characters allow customization of how    -->
<!-- LaTeX macros are recognized in the fancyvrb      -->
<!-- package's Verbatim clone environment, "console"  -->
<!-- The defaults are traditional LaTeX, we let any   -->
<!-- other specification make a document-wide default -->
<!-- <xsl:param name="latex.console.macro-char" select="'\'" />
<xsl:param name="latex.console.begin-char" select="'{'" />
<xsl:param name="latex.console.end-char" select="'}'" /> -->

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
<!-- <xsl:param name="exercise.text.statement" select="'yes'" />
<xsl:param name="exercise.text.hint" select="'yes'" />
<xsl:param name="exercise.text.answer" select="'no'" />
<xsl:param name="exercise.text.solution" select="'no'" />
<xsl:param name="exercise.backmatter.statement" select="'no'" />
<xsl:param name="exercise.backmatter.hint" select="'no'" />
<xsl:param name="exercise.backmatter.answer" select="'yes'" />
<xsl:param name="exercise.backmatter.solution" select="'yes'" /> -->



<!-- Include a style file at the end of the preamble: -->

<xsl:param name="latex.preamble.late">
  <xsl:text>%This should load all the style information that mbx does not.&#xa;</xsl:text>
    <xsl:text>\input{latex-preamble-styles}&#xa;</xsl:text>
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
    <xsl:text>\input{frontmatter/title-page}&#xa;</xsl:text>
    <xsl:text>%% end: title page&#xa;</xsl:text>
</xsl:template>

<!-- Import custom copyright page -->
<xsl:template match="book" mode="copyright-page" >
    <xsl:text>%% begin: copyright-page&#xa;</xsl:text>
    <xsl:text>\input{frontmatter/copyright-page}&#xa;</xsl:text>
    <xsl:text>%% end:   copyright-page&#xa;</xsl:text>
</xsl:template>

<!-- Dedication style -->
<xsl:template match="dedication/p|dedication/p[1]" priority="1">
    <xsl:text>\begin{flushright}\large%&#xa;</xsl:text>
        <xsl:apply-templates />
    <xsl:text>%&#xa;</xsl:text>
    <xsl:text>\end{flushright}&#xa;</xsl:text>
</xsl:template>


<!-- Create a heading for each non-empty collection of solutions -->
<!-- Format as appropriate LaTeX subdivision for this level      -->
<!-- But number according to the actual Exercises section        -->
<!-- <xsl:template match="exercises" mode="backmatter">
    <xsl:variable name="nonempty" select="(.//hint and $exercise.backmatter.hint='yes') or (.//answer and $exercise.backmatter.answer='yes') or (.//solution and $exercise.backmatter.solution='yes')" />
    <xsl:if test="$nonempty='true'">
        <xsl:text>\</xsl:text>
        <xsl:apply-templates select="." mode="division-name" />
        <xsl:text>*{</xsl:text>
        <xsl:apply-templates select="." mode="number" />
        <xsl:text> </xsl:text>
        <xsl:apply-templates select="." mode="title-full" />
        <xsl:text>}&#xa;</xsl:text>
        <xsl:apply-templates select="*" mode="backmatter" />
    </xsl:if>
</xsl:template> -->

<!-- Create a heading for each non-empty collection of solutions -->
<!-- Format as appropriate LaTeX subdivision for this level      -->
<!-- But number according to the actual Exercises section        -->
<!-- This needs to be fixed! -->
<!-- <xsl:template match="exercises" mode="backmatter">
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
</xsl:template> -->




<!-- Set up solution list -->
<!-- Print exercises with some solution component -->
<!-- Respect switches about visibility ("knowl" is assumed to be 'no') -->
<!-- <xsl:template match="exercise" mode="backmatter">
    <xsl:if test="answer or solution">  -->
      <!-- revmoed hint, those are not displayed here.  If I move hints to the back, I need to put it back here too -->
        <!-- Lead with the problem number and some space -->
        <!-- <xsl:text>\noindent\textbf{</xsl:text>
        <xsl:apply-templates select="." mode="number" />  -->
        <!-- changed serial-number to number -->
        <!-- <xsl:text>.} </xsl:text>
        <xsl:if test="$exercise.backmatter.statement='yes'"> -->
            <!-- TODO: not a "backmatter" template - make one possibly? Or not necessary -->
            <!-- <xsl:apply-templates select="statement" />
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
</xsl:template> -->


<!-- MINE: Fix for webwork popup formatting: -->
<!-- answer blank for other kinds of answers                 -->
<!-- TODO: gradually eliminate "var"'s presence from static  -->
<!-- coming from a WeBWorK server, similar to how the above  -->
<!-- replaced var with fillin for quantitative answers.      -->
<xsl:template match="webwork-reps/static//statement//var[@form]">
    <xsl:choose>
        <!-- TODO: make semantic list style in preamble -->
        <xsl:when test="@form='popup'" >
            <!-- <xsl:text>\quad(\begin{itemize*}[label=$\square$,leftmargin=3em,itemjoin=\hspace{1em}]&#xa;</xsl:text>
            <xsl:for-each select="li">
                <xsl:if test="not(p[.='?']) and not(normalize-space(.)='?')">
                    <xsl:text>\item{}</xsl:text>
                    <xsl:apply-templates select='.' />
                    <xsl:text>&#xa;</xsl:text>
                </xsl:if>
            </xsl:for-each>
            <xsl:text>\end{itemize*})\quad&#xa;</xsl:text> -->
        </xsl:when>
        <!-- Radio button alternatives:                                -->
        <!--     \ocircle (wasysym), \circledcirc (amssymb),           -->
        <!--     \textopenbullet, \textbigcircle (textcomp)            -->
        <!-- To adjust in preamble, test on:                           -->
        <!-- $document-root//webwork-reps/static//var[@form='buttons'] -->
        <xsl:when test="@form='buttons'" >
            <xsl:text>\par&#xa;</xsl:text>
            <xsl:text>\begin{itemize}[label=$\odot$,leftmargin=3em,]&#xa;</xsl:text>
            <xsl:for-each select="li">
                <xsl:text>\item{}</xsl:text>
                <xsl:apply-templates select='.' />
                <xsl:text>&#xa;</xsl:text>
            </xsl:for-each>
            <xsl:text>\end{itemize}&#xa;</xsl:text>
        </xsl:when>
        <xsl:when test="@form='checkboxes'" >
            <xsl:text>\par&#xa;</xsl:text>
            <xsl:text>\begin{itemize*}[label=$\square$,leftmargin=3em,itemjoin=\hspace{4em plus 1em minus 3em}]&#xa;</xsl:text>
            <xsl:for-each select="li">
                <xsl:if test="not(p[.='?']) and not(normalize-space(.)='?')">
                    <xsl:text>\item{}</xsl:text>
                    <xsl:apply-templates select='.' />
                    <xsl:text>&#xa;</xsl:text>
                </xsl:if>
            </xsl:for-each>
            <xsl:text>\end{itemize*}&#xa;</xsl:text>
        </xsl:when>
        <xsl:when test="@form='essay'" >
            <xsl:text>\quad\lbrack Essay Answer\rbrack</xsl:text>
        </xsl:when>
    </xsl:choose>
</xsl:template>







<!-- Set up headers for index -->
<xsl:template match="index-list">
    <xsl:text>%&#xa;</xsl:text>
    <xsl:text>%% The index is here, setup is all in preamble&#xa;</xsl:text>
    <!-- Not sure why this is needed, but this will get the headings right -->
    <xsl:text>\markright{Index}&#xa;</xsl:text>
    <xsl:text>\renewcommand{\leftmark}{Index}&#xa;</xsl:text>
    <xsl:text>\printindex&#xa;</xsl:text>
    <xsl:text>%&#xa;</xsl:text>
</xsl:template>




<!-- Remove leavemode for assemblage -->
<!-- Lists themselves -->
<!-- If columns are specified, we        -->
<!-- wrap in the multicolumn environment -->
<!-- TODO: fewer \leavevmode might be possible.      -->
<!-- Test for first node of "p", then test for the   -->
<!-- "p" being first node of some sectioning element -->
<xsl:template match="ol">
    <xsl:choose>
        <xsl:when test="not(ancestor::ol or ancestor::ul or ancestor::dl or ancestor::assemblage or ancestor::investigation)">
            <xsl:call-template name="leave-vertical-mode" />
        </xsl:when>
        <xsl:otherwise>
            <xsl:text>%&#xa;</xsl:text>
        </xsl:otherwise>
    </xsl:choose>
    <xsl:if test="@cols">
        <xsl:text>\begin{multicols}{</xsl:text>
        <xsl:value-of select="@cols" />
        <xsl:text>}&#xa;</xsl:text>
    </xsl:if>
    <xsl:text>\begin{enumerate}</xsl:text>
    <!-- override LaTeX defaults as indicated -->
    <xsl:if test="@label or ancestor::exercises or ancestor::references">
        <xsl:text>[label=</xsl:text>
        <xsl:apply-templates select="." mode="latex-list-label" />
        <xsl:text>]</xsl:text>
    </xsl:if>
    <xsl:text>&#xa;</xsl:text>
     <xsl:apply-templates />
    <xsl:text>\end{enumerate}&#xa;</xsl:text>
    <xsl:if test="@cols">
        <xsl:text>\end{multicols}&#xa;</xsl:text>
    </xsl:if>
</xsl:template>

<!-- MBX unordered list scheme is distinct -->
<!-- from LaTeX's so we write out a label  -->
<!-- choice for each such list             -->
<xsl:template match="ul">
    <xsl:choose>
        <xsl:when test="not(ancestor::ol or ancestor::ul or ancestor::dl or ancestor::assemblage or ancestor::investigation)">
            <xsl:call-template name="leave-vertical-mode" />
        </xsl:when>
        <xsl:otherwise>
            <xsl:text>%&#xa;</xsl:text>
        </xsl:otherwise>
    </xsl:choose>
    <xsl:if test="@cols">
        <xsl:text>\begin{multicols}{</xsl:text>
        <xsl:value-of select="@cols" />
        <xsl:text>}&#xa;</xsl:text>
    </xsl:if>
    <xsl:text>\begin{itemize}[label=</xsl:text>
    <xsl:apply-templates select="." mode="latex-list-label" />
    <xsl:text>]&#xa;</xsl:text>
    <xsl:apply-templates />
    <xsl:text>\end{itemize}&#xa;</xsl:text>
    <xsl:if test="@cols">
        <xsl:text>\end{multicols}&#xa;</xsl:text>
    </xsl:if>
</xsl:template>

<xsl:template match="dl">
    <xsl:choose>
        <xsl:when test="not(ancestor::ol or ancestor::ul or ancestor::dl or ancestor::assemblage or ancestor::investigation)">
            <xsl:call-template name="leave-vertical-mode" />
        </xsl:when>
        <xsl:otherwise>
            <xsl:text>%&#xa;</xsl:text>
        </xsl:otherwise>
    </xsl:choose>
    <xsl:if test="@cols">
        <xsl:text>\begin{multicols}{</xsl:text>
        <xsl:value-of select="@cols" />
        <xsl:text>}&#xa;</xsl:text>
    </xsl:if>
    <xsl:text>\begin{description}&#xa;</xsl:text>
    <xsl:apply-templates />
    <xsl:text>\end{description}&#xa;</xsl:text>
    <xsl:if test="@cols">
        <xsl:text>\end{multicols}&#xa;</xsl:text>
    </xsl:if>
</xsl:template>




<!-- Each component has a similar look, so we combine here -->
<!-- Separators depend on possible trailing items, so no   -->
<!-- vertical spacing beforehand is present here           -->
<xsl:template match="hint|answer|solution" mode="solution-heading">
    <xsl:param name="b-original" select="true()" />

    <xsl:text>\textbf{</xsl:text>
    <xsl:apply-templates select="." mode="type-name" />
    <!-- An empty value means element is a singleton -->
    <!-- else the serial number comes through        -->
    <xsl:variable name="the-number">
        <xsl:apply-templates select="." mode="non-singleton-number" />
    </xsl:variable>
    <xsl:if test="not($the-number = '')">
        <xsl:text> </xsl:text>
        <xsl:apply-templates select="." mode="serial-number" />
    </xsl:if>
    <xsl:text>}</xsl:text> <!-- end bold number -->
    <xsl:if test="title">
        <xsl:text> (</xsl:text>
        <xsl:apply-templates select="." mode="title-full" />
        <xsl:text>)</xsl:text>
    </xsl:if>
    <xsl:text>.</xsl:text>
    <!-- <xsl:if test="$b-original">
        <xsl:apply-templates select="." mode="label" />
    </xsl:if> -->
    <!-- some distance to actual content -->
    <!-- <xsl:text>~~%&#xa;</xsl:text> -->
</xsl:template>

</xsl:stylesheet>
