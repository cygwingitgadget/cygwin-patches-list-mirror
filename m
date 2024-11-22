Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 96F683858416; Fri, 22 Nov 2024 12:53:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 96F683858416
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1732279995;
	bh=3rxfpGbe2agJRxBam6JuL4XmtNTbnVoZ5rhqRVRFWQY=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=VehO5Qk9+G6ly1/pyngFN3hREmiVy8oITqlG/bn+0mTah6ALn7iRht3fPmkMUp06y
	 msvCRs4lkldAfDfJCBPsqMr7qA3DoYnzBV14c0/NRwuzROKkE+geZ0fMeJJsGoUbC7
	 J+AP8wOrFiglLXTQLO+201uNgw9FdXa9DjoS8w+A=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 692E4A80D67; Fri, 22 Nov 2024 13:53:13 +0100 (CET)
Date: Fri, 22 Nov 2024 13:53:13 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3] cygthread: suspend thread before terminating.
Message-ID: <Z0B-ue4nNgCYZDrw@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <45e536e2-e894-2548-e9d0-5937ff96b0b5@jdrake.com>
 <Zz0ER77IqtBDV_EU@calimero.vinschen.de>
 <4e2cbe74-2d1c-f8df-a457-57c0239844c1@jdrake.com>
 <Zz2_Czrk_qzn2fu6@calimero.vinschen.de>
 <1ce32afc-94ee-af96-db30-26d5f02a07ef@jdrake.com>
 <765a746a-b5a1-cdab-242d-1ff3c5bd65ba@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <765a746a-b5a1-cdab-242d-1ff3c5bd65ba@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

On Nov 21 17:20, Jeremy Drake via Cygwin-patches wrote:
> On Wed, 20 Nov 2024, Jeremy Drake via Cygwin-patches wrote:
> 
> > On Wed, 20 Nov 2024, Corinna Vinschen wrote:
> >
> > > Patch pushed.
> >
> > Thanks, folks on ARM64 will be very happy to see that deadlock gone.
> > MSYS2 already made a release based on v2 of the patch, and Git for Windows
> > at least merged that version of the patch too, and is looking forward to
> > making a release with it.
> 
> Uh oh, MSYS2 is getting some reports of deadlock/hangs in similar
> scenarios on native x86_64 now.  See starting at
> https://github.com/msys2/MSYS2-packages/issues/4340#issuecomment-2491401847
> if you're interested.
> 
> I was able to reproduce, debug, and found the following:
> 
> wait_thread is happily waiting in ReadFile, while the main thread is
> hanging in ForceCloseHandle1 (close_h, rd_proc_pipe);.

...which is one of the great annoyances of Windows.  CloseHandle
on a pipe should never hang, but... well...

> The pinfo::release
> call is after the wait thread should have been terminated, so it's
> apparent the CancelSynchronousIo didn't work for whatever reason (possibly
> due to canceling some other sychronous IO,

How would that be possible? A thread can only run a single synchronous
IO at the time, isn't it?

Somehow I'm not really surprised.  You already wrote in your commit
message:

  Also, attempt to use `CancelSynchonousIo()` (as seen in `flock.cc`) to
  avoid the need for `TerminateThread()` altogether.  This doesn't
  always work, however, so was not a complete fix for the deadlock issue.

Per MSDN, CancelSynchronousIo() is not synchronous itself. It "returns
immediately after the cancellation attempt" and "If there are any
pending I/O operations in progress for the specified thread, the
CancelSynchronousIo function marks them for cancellation."

So it doesn't wait for cancel completion.  This in turn means, the
return code from CancelSynchronousIo() doesn't say anything about the
cancellation state of the IO-to-be-canceled, only about the success of
marking the IO for cancellation.

Do we know if ReadFile on a pipe is realiably cancelable?

Rather than calling CancelSynchronousIo(), what about sending a
signal to proc_waiter() via alert_parent(0)?

On second thought, the current behaviour after getting an
ERROR_OPERATION_ABORTED error doesn't look right either.

Rather than entering the error case, it should be exempt from
being handled as error, just as ERROR_BROKEN_PIPE.  Otherwise
it never runs the case 0 code in the following switch statement, but
it should.  Even that change might already fix things...

> letting it come back around in
> the loop and call ReadFile again.
> 
> Using gdb to call CancelSynchronousIo again resulted in the wait thread
> exiting immediately.
> 
> 
> Either we just revert the CancelSynchronousIo part of the patch (the
> SuspendThread/GetThreadContext part is what actually solved the ARM64
> deadlock), or possibly we can add a flag that the thread should be
> shutting down, and check that in the for loop condition in the wait
> thread.  Thoughts either way?

Either way, this looks like yet another synchronization problem:

You can't be sure that ReadFile() actually exited after calling
CancelSynchronousIo().

And you can't be sure that proc_waiter() was really in the ReadFile call
when you call CancelSynchronousIo().  proc_waiter() could easily be in
the followup code and only enter ReadFile() after your
CancelSynchronousIo() call.

All in all, it looks like calling alert_parent(0) might be the better
approach, but ultimately, I still don't see a way around
terminate_thread().


Corinna
