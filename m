Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from omta002.cacentral1.a.cloudfilter.net (omta002.cacentral1.a.cloudfilter.net [3.97.99.33])
	by sourceware.org (Postfix) with ESMTPS id DC75C395A40C;
	Sat, 17 Sep 2022 04:56:06 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org DC75C395A40C
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=systematicsw.ab.ca
Received: from shw-obgw-4001a.ext.cloudfilter.net ([10.228.9.142])
	by cmsmtp with ESMTP
	id ZId3oAEt2Sp39ZPs6oUQQk; Sat, 17 Sep 2022 04:56:06 +0000
Received: from localhost.localdomain ([184.64.124.72])
	by cmsmtp with ESMTP
	id ZPs4o6mbnlahmZPs5oGRgR; Sat, 17 Sep 2022 04:56:06 +0000
X-Authority-Analysis: v=2.4 cv=d8PmdDvE c=1 sm=1 tr=0 ts=63255366
 a=oHm12aVswOWz6TMtn9zYKg==:117 a=oHm12aVswOWz6TMtn9zYKg==:17
 a=r77TgQKjGQsHNAKrUKIA:9 a=9pJ1AMZdf05kdrFBZ94A:9 a=QEXdDO2ut3YA:10
 a=U9VJzsmbhA0ZiW-RFUcA:9 a=B2y7HmGcmWMA:10
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: Cygwin Patches <cygwin-patches@cygwin.com>,
	Cygwin Patches <Cygwin-Patches@Cygwin.com>
Subject: [PATCH] strptime.cc(__strptime): add %i, %q, %v
Date: Fri, 16 Sep 2022 22:55:27 -0600
Message-Id: <20220917045526.5733-1-Brian.Inglis@SystematicSW.ab.ca>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------2.37.2"
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfOCDDOjgehjJEHWUsDznzA1uF0zo3GLPBjcJW58ShfcQ/vnHyaMYkAjCUyNRWnBqLly9ykWRWlfkZMmt27Ob5TYPw0CtACq7bMFN535XT2ed01sFfsrW
 X92s3Q0i9vPVIje35EjO7xhWDa29IrxXkpdoq4vik7Q73hjXYkoaLR96juukN7Eq5f1rxiIpytkIhcSqpQoN/e+8oeDJJ3aXmgN5Qz7WYBL1JDGV8uld7AjM
 CNTTkfRdcXUs8m7USK0CmKh0FLEf88Y2FxF15hK5zCreyIZoKdJJJbxNde3H/iBmBbTURb3prj7+SQu/ZbbnZw==
X-Spam-Status: No, score=-1169.8 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,KAM_LAZY_DOMAIN_SECURITY,SPF_HELO_NONE,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is a multi-part message in MIME format.
--------------2.37.2
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


[Please Reply All due to email issues]

winsup/cygwin/libc/strptime.cc(__strptime):
%i year in century [00..99] Synonym for "%y". Non-POSIX extension. [tm_year]
%q GNU quarter of the year (from `<<1>>' to `<<4>>') [tm_mon]
%v OSX/Ruby VMS/Oracle date "%d-%b-%Y". Non-POSIX extension. [tm_mday, tm_mon, tm_year]
---
 winsup/cygwin/libc/strptime.cc | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)


--------------2.37.2
Content-Type: text/x-patch; name="0001-strptime.cc-__strptime-add-i-q-v.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="0001-strptime.cc-__strptime-add-i-q-v.patch"

diff --git a/winsup/cygwin/libc/strptime.cc b/winsup/cygwin/libc/strptime.cc
index 3a9bdbb300d4..901e93607960 100644
--- a/winsup/cygwin/libc/strptime.cc
+++ b/winsup/cygwin/libc/strptime.cc
@@ -440,6 +440,12 @@ literal:
 			LEGAL_ALT(0);
 			goto recurse;
 
+		case 'v':	/* OSX/Ruby VMS/Oracle date "%d-%b-%Y". */
+			new_fmt = "%d-%b-%Y";
+			LEGAL_ALT(0);
+			ymd |= SET_YMD;
+			goto recurse;
+
 		case 'X':	/* The time, using the locale's format. */
 			new_fmt = (alt_format & ALT_E)
 				  ? _ctloc (era_t_fmt) : _ctloc(X_fmt);
@@ -570,6 +576,14 @@ literal:
 			LEGAL_ALT(0);
 			continue;
 
+		case 'q':	/* The quarter year. GNU extension. */
+			LEGAL_ALT(0);
+			i = 1;
+			bp = conv_num(bp, &i, 1, 4, ALT_DIGITS);
+			tm->tm_mon = (i - 1)*3;
+			ymd |= SET_MON;
+			continue;
+
 		case 'S':	/* The seconds. */
 			LEGAL_ALT(ALT_O);
 			bp = conv_num(bp, &tm->tm_sec, 0, 61, ALT_DIGITS);
@@ -655,7 +669,10 @@ literal:
 			got_eoff = 0;
 			continue;
 
-		case 'y':	/* The year within 100 years of the epoch. */
+		case 'i':	/* The year within 100 years of the era. */
+			LEGAL_ALT(0);
+			fallthrough;
+		case 'y':	/* The year within 100 years of the era. */
 			/* LEGAL_ALT(ALT_E | ALT_O); */
 			ymd |= SET_YEAR;
 			if ((alt_format & ALT_E) && *era_info)

--------------2.37.2--


