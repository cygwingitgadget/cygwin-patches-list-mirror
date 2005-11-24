Return-Path: <cygwin-patches-return-5678-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26643 invoked by alias); 24 Nov 2005 22:02:57 -0000
Received: (qmail 26633 invoked by uid 22791); 24 Nov 2005 22:02:57 -0000
X-Spam-Check-By: sourceware.org
Received: from mailout01.sul.t-online.com (HELO mailout01.sul.t-online.com) (194.25.134.80)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 24 Nov 2005 22:02:55 +0000
Received: from fwd34.aul.t-online.de  	by mailout01.sul.t-online.com with smtp  	id 1EfPB7-0008Fh-01; Thu, 24 Nov 2005 23:02:53 +0100
Received: from [10.3.2.2] (ZkYXCoZCQeb8VoiZ84ngNfLpZFME7Ef5LHR07QOs2KyTWBuOgWoN6O@[80.137.71.58]) by fwd34.sul.t-online.de 	with esmtp id 1EfPB5-1gwMCG0; Thu, 24 Nov 2005 23:02:51 +0100
Message-ID: <43863896.4080203@t-online.de>
Date: Thu, 24 Nov 2005 22:02:00 -0000
From: Christian Franke <Christian.Franke@t-online.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8b) Gecko/20050217
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: Allow to send SIGQUIT via Ctrl+BREAK (patch included)
Content-Type: multipart/mixed;  boundary="------------040302040900030002080500"
X-ID: ZkYXCoZCQeb8VoiZ84ngNfLpZFME7Ef5LHR07QOs2KyTWBuOgWoN6O
X-TOI-MSGID: bdcedbf8-7ac8-47e0-9348-5a00a25b934f
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2005-q4/txt/msg00020.txt.bz2

This is a multi-part message in MIME format.
--------------040302040900030002080500
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 634

Hi,

unlike Linux & friends, Cygwin cannot send a SIGQUIT via keyboard.
The SIGQUIT key simulated in termios does only work if app reads from 
console.
Both console events ^C and ^BREAK are mapped to SIGINT.

Suggest to add some option to send SIGQUIT via ^BREAK.

A simple patch is attached.

It sends SIGQUIT on ^BREAK if both VINTR and VQUIT are set to ^C.
As a positive side effect, this disables any other SIGQUIT key in termios.

Testcase:

$ sleep 1000
[^BREAK]

$ ./stty quit ^C
$ sleep 1000
[^BREAK]
Quit (core dumped)

$ ./stty quit ^X
$ sleep 1000
[^BREAK]

$ echo Thanks for any comment
Thanks for any comment

Christian


--------------040302040900030002080500
Content-Type: text/plain;
 name="cygwin-sigbreak-patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygwin-sigbreak-patch.txt"
Content-length: 670

--- exceptions.cc.orig	2005-07-01 17:49:40.001000000 +0200
+++ exceptions.cc	2005-11-24 22:41:02.765867700 +0100
@@ -888,8 +888,13 @@
        that we have handled the signal).  At this point, type should be
        a CTRL_C_EVENT or CTRL_BREAK_EVENT. */
     {
+      int sig = SIGINT;
+      /* If intr and quit are both mapped to ^C, send SIGQUIT on ^BREAK */
+      if (type == CTRL_BREAK_EVENT
+          && t->ti.c_cc[VINTR] == 3 && t->ti.c_cc[VQUIT] == 3)
+        sig = SIGQUIT;
       t->last_ctrl_c = GetTickCount ();
-      killsys (-myself->pid, SIGINT);
+      killsys (-myself->pid, sig);
       t->last_ctrl_c = GetTickCount ();
       return TRUE;
     }

--------------040302040900030002080500--
