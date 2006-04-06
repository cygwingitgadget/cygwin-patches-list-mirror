Return-Path: <cygwin-patches-return-5814-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24526 invoked by alias); 6 Apr 2006 00:16:36 -0000
Received: (qmail 24404 invoked by uid 22791); 6 Apr 2006 00:16:35 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-68-163-153-24.bos.east.verizon.net (HELO phumblet.no-ip.org) (68.163.153.24)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 06 Apr 2006 00:16:34 +0000
Received: from [192.168.1.10] (helo=COMPAQ) 	by phumblet.no-ip.org with smtp (Exim 4.60) 	(envelope-from <Pierre.Humblet@ieee.org>) 	id IX9Y3A-0002US-HS 	for cygwin-patches@cygwin.com; Wed, 05 Apr 2006 20:16:22 -0400
Message-Id: <3.0.5.32.20060405201622.009b7100@incoming.verizon.net>
X-Sender: phumblet@incoming.verizon.net
Date: Thu, 06 Apr 2006 00:16:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: Patch to dcrt0.cc for dmalloc
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q2/txt/msg00002.txt.bz2



2006-04-06  Pierre Humblet  <Pierre.Humblet@ieee.org>

	* drct0.cc (dll_crt0_1): Move malloc_init after
user_data->resourcelocks->Init.



diff -u -p -r1.303 dcrt0.cc
--- dcrt0.cc    3 Apr 2006 17:33:07 -0000       1.303
+++ dcrt0.cc    5 Apr 2006 16:07:53 -0000
@@ -784,7 +784,6 @@ static void
 dll_crt0_1 (char *)
 {
   check_sanity_and_sync (user_data);
-  malloc_init ();
 #ifdef CGF
   int i = 0;
   const int n = 2 * 1024 * 1024;
@@ -794,6 +793,7 @@ dll_crt0_1 (char *)
 
   user_data->resourcelocks->Init ();
   user_data->threadinterface->Init ();
+  malloc_init ();
   ProtectHandle (hMainProc);
   ProtectHandle (hMainThread);
