Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 136F53857C78; Mon, 25 Nov 2024 09:44:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 136F53857C78
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1732527857;
	bh=hY+IGRlDopSTCitXFMiLVgmRKDDbySPE2YavmLVnM6M=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=pNW6CoKiWKeRLJZzsjKa4MZbsP8yGHE2A5+WKZty2weoU2n7ATQGHHnxeNfTaprkW
	 8ivlC2+UXI88Kyk0XwXrC/iz2cfvMpAHTMspKWjv6FVj+B/PcM0Gz3lCHAfKN47PS9
	 V9qyeXDsMUjzsxYDWWNsf0msY6pSfub+QaXR1rS8=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 08623A80C06; Mon, 25 Nov 2024 10:44:15 +0100 (CET)
Date: Mon, 25 Nov 2024 10:44:14 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3] cygthread: suspend thread before terminating.
Message-ID: <Z0RG7qrCMbUIuA3p@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <45e536e2-e894-2548-e9d0-5937ff96b0b5@jdrake.com>
 <Zz0ER77IqtBDV_EU@calimero.vinschen.de>
 <4e2cbe74-2d1c-f8df-a457-57c0239844c1@jdrake.com>
 <Zz2_Czrk_qzn2fu6@calimero.vinschen.de>
 <1ce32afc-94ee-af96-db30-26d5f02a07ef@jdrake.com>
 <765a746a-b5a1-cdab-242d-1ff3c5bd65ba@jdrake.com>
 <Z0B-ue4nNgCYZDrw@calimero.vinschen.de>
 <15927c29-7e55-f560-ac57-648cb087b452@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <15927c29-7e55-f560-ac57-648cb087b452@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

On Nov 22 09:56, Jeremy Drake via Cygwin-patches wrote:
> On Fri, 22 Nov 2024, Corinna Vinschen wrote:
> 
> > > wait_thread is happily waiting in ReadFile, while the main thread is
> > > hanging in ForceCloseHandle1 (close_h, rd_proc_pipe);.
> >
> > ....which is one of the great annoyances of Windows.  CloseHandle
> > on a pipe should never hang, but... well...
> 
> Yeah, I thought TerminateThread should never hang either, but I was proved
> wrong by emulation :P
> 
> > > The pinfo::release
> > > call is after the wait thread should have been terminated, so it's
> > > apparent the CancelSynchronousIo didn't work for whatever reason (possibly
> > > due to canceling some other sychronous IO,
> >
> > How would that be possible? A thread can only run a single synchronous
> > IO at the time, isn't it?
> 
> I thought something in the rest of the logic in the thread might be doing
> a synchronous IO.  I dug through and found a WriteFile somewhere, but I
> didn't follow the code logic to prove that that happens in the particular
> cases in this thread.

Ah, ok, I misunderstood what you were trying to say and was thinking
of multiple parallel synch IOs in the same thread... which I can only
imagine with a certain amount of squinting...

> > Rather than calling CancelSynchronousIo(), what about sending a
> > signal to proc_waiter() via alert_parent(0)?
> 
> How would that work?  Wouldn't that have to be done in the child?

Hmm, yeah.

> > On second thought, the current behaviour after getting an
> > ERROR_OPERATION_ABORTED error doesn't look right either.
> >
> > Rather than entering the error case, it should be exempt from
> > being handled as error, just as ERROR_BROKEN_PIPE.  Otherwise
> > it never runs the case 0 code in the following switch statement, but
> > it should.  Even that change might already fix things...
> 
> I thought this was correct, because in the case where CancelSynchronousIo
> was added the thread otherwise would have been terminated.  Therefore it
> should exit ASAP, do not pass go, etc.

Yeah, I understand the reasoning, but wasn't CancelSynchronousIo() meant
to replace TerminateThread() with a *clean* thread termination?  But,
never mind.

> > Either way, this looks like yet another synchronization problem:
> >
> > You can't be sure that ReadFile() actually exited after calling
> > CancelSynchronousIo().
> >
> > And you can't be sure that proc_waiter() was really in the ReadFile call
> > when you call CancelSynchronousIo().  proc_waiter() could easily be in
> > the followup code and only enter ReadFile() after your
> > CancelSynchronousIo() call.
> >
> > All in all, it looks like calling alert_parent(0) might be the better
> > approach, but ultimately, I still don't see a way around
> > terminate_thread().
> 
> I will submit a patch reverting the CancelSynchronousIo changes, since
> they were not necessary for the ARM64 fix, and were just an attempt to
> avoid the necessity of using TerminateThread.

Ok, thanks!


Corinna
