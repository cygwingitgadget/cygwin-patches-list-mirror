Return-Path: <cygwin-patches-return-5777-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21317 invoked by alias); 27 Feb 2006 20:45:53 -0000
Received: (qmail 21305 invoked by uid 22791); 27 Feb 2006 20:45:51 -0000
X-Spam-Check-By: sourceware.org
Received: from ACCESS1.CIMS.NYU.EDU (HELO access1.cims.nyu.edu) (128.122.81.155)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Mon, 27 Feb 2006 20:45:49 +0000
Received: from localhost (localhost [127.0.0.1]) 	by access1.cims.nyu.edu (8.12.10+Sun/8.12.10) with ESMTP id k1RKjmfo003904; 	Mon, 27 Feb 2006 15:45:48 -0500 (EST)
Date: Mon, 27 Feb 2006 20:45:00 -0000
From: Igor Peshansky <pechtcha@cs.nyu.edu>
Reply-To: cygwin@cygwin.com
To: =?ISO-8859-15?Q?Marjan_Er=B8en?= <merzen@masktech.de>
cc: cygwin-patches@cygwin.com
Subject: Re: Try to remove possible race pinfo::init
In-Reply-To: <440361F8.4010007@masktech.de>
Message-ID: <Pine.GSO.4.63.0602271540290.2491@access1.cims.nyu.edu>
References: <440361F8.4010007@masktech.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q1/txt/msg00086.txt.bz2

On Mon, 27 Feb 2006, Marjan Er?en wrote:

