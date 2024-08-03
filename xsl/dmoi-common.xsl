<?xml version='1.0'?>

<!-- This file is part of the book                 -->
<!--                                               -->
<!--   Discrete Mathematics: an Open Introduction  -->
<!--                                               -->
<!-- Copyright (C) 2015-2018 Oscar Levin           -->
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
<!-- <xsl:param name="chunk.level" select="''" /> -->

<!-- DO NOT USE -->
<!-- HTML-specific deprecated 2015/06, but still functional -->
<!-- <xsl:param name="html.chunk.level" select="''" /> -->
<!-- DO NOT USE -->

<!-- An exercise has a statement, and may have hints,      -->
<!-- answers and solutions.  An answer is just the         -->
<!-- final number, expression, whatever; while a solution  -->
<!-- includes intermediate steps. Parameters here control  -->
<!-- the *visibility* of these four parts                  -->
<!--                                                       -->
<!-- Parameters are:                                       -->
<!--   'yes' - visible                                     -->
<!--   'no' - not visible                                  -->
<!--                                                       -->
<!-- Five categories:                                      -->
<!--   inline (checpoint) exercises                        -->
<!--   divisional (inside an "exercises" division)         -->
<!--   worksheet (inside a "worksheet" division)           -->
<!--   reading (inside a "reading-questions" division)     -->
<!--   project (on a project-like,                         -->
<!--   or possibly on a terminal "task" of a project-like) -->
<!--                                                       -->
<!-- Default is "yes" for every part, so experiment        -->
<!-- with parameters to make some parts hidden.            -->
<!--                                                       -->
<!-- These are global switches, so only need to be fed     -->
<!-- into the construction of exercises via the            -->
<!-- "exercise-components" template.                       -->
<!-- N.B. "statement" switches are necessary or desirable  -->
<!-- for alternate collections of solutions (only)         -->
<!-- <xsl:param name="exercise.inline.statement" select="''" />
<xsl:param name="exercise.inline.hint" select="''" />
<xsl:param name="exercise.inline.answer" select="''" />
<xsl:param name="exercise.inline.solution" select="''" />
<xsl:param name="exercise.divisional.statement" select="''" />
<xsl:param name="exercise.divisional.hint" select="'no'" />
<xsl:param name="exercise.divisional.answer" select="'no'" />
<xsl:param name="exercise.divisional.solution" select="'no'" />
<xsl:param name="exercise.worksheet.statement" select="''" />
<xsl:param name="exercise.worksheet.hint" select="''" />
<xsl:param name="exercise.worksheet.answer" select="''" />
<xsl:param name="exercise.worksheet.solution" select="''" />
<xsl:param name="exercise.reading.statement" select="''" />
<xsl:param name="exercise.reading.hint" select="''" />
<xsl:param name="exercise.reading.answer" select="''" />
<xsl:param name="exercise.reading.solution" select="''" />
<xsl:param name="project.statement" select="''" />
<xsl:param name="project.hint" select="''" />
<xsl:param name="project.answer" select="''" />
<xsl:param name="project.solution" select="''" /> -->
<!-- Author tools are for drafts, mostly "todo" items                 -->
<!-- and "provisional" citations and cross-references                 -->
<!-- Default is to hide todo's, inline provisionals                   -->
<!-- Otherwise ('yes'), todo's in red paragraphs, provisionals in red -->
<xsl:param name="author.tools" select="'no'" />

<!-- How many levels to table of contents  -->
<!-- Not peculiar to HTML or LaTeX or etc. -->
<!-- Sentinel indicates no choice made     -->
<!-- <xsl:param name="toc.level" select="'3'" /> -->
<!-- How many levels in numbering of theorems, etc     -->
<!-- Followed by a sequential number across that level -->
<!-- For example "2" implies Theorem 5.3.12 is         -->
<!-- 12-th theorem, lemma, etc in 5.2                  -->
<!-- <xsl:param name="numbering.theorems.level" select="'2'" /> -->
<!-- How many levels in numbering of projects, etc     -->
<!-- PROJECT-LIKE gets independent numbering -->
<!-- <xsl:param name="numbering.projects.level" select="'1'" /> -->
<!-- How many levels in numbering of equations     -->
<!-- Analagous to numbering theorems, but distinct -->
<!-- <xsl:param name="numbering.equations.level" select="'1'" /> -->
<!-- Level where footnote numbering resets                                -->
<!-- For example, "2" would be sections in books, subsections in articles -->
<!-- <xsl:param name="numbering.footnotes.level" select="'1'" /> -->
<!-- Last level where subdivision (section) numbering takes place     -->
<!-- For example, "2" would mean subsections of a book are unnumbered -->
<!-- N.B.: the levels above cannot be numerically larger              -->
<!-- <xsl:param name="numbering.maximum.level" select="'2'" /> -->
<!-- Image files, media files and knowls are placed in directories    -->
<!-- The defaults are relative to wherever principal output goes      -->
<!-- These can be overridden at the command-line or in customizations -->
<!-- <xsl:param name="directory.images" select="'images'" />
<xsl:param name="directory.media"  select="'media'" />
<xsl:param name="directory.knowls" select="'knowls'" /> -->
<!-- Pointers to realizations of the actual document -->
<!-- <xsl:param name="address.html" select="''" />
<xsl:param name="address.pdf" select="''" /> -->

