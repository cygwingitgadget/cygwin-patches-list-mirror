Return-Path: <cygwin-patches-return-8660-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 73508 invoked by alias); 5 Jan 2017 17:39:52 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 73418 invoked by uid 89); 5 Jan 2017 17:39:50 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.4 required=5.0 tests=BAYES_00,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_SPAM,SPF_PASS autolearn=no version=3.3.2 spammy=Erik, erik, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: mail-wm0-f65.google.com
Received: from mail-wm0-f65.google.com (HELO mail-wm0-f65.google.com) (74.125.82.65) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 05 Jan 2017 17:39:45 +0000
Received: by mail-wm0-f65.google.com with SMTP id l2so72513938wml.2        for <cygwin-patches@cygwin.com>; Thu, 05 Jan 2017 09:39:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20161025;        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to         :references;        bh=RpJgZufFWoQppuhaxcEDPxM56kNEchymLXr86ThliNs=;        b=AhsTSnOYcwpRCDRuSSyo3fDgKOVpBkLTXCNQjzaWJemeCQZtg90larDjWyI7t+aTwA         foT9JLKyvo8od+qtpLPv0HP2k3B962X55PHKrGVbuljZREkgGX/YY3UMjt8ls+HzS5yf         XXTg+UeSW+ukIPq+6nVGLEsdNL5Begf2+JJoF4uC4ak7nzEmouEmfp2kjg1H6aKPuFm8         tgu/fw+YiEVmj2uxq0aeHWvMmncsM3CKgwATJQ62DUnV42v1gsf3JvhU5pqwc5y5v6I4         JqyW2iDnrNoyPRbzj/07iFmYJRWiEBBmuTJNNbjkslo9dsQnZRE/YiAvthx+KLZDe3Es         LXpg==
X-Gm-Message-State: AIkVDXKsB4ijeBHOcdkucsSjl83Jc7O4PWkONM+6tW7/91gE17yigLdmvF4NxJVKWHOQsg==
X-Received: by 10.28.176.200 with SMTP id z191mr63676264wme.17.1483637983222;        Thu, 05 Jan 2017 09:39:43 -0800 (PST)
Received: from localhost.localdomain (lri30-45.lri.fr. [129.175.30.45])        by smtp.gmail.com with ESMTPSA id t194sm84773wmd.1.2017.01.05.09.39.42        for <cygwin-patches@cygwin.com>        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);        Thu, 05 Jan 2017 09:39:42 -0800 (PST)
From: erik.m.bray@gmail.com
To: cygwin-patches@cygwin.com
Subject: [PATCH 1/3] Move the core environment parsing of environ_init into a new win32env_to_cygenv function.
Date: Thu, 05 Jan 2017 17:39:00 -0000
Message-Id: <20170105173929.65728-2-erik.m.bray@gmail.com>
In-Reply-To: <20170105173929.65728-1-erik.m.bray@gmail.com>
References: <20170105173929.65728-1-erik.m.bray@gmail.com>
X-IsSubscribed: yes
X-SW-Source: 2017-q1/txt/msg00001.txt.bz2

From: "Erik M. Bray" <erik.bray@lri.fr>

win32env_to_cygwenv handles converting wchar to char and some other
minor taks.  Optionally it handles converting any paths in variables to
posix paths.

This will be useful for implementing /proc/<pid>/environ
---
 winsup/cygwin/environ.cc | 84 ++++++++++++++++++++++++++++--------------------
 winsup/cygwin/environ.h  |  2 ++
 2 files changed, 51 insertions(+), 35 deletions(-)

