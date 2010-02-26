Return-Path: <cygwin-patches-return-6979-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29524 invoked by alias); 26 Feb 2010 02:36:24 -0000
Received: (qmail 29496 invoked by uid 22791); 26 Feb 2010 02:36:22 -0000
X-SWARE-Spam-Status: No, hits=4.9 required=5.0 	tests=AWL,BAYES_20,BOTNET,HK_OBFDOM
X-Spam-Check-By: sourceware.org
Received: from vms173005pub.verizon.net (HELO vms173005pub.verizon.net) (206.46.173.5)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 26 Feb 2010 02:36:18 +0000
Received: from pool-68-239-42-250.bos.east.verizon.net  ([unknown] [68.239.42.250]) by vms173005.mailsrvcs.net  (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))  with ESMTPA id <0KYF00GJJGK5PMO7@vms173005.mailsrvcs.net> for  cygwin-patches@cygwin.com; Thu, 25 Feb 2010 20:36:10 -0600 (CST)
Message-id: <0KYF00GJLGK5PMO7@vms173005.mailsrvcs.net>
Date: Fri, 26 Feb 2010 02:36:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <phumblet@phumblet.no-ip.org>
Subject: [PATCH] check_access()
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2010-q1/txt/msg00095.txt.bz2

This fixes problem # 3 in http://cygwin.com/ml/cygwin/2010-02/msg00330.html

Pierre

Index: ChangeLog
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/ChangeLog,v
retrieving revision 1.4845
diff -u -r1.4845 ChangeLog
--- ChangeLog   25 Feb 2010 16:55:01 -0000      1.4845
+++ ChangeLog   26 Feb 2010 01:29:30 -0000
@@ -1,3 +1,8 @@
+2010-02-26  Pierre Humblet <Pierre.Humblet@ieee.org>
+
+       * security.cc (check_access): Use user.imp_token if appropriate.
+        Set errno and return if DuplicateTokenEx fails .
+
  2010-02-25  Corinna Vinschen  <corinna@vinschen.de>

         * lc_era.h (lc_era_t): Fix apparent glibc bug in ja_JP era definition.



Index: security.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/security.cc,v
retrieving revision 1.239
diff -u -p -r1.239 security.cc
--- security.cc 3 Nov 2009 09:31:45 -0000       1.239
+++ security.cc 26 Feb 2010 01:24:13 -0000
@@ -751,16 +751,17 @@ check_access (security_descriptor &sd, G
                 ? cygheap->user.imp_token ()
                 : hProcImpToken);

-  if (!tok && !DuplicateTokenEx (hProcToken, MAXIMUM_ALLOWED, NULL,
-                                SecurityImpersonation, TokenImpersonation,
-                                &hProcImpToken))
-#ifdef DEBUGGING
-       system_printf ("DuplicateTokenEx failed, %E");
-#else
-       syscall_printf ("DuplicateTokenEx failed, %E");
-#endif
-  else
-    tok = hProcImpToken;
+  if (!tok)
+    {
+      if (!DuplicateTokenEx (hProcToken, MAXIMUM_ALLOWED, NULL,
+                           SecurityImpersonation, TokenImpersonation,
+                           &hProcImpToken))
+         {
+            __seterrno ();
+            return ret;
+         }
+      tok = hProcImpToken;
+    }

    if (!AccessCheck (sd, tok, desired, &mapping, pset, &plen, 
&granted, &status))
      __seterrno ();
