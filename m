Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 8E2723858C52; Wed, 20 Nov 2024 10:50:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 8E2723858C52
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1732099853;
	bh=3CtrtPM2cOc5oPBKe7CHHc60lk+1JgzEMU9dr9p9nhk=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=FiURvgSmLC42o3g8mTd4QNNRsT5XhQG5IvmVED8/pflD+pu8tG+072Pkn4/N8AD5S
	 GAkALgjn46F1XeM6hhniw3C6jeYabKQEI/VMgjx+9Ndkh7sYM2gm4TcehKAaYn2asj
	 PywCKz5dOn4xAunos8CIKS8rgvmpxQkNGjQuOPvI=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 8AC87A80D2F; Wed, 20 Nov 2024 11:50:51 +0100 (CET)
Date: Wed, 20 Nov 2024 11:50:51 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3] cygthread: suspend thread before terminating.
Message-ID: <Zz2_Czrk_qzn2fu6@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <45e536e2-e894-2548-e9d0-5937ff96b0b5@jdrake.com>
 <Zz0ER77IqtBDV_EU@calimero.vinschen.de>
 <4e2cbe74-2d1c-f8df-a457-57c0239844c1@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4e2cbe74-2d1c-f8df-a457-57c0239844c1@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

Hi Jeremy,

On Nov 19 13:58, Jeremy Drake via Cygwin-patches wrote:
> On Tue, 19 Nov 2024, Corinna Vinschen wrote:
> 
> > On Nov 19 11:06, Jeremy Drake via Cygwin-patches wrote:
> > > (I searched for other callers of terminate_thread after this, and the only
> > > one left without CancelSynchronousIo is in ldap.cc and I'm pretty sure
> > > that's a "can't happen" case.)
> >
> > I'm inclined to push your patch, but I'm not quite sure here...
> >
> > Yes, terminate_thread called from ldap.cc is an unlikely last resort kind
> > of thing.  And there are more places calling terminate_thread().  But none
> > of them are terminating the wait_thread, so they shouldn't matter in this
> > scenario.  I think?
> 
> I grepped in winsup/cygwin for TerminateThread (which only showed up in
> cygthread.cc) and terminate_thread, which shows up in cygthread.cc (where
> it's implemented), flock.cc (where I saw the CancelSynchronousIo trick in
> the first place), ldap.cc, and sigproc.cc (which is patched here).
> 
> I have not seen a hang in places other than at (or near) the termination
> of the wait_thread in proc_terminate.  That doesn't mean there aren't any,
> it is incredibly difficult to get a debugger to tell you where things are
> hung up.  The reason that I think this wait_thread scenario was
> problematic (and the reason that I'm not concerned about the couple of
> times I saw it hung "near" the TerminateThread call rather than at it) is
> that the lock in question was described as being a "code cache lock", and
> this double-fork scenario results in the process exiting almost
> immediately after being started.  The emulator is still translating and
> caching code both for the thread and for the process as a whole, so the
> wait_thread is holding the lock when it's terminated, and the main thread
> needs to acquire the lock to continue translating the rest of Cygwin's
> process shutdown code.

Ok.

> > Assuming they do matter, CancelSynchronousIo() only makes sense
> > if the thread hangs in synchronous IO.  Other internal threads use WFMO,
> > and I don't see that you can avoid a TerminateThread in these cases.
> > But those are covered by the neat SuspendThread/GetThreadContext trick,
> > right?
> 
> Yes, the SuspendThread/GetThreadConext trick makes sure the thread is out
> of emulation before terminating it.  The CancelSyncronousIo was something
> I tried before learning that.  It helped but was not sufficient because
> the thread may not have been in ReadFile at the time, so the thread still
> needed to be terminated in some cases.  I included it in this patch
> because TerminateThread is documented as being unsafe, so any effort to
> avoid using it would be an improvement.
> 
> For threads that are in WFMO, what I do in my own code is include a
> 'shutdown' event that code that wants the thread to shut down can set and
> then wait on the thread object to know when it's done shutting down.

Yeah, we're trying that too, see cygthread::detach().

Usually the code is following the idea of calling TerminateThread() only
in situations where we (quoting MSDN) "know exactly what the target
thread is doing, and you control all of the code that the target thread
could possibly be running at the time of the termination".

Your emulation scenario is beyond that, and there may always lurk YA bug...

Patch pushed.


Thanks,
Corinna
