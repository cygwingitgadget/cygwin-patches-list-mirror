Return-Path: <cygwin-patches-return-4487-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27475 invoked by alias); 9 Dec 2003 03:11:35 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 27466 invoked from network); 9 Dec 2003 03:11:34 -0000
Message-Id: <3.0.5.32.20031208221010.0082f7b0@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Tue, 09 Dec 2003 03:11:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Re: [Patch]: Fixing the PROCESS_DUP_HANDLE security hole (part
  1).
In-Reply-To: <20031207224017.GA6290@redhat.com>
References: <3.0.5.32.20030929215525.0082c4f0@incoming.verizon.net>
 <3.0.5.32.20030929215525.0082c4f0@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2003-q4/txt/msg00206.txt.bz2

Pierre A. Humblet wrote:
>At 05:40 PM 12/7/2003 -0500, Christopher Faylor wrote:
>>On Mon, Sep 29, 2003 at 09:55:25PM -0400, Pierre A. Humblet wrote:
>>>Here is a patch that allows to open master ttys without giving
>>>full access to the process, at least for access to the ctty. 
>>>
>>>It works by snooping the ctty pipe handles and duplicating them
>>>on the cygheap, for use by future opens in descendant processes.
>>>
>>>It passes all the tests I tried, but considering my lack of knowledge
>>>about ttys, everything is possible.
>>
>>I checked in a variation of this patch.  It restructures the way
>>controlling tty is handled, making it a little easier to deal with
>>/dev/tty at the fhandler level.  I suspect that eventually there will
>>be a fhandler_ctty class but, for now, this seems to work.
>>
>>I'm not 100% certain that I got the close-on-exec stuff right but, fwiw,
>>it seems to work with the combination of ssh/zsh which is usually a
>>pretty tough test for this kind of thing.  I did check to make sure that
>>access to a tty is now not allowed from a non-privileged account thanks
>>to the tty.cc change below.
>>
>>Thanks for the patch and sorry for the delay.
>>
>>cgf
>
>It's mostly fine (rxvt and notty) but starting the following from DOS
>creates a slew of warning from the handler protection code (below).
>However the shell is functional.

When I tried the same dll on an NT4 the errors had disappeared. But that's
a question of luck, i.e. not creating a new handle that matches one that
will be incorrectly deleted multiple times.

I have now traced the problem: when /dev/tty is duplicated, myself->set_ctty
is called again (with the same everything, except new handles), and it 
blindly copies everything over, including the handles.
From there on the test in fhandler_tty_slave::close () doesn't work as 
intended.
Either myself->set_ctty should be smarter, or fhandler_tty_slave::dup
could see if it's about the ctty and simply copy it.

Pierre

 
