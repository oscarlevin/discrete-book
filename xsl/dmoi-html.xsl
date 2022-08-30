<?xml version="1.0" encoding="UTF-8"?>


<!-- This file is part of the book                 -->
<!--                                               -->
<!--   Discrete Mathematics: an Open Introduction  -->
<!--                                               -->
<!-- Copyright (C) 2015-2018 Oscar Levin           -->
<!-- See the file COPYING for copying conditions.  -->

<!-- Parts of this file were adapted from the author guide at https://github.com/rbeezer/mathbook and the analagous file at https://github.com/twjudson/aata -->
<!DOCTYPE xsl:stylesheet [
    <!ENTITY % entities SYSTEM "entities.ent">
    %entities;
]>

<!-- DMOI customizations for HTML runs -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<!-- Assumes current file is in mathbook/user -->
<xsl:import href="./core/pretext-html.xsl" />
<!-- Assumes next file can be found in mathbook/user-->
<xsl:import href="dmoi-common.xsl" />

<!-- List Chapters and Sections in sidebar Table of Contents -->
<xsl:param name="toc.level" select="''" />


<!-- Exercises -->
<!-- <xsl:param name="exercise.inline.hint" select="'yes'" />
<xsl:param name="exercise.inline.answer" select="'yes'" />
<xsl:param name="exercise.inline.solution" select="'yes'" />
<xsl:param name="exercise.divisional.hint" select="'yes'" />
<xsl:param name="exercise.divisional.answer" select="'yes'" />
<xsl:param name="exercise.divisional.solution" select="'yes'" />
<xsl:param name="project.hint" select="'yes'" />
<xsl:param name="project.answer" select="'yes'" />
<xsl:param name="project.solution" select="'yes'" /> -->

<!-- WeBWorK exercise may be rendered static="yes"    -->
<!-- TODO: implement middle option static="preview"   -->
<!-- Or static="no" makes an interactive problem      -->
<!-- Also in play here are params from -common:       -->
<!-- exercise.text.statement, exercise.text.hint, exercise.text.solution -->
<!-- For a divisional exercise, when static="no", that is an intentional -->
<!-- decision to show the live problem, which means the statement will   -->
<!-- be shown, regardless of exercise.text.statement. If the problem was -->
<!-- authored in PTX source, we can respect the values for               -->
<!-- exercise.text.hint and exercise.text.solution. If the problem       -->
<!-- source is on the webwork server, then hints and solutions will show -->
<!-- no matter what.                                                     -->
<!-- For a divisional exercise, when static="yes", each of the three     -->
<!-- -common params will be respected. Effectively the content is        -->
<!-- handled like a non-webwork exercise.                                -->
<!-- For an inline exercise (webwork or otherwise) statements, hints,    -->
<!-- and solutions are always shown. The -common params mentioned above  -->
<!-- do not apply. Whether static is "yes" or "no" doesn't matter.       -->
<xsl:param name="webwork.inline.static" select="'no'" />
<xsl:param name="webwork.divisional.static" select="'no'" />



<!-- HTML: knowlize as available/appropriate -->
<!-- <xsl:param name="exercise.text.statement" select="'yes'" />
<xsl:param name="exercise.text.hint" select="'yes'" />
<xsl:param name="exercise.text.answer" select="'yes'" />
<xsl:param name="exercise.text.solution" select="'yes'" />
<xsl:param name="exercise.backmatter.statement" select="'no'" />
<xsl:param name="exercise.backmatter.hint" select="'no'" />
<xsl:param name="exercise.backmatter.answer" select="'yes'" />
<xsl:param name="exercise.backmatter.solution" select="'yes'" />
<xsl:param name="webwork.inline.static" select="'no'" />
<xsl:param name="webwork.divisional.static" select="'no'" /> -->


<!-- Changes to mimic in HTML via CSS/other changes? -->
<!-- LaTeX: Bold and italic for terminology macro -->
<!-- LaTeX: Proof to small caps -->
<!-- LaTeX: Historical Notes -->


<!-- ID settings for various services -->
<!-- These are publisher items that may vary for a fork,     -->
<!-- and which should not be a concern while editing, and    -->
<!-- which should not run with source.  Deprecated "docinfo" -->
<!-- options are respected for now.                          -->
<!-- Removed to publisher file 5/18/2020 -->
<!-- <xsl:param name="html.google-classic" select="''"/>
<xsl:param name="html.google-universal" select="'UA-66485406-1'"/>
<xsl:param name="html.google-search" select="'000445521324161818100:qhc2ahxtur8'"/> -->


<!-- Here are the options, taken from mathbook-html.xsl, changed as needed -->