> Hi there!
>
> I'm trying to find out why my cygwin system gets unstable after a while.
> The symptoms are:
> - the message "fork: Resource temporarily unavailable"
> - make sometimes just exits with exit code -1
> - exiting all cygwin processes seems to temporarily resolve the issue - but this is not a
>   nice workaround
>
> Once the system is unstable, it is quite easy to reproduce the problem.
> The following simple command line is sufficient and usually stops after
> just a few seconds:
>
> > $ bash -c "while : ; do /bin/true; done"
> > bash: fork: Resource temporarily unavailable
>
> So I used this command line to find out more:
> > $ strace -f bash -c "while : ; do /bin/true; done" 2>&1 | less
> and the interesting part of the output seems to be:
>
> >    26 22254451 [main] bash 3336 sig_send: sendsig 0x6CC, pid 3336, signal -40, its_me 1
> >    27 22254478 [main] bash 3336 sig_send: wakeup 0x694
> >    32 22254510 [main] bash 3336 sig_send: Waiting for pack.wakeup 0x694
> >    31 22254541 [sig] bash 3336 wait_sig: signalling pack.wakeup 0x694
> >    35 22254576 [main] bash 3336 sig_send: returning 0x0 from sending signal -40
> >   332 22254908 [main] bash 3336 frok::parent: priority class 32
> >   111 22255019 [main] bash 3336 frok::parent: stack - bottom 0x240000, top 0x23E7B0, size 6224
> >   145 22255164 [main] bash 3336 frok::parent: CreateProcess (C:\tools\cygwin\bin\bash.exe, C:\tools\cygwin\bin\bash.exe, 0, 0, 1,
> 0x20, 0, 0, 0x23E710, 0x23E780)
> >  2844 22258008 [main] bash 3336 open_shared: name Global\cygwin1S4.cygpid.1848, n 1848, shared 0x18CF0000 (wanted 0x0), h 0x66C
> >   192 22258200 [main] bash 3336 pinfo::init: looping because pid 1848, procinfo->pid 1848, procinfo->dwProcessid 1552 has
> PID_EXITED set
> > 26868 22285068 [main] bash 3336 open_shared: name (null), n 1848, shared 0x18CF0000 (wanted 0x0), h 0x66C
> >   204 22285272 [main] bash 3336 pinfo::init: looping because pid 1848, procinfo->pid 1848, procinfo->dwProcessid 1552 has
> PID_EXITED set
> >   115 22285387 [main] bash 3336 open_shared: name (null), n 1848, shared 0x18CF0000 (wanted 0x0), h 0x66C
> >    35 22285422 [main] bash 3336 pinfo::init: looping because pid 1848, procinfo->pid 1848, procinfo->dwProcessid 1552 has
> PID_EXITED set
> >   549 22285971 [main] bash 3336 open_shared: name (null), n 1848, shared 0x18CF0000 (wanted 0x0), h 0x66C
> >    43 22286014 [main] bash 3336 pinfo::init: looping because pid 1848, procinfo->pid 1848, procinfo->dwProcessid 1552 has
> PID_EXITED set
> >   221 22286235 [main] bash 3336 open_shared: name (null), n 1848, shared 0x18CF0000 (wanted 0x0), h 0x66C
> >    34 22286269 [main] bash 3336 pinfo::init: looping because pid 1848, procinfo->pid 1848, procinfo->dwProcessid 1552 has
> PID_EXITED set
> >   139 22286408 [main] bash 3336 open_shared: name (null), n 1848, shared 0x18CF0000 (wanted 0x0), h 0x66C
> >    34 22286442 [main] bash 3336 pinfo::init: looping because pid 1848, procinfo->pid 1848, procinfo->dwProcessid 1552 has
> PID_EXITED set
> >    51 22286493 [main] bash 3336 open_shared: name (null), n 1848, shared 0x18CF0000 (wanted 0x0), h 0x66C
> >    32 22286525 [main] bash 3336 pinfo::init: looping because pid 1848, procinfo->pid 1848, procinfo->dwProcessid 1552 has
> PID_EXITED set
> >    50 22286575 [main] bash 3336 open_shared: name (null), n 1848, shared 0x18CF0000 (wanted 0x0), h 0x66C
> >    31 22286606 [main] bash 3336 pinfo::init: looping because pid 1848, procinfo->pid 1848, procinfo->dwProcessid 1552 has
> PID_EXITED set
> >    50 22286656 [main] bash 3336 open_shared: name (null), n 1848, shared 0x18CF0000 (wanted 0x0), h 0x66C
> >    30 22286686 [main] bash 3336 pinfo::init: looping because pid 1848, procinfo->pid 1848, procinfo->dwProcessid 1552 has
> PID_EXITED set
> >    49 22286735 [main] bash 3336 open_shared: name (null), n 1848, shared 0x18CF0000 (wanted 0x0), h 0x66C
> >    31 22286766 [main] bash 3336 pinfo::init: looping because pid 1848, procinfo->pid 1848, procinfo->dwProcessid 1552 has
> PID_EXITED set
> >    48 22286814 [main] bash 3336 open_shared: name (null), n 1848, shared 0x18CF0000 (wanted 0x0), h 0x66C
> >    30 22286844 [main] bash 3336 pinfo::init: looping because pid 1848, procinfo->pid 1848, procinfo->dwProcessid 1552 has
> PID_EXITED set
> >    50 22286894 [main] bash 3336 open_shared: name (null), n 1848, shared 0x18CF0000 (wanted 0x0), h 0x66C
> >    88 22286982 [main] bash 3336 pinfo::init: looping because pid 1848, procinfo->pid 1848, procinfo->dwProcessid 1552 has
> PID_EXITED set
> >    90 22287072 [main] bash 3336 open_shared: name (null), n 1848, shared 0x18CF0000 (wanted 0x0), h 0x66C
> >   147 22287219 [main] bash 3336 pinfo::init: looping because pid 1848, procinfo->pid 1848, procinfo->dwProcessid 1552 has
> PID_EXITED set
> >   101 22287320 [main] bash 3336 open_shared: name (null), n 1848, shared 0x18CF0000 (wanted 0x0), h 0x66C
> >    34 22287354 [main] bash 3336 pinfo::init: looping because pid 1848, procinfo->pid 1848, procinfo->dwProcessid 1552 has
> PID_EXITED set
> >    51 22287405 [main] bash 3336 open_shared: name (null), n 1848, shared 0x18CF0000 (wanted 0x0), h 0x66C
> >    30 22287435 [main] bash 3336 pinfo::init: looping because pid 1848, procinfo->pid 1848, procinfo->dwProcessid 1552 has
> PID_EXITED set
> >    50 22287485 [main] bash 3336 open_shared: name (null), n 1848, shared 0x18CF0000 (wanted 0x0), h 0x66C
> >    30 22287515 [main] bash 3336 pinfo::init: looping because pid 1848, procinfo->pid 1848, procinfo->dwProcessid 1552 has
> PID_EXITED set
> >    49 22287564 [main] bash 3336 open_shared: name (null), n 1848, shared 0x18CF0000 (wanted 0x0), h 0x66C
> >    30 22287594 [main] bash 3336 pinfo::init: looping because pid 1848, procinfo->pid 1848, procinfo->dwProcessid 1552 has
> PID_EXITED set
> >    50 22287644 [main] bash 3336 open_shared: name (null), n 1848, shared 0x18CF0000 (wanted 0x0), h 0x66C
> >    29 22287673 [main] bash 3336 pinfo::init: looping because pid 1848, procinfo->pid 1848, procinfo->dwProcessid 1552 has
> PID_EXITED set
> >    49 22287722 [main] bash 3336 open_shared: name (null), n 1848, shared 0x18CF0000 (wanted 0x0), h 0x66C
> >    31 22287753 [main] bash 3336 pinfo::init: looping because pid 1848, procinfo->pid 1848, procinfo->dwProcessid 1552 has
> PID_EXITED set
> >   129 22287882 [main] bash 3336 open_shared: name (null), n 1848, shared 0x18CF0000 (wanted 0x0), h 0x66C
> >    35 22287917 [main] bash 3336 pinfo::init: looping because pid 1848, procinfo->pid 1848, procinfo->dwProcessid 1552 has
> PID_EXITED set
> >   988 22288905 [main] bash 3336 frok::parent: pinfo failed
> >   108 22289013 [main] bash 3336 frok::parent: returning -1
> >    29 22289042 [main] bash 3336 fork: fork failed - child pid 1848, errno 11
> >    26 22289068 [main] bash 3336 __set_errno: int fork():546 val 11
> >   123 22289191 [main] bash 3336 sig_send: sendsig 0x6CC, pid 3336, signal -41, its_me 1
> >    38 22289229 [main] bash 3336 sig_send: wakeup 0x694
> >    82 22289311 [main] bash 3336 sig_send: Waiting for pack.wakeup 0x694
> >    41 22289352 [sig] bash 3336 wait_sig: signalling pack.wakeup 0x694
> >    38 22289390 [main] bash 3336 sig_send: returning 0x0 from sending signal -41
> >    82 22289311 [main] bash 3336 sig_send: Waiting for pack.wakeup 0x694
> >    41 22289352 [sig] bash 3336 wait_sig: signalling pack.wakeup 0x694
> >    38 22289390 [main] bash 3336 sig_send: returning 0x0 from sending signal -41
> >    92 22289482 [main] bash 3336 fork: -1 = fork()
> >   321 22289803 [main] bash 3336 fhandler_base::write: binary write
> > bash: fork: Resource temporarily unavailable
> >   977 22290780 [main] bash 3336 set_signal_mask: oldmask 0x80002, newmask 0x0, mask_bits 0x80002
>
> The "Resource temporarily unavailable" seems to come from the
> pinfo::init(), looping 20 times waiting for PID_EXITED, but PID_EXITED
> is not being set.  The relevant code is in pinfo.cc, Revision 1.225:
>
> 256:       /* In certain pathological cases, it is possible for the shared memory
> 257:         region to exist for a while after a process has exited.  This should
> 258:         only be a brief occurrence, so rather than introduce some kind of
> 259:         locking mechanism, just loop.  */
> 260:       if (!created && createit && (procinfo->process_state & PID_EXITED))
> 261:        {
> 262:          debug_printf ("looping because pid %d, procinfo->pid %d, "
> 263:                        "procinfo->dwProcessid %u has PID_EXITED set",
> 264:                        n, procinfo->pid, procinfo->dwProcessId);
> 265:          goto loop;
> 266:        }
>
> It looks as if the loop runs too fast, not allowing the PID_EXITED flag
> to be reset. Once upon a time, this code had a "low_priority_sleep(0);"
> between lines 264 and 265; before that, this was a
> low_priority_sleep(5); and even earlier a sleep(5);
>
> Some corresponding log messages are:
>
> > Revision 1.212 / (download) - annotate - [select for diffs] , Wed Dec 21 19:39:53 2005 UTC (2 months, 1 week ago) by cgf
> > Branch: MAIN
> > Changes since 1.211: +4 -5 lines
> > Diff to previous 1.211 (colored)
> >
> > * pinfo.cc (pinfo::init): Remove spurious low_priority_sleep.
> [...]
> > Revision 1.189 / (download) - annotate - [select for diffs] , Thu Sep 22 21:10:07 2005 UTC (5 months ago) by cgf
> > Branch: MAIN
> > Changes since 1.188: +8 -1 lines
> > Diff to previous 1.188 (colored)
> >
> > * pinfo.cc (set_myself): Call strace.hello unconditionally when DEBUGGING.
> > (pinfo::init): Sleep and issue debugging output before looping when a
> > PID_EXITED is found.
>
> Could someone please check if re-inserting a
>   low_priority_sleep (0);
> or maybe a
>   low_priority_sleep (5);
> helps resolving this issue?

