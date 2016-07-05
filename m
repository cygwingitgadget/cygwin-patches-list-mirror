Return-Path: <cygwin-patches-return-8595-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24145 invoked by alias); 5 Jul 2016 10:08:36 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 24108 invoked by uid 89); 5 Jul 2016 10:08:35 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-0.1 required=5.0 tests=AWL,BAYES_50,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW autolearn=no version=3.3.2 spammy=HX-CTCH-RefID:sk:0001.0A, HX-CTCH-RefID:1,fgs, HX-CTCH-RefID:str, HX-CTCH-RefID:0.000,reip
X-HELO: rgout0401.bt.lon5.cpcloud.co.uk
Received: from rgout0401.bt.lon5.cpcloud.co.uk (HELO rgout0401.bt.lon5.cpcloud.co.uk) (65.20.0.214) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 05 Jul 2016 10:08:22 +0000
X-OWM-Source-IP: 86.179.112.53 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-CTCH-RefID: str=0001.0A090206.577B8711.0065,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-Junkmail-Premium-Raw: score=27/50,refid=2.7.2:2016.7.4.165416:17:27.888,ip=86.179.112.53,rules=__HAS_FROM, __TO_MALFORMED_2, __TO_NO_NAME, __HAS_CC_HDR, __SUBJ_ALPHA_END, __HAS_MSGID, __SANE_MSGID, __HAS_X_MAILER, __IN_REP_TO, __REFERENCES, __ANY_URI, __URI_NO_WWW, BODYTEXTP_SIZE_3000_LESS, BODY_SIZE_900_999, __MIME_TEXT_ONLY, RDNS_GENERIC_POOLED, __URI_NS, SXL_IP_DYNAMIC[53.112.179.86.fur], HTML_00_01, HTML_00_10, BODY_SIZE_5000_LESS, RDNS_SUSP_GENERIC, BODY_SIZE_1000_LESS, BODY_SIZE_2000_LESS, MULTIPLE_RCPTS_RND, RDNS_SUSP, IN_REP_TO, REFERENCES, BODY_SIZE_7000_LESS, NO_URI_HTTPS, MSG_THREAD, LEGITIMATE_NEGATE
X-CTCH-Spam: Unknown
Received: from localhost.localdomain (86.179.112.53) by rgout04.bt.lon5.cpcloud.co.uk (8.6.122.06) (authenticated as jonturney@btinternet.com)        id 57764D230097E8D7; Tue, 5 Jul 2016 11:08:17 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 2/3] Use <filename> tag, not <pathname> tag
Date: Tue, 05 Jul 2016 10:08:00 -0000
Message-Id: <20160705100752.6684-3-jon.turney@dronecode.org.uk>
In-Reply-To: <20160705100752.6684-1-jon.turney@dronecode.org.uk>
References: <20160705100752.6684-1-jon.turney@dronecode.org.uk>
X-SW-Source: 2016-q3/txt/msg00003.txt.bz2

Fix an instance of the invalid <pathname> tag in Cygwin utils documentation,
by using the valid <filename> tag instead.

Signed-off-by: Jon Turney <jon.turney@dronecode.org.uk>
---
 winsup/doc/utils.xml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/doc/utils.xml b/winsup/doc/utils.xml
index 4853d92..12949c5 100644
--- a/winsup/doc/utils.xml
+++ b/winsup/doc/utils.xml
@@ -335,7 +335,7 @@ Other options:
     However, the cygdrive prefix can be changed by the user, so symbolic links
     created using the cygdrive prefix are not foolproof.  With
     <literal>-U</literal> cygpath will generate such paths prepended by the
-    virtual <pathname>/proc/cygdrive</pathname> symbolic link, which will
+    virtual <filename>/proc/cygdrive</filename> symbolic link, which will
     never change, so the created path is safe against changing the cygdrive
     prefix.</para>
 
-- 
2.8.3
