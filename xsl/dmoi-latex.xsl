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
<xsl:param name="latex.font.size" select="'11pt'" />
<!--  -->
<!-- Geometry: page shape, margins, etc            -->
<!-- Pass a string with any of geometry's options  -->
<!-- Default is empty and thus ineffective         -->
<!-- Otherwise, happens early in preamble template -->
<xsl:param name="latex.geometry" select="'papersize={7in,10in}, width=4.85in, inner=1in, height=8.5in, top=0.75in, twoside, ignoreheadfoot'"/>
<!-- papersize={7in,10in},  width=5in, inner=.75in, height=8.25in, top=0.75in, twoside, ignoreheadfoot, hmargin={0.85in, 0.5in}, -->
<!--  -->
<!-- PDF Watermarking                    -->
<!-- Non-empty string makes it happen    -->
<!-- Scale works well for "CONFIDENTIAL" -->
<!-- or  for "DRAFT YYYY/MM/DD"          -->
<xsl:param name="watermark.text" select="''"/>
<xsl:param name="watermark.scale" select="2.0"/>
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
<!-- Sidedness -->
<xsl:param name="latex.sides" select="'two'"/>
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
<xsl:param name="webwork.server.latex" select="''" />






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
  <xsl:text>%This should load all the style information that ptx does not.&#xa;</xsl:text>
    <xsl:text>\input{latex-preamble-styles}&#xa;</xsl:text>
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
<xsl:template match="paragraphs" mode="environment">
    <xsl:text>%% paragraphs: the terminal, pseudo-division&#xa;</xsl:text>
    <xsl:text>%% We use the lowest LaTeX traditional division&#xa;</xsl:text>
    <xsl:text>\titleformat{\subparagraph}[block]{\normalfont\filcenter\scshape\bfseries}{\thesubparagraph}{0em}{#1}&#xa;</xsl:text>
    <xsl:text>\titlespacing*{\subparagraph}{0pt}{3.25ex plus 1ex minus .2ex}{1ex}&#xa;</xsl:text>
    <xsl:text>\NewDocumentEnvironment{paragraphs}{mm}&#xa;</xsl:text>
    <xsl:text>{\subparagraph*{#1}\hypertarget{#2}{}}{}&#xa;</xsl:text>
</xsl:template>
<!-- Paragraphs -->
<!-- Non-structural, even if they appear to be -->
<xsl:template match="paragraphs">
    <!-- Warn about paragraph deprecation -->
    <xsl:text>\begin{paragraphs}</xsl:text>
    <xsl:text>{</xsl:text>
    <!-- Get rid of punctuation: (change title-punctuated to title-full) -->
    <xsl:apply-templates select="." mode="title-full" />
    <xsl:text>}</xsl:text>
    <xsl:text>{</xsl:text>
    <xsl:apply-templates select="." mode="latex-id" />
    <xsl:text>}</xsl:text>
    <xsl:text>%&#xa;</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>\end{paragraphs}%&#xa;</xsl:text>
</xsl:template>


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
<xsl:template match="proof" mode="tcb-style">
    <xsl:text>bwminimalstyle, fonttitle=\normalfont\itshape, attach title to upper, after title={\space}, after upper={\space\space\hspace*{\stretch{1}}\(\textsc{qed}\)}&#xa;</xsl:text>
</xsl:template>


<!-- HACK (12/21/18): Set up titles for divisions in solutions: -->
<!-- ####################################### -->
<!-- Solutions Divisions, Content Generation -->
<!-- ####################################### -->

<!-- We pass in the "scope", which will be a traditional division   -->
<!-- and then can create an appropriate size for a heading (without -->
<!-- needing to deal with specialized divisions possibly appearing  -->
<!-- at most any level).                                            -->
<!-- TODO: this could be an xparse environment, perhaps -->
<!-- with a key indicating fontsize or division level   -->
<xsl:template match="exercises" mode="division-in-solutions">
    <xsl:param name="scope" />
    <xsl:param name="content" />

    <!-- LaTeX heading, possibly with hard-coded number -->
    <xsl:text>\vskip 2ex \centerline{\bfseries\scshape\large </xsl:text>
    <!-- <xsl:value-of select="$font-size" /> -->
    <!-- A structured division has numbered subdivisions              -->
    <!-- Otherwise "exercises" do not display their number at "birth" -->
        <xsl:apply-templates select="parent::*" mode="number" />
        <xsl:text>\space{} </xsl:text>
    <xsl:apply-templates select="." mode="title-full" />
    <xsl:text>}&#xa;\par\smallskip&#xa;</xsl:text>

    <xsl:copy-of select="$content" />
</xsl:template>
<!-- Everything else is empty -->
<xsl:template match="chapter|section|subsection|subsubsection|worksheet|reading-questions" mode="division-in-solutions">
</xsl:template>


<!-- HACK (12/21/18): Fix up backmatter to not type "solution" before every solution.  Also remove introduction/conclusion from webwork, since that's not how I used those. -->
<!-- Divisional Exercises (exercises//exercise, etc) in solutions-->
<!-- Nothing produced if there is no content -->
<!-- Otherwise, no label, since duplicate    -->
<!-- Switches for solutions are generated    -->
<!-- elsewhere and always supplied in call   -->
<xsl:template match="exercises//exercise|worksheet//exercise|reading-questions//exercise" mode="solutions">
    <xsl:param name="purpose"/>
    <xsl:param name="b-has-statement" />
    <xsl:param name="b-has-hint" />
    <xsl:param name="b-has-answer" />
    <xsl:param name="b-has-solution" />

    <!-- Subsetting, especially in the back matter can yield no content at all    -->
    <!-- Schema says there is always some sort of statement, explicit or implicit -->
    <!-- We frequently build collections of "dry-run" output to determine if a    -->
    <!-- collection of exercises (e.g. in an "exercisegroup") is empty or not.    -->
    <!-- So it is *critical* that we get zero output for an exercise that has     -->
    <!-- no content due to settings of switches.                                  -->
    <!-- When we subset exercises for solutions, an entire      -->
    <!-- "exercisegroup" can become empty.  So we do a dry-run  -->
    <!-- and if there is no content at all we bail out.         -->

     <xsl:variable name="dry-run">
        <xsl:apply-templates select="." mode="dry-run">
            <xsl:with-param name="b-has-statement" select="$b-has-statement" />
            <xsl:with-param name="b-has-hint"      select="$b-has-hint" />
            <xsl:with-param name="b-has-answer"    select="$b-has-answer" />
            <xsl:with-param name="b-has-solution"  select="$b-has-solution" />
        </xsl:apply-templates>
    </xsl:variable>
    <!-- <xsl:variable name="nonempty" select="$b-has-statement or ($b-has-hint and hint) or ($b-has-answer and answer) or ($b-has-solution and solution)" /> -->

    <xsl:if test="not($dry-run = '')">
        <!-- Using fully-qualified number in solution lists -->
        <xsl:variable name="env-name">
            <xsl:text>divisionsolution</xsl:text>
            <xsl:if test="ancestor::exercisegroup">
                <xsl:text>eg</xsl:text>
            </xsl:if>
            <xsl:if test="ancestor::exercisegroup/@cols">
                <xsl:text>col</xsl:text>
            </xsl:if>
        </xsl:variable>
        <xsl:text>\begin{</xsl:text>
        <xsl:value-of select="$env-name"/>
        <xsl:text>}</xsl:text>
        <xsl:text>{</xsl:text>
        <xsl:apply-templates select="." mode="number" />
        <xsl:text>}</xsl:text>
        <xsl:text>{</xsl:text>
        <!-- <xsl:apply-templates select="." mode="title-punctuated"/> -->
        <!-- Line above commented out to remove title -->
        <xsl:text>}</xsl:text>
        <!-- label of the exercise, to link back to it -->
        <xsl:text>{</xsl:text>
        <xsl:apply-templates select="." mode="latex-id"/>
        <xsl:text>}</xsl:text>
        <!-- no workspace fraction in a solution -->
        <xsl:text>%&#xa;</xsl:text>
        <!-- Allow a webwork or myopenmath exercise to introduce/connect    -->
        <!-- a problem (especially from server) to the text in various ways -->
        <!-- <xsl:if test="webwork-reps|myopenmath">
            <xsl:apply-templates select="introduction"/>
        </xsl:if> -->
        <!-- condition on how statement, hint, answer, solution are presented -->
        <xsl:choose>
            <!-- webwork, structured with "stage" matches first -->
            <xsl:when test="webwork-reps/static/stage">
                <!-- Needs this fix, but requires more care                                              -->
                <!-- <xsl:apply-templates select="webwork-reps/static/stage" mode="exercise-components"> -->
                <xsl:apply-templates select="webwork-reps/static/stage">
                    <xsl:with-param name="b-original" select="false()" />
                    <xsl:with-param name="purpose" select="$purpose" />
                    <xsl:with-param name="b-has-statement" select="$b-has-statement" />
                    <xsl:with-param name="b-has-hint"      select="$b-has-hint" />
                    <!-- 2018-09-21: WW answers may become available -->
                    <xsl:with-param name="b-has-answer"    select="$b-has-answer" />
                    <xsl:with-param name="b-has-solution"  select="$b-has-solution" />
                </xsl:apply-templates>
            </xsl:when>
            <!-- webwork exercise, no "stage" -->
            <xsl:when test="webwork-reps/static">
                <xsl:apply-templates select="webwork-reps/static" mode="exercise-components">
                    <xsl:with-param name="b-original" select="false()" />
                    <xsl:with-param name="purpose" select="$purpose" />
                    <xsl:with-param name="b-has-statement" select="$b-has-statement" />
                    <xsl:with-param name="b-has-hint"      select="$b-has-hint" />
                    <!-- 2018-09-21: WW answers may become available -->
                    <xsl:with-param name="b-has-answer"    select="$b-has-answer" />
                    <xsl:with-param name="b-has-solution"  select="$b-has-solution" />
                </xsl:apply-templates>
            </xsl:when>
            <!-- myopenmath exercise -->
            <!-- We only try to open an external file when the source  -->
            <!-- has a MOM problem (with an id number).  The second    -->
            <!-- argument of the "document()" function is a node and   -->
            <!-- causes the relative file name to resolve according    -->
            <!-- to the location of the XML.   Experiments with the    -->
            <!-- empty node "/.." are interesting.                     -->
            <!-- https://ajwelch.blogspot.co.za/2008/04/relative-paths-and-document-function.html -->
            <!-- http://www.dpawson.co.uk/xsl/sect2/N2602.html#d3862e73 (Point 4) -->
            <xsl:when test="myopenmath">
                <xsl:variable name="filename" select="concat(concat('problems/mom-', myopenmath/@problem), '.xml')" />
                <xsl:apply-templates select="document($filename, .)/myopenmath"  mode="exercise-components">
                    <xsl:with-param name="b-original" select="false()" />
                    <xsl:with-param name="purpose" select="$purpose" />
                    <xsl:with-param name="b-has-statement" select="$b-has-statement" />
                    <xsl:with-param name="b-has-hint"      select="false()" />
                    <xsl:with-param name="b-has-answer"    select="false()" />
                    <xsl:with-param name="b-has-solution"  select="$b-has-solution" />
                </xsl:apply-templates>
            </xsl:when>
            <!-- "normal" exercise -->
            <xsl:otherwise>
                <xsl:apply-templates select="." mode="exercise-components">
                    <xsl:with-param name="b-original" select="false()" />
                    <xsl:with-param name="purpose" select="$purpose" />
                    <xsl:with-param name="b-has-statement" select="$b-has-statement" />
                    <xsl:with-param name="b-has-hint"      select="$b-has-hint" />
                    <xsl:with-param name="b-has-answer"    select="$b-has-answer" />
                    <xsl:with-param name="b-has-solution"  select="$b-has-solution" />
                </xsl:apply-templates>
            </xsl:otherwise>
        </xsl:choose>
        <!-- Allow a webwork or myopenmath exercise to conclude/connect     -->
        <!-- a problem (especially from server) to the text in various ways -->
        <!-- <xsl:if test="webwork-reps|myopenmath">
            <xsl:apply-templates select="conclusion"/>
        </xsl:if> -->
        <!-- closing % necessary, as newline between adjacent environments -->
        <!-- will cause a slight indent on trailing exercise               -->
        <xsl:text>\end{</xsl:text>
        <xsl:value-of select="$env-name"/>
        <xsl:text>}%&#xa;</xsl:text>
    </xsl:if>
</xsl:template>

<!-- Here is where we remove the solution heading. Note that this only works because I have chosen to put different types of solutions (hints vs solutions) in different solutions envs. -->
<!-- Each component has a similar look, so we combine here -->
<!-- Separators depend on possible trailing items, so no   -->
<!-- vertical spacing beforehand is present here           -->
<xsl:template match="hint|answer|solution" mode="solution-heading">
    <xsl:param name="b-original" select="true()" />
    <xsl:param name="purpose" />


    <!-- if original, label in the usual ways  -->
    <!-- if duplicate, use extraordinary label -->
    <xsl:choose>
        <!-- a solution right where the exercise is born -->
        <xsl:when test="$b-original">
          <xsl:text>\textbf{</xsl:text>
          <xsl:apply-templates select="." mode="type-name" />
          <xsl:text>}</xsl:text> <!-- end bold number -->
          <xsl:text>.</xsl:text>
            <xsl:apply-templates select="." mode="label"/>
        </xsl:when>
            <!-- Finally, the purpose of $purpose.  We know if this  -->
            <!-- solution is being displayed in the main matter or   -->
            <!-- in the back matter, so we can provide the correct   -->
            <!-- suffix to the label.                                -->
        <xsl:when test="$purpose = 'mainmatter'">
            <xsl:text>\hypertarget{</xsl:text>
            <xsl:apply-templates select="." mode="latex-id-duplicate">
                <xsl:with-param name="suffix" select="'main'"/>
            </xsl:apply-templates>
            <xsl:text>}</xsl:text>
        </xsl:when>
        <xsl:when test="$purpose = 'backmatter'">
            <xsl:text>\hypertarget{</xsl:text>
            <xsl:apply-templates select="." mode="latex-id-duplicate">
                <xsl:with-param name="suffix" select="'back'"/>
            </xsl:apply-templates>
            <xsl:text>}</xsl:text>
        </xsl:when>
        <!-- linking not enabled for PDF solution manual -->
        <xsl:when test="$purpose = 'solutionmanual'" />
        <!-- born (original=true), or mainmatter, or backmatter, or solutionmanual -->
        <xsl:otherwise>
            <xsl:message>PTX:BUG:     Exercise component mis-labeled</xsl:message>
        </xsl:otherwise>
    </xsl:choose>
    <!-- some distance to actual content -->
    <xsl:text>~~%&#xa;</xsl:text>
</xsl:template>



<!-- HACK 3-23-19: make numbers links to hints or solutions (with hints getting precidence). -->
<!-- Divisional Exercises (exercises//exercise, worksheet//exercise, etc) -->
<!-- Divisional exercises are not named when born, by virtue -->
<!-- of being within an "exercises" division.  We hard-code  -->
<!-- their numbers to allow for flexibility, and since it is -->
<!-- too hard (impossible?) to mesh into LaTeX's scheme.  An -->
<!-- "exercises" may be divided by a future "subexercises"   -->
<!-- and/or by an "exercisegroup", so we match with "//"     -->
<xsl:template match="exercises//exercise|worksheet//exercise|reading-questions//exercise">
    <!-- There are three sets of switches, so we build a single set, -->
    <!-- depending on what type of division the "exercise" lives in. -->
    <!-- For each, exactly one "ancestor" is true, and then the      -->
    <!-- expression will evaluate to the corresponding global switch -->
    <xsl:variable name="b-has-statement" select="true()"/>
    <xsl:variable name="b-has-hint"
        select="(ancestor::exercises and $b-has-divisional-hint) or
                (ancestor::worksheet and $b-has-worksheet-hint)  or
                (ancestor::reading-questions and $b-has-reading-hint)"/>
    <xsl:variable name="b-has-answer"
        select="(ancestor::exercises and $b-has-divisional-answer) or
                (ancestor::worksheet and $b-has-worksheet-answer)  or
                (ancestor::reading-questions and $b-has-reading-answer)"/>
    <xsl:variable name="b-has-solution"
        select="(ancestor::exercises and $b-has-divisional-solution) or
                (ancestor::worksheet and $b-has-worksheet-solution)  or
                (ancestor::reading-questions and $b-has-reading-solution)"/>
    <!-- The exact environment depends on the placement of the -->
    <!-- "exercise" when located in an "exercises" division    -->
    <xsl:variable name="env-name">
        <xsl:text>divisionexercise</xsl:text>
        <xsl:if test="ancestor::exercisegroup">
            <xsl:text>eg</xsl:text>
        </xsl:if>
        <xsl:if test="ancestor::exercisegroup/@cols">
            <xsl:text>col</xsl:text>
        </xsl:if>
    </xsl:variable>
    <xsl:text>\begin{</xsl:text>
    <xsl:value-of select="$env-name"/>
    <xsl:text>}</xsl:text>
    <xsl:text>{</xsl:text>
    <!--OL: Replace original serial-number with following choose: -->
    <xsl:choose>
        <xsl:when test="hint">
          <xsl:text>\hyperlink{</xsl:text>
          <xsl:apply-templates select="hint[1]" mode="latex-id-duplicate">
              <xsl:with-param name="suffix" select="'back'"/>
          </xsl:apply-templates>
          <xsl:text>}{</xsl:text>
          <xsl:apply-templates select="." mode="serial-number" />
          <xsl:text>}</xsl:text>
        </xsl:when>
        <xsl:when test="webwork-reps/static/hint">
          <xsl:text>\hyperlink{</xsl:text>
          <xsl:apply-templates select="webwork-reps/static/hint[1]" mode="latex-id-duplicate">
              <xsl:with-param name="suffix" select="'back'"/>
          </xsl:apply-templates>
          <xsl:text>}{</xsl:text>
          <xsl:apply-templates select="." mode="serial-number" />
          <xsl:text>}</xsl:text>
        </xsl:when>
        <xsl:when test="solution">
          <xsl:text>\hyperlink{</xsl:text>
          <xsl:apply-templates select="solution[1]" mode="latex-id-duplicate">
              <xsl:with-param name="suffix" select="'back'"/>
          </xsl:apply-templates>
          <xsl:text>}{</xsl:text>
          <xsl:apply-templates select="." mode="serial-number" />
          <xsl:text>}</xsl:text>
        </xsl:when>
        <xsl:when test="webwork-reps/static/solution">
          <xsl:text>\hyperlink{</xsl:text>
          <xsl:apply-templates select="webwork-reps/static/solution[1]" mode="latex-id-duplicate">
              <xsl:with-param name="suffix" select="'back'"/>
          </xsl:apply-templates>
          <xsl:text>}{</xsl:text>
          <xsl:apply-templates select="." mode="serial-number" />
          <xsl:text>}</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates select="." mode="serial-number" />
        </xsl:otherwise>
    </xsl:choose>
    <xsl:text>}</xsl:text>
    <xsl:text>{</xsl:text>
    <xsl:apply-templates select="." mode="title-full"/>
    <xsl:text>}</xsl:text>
    <!-- workspace fraction, only if given, else blank -->
    <!-- worksheets only now, eventually exams?        -->
    <xsl:text>{</xsl:text>
    <xsl:if test="ancestor::worksheet and @workspace">
        <xsl:value-of select="substring-before(@workspace,'%') div 100" />
    </xsl:if>
    <xsl:text>}</xsl:text>
    <xsl:text>{</xsl:text>
    <xsl:apply-templates select="." mode="latex-id"/>
    <xsl:text>}</xsl:text>
    <xsl:text>%&#xa;</xsl:text>
    <!-- Allow a webwork or myopenmath exercise to introduce/connect    -->
    <!-- a problem (especially from server) to the text in various ways -->
    <xsl:if test="webwork-reps|myopenmath">
        <xsl:apply-templates select="introduction"/>
    </xsl:if>
    <!-- condition on how statement, hint, answer, solution are presented -->
    <xsl:choose>
        <!-- webwork, structured with "stage" matches first -->
        <!-- Above provides infrastructure for the exercise, -->
        <!-- we pass the stage on to a WW-specific template  -->
        <!-- since each stage may have hints, answers, and   -->
        <!-- solutions.                                      -->
        <xsl:when test="webwork-reps/static/stage">
            <xsl:apply-templates select="webwork-reps/static/stage">
                <xsl:with-param name="b-original" select="true()" />
                <xsl:with-param name="b-has-statement" select="$b-has-statement" />
                <xsl:with-param name="b-has-hint"      select="$b-has-hint" />
                <xsl:with-param name="b-has-answer"    select="$b-has-answer" />
                <xsl:with-param name="b-has-solution"  select="$b-has-solution" />
            </xsl:apply-templates>
        </xsl:when>
        <!-- webwork exercise, no "stage" -->
        <xsl:when test="webwork-reps/static">
            <xsl:apply-templates select="webwork-reps/static" mode="exercise-components">
                <xsl:with-param name="b-original" select="true()" />
                <xsl:with-param name="b-has-statement" select="$b-has-statement" />
                <xsl:with-param name="b-has-hint"      select="$b-has-hint" />
                <!-- 2018-09-21: WW answers may become available -->
                <xsl:with-param name="b-has-answer"    select="$b-has-answer" />
                <xsl:with-param name="b-has-solution"  select="$b-has-solution" />
            </xsl:apply-templates>
        </xsl:when>
        <!-- myopenmath exercise -->
        <!-- We only try to open an external file when the source  -->
        <!-- has a MOM problem (with an id number).  The second    -->
        <!-- argument of the "document()" function is a node and   -->
        <!-- causes the relative file name to resolve according    -->
        <!-- to the location of the XML.   Experiments with the    -->
        <!-- empty node "/.." are interesting.                     -->
        <!-- https://ajwelch.blogspot.co.za/2008/04/relative-paths-and-document-function.html -->
        <!-- http://www.dpawson.co.uk/xsl/sect2/N2602.html#d3862e73 (Point 4) -->
        <xsl:when test="myopenmath">
            <xsl:variable name="filename" select="concat(concat('problems/mom-', myopenmath/@problem), '.xml')" />
            <xsl:apply-templates select="document($filename, .)/myopenmath"  mode="exercise-components">
                <xsl:with-param name="b-original" select="true()" />
                <xsl:with-param name="b-has-statement" select="$b-has-statement" />
                <xsl:with-param name="b-has-hint"      select="false()" />
                <xsl:with-param name="b-has-answer"    select="false()" />
                <xsl:with-param name="b-has-solution"  select="$b-has-solution" />
            </xsl:apply-templates>
        </xsl:when>
        <!-- "normal" exercise -->
        <xsl:otherwise>
            <xsl:apply-templates select="." mode="exercise-components">
                <xsl:with-param name="b-original" select="true()" />
                <xsl:with-param name="b-has-statement" select="$b-has-statement" />
                <xsl:with-param name="b-has-hint"      select="$b-has-hint" />
                <xsl:with-param name="b-has-answer"    select="$b-has-answer" />
                <xsl:with-param name="b-has-solution"  select="$b-has-solution" />
            </xsl:apply-templates>
        </xsl:otherwise>
    </xsl:choose>
    <!-- Allow a webwork or myopenmath exercise to conclude/connect     -->
    <!-- a problem (especially from server) to the text in various ways -->
    <xsl:if test="webwork-reps|myopenmath">
        <xsl:apply-templates select="conclusion"/>
    </xsl:if>
    <!-- closing % necessary, as newline between adjacent environments -->
    <!-- will cause a slight indent on trailing exercise               -->
    <xsl:text>\end{</xsl:text>
    <xsl:value-of select="$env-name"/>
    <xsl:text>}%&#xa;</xsl:text>
    <xsl:apply-templates select="." mode="pop-footnote-text"/>
</xsl:template>





<!-- HACK 12-21-18: Improve style of forward links to solutions: -->
<xsl:template match="exercise|webwork-reps/static|webwork-reps/static/stage|myopenmath|&EXAMPLE-LIKE;|&PROJECT-LIKE;|task" mode="exercise-components">
    <xsl:param name="b-original" />
    <xsl:param name="purpose" />
    <xsl:param name="b-has-statement" />
    <xsl:param name="b-has-hint" />
    <xsl:param name="b-has-answer"  />
    <xsl:param name="b-has-solution"  />

    <!-- structured (with components) versus unstructured (simply a bare statement) -->
    <xsl:choose>
        <xsl:when test="statement">
            <xsl:if test="$b-has-statement">
                <xsl:apply-templates select="statement">
                    <xsl:with-param name="b-original" select="$b-original" />
                </xsl:apply-templates>
                <xsl:if test="$b-original and ($debug.exercises.forward = 'yes')">
                    <!-- if several, all exist together, so just work with first one -->
                    <xsl:for-each select="hint[1]|answer[1]|solution[1]">
                        <!-- closer is better, so mainmatter solutions first -->
                        <xsl:choose>
                            <xsl:when test="count(.|$solutions-mainmatter) = count($solutions-mainmatter)">
                                <xsl:text>\hfill{\tiny</xsl:text>
                                <xsl:text>\hyperlink{</xsl:text>
                                <xsl:apply-templates select="." mode="latex-id-duplicate">
                                    <xsl:with-param name="suffix" select="'main'"/>
                                </xsl:apply-templates>
                                <xsl:text>}{[</xsl:text>
                                <xsl:apply-templates select="." mode="type-name"/>
                                <xsl:text>]}}&#xa;</xsl:text>
                            </xsl:when>
                            <xsl:when test="count(.|$solutions-backmatter) = count($solutions-backmatter)">
                                <xsl:text>\hfill{\tiny</xsl:text>
                                <xsl:text>\hyperlink{</xsl:text>
                                <xsl:apply-templates select="." mode="latex-id-duplicate">
                                    <xsl:with-param name="suffix" select="'back'"/>
                                </xsl:apply-templates>
                                <xsl:text>}{[</xsl:text>
                                <xsl:apply-templates select="." mode="type-name"/>
                                <xsl:text>]}}&#xa;</xsl:text>
                            </xsl:when>
                        </xsl:choose>
                    </xsl:for-each>
                </xsl:if>
                <xsl:if test="(hint and $b-has-hint) or (answer and $b-has-answer) or (solution and $b-has-solution)">
                    <xsl:call-template name="exercise-component-separator" />
                </xsl:if>
            </xsl:if>
            <xsl:if test="$b-has-hint">
                <xsl:apply-templates select="hint">
                    <xsl:with-param name="b-original" select="$b-original" />
                    <xsl:with-param name="purpose" select="$purpose" />
                    <xsl:with-param name="b-has-answer" select="$b-has-answer" />
                    <xsl:with-param name="b-has-solution" select="$b-has-solution" />
                </xsl:apply-templates>
            </xsl:if>
            <xsl:if test="$b-has-answer">
                <xsl:apply-templates select="answer">
                    <xsl:with-param name="b-original" select="$b-original" />
                    <xsl:with-param name="purpose" select="$purpose" />
                    <xsl:with-param name="b-has-solution" select="$b-has-solution" />
                </xsl:apply-templates>
            </xsl:if>
            <xsl:if test="$b-has-solution">
                <xsl:apply-templates select="solution">
                    <xsl:with-param name="b-original" select="$b-original" />
                    <xsl:with-param name="purpose" select="$purpose" />
                </xsl:apply-templates>
            </xsl:if>
        </xsl:when>
        <xsl:otherwise>
            <!-- no explicit "statement", so all content is the statement -->
            <xsl:if test="$b-has-statement">
                <xsl:apply-templates select="*">
                    <xsl:with-param name="b-original" select="$b-original" />
                </xsl:apply-templates>
                <!-- no separator, since no trailing components -->
            </xsl:if>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>

</xsl:stylesheet>
