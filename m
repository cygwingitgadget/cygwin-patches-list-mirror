Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 222393858D38; Tue,  3 Dec 2024 13:14:01 +0000 (GMT)
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id EBBFDA80B66; Tue,  3 Dec 2024 14:13:58 +0100 (CET)
Date: Tue, 3 Dec 2024 14:13:58 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: sched_setscheduler: accept SCHED_OTHER,
 SCHED_FIFO and SCHED_RR
Message-ID: <Z08EFs_LTnjKL6xr@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <eabbcf15-1605-8b77-bf77-ec5fde2d6001@t-online.de>
 <Z03Tik1rbM4sMpKl@calimero.vinschen.de>
 <e79eb78a-c8a1-d2c6-4a8d-9c21415b15e9@t-online.de>
 <8734j6q6qk.fsf@Gerda.invalid>
 <c6f21ed2-679d-4a89-a8a3-b0b1e9d1714f@SystematicSW.ab.ca>
 <80e1716d-d268-e5cd-b9ff-484aa5dcc344@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <80e1716d-d268-e5cd-b9ff-484aa5dcc344@t-online.de>
List-Id: <cygwin-patches.cygwin.com>

On Dec  3 10:20, Christian Franke wrote:
> Brian Inglis wrote:
> > On 2024-12-02 11:28, ASSI wrote:
> > > Christian Franke writes:
> > > > +    nice value   sched_priority Windows priority class
> > > > +     12...19      1....6          IDLE_PRIORITY_CLASS
> > > > +      4...11      7...12          BELOW_NORMAL_PRIORITY_CLASS
> > > > +     -4....3     13...18          NORMAL_PRIORITY_CLASS
> > > > +    -12...-5     19...24          ABOVE_NORMAL_PRIORITY_CLASS
> > > > +    -13..-19     25...30          HIGH_PRIORITY_CLASS
> > > > +         -20     31...32          REALTIME_PRIORITY_CLASS
> > > 
> > > That mapping looks odd… care to explain why the number of nice values
> > > and sched_priorities doesn't match up for each priority class? 39
> > > possible values for one can't match to 32 for the other of course, but
> > > which ones are skipped and why?
> > 
> > See also miscfuncs.cc which maps nice<->winprio with a 40 entry table,
> > and cygwin-doc proc(5) or cygwin-ug-net/proc.html which explains the
> > mapping to scheduler priorities and policies.
> 
> No *_PRIORITY_CLASS is mentioned in current newlib-cygwin/winsup/doc/*.
> 
> 
> > 
> > Also relevant may be man-pages-posix sched.h(0p), man-pages-linux
> > sched(7) and proc_pid_stat(5).
> > 
> > You may also wish to consider whether SCHED_SPORADIC should be somewhat
> > supported for POSIX compatibility, and SCHED_IDLE, SCHED_BATCH,
> > SCHED_DEADLINE for Linux compatibility?
> 
> SCHED_IDLE: Ignore nice value and set IDLE_PRIORITY_CLASS ?

Would make sense, I guess.

> SCHED_BATCH: Reduced mapping, e.g. nice=0 -> BELOW_NORMAL_PRIORITY_CLASS ?

Sounds good.

> SCHED_SPORADIC, SCHED_DEADLINE: ?

We can't model SCHED_DEADLINE in Windows.

> The current newlib/libc/include/sys/sched.h only defines SCHED_OTHER,
> SCHED_FIFO, SCHED_RR and SCHED_SPORADIC. The latter is guarded by
> _POSIX_SPORADIC_SERVER which is only set for RTEMS (#ifdef __rtems__) in
> features.h.

SCHED_SPORADIC is a bit of a problem.  It requires extension of the
sched_param struct with values we're not able to handle.

Also, SCHED_SPORADIC doesn't exist in Linux either, so why bother.


Corinna
