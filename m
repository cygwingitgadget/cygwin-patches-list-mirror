Return-Path: <cygwin-patches-return-9055-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 102462 invoked by alias); 19 Apr 2018 13:39:03 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 101788 invoked by uid 89); 19 Apr 2018 13:39:03 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-124.2 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2 spammy=
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.131) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 19 Apr 2018 13:38:54 +0000
Received: from calimero.vinschen.de ([217.91.18.234]) by mrelayeu.kundenserver.de (mreue004 [212.227.15.167]) with ESMTPSA (Nemesis) id 0M9LFi-1fHQxh3PzS-00ChtT for <cygwin-patches@cygwin.com>; Thu, 19 Apr 2018 15:38:51 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 26FC6A81EE6; Thu, 19 Apr 2018 15:38:51 +0200 (CEST)
Date: Thu, 19 Apr 2018 13:39:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 1/3] Posix asynchronous I/O support: aio files
Message-ID: <20180419133851.GP15911@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20180419080402.10932-1-mark@maxrnd.com> <20180419080402.10932-2-mark@maxrnd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="m1UC1K4AOz1Ywdkx"
Content-Disposition: inline
In-Reply-To: <20180419080402.10932-2-mark@maxrnd.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-UI-Out-Filterresults: notjunk:1;V01:K0:Vz1YNA5T3f0=:97imFpdw6q4yCc66h7MR8h brrUrJPfSjFwINLnte8+xyKoJ9OnGAYbrrTKekjNrBUUC+NYgxET1hOscbhuSJv3GIAM1CyMF d+f35cqbvzDW1NKYmHuvtVlSiK5kPwMZj3bxd0E3T0poZaYR2a/kTUldcL1ObfEKS09fLCAES +WvVb+5V6ggubxhHU8DYTuu8E9Wu7MOU1LS48vNICyZR+gggiIdAl+3gwUrkPYU+BsEH0DwfK eDxntrRkiBNbDstIB8hU6nAQqHwVwaThBj27ZGMNqFtE6gGE8cDbPFGC9DDs2rtCW4iZ72LPM WLI6RQ2ILFPI7dLsdwBXE7VbvTvATLXkjD2CZ3U7/wpqF9I+9olWzZgxHhPK+OCMDetEtWjty dQAbGQmm5/F0W5Z/qeV8aCGgBir8PWSIlZ59nruYaHVP//NLST4yN4FLUcESaf9iGs5AiNzYi r46zpo/TLVU7ZynDkjecbB1WWFKXsXYYqBcnPVWGyxOW5Ht7ZHBIutxukBvaKdNaIcydEZj5n aCcB1SUIkGeNbb4K4GrsqW2xEjDWgbAMQBLg8+MgTQB4RgvpdsKaMAWviOqe2WZP3WUNfCEym TH1JKE6Vy3PaibD0sN50zDfJMWs9mMFRUDifmY51ZBaUdekkOGd4R/a9julnFUbGwrUtZpv3K MBoi5Th0/QCbCwXtooJ6X9hVV3JIIhNIomQH/7863fYgK9K3hPtW50IzcQV0lR8pMY6QxrGjD tG5DhSEb9Dt2Q9zcLOFHXEOXkCrs98nH3MwJsQ==
X-SW-Source: 2018-q2/txt/msg00012.txt.bz2


--m1UC1K4AOz1Ywdkx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 21940