<!-- Parameters -->
<!-- Parameters to pass via xsltproc "stringparam" on command-line            -->
<!-- Or make a thin customization layer and use 'select' to provide overrides -->
<!-- See more generally applicable parameters in mathbook-common.xsl file     -->

<!-- Content as Knowls -->
<!-- These parameters control if content is      -->
<!-- hidden in a knowl on first appearance       -->
<!-- The happens automatically sometimes,        -->
<!-- eg content of a footnote is always hidden   -->
<!-- Some things never are hidden,               -->
<!-- eg an entire section (too big),             -->
<!-- or a bibliographic item (pointless)         -->
<!-- These switches often control a whole group  -->
<!-- of similar items, for example the "theorem" -->
<!-- switch will similarly affect corrolaries,   -->
<!-- lemmas, etc - anything that can be proved   -->
<!-- NB: figures and tables inside of            -->
<!-- side-by-side panels are never born hidden,  -->
<!-- no matter how the switches below are set.   -->
<!-- You may elect to have entire side-by-side   -->
<!-- panels born as knowls, using the switch.    -->
<!-- PROJECT-LIKE gets own switch here           -->


<!-- CSS and Javascript Servers -->
<!-- <xsl:param name="html.css.colorfile" select="''" /> -->
<!-- <xsl:param name="debug.colorgs" select="'blue_grey'" /> -->
<!-- A space-separated list of CSS URLs (points to servers or local files) -->
<!-- <xsl:param name="html.css.extra"  select="'custom-styles.css style_oscarlevin.css'" /> -->

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
<!-- <xsl:param name="webwork.server" select="'https://webwork.pcc.edu'"/>
<xsl:param name="webwork.course" select="'anonymous'" />
<xsl:param name="webwork.userID" select="'anonymous'" />
<xsl:param name="webwork.password" select="'anonymous'" /> -->






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
                <span class="codenumber"><xsl:apply-templates select="parent::*" mode="number" /></span>
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

<!-- HTML, CSS -->
<!-- <xsl:template match="exercise" mode="environment-element">
    <xsl:text>article</xsl:text>
</xsl:template>
<xsl:template match="exercise" mode="environment-class">
    <xsl:text>exercise-like</xsl:text>
</xsl:template> -->

<!-- HACK 5/29/19: Remove codenumber and period from projects (Investigate!) -->
<!-- h6, type name, number (if exists), title (if exists) -->
<!-- REMARK-LIKE, COMPUTATION-LIKE, DEFINITION-LIKE, SOLUTION-LIKE, objectives (xref-content), outcomes (xref-content), EXAMPLE-LIKE, PROJECT-LIKE, exercise (inline), task (xref-content), fn (xref-content), biblio/note (xref-content)-->
<!-- E.g. Corollary 4.1 (Leibniz, Newton).  The fundamental theorem of calculus. -->
<xsl:template match="&PROJECT-LIKE;" mode="heading-full">
    <h6 class="heading">
        <span class="type">
            <xsl:apply-templates select="." mode="type-name"/>
        </span>
        <!--  -->
        <xsl:variable name="the-number">
            <xsl:apply-templates select="." mode="number" />
        </xsl:variable>
        <xsl:if test="not($the-number='')">
            <xsl:text> </xsl:text>
            <!-- <span class="codenumber">
                <xsl:value-of select="$the-number"/>
            </span> REMOVED -->
        </xsl:if>
        <!--  -->
        <xsl:if test="creator and (&THEOREM-FILTER; or &AXIOM-FILTER;)">
            <xsl:text> </xsl:text>
            <span class="creator">
                <xsl:text>(</xsl:text>
                <xsl:apply-templates select="." mode="creator-full"/>
                <xsl:text>)</xsl:text>
            </span>
        </xsl:if>
        <!-- A period now, no matter which of 4 combinations we have above-->
        <!-- <xsl:text>.</xsl:text> REMOVED -->
        <!-- A title carries its own punctuation -->
        <xsl:if test="title">
            <xsl:text> </xsl:text>
            <span class="title">
                <xsl:apply-templates select="." mode="title-full"/>
            </span>
        </xsl:if>
    </h6>
</xsl:template>

<!-- And its CSS class -->
<xsl:template match="&PROJECT-LIKE;" mode="body-css-class">
    <xsl:text>project-like</xsl:text>
</xsl:template>

<!-- Analytics Footers -->

<!-- Google Analytics                     -->
<!-- "Classic", not compared to Universal -->
<!-- <xsl:template match="google">
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
</xsl:template> -->



</xsl:stylesheet>
