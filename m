Return-Path: <cygwin-patches-return-7625-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20201 invoked by alias); 29 Mar 2012 02:56:17 -0000
Received: (qmail 20101 invoked by uid 22791); 29 Mar 2012 02:56:14 -0000
X-SWARE-Spam-Status: No, hits=2.1 required=5.0	tests=AWL,BAYES_00,TW_RX,T_RP_MATCHES_RCVD
X-Spam-Check-By: sourceware.org
Received: from elfmimi.jp (HELO mx.elfmimi.jp) (61.197.227.216)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 29 Mar 2012 02:55:54 +0000
Received: from [127.0.0.1] (AspiringElf.elfmimi [192.168.0.6])	by mx.elfmimi.jp (Postfix) with ESMTP id 814751D1DE	for <cygwin-patches@cygwin.com>; Thu, 29 Mar 2012 12:27:32 +0900 (JST)
Message-ID: <4F73CF37.4020001@elfmimi.jp>
Date: Thu, 29 Mar 2012 02:56:00 -0000
From: Ein Terakawa <applause@elfmimi.jp>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:11.0) Gecko/20120312 Thunderbird/11.0
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [PATCH] Ctrl-C and non-Cygwin programs
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
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
X-SW-Source: 2012-q1/txt/msg00048.txt.bz2

This is a proof of concept demonstration which
makes Ctrl-C behave in a way a lot of people expect
concerning non-Cygwin console programs.

What it does actually is it generates CTRL_BREAK_EVENT with 
Windows Console API GenerateConsoleCtrlEvent on the arrival of SIGINT.
And to make this scheme to be functional it is required to specify
CREATE_NEW_PROCESS_GROUP when creating new non-Cygwin processes.

To my surprise there seem to be no way to generate CTRL_C_EVENT using API.

I must also point out that virtually all of the terminal emulators
are sneakily keeping hidden Windows Console in the background.
Thus several features of the Windows Console is still available to
processes running in the cygwin environment.
One of such features is this 'process group' and the other one is
'code page' which you manipulate with chcp.com utility.


Following is a bunch of random posts, I picked up from this list, 
talking about the same topic. Ordered by its significance under my judge.
These should help you understand (or remind) what it is about.


Date: Mon, 04 Dec 2006 06:24:41 -0800
Subject: Re: Ctrl-C and non-cygwin programs
http://cygwin.com/ml/cygwin/2006-12/msg00151.html

Date: Thu, 20 May 2010 22:50:49 +0000 (UTC)
Subject: A workaround for CTRL-C not working on Windows console apps in ptys
http://sourceware.org/ml/cygwin/2010-05/msg00524.html

Date: Mon, 19 Jan 2009 11:41:51 -0500
Subject: Signal handling in WIN32 console programs
http://sourceware.org/ml/cygwin/2009-01/msg00587.html

Date: Fri, 24 Aug 2001 17:25:14 -0400
Subject: control-c issue when running VC++ console programs in bash.exe
http://cygwin.com/ml/cygwin/2001-08/msg01111.html


As you can see this is a haunting problem and
the situation hasn't changed a bit over this past decade.
At least please let this issue be added to the FAQ.

I believe this patch is fairly small and worth giving a field test.


Lastly first third of the patch is a workaround of a problem observed
with cygwin1.dll of cvs HEAD.
To reproduce:
1. Launch a terminal emulator like rxvt or mintty.
2. Execute cmd.exe or more.com from shell prompt.
3. Type in Enter, Ctrl-C, then Enter again.
Whole processes including the terminal emulator will just hung up.

---
ChangeLog for winsup/cygwin:

2012-03-28  Ein Terakawa <applause@elfmimi.jp>

	* exceptions.cc: (sigpacket::process) Do not sigflush in response
	to SIGINT for a non-Cygwin process to work around hung-up.
	Translate SIGINT into CTRL_BREAK_EVENT for a non-Cygwin process.
	* spawn.cc: (child_info_spawn::worker) CREATE_NEW_PROCESS_GROUP for
	each new non-Cygwin process.
---
Index: winsup/cygwin/exceptions.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/exceptions.cc,v
retrieving revision 1.375
diff -c -p -r1.375 exceptions.cc
*** winsup/cygwin/exceptions.cc	12 Feb 2012 22:43:33 -0000	1.375
--- winsup/cygwin/exceptions.cc	28 Mar 2012 14:39:58 -0000
*************** sigpacket::process ()
*** 1166,1171 ****
--- 1166,1174 ----
    switch (si.si_signo)
      {
      case SIGINT:
+       if (have_execed)
+         break;
+       /* fall through */
      case SIGQUIT:
      case SIGSTOP:
      case SIGTSTP:
*************** sigpacket::process ()
*** 1252,1257 ****
--- 1255,1266 ----
        if (si.si_signo == SIGTSTP || si.si_signo == SIGTTIN || si.si_signo == SIGTTOU)
  	goto stop;
  
+       if (si.si_signo == SIGINT && have_execed)
+         {
+           GenerateConsoleCtrlEvent(CTRL_BREAK_EVENT, GetProcessId(ch_spawn));
+           goto done;
+         }
+ 
        goto exit_sig;
      }
  
Index: winsup/cygwin/spawn.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/spawn.cc,v
retrieving revision 1.329
diff -c -p -r1.329 spawn.cc
*** winsup/cygwin/spawn.cc	21 Mar 2012 15:54:50 -0000	1.329
--- winsup/cygwin/spawn.cc	28 Mar 2012 14:39:58 -0000
*************** child_info_spawn::worker (const char *pr
*** 573,579 ****
    cygbench ("spawn-worker");
  
    if (!real_path.iscygexec())
!     ::cygheap->fdtab.set_file_pointers_for_exec ();
  
    moreinfo->envp = build_env (envp, envblock, moreinfo->envc,
  			      real_path.iscygexec ());
--- 573,582 ----
    cygbench ("spawn-worker");
  
    if (!real_path.iscygexec())
!     {
!       ::cygheap->fdtab.set_file_pointers_for_exec ();
!       c_flags |= CREATE_NEW_PROCESS_GROUP;
!     }
  
    moreinfo->envp = build_env (envp, envblock, moreinfo->envc,
  			      real_path.iscygexec ());
