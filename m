Return-Path: <cygwin-patches-return-4735-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11829 invoked by alias); 8 May 2004 18:48:31 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11820 invoked from network); 8 May 2004 18:48:30 -0000
Message-Id: <3.0.5.32.20040508144526.0080bdb0@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Sat, 08 May 2004 18:48:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: [Patch]: env -i
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2004-q2/txt/msg00087.txt.bz2

Before:
~: env -i /bin/env
HOMEDRIVE=C:
HOMEPATH=\Documents and Settings\Owner
LOGONSERVER=\\COMPAQ
SYSTEMDRIVE=C:
SYSTEMROOT=C:\WINDOWS
USERDOMAIN=COMPAQ
USERNAME=Owner
USERPROFILE=C:\Documents and Settings\Owner

After:
~: env -i /bin/env
~: 
(but the variables are present with telnet, ssh, etc..)

Pierre

2004-05-08  Pierre Humblet <pierre.humblet@ieee.org>

	* environ.cc (build_env): Only try to construct required-but-missing
	variables while issetuid.



Index: environ.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/environ.cc,v
retrieving revision 1.98
diff -u -p -r1.98 environ.cc
--- environ.cc  8 May 2004 02:55:38 -0000       1.98
+++ environ.cc  8 May 2004 18:34:53 -0000
@@ -910,17 +910,18 @@ build_env (const char * const *envp, cha
 
   assert ((srcp - envp) == n);
   /* Fill in any required-but-missing environment variables. */
-  for (unsigned i = 0; i < SPENVS_SIZE; i++)
-    if (!saw_spenv[i])
-      {
-       *dstp = spenvs[i].retrieve (no_envblock);
-       if (*dstp && !no_envblock && *dstp != env_dontadd)
-         {
-           tl += strlen (*dstp) + 1;
-           dstp++;
-         }
-      }
-
+  if (cygheap->user.issetuid ())
+    for (unsigned i = 0; i < SPENVS_SIZE; i++)
+      if (!saw_spenv[i])
+        {
+         *dstp = spenvs[i].retrieve (no_envblock);
+         if (*dstp && !no_envblock && *dstp != env_dontadd)
+           {
+             tl += strlen (*dstp) + 1;
+             dstp++;
+           }
+       }
+  
   envc = dstp - newenv;                /* Number of entries in newenv */
   assert ((size_t) envc <= (n + SPENVS_SIZE));
   *dstp = NULL;                        /* Terminate */
