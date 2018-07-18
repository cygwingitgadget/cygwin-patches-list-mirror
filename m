Return-Path: <cygwin-patches-return-9124-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 91832 invoked by alias); 18 Jul 2018 05:26:54 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 91803 invoked by uid 89); 18 Jul 2018 05:26:54 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-23.6 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,KAM_LAZY_DOMAIN_SECURITY autolearn=ham version=3.3.2 spammy=sk:industr, totally, ease, professional
X-HELO: m0.truegem.net
Received: from m0.truegem.net (HELO m0.truegem.net) (69.55.228.47) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 18 Jul 2018 05:26:50 +0000
Received: (from daemon@localhost)	by m0.truegem.net (8.12.11/8.12.11) id w6I5QmVD079912	for <cygwin-patches@cygwin.com>; Tue, 17 Jul 2018 22:26:48 -0700 (PDT)	(envelope-from mark@maxrnd.com)
Received: from 76-217-5-154.lightspeed.irvnca.sbcglobal.net(76.217.5.154), claiming to be "[192.168.1.100]" via SMTP by m0.truegem.net, id smtpdTvrHh3; Tue Jul 17 22:26:38 2018
Subject: Re: [PATCH v3 1/3] POSIX Asynchronous I/O support: aio files
To: cygwin-patches@cygwin.com
References: <20180715082025.4920-1-mark@maxrnd.com> <20180715082025.4920-2-mark@maxrnd.com> <20180716142128.GZ27673@calimero.vinschen.de>
From: Mark Geisert <mark@maxrnd.com>
Message-ID: <2f78f69e-079d-36d5-15f0-61f1bfc8a9b7@maxrnd.com>
Date: Wed, 18 Jul 2018 05:26:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:49.0) Gecko/20100101 Firefox/49.0 SeaMonkey/2.46
MIME-Version: 1.0
In-Reply-To: <20180716142128.GZ27673@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2018-q3/txt/msg00019.txt.bz2

Corinna Vinschen wrote:
> Hi Mark,
>
> this looks good.  Inline comments as usual.

Thank you; OK.

> On Jul 15 01:20, Mark Geisert wrote:
[...]
>> +static int
>> +aiochkslot (struct aiocb *aio)
>> +{
>> +  /* Sanity check.. make sure this AIO is not already busy */
>> +  for (int slot = 0; slot < AIO_MAX; ++slot)
>> +    if (evt_aiocbs[slot] == aio)
>> +      {
>> +        debug_printf ("aio %p is already busy in slot %d", aio, slot);
>> +        return slot;
>> +      }
>> +
>> +  return -1;
>> +}
>
> Shouldn't this check be under lock as well?  Or I am missing something.
> Why is the lock not necessary here?

Brain hiccup on my part.  I was thinking read-only simple access doesn't need to 
be locked.  That's wrong and fixed now.

>> +aionotify_on_pthread (struct sigevent *evp)
>> +{
>> +  pthread_attr_t *attr;
>> +  pthread_attr_t  default_attr;
>> +  int             rc;
>> +  pthread_t       vaquita; /* == "little porpoise", endangered */
>> +
>> +  if (evp->sigev_notify_attributes)
>> +    attr = evp->sigev_notify_attributes;
>> +  else
>> +    {
>> +      pthread_attr_init (attr = &default_attr);
>> +      pthread_attr_setdetachstate (attr, PTHREAD_CREATE_DETACHED);
>> +    }
>> +
>> +  rc = pthread_create (&vaquita, attr,
>> +                       (void * (*) (void *)) evp->sigev_notify_function,
>> +                       evp->sigev_value.sival_ptr);
>> +
>> +  /* The following error is not expected. If seen often, develop a recovery. */
>> +  if (rc)
>> +    debug_printf ("aio vaquita thread creation failed, %E");
>
> I like the name, but what's the background for naming a thread like this?
> Just curious.  A bit of comment might help to keep it in mind, too :)

I've now added commentary above the pthread_create() call.  It reads:
   /* A "vaquita" thread is a temporary pthread created to deliver a signal to
    * the application.  We don't wait around for the thread to return from the
    * app.  There's some symbolism here of sending a little creature off to tell
    * the app something important.  If all the vaquitas end up wiped out in the
    * wild, a distinct near-term possibility, at least this code remembers them.
    */

If all this vaquita stuff is deemed too precious for industrial-grade software I 
can recast this code in more professional terms and wouldn't mind doing it.

[...]
>> +          /* Do the requested AIO operation manually, synchronously */
>> +          switch (aio->aio_lio_opcode)
>> +            {
>> +              case LIO_READ:
>> +                /*XXX Hmm, no direct result? This OK? */
>
> Unfortunately the fhandler read method has been written this way more
> than 20 years ago.  I have no idea why and it's ugly as hell.
>
> But there is a result: The second parameter is set to the number of bytes
> read or -1 on error, in which case errno is set.
>
> Feel free to rewrite the fhandler read method to look more sane :)

Thanks for the background; I missed the 2nd arg being passed by reference.  I've 
left the code as-is but have now added a little commentary to describe what's 
going on.  Re-writing the fhandler read method is left for the future...

>
>> +#ifdef _POSIX_SYNCHRONIZED_IO
>
> We really don't need this ifdef, not even in the header.  The macro is
> certainly defined.

All occurrences have now been deleted.

>
>> diff --git a/winsup/cygwin/include/aio.h b/winsup/cygwin/include/aio.h
>> new file mode 100644
>> index 000000000..34ff29969
>> --- /dev/null
>> +++ b/winsup/cygwin/include/aio.h
>> @@ -0,0 +1,82 @@
>> +/* aio.h: Support for Posix asynchronous i/o routines.
>> +
>> +This file is part of Cygwin.
>> +
>> +This software is a copyrighted work licensed under the terms of the
>> +Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
>> +details. */
>> +
>> +#ifndef _AIO_H
>> +#define _AIO_H
>> +
>> +#include <sys/features.h>
>> +#include <sys/queue.h>
>> +#include <sys/signal.h>
>> +#include <sys/types.h>
>> +#include <limits.h> // for AIO_LISTIO_MAX, AIO_MAX, and AIO_PRIO_DELTA_MAX
>> +
>> +#ifndef __INSIDE_CYGWIN__
>> +#include <w32api/winternl.h> // for HANDLE and IO_STATUS_BLOCK
>> +#endif
>
> Hmm.  Did I miss this last time?  Looks like it.
>
>> +/* struct aiocb is defined by Posix */
>> +struct aiocb {
>> +    /* these elements of aiocb are Cygwin-specific */
>> +    TAILQ_ENTRY(aiocb)   aio_chain;
>> +    struct liocb        *aio_liocb;
>> +    HANDLE               aio_win_event;
>> +    IO_STATUS_BLOCK      aio_win_iosb;
>> +    ssize_t              aio_rbytes;
>> +    int                  aio_errno;
>> +    /* the remaining elements of aiocb are defined by Posix */
>> +    int                  aio_lio_opcode;
>> +    int                  aio_reqprio; /* Not yet implemented; must be zero */
>> +    int                  aio_fildes;
>> +    volatile void       *aio_buf;
>> +    size_t               aio_nbytes;
>> +    off_t                aio_offset;
>> +    struct sigevent      aio_sigevent;
>> +};
>
> Can you please change this so it doesn't require to include a
> windows header?  You could use void * instead of HANDLE and define
> your own __io_t (or whatever) as a struct of void * and uintptr_t
> values and only cast them to the Windows types inside of Cygwin.
> That ok?

It's totally OK; I'm still fine tuning the replacement code for readability and 
ease of coding.

..mark
