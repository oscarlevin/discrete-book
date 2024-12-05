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

<xsl:template match="divisionsolutions" mode="tcb-style">
    <xsl:text>
      enhanced,
      parbox=false,
      sharp corners,
      fonttitle=\bfseries\itshape\large,
      coltitle=black,
      attach boxed title to top left={xshift=5mm,yshift=-\tcboxedtitleheight/2-1mm,yshifttext=-2mm},
      title=Solution,
      boxed title style={frame hidden, colback=white, sharp corners},
      boxed title size=title,
      frame hidden,
      borderline={2pt}{0mm}{black},
      colback=white,
      bottom=5mm,
      after skip=2em,
    </xsl:text>
</xsl:template>


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

<xsl:template match="&ASIDE-LIKE;" mode="tcb-style">
    <xsl:text>
      runintitlestyle,
      enhanced, 
      frame hidden,
      parbox=false,
      borderline={1pt}{0mm}{black!10},
      borderline west={1pt}{0mm}{black!30},
      sharp corners, 
      colback=black!10, 
      coltitle=black, 
      top=2mm,
      title={By the way...},
      after title={\space}, 
      after skip=1em
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
    <xsl:text>bwminimalstyle, parbox=false, fonttitle=\normalfont\bfseries, attach title to upper, after title={\space\space}, after upper={\space\space\hspace*{\stretch{1}}\scshape qed}, center, width=.95\linewidth, after skip=1em&#xa;</xsl:text>
</xsl:template>


