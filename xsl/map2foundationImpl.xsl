<xsl:stylesheet
  xmlns:df="http://dita2indesign.org/dita/functions"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:relpath="http://dita2indesign/functions/relpath"
  xmlns:htmlutil="http://dita4publishers.org/functions/htmlutil"
  xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
  xmlns:dc="http://purl.org/dc/elements/1.1/"
  exclude-result-prefixes="df xs relpath htmlutil xd dc"
  version="2.0">

  <xsl:template name="gen-page-links">
   <!-- remove content -->
  </xsl:template>

  <!-- used to output the html5 header -->
  <xsl:template match="*" mode="generate-header">
    <xsl:param name="documentation-title" as="xs:string" select="''" tunnel="yes" />
    <div class="contain-to-grid sticky">
      <nav class="top-bar" data-topbar="">
        <ul class="title-area">
          <li class="name">
            <h1><a href="#"><xsl:value-of select="$documentation-title"/></a></h1>
          </li>
          <!--li class="toggle-topbar menu-icon"><a href="#"><span>Menu</span></a></li-->
        </ul>
      </nav>
    </div>
  </xsl:template>

  <!-- generate section container -->
<xsl:template match="*" mode="generate-section-container">
      <xsl:param name="navigation" as="element()*"  tunnel="yes" />
      <xsl:param name="is-root" as="xs:boolean"  tunnel="yes" select="false()" />
      <xsl:param name="resultUri" as="xs:string" tunnel="yes" select="''" />

      <section role="main">
        <div class="row">
          <div class="large-3 medium-4 columns">
              <xsl:choose>
                <xsl:when test="$is-root">
                  <xsl:sequence select="$navigation"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:variable name="navigation-fixed">
                    <xsl:apply-templates select="$navigation" mode="fix-navigation-href">
                      <xsl:with-param name="resultUri" select="$resultUri" />
                    </xsl:apply-templates>
                  </xsl:variable>
                  <xsl:sequence select="$navigation-fixed"/>
                </xsl:otherwise>
              </xsl:choose>
           </div>

           <div class="large-9 medium-8 columns">
             <xsl:apply-templates select="." mode="generate-main-content"/>
           </div>
        </div>
      </section>

  </xsl:template>

  <xsl:template mode="generate-html5-nav-page-markup" match="*[df:class(., 'map/map')]">
    <xsl:param name="collected-data" as="element()" tunnel="yes"/>
    <xsl:param name="documentation-title" tunnel="yes" />

    <div class="sidebar">

      <nav aria-label="Main navigation">
        <xsl:variable name="listItems" as="node()*">
          <xsl:apply-templates mode="generate-html5-nav"
            select=".
            except (
            *[df:class(., 'topic/title')],
            *[df:class(., 'map/topicmeta')],
            *[df:class(., 'map/reltable')]
            )"
          />
        </xsl:variable>

        <xsl:if test="$listItems">
          <ul class="side-nav">
            <xsl:sequence select="$listItems"/>
          </ul>
        </xsl:if>
      </nav>
    </div>
  </xsl:template>

</xsl:stylesheet>
