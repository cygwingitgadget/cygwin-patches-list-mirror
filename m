Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from omta002.cacentral1.a.cloudfilter.net (omta002.cacentral1.a.cloudfilter.net [3.97.99.33])
	by sourceware.org (Postfix) with ESMTPS id F28743858D1E
	for <cygwin-patches@cygwin.com>; Sat, 22 Oct 2022 05:16:18 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org F28743858D1E
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=systematicsw.ab.ca
Received: from shw-obgw-4001a.ext.cloudfilter.net ([10.228.9.142])
	by cmsmtp with ESMTP
	id lsnBomxPHSp39m6rqoNN7X; Sat, 22 Oct 2022 05:16:18 +0000
Received: from localhost.localdomain ([184.64.124.72])
	by cmsmtp with ESMTP
	id m6rpo9xrmkTFZm6rqowd0n; Sat, 22 Oct 2022 05:16:18 +0000
X-Authority-Analysis: v=2.4 cv=D8dUl9dj c=1 sm=1 tr=0 ts=63537ca2
 a=oHm12aVswOWz6TMtn9zYKg==:117 a=oHm12aVswOWz6TMtn9zYKg==:17
 a=r77TgQKjGQsHNAKrUKIA:9 a=TREZnVsva5QR3Tm_J8MA:9 a=QEXdDO2ut3YA:10
 a=D8Q_mHDOrX4A:10 a=qynNUJvCSgxBgBsrhb4A:9 a=B2y7HmGcmWMA:10
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: cygwin-patches@cygwin.com
Subject: [PATCH] strptime.cc(__strptime): add %q GNU quarter
Date: Fri, 21 Oct 2022 23:16:03 -0600
Message-Id: <20221022051603.2787-1-Brian.Inglis@SystematicSW.ab.ca>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------2.37.3"
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfP2B4DRn9dVi7bjshITrepqQVgaRsm3vwjrhIO8KjbDGZqHi+ieBYsRsAjgUtqzQkA39UX7iD847qV4oFez3PFXKz60sXw6M0DihbzF+XFzWju2carcj
 us62miSh+X3FFt1b46s84WkYlBr57McDMtiX0WSVHbOK3p2FTKBMv++wywZ9+TDpAqgY3uy54Kj4MO24uyTXVo7ddwn1fQ1Nzk8wSFAMoapyjCfJrzyfI+9Q
 zGxGTNmaVdKDqqAHAytty9Ld/PrI5AJBTLw1NbwOr3U=
X-Spam-Status: No, score=-1169.8 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is a multi-part message in MIME format.
--------------2.37.3
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit

---
 winsup/cygwin/libc/strptime.cc | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)


--------------2.37.3
Content-Type: text/x-patch; name="0001-strptime.cc-__strptime-add-q-GNU-quarter.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="0001-strptime.cc-__strptime-add-q-GNU-quarter.patch"

diff --git a/winsup/cygwin/libc/strptime.cc b/winsup/cygwin/libc/strptime.cc
index 3a9bdbb300d4..d1e635cd279f 100644
--- a/winsup/cygwin/libc/strptime.cc
+++ b/winsup/cygwin/libc/strptime.cc
@@ -570,6 +570,14 @@ literal:
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
@@ -655,7 +663,7 @@ literal:
 			got_eoff = 0;
 			continue;
 
-		case 'y':	/* The year within 100 years of the epoch. */
+		case 'y':	/* The year within 100 years of the century or era. */
 			/* LEGAL_ALT(ALT_E | ALT_O); */
 			ymd |= SET_YEAR;
 			if ((alt_format & ALT_E) && *era_info)

--------------2.37.3--


