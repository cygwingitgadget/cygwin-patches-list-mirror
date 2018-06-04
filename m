Return-Path: <cygwin-patches-return-9069-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 118478 invoked by alias); 4 Jun 2018 19:36:20 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 116660 invoked by uid 89); 4 Jun 2018 19:36:18 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-25.8 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.2 spammy=4839, Takes, According, H*Ad:U*cygwin-patches
X-HELO: limerock03.mail.cornell.edu
Received: from limerock03.mail.cornell.edu (HELO limerock03.mail.cornell.edu) (128.84.13.243) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 04 Jun 2018 19:36:17 +0000
X-CornellRouted: This message has been Routed already.
Received: from authusersmtp.mail.cornell.edu (granite4.serverfarm.cornell.edu [10.16.197.9])	by limerock03.mail.cornell.edu (8.14.4/8.14.4_cu) with ESMTP id w54JaEnw009787;	Mon, 4 Jun 2018 15:36:15 -0400
Received: from nothing.nyroc.rr.com (mta-68-175-129-7.twcny.rr.com [68.175.129.7] (may be forged))	(authenticated bits=0)	by authusersmtp.mail.cornell.edu (8.14.4/8.12.10) with ESMTP id w54Ja676027599	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);	Mon, 4 Jun 2018 15:36:14 -0400
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH 2/5] Cygwin: Allow the environment pointer to be NULL
Date: Mon, 04 Jun 2018 19:36:00 -0000
Message-Id: <20180604193607.17088-3-kbrown@cornell.edu>
In-Reply-To: <20180604193607.17088-1-kbrown@cornell.edu>
References: <20180604193607.17088-1-kbrown@cornell.edu>
X-PMX-Cornell-Gauge: Gauge=XXXXX
X-PMX-CORNELL-AUTH-RESULTS: dkim-out=none;
X-IsSubscribed: yes
X-SW-Source: 2018-q2/txt/msg00026.txt.bz2

Following glibc, interpret this as meaning the environment is empty.
---
 winsup/cygwin/environ.cc | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/winsup/cygwin/environ.cc b/winsup/cygwin/environ.cc
index b452d21a5..8e6bbe561 100644
--- a/winsup/cygwin/environ.cc
+++ b/winsup/cygwin/environ.cc
@@ -483,6 +483,9 @@ my_findenv (const char *name, int *offset)
   register char **p;
   const char *c;
 
+  if (cur_environ () == NULL)
+    return NULL;
+
   c = name;
   len = 0;
   while (*c && *c != '=')
@@ -545,14 +548,18 @@ _getenv_r (struct _reent *, const char *name)
   return findenv_func (name, &offset);
 }
 
-/* Return size of environment block, including terminating NULL. */
+/* Return number of environment entries, including terminating NULL. */
 static int __stdcall
 envsize (const char * const *in_envp)
 {
   const char * const *envp;
+
+  if (in_envp == NULL)
+    return 0;
+
   for (envp = in_envp; *envp; envp++)
     continue;
-  return (1 + envp - in_envp) * sizeof (const char *);
+  return 1 + envp - in_envp;
 }
 
 /* Takes similar arguments to setenv except that overwrite is
@@ -584,23 +591,23 @@ _addenv (const char *name, const char *value, int overwrite)
     {				/* Create new slot. */
       int sz = envsize (cur_environ ());
 
-      /* Allocate space for two new slots even though only one is needed.
-	 According to the commit message for commit ebd645e
-	 (2001-10-03), this is done to "work around problems with some
-	 buggy applications." */
-      int allocsz = sz + (2 * sizeof (char *));
+      /* If sz == 0, we need two new slots, one for the terminating NULL.
+	 But we add two slots in all cases, as has been done since
+	 2001-10-03 (commit ebd645e) to "work around problems with
+	 some buggy applications." */
+      int allocsz = (sz + 2) * sizeof (char *);
 
-      offset = (sz - 1) / sizeof (char *);
+      offset = sz == 0 ? 0 : sz - 1;
 
       /* Allocate space for additional element. */
       if (cur_environ () == lastenviron)
 	lastenviron = __cygwin_environ = (char **) realloc (cur_environ (),
 							    allocsz);
       else if ((lastenviron = (char **) malloc (allocsz)) != NULL)
-	__cygwin_environ = (char **) memcpy ((char **) lastenviron,
-					     __cygwin_environ, sz);
+	__cygwin_environ = (char **) memcpy (lastenviron, __cygwin_environ,
+					     sz * sizeof (char *));
 
-      if (!__cygwin_environ)
+      if (!lastenviron)
 	{
 #ifdef DEBUGGING
 	  try_to_debug ();
-- 
2.17.0