<!-- PROOF-LIKE (solutions, minor) -->
<!-- NOT a tcolorbox since embedded in others,      -->
<!-- hence an inner box and thus always unbreakable -->
<!-- Body:  \begin{solutionproof}                   -->
<!-- Really simple.  No label, so not a target of a -->
<!-- cross-reference.  Not stylable, though we      -->
<!-- could use a macro for the tombstone/Halmos/QED -->
<!-- so that could be set.                          -->
<xsl:template match="*[&PROOF-FILTER;][&SOLUTION-PROOF-FILTER;]" mode="environment">
    <xsl:text>\NewDocumentEnvironment{solution</xsl:text>
    <xsl:value-of select="local-name(.)"/>
    <xsl:text>}{m}&#xa;</xsl:text>
    <xsl:text>{\par\smallskip\noindent\textit{#1}.\space\space}{\space\space\hspace*{\stretch{1}}\scshape qed\par\smallskip}&#xa;</xsl:text>
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


<!-- %%%%%%%%%%%%%%%%%%% -->
<!-- Solutions numbering -->
<!-- %%%%%%%%%%%%%%%%%%% -->

<!-- <xsl:template match="book|article|part|chapter|appendix|section|subsection|subsubsection" mode="is-structured-division">
    <xsl:if test="chapter|section|subsection|subsubsection">
        <xsl:text></xsl:text>  -->
        <!-- removed "true", so now this should make all exercises think they are part of unstructured divisions -->
    <!-- </xsl:if>
  </xsl:template> -->


<!-- ####################################### -->
<!-- Solutions Divisions, Content Generation -->
<!-- ####################################### -->

<!-- The "division-in-solutions" modal template from -common   -->
<!-- calls the "duplicate-heading" modal template.             -->
<!-- Stacked headings are all \Large, regardless of which      -->
<!-- level of depth they reflect. This is consistent with      -->
<!-- treating stacked headings as a single "squashed" heading. -->

<xsl:template match="*" mode="duplicate-heading">
    <xsl:param name="heading-level"/>
    <xsl:param name="heading-stack" select="."/>
    <xsl:variable name="text-size">
        <xsl:call-template name="get-heading-text-size">
            <xsl:with-param name="heading-level" select="$heading-level"/>
        </xsl:call-template>
    </xsl:variable>
    <xsl:text>\par\medskip&#xa;\subsection*{</xsl:text>
    <xsl:value-of select="$text-size"/>
    <xsl:text>{}</xsl:text>
    <xsl:apply-templates select="$heading-stack" mode="duplicate-heading-content">
        <xsl:with-param name="heading-stack" select="$heading-stack"/>
    </xsl:apply-templates>
    <xsl:text>}&#xa;</xsl:text>
    <xsl:text>\par\medskip&#xa;</xsl:text>
</xsl:template>

<xsl:template match="*" mode="duplicate-heading-content">
    <xsl:param name="heading-stack"/>
    <xsl:variable name="is-specialized-division">
        <xsl:choose>
            <xsl:when test="self::task">
                <xsl:value-of select="false()"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates select="." mode="is-specialized-division"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    <xsl:variable name="is-child-of-structured">
        <xsl:choose>
            <xsl:when test="parent::*[&TRADITIONAL-DIVISION-FILTER;]">
                <xsl:apply-templates select="parent::*[&TRADITIONAL-DIVISION-FILTER;]" mode="is-structured-division"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="false()"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    <xsl:choose>
        <xsl:when test="count(descendant::*[count(.|$heading-stack) = count($heading-stack)]) > 0">
            <!-- <xsl:text>\textperiodcentered\space{}</xsl:text> -->
            <xsl:text>%skipping&#xa;</xsl:text>
        </xsl:when>
        <xsl:otherwise>
            <xsl:apply-templates select="." mode="structure-number" />
            <xsl:text>\space\textperiodcentered\space{}</xsl:text>
            <xsl:apply-templates select="." mode="title-full" />
        </xsl:otherwise>
    </xsl:choose>
    <!-- line break, but not on last -->
    <!-- <xsl:if >
        <xsl:text>\\&#xa;</xsl:text>
    </xsl:if> -->
</xsl:template>

<xsl:template name="get-heading-text-size">
    <xsl:param name="heading-level" select="6"/>
    <xsl:choose>
        <xsl:when test="$heading-level = 1">
            <xsl:text>\Huge</xsl:text>
        </xsl:when>
        <xsl:when test="$heading-level = 2">
            <xsl:text>\huge</xsl:text>
        </xsl:when>
        <xsl:when test="$heading-level = 3">
            <xsl:text>\large</xsl:text>
        </xsl:when>
        <xsl:when test="$heading-level = 4">
            <xsl:text>\large</xsl:text>
        </xsl:when>
        <xsl:when test="$heading-level = 5">
            <xsl:text>\normalsize</xsl:text>
        </xsl:when>
        <xsl:otherwise>
            <xsl:text>\normalsize</xsl:text>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>

<!-- And now for the individual exercises, but here we only make the number simpler. -->

<!-- Exercises and projects (as above) in solutions-->
<!-- Nothing produced if there is no content       -->
<!-- Otherwise, no label, since duplicate          -->
<!-- Different environment, with hard-coded number -->
<!-- Switches for solutions are generated          -->
<!-- elsewhere and always supplied in call         -->
<!-- NB: switches originate in solutions generator -->
<xsl:template match="exercise[boolean(&INLINE-EXERCISE-FILTER;)]|&PROJECT-LIKE;|exercises//exercise|worksheet//exercise|reading-questions//exercise" mode="solutions">
    <xsl:param name="purpose"/>
    <xsl:param name="admit"/>
    <xsl:param name="b-component-heading"/>
    <xsl:param name="b-has-statement" />
    <xsl:param name="b-has-hint"      />
    <xsl:param name="b-has-answer"    />
    <xsl:param name="b-has-solution"  />

    <!-- Subsetting, especially in the back matter can yield no content at all    -->
    <!-- Schema says there is always some sort of statement, explicit or implicit -->
    <!-- We frequently build collections of "dry-run" output to determine if a    -->
    <!-- collection of exercises (e.g. in an "exercisegroup") is empty or not.    -->
    <!-- So it is *critical* that we get zero output for an exercise that has     -->
    <!-- no content due to settings of switches.                                  -->

     <xsl:variable name="dry-run">
        <xsl:apply-templates select="." mode="dry-run">
            <xsl:with-param name="admit" select="$admit"/>
            <xsl:with-param name="b-has-statement" select="$b-has-statement" />
            <xsl:with-param name="b-has-hint"      select="$b-has-hint" />
            <xsl:with-param name="b-has-answer"    select="$b-has-answer" />
            <xsl:with-param name="b-has-solution"  select="$b-has-solution" />
        </xsl:apply-templates>
    </xsl:variable>

    <xsl:if test="not($dry-run = '')">
        <!-- no project-like prelude, as duplicating in solutions division -->
        <!-- The exact environment depends on the placement of the -->
        <!-- "exercise" when located in an "exercises" division    -->
        <xsl:variable name="env-name">
            <xsl:apply-templates select="." mode="solutions-environment-name"/>
        </xsl:variable>
        <xsl:text>\begin{</xsl:text>
        <xsl:value-of select="$env-name"/>
        <xsl:text>}</xsl:text>
        <!-- Always supply a type-name, even if the     -->
        <!-- receiving environment does not utilize it. -->
        <!-- Five categories, four are "exercise".      -->
        <xsl:text>{</xsl:text>
        <xsl:choose>
            <!--divisional exercise -->
            <xsl:when test="self::exercise and ancestor::exercises">
                <xsl:apply-templates select="." mode="type-name">
                    <xsl:with-param name="string-id" select="'divisionalexercise'"/>
                </xsl:apply-templates>
            </xsl:when>
            <!-- worksheet exercise -->
            <xsl:when test="self::exercise and ancestor::worksheet">
                <xsl:apply-templates select="." mode="type-name">
                    <xsl:with-param name="string-id" select="'worksheetexercise'"/>
                </xsl:apply-templates>
            </xsl:when>
            <!-- reading question -->
            <xsl:when test="self::exercise and ancestor::reading-questions">
                <xsl:apply-templates select="." mode="type-name">
                    <xsl:with-param name="string-id" select="'readingquestion'"/>
                </xsl:apply-templates>
            </xsl:when>
            <!-- inline exercise ("Checkpoint") by elimination -->
            <xsl:when test="self::exercise">
                <xsl:apply-templates select="." mode="type-name">
                    <xsl:with-param name="string-id" select="'inlineexercise'"/>
                </xsl:apply-templates>
            </xsl:when>
            <!-- now PROJECT-LIKE by elimination, don't need $string-id -->
            <xsl:otherwise>
                <xsl:apply-templates select="." mode="type-name"/>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:text>}</xsl:text>
        <!-- Always a hard-coded full number, never any workspace -->
        <!-- indication, so unified across the four types         -->
        <xsl:text>{</xsl:text>
        <!-- EDIT!  we change this to be just the serial number -->
        <xsl:apply-templates select="." mode="serial-number" />
        <xsl:text>}</xsl:text>
        <xsl:text>{</xsl:text>
        <xsl:apply-templates select="." mode="title-full"/>
        <xsl:text>}</xsl:text>
        <!-- label of the exercise, to link back to it -->
        <xsl:text>{</xsl:text>
        <xsl:apply-templates select="." mode="unique-id"/>
        <xsl:text>}</xsl:text>
        <xsl:text>%&#xa;</xsl:text>
        <!-- Now the guts of the exercise, inside of its  -->
        <!-- (variable) identification, environment, etc. -->
        <!-- NB: this is where we say goodbye to the      -->
        <!-- "solutions" modal templates and switch to    -->
        <!-- the "exercise-components"templates with the  -->
        <!-- $b-original flag.                            -->
        <xsl:apply-templates select="." mode="exercise-components">
            <xsl:with-param name="b-original" select="false()" />
            <xsl:with-param name="purpose" select="$purpose" />
            <xsl:with-param name="b-component-heading" select="$b-component-heading"/>
            <xsl:with-param name="b-has-statement" select="$b-has-statement" />
            <xsl:with-param name="b-has-hint"      select="$b-has-hint" />
            <xsl:with-param name="b-has-answer"    select="$b-has-answer" />
            <xsl:with-param name="b-has-solution"  select="$b-has-solution" />
        </xsl:apply-templates>
        <!-- closing % necessary, as newline between adjacent environments -->
        <!-- will cause a slight indent on trailing exercise               -->
        <xsl:text>\end{</xsl:text>
        <xsl:value-of select="$env-name"/>
        <xsl:text>}%&#xa;</xsl:text>
        <!-- no project-like postlude, as duplicating in solutions division -->
    </xsl:if>
</xsl:template>

</xsl:stylesheet>
