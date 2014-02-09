Return-Path: <cygwin-patches-return-7966-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14396 invoked by alias); 9 Feb 2014 00:26:31 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 14382 invoked by uid 89); 9 Feb 2014 00:26:31 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2
X-HELO: mail-we0-f175.google.com
Received: from mail-we0-f175.google.com (HELO mail-we0-f175.google.com) (74.125.82.175) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-SHA encrypted) ESMTPS; Sun, 09 Feb 2014 00:26:11 +0000
Received: by mail-we0-f175.google.com with SMTP id q59so3264244wes.20        for <cygwin-patches@cygwin.com>; Sat, 08 Feb 2014 16:26:08 -0800 (PST)
X-Received: by 10.194.203.200 with SMTP id ks8mr35745wjc.61.1391905568612;        Sat, 08 Feb 2014 16:26:08 -0800 (PST)
Received: from ArchVMl702x.cable.virginmedia.net (cpc1-bagu4-0-0-cust54.1-3.cable.virginm.net. [82.23.84.55])        by mx.google.com with ESMTPSA id xt1sm22363289wjb.17.2014.02.08.16.26.07        for <multiple recipients>        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);        Sat, 08 Feb 2014 16:26:08 -0800 (PST)
From: Ray Donnelly <mingw.android@gmail.com>
To: cygwin-patches@cygwin.com
Cc: Ray Donnelly <mingw.android@gmail.com>
Subject: [PATCH] * winsup/cygwin/exceptions.cc: Expand $CYGWIN error_start   processing so that custom commandlines can be passed to   the debugger program using '|' as an argument delimiter   and <program-name> and <process-id> as special tokens.
Date: Sun, 09 Feb 2014 00:26:00 -0000
Message-Id: <1391905541-986-2-git-send-email-mingw.android@gmail.com>
In-Reply-To: <1391905541-986-1-git-send-email-mingw.android@gmail.com>
References: <1391905541-986-1-git-send-email-mingw.android@gmail.com>
X-IsSubscribed: yes
X-SW-Source: 2014-q1/txt/msg00039.txt.bz2

---
 winsup/cygwin/exceptions.cc | 50 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 46 insertions(+), 4 deletions(-)

diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
index ceddbbc..99392a7 100644
--- a/winsup/cygwin/exceptions.cc
+++ b/winsup/cygwin/exceptions.cc
@@ -113,13 +113,41 @@ error_start_init (const char *buf)
       return;
     }
 
-  char pgm[NT_MAX_PATH];
-  if (!GetModuleFileName (NULL, pgm, NT_MAX_PATH))
+  char pgm[NT_MAX_PATH+5];
+  strcpy(pgm," \"");
+  if (!GetModuleFileName (NULL, pgm+2, NT_MAX_PATH))
     strcpy (pgm, "cygwin1.dll");
   for (char *p = strchr (pgm, '\\'); p; p = strchr (p, '\\'))
     *p = '/';
+  strcat(pgm,"\" ");
 
-  __small_sprintf (debugger_command, "%s \"%s\"", buf, pgm);
+  strcpy(debugger_command, buf);
+  /* Turn all '|' into ' ' */
+  char* bar = debugger_command;
+  while ((bar = strchr(debugger_command, '|')))
+    {
+       *bar = ' ';
+    }
+
+  /* If either <program-name> or <process-id> appears then don't
+     append hardcoded arguments. */
+  int new_style =  (strstr (debugger_command, "<program-name>") != NULL ||
+                    strstr (debugger_command, "<process-id>" ) != NULL) ? 1 : 0;
+
+  /* Only supports one instance of <program-name> as we're space-restricted.  */
+  char* pname = strstr (debugger_command, "<program-name>");
+  if (pname !=0)
+    {
+      char debugger_command_rest[2 * NT_MAX_PATH + 20];
+      strcpy (debugger_command_rest, pname + strlen("<program-name>"));
+      strcpy (pname, pgm);
+      strcat (pname, debugger_command_rest);
+    }
+
+  if (new_style == 0)
+    {
+      strcat(debugger_command, pgm);
+    }
 }
 
 void
@@ -447,7 +475,21 @@ try_to_debug (bool waitloop)
       return 0;
     }
 
-  __small_sprintf (strchr (debugger_command, '\0'), " %u", GetCurrentProcessId ());
+  char* pid = strstr (debugger_command, "<process-id>");
+  if (pid != NULL)
+    {
+      int count = __small_sprintf (pid, " %u ", GetCurrentProcessId ());
+      pid += count;
+      count = strlen("<process-id>") - count;
+      while (count-->0)
+        {
+          *pid++ = ' ';
+        }
+    }
+  else
+    {
+      __small_sprintf (strchr (debugger_command, '\0'), " %u", GetCurrentProcessId ());
+    }
 
   LONG prio = GetThreadPriority (GetCurrentThread ());
   SetThreadPriority (GetCurrentThread (), THREAD_PRIORITY_HIGHEST);
-- 
1.8.5.3
