<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="text"/>
    <xsl:template match="/">

# Generate by v2v-job
apiVersion: kubevirt.io/v1alpha1
kind: VirtualMachine
metadata:
  name: <xsl:value-of select="/domain/name"/>
spec:
  terminationGracePeriodSeconds: 0
  domain:
    cpu:
      cores: <xsl:value-of select="/domain/vcpu"/>
    resources:
      requests:
        memory: <xsl:value-of select="/domain/memory"/><xsl:value-of select="/domain/memory/@unit"/>
    devices:
      disks:
<xsl:for-each select="/domain/devices/disk">
<!-- fixme need to check supported buses -->
<!--xsl:if test="@device = 'disk'"-->
      - name: disk-<xsl:value-of select="position()"/>
        volumeName: volume-<xsl:value-of select="position()"/>
<xsl:text>
        </xsl:text><xsl:value-of select="@device"/>:
          bus: <xsl:value-of select="target/@bus"/>
<!--/xsl:if-->
</xsl:for-each>

  volumes:
<xsl:for-each select="/domain/devices/disk">
<!--xsl:if test="@device = 'disk'"-->
    - name: volume-<xsl:value-of select="position()"/>
      persistentVolumeClaim:
        name: <xsl:value-of select="/domain/name"/>-disk-<xsl:value-of select="position()"/>
<!--/xsl:if-->
</xsl:for-each>

<xsl:text>&#10;</xsl:text><!-- newline -->
	</xsl:template>
</xsl:stylesheet>

