<xsl:stylesheet version="1.0"
  xmlns="http://www.tei-c.org/ns/1.0"
  xmlns:tei="http://www.tei-c.org/ns/1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  exclude-result-prefixes="tei">

  <xsl:output method="xml" encoding="utf-8" />

  <!-- Identity template -->
  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

  <!-- Create listBibl/bibl from div/p -->
  <xsl:template match="tei:div[@xml:id='bibliography']">
    <listBibl>
      <xsl:apply-templates select="@*|node()" />
    </listBibl>
  </xsl:template>

  <xsl:template match="tei:div[@xml:id='bibliography']/tei:p">
    <bibl>
      <xsl:apply-templates select="@*|node()" />
    </bibl>
  </xsl:template>

</xsl:stylesheet>
