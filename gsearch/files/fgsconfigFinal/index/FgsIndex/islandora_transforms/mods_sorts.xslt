<?xml version="1.0" encoding="UTF-8"?>
<!-- MODs Sorts MODS -->
<!-- This is before my time, but it appears to have come from: -->
<!-- https://gist.github.com/bibliotechy/9629633 -->

<xsl:stylesheet version="1.0"
    xmlns:java="http://xml.apache.org/xalan/java"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xlink="http://www.w3.org/1999/xlink"
    xmlns:foxml="info:fedora/fedora-system:def/foxml#"
    xmlns:mods="http://www.loc.gov/mods/v3"
    exclude-result-prefixes="mods">

    <xsl:template match="foxml:datastream[@ID='MODS']/foxml:datastreamVersion[last()]" name="mods_sorts" mode="mods_sorts">
    <xsl:param name="content"/>
    <xsl:apply-templates mode="mods_sorts" select="$content/mods:mods" />
    </xsl:template>

    <xsl:template name="mods_sorts_creator">
        <xsl:param name="content"/>
        <xsl:param name="field_suffix"/>
        <field name="{$field_suffix}">
            <xsl:choose>

                <xsl:when test="current()[not(@type)] or current()[@type='personal']">

                    <xsl:choose>
                        <xsl:when test="mods:namePart[@type='given'] and mods:namePart[@type='family']">
                            <xsl:value-of select="mods:namePart[@type='given']"/>
                            <xsl:text> </xsl:text>
                            <xsl:value-of select="mods:namePart[@type='family']"/>
                            <xsl:if test="mods:namePart[@type='termsOfAddress']">
                                <xsl:text>, </xsl:text>
                            </xsl:if>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:for-each select="mods:namePart[not(@type) or @type='given' or @type='family']" >
                                <xsl:value-of select="."/>
                                <xsl:choose>
                                    <xsl:when test="position() != last ()">
                                        <xsl:text>, </xsl:text>
                                    </xsl:when>
                                    <xsl:otherwise>  <!-- last part of name proper -->
                                        <xsl:choose>
                                            <xsl:when test="not(following-sibling::*)" />  <!-- no more elements -->
                                            <xsl:when test="following-sibling::mods:role" /> <!-- or only role left -->
                                            <xsl:otherwise>
                                                <xsl:text>, </xsl:text>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:for-each>
                        </xsl:otherwise>
                    </xsl:choose>

                    <xsl:for-each select="mods:namePart[@type='termsOfAddress']" >
                        <xsl:value-of select="." />
                        <xsl:choose>
                            <xsl:when test="../mods:namePart[@type='date']">
                                <xsl:text>,</xsl:text>
                            </xsl:when>
                            <xsl:otherwise />
                        </xsl:choose>
                    </xsl:for-each>

                    <xsl:for-each select="mods:namePart[@type='date']" >
                        <xsl:value-of select="." />
                    </xsl:for-each>
                </xsl:when>

                <xsl:otherwise>   <!-- corporate or conference -->
                    <xsl:for-each select="mods:namePart" >
                        <xsl:value-of select="." />
                        <xsl:choose>
                            <xsl:when test="position() != last ()">
                                <xsl:text>. </xsl:text>
                            </xsl:when>
                            <xsl:otherwise />
                        </xsl:choose>
                    </xsl:for-each>
                </xsl:otherwise>

            </xsl:choose>
        </field>
    </xsl:template>

    <xsl:template match="mods:mods/mods:name[1]" mode="mods_sorts">
        <xsl:call-template name="mods_sorts_creator">
            <xsl:with-param name="field_suffix" select="'creator_sort'" />
        </xsl:call-template>
        <xsl:call-template name="mods_sorts_creator">
            <xsl:with-param name="field_suffix" select="'creator_sort_ms'" />
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="mods:originInfo[1]" mode="mods_sorts">
        <xsl:choose>
            <xsl:when test="mods:dateIssued[1]" >
                <field>
                    <xsl:attribute name="name">date_sort</xsl:attribute>
                    <xsl:value-of select="mods:dateIssued[1]" />
                </field>
            </xsl:when>
            <xsl:when test="mods:dateCreated[1]">
                <field>
                    <xsl:attribute name="name">date_sort</xsl:attribute>
                    <xsl:value-of select="mods:dateCreated[1]" />
                </field>
            </xsl:when>
            <xsl:when test="mods:dateOther[1]">
                <field>
                    <xsl:attribute name="name">date_sort</xsl:attribute>
                    <xsl:value-of select="mods:dateOther[1]" />
                </field>
            </xsl:when>
            <xsl:otherwise>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>


    <xsl:template match="mods:mods/mods:titleInfo[not(@type)][1]" mode="mods_sorts">
        <field>
            <xsl:attribute name="name">title_sort</xsl:attribute>
            <xsl:value-of select="mods:title[1]" />
        </field>
    </xsl:template>

    <xsl:template match="text()" mode="mods_sorts"/>
</xsl:stylesheet>

