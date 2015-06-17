Return-Path: <cygwin-patches-return-8185-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11745 invoked by alias); 17 Jun 2015 12:37:36 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 11670 invoked by uid 89); 17 Jun 2015 12:37:35 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=0.4 required=5.0 tests=AWL,BAYES_50,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=no version=3.3.2
X-HELO: rgout05.bt.lon5.cpcloud.co.uk
Received: from rgout05.bt.lon5.cpcloud.co.uk (HELO rgout05.bt.lon5.cpcloud.co.uk) (65.20.0.182) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 17 Jun 2015 12:37:32 +0000
X-OWM-Source-IP: 86.141.128.210(GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-CTCH-RefID: str=0001.0A090204.55816A0C.0078,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-Junkmail-Premium-Raw: score=27/50,refid=2.7.2:2015.6.17.94516:17:27.888,ip=86.141.128.210,rules=__HAS_FROM, __TO_MALFORMED_2, __TO_NO_NAME, __SUBJ_ALPHA_END, __HAS_MSGID, __SANE_MSGID, __HAS_X_MAILER, __IN_REP_TO, __REFERENCES, __ANY_URI, __URI_NO_WWW, __URI_NO_PATH, BODY_SIZE_1700_1799, BODYTEXTP_SIZE_3000_LESS, __MIME_TEXT_ONLY, RDNS_GENERIC_POOLED, __URI_NS, SXL_IP_DYNAMIC[210.128.141.86.fur], HTML_00_01, HTML_00_10, BODY_SIZE_5000_LESS, RDNS_SUSP_GENERIC, BODY_SIZE_2000_LESS, RDNS_SUSP, BODY_SIZE_7000_LESS, REFERENCES
X-CTCH-Spam: Unknown
Received: from localhost.localdomain (86.141.128.210) by rgout05.bt.lon5.cpcloud.co.uk (8.6.122.06) (authenticated as jonturney@btinternet.com)        id 55814C5E00039AEA; Wed, 17 Jun 2015 13:37:24 +0100
From: Jon TURNEY <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon TURNEY <jon.turney@dronecode.org.uk>
Subject: [PATCH 2/5] winsup/doc: Generate ANSI rather than K&R style function prototypes
Date: Wed, 17 Jun 2015 12:37:00 -0000
Message-Id: <1434544626-2516-3-git-send-email-jon.turney@dronecode.org.uk>
In-Reply-To: <1434544626-2516-1-git-send-email-jon.turney@dronecode.org.uk>
References: <1434544626-2516-1-git-send-email-jon.turney@dronecode.org.uk>
X-SW-Source: 2015-q2/txt/msg00086.txt.bz2

Since K&R style prototypes appear to be the default for HTML and FO, customize
the stylesheets rendering of funcsynopsis elements to generate ANSI style
prototypes instead.

2015-06-17  Jon Turney  <jon.turney@dronecode.org.uk>

	* fo.xsl: Render funcsynopsis elements as ANSI style function
	prototypes.
	* html.xsl: Ditto.

Signed-off-by: Jon TURNEY <jon.turney@dronecode.org.uk>
---
 winsup/doc/ChangeLog | 6 ++++++
 winsup/doc/fo.xsl    | 3 +++
 winsup/doc/html.xsl  | 3 +++
 3 files changed, 12 insertions(+)

diff --git a/winsup/doc/ChangeLog b/winsup/doc/ChangeLog
index 453de70..347adcb 100644
--- a/winsup/doc/ChangeLog
+++ b/winsup/doc/ChangeLog
@@ -1,5 +1,11 @@
 2015-06-17  Jon Turney  <jon.turney@dronecode.org.uk>
 
+	* fo.xsl: Render funcsynopsis elements as ANSI style function
+	prototypes.
+	* html.xsl: Ditto.
+
+2015-06-17  Jon Turney  <jon.turney@dronecode.org.uk>
+
 	* html.xsl: Renamed from cygwin.xsl.
 
 2015-06-17  Corinna Vinschen  <corinna@vinschen.de>
diff --git a/winsup/doc/fo.xsl b/winsup/doc/fo.xsl
index ba8e191..f3fee0b 100644
--- a/winsup/doc/fo.xsl
+++ b/winsup/doc/fo.xsl
@@ -65,4 +65,7 @@
   </xsl:if>
 </xsl:template>
 
+	<!-- generate ansi rather than k&r style function synopses -->
+	<xsl:param name="funcsynopsis.style" select="ansi" />
+
 </xsl:stylesheet>
diff --git a/winsup/doc/html.xsl b/winsup/doc/html.xsl
index 2b02ea8..59b7735 100644
--- a/winsup/doc/html.xsl
+++ b/winsup/doc/html.xsl
@@ -23,4 +23,7 @@
 <!-- suppress refentry in toc being annotated with refpurpose -->
 <xsl:param name="annotate.toc" select="0" />
 
+<!-- generate ansi rather than k&r style function synopses -->
+<xsl:param name="funcsynopsis.style" select="ansi" />
+
 </xsl:stylesheet>
-- 
2.1.4
