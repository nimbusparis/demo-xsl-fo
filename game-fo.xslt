<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:fo="http://www.w3.org/1999/XSL/Format"

  version="1.0">
  
  <xsl:output method="xml" encoding="UTF-8" indent="yes" />
  <xsl:param name="cols">2</xsl:param>

  <xsl:template name="date">
    <xsl:param name="date-time"/>
    <xsl:param name="date" select="substring-before($date-time,'T')"/>
    <xsl:param name="year" select="substring-before($date,'-')"/>
    <xsl:param name="month" 
          select="substring-before(substring-after($date,'-'),'-')"/>
    <xsl:param name="day" select="substring-after(substring-after($date,'-'),'-')"/>
    <xsl:value-of select="$day"/>/<xsl:value-of select="$month"/>/<xsl:value-of select="$year"/>
  </xsl:template>   
  <xsl:template name="time">
    <xsl:param name="date-time"/>
    <xsl:param name="time" select="substring-after($date-time,'T')"/>
    <xsl:value-of select="$time"></xsl:value-of>
  </xsl:template> 
  <xsl:template match="//Game">

    <fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
      <fo:layout-master-set>
        <fo:simple-page-master master-name="simple"
                      page-height="29.7cm"
                      page-width="21cm"
                      margin-top="1cm"
                      margin-bottom="2cm"
                      margin-left="2.5cm"
                      margin-right="2.5cm">
          <fo:region-body margin-top="3cm"/>
          <fo:region-before extent="3cm"/>
          <fo:region-after extent="1.5cm"/>
        </fo:simple-page-master>
      </fo:layout-master-set>
      <fo:page-sequence master-reference="simple">
        <fo:flow flow-name="xsl-region-body">
          <fo:block font-size="28pt"
          font-family="sans-serif"
          line-height="24pt"
          space-after.optimum="15pt"
      
          color="black"
          text-align="center"
          padding-top="3pt">
            Chasse au trésor de <xsl:value-of select="./@city" ></xsl:value-of>
          </fo:block>
          
          <fo:block font-size="11pt"
            font-family="sans-serif"
            line-height="24pt"
            space-after.optimum="15pt"
      
            color="black"
            text-align="left"
            padding-top="3pt">
            La chasse au trésor de <fo:inline font-weight="bold">
              <xsl:value-of select="./@city" ></xsl:value-of>
            </fo:inline> débutera le <xsl:call-template name="date">
              <xsl:with-param name="date-time" select="./@startDate"/>
            </xsl:call-template> à <xsl:call-template name="time">
              <xsl:with-param name="date-time" select="./@startDate"/>
            </xsl:call-template>.
          </fo:block>
          <fo:block font-size="11pt"
            font-family="sans-serif"
            line-height="24pt"
            space-after.optimum="15pt"
      
            color="black"
            text-align="left"
            padding-top="3pt">
            Participerons à cette chasse les équipes suivantes :
          </fo:block>
          <fo:list-block>
            <xsl:apply-templates select="./Teams"></xsl:apply-templates>
          </fo:list-block>
          <fo:block font-size="11pt"
      font-family="sans-serif"
      line-height="24pt"
      space-after.optimum="15pt"
      
      color="black"
      text-align="left"
      padding-top="3pt">
            Il y aura les actions suivantes à faire :
          </fo:block>

          <fo:table table-layout="fixed" width="100%" border-collapse="collapse">
            <fo:table-column column-width="50mm" border-style="solid"/>
            <fo:table-column column-width="50mm" border-style="solid"/>
            <fo:table-header border-style="solid">
              <fo:table-row>
                <fo:table-cell >
                  <fo:block>Action</fo:block>
                </fo:table-cell>
                <fo:table-cell >
                  <fo:block>Points</fo:block>
                </fo:table-cell>
              </fo:table-row>
            </fo:table-header>
            <fo:table-body>
              <xsl:apply-templates select="./Nodes/Node[@type='ActionNode']"></xsl:apply-templates>
            </fo:table-body>
          </fo:table>

          <fo:block font-size="11pt"
                    font-family="sans-serif"
                    line-height="24pt"
                    space-after.optimum="15pt"
                    color="black"
                    text-align="left"
                    padding-top="3pt">
            Les photos suivantes seront à découvrir :
          </fo:block>
          <xsl:apply-templates select="Nodes" />
        </fo:flow>
      </fo:page-sequence>
    </fo:root>

  </xsl:template>
  <xsl:template name="team" match="Team">
    <fo:list-item>
      <fo:list-item-label end-indent="label-end()">
        <fo:block>
          <fo:inline font-family="Symbol">&#x2022;</fo:inline>
        </fo:block>

      </fo:list-item-label>
      <fo:list-item-body start-indent="body-start()">
        <fo:block>
          <xsl:value-of select="./@name"/>
        </fo:block>
        <fo:list-block>
          <xsl:apply-templates select="./Players"></xsl:apply-templates>
        </fo:list-block>
      </fo:list-item-body>
    </fo:list-item>
  </xsl:template>
  <xsl:template name="player" match="Player">
    <fo:list-item>
      <fo:list-item-label end-indent="label-end()">
        <fo:block>
          <fo:inline font-family="Symbol">&#x2022;</fo:inline>
        </fo:block>

      </fo:list-item-label>
      <fo:list-item-body start-indent="body-start()">
        <fo:block>
          <xsl:value-of select="./@name"/>
        </fo:block>

      </fo:list-item-body>
    </fo:list-item>

  </xsl:template>
  <xsl:template name="actionRow" match="Node[@type='ActionNode']">
    <fo:table-row>
      <fo:table-cell >
        <fo:block>
          <xsl:value-of select="./@action"/>
        </fo:block>
      </fo:table-cell>
      <fo:table-cell >
        <fo:block>
          <xsl:value-of select="./@points"/>
        </fo:block>
      </fo:table-cell>

    </fo:table-row>

  </xsl:template>

  <xsl:template match="Nodes">
    <fo:table table-layout="fixed" width="100%" border-collapse="collapse">
      <xsl:for-each select="(//node())[$cols >= position()]">
        <fo:table-column column-width="50mm" border-style="solid"/>
      </xsl:for-each>

      <fo:table-body>

        <xsl:apply-templates select="Node[@type='PictureNode'][position() mod $cols = 1 or position() = 1]"
                             mode="row" />
      </fo:table-body>
    </fo:table>
  </xsl:template>

  <xsl:template match="Node[@type='PictureNode']" mode="row">
    <fo:table-row>
      <xsl:apply-templates select=". | following-sibling::Node[@type='PictureNode'][position() &lt; $cols]"
                           mode="cell" />
    </fo:table-row>
  </xsl:template>
  <xsl:template name="pictureCell" match="Node[@type='PictureNode']" mode="cell">
    <fo:table-cell>
      <fo:block>
        <fo:external-graphic src="{./Picture/@url}" scaling="uniform" content-height="scale-to-fit" content-width="50mm" />
      </fo:block>
      <fo:block text-align="center">
        <xsl:value-of select="./@points"/> Points
      </fo:block>
    </fo:table-cell>

  </xsl:template>
 
</xsl:stylesheet>