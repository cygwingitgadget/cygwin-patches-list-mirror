Return-Path: <cygwin-patches-return-4946-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26728 invoked by alias); 11 Sep 2004 03:17:59 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 26718 invoked from network); 11 Sep 2004 03:17:58 -0000
Message-Id: <3.0.5.32.20040910231337.007e0100@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Sat, 11 Sep 2004 03:17:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Re: [Patch]: Setting the winpid in pinfo
In-Reply-To: <20040911024905.GF15401@trixie.casa.cgf.cx>
References: <3.0.5.32.20040910212935.007e4310@incoming.verizon.net>
 <3.0.5.32.20040907212602.0085d7f0@incoming.verizon.net>
 <3.0.5.32.20040907212602.0085d7f0@incoming.verizon.net>
 <3.0.5.32.20040910212935.007e4310@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2004-q3/txt/msg00098.txt.bz2

At 10:49 PM 9/10/2004 -0400, Christopher Faylor wrote:
>On Fri, Sep 10, 2004 at 09:29:35PM -0400, Pierre A. Humblet wrote:

>>Here are 2 other small changes.
>>
>>When killing the (system stressing) program I used to track the
>>fork bug, I noticed that it occasionally leaves stray processes
>>behind, as in
>>821 49315459       1  557307 4245651837    0  740 20:50:10 /c/HOME/PIERRE/A
>>0x821 = PID_INITIALIZING + PID_ORPHANED + PID_IN_USE
>>What's happening is that there is a race between the winpids
>>scanning in kill_pgrp and the creation of new processes.
>>The patch in fork.cc improves the situation by exiting
>>children immediately when the parent dies during a fork.
>>
>>Also a ^C immediately terminates processes that are initializing.
>>That is not desirable for processes created by Cygwin processes. 
>>The patch in exceptions.cc changes that.
>
>I don't understand.  You're removing an exit on a CTRL-C in
>exceptions.cc and essentially adding it to fork.cc.
 
The change in fork.cc affects all signals, not only ^C
Without the change, you get those stray orphan processes
on "kill -9 parent". And 5 minutes (FORK_WAIT_TIMEOUT) later
you get a fatal_api message on your screen, for no apparent reasons.

> How is that an improvement?  Why aren't both parent and child going away 
> when they see a CTRL-C already?
  
The parent may have chosen to ignore the ^C, in which case it will 
stay alive. Its fork will then fail unexpectedly. Few programs are
designed to retry on a failed fork. With the change, all goes well.

>If the child process has not become fully awake yet it should just exit now.

Not if it is destined to ignore ^C. The group leader will wait until the 
[grand]child has grown up and its sendsig is != NULL, and then send the
signal.
The child will then handle it properly.

The motivation for looking at this was
<http://cygwin.com/ml/cygwin/2004-07/msg01120.html>, as well as personal
observations. I have run thousands of tests and eveything has gone well.

Pierre
