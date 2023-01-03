<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet>
<xsl:stylesheet version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.w3.org/1999/xhtml">

    <xsl:output method="html" indent="yes"/>
    <xsl:strip-space elements="*"/>
    <xsl:preserve-space elements="tei:persName tei:birth tei:placeName"/>
    <xsl:template match="/">
        <html>
            <head>
                <link rel="stylesheet" type="text/css" href="css/progetto.css" media="screen" />
                <script src="script/progetto.js"></script>
                <title><xsl:value-of select="//tei:titleStmt/tei:title[@type='main']"/>, <xsl:value-of select="//tei:titleStmt/tei:author"/></title>
            </head>
            <body>
                <h1><xsl:value-of select="//tei:titleStmt/tei:title[@type='main']"/>&#160;<xsl:value-of select="//tei:titleStmt/tei:title[@type='sub']"/> by <xsl:value-of select="//tei:titleStmt/tei:author"/></h1>
                <h3><xsl:value-of select="//tei:editionStmt/tei:edition"/></h3>
                <div id="f3f6Images">
                    <xsl:variable name="apos" select='"&apos;"'/>
                    <xsl:for-each select="//tei:surface/tei:graphic">
                        <xsl:variable name="index" select="position()"/>
                        <h2><xsl:value-of select="concat('Folio n.',$index*3, ', Première conférence')"/></h2>
                        <span id="folioContainer">
                            <xsl:element name="img">
                                <xsl:attribute name="usemap">
                                    <xsl:value-of select="concat('#map',$index)"/>
                                </xsl:attribute>
                                <xsl:attribute name="id">
                                    <xsl:value-of select="parent::tei:surface/@xml:id"/>
                                </xsl:attribute> 
                                <xsl:attribute name="src">
                                    <xsl:value-of select="current()/@url"/>
                                </xsl:attribute>
                                <xsl:attribute name="class">
                                    <xsl:text>fogliImages</xsl:text>
                                </xsl:attribute>
                            </xsl:element>
                            <xsl:element name="map">  
                                <xsl:attribute name="name">
                                    <xsl:value-of select="concat('map',$index)"/>
                                </xsl:attribute>
                                <xsl:attribute name="id">
                                    <xsl:value-of select="concat('map',$index)"/>
                                </xsl:attribute> 
                                <xsl:for-each select="parent::tei:surface/tei:zone[@rendition='line']">
                                    <xsl:element name="area">   
                                        <xsl:attribute name="id">
                                            <xsl:value-of select="@xml:id"/>
                                        </xsl:attribute>
                                        <xsl:attribute name="shape">
                                            <xsl:text>rect</xsl:text>
                                        </xsl:attribute>
                                        <xsl:attribute name="coords">
                                            <xsl:value-of select="@ulx"/>,<xsl:value-of select="@uly"/>,<xsl:value-of select="@lrx"/>,<xsl:value-of select="@lry"/>
                                        </xsl:attribute>
                                        <xsl:attribute name="onclick">
                                            <xsl:value-of select="concat('gestoreEvidenzia(', $apos, @xml:id, $apos, ')' )"/>
                                        </xsl:attribute>
                                    </xsl:element>
                                </xsl:for-each>
                            </xsl:element>
                            <div id="frenchTranscript">
                                <h4>French Transcription</h4>
                                <xsl:apply-templates select="//tei:text/tei:group/tei:text[@xml:lang='fr']/tei:body/tei:div[$index]"/>
                            </div>
                            <div id="italianTranscript">
                                <h4>Italian Translation</h4>
                                <br/>
                                <xsl:apply-templates select="//tei:text/tei:group/tei:text[@xml:lang='it']/tei:body/tei:div[$index]"/>
                            </div>
                        </span>
                    </xsl:for-each>
                </div>
                <div id="containerInfo">
                    <div id="gloss">
                        <xsl:apply-templates select="//tei:back/tei:div/tei:list[@type='gloss']"/>
                    </div>
                    <div id="infos">
                        <div id="person">
                            <xsl:apply-templates select="//tei:back/tei:div/tei:listPerson"/>
                        </div>
                        <div id="biblio">
                            <xsl:apply-templates select="//tei:back/tei:div/tei:listBibl"/>
                        </div>
                        <div id="places">
                            <xsl:apply-templates select="//tei:back/tei:div/tei:listPlace"/>
                        </div>
                        <div id="org">
                            <xsl:apply-templates select="//tei:back/tei:div/tei:listOrg"/>
                        </div>
                    </div>
                </div>
                <footer>
                    <div class="divFooter">
                        <h3>Manuscript Info</h3>
                        Manuscript <xsl:value-of select="//tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:msDesc/tei:msIdentifier/tei:idno"/>
                        preserved at the 
                        <xsl:value-of select="//tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:msDesc/tei:msIdentifier/tei:repository"/>,
                        <xsl:value-of select="//tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:msDesc/tei:msIdentifier/tei:settlement"/>,
                        <xsl:value-of select="//tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:msDesc/tei:msIdentifier/tei:country"/>,
                        <br/>
                        within the <xsl:value-of select="//tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:msDesc/tei:msIdentifier/tei:collection"/> archive.
                        <br/>
                        <xsl:value-of select="//tei:physDesc/tei:handDesc/tei:handNote"/>
                        <br/>
                        The Manuscript is made of <xsl:value-of select="//tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:msDesc/tei:physDesc/tei:objectDesc/tei:supportDesc/tei:support"/> 
                        and is composed of three lections: <br/> 
                        <xsl:value-of select="//tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:msDesc/tei:msContents/tei:msItem[1]/tei:title[2]"/>
                        (<xsl:value-of select="//tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:msDesc/tei:msContents/tei:msItem[1]/tei:docDate"/>);
                        <xsl:value-of select="//tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:msDesc/tei:msContents/tei:msItem[2]/tei:title[2]"/>
                        (<xsl:value-of select="//tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:msDesc/tei:msContents/tei:msItem[2]/tei:docDate"/>);
                        <xsl:value-of select="//tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:msDesc/tei:msContents/tei:msItem[3]/tei:title[2]"/>
                        (<xsl:value-of select="//teiteiHeader/tei:fileDesc/tei:sourceDesc/tei:msDesc/tei:msContents/tei:msItem[3]/tei:docDate"/>);
                        <br/>
                        (
                            <xsl:value-of select="//tei:supportDesc/tei:extent/tei:measureGrp/tei:measure[1]"/>
                            <xsl:value-of select="//tei:supportDesc/tei:extent/tei:measureGrp/tei:measure[2]"/>
                            <xsl:value-of select="//tei:supportDesc/tei:extent/tei:measureGrp/tei:measure[3]"/>
                        )
                        <br/>
                        <xsl:value-of select="//tei:supportDesc/tei:foliation"/>
                        &#160;<xsl:value-of select="//tei:supportDesc/tei:condition"/>
                        &#160;<xsl:value-of select="//tei:physDesc/tei:additions"/>
                    </div>
                    <div class="divFooter">
                        <h3>Digital Edition Info</h3>
                        <xsl:value-of select="//tei:teiHeader/tei:fileDesc/tei:editionStmt/tei:edition"/>
                        <xsl:value-of select="//tei:teiHeader/tei:fileDesc/tei:editionStmt/tei:respStmt[1]/tei:resp"/>
                        <xsl:value-of select="//tei:teiHeader/tei:fileDesc/tei:editionStmt/tei:respStmt[1]/tei:name[1]"/>, 
                        <xsl:value-of select="//tei:teiHeader/tei:fileDesc/tei:editionStmt/tei:respStmt[1]/tei:name[2]"/>.
                        <br/>
                        <xsl:value-of select="//tei:teiHeader/tei:fileDesc/tei:editionStmt/tei:respStmt[2]/tei:resp"/>
                        <xsl:value-of select="//tei:teiHeader/tei:fileDesc/tei:editionStmt/tei:respStmt[2]/tei:name[1]"/>, 
                        <xsl:value-of select="//tei:teiHeader/tei:fileDesc/tei:editionStmt/tei:respStmt[2]/tei:name[2]"/>, 
                        <xsl:value-of select="//tei:teiHeader/tei:fileDesc/tei:editionStmt/tei:respStmt[2]/tei:name[2]"/>.
                        <br/>
                        <xsl:value-of select="//tei:teiHeader/tei:fileDesc/tei:editionStmt/tei:respStmt[3]/tei:resp"/>
                        <xsl:value-of select="//tei:teiHeader/tei:fileDesc/tei:editionStmt/tei:respStmt[3]/tei:name[1]"/>
                        <br/>
                        <xsl:value-of select="//tei:teiHeader/tei:fileDesc/tei:publicationStmt/tei:publisher"/>, 
                        <xsl:value-of select="//tei:teiHeader/tei:fileDesc/tei:publicationStmt/tei:pubPlace"/>, 
                        <xsl:value-of select="//tei:teiHeader/tei:fileDesc/tei:publicationStmt/tei:date"/> 
                        <br/>
                        <xsl:value-of select="//tei:teiHeader/tei:encodingDesc/tei:projectDesc"/>
                        <br/>
                        <xsl:value-of select="//tei:teiHeader/tei:fileDesc/tei:publicationStmt/tei:availability/tei:licence"/>
                    </div>
                </footer>
                <!-- script jQuery (https://github.com/stowball/jQuery-rwdImageMaps) per effettuare il resize corretto di immagine e della relativa map -->
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"/>
                <script src="script/jquery.rwdImageMaps.min.js"/>
                <script type="text/javascript">
                    <xsl:text>
                        $(document).ready(function(e) {
                            $('img[usemap]').rwdImageMaps();
                        });
                    </xsl:text>
                </script>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="tei:del">
    </xsl:template>

    <xsl:template match="tei:restore">
        <xsl:value-of select="tei:del"/>
    </xsl:template>

    <xsl:template match="tei:subst">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="tei:lb">
        <xsl:element name="br"/>
        <xsl:element name="span">
            <xsl:attribute name="id">
                <xsl:value-of select="@facs" />
            </xsl:attribute>
            <xsl:value-of select="concat('[', @n, ']')"/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="tei:choice">
        <xsl:choose>
            <xsl:when test="tei:orig">
                <xsl:value-of select="tei:reg"/> (orig: <xsl:value-of select="tei:orig"/>)
            </xsl:when>
            <xsl:when test="tei:abbr">
                <xsl:value-of select="tei:expan"/> (abbr: <xsl:value-of select="tei:abbr"/>)
            </xsl:when>
            <xsl:when test="tei:sic">
                <xsl:value-of select="tei:corr"/> (sic: <xsl:value-of select="tei:sic"/>)
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="//tei:text/tei:group/tei:text[@xml:lang='fr']/tei:body/tei:div[1]/tei:ab">
        <xsl:element name="span">
            <xsl:attribute name="id">
                <xsl:value-of select="@xml:id"/>
            </xsl:attribute>
            <xsl:element name="a">
                <xsl:apply-templates/>
            </xsl:element>
        </xsl:element>
    </xsl:template>

    <xsl:template match="//tei:text/tei:group/tei:text[@xml:lang='fr']/tei:body/tei:div[2]/tei:ab">
        <xsl:element name="span">
            <xsl:attribute name="id">
                <xsl:value-of select="@xml:id"/>
            </xsl:attribute>
            <xsl:element name="a">
                <xsl:apply-templates/>
            </xsl:element>
        </xsl:element>
    </xsl:template>

    <xsl:template match="//tei:text/tei:group/tei:text[@xml:lang='it']/tei:body/tei:div[1]">
        <xsl:element name="span">
            <xsl:attribute name="id">
                <xsl:value-of select="@xml:id"/>
            </xsl:attribute>
            <xsl:element name="a">
                <xsl:apply-templates/>
            </xsl:element>
        </xsl:element>
    </xsl:template>

    <xsl:template match="//tei:text/tei:group/tei:text[@xml:lang='it']/tei:body/tei:div[2]">
        <xsl:element name="span">
            <xsl:attribute name="id">
                <xsl:value-of select="@xml:id"/>
            </xsl:attribute>
            <xsl:element name="a">
                <xsl:apply-templates/>
            </xsl:element>
        </xsl:element>
    </xsl:template>

    <xsl:template match="tei:div[@type='list']">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="tei:list[@type='gloss']">
        <h3 class="terminology">Terminology</h3>
        <xsl:element name="ol">
            <xsl:apply-templates select="current()//tei:gloss"/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="tei:listPerson">
        <h3 class="terminology">People</h3>

        <xsl:element name="ul">
            <xsl:apply-templates select="current()//tei:persName"/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="tei:listBibl">
        <h3 class="terminology">Bibliography</h3>

        <xsl:element name="ul">
            <xsl:apply-templates select="current()//tei:bibl"/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="tei:listPlace">
        <h3 class="terminology">Places</h3>

        <xsl:element name="ul">
            <xsl:apply-templates select="current()//tei:place"/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="tei:listOrg">
        <h3 class="terminology">Organizations</h3>

        <xsl:element name="ol">
            <xsl:apply-templates select="current()//tei:org"/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="tei:gloss">
        <xsl:element name="li">
            <xsl:attribute name="id"><xsl:value-of select="substring(@target, 2)"/></xsl:attribute>
            <xsl:element name="span">
                <xsl:element name="strong">
                    <xsl:value-of select="//tei:list[@type='gloss']/tei:label/tei:term[@xml:id=substring(current()/@target, 2)]"/>
                </xsl:element>
            </xsl:element>
            <xsl:element name="i">
                (<xsl:value-of select="//tei:list[@type='gloss']/tei:label/tei:term[@target=current()/@target]"/>)
            </xsl:element>
            :
            <xsl:value-of select="current()"/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="tei:persName">
        <xsl:element name="li">
            <xsl:attribute name="id"><xsl:value-of select="@xml:id"/></xsl:attribute>
            <xsl:element name="span">
                <xsl:element name="strong">
                    <xsl:apply-templates/>
                </xsl:element>
                <xsl:if test="parent::node()/tei:birth | parent::node()/tei:death | parent::node()/tei:nationality | parent::node()/tei:occupation">
                    (
                    <xsl:if test="parent::node()/tei:birth">
                        <xsl:apply-templates select="parent::node()/tei:birth"/> 
                    </xsl:if>
                    <xsl:if test="parent::node()/tei:death">
                        - <xsl:apply-templates select="parent::node()/tei:death"/>, 
                    </xsl:if>
                    <xsl:if test="parent::node()/tei:nationality">
                        <xsl:apply-templates select="parent::node()/tei:nationality"/>
                    </xsl:if>
                    <xsl:if test="parent::node()/tei:occupation">
                        , <xsl:value-of select="parent::node()/tei:occupation[1]"/>
                        <xsl:if test="parent::node()/tei:occupation[2]">
                            - <xsl:value-of select="parent::node()/tei:occupation[2]"/>
                        </xsl:if>
                    </xsl:if>
                    )
                </xsl:if>
            </xsl:element>
        </xsl:element>
    </xsl:template>

    <xsl:template match="tei:bibl">
        <xsl:element name="li">
            <xsl:attribute name="id"><xsl:value-of select="@xml:id"/></xsl:attribute>
            <xsl:element name="span">
                <xsl:element name="strong">
                    <xsl:element name="i">
                        "<xsl:value-of select="tei:title"></xsl:value-of>"
                    </xsl:element>
                </xsl:element>
                <br/>
                <xsl:for-each select="tei:author">
                    <xsl:value-of select="tei:persName"/>, 
                </xsl:for-each>
                <xsl:value-of select="tei:publisher"/>,
                <xsl:value-of select="tei:pubPlace"/>,
                <xsl:value-of select="tei:date"/>,
                <xsl:value-of select="tei:idno"/>,
                <xsl:value-of select="tei:extent"/>,
                <xsl:value-of select="tei:citedRange"/>;
                <br/>
                <xsl:value-of select="tei:note"/>
            </xsl:element>
        </xsl:element>
    </xsl:template>

    <xsl:template match="tei:place">
        <xsl:element name="a">
            <xsl:attribute name="id"><xsl:value-of select="@xml:id"/></xsl:attribute>
            <xsl:element name="span">
                <xsl:choose>
                    <xsl:when test="tei:country">
                        <xsl:value-of select="concat(current()/tei:placeName, ', ', current()/tei:country)"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="current()/tei:placeName"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:element>; 
        </xsl:element>
    </xsl:template>

    <xsl:template match="tei:org">
        <xsl:element name="li">
            <xsl:attribute name="id"><xsl:value-of select="@xml:id"/></xsl:attribute>
            <xsl:element name="span">
                <xsl:element name="strong">
                    <xsl:value-of select="current()/tei:orgName"></xsl:value-of>
                </xsl:element>
                : <xsl:value-of select="current()/tei:desc"></xsl:value-of>
            </xsl:element>
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>