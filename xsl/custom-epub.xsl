<?xml version="1.0" encoding="UTF-8"?>


<!-- This file is part of the book                 -->
<!--                                               -->
<!--   Discrete Mathematics: an Open Introduction  -->
<!--                                               -->
<!-- Copyright (C) 2015-2018 Oscar Levin           -->
<!-- See the file COPYING for copying conditions.  -->

<!-- Parts of this file were adapted from the author guide at https://github.com/rbeezer/mathbook and the analagous file at https://github.com/twjudson/aata -->


<!-- DMOI customizations for HTML runs -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<!-- Assumes current file is in discrete-text/xsl and that the mathbook repository is adjacent -->
<xsl:import href="../../mathbook/xsl/mathbook-epub.xsl" />
<!-- Assumes next file can be found in discrete-text/xsl -->
<xsl:import href="custom-common.xsl" />

<!-- List Chapters and Sections in sidebar Table of Contents -->
<xsl:param name="toc.level" select="''" />


<!-- Knowls do not function in an ePub,       -->
<!-- so no content should be born hidden      -->
<!-- TODO: enable turning off xrefs as knowls -->
<xsl:param name="html.knowl.theorem" select="'no'" />
<xsl:param name="html.knowl.proof" select="'no'" />
<xsl:param name="html.knowl.definition" select="'no'" />
<xsl:param name="html.knowl.example" select="'no'" />
<xsl:param name="html.knowl.remark" select="'no'" />
<xsl:param name="html.knowl.figure" select="'no'" />
<xsl:param name="html.knowl.table" select="'no'" />
<xsl:param name="html.knowl.exercise" select="'no'" />

<!-- Hints, solutions, etc are typically knowled   -->
<!-- We temporarily kill them all as a convenience -->
<xsl:param name="exercise.text.statement" select="'yes'" />
<xsl:param name="exercise.text.hint" select="'no'" />
<xsl:param name="exercise.text.answer" select="'no'" />
<xsl:param name="exercise.text.solution" select="'no'" />
<!-- Second, an exercise in a solutions list in backmatter.-->
<xsl:param name="exercise.backmatter.statement" select="'no'" />
<xsl:param name="exercise.backmatter.hint" select="'no'" />
<xsl:param name="exercise.backmatter.answer" select="'no'" />
<xsl:param name="exercise.backmatter.solution" select="'no'" />

<!-- CSS and Javascript Servers -->
<!-- We allow processing paramteers to specify new servers   -->
<!-- or to specify the particular CSS file, which may have   -->
<!-- different color schemes.  The defaults should work      -->
<!-- fine and will not need changes on initial or casual use -->
<!-- #0 to #5 on mathbook-modern for different color schemes -->
<!-- We just like #3 as the default                          -->
<!-- N.B.:  This scheme is transitional and may change             -->
<!-- N.B.:  without warning and without any deprecation indicators -->
<xsl:param name="html.js.server"  select="'https://aimath.org'" />
<xsl:param name="html.css.server" select="'https://aimath.org'" />
<xsl:param name="html.css.file"   select="'mathbook-4.css'" />
<!-- A space-separated list of CSS URLs (points to servers or local files) -->
<xsl:param name="html.css.extra"  select="'custom-styles.css title-period-fix.css'" />

<!-- Navigation -->
<!-- Navigation may follow two different logical models:                     -->
<!--   (a) Linear, Prev/Next - depth-first search, linear layout like a book -->
<!--       Previous and Next take you to the adjacent "page"                 -->
<!--   (b) Tree, Prev/Up/Next - explicitly traverse the document tree        -->
<!--       Prev and Next remain at same depth/level in tree                  -->
<!--       Must follow a summary link to descend to finer subdivisions       -->
<!--   'linear' is the default, 'tree' is an option                          -->
<xsl:param name="html.navigation.logic"  select="'linear'" />
<!-- The "up" button is optional given the contents sidebar, default is to have it -->
<!-- An up button is very desirable if you use the tree-like logic                 -->
<xsl:param name="html.navigation.upbutton"  select="'yes'" />
<!-- There are also "compact" versions of the navigation buttons in the top right -->
<xsl:param name="html.navigation.style"  select="'full'" />

<!-- WeBWorK -->
<!-- There is no default server provided         -->
<!-- Interactions are with an "anonymous" course -->
<xsl:param name="webwork.server" select="''"/>
<xsl:param name="webwork.course" select="'anonymous'" />
<xsl:param name="webwork.userID" select="'anonymous'" />
<xsl:param name="webwork.password" select="'anonymous'" />