Hi,

First off, this is the wrong list, since you don't actually have a patch.
The list to report this bug to is the main Cygwin list -- I've set the
Reply-To on this message accordingly.

However, do search the archives of the main list before you port -- you
will find my report of the same exact problem, with analysis (and the same
strace).  I'm still plagued by it, FWIW, and I'm still trying to figure
out what is going on.  Your analysis is a bit backward, though, since
pinfo::init is not waiting for PID_EXITED to be set, but rather mapping
the pinfo structure to some memory which has PID_EXITED set from a
previosly exited process.  The error message ("resource temporarily
unavailable") is spurious.  You'll find all of this detail in my bug
report on the main list.

And no, adding the sleep back in doesn't help.
	Igor
-- 
				http://cs.nyu.edu/~pechtcha/
      |\      _,,,---,,_	    pechtcha@cs.nyu.edu | igor@watson.ibm.com
ZZZzz /,`.-'`'    -.  ;-;;,_		Igor Peshansky, Ph.D. (name changed!)
     |,4-  ) )-,_. ,\ (  `'-'		old name: Igor Pechtchanski
    '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!

"Las! je suis sot... -Mais non, tu ne l'es pas, puisque tu t'en rends compte."
"But no -- you are no fool; you call yourself a fool, there's proof enough in
that!" -- Rostand, "Cyrano de Bergerac"
