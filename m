Return-Path: <cygwin-patches-return-5300-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5200 invoked by alias); 8 Jan 2005 05:04:52 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5072 invoked from network); 8 Jan 2005 05:04:45 -0000
Received: from unknown (HELO phumblet.no-ip.org) (68.163.205.203)
  by sourceware.org with SMTP; 8 Jan 2005 05:04:45 -0000
Received: from [192.168.1.156] (helo=hpn5170)
	by phumblet.no-ip.org with smtp (Exim 4.43)
	id I9ZFMC-006MVX-1Y
	for cygwin-patches@cygwin.com; Sat, 08 Jan 2005 00:08:36 -0500
Message-Id: <3.0.5.32.20050107235918.00827de0@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Sat, 08 Jan 2005 05:04:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: [Patch]: seteuid
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2005-q1/txt/msg00003.txt.bz2

Currently the process default dacl is changed in seteuid even
when seteuid fails. This is a potentially security hole.
The patch fixes it.

Also HKCU is not closed anymore, as it is not used by Cygwin.
It's now up to applications (if any) to close it, and they should
keep MS KB 199190 in mind.

Pierre

2005-01-08  Pierre Humblet <pierre.humblet@ieee.org>

	* syscalls.cc (seteuid32): Only change the default dacl when
	seteuid succeeds. Do not close HKCU.


Index: syscalls.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/syscalls.cc,v
retrieving revision 1.355
diff -u -p -r1.355 syscalls.cc
--- syscalls.cc 6 Jan 2005 22:10:08 -0000       1.355
+++ syscalls.cc 8 Jan 2005 00:56:42 -0000
@@ -2066,7 +2066,7 @@ seteuid32 (__uid32_t uid)
   if (!wincap.has_security () && pw_new)
     {
       load_registry_hive (pw_new->pw_name);
-    goto success_9x;
+      goto success_9x;
     }
   if (!usersid.getfrompw (pw_new))
     {
@@ -2103,16 +2103,6 @@ seteuid32 (__uid32_t uid)
 
   debug_printf ("Found token %d", new_token);
 
-  /* Set process def dacl to allow access to impersonated token */
-  if (sec_acl ((PACL) dacl_buf, true, true, usersid))
-    {
-      tdacl.DefaultDacl = (PACL) dacl_buf;
-      if (!SetTokenInformation (ptok, TokenDefaultDacl,
-                               &tdacl, sizeof dacl_buf))
-       debug_printf ("SetTokenInformation"
-                     "(TokenDefaultDacl), %E");
-    }
-
   /* If no impersonation token is available, try to
      authenticate using NtCreateToken () or subauthentication. */
   if (new_token == INVALID_HANDLE_VALUE)
@@ -2132,6 +2122,16 @@ seteuid32 (__uid32_t uid)
       cygheap->user.internal_token = new_token;
     }
 
+  /* Set process def dacl to allow access to impersonated token */
+  if (sec_acl ((PACL) dacl_buf, true, true, usersid))
+    {
+      tdacl.DefaultDacl = (PACL) dacl_buf;
+      if (!SetTokenInformation (ptok, TokenDefaultDacl,
+                               &tdacl, sizeof dacl_buf))
+       debug_printf ("SetTokenInformation"
+                     "(TokenDefaultDacl), %E");
+    }
+
   if (new_token != ptok)
     {
       /* Avoid having HKCU use default user */
@@ -2166,11 +2166,8 @@ success_9x:
   cygheap->user.set_name (pw_new->pw_name);
   myself->uid = uid;
   groups.ischanged = FALSE;
-  if (!issamesid) /* MS KB 199190 */
-    {
-      RegCloseKey (HKEY_CURRENT_USER);
-      user_shared_initialize (true);
-    }
+  if (!issamesid)
+    user_shared_initialize (true);
   return 0;
 
 failed:
