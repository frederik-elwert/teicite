<xsl:stylesheet version="1.0"
  xmlns="http://purl.org/net/xbiblio/csl"
  xmlns:csl="http://purl.org/net/xbiblio/csl"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="xml" encoding="utf-8" />

  <!-- Identity template -->
  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

  <!-- Remove formatting -->
  <xsl:template match="@font-style|@font-variant|@font-weight|@text-decoration|@quotes" />

  <!-- Template to add tei annotations to @prefix and @suffix -->
  <xsl:template match="*" mode="annotate">
    <xsl:param name="tei_elem" />
    <xsl:param name="tei_attrs" />
    <xsl:attribute name="prefix">
      <xsl:value-of select="@prefix" />
      <xsl:text>{{tei}}&lt;</xsl:text>
      <xsl:value-of select="$tei_elem" />
      <xsl:if test="$tei_attrs">
        <xsl:text> </xsl:text>
        <xsl:value-of select="$tei_attrs" />
      </xsl:if>
      <xsl:text>&gt;{{/tei}}</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="suffix">
      <xsl:text>{{tei}}&lt;/</xsl:text>
      <xsl:value-of select="$tei_elem" />
      <xsl:text>&gt;{{/tei}}</xsl:text>
      <xsl:value-of select="@suffix" />
    </xsl:attribute>
  </xsl:template>

  <!-- Templates for individual variables -->
  <xsl:template match="csl:text[@variable='title'
                                or @variable='publisher']">
    <xsl:copy>
      <xsl:apply-templates select="." mode="annotate">
        <xsl:with-param name="tei_elem"><xsl:value-of select="@variable" /></xsl:with-param>
      </xsl:apply-templates>
      <xsl:apply-templates select="@*[not(name()='prefix') and not(name()='suffix')]|node()" />
    </xsl:copy>
  </xsl:template>

  <xsl:template match="csl:text[@variable='container-title']">
    <xsl:copy>
      <xsl:apply-templates select="." mode="annotate">
        <xsl:with-param name="tei_elem">title</xsl:with-param>
      </xsl:apply-templates>
      <xsl:apply-templates select="@*[not(name()='prefix') and not(name()='suffix')]|node()" />
    </xsl:copy>
  </xsl:template>

  <xsl:template match="csl:text[@variable='publisher-place']">
    <xsl:copy>
      <xsl:apply-templates select="." mode="annotate">
        <xsl:with-param name="tei_elem">pubPlace</xsl:with-param>
      </xsl:apply-templates>
      <xsl:apply-templates select="@*[not(name()='prefix') and not(name()='suffix')]|node()" />
    </xsl:copy>
  </xsl:template>

  <xsl:template match="csl:text[@variable='page']
                       |csl:text[@variable='volume'
                                   or @variable='issue']
                       |csl:number[@variable='volume'
                                   or @variable='issue']">
    <xsl:copy>
      <xsl:apply-templates select="." mode="annotate">
        <xsl:with-param name="tei_elem">biblScope</xsl:with-param>
        <xsl:with-param name="tei_attrs">unit=&quot;<xsl:value-of select="@variable" />&quot;</xsl:with-param>
      </xsl:apply-templates>
      <xsl:apply-templates select="@*[not(name()='prefix') and not(name()='suffix')]|node()" />
    </xsl:copy>
  </xsl:template>

  <xsl:template match="csl:date[not(csl:date-part)]">
    <xsl:copy>
      <xsl:apply-templates select="." mode="annotate">
        <xsl:with-param name="tei_elem">date</xsl:with-param>
      </xsl:apply-templates>
      <xsl:apply-templates select="@*[not(name()='prefix') and not(name()='suffix')]|node()" />
    </xsl:copy>
  </xsl:template>

  <xsl:template match="csl:date-part[@name='year']">
    <xsl:copy>
      <xsl:apply-templates select="." mode="annotate">
        <xsl:with-param name="tei_elem">date</xsl:with-param>
      </xsl:apply-templates>
      <xsl:apply-templates select="@*[not(name()='prefix') and not(name()='suffix')]|node()" />
    </xsl:copy>
  </xsl:template>

  <!-- Add names! -->
  <xsl:template match="csl:names[contains(concat(' ', @variable, ' '), ' author ')]
                       /csl:name[not(csl:name-part)]">
    <xsl:copy>
      <xsl:attribute name="prefix"><xsl:value-of select="@prefix" />{{tei}}&lt;author&gt;&lt;persName&gt;{{/tei}}</xsl:attribute>
      <xsl:attribute name="suffix">{{tei}}&lt;/persName&gt;&lt;/author&gt;{{/tei}}<xsl:value-of select="@suffix" /></xsl:attribute>
      <xsl:apply-templates select="@*" />
      <name-part name="given" prefix="{{{{tei}}}}&lt;forename&gt;{{{{/tei}}}}" suffix="{{{{tei}}}}&lt;/forename&gt;{{{{/tei}}}}" />
      <name-part name="family" prefix="{{{{tei}}}}&lt;surname&gt;{{{{/tei}}}}" suffix="{{{{tei}}}}&lt;/surname&gt;{{{{/tei}}}}" />
      <xsl:apply-templates />
    </xsl:copy>
  </xsl:template>

  <xsl:template match="csl:names[contains(concat(' ', @variable, ' '), ' editor ')]
                       /csl:name[not(csl:name-part)]">
    <xsl:copy>
      <xsl:attribute name="prefix"><xsl:value-of select="@prefix" />{{tei}}&lt;editor&gt;&lt;persName&gt;{{/tei}}</xsl:attribute>
      <xsl:attribute name="suffix">{{tei}}&lt;/persName&gt;&lt;/editor&gt;{{/tei}}<xsl:value-of select="@suffix" /></xsl:attribute>
      <xsl:apply-templates select="@*" />
      <name-part name="given" prefix="{{{{tei}}}}&lt;forename&gt;{{{{/tei}}}}" suffix="{{{{tei}}}}&lt;/forename&gt;{{{{/tei}}}}" />
      <name-part name="family" prefix="{{{{tei}}}}&lt;surname&gt;{{{{/tei}}}}" suffix="{{{{tei}}}}&lt;/surname&gt;{{{{/tei}}}}" />
      <xsl:apply-templates />
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>