diff --git a/winsup/cygwin/environ.cc b/winsup/cygwin/environ.cc
index 51107c5..c4195ed 100644
--- a/winsup/cygwin/environ.cc
+++ b/winsup/cygwin/environ.cc
@@ -758,18 +758,12 @@ ucenv (char *p, const char *eq)
 void
 environ_init (char **envp, int envc)
 {
-  PWCHAR rawenv, w;
-  int i;
+  PWCHAR rawenv;
   char *p;
-  char *newp;
-  int sawTERM = 0;
   bool envp_passed_in;
-  static char NO_COPY cygterm[] = "TERM=cygwin";
-  tmp_pathbuf tp;
 
   __try
     {
-      char *tmpbuf = tp.t_get ();
       if (!envp)
 	envp_passed_in = 0;
       else
@@ -794,9 +788,6 @@ environ_init (char **envp, int envc)
 	  goto out;
 	}
 
-      /* Allocate space for environment + trailing NULL + CYGWIN env. */
-      lastenviron = envp = (char **) malloc ((4 + (envc = 100)) * sizeof (char *));
-
       rawenv = GetEnvironmentStringsW ();
       if (!rawenv)
 	{
@@ -805,32 +796,8 @@ environ_init (char **envp, int envc)
 	}
       debug_printf ("GetEnvironmentStrings returned %p", rawenv);
 
-      /* Current directory information is recorded as variables of the
-	 form "=X:=X:\foo\bar; these must be changed into something legal
-	 (we could just ignore them but maybe an application will
-	 eventually want to use them).  */
-      for (i = 0, w = rawenv; *w != L'\0'; w = wcschr (w, L'\0') + 1, i++)
-	{
-	  sys_wcstombs_alloc_no_path (&newp, HEAP_NOTHEAP, w);
-	  if (i >= envc)
-	    envp = (char **) realloc (envp, (4 + (envc += 100)) * sizeof (char *));
-	  envp[i] = newp;
-	  if (*newp == '=')
-	    *newp = '!';
-	  char *eq = strchrnul (newp, '=');
-	  ucenv (newp, eq);	/* uppercase env vars which need it */
-	  if (*newp == 'T' && strncmp (newp, "TERM=", 5) == 0)
-	    sawTERM = 1;
-	  else if (*newp == 'C' && strncmp (newp, "CYGWIN=", 7) == 0)
-	    parse_options (newp + 7);
-	  if (*eq)
-	    posify_maybe (envp + i, *++eq ? eq : --eq, tmpbuf);
-	  debug_printf ("%p: %s", envp[i], envp[i]);
-	}
+	  lastenviron = envp = win32env_to_cygenv(rawenv, true);
 
-      if (!sawTERM)
-	envp[i++] = strdup (cygterm);
-      envp[i] = NULL;
       FreeEnvironmentStringsW (rawenv);
 
     out:
@@ -852,6 +819,53 @@ environ_init (char **envp, int envc)
   __endtry
 }
 
+
+char **
+win32env_to_cygenv(PWCHAR rawenv, bool posify)
+{
+  tmp_pathbuf tp;
+  char **envp;
+  int envc;
+  char *newp;
+  int i;
+  int sawTERM = 0;
+  static char NO_COPY cygterm[] = "TERM=cygwin";
+  char *tmpbuf = tp.t_get ();
+  PWCHAR w;
+
+  /* Allocate space for environment + trailing NULL + CYGWIN env. */
+  envp = (char **) malloc ((4 + (envc = 100)) * sizeof (char *));
+
+  /* Current directory information is recorded as variables of the
+     form "=X:=X:\foo\bar; these must be changed into something legal
+     (we could just ignore them but maybe an application will
+     eventually want to use them).  */
+  for (i = 0, w = rawenv; *w != L'\0'; w = wcschr (w, L'\0') + 1, i++)
+    {
+      sys_wcstombs_alloc_no_path (&newp, HEAP_NOTHEAP, w);
+      if (i >= envc)
+        envp = (char **) realloc (envp, (4 + (envc += 100)) * sizeof (char *));
+      envp[i] = newp;
+      if (*newp == '=')
+        *newp = '!';
+      char *eq = strchrnul (newp, '=');
+      ucenv (newp, eq);    /* uppercase env vars which need it */
+      if (*newp == 'T' && strncmp (newp, "TERM=", 5) == 0)
+        sawTERM = 1;
+      else if (*newp == 'C' && strncmp (newp, "CYGWIN=", 7) == 0)
+        parse_options (newp + 7);
+      if (*eq && posify)
+        posify_maybe (envp + i, *++eq ? eq : --eq, tmpbuf);
+      debug_printf ("%p: %s", envp[i], envp[i]);
+    }
+
+  if (!sawTERM)
+    envp[i++] = strdup (cygterm);
+
+  envp[i] = NULL;
+  return envp;
+}
+
 /* Function called by qsort to sort environment strings.  */
 static int
 env_sort (const void *a, const void *b)
diff --git a/winsup/cygwin/environ.h b/winsup/cygwin/environ.h
index 46beb2d..7bd87da 100644
--- a/winsup/cygwin/environ.h
+++ b/winsup/cygwin/environ.h
@@ -45,4 +45,6 @@ extern "C" char __stdcall **cur_environ ();
 char ** __reg3 build_env (const char * const *envp, PWCHAR &envblock,
 			  int &envc, bool need_envblock, HANDLE new_token);
 
+char __stdcall ** win32env_to_cygenv (PWCHAR rawenv, bool posify);
+
 #define ENV_CVT -1
-- 
2.8.3
