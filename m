Return-Path: <cygwin-patches-return-9088-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 92544 invoked by alias); 6 Jun 2018 15:46:17 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 92271 invoked by uid 89); 6 Jun 2018 15:46:14 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-26.0 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.2 spammy=H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: limerock02.mail.cornell.edu
Received: from limerock02.mail.cornell.edu (HELO limerock02.mail.cornell.edu) (128.84.13.242) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 06 Jun 2018 15:46:11 +0000
X-CornellRouted: This message has been Routed already.
Received: from authusersmtp.mail.cornell.edu (granite4.serverfarm.cornell.edu [10.16.197.9])	by limerock02.mail.cornell.edu (8.14.4/8.14.4_cu) with ESMTP id w56Fk91J023963;	Wed, 6 Jun 2018 11:46:09 -0400
Received: from nothing.nyroc.rr.com (mta-68-175-129-7.twcny.rr.com [68.175.129.7] (may be forged))	(authenticated bits=0)	by authusersmtp.mail.cornell.edu (8.14.4/8.12.10) with ESMTP id w56Fjxgd006086	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);	Wed, 6 Jun 2018 11:46:08 -0400
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH v2 2/6] Cygwin: Allow the environment pointer to be NULL
Date: Wed, 06 Jun 2018 15:46:00 -0000
Message-Id: <20180606154559.6828-3-kbrown@cornell.edu>
In-Reply-To: <20180606154559.6828-1-kbrown@cornell.edu>
References: <20180606154559.6828-1-kbrown@cornell.edu>
X-PMX-Cornell-Gauge: Gauge=XXXXX
X-PMX-CORNELL-AUTH-RESULTS: dkim-out=none;
X-IsSubscribed: yes
X-SW-Source: 2018-q2/txt/msg00045.txt.bz2

Following glibc, interpret this as meaning the environment is empty.
---
 winsup/cygwin/environ.cc | 40 ++++++++++++++++++++++++++--------------
 winsup/cygwin/pinfo.cc   |  7 ++++---
 2 files changed, 30 insertions(+), 17 deletions(-)

diff --git a/winsup/cygwin/environ.cc b/winsup/cygwin/environ.cc
index b452d21a5..06e1ced01 100644
--- a/winsup/cygwin/environ.cc
+++ b/winsup/cygwin/environ.cc
@@ -30,6 +30,7 @@ details. */
 #include "shared_info.h"
 #include "ntdll.h"
 
+/* If this is not NULL, it points to memory allocated by us. */
 static char **lastenviron;
 
 /* Parse CYGWIN options */
@@ -483,6 +484,9 @@ my_findenv (const char *name, int *offset)
   register char **p;
   const char *c;
 
+  if (cur_environ () == NULL)
+    return NULL;
+
   c = name;
   len = 0;
   while (*c && *c != '=')
@@ -545,14 +549,18 @@ _getenv_r (struct _reent *, const char *name)
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
@@ -584,23 +592,22 @@ _addenv (const char *name, const char *value, int overwrite)
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
-	lastenviron = __cygwin_environ = (char **) realloc (cur_environ (),
+	lastenviron = __cygwin_environ = (char **) realloc (lastenviron,
 							    allocsz);
-      else if ((lastenviron = (char **) malloc (allocsz)) != NULL)
-	__cygwin_environ = (char **) memcpy ((char **) lastenviron,
-					     __cygwin_environ, sz);
-
-      if (!__cygwin_environ)
+      else if ((lastenviron = (char **) realloc (lastenviron, allocsz)) != NULL)
+	__cygwin_environ = (char **) memcpy (lastenviron, __cygwin_environ,
+					     sz * sizeof (char *));
+      if (!lastenviron)
 	{
 #ifdef DEBUGGING
 	  try_to_debug ();
@@ -1029,8 +1036,13 @@ build_env (const char * const *envp, PWCHAR &envblock, int &envc,
   char **dstp;
   bool saw_spenv[SPENVS_SIZE] = {0};
 
+  static char *const empty_env[] = { NULL };
+
   debug_printf ("envp %p", envp);
 
+  if (!envp)
+    envp = empty_env;
+
   /* How many elements? */
   for (n = 0; envp[n]; n++)
     continue;
diff --git a/winsup/cygwin/pinfo.cc b/winsup/cygwin/pinfo.cc
index e4eef8b3c..6b6986c9e 100644
--- a/winsup/cygwin/pinfo.cc
+++ b/winsup/cygwin/pinfo.cc
@@ -677,11 +677,12 @@ commune_process (void *arg)
 	sigproc_printf ("processing PICOM_ENVIRON");
 	unsigned n = 0;
 	char **env = cur_environ ();
-	for (char **e = env; *e; e++)
-	  n += strlen (*e) + 1;
+	if (env)
+	  for (char **e = env; *e; e++)
+	    n += strlen (*e) + 1;
 	if (!WritePipeOverlapped (tothem, &n, sizeof n, &nr, 1000L))
 	  sigproc_printf ("WritePipeOverlapped sizeof argv failed, %E");
-	else
+	else if (env)
 	  for (char **e = env; *e; e++)
 	    if (!WritePipeOverlapped (tothem, *e, strlen (*e) + 1, &nr, 1000L))
 	      {
-- 
2.17.0
