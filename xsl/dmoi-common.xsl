<?xml version='1.0'?>

<!-- This file is part of the book                 -->
<!--                                               -->
<!--   Discrete Mathematics: an Open Introduction  -->
<!--                                               -->
<!-- Copyright (C) 2015-2016 Oscar Levin           -->
<!-- See the file COPYING for copying conditions.  -->

<!-- Parts of this file were adapted from the author guide at https://github.com/rbeezer/mathbook and the analagous file at https://github.com/twjudson/aata -->

<!-- DMOI customizations for ALL versions of any type -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<!-- Assumes current file is in discrete-text/xsl                         -->
<!-- These are defined in matbook-common.xsl, so these are overrides      -->
<!-- Explanations are verbatim, from 2015/05/19                           -->



<!-- Parameters to pass via xsltproc "stringparam" on command-line            -->
<!-- Or make a thin customization layer and use 'select' to provide overrides -->
<!-- These here are independent of the output format as well                  -->
<!--                                                                          -->
<!-- Depth to which a document is broken into smaller files/chunks -->
<!-- Sentinel indicates no choice made                             -->
<xsl:param name="chunk.level" select="''" />

<!-- DO NOT USE -->
<!-- HTML-specific deprecated 2015/06, but still functional -->
<xsl:param name="html.chunk.level" select="''" />
<!-- DO NOT USE -->

<!-- An exercise has a statement, and may have hints,      -->
<!-- answers and solutions.  An answer is just the         -->
<!-- final number, expression, whatever; while a solution  -->
<!-- includes intermediate steps. Parameters here control  -->
<!-- the *visibility* of these four parts                  -->
<!--                                                       -->
<!-- Parameters are:                                       -->
<!--   'yes' - immediately visible                         -->
<!--   'knowl' - adjacent, but requires action to reveal   -->
<!--    NB: HTML - 'knowl' not implemented or recognized   -->
<!--       'yes' makes knowls for hints, etc *always*      -->
<!--   'no' - not visible at all                           -->
<!--                                                       -->
<!-- First, an exercise in exercises section.              -->
<!-- Default is "yes" for every part, so experiment        -->
<!-- with parameters to make some parts hidden.            -->
<xsl:param name="exercise.text.statement" select="'yes'" />
<xsl:param name="exercise.text.hint" select="'no'" />
<xsl:param name="exercise.text.answer" select="'no'" />
<xsl:param name="exercise.text.solution" select="'no'" />
<!-- Second, an exercise in a solutions list in backmatter.-->
<xsl:param name="exercise.backmatter.statement" select="'no'" />
<xsl:param name="exercise.backmatter.hint" select="'yes'" />
<xsl:param name="exercise.backmatter.answer" select="'yes'" />
<xsl:param name="exercise.backmatter.solution" select="'yes'" />
<!-- Author tools are for drafts, mostly "todo" items                 -->
<!-- and "provisional" citations and cross-references                 -->
<!-- Default is to hide todo's, inline provisionals                   -->
<!-- Otherwise ('yes'), todo's in red paragraphs, provisionals in red -->
<xsl:param name="author-tools" select="'no'" />
<!-- Cross-references like Section 5.2, Theorem 6.7.89    -->
<!-- "know" what they point to, so we can get the "name"  -->
<!-- part automatically (and have it change with editing) -->
<!-- This switch is global, override with @autoname='no'  -->
<!-- on an <xref> where it is unjustified or a problem    -->
<!-- Default is to have this feature off                  -->
<xsl:param name="autoname" select="'yes'" />
<!-- How many levels to table of contents  -->
<!-- Not peculiar to HTML or LaTeX or etc. -->
<!-- Sentinel indicates no choice made     -->
<xsl:param name="toc.level" select="'4'" />
<!-- How many levels in numbering of theorems, etc     -->
<!-- Followed by a sequential number across that level -->
<!-- For example "2" implies Theorem 5.3.12 is         -->
<!-- 12-th theorem, lemma, etc in 5.2                  -->
<xsl:param name="numbering.theorems.level" select="'2'" />
<!-- How many levels in numbering of projects, etc     -->
<!-- PROJECT-LIKE gets independent numbering -->
<xsl:param name="numbering.projects.level" select="'0'" />
<!-- How many levels in numbering of equations     -->
<!-- Analagous to numbering theorems, but distinct -->
<xsl:param name="numbering.equations.level" select="'1'" />
<!-- Level where footnote numbering resets                                -->
<!-- For example, "2" would be sections in books, subsections in articles -->
<xsl:param name="numbering.footnotes.level" select="'1'" />
<!-- Last level where subdivision (section) numbering takes place     -->
<!-- For example, "2" would mean subsections of a book are unnumbered -->
<!-- N.B.: the levels above cannot be numerically larger              -->
<xsl:param name="numbering.maximum.level" select="'2'" />
<!-- Image files, media files and knowls are placed in directories    -->
<!-- The defaults are relative to wherever principal output goes      -->
<!-- These can be overridden at the command-line or in customizations -->
<xsl:param name="directory.images" select="'images'" />
<xsl:param name="directory.media"  select="'media'" />
<xsl:param name="directory.knowls" select="'knowls'" />
<!-- Pointers to realizations of the actual document -->
<xsl:param name="address.html" select="''" />
<xsl:param name="address.pdf" select="''" />



<!-- Redefine chapter numbering to start at 0 -->
<xsl:template match="chapter" mode="raw-serial-number">
    <xsl:variable name="n">
      <xsl:number count="chapter|references|exercises"/>
    </xsl:variable>
    <xsl:number value="$n - 1" format="1" />
</xsl:template>

<xsl:template match="exercises|references" mode="raw-serial-number">
    <xsl:number count="part|chapter|appendix|section|subsection|subsubsection|references|exercises" format="1" />
</xsl:template>

<!-- Set exercises blocks to be numbered by their parent section   -->
<xsl:template match="exercises" mode="number">
    <xsl:variable name="serial">
        <xsl:apply-templates select="parent::*" mode="serial-number" />
    </xsl:variable>
    <xsl:if test="not($serial = '')">
        <xsl:apply-templates select="parent::*" mode="structure-number" />
        <xsl:value-of select="$serial" />
    </xsl:if>
</xsl:template>


<!-- Reload this to get exercise numbers to respect exercise block numbers -->
<xsl:template match="exercises/exercise|exercises/exercisegroup/exercise" mode="serial-number">
    <xsl:number from="exercises" level="any" count="exercise" />
</xsl:template>
<xsl:template match="exercises/exercise[@number]|exercisegroup/exercise[@number]" mode="serial-number">
    <xsl:apply-templates select="@number" />
</xsl:template>
<!-- Hints, answers, solutions may be numbered (for cross-reference knowls) -->
<xsl:template match="hint|answer|solution" mode="serial-number">
    <xsl:number />
</xsl:template>


</xsl:stylesheet>
