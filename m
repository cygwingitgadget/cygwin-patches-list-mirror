Return-Path: <cygwin-patches-return-4834-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9049 invoked by alias); 16 Jun 2004 04:40:01 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9025 invoked from network); 16 Jun 2004 04:39:56 -0000
Message-Id: <3.0.5.32.20040616003625.0081c940@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Wed, 16 Jun 2004 04:40:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: [Patch]: Unicode length
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2004-q2/txt/msg00186.txt.bz2

This has not yet been fully tested.

There is a similar problem in str2buf2uni_cat and perhaps
elsewhere, but it's late.
Perhaps the debug_printf should be in sys_mbstowcs.
 
Pierre

2004-06-16  Pierre Humblet <pierre.humblet@ieee.org>

	* security.cc (str2buf2uni): Set the unicode length from the
	return value of sys_mbstowcs().



Index: security.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/security.cc,v
retrieving revision 1.172
diff -u -p -r1.172 security.cc
--- security.cc 28 May 2004 19:50:06 -0000      1.172
+++ security.cc 16 Jun 2004 04:28:10 -0000
@@ -156,13 +156,21 @@ str2buf2lsa (LSA_STRING &tgt, char *buf,
   memcpy (buf, srcstr, tgt.MaximumLength);
 }
 
+/* The dimension of buf is assumed to be at least strlen(srcstr) + 1,
+   The result will be shorter if the input has multibyte chars */
 void
 str2buf2uni (UNICODE_STRING &tgt, WCHAR *buf, const char *srcstr)
 {
-  tgt.Length = strlen (srcstr) * sizeof (WCHAR);
-  tgt.MaximumLength = tgt.Length + sizeof (WCHAR);
+  tgt.MaximumLength = sys_mbstowcs (buf, srcstr, strlen (srcstr) + 1) * sizeof (WCHAR);
+  if (tgt.MaximumLength)
+    tgt.Length = tgt.MaximumLength - sizeof (WCHAR);
+  else
+    {
+      debug_printf ("sys_mbstowcs: %E");
+      tgt.Length = 0;
+    }
   tgt.Buffer = (PWCHAR) buf;
-  sys_mbstowcs (buf, srcstr, tgt.MaximumLength);
+
 }
 
 void
