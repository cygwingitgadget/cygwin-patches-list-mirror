Return-Path: <cygwin-patches-return-4945-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10407 invoked by alias); 11 Sep 2004 02:47:44 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 10397 invoked from network); 11 Sep 2004 02:47:42 -0000
Date: Sat, 11 Sep 2004 02:47:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: Setting the winpid in pinfo
Message-ID: <20040911024905.GF15401@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20040907212602.0085d7f0@incoming.verizon.net> <3.0.5.32.20040907212602.0085d7f0@incoming.verizon.net> <3.0.5.32.20040910212935.007e4310@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20040910212935.007e4310@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q3/txt/msg00097.txt.bz2

On Fri, Sep 10, 2004 at 09:29:35PM -0400, Pierre A. Humblet wrote:
>At 12:15 AM 9/8/2004 -0400, Christopher Faylor wrote:
>>On Tue, Sep 07, 2004 at 09:26:02PM -0400, Pierre A. Humblet wrote:
>
>>>Also, on WinME, simply holding down ^C in the bash shell will
>>>cause a crash (thanks to Errol Smith)
>>>~>     142 [sig] BASH 1853149 handle_threadlist_exception: 
>>>handle_threadlist_exception called with threadlist_ix -1
>>>    1751 [sig] BASH 1853149 handle_exceptions: Exception: 
>>>STATUS_ACCESS_VIOLATION
>>>
>>>Any idea about what's happening? I have been unable to
>>>make any progress.
>>
>>I'll see if I can duplicate the problem with VMware.  That's the only
>>WinME system that I have available to me currently.
>
>Should we appeal for the donation of a small laptop? It wouldn't
>crowd your office much. BTW, I keep my Win95 in my guestroom,
>so my guests can check their e-mail.
>
>Here are 2 other small changes.
>
>When killing the (system stressing) program I used to track the
>fork bug, I noticed that it occasionally leaves stray processes
>behind, as in
>821 49315459       1  557307 4245651837    0  740 20:50:10 /c/HOME/PIERRE/A
>0x821 = PID_INITIALIZING + PID_ORPHANED + PID_IN_USE
>What's happening is that there is a race between the winpids
>scanning in kill_pgrp and the creation of new processes.
>The patch in fork.cc improves the situation by exiting
>children immediately when the parent dies during a fork.
>
>Also a ^C immediately terminates processes that are initializing.
>That is not desirable for processes created by Cygwin processes. 
>The patch in exceptions.cc changes that.

I don't understand.  You're removing an exit on a CTRL-C in
exceptions.cc and essentially adding it to fork.cc.  How is that an
improvement?  Why aren't both parent and child going away when they see a
CTRL-C already?  If the child process has not become fully awake yet
it should just exit now.

cgf
