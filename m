Return-Path: <cygwin-patches-return-5148-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16806 invoked by alias); 20 Nov 2004 18:56:18 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 16429 invoked from network); 20 Nov 2004 18:56:13 -0000
Received: from unknown (HELO phumblet.no-ip.org) (68.163.190.188)
  by sourceware.org with SMTP; 20 Nov 2004 18:56:13 -0000
Received: from [192.168.1.156] (helo=hpn5170)
	by phumblet.no-ip.org with smtp (Exim 4.43)
	id I7HRF1-002VRL-8C
	for cygwin-patches@cygwin.com; Sat, 20 Nov 2004 13:59:25 -0500
Message-Id: <3.0.5.32.20041120135116.007e8ae0@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Sat, 20 Nov 2004 18:56:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: [Patch] debug_printf edits
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2004-q4/txt/msg00149.txt.bz2

Here are minor changes that facilitate grepping traces. 

Pierre

2004-11-20  Pierre Humblet <pierre.humblet@ieee.org>

	* fhandler.cc (fhandler::write): Remove debug_printf.
	* pipe.cc (fhandler_pipe::create): Edit syscall_printf format.

Index: fhandler.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler.cc,v
retrieving revision 1.206
diff -u -p -r1.206 fhandler.cc
--- fhandler.cc 12 Sep 2004 03:47:56 -0000      1.206
+++ fhandler.cc 20 Nov 2004 18:52:33 -0000
@@ -914,7 +914,6 @@ fhandler_base::write (const void *ptr, s
        }
     }
 
-  debug_printf ("%d = write (%p, %d)", res, ptr, len);
   return res;
 }
 
Index: pipe.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/pipe.cc,v
retrieving revision 1.64
diff -u -p -r1.64 pipe.cc
--- pipe.cc     12 Sep 2004 03:47:56 -0000      1.64
+++ pipe.cc     20 Nov 2004 18:52:33 -0000
@@ -380,7 +380,7 @@ fhandler_pipe::create (fhandler_pipe *fh
        }
     }
 
-  syscall_printf ("%d = ([%p, %p], %d, %p)", res, fhs[0], fhs[1], psize,
mode);
+  syscall_printf ("%d = pipe ([%p, %p], %d, %p)", res, fhs[0], fhs[1],
psize, mode);
   return res;
 }
 
