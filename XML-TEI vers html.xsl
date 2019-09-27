<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:output method="html" encoding="UTF-8"/>
    
    <!--<xsl:strip-space elements="*"/> -->
    
    <xsl:template match="/">
            <html>
                <head>
                    <link rel="stylesheet" type="text/css" href="epistulahtml.css"/>
                    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
                    <title><xsl:value-of select="//title"/></title>
                </head>
                <body>
                    <h1>
                        <xsl:apply-templates select="//head"/>
                    </h1>
                    
                    <div id="sommaire">
                        <h3>Plan et ressources:</h3>
                        <xsl:apply-templates select="//div[@xml:id='n00']"/>
                    </div>
                    
                    <div id="legende">
                        <h3>Légende de la lettre: </h3>
                        <xsl:apply-templates select="//div[@type='legende']"/>
                    </div>
                    
                    <h2>
                        <xsl:apply-templates select="//salute"/>
                        <a class="note" href="#"><sup>0</sup>  
                        <span style="text-align:left">
                            <xsl:apply-templates select="//p[@xml:id='n0']"/> 
                        </span>
                        </a>
                    </h2>
                   <div id="lettre">
                        <xsl:for-each select="//body/div"> 
                            <p id="{@n}">
                            <xsl:value-of select="@n"/>
                                <xsl:text>. &#10;</xsl:text>
                            <xsl:apply-templates select="."/>
                            </p>
                        </xsl:for-each>
                   </div>
                    
                    <hr/>
                    
                    
                    <h2>Analyses</h2>
                    
                    <div id="n000">
                        <h3>Plan thématique</h3>
                        
                        <xsl:apply-templates select="//div[@xml:id='n000']"/>
                    </div>
                    <br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
                    <hr/>
                    
                    <div id="analyse1">
                        <h3>Analogies de Victrice</h3>
                        
                        <table width="100%" align="center" border="1px solid black">
                            <tr>
                                <td width="20%">
                                    <p>Paragraphe</p>
                                </td>
                                <td width="60%">
                                    Texte
                                </td>
                                <td width="20%">
                                    <p>Comparant</p>
                                </td>
                            </tr>
                        </table>
                        <xsl:for-each select="//seg[@ana='indexnominum.xml#Victricius']">
                            
                            <table width="100%" align="center" border="1px solid black">
                                <tr>
                                    <td width="20%">
                                        <p><xsl:value-of select="ancestor::div/@n"/></p>
                                    </td>
                                    <td width="60%">
                                        <xsl:apply-templates/>
                                    </td>
                                    <td width="20%">
                                        <xsl:variable name="idcorresp">
                                            <xsl:value-of select="replace(@corresp,'indexnominum.xml#','')"/> 
                                        </xsl:variable>
                                        
                                        <p><xsl:value-of select="$idcorresp"/></p>
                                    </td>
                                </tr>
                            </table>   
                        </xsl:for-each>
                    </div>
                    <br/><br/>
                   <hr/>
                    <br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
                    <div id="analyse2">
                        <h3>Intertextualité virgilienne</h3>
                        <table style="width:100%;">
                            <tr>
                                <td width="50%" valign="top">
                                    <p style="line-height:3"><xsl:apply-templates select="//p[@xml:id='analyse2.1']"/></p>
                                </td>
                                <td width="50%" valign="top">
                                    <p style="line-height:3"><xsl:apply-templates select="//p[@xml:id='analyse2.2']"/></p>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
                </body>
            </html>  
    </xsl:template>
    
    <xsl:template match="//seg[@type='métaphore']">
        <mark class="analogie" href="#"><span><xsl:value-of select="@ana"/><xsl:text> = </xsl:text><xsl:value-of select="@corresp"/></span>
            <xsl:apply-templates/>
        </mark>
    </xsl:template>
    
    <xsl:template match="//seg[@type='comparaison']">
        <mark class="analogie" href="#"><span><xsl:value-of select="@ana"/><xsl:text> = </xsl:text><xsl:value-of select="@corresp"/></span>
            <xsl:apply-templates/>
        </mark>
    </xsl:template>
    
    <!--
    <xsl:template match="seg[@type='portrait']">
        <span class="portrait" href="#"><span><xsl:text>Portrait de l'/de la/du/de </xsl:text><xsl:value-of select="@ana"/></span>
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    -->
    
    <xsl:template match="seg[@type='topoi']">
        <xsl:apply-templates/>
        <xsl:for-each select=".">
            <a class="topoi" href="#"><sup><xsl:value-of select="replace(ptr/@n,'#n','')"/></sup> 
            <span>
                <xsl:variable name="idnote">
                    <xsl:value-of select="replace(ptr/@n,'#','')"/> 
                </xsl:variable>
                <xsl:value-of select="//p[@xml:id=$idnote]"/> 
            </span>
            </a>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="//quote[@type='tissé']">
        <a class="quotetissé" href="#"><span><xsl:value-of select="@source"/><xsl:text> </xsl:text> <xsl:value-of select="comment()"/></span>
            <xsl:apply-templates/> 
        </a>    
    </xsl:template>
    
    <xsl:template match="//quote[@type='annoncé']">
        <a class="quoteannoncé" href="#"><span><xsl:value-of select="@source"/><xsl:text> </xsl:text> <xsl:value-of select="comment()"/></span>
            <xsl:value-of select="."/> 
        </a>    
    </xsl:template>
    
    <xsl:template match="//persName">
        <xsl:value-of select="."/>
    </xsl:template>
    
    <xsl:template match="//placeName">
        <strong><xsl:value-of select="."/></strong>
    </xsl:template>
   
    
    <xsl:template match="item">
            <xsl:choose>
                <xsl:when test="p/ptr">
                    <li>
                    <a class="lien" href="{p/ptr/@target}">
                        <xsl:apply-templates/>
                    </a>
                    </li>
                </xsl:when>
                <xsl:when test="p/@source">
                    <li>
                        <a class="lien" href="{p/@source}">
                            <xsl:apply-templates/>
                        </a>
                    </li>
                </xsl:when>
                <xsl:otherwise>
                    <li>
                        <xsl:apply-templates/>
                    </li>
                </xsl:otherwise>
            </xsl:choose>
    </xsl:template>
    
    
    <xsl:template match="list[@rend='numbered']">
        <ol>
            <xsl:apply-templates/>
        </ol>
    </xsl:template>
    
    <xsl:template match="list[@rend='bulleted']">
        <ul>
            <xsl:apply-templates/>
        </ul>
    </xsl:template>
    
    <xsl:template match="hi[@rend='sub']">
        <sub>
            <xsl:apply-templates/>
        </sub>
    </xsl:template>
    
    <xsl:template match="hi[@rend='italic']">
        <i>
            <xsl:apply-templates/>
        </i>
    </xsl:template>
    
    <xsl:template match="hi[@style]">
        <span style="{@style}"><xsl:apply-templates/></span>
    </xsl:template>
    
    <xsl:template match="l">
        <xsl:apply-templates/><br/>
    </xsl:template>
    
    <xsl:template match="div">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="bibl">
        <p><xsl:apply-templates/></p>
    </xsl:template>

    <xsl:template match="p">
        <p><xsl:apply-templates/></p>
    </xsl:template>
    
</xsl:stylesheet>