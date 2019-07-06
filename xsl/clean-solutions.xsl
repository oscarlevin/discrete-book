<?xml version='1.0'?>

<!-- This file is part of the book                 -->
<!--                                               -->
<!--   Discrete Mathematics: an Open Introduction  -->
<!--                                               -->
<!-- Copyright (C) 2015-2018 Oscar Levin           -->
<!-- See the file COPYING for copying conditions.  -->

<!-- This will remove any elements marked as for instructors from an xml file -->

<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
    exclude-result-prefixes="xsl">

<xsl:output method="xml" encoding="UTF-8" />

<!-- match and copy everything -->
<xsl:template match="node() | @*">
  <xsl:copy>
      <xsl:apply-templates select="node() | @*"/>
  </xsl:copy>
</xsl:template>

<!-- override copy of solutions with category instructor -->
<xsl:template match="solution[@c='i']"/>

</xsl:stylesheet>
