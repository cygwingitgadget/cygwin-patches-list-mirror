Return-Path: <cygwin-patches-return-4241-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6339 invoked by alias); 26 Sep 2003 03:05:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 6329 invoked from network); 26 Sep 2003 03:05:44 -0000
Message-Id: <3.0.5.32.20030925225641.00820820@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Fri, 26 Sep 2003 03:05:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Re: {Patch]: Giving access to pinfo after seteuid and exec
In-Reply-To: <20030926022357.GA31116@redhat.com>
References: <20030926021722.GA30575@redhat.com>
 <3.0.5.32.20030925214748.0081f330@incoming.verizon.net>
 <20030926021722.GA30575@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2003-q3/txt/msg00257.txt.bz2

At 10:23 PM 9/25/2003 -0400, you wrote:
>On Thu, Sep 25, 2003 at 10:17:22PM -0400, Christopher Faylor wrote:
>>I'll check in the rest of the spawn.cc stuff with some modifications.  I see
>>I missed some cases with the addition of _P_SYSTEM.
>
>I'm sorry.  Long day.  I'm checking in the non-acl related stuff.  I'll leave
>the rest for Corinna's review.
>
OK.

By the way, in the case      
if (!child)
	{
	  syscall_printf ("pinfo failed");
	  set_errno (EAGAIN);

the EAGAIN is masking the true reason that should have been set by the
pinfo code. That may be Posix, but it's not helpful from a debugging
point of view.

If you still have some energy, in fork.cc the "pinfo forked"
should be checked for error as well.

Pierre