<!-- Permalinks -->
<!-- Next to subdivision headings a "paragraph" symbol     -->
<!-- (a pilcrow) along with internationalized text         -->
<!-- ("permalink") indicates a link to that section.       -->
<!-- It is useful if you want to right-click on it to      -->
<!-- capture a link for use somewhere else.  (Similar      -->
<!-- behavior for theorems, examples, etc is planned.)     -->
<!--                                                       -->
<!-- "Permalink" is a bit of an exaggeration.  Site        -->
<!-- domain name is relative to wherever content is        -->
<!-- hosted.  We say a link is "stable" if there is        -->
<!-- an  xml:id  on the enclosing page AND an  xml:id      -->
<!-- on the subdivision (which could be the same).         -->
<!-- If you change the chunking level, then the enclosing  -->
<!-- page could change and these links will be affected.   -->
<!--                                                       -->
<!-- 'none' - no permalinks anywhere                       -->
<!-- 'stable' - only stable links (see paragraph above)    -->
<!-- 'all' - every section heading, even if links are poor -->
<xsl:param name="html.permalink"  select="'all'" />







<!-- Hack solution-list to display nicer headers -->
<xsl:template match="exercises" mode="backmatter">
    <!-- see if an "exercises" section has any solutions -->
    <xsl:variable name="nonempty" select="(.//hint and $exercise.backmatter.hint='yes') or
                                          (.//answer and $exercise.backmatter.answer='yes') or
                                          (.//solution and $exercise.backmatter.solution='yes')" />

    <xsl:if test="$nonempty='true'">
        <section class="exercises" id="">
            <h1 class="heading">
                <span class="type">Solutions for Section </span>
                <span class="codenumber"><xsl:apply-templates select="." mode="number" /></span>
                <!-- <span class="title"><xsl:apply-templates select="." mode="title-full" /></span> -->
            </h1>
            <!-- ignore introduction, conclusion, exercise groups -->
            <xsl:apply-templates select=".//exercise" mode="backmatter" />
        </section>
    </xsl:if>
</xsl:template>
<!-- Print exercises with some solution component -->
<!-- Respect switches about visibility            -->
<xsl:template match="exercise" mode="backmatter">
    <xsl:if test="answer or solution"><!-- Removed "hint or" -->
        <!-- Lead with the problem number and some space -->
        <xsl:variable name="xref">
            <xsl:apply-templates select="." mode="internal-id" />
        </xsl:variable>
        <article class="exercise-like" id="{$xref}">
            <h5 class="heading hidden-type">
            <!-- <span class="type"><xsl:apply-templates select="." mode="type-name" /></span> -->
            <span class="codenumber"><xsl:apply-templates select="." mode="number" /></span>
            <xsl:if test="title">
                <span class="title"><xsl:apply-templates select="." mode="title-full" /></span>
            </xsl:if>
            </h5>
            <!-- default templates will produce inline knowls -->
            <span class="hidden-knowl-wrapper">
              <xsl:if test="$exercise.backmatter.statement='yes'">
                <xsl:apply-templates select="statement" />
              </xsl:if> <!-- moved first one down -->
                <xsl:if test="hint and $exercise.backmatter.hint='yes'">
                    <xsl:apply-templates select="hint" />
                </xsl:if>
                <xsl:if test="answer and $exercise.backmatter.answer='yes'">
                    <xsl:apply-templates select="answer" />
                </xsl:if>
                <xsl:if test="solution and $exercise.backmatter.solution='yes'">
                    <xsl:apply-templates select="solution" />
                </xsl:if>
            </span>
        </article>
    </xsl:if>
</xsl:template>





<!-- Exercise Group -->
<!-- We interrupt a list of exercises with short commentary, -->
<!-- typically instructions for a list of similar exercises  -->
<!-- Commentary goes in an introduction and/or conclusion    -->
<!-- Available as a xref knowl, but never born hidden        -->
<xsl:template match="exercisegroup" mode="is-hidden-old">
    <xsl:value-of select="false()" />
</xsl:template>
<xsl:template match="exercisegroup" mode="is-block-env">
    <xsl:value-of select="true()" />
</xsl:template>
<!-- Never hidden so calling hidden-knowl-text raises error -->
<!-- There is no head ever -->
<xsl:template match="exercisegroup" mode="head" />
<!-- Body is just all content             -->
<!-- introducttion, exercises, conclusion -->
<xsl:template match="exercisegroup" mode="body">
    <xsl:apply-templates />
</xsl:template>
<!-- No posterior  -->
<xsl:template match="exercisegroup" mode="posterior" />
<!-- HTML, CSS -->
<xsl:template match="exercisegroup" mode="environment-element">
    <xsl:text>div</xsl:text>
</xsl:template>
<xsl:template match="exercisegroup" mode="environment-class">
    <xsl:text>exercisegroup</xsl:text>
</xsl:template>

<!-- Exercises -->
<!-- TODO: switches for inline versus sectional -->
<xsl:template match="exercise" mode="is-hidden-old">
    <xsl:value-of select="$html.knowl.exercise.inline = 'yes'" />
</xsl:template>
<xsl:template match="exercises//exercise" mode="is-hidden-old">
    <xsl:value-of select="$html.knowl.exercise.sectional = 'yes'" />
</xsl:template>
<!-- does block form work in "exercises" section -->
<xsl:template match="exercise" mode="is-block-env">
    <xsl:value-of select="true()" />
</xsl:template>
<!-- Knowl text has simpler number at appearance in division -->
<xsl:template match="exercises//exercise" mode="hidden-knowl-text">
    <h5 class="heading">
    <span class="type"><xsl:apply-templates select="." mode="type-name" /></span>
    <xsl:text> </xsl:text>
    <span class="codenumber"><xsl:apply-templates select="." mode="serial-number" /></span>
    <xsl:if test="title">
        <xsl:text> </xsl:text>
        <span class="title"><xsl:apply-templates select="." mode="title-full" /></span>
    </xsl:if>
    </h5>
</xsl:template>
<xsl:template match="exercise" mode="hidden-knowl-text">
    <h5 class="heading">
    <span class="type"><xsl:apply-templates select="." mode="type-name" /></span>
    <xsl:text> </xsl:text>
    <span class="codenumber"><xsl:apply-templates select="." mode="number" /></span>
    <xsl:if test="title">
        <xsl:text> </xsl:text>
        <span class="title"><xsl:apply-templates select="." mode="title-full" /></span>
    </xsl:if>
    </h5>
</xsl:template>
<!-- CHANGE: NOT Simpler head for sectional exercise -->
<xsl:template match="exercises//exercise" mode="head">
    <h5 class="heading">
    <span class="codenumber"><xsl:apply-templates select="." mode="serial-number" /></span>
    <xsl:if test="title">
        <xsl:text> </xsl:text>
        <span class="title"><xsl:apply-templates select="." mode="title-full" /></span>
    </xsl:if>
    </h5>
</xsl:template>
<xsl:template match="exercise" mode="head">
    <h5 class="heading">
    <span class="type"><xsl:apply-templates select="." mode="type-name" /></span>
    <xsl:text> </xsl:text>
    <span class="codenumber"><xsl:apply-templates select="." mode="number" /></span>
    <xsl:if test="title">
        <xsl:text> </xsl:text>
        <span class="title"><xsl:apply-templates select="." mode="title-full" /></span>
    </xsl:if>
    </h5>
</xsl:template>
<!-- Body is statement normally, but for WeBWorK -->
<!-- body is introduction, webwork, conclusion   -->
<!-- (ignoring .text switches for WW!)           -->
<xsl:template match="exercise[child::statement]" mode="body">
    <xsl:apply-templates select="statement"/>
</xsl:template>
<xsl:template match="exercise[child::webwork]" mode="body">
    <xsl:apply-templates select="statement"/>
    <xsl:apply-templates select="introduction"/>
    <xsl:apply-templates select="webwork" mode="knowl-clickable" />
    <xsl:apply-templates select="conclusion"/>
</xsl:template>
<!-- Posterior: links to information  -->
<xsl:template match="exercise" mode="posterior">
    <xsl:variable name="hint-visible">
        <xsl:value-of select="$exercise.text.hint='yes'" />
    </xsl:variable>
    <xsl:variable name="answer-visible">
        <xsl:value-of select="$exercise.text.answer='yes'" />
    </xsl:variable>
    <xsl:variable name="solution-visible">
        <xsl:value-of select="$exercise.text.solution='yes'" />
    </xsl:variable>
    <!-- Order enforced: hint, answer, solution                   -->
    <!-- wrapped in a div to get these to open in proper location -->
    <div class="hidden-knowl-wrapper">
        <xsl:if test="$hint-visible='true'">
            <xsl:apply-templates select="hint"/>
        </xsl:if>
        <xsl:if test="$answer-visible='true'">
            <xsl:apply-templates select="answer"/>
        </xsl:if>
        <xsl:if test="$solution-visible='true'">
            <xsl:apply-templates select="solution"/>
        </xsl:if>
    </div>
</xsl:template>
<!-- HTML, CSS -->
<xsl:template match="exercise" mode="environment-element">
    <xsl:text>article</xsl:text>
</xsl:template>
<xsl:template match="exercise" mode="environment-class">
    <xsl:text>exercise-like</xsl:text>
</xsl:template>



<!-- Analytics Footers -->

<!-- Google Analytics                     -->
<!-- "Classic", not compared to Universal -->
<xsl:template match="google">
<xsl:comment>Start: Google code</xsl:comment>
<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','https://www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-66485406-1', 'auto');
  ga('send', 'pageview');

</script>
<xsl:comment>End: Google code</xsl:comment>
</xsl:template>



</xsl:stylesheet>
