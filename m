Return-Path: <cygwin-patches-return-4483-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14123 invoked by alias); 8 Dec 2003 03:25:12 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 14114 invoked from network); 8 Dec 2003 03:25:11 -0000
Message-Id: <3.0.5.32.20031207222431.00829420@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Mon, 08 Dec 2003 03:25:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Re: [Patch]: Fixing the PROCESS_DUP_HANDLE security hole (part
  1).
In-Reply-To: <20031207224017.GA6290@redhat.com>
References: <3.0.5.32.20030929215525.0082c4f0@incoming.verizon.net>
 <3.0.5.32.20030929215525.0082c4f0@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2003-q4/txt/msg00202.txt.bz2

At 05:40 PM 12/7/2003 -0500, Christopher Faylor wrote:
>On Mon, Sep 29, 2003 at 09:55:25PM -0400, Pierre A. Humblet wrote:
>>Here is a patch that allows to open master ttys without giving
>>full access to the process, at least for access to the ctty. 
>>
>>It works by snooping the ctty pipe handles and duplicating them
>>on the cygheap, for use by future opens in descendant processes.
>>
>>It passes all the tests I tried, but considering my lack of knowledge
>>about ttys, everything is possible.
>
>I checked in a variation of this patch.  It restructures the way
>controlling tty is handled, making it a little easier to deal with
>/dev/tty at the fhandler level.  I suspect that eventually there will
>be a fhandler_ctty class but, for now, this seems to work.
>
>I'm not 100% certain that I got the close-on-exec stuff right but, fwiw,
>it seems to work with the combination of ssh/zsh which is usually a
>pretty tough test for this kind of thing.  I did check to make sure that
>access to a tty is now not allowed from a non-privileged account thanks
>to the tty.cc change below.
>
>Thanks for the patch and sorry for the delay.
>
>cgf

It's mostly fine (rxvt and notty) but starting the following from DOS
creates a slew of warning from the handler protection code (below).
However the shell is functional.
tty reports /dev/tty, instead of /dev/ttyN with 1.5.5

@echo off
set CYGWIN=tty
C:
chdir \progra~1\cygwin\bin
bash --login -i

Pierre

Sorry, it's missing the top but that's all I can paste from the DOS
windows on ME.

 328926 [main] BASH 50298593! mark_closed: attempt to close protected
handle voi
d sigproc_init():604(signal_arrived<0xE4>) winpid -50298593
 339822 [main] BASH 50298593! mark_closed:  by virtual int
fhandler_tty_common::
close():1151(ioctl_done_event<0xE4>)
 361168 [main] BASH 50298593! mark_closed: closing protected handle int
spawn_gu
ts(const char*, const char* const*, const char* const*,
int):395(subproc_ready<0
xD4>)
 363640 [main] BASH 50298593! mark_closed:  by virtual int
fhandler_tty_common::
close():1159(output_mutex<0xD4>)
 369935 [main] BASH 50298593! mark_closed: attempt to close protected
handle voi
d sigproc_init():604(signal_arrived<0xE4>) winpid -50298593
  29407 [main] id 50298593 mark_closed: closing protected handle void
sigproc_in
it():604(signal_arrived<0xD8>)
  34781 [main] id 50298593 mark_closed:  by virtual int
fhandler_tty_common::clo
se():1157(input_mutex<0xD8>)
 375411 [main] BASH 50298593! mark_closed:  by virtual int
fhandler_tty_common::
close():1151(ioctl_done_event<0xE4>)
 386473 [main] BASH 50298593! spawn_guts: wait failed: nwait 3, pid
50298593, wi
npid -50323745, Win32 error 6
 400722 [main] BASH 50298593! spawn_guts: waitbuf[0] 0x158 0
 400848 [main] BASH 50298593! spawn_guts: waitbuf[1] 0xE4 = 258
 401379 [main] BASH 50298593! spawn_guts: waitbuf[w] 0xD4 = -1
.bash_profile

Have mailbox
 567659 [main] BASH 85913! mark_closed: attempt to close protected handle
void s
igproc_init():604(signal_arrived<0xE4>) winpid -85913
 578034 [main] BASH 85913! mark_closed:  by virtual int
fhandler_tty_common::clo
se():1151(ioctl_done_event<0xE4>)
 581260 [main] BASH 85913! mark_closed: closing protected handle int
spawn_guts(
const char*, const char* const*, const char* const*,
int):395(subproc_ready<0xD4
>)
   9793 [main] dircolors 85913 mark_closed: closing protected handle void
sigpro
c_init():604(signal_arrived<0xD8>)
  14530 [main] dircolors 85913 mark_closed:  by virtual int
fhandler_tty_common:
:close():1157(input_mutex<0xD8>)
 589175 [main] BASH 85913! mark_closed:  by virtual int
fhandler_tty_common::clo
se():1159(output_mutex<0xD4>)
 612646 [main] BASH 85913! mark_closed: attempt to close protected handle
void s
igproc_init():604(signal_arrived<0xE4>) winpid -85913
 614399 [main] BASH 85913! mark_closed:  by virtual int
fhandler_tty_common::clo
se():1151(ioctl_done_event<0xE4>)
 614870 [main] BASH 85913! spawn_guts: wait failed: nwait 3, pid 85913,
winpid -
46434897, Win32 error 6
 615685 [main] BASH 85913! spawn_guts: waitbuf[0] 0x158 0
 616454 [main] BASH 85913! spawn_guts: waitbuf[1] 0xE4 = 258
 616527 [main] BASH 85913! spawn_guts: waitbuf[w] 0xD4 = -1
~:
   
