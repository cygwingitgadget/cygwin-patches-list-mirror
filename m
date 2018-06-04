Return-Path: <cygwin-patches-return-9068-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 116923 invoked by alias); 4 Jun 2018 19:36:18 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 116031 invoked by uid 89); 4 Jun 2018 19:36:17 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-25.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.2 spammy=H*r:8.12.10, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: limerock01.mail.cornell.edu
Received: from limerock01.mail.cornell.edu (HELO limerock01.mail.cornell.edu) (128.84.13.241) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 04 Jun 2018 19:36:16 +0000
X-CornellRouted: This message has been Routed already.
Received: from authusersmtp.mail.cornell.edu (granite4.serverfarm.cornell.edu [10.16.197.9])	by limerock01.mail.cornell.edu (8.14.4/8.14.4_cu) with ESMTP id w54JaEKY007311;	Mon, 4 Jun 2018 15:36:14 -0400
Received: from nothing.nyroc.rr.com (mta-68-175-129-7.twcny.rr.com [68.175.129.7] (may be forged))	(authenticated bits=0)	by authusersmtp.mail.cornell.edu (8.14.4/8.12.10) with ESMTP id w54Ja675027599	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);	Mon, 4 Jun 2018 15:36:13 -0400
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH 1/5] Cygwin: Clarify some code in environ.cc
Date: Mon, 04 Jun 2018 19:36:00 -0000
Message-Id: <20180604193607.17088-2-kbrown@cornell.edu>
In-Reply-To: <20180604193607.17088-1-kbrown@cornell.edu>
References: <20180604193607.17088-1-kbrown@cornell.edu>
X-PMX-Cornell-Gauge: Gauge=XXXXX
X-PMX-CORNELL-AUTH-RESULTS: dkim-out=none;
X-IsSubscribed: yes
X-SW-Source: 2018-q2/txt/msg00025.txt.bz2

---
 winsup/cygwin/environ.cc | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/environ.cc b/winsup/cygwin/environ.cc
index 43225341c..b452d21a5 100644
--- a/winsup/cygwin/environ.cc
+++ b/winsup/cygwin/environ.cc
@@ -545,6 +545,7 @@ _getenv_r (struct _reent *, const char *name)
   return findenv_func (name, &offset);
 }
 
+/* Return size of environment block, including terminating NULL. */
 static int __stdcall
 envsize (const char * const *in_envp)
 {
@@ -582,11 +583,16 @@ _addenv (const char *name, const char *value, int overwrite)
   else
     {				/* Create new slot. */
       int sz = envsize (cur_environ ());
+
+      /* Allocate space for two new slots even though only one is needed.
+	 According to the commit message for commit ebd645e
+	 (2001-10-03), this is done to "work around problems with some
+	 buggy applications." */
       int allocsz = sz + (2 * sizeof (char *));
 
       offset = (sz - 1) / sizeof (char *);
 
-      /* Allocate space for additional element plus terminating NULL. */
+      /* Allocate space for additional element. */
       if (cur_environ () == lastenviron)
 	lastenviron = __cygwin_environ = (char **) realloc (cur_environ (),
 							    allocsz);
-- 
2.17.0
