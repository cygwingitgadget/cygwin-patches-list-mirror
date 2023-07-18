Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 294BB38582B0; Tue, 18 Jul 2023 12:09:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 294BB38582B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1689682173;
	bh=q7NdU5K39DA+E9yLbyk8pAr6JYK1j/VKB1yxlBFD4qI=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=mT/P3+1J+CqtfsRCJxblaAfCp8Mr+elgn4r5yQvKB8XUNg2amF3nIOp/yoBTVayDA
	 eLu7IIbr3Bvt0J7pjRmhPFIsvpQTFiNLUmPcnDxKL53rP46YkCQISg7TJmOGitUtl/
	 GCB1hqw3AMD3BcaS/xoJh6rASQtxzOMVi85AxfSQ=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id AF869A80C30; Tue, 18 Jul 2023 14:09:30 +0200 (CEST)
Date: Tue, 18 Jul 2023 14:09:30 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 08/11] Cygwin: testsuite: Busy-wait in cancel3 and cancel5
Message-ID: <ZLaA+toDV1ms4Ene@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <ZLA/j6L/tPcqHiG7@calimero.vinschen.de>
 <ZLBEajmAonZGmsqx@calimero.vinschen.de>
 <ZLBIJTlbCtRvYlU9@calimero.vinschen.de>
 <5aa21952-a13d-f304-8b63-18ee4885c308@dronecode.org.uk>
 <ZLGaf8/nWphfbRI9@calimero.vinschen.de>
 <ZLUgZE5ECv+HaAGI@calimero.vinschen.de>
 <b132e96c-8767-e5b9-1152-c92cd5ad200e@dronecode.org.uk>
 <ZLVOhclITbZyDOhF@calimero.vinschen.de>
 <ZLVhNJE83tlKMTEi@calimero.vinschen.de>
 <a3513077-38c4-0839-1bfd-73f331069454@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a3513077-38c4-0839-1bfd-73f331069454@dronecode.org.uk>
List-Id: <cygwin-patches.cygwin.com>

On Jul 18 12:20, Jon Turney wrote:
> On 17/07/2023 16:41, Corinna Vinschen wrote:
> > > Looking into pthread::cancel we have this order of things:
> > > 
> > >      // cancel deferred
> > >      mutex.unlock ();
> > >      canceled = true;
> > >      SetEvent (cancel_event);
> > >      return 0;
> > > 
> > > The canceled var is set before the SetEvent call.
> > > What if the thread is terminated after canceled is set to true but
> > > before SetEvent is called?
> > > 
> > > pthread::testcancel claims:
> > > 
> > >    We check for the canceled flag first. [...]
> > >    Only if the thread is marked as canceled, we wait for cancel_event
> > >    being really set, on the off-chance that pthread_cancel gets
> > >    interrupted before calling SetEvent.
> > > 
> > > Neat idea to speed up the code, but doesn't that mean we have a
> > > potential deadlock, especially given that pthread::testcancel calls WFSO
> > > with an INFINITE timeout?
> 
> I'm not sure I follow: another thread sets cancelled = true, just before we
> hit pthread::testcancel(), so we go into the WFSO, but then the other thread
> continues, signals cancel_event and everything's fine.
> 
> What meaning are you assigning to "interrupted" here?
> 
> Are we worried about the thread calling pthread_cancel being cancelled
> itself?

Yes.  My concern is if the thread gets terminated between setting
canceled and setting the event object.

Prior to commit 42faed412857, we didn't wait infinitely, just tested the
event object.  Only with adding the canceled variable, we (better: I)
added the the infinite timeout.

I don't see a real reason to do that.  I think this should be changed
to just checking the event object, see the below patch.

> > > And if so, how do we fix this?  Theoretically, the most simple
> > > solution might be to call SetEvent before setting the canceled
> > > variable, but in fact we would have to make setting canceld
> > > and cancel_event an atomic operation.
> 
> Well, yeah, that is required for them to be coherent. But we have a mutex on
> the thread object for that purpose, and I don't quite see why it's released
> so early here.

The mutex is not guarding canceled or the event object.  Thus it's not
used in testcancel either, otherwise introducing the canceled var to
speed up stuff wouldn't have made any sense.


Corinna


commit 518e5e46f064de41d3ef6d6ef743e2e760a46282
Author:     Corinna Vinschen <corinna@vinschen.de>
AuthorDate: Mon Jul 17 18:02:04 2023 +0200
Commit:     Corinna Vinschen <corinna@vinschen.de>
CommitDate: Tue Jul 18 10:11:30 2023 +0200

    Cygwin: don't wait infinitely on a pthread cancel event
    
    Starting with commit 42faed412857 ("* thread.h (class pthread): Add bool
    member canceled."), pthread::testcancel waits infinitely on cancel_event
    after it checked if the canceled variable is set.  However, this might
    introduce a deadlock, if the thread calling pthread_cancel is terminated
    after setting canceled to true, but before calling SetEvent on cancel_event.
    
    In fact, it's not at all necessary to wait infinitely.  By definition,
    the thread is only canceled if cancel_event is set.  The canceled
    variable is just a helper to speed up code.  We can safely assume that
    the thread hasn't been canceled yet, if canceled is set, but cancel_event
    isn't.
    
    Fixes: 42faed412857 ("* thread.h (class pthread): Add bool member canceled.")
    Signed-off-by: Corinna Vinschen <corinna@vinschen.de>

diff --git a/winsup/cygwin/thread.cc b/winsup/cygwin/thread.cc
index f614e01c42f6..21e89e146e0a 100644
--- a/winsup/cygwin/thread.cc
+++ b/winsup/cygwin/thread.cc
@@ -961,12 +961,9 @@ pthread::testcancel ()
      pthread_testcancel function a lot without adding the overhead of
      an OS call.  Only if the thread is marked as canceled, we wait for
      cancel_event being really set, on the off-chance that pthread_cancel
-     gets interrupted before calling SetEvent. */
-  if (canceled)
-    {
-      WaitForSingleObject (cancel_event, INFINITE);
-      cancel_self ();
-    }
+     gets interrupted or terminated before calling SetEvent. */
+  if (canceled && IsEventSignalled (cancel_event))
+    cancel_self ();
 }
 
 /* Return cancel event handle if it exists *and* cancel is not disabled.
