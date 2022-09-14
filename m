Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from omta001.cacentral1.a.cloudfilter.net (omta001.cacentral1.a.cloudfilter.net [3.97.99.32])
	by sourceware.org (Postfix) with ESMTPS id 2AC323858407;
	Wed, 14 Sep 2022 02:52:42 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 2AC323858407
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=systematicsw.ab.ca
Received: from shw-obgw-4001a.ext.cloudfilter.net ([10.228.9.142])
	by cmsmtp with ESMTP
	id Y9pNog2TyS8WrYIW1oHs3H; Wed, 14 Sep 2022 02:52:41 +0000
Received: from BWINGLISD.cg.shawcable.net. ([184.64.124.72])
	by cmsmtp with ESMTP
	id YIW0o9xvGUAunYIW1omFTY; Wed, 14 Sep 2022 02:52:41 +0000
X-Authority-Analysis: v=2.4 cv=JLIoDuGb c=1 sm=1 tr=0 ts=632141f9
 a=oHm12aVswOWz6TMtn9zYKg==:117 a=oHm12aVswOWz6TMtn9zYKg==:17
 a=r77TgQKjGQsHNAKrUKIA:9 a=9pJ1AMZdf05kdrFBZ94A:9 a=QEXdDO2ut3YA:10
 a=dmFWhoLbThZFLoyzdvQA:9 a=B2y7HmGcmWMA:10
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: Cygwin Patches <cygwin-patches@cygwin.com>,
	Cygwin Patches <Cygwin-Patches@Cygwin.com>
Cc: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Subject: [PATCH 2/3] strptime.c(strptime_l): add %i, %q, %v
Date: Tue, 13 Sep 2022 20:52:35 -0600
Message-Id: <20220914025236.54080-3-Brian.Inglis@SystematicSW.ab.ca>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220914025236.54080-1-Brian.Inglis@SystematicSW.ab.ca>
References: <20220914025236.54080-1-Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------2.37.2"
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfM23VLGQFvuNfKqBdw8DaV4pOsO8L9Jt+0ygNR9cfCZB2BXyCF8MXIL0YZNhEgVViKWsqMXh1U4DlZ/f7SSDC2LvJD44ZIU+VuE3DoLOp7la9pn8yZzl
 UKgAsqaEq+qVKiuTNgxtF192jhMigqdKRh9Zxa6M5aMScdxityPacQ4pbQiMGlDUzlaJKTbNINWCGfRaU55Jw4lLjZi1pCQ/mHH1ZuLH1rX5R86LxmkDebUK
 AdORPd1AQhUi4GFB/QfYH1EIoRQoxwDlE/zxGcycHGWaA/1qgXI4xipBOeOJt1iSb+PCaraa5pTswgzMdcNi5A==
X-Spam-Status: No, score=-1169.8 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,KAM_LAZY_DOMAIN_SECURITY,PP_MIME_FAKE_ASCII_TEXT,SPF_HELO_NONE,SPF_NONE,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is a multi-part message in MIME format.
--------------2.37.2
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


newlib/libc/time/strptime.c(strptime_l):
%i year in century [00..99] Synonym for "%y". Non-POSIX extension. [tm_year]
%q GNU quarter of the year (from `<<1>>' to `<<4>>') [tm_mon]
%v OSX/Ruby VMS/Oracle date "%d-%b-%Y". Non-POSIX extension. [tm_mday, tm_mon, tm_year]:
---
 newlib/libc/time/strptime.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)


--------------2.37.2
Content-Type: text/x-patch; name="0002-strptime.c-strptime_l-add-i-q-v.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="0002-strptime.c-strptime_l-add-i-q-v.patch"

diff --git a/newlib/libc/time/strptime.c b/newlib/libc/time/strptime.c
index 12b2ef4695de..5e64af262516 100644
--- a/newlib/libc/time/strptime.c
+++ b/newlib/libc/time/strptime.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (c) 1999 Kungliga Tekniska H?gskolan
+ * Copyright (c) 1999 Kungliga Tekniska Högskolan
  * (Royal Institute of Technology, Stockholm, Sweden). 
  * All rights reserved. 
  *
@@ -298,6 +298,14 @@ strptime_l (const char *buf, const char *format, struct tm *timeptr,
 		} else
 		    timeptr->tm_hour += 12;
 		break;
+	    case 'q' :		/* quarter year - GNU extension */
+		ret = strtol_l (buf, &s, 10, locale);
+		if (s == buf)
+		    return NULL;
+		timeptr->tm_mon = (ret - 1)*3;
+		buf = s;
+		ymd |= SET_MON;
+		break;
 	    case 'r' :		/* %I:%M:%S %p */
 		s = strptime_l (buf, _ctloc (ampm_fmt), timeptr, locale);
 		if (s == NULL)
@@ -365,6 +373,13 @@ strptime_l (const char *buf, const char *format, struct tm *timeptr,
 		buf = s;
 		ymd |= SET_WDAY;
 		break;
+	    case 'v' :	/* %d-%b-%Y - OSX/Ruby extension VMS/Oracle date */
+		s = strptime_l (buf, "%d-%b-%Y", timeptr, locale);
+		if (s == NULL || s == buf)
+		    return NULL;
+		buf = s;
+		ymd |= SET_YMD;
+		break;
 	    case 'U' :
 		ret = strtol_l (buf, &s, 10, locale);
 		if (s == buf)
@@ -402,6 +417,7 @@ strptime_l (const char *buf, const char *format, struct tm *timeptr,
 		    return NULL;
 		buf = s;
 	    	break;
+	    case 'i' :	    /* Non-POSIX extension. */
 	    case 'y' :
 		ret = strtol_l (buf, &s, 10, locale);
 		if (s == buf)

--------------2.37.2--


