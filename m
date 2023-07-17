Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 850BB3858D28; Mon, 17 Jul 2023 18:23:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 850BB3858D28
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1689618197;
	bh=2btm9EJZ9JfhS/fOhwlOB1nAPhZxa/ku1L1///gNvHc=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=kjKpo/TyohaUNIvPun1/zZWhywgMv+UrrZnqtVmkEvRBe0Kn+iscCu0epZ9pQMG9R
	 196rYiKyuXG+nRmAl2tEY1NPDG3SltFHDu3x/6mT+yNisUMiqvK6+3g0AqgGkvzweD
	 xWOdrHNX03SJa1AwYu9Slc2UlUCDQ6PX1zOGm4F4=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id F03DDA80940; Mon, 17 Jul 2023 20:23:14 +0200 (CEST)
Date: Mon, 17 Jul 2023 20:23:14 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 08/11] Cygwin: testsuite: Busy-wait in cancel3 and cancel5
Message-ID: <ZLWHEroTkcgTZUcc@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20230713113904.1752-9-jon.turney@dronecode.org.uk>
 <ZLA/j6L/tPcqHiG7@calimero.vinschen.de>
 <ZLBEajmAonZGmsqx@calimero.vinschen.de>
 <ZLBIJTlbCtRvYlU9@calimero.vinschen.de>
 <5aa21952-a13d-f304-8b63-18ee4885c308@dronecode.org.uk>
 <ZLGaf8/nWphfbRI9@calimero.vinschen.de>
 <ZLUgZE5ECv+HaAGI@calimero.vinschen.de>
 <b132e96c-8767-e5b9-1152-c92cd5ad200e@dronecode.org.uk>
 <ZLVOhclITbZyDOhF@calimero.vinschen.de>
 <ZLVhNJE83tlKMTEi@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZLVhNJE83tlKMTEi@calimero.vinschen.de>
List-Id: <cygwin-patches.cygwin.com>

On Jul 17 17:41, Corinna Vinschen wrote:
> On Jul 17 16:21, Corinna Vinschen wrote:
> > On Jul 17 12:51, Jon Turney wrote:
> > > On 17/07/2023 12:05, Corinna Vinschen wrote:
> > > > diff --git a/winsup/cygwin/thread.cc b/winsup/cygwin/thread.cc
> > > > index f614e01c42f6..fceb9bda1806 100644
> > > > --- a/winsup/cygwin/thread.cc
> > > > +++ b/winsup/cygwin/thread.cc
> > > > @@ -546,6 +546,13 @@ pthread::exit (void *value_ptr)
> > > >     class pthread *thread = this;
> > > >     _cygtls *tls = cygtls;	/* Save cygtls before deleting this. */
> > > > +  /* Deferred cancellation still pending? */
> > > > +  if (canceled)
> > > > +    {
> > > > +      WaitForSingleObject (cancel_event, INFINITE);
> > > > +      value_ptr = PTHREAD_CANCELED;
> > > > +    }
> > > > +
> > > >     // run cleanup handlers
> > > >     pop_all_cleanup_handlers ();
> > > > What do you think?
> > > 
> > > I mean, by your own interpretation of the standard, this isn't required,
> > > because we're allowed to take arbitrarily long to deliver the async
> > > cancellation, and in this case, we took so long that the thread exited
> > > before it happened, too bad...
> > 
> > True enough!
> > 
> > > It doesn't seem a bad addition,
> > 
> Actually, it seems we actually *have* to do this.  I just searched
> for more info on that problem and, to my surprise, I found this in the
> most obvious piece of documentation:
> 
> https://pubs.opengroup.org/onlinepubs/9699919799/functions/pthread_exit.html
> 
> Quote:
> 
>   As the meaning of the status is determined by the application (except
>   when the thread has been canceled, in which case it is
>   PTHREAD_CANCELED), [...]

FTR, apparently I have overinterpreted this sentence.

I performed the following crude test on Linux,, the idea being
to call pthread_cancel and then pthread_exit without hitting a
cancallation point in between.

cat > pt.c <<EOF
#include <stdio.h>
#include <errno.h>
#include <string.h>
#include <stdint.h>
#include <unistd.h>
#include <pthread.h>

int marker = 0;

void *
thread (void *arg)
{
  int oldval;

  pthread_setcanceltype (PTHREAD_CANCEL_DEFERRED, &oldval);
  pthread_setcancelstate (PTHREAD_CANCEL_ENABLE, &oldval);
  marker = 1;
  while (marker < 2)
    ;
  pthread_exit ((void *) 42);
}

int
main ()
{
  int error;
  pthread_t pt;
  void *retval;

  if ((error = pthread_create (&pt, NULL, thread, NULL)))
    {
      printf ("pthread_create: %d %s\n", error, strerror (error));
      return 1;
    }
  while (marker < 1)
    ;
  if ((error = pthread_cancel (pt)))
    {
      marker = 2;
      printf ("pthread_cancel: %d %s\n", error, strerror (error));
      pthread_detach (pt);
      return 1;
    }
  marker = 2;
  if ((error = pthread_join (pt, &retval)))
    {
      printf ("pthread_join: %d %s\n", error, strerror (error));
      pthread_detach (pt);
      return 1;
    }
  printf ("retval = %ld (%d)\n", (uintptr_t) retval, retval == PTHREAD_CANCELED);
  return 0;
}
EOF
$ gcc -g -o pt pt.c -lpthread
$ ./pt
retval = 42 (0)

So retval is the one set by the application, not PTHREAD_CANCELED,
despite the pthread_cancel call.  Looks like handling cancellation
inside pthread_exit is really not the right thing to do...


Corinna
