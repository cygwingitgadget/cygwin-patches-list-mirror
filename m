Return-Path: <cygwin-patches-return-5077-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21898 invoked by alias); 24 Oct 2004 01:15:48 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 21889 invoked from network); 24 Oct 2004 01:15:47 -0000
Message-Id: <3.0.5.32.20041023211115.0082d3f0@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Sun, 24 Oct 2004 01:15:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: [Patch] registry issues
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2004-q4/txt/msg00078.txt.bz2

This should fix the first two issues in the recent mail
to cygwin-developers.
It's currently untested (need an NT machine).

Pierre

2004-10-24  Pierre Humblet <pierre.humblet@ieee.org>

	* registry.cc (get_registry_hive_path): Simplify and add a
	debug_printf in case of failure.
	(load_registry_hive): Revert 2004-04-19 change.	


Index: registry.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/registry.cc,v
retrieving revision 1.19
diff -u -p -r1.19 registry.cc
--- registry.cc 19 Apr 2004 19:29:10 -0000      1.19
+++ registry.cc 24 Oct 2004 01:01:31 -0000
@@ -211,14 +211,15 @@ get_registry_hive_path (const PSID psid,
       char buf[256];
       DWORD type, siz;
 
-      key[0] = '\0';
+      path[0] = '\0';
       if (!RegQueryValueExA (hkey, "ProfileImagePath", 0, &type,
-                            (BYTE *)buf, (siz = 256, &siz)))
-       ExpandEnvironmentStringsA (buf, key, 256);
+                            (BYTE *)buf, (siz = sizeof (buf), &siz)))
+       ExpandEnvironmentStringsA (buf, path, CYG_MAX_PATH + 1);
       RegCloseKey (hkey);
-      if (key[0])
-       return strcpy (path, key);
+      if (path[0])
+       return path;
     }
+  debug_printf ("HKLM\\%s not found", key);
   return NULL;
 }
 
@@ -241,7 +242,8 @@ load_registry_hive (PSID psid)
       RegCloseKey (hkey);
       return;
     }
-  enable_restore_privilege ();
+  /* This is only called while deimpersonated */
+  set_process_privilege (SE_RESTORE_NAME);
   if (get_registry_hive_path (psid, path))
     {
       strcat (path, "\\NTUSER.DAT");