<!-- To start chapters at 0 (might change later)-->
<!-- <xsl:param name="debug.chapter.start" select="'0'" /> -->

<!-- Forward links to solutions -->
<!-- very temporary, just for testing -->
<!-- <xsl:param name="debug.exercises.forward" select="'yes'"/> -->


<!-- WeBWorK -->
<!-- There is no default server provided         -->
<!-- Interactions are with an "anonymous" course -->
<!-- <xsl:param name="webwork.server" select="'https://webwork-dev.aimath.org'"/>
<xsl:param name="webwork.course" select="'anonymous'" />
<xsl:param name="webwork.userID" select="'anonymous'" />
<xsl:param name="webwork.password" select="'anonymous'" /> -->

<!-- Redefine chapter numbering to start at 0 -->
<!-- <xsl:template match="chapter" mode="division-serial-number"> -->
    <!-- chapters, in parts or not, do not have "references" -->
    <!-- or "exercises" divisions as peers, so we just count -->
    <!-- chapters, varying the subtree considered depending  -->
    <!-- on the style elected for how parts are numbered     -->
    <!-- <xsl:variable name="n">
      <xsl:choose>
        <xsl:when test="($parts = 'absent') or ($parts = 'decorative')">
            <xsl:number from="book" level="any" count="chapter" format="1" />
        </xsl:when>
        <xsl:when test="$parts = 'structural'">
            <xsl:number from="part" count="chapter" format="1" />
        </xsl:when>
      </xsl:choose>
    </xsl:variable>
    <xsl:number value="$n - 1" format="1" />
</xsl:template> -->



<!-- Set exercises blocks to be numbered by their parent section   -->
<!-- <xsl:template match="exercises" mode="number">
    <xsl:variable name="serial">
        <xsl:apply-templates select="parent::*" mode="serial-number" />
    </xsl:variable>
    <xsl:if test="not($serial = '')">
        <xsl:apply-templates select="parent::*" mode="structure-number" />
        <xsl:value-of select="$serial" />
    </xsl:if>
</xsl:template> -->


<!-- Reload this to get exercise numbers to respect exercise block numbers -->
<!-- <xsl:template match="exercises/exercise|exercises/exercisegroup/exercise" mode="serial-number">
    <xsl:number from="exercises" level="any" count="exercise" />
</xsl:template>
<xsl:template match="exercises/exercise[@number]|exercisegroup/exercise[@number]" mode="serial-number">
    <xsl:apply-templates select="@number" />
</xsl:template> -->

<!-- Hints, answers, solutions may be numbered (for cross-reference knowls) -->
<!-- <xsl:template match="hint|answer|solution" mode="serial-number">
    <xsl:number />
</xsl:template> -->

<!-- Hack (12/21/18): make all exercises unstructured? -->
<!-- There are two models for most of the divisions (part -->
<!-- through subsubsection, plus appendix).  One has      -->
<!-- subdivisions, and possibly multiple "exercises", or  -->
<!-- other specialized subdivisions.  The other has no    -->
<!-- subdivisions, and then at most one of each type of   -->
<!-- specialized subdivision, which inherit numbers from  -->
<!-- their parent division. This is the test, which is    -->
<!-- very similar to "is-leaf" above.                     -->
<!--                                                      -->
<!-- A "part" must have chapters, so will always return   -->
<!-- 'true' and for a 'subsubsection' there are no more   -->
<!-- subdivisions to employ and so will return empty.     -->
<!-- <xsl:template match="book|article|part|chapter|appendix|section|subsection|subsubsection" mode="is-structured-division">
    <xsl:if test="chapter|section|subsection|subsubsection">
        <xsl:text></xsl:text>  -->
        <!-- removed "true", so now this should make all exercises think they are part of unstructured divisions -->
    <!-- </xsl:if>
  </xsl:template> -->

</xsl:stylesheet>
