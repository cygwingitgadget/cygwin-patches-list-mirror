Return-Path: <cygwin-patches-return-2278-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 19638 invoked by alias); 1 Jun 2002 22:08:49 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19623 invoked from network); 1 Jun 2002 22:08:48 -0000
Message-ID: <06eb01c209b9$11c491d0$6132bc3e@BABEL>
From: "Conrad Scott" <Conrad.Scott@dsl.pipex.com>
To: <cygwin-patches@cygwin.com>
Subject: strace -f fix
Date: Sat, 01 Jun 2002 15:08:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q2/txt/msg00261.txt.bz2

I've been playing around with the strace program some more and noticed a
minor glitch: it's only meant to trace forked children if the -f flag is
given on the command line. Unfortunately it currently always traces
children, and the this flag has no effect.

Having read the MS documentation, I fully understand this: the documentation
of the relevant flag (DEBUG_ONLY_THIS_PROCESS) is at the least utterly
ambiguous and most likely contradictory.

Anyhow, the upshot is that the DEBUG_PROCESS flag should be given to
CreateProcess() only if children are to be debugged; otherwise the
DEBUG_ONLY_THIS_PROCESS flag should be given. This isn't the scheme in
utils/strace.cc, so I've appended a tiny patch. As it's a trivial patch and
my assignment form has probably yet to reach RedHat, please make what use
you can of it.

// Conrad

diff -u -u -r1.20 strace.cc
--- strace.cc 27 May 2002 01:49:08 -0000 1.20
+++ strace.cc 1 Jun 2002 21:39:39 -0000
@@ -314,8 +314,8 @@

   /* cygwin32_conv_to_win32_path (exec_file, real_path); */

-  flags = forkdebug ? 0 : DEBUG_ONLY_THIS_PROCESS;
-  flags |= CREATE_DEFAULT_ERROR_MODE | DEBUG_PROCESS;
+  flags = forkdebug ? DEBUG_PROCESS : DEBUG_ONLY_THIS_PROCESS;
+  flags |= CREATE_DEFAULT_ERROR_MODE;
   flags |= (new_window ? CREATE_NEW_CONSOLE | CREATE_NEW_PROCESS_GROUP :
0);

   make_command_line (one_line, argv);


