Return-Path: <cygwin-patches-return-8314-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 70873 invoked by alias); 12 Feb 2016 22:02:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 70848 invoked by uid 89); 12 Feb 2016 22:02:40 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.0 required=5.0 tests=BAYES_00,RP_MATCHES_RCVD,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=expansions, HTo:U*cygwin-patches, sum, H*Ad:U*cygwin-patches
X-HELO: mx1.redhat.com
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Fri, 12 Feb 2016 22:02:39 +0000
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])	by mx1.redhat.com (Postfix) with ESMTPS id 2D7C05A45	for <cygwin-patches@cygwin.com>; Fri, 12 Feb 2016 22:02:38 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-17.rdu2.redhat.com [10.10.116.17])	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u1CM2ahx029580	(version=TLSv1/SSLv3 cipher=AES256-SHA256 bits=256 verify=NO)	for <cygwin-patches@cygwin.com>; Fri, 12 Feb 2016 17:02:37 -0500
From: Yaakov Selkowitz <yselkowi@redhat.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH v2] cygwin: work around GCC 5 preprocessor changes
Date: Fri, 12 Feb 2016 22:02:00 -0000
Message-Id: <1455314533-11104-1-git-send-email-yselkowi@redhat.com>
In-Reply-To: <56BE4162.3000806@redhat.com>
References: <56BE4162.3000806@redhat.com>
X-SW-Source: 2016-q1/txt/msg00020.txt.bz2

GCC 5 adds #line directives (and hence extra newlines) for macros
expansions, which confuses cygmagic.  Using the -P flag avoids
them entirely.

https://cygwin.com/ml/cygwin-patches/2016-q1/msg00016.html

Signed-off-by: Yaakov Selkowitz <yselkowi@redhat.com>
---
 winsup/cygwin/cygmagic | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/cygwin/cygmagic b/winsup/cygwin/cygmagic
index b945291..036c79c 100755
--- a/winsup/cygwin/cygmagic
+++ b/winsup/cygwin/cygmagic
@@ -24,7 +24,7 @@ sumit() {
 while [ -n "$1" ]; do
     define=$1; shift
     struct=$1; shift
-    sum=`$gcc -D__CYGMAGIC__ -E $file | sed -n "/^$struct/,/^};/p" | sed -e 's/[ 	]//g' -e '/^$/d' | sumit | awk '{printf "0x%xU", $1}'`
+    sum=`$gcc -D__CYGMAGIC__ -E -P $file | sed -n "/^$struct/,/^};/p" | sed -e 's/[ 	]//g' -e '/^$/d' | sumit | awk '{printf "0x%xU", $1}'`
     echo "#define $define $sum"
     curr=`sed -n "s/^#[ 	]*define CURR_$define[ 	][ 	]*\([^ 	][^ 	]*\)/\1/p" $file`
     [ "$curr" != "$sum" ] && echo "*** WARNING WARNING WARNING WARNING WARNING ***
-- 
2.7.0