On Apr 19 01:04, Mark Geisert wrote:
> This is the core of the AIO implementation: aio.cc and aio.h.  The
> latter is used within Cygwin by aio.cc and the fhandler* modules, as
> well as by user programs wanting the AIO functionality.
>=20
> This is the 2nd WIP patch set for AIO.  The string XXX marks issues
> I'm specifically requesting comments on, but feel free to comment or
> suggest changes on any of this code.
> ---
>  winsup/cygwin/aio.cc        | 802 ++++++++++++++++++++++++++++++++++++++=
++++++
>  winsup/cygwin/include/aio.h |  83 +++++
>  2 files changed, 885 insertions(+)
>  create mode 100644 winsup/cygwin/aio.cc
>  create mode 100644 winsup/cygwin/include/aio.h
>=20
> diff --git a/winsup/cygwin/aio.cc b/winsup/cygwin/aio.cc
> new file mode 100644
> index 000000000..2749104fa
> --- /dev/null
> +++ b/winsup/cygwin/aio.cc
> @@ -0,0 +1,802 @@
> +/* aio.cc: Posix asynchronous i/o functions.
> +
> +This file is part of Cygwin.
> +
> +This software is a copyrighted work licensed under the terms of the
> +Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
> +details. */
> +
> +#include "winsup.h"
> +#include "path.h"
> +#include "fhandler.h"
> +#include "dtable.h"
> +#include "cygheap.h"
> +#include <aio.h>
> +#include <fcntl.h>
> +#include <semaphore.h>
> +#include <unistd.h>
> +
> +#ifdef __cplusplus
> +extern "C" {
> +#endif
> +
> +/* 'aioinitialized' is a thread-safe status of AIO feature initializatio=
n:
> + * 0 means uninitialized, >0 means initializing, <0 means initialized
> + */
> +static NO_COPY volatile int  aioinitialized =3D 0;
> +static NO_COPY pid_t         mypid;

Don't do that.  You have immediate access to your own process pinfo
structure via "myself".  I.e, myself->pid is your pid.

> +/* This implementation supports two flavors of asynchronous operation:
> + * "inline" and "queued".  Inline AIOs are used when:
> + *     (1) fd refers to a local disk file opened in binary mode,
> + *     (2) no more than AIO_MAX inline AIOs will be in progress at same =
time.
> + * In all other cases queued AIOs will be used.
> + *
> + * An inline AIO is performed by the calling thread as a pread|pwrite on=
 a
> + * shadow fd that permits Windows asynchronous i/o, with event notificat=
ion
> + * on completion.  Event arrival causes AIO context for the fd to be upd=
ated.
> + *
> + * A queued AIO is performed by an AIO worker thread using pread|pwrite =
on a=20
> + * shadow fd that permits Windows async i/o, with event notification on
> + * completion.  Event arrival causes AIO context for the fd to be update=
d.
> + */
> +
> +/* These variables support inline AIO operations */
> +static NO_COPY HANDLE            evt_handles[AIO_MAX];
> +static NO_COPY struct aiocb     *evt_aiocbs[AIO_MAX];
> +static NO_COPY CRITICAL_SECTION  slotcrit;
> +
> +/* These variables support queued AIO operations */
> +static NO_COPY sem_t         worksem;   /* indicates whether AIOs are qu=
eued */
> +static NO_COPY struct aiocb *worklisthd =3D NULL;  /* head of pending AI=
O list */
> +static NO_COPY struct aiocb *worklisttl =3D NULL;  /* tail of pending AI=
O list */
> +static NO_COPY CRITICAL_SECTION  workcrit;      /* lock for pending AIO =
list */
> +//XXX Investigate TAILQ* macros in <sys/queue.h> for worklist mgmt

Would really be preferrable, given they are a tried and trusted,
semi-offical API.

> +//XXX Generally I don't like forward ref declarations. Need to reorder f=
uncs.

Ditto.

> +static int aioqueue (struct aiocb *);
> +static int asyncread (struct aiocb *);
> +static int asyncwrite (struct aiocb *);
> +
> +static struct aiocb *
> +enqueue (struct aiocb *aio)
> +{
> +  /* critical section 'workcrit' is held on entry */
> +  aio->aio_prev =3D worklisttl;
> +  aio->aio_next =3D NULL;
> +
> +  if (!worklisthd)
> +    worklisthd =3D aio;
> +  if (worklisttl)
> +    worklisttl->aio_next =3D aio;
> +  worklisttl =3D aio;
> +
> +  return aio;
> +}
> +
> +static struct aiocb *
> +dequeue (struct aiocb *aio)
> +{
> +  /* critical section 'workcrit' is held on entry */
> +  if (aio->aio_prev)
> +    aio->aio_prev->aio_next =3D aio->aio_next;
> +  if (aio->aio_next)
> +    aio->aio_next->aio_prev =3D aio->aio_prev;
> +
> +  if (aio =3D=3D worklisthd)
> +    worklisthd =3D aio->aio_next;
> +  if (aio =3D=3D worklisttl)
> +    worklisttl =3D aio->aio_prev;
> +
> +  aio->aio_prev =3D aio->aio_next =3D NULL;
> +
> +  return aio;
> +}
> +
> +static int
> +aiogetslot (struct aiocb *aio)
> +{
> +  int slot;
> +
> +  /* Get free slot for this inline AIO; if none available AIO will be qu=
eued */
> +  EnterCriticalSection (&slotcrit);
> +  for (slot =3D 0; slot < AIO_MAX; ++slot)
> +    if (evt_aiocbs[slot] =3D=3D NULL)
> +      {
> +        evt_aiocbs[slot] =3D aio;
> +        LeaveCriticalSection (&slotcrit);
> +        return slot;
> +      }
> +
> +  LeaveCriticalSection (&slotcrit);
> +  return -1;
> +}
> +
> +static void
> +aionotify (struct aiocb *aio)
> +{
> +  /* if signal notification wanted, send AIO-complete signal */
> +  //XXX Is sigqueue() the best way to send signo+value within same proce=
ss?
> +  if (aio->aio_sigevent.sigev_notify =3D=3D SIGEV_SIGNAL)
> +    sigqueue (mypid,
> +              aio->aio_sigevent.sigev_signo,
> +              aio->aio_sigevent.sigev_value);

Given you have direct access to pinfo, you can just as well call
sig_send (myself, ...). This also drop the requirement to know your pid.

> +
> +  /* if this op is on LIO list and is last op, send LIO-complete signal =
*/
> +  if (aio->aio_liocb)
> +    {
> +      if (1 =3D=3D InterlockedExchangeAdd (&aio->aio_liocb->lio_count, -=
1))
> +        {
> +          /* LIO's count has decremented to zero */
> +          if (aio->aio_liocb->lio_sigevent->sigev_notify =3D=3D SIGEV_SI=
GNAL)
> +            sigqueue (mypid,
> +                      aio->aio_liocb->lio_sigevent->sigev_signo,
> +                      aio->aio_liocb->lio_sigevent->sigev_value);
> +
> +          free (aio->aio_liocb);
> +          aio->aio_liocb =3D NULL;
> +        }
> +    }
> +}
> +
> +static DWORD WINAPI __attribute__ ((noreturn))
> +aiowaiter (void *unused)
> +{ /* called on its own cygthread; runs until program exits */
> +  struct aiocb *aio;
> +  DWORD         res;
> +  int           slot;
> +  NTSTATUS      status;
> +
> +  while (1)
> +    {
> +      /* wait forever for at least one event to be set */
> +      res =3D WaitForMultipleObjects(AIO_MAX, evt_handles, FALSE, INFINI=
TE);
> +      switch (res)
> +        {
> +          case WAIT_FAILED:
> +            api_fatal ("aiowaiter fatal error, %E");
> +
> +          default:
> +            if (res < WAIT_OBJECT_0 || res >=3D WAIT_OBJECT_0 + AIO_MAX)
> +              api_fatal ("aiowaiter unexpected WFMO result %d", res);
> +            slot =3D res - WAIT_OBJECT_0;
> +
> +            /* Free up the slot used for this inline AIO */
> +            EnterCriticalSection (&slotcrit);
> +            aio =3D evt_aiocbs[slot];
> +            evt_aiocbs[slot] =3D NULL;
> +            LeaveCriticalSection (&slotcrit);
> +            debug_printf ("retired aio %p", aio);
> +
> +            /* Capture Windows status and convert to Cygwin status */
> +            status =3D aio->aio_win_iosb.Status;
> +            if (NT_SUCCESS (status))
> +              {
> +                aio->aio_rbytes =3D aio->aio_win_iosb.Information;
> +                aio->aio_errno =3D 0;
> +              }
> +            else
> +              {
> +                aio->aio_rbytes =3D -1;
> +                aio->aio_errno =3D geterrno_from_nt_status (status);
> +              }
> +
> +            /* send completion signal if user requested it */
> +            aionotify (aio);
> +        }
> +    }
> +}
> +
> +static DWORD WINAPI __attribute__ ((noreturn))
> +aioworker (void *unused)
> +{ /* multiple instances; called on own cygthreads; runs 'til program exi=
ts */
> +  struct aiocb *aio;
> +
> +  while (1)
> +    {
> +      /* park here until there's work to do */
> +      sem_wait (&worksem);
> +
> +look4work:
> +      EnterCriticalSection (&workcrit);
> +      if (!worklisthd)
> +        {
> +          /* another aioworker picked up the work already */
> +          LeaveCriticalSection (&workcrit);
> +          continue;
> +        }
> +
> +      aio =3D dequeue (worklisthd);
> +      LeaveCriticalSection (&workcrit);
> +
> +      //XXX Historical commentary to be removed before final ship of thi=
s code:
> +      //XXX
> +      //XXX About to use read|write.  Should we require aio_offset to be=
 zero?
> +      //XXX Or ignore aio_offset?  Or manually seek/op/reseek on seekabl=
e fds?
> +      //XXX [time passes for testing]
> +      //XXX Crap! Must seek/op/reseek or all the writes append to the fi=
le!
> +      //XXX Or turn these back into pread|pwrite as originally here. If =
those
> +      //XXX fail here, then do seek/op/reseek. That should work out OK.
> +      //XXX Could they be made inline AIOs here, just initiated from thr=
eads?

Not sure how relevant this comment still is...

> +      debug_printf ("starting aio %p", aio);
> +      aio->aio_errno =3D EBUSY; /* mark AIO as physically underway now */
> +      switch (aio->aio_lio_opcode)
> +        {
> +          case LIO_NOP:
> +            aio->aio_rbytes =3D 0;
> +            break;
> +
> +          case LIO_READ:
> +            aio->aio_rbytes =3D asyncread (aio);
> +            break;
> +
> +          case LIO_WRITE:
> +            aio->aio_rbytes =3D asyncwrite (aio);
> +            break;
> +
> +          default:
> +            errno =3D EINVAL;
> +            aio->aio_rbytes =3D -1;
> +            break;
> +        }
> +
> +      /* if operation errored, save error number, else clear it */
> +      if (aio->aio_rbytes =3D=3D -1)
> +        aio->aio_errno =3D get_errno ();
> +      else
> +        aio->aio_errno =3D 0;
> +
> +      /* if we had no slot for inline async AIO, re-queue it */
> +      if (aio->aio_errno =3D=3D ENOBUFS)
> +        {
> +          usleep (1000); //XXX No, leads to unrest. Wait on an event or =
sem */

Why requeuing?  Shouldn't this case just error out with EAGAIN?

> +          aio->aio_errno =3D EINPROGRESS;
> +          aioqueue (aio); // re-queue this AIO
> +          goto look4work;
> +        }
> +
> +      /* if we're not permitted to seek on given fd, do the op manually =
*/
> +      if (aio->aio_errno =3D=3D ESPIPE)
> +        {
> +	  //XXX Wait a minute. ESPIPE can mean "pread|pwrite not yet
> +	  //XXX implemented for this device type" or it can mean "can't seek
> +	  //XXX on this device type".  Those require different actions here.
> +	  //
> +	  //XXX For the is-seekable case:
> +	  //XXX if aio_offset !=3D 0, save current file position
> +	  //XXX if aio_offset !=3D 0, set new file position
> +	  //XXX do op
> +	  //XXX if aio_offset !=3D 0, set saved file position
> +	  //XXX Not quite; what if aio_offset zero is actually intended by app?
> +	  //
> +	  //XXX For the non-seekable case:
> +	  //XXX do op as if aio_offset doesn't matter?

That shows that I should read all of the patch first.  Also, it shows
that I forgot to think about non-seekable files.  The emerrassment
serves me right.

I just read SUSv4 again, and it allows to return EINVAL for invalid
offsets.  However, glibc simply calls write if pwrite failed with
ESPIPE.  We could just do the same.  It would also decouple us from the
fact if pread/pwrite exists for an fhandler or not.

> +        }
> +
> +      /* send completion signal if user requested it */
> +      aionotify (aio);
> +      debug_printf ("completed aio %p", aio);
> +      goto look4work;
> +    }
> +}
> +
> +static void
> +aioinit (void)
> +{
> +  /* first a cheap test to speed processing after initialization complet=
es */
> +  if (aioinitialized >=3D 0)
> +    {
> +      /* guard against multiple threads initializing at same time */
> +      if (0 =3D=3D InterlockedExchangeAdd (&aioinitialized, 1))
> +        {
> +          int       i =3D AIO_MAX;
> +          char     *tnames =3D (char *) malloc (AIO_MAX * 8);
> +
> +          if (!tnames)
> +            api_fatal ("couldn't create aioworker tname table");
> +
> +          InitializeCriticalSection (&slotcrit);
> +          InitializeCriticalSection (&workcrit);
> +          sem_init (&worksem, 0, 0);
> +          mypid =3D getpid ();=20
> +          /* create AIO_MAX number of aioworker threads for queued AIOs =
*/
> +          //XXX Another option is #threads =3D=3D 1 + #cores
> +          while (i--)
> +            {
> +              __small_sprintf (&tnames[i * 8], "aio%d", AIO_MAX - i);
> +              if (!new cygthread (aioworker, NULL, &tnames[i * 8]))
> +                api_fatal ("couldn't create an aioworker thread, %E");
> +            }
> +
> +          /* initialize event handles array for inline AIOs */
> +          for (i =3D 0; i < AIO_MAX; ++i)
> +            {
> +              /* events are non-inheritable, auto-reset, init unset, unn=
amed */
> +              evt_handles[i] =3D CreateEvent (NULL, FALSE, FALSE, NULL);
> +              if (!evt_handles[i])
> +                api_fatal ("couldn't create an event, %E");
> +            }
> +
> +          /* create aiowaiter thread; waits for inline AIO completion ev=
ents */
> +          if (!new cygthread (aiowaiter, NULL, "aio"))
> +            api_fatal ("couldn't create aiowaiter thread, %E");
> +
> +          /* indicate we have completed initialization */
> +          InterlockedExchange (&aioinitialized, -1);
> +        }
> +      else
> +        /* if 'aioinitialized' is greater than zero, another thread is
> +           initializing for us; wait until 'aioinitialized' goes negativ=
e */
> +        while (InterlockedExchangeAdd (&aioinitialized, 0) >=3D 0)
> +          usleep (1000);
> +    }
> +}
> +
> +static int
> +aioqueue (struct aiocb *aio)
> +{ /* add an AIO to the worklist, to be serviced by a worker thread */
> +  if (aioinitialized >=3D 0)
> +    aioinit ();
> +
> +  EnterCriticalSection (&workcrit);
> +  enqueue (aio);
> +  LeaveCriticalSection (&workcrit);
> +
> +  debug_printf ("queued aio %p", aio);
> +  sem_post (&worksem);
> +
> +  return 0;
> +}
> +
> +int
> +aio_cancel (int fildes, struct aiocb *aio)
> +{
> +  int           aiocount =3D 0;
> +  struct aiocb *ptr;
> +
> +  /* Note 'aio' is allowed to be NULL here; it's used as a wildcard */
> +restart:
> +  EnterCriticalSection (&workcrit);
> +  ptr =3D worklisthd;
> +
> +  while (ptr)
> +    {
> +      if (ptr->aio_fildes =3D=3D fildes && (!aio || ptr =3D=3D aio))
> +        {
> +          /* this queued AIO qualifies for cancellation */
> +          ptr =3D dequeue (ptr);
> +          LeaveCriticalSection (&workcrit);
> +
> +          ptr->aio_errno =3D ECANCELED;
> +          ptr->aio_rbytes =3D -1;
> +
> +          /* if signal notification wanted, send AIO-canceled signal */
> +          if (ptr->aio_sigevent.sigev_notify =3D=3D SIGEV_SIGNAL)
> +            sigqueue (mypid,
> +                      ptr->aio_sigevent.sigev_signo,
> +                      ptr->aio_sigevent.sigev_value);
> +
> +          ++aiocount;
> +          goto restart;
> +        }
> +      ptr =3D ptr->aio_next;
> +    }
> +
> +  LeaveCriticalSection (&workcrit);
> +
> +  /* Note AIO_NOTCANCELED is not possible in this implementation.  That's
> +     because AIOs are dequeued to execute; the worklist search above won=
't
> +     find an AIO that's been dequeued from the worklist. */
> +  if (aiocount)
> +    return AIO_CANCELED;
> +  else
> +    return AIO_ALLDONE;
> +}
> +
> +int
> +aio_error (const struct aiocb *aio)
> +{
> +  int err;
> +
> +  if (!aio)
> +    {
> +      set_errno (EINVAL);
> +      return -1;
> +    }
> +
> +  switch (aio->aio_errno)
> +    {
> +      case EBUSY: /* This state for internal use only; not visible to ap=
p */
> +      case ENOBUFS: /* This state for internal use only; not visible to =
app */
> +        err =3D EINPROGRESS;
> +        break;
> +
> +      default:
> +        err =3D aio->aio_errno;
> +    }
> +
> +  return err;
> +}
> +
> +#ifdef _POSIX_SYNCHRONIZED_IO
> +int
> +aio_fsync (int mode, struct aiocb *aio)
> +{
> +  if (!aio)
> +    {
> +      set_errno (EINVAL);
> +      return -1;
> +    }
> +
> +  switch (mode)
> +    {
> +#if defined(O_SYNC)
> +      case O_SYNC:
> +        aio->aio_rbytes =3D fsync (aio->aio_fildes);
> +        break;
> +
> +#if defined(O_DSYNC) && O_DSYNC !=3D O_SYNC
> +      case O_DSYNC:
> +        aio->aio_rbytes =3D fdatasync (aio->aio_fildes);
> +        break;
> +#endif
> +#endif
> +
> +      default:
> +        set_errno (EINVAL);
> +        return -1;
> +    }
> +
> +  if (aio->aio_rbytes =3D=3D -1)
> +    aio->aio_errno =3D get_errno ();
> +
> +  return aio->aio_rbytes;
> +}
> +#endif /* _POSIX_SYNCHRONIZED_IO */
> +
> +static int
> +asyncread (struct aiocb *aio)
> +{ /* Try to initiate an inline async read, whether from app or worker th=
read */
> +  ssize_t       res =3D 0;
> +  int           slot =3D 0;
> +
> +  cygheap_fdget cfd (aio->aio_fildes);
> +  if (cfd < 0)
> +    res =3D -1; /* errno has been set to EBADF */
> +  else
> +    {
> +      slot =3D aiogetslot (aio);
> +      if (slot >=3D 0)
> +        {
> +          aio->aio_errno =3D EBUSY; /* mark AIO as physically underway n=
ow */
> +          aio->aio_win_event =3D evt_handles[slot];
> +          res =3D cfd->pread ((void *) aio->aio_buf, aio->aio_nbytes,
> +                            aio->aio_offset, (void *) aio);
> +          //XXX Can we have a variant pread method that takes 1 arg: *ai=
o?

Well, glibc does with pread/pwrite alone, but I guess it's not much of a
problem to add inline pread/pwrite methods with a different set of args.

> +        }
> +      else
> +        {
> +          set_errno (ENOBUFS);
> +          res =3D -1;
> +        }
> +    }
> +
> +  return res;
> +}
> +
> +int
> +aio_read (struct aiocb *aio)
> +{
> +  ssize_t       res =3D 0;
> +
> +  if (!aio)
> +    {
> +      set_errno (EINVAL);
> +      return -1;
> +    }
> +  if (aioinitialized >=3D 0)
> +    aioinit ();
> +
> +  /* Try to launch inline async read; only on ESPIPE is it queued */
> +  pthread_testcancel ();
> +  res =3D asyncread (aio);
> +
> +  /* If async read couldn't be launched, queue the AIO for a worker thre=
ad */
> +  if (res =3D=3D -1 && (get_errno () =3D=3D ESPIPE || get_errno () =3D=
=3D ENOBUFS))
> +    {
> +      aio->aio_lio_opcode =3D LIO_READ;
> +      aio->aio_liocb =3D NULL;
> +      aio->aio_errno =3D EINPROGRESS;
> +      aio->aio_rbytes =3D -1;
> +
> +      res =3D aioqueue (aio);
> +    }
> +
> +  return res;
> +}
> +
> +ssize_t
> +aio_return (struct aiocb *aio)
> +{
> +  if (!aio)
> +    {
> +      set_errno (EINVAL);
> +      return -1;
> +    }
> +
> +  switch (aio->aio_errno)
> +    {
> +      case EBUSY:       /* AIO is currently underway (internal state) */
> +      case ENOBUFS:     /* AIO is currently underway (internal state) */
> +      case EINPROGRESS: /* AIO has been queued successfully */
> +        set_errno (EINPROGRESS);
> +        return -1;
> +
> +      case EINVAL:      /* aio_return() has already been called on this =
AIO */
> +        set_errno (aio->aio_errno);
> +        return -1;
> +
> +      default:          /* AIO has completed, successfully or not */
> +        ;
> +    }
> +
> +  /* This AIO has completed so grab any error status if present */
> +  if (aio->aio_rbytes =3D=3D -1)
> +    set_errno (aio->aio_errno);
> +
> +  /* Set this AIO's errno so later aio_return() calls on this AIO fail */
> +  aio->aio_errno =3D EINVAL;
> +
> +  return aio->aio_rbytes;
> +}
> +
> +static int
> +aiosuspend (const struct aiocb *const aiolist[],
> +         int nent, const struct timespec *timeout)
> +{
> +  /* Returns lowest list index of completed aios, else 'nent' if all com=
pleted.
> +     If none completed on entry, wait for interval specified by 'timeout=
'. */
> +  int       aiocount;
> +  int       i;
> +  DWORD     msecs =3D 0;
> +  int       result;
> +  sigset_t  sigmask;
> +  siginfo_t si;
> +  DWORD     time0, time1;
> +  struct timespec *to =3D (struct timespec *) timeout;
> +
> +  if (to)
> +    msecs =3D (1000 * to->tv_sec) + ((to->tv_nsec + 999999) / 1000000);
> +
> +retry:
> +  sigemptyset (&sigmask);
> +  aiocount =3D 0;
> +  for (i =3D 0; i < nent; ++i)
> +    if (aiolist[i] && aiolist[i]->aio_liocb)
> +      {
> +        if (aiolist[i]->aio_errno =3D=3D EINPROGRESS ||
> +            aiolist[i]->aio_errno =3D=3D ENOBUFS ||
> +            aiolist[i]->aio_errno =3D=3D EBUSY)
> +          {
> +            ++aiocount;
> +            if (aiolist[i]->aio_sigevent.sigev_notify =3D=3D SIGEV_SIGNA=
L)
> +              sigaddset (&sigmask, aiolist[i]->aio_sigevent.sigev_signo);
> +          }
> +        else
> +          return i;
> +      }
> +
> +  if (aiocount =3D=3D 0)
> +    return nent;
> +
> +  if (to && msecs =3D=3D 0)
> +    {
> +      set_errno (EAGAIN);
> +      return -1;
> +    }
> +
> +  time0 =3D GetTickCount ();
> +  result =3D sigtimedwait (&sigmask, &si, to);
> +  if (result =3D=3D -1)
> +    return -1; /* return with errno set by failed sigtimedwait() */
> +  time1 =3D GetTickCount ();
> +
> +  /* adjust timeout to account for time just waited */
> +  msecs -=3D (time1 - time0);
> +  if (msecs < 0)
> +    msecs =3D 0;
> +  to->tv_sec =3D msecs / 1000;
> +  to->tv_nsec =3D (msecs % 1000) * 1000000;
> +
> +  goto retry;
> +}
> +
> +int
> +aio_suspend (const struct aiocb *const aiolist[],
> +             int nent, const struct timespec *timeout)
> +{
> +  int result;
> +
> +  if (nent < 0 /*XXX maybe delete this: || nent > AIO_LISTIO_MAX*/)

If it works without wasting resources, why not?

Rest looks good.  However, I'm missing SIGEV_THREAD handling.
Did I miss something?


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--m1UC1K4AOz1Ywdkx
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlrYm+oACgkQ9TYGna5E
T6BlVQ//Y8jymT2Y/aHa4EhCoxXUUrySa5uoUd5xgcBZ16feSbOQ5ndGn8a+h89S
ezAqXe5o0MmS3H74C0NZptk+Fj+HV0oxUHJ8eSpy+4mO635oPCukp9O49FFe4xtw
PsnDDhakV5XstQDJaCFEGdATz3pnqCNfmn5o0a8fIsqj9nggOlJCYA11mDD9oZr8
1qnGUilTSMEbD5GRWAMi3S7C556vlkpLendD5uD1tCof9yDq6wrXL8sve063zYdy
ap5SwIv0R3ysUNIjJvPUL7t7jSMGx+q1yloQjJO3mM52Bf+PPIYAjtTirSg2v+Lt
gttfjPf1b4nQ14xHXr2s8r1FCEG0ls/v445C5jL5mYQk0Xrdr5UNhkXKYOPbu8Eb
Ihjdup90gD/TCVIjj7W87F40W+w6N/owWe9bjs+fUt2leMXzsNXsE0wO/XEGA0uj
R8HyZnxvtswvxOMUjTXjJcPZ9T+BcmjaqwuU+cK7pfflIymjfy6nx1qbrQU896MF
13j4VXY7Yz3ee0nwhQiTJz0VPAIboWrx4RIUy7xUMzD5p8tgRrVf4Q4LGC0e16hg
GZ4+HBTdzqbxTNFXyqgNGe0Tk4lrjQiDgEpIk2nNCUkfZaYT6UPRldWapzEdi5sx
HRBlI0pnUogLu2ba61Rr921N0RbHNlBo69IJJzVo7EeWfuqCInk=
=kv7L
-----END PGP SIGNATURE-----

--m1UC1K4AOz1Ywdkx--
