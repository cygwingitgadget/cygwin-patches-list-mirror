Return-Path: <cygwin-patches-return-9119-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13691 invoked by alias); 16 Jul 2018 14:21:34 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 13670 invoked by uid 89); 16 Jul 2018 14:21:33 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-123.9 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2 spammy=apps, worker, Another, synchronous
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (217.72.192.73) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 16 Jul 2018 14:21:31 +0000
Received: from calimero.vinschen.de ([217.91.18.234]) by mrelayeu.kundenserver.de (mreue103 [212.227.15.183]) with ESMTPSA (Nemesis) id 0LmNdq-1gEgJO39ta-00a0MK for <cygwin-patches@cygwin.com>; Mon, 16 Jul 2018 16:21:28 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 395D0A80576; Mon, 16 Jul 2018 16:21:28 +0200 (CEST)
Date: Mon, 16 Jul 2018 14:21:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3 1/3] POSIX Asynchronous I/O support: aio files
Message-ID: <20180716142128.GZ27673@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20180715082025.4920-1-mark@maxrnd.com> <20180715082025.4920-2-mark@maxrnd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="v+Mbu5iuT/5Blw/K"
Content-Disposition: inline
In-Reply-To: <20180715082025.4920-2-mark@maxrnd.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SW-Source: 2018-q3/txt/msg00014.txt.bz2


--v+Mbu5iuT/5Blw/K
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 6465

Hi Mark,

this looks good.  Inline comments as usual.

On Jul 15 01:20, Mark Geisert wrote:
> + *     (2) no more than AIO_MAX inline AIOs will be in progress at same =
time.
> + * In all other cases queued AIOs will be used.
> + *
> + * An inline AIO is performed by the calling app's thread as a pread|pwr=
ite on
> + * a shadow fd that permits Windows asynchronous i/o, with event notific=
ation
> + * on completion.  Event arrival causes AIO context for the fd to be upd=
ated.
> + *
> + * A queued AIO is performed in a similar manner, but by an AIO worker t=
hread
> + * rather than the calling app's thread.  The queued flavor can also ope=
rate=20
> + * on sockets, pipes, non-binary files, mandatory-locked files, and files
> + * that don't support pread|pwrite.  Generally all these cases are handl=
ed as
> + * synchronous read|write operations, but still don't delay the app beca=
use
> + * they're taken care of by AIO worker threads.
> + */
> +
> +/* These variables support inline AIO operations */
> +static NO_COPY HANDLE            evt_handles[AIO_MAX];
> +static NO_COPY struct aiocb     *evt_aiocbs[AIO_MAX];
> +static NO_COPY CRITICAL_SECTION  evt_locks[AIO_MAX]; /* per-slot locks */
> +static NO_COPY CRITICAL_SECTION  slotcrit; /* lock for slot variables in=
 toto */
> +
> +/* These variables support queued AIO operations */
> +static NO_COPY sem_t             worksem;   /* tells whether AIOs are qu=
eued */
> +static NO_COPY CRITICAL_SECTION  workcrit;        /* lock for AIO work q=
ueue */
> +TAILQ_HEAD(queue, aiocb) worklist =3D TAILQ_HEAD_INITIALIZER(worklist);
> +
> +static int
> +aiochkslot (struct aiocb *aio)
> +{
> +  /* Sanity check.. make sure this AIO is not already busy */
> +  for (int slot =3D 0; slot < AIO_MAX; ++slot)
> +    if (evt_aiocbs[slot] =3D=3D aio)
> +      {
> +        debug_printf ("aio %p is already busy in slot %d", aio, slot);
> +        return slot;
> +      }
> +
> +  return -1;
> +}

Shouldn't this check be under lock as well?  Or I am missing something.
Why is the lock not necessary here?

> +aionotify_on_pthread (struct sigevent *evp)
> +{
> +  pthread_attr_t *attr;
> +  pthread_attr_t  default_attr;
> +  int             rc;
> +  pthread_t       vaquita; /* =3D=3D "little porpoise", endangered */
> +
> +  if (evp->sigev_notify_attributes)
> +    attr =3D evp->sigev_notify_attributes;
> +  else
> +    {
> +      pthread_attr_init (attr =3D &default_attr);
> +      pthread_attr_setdetachstate (attr, PTHREAD_CREATE_DETACHED);
> +    }
> +
> +  rc =3D pthread_create (&vaquita, attr,
> +                       (void * (*) (void *)) evp->sigev_notify_function,
> +                       evp->sigev_value.sival_ptr);
> +
> +  /* The following error is not expected. If seen often, develop a recov=
ery. */
> +  if (rc)
> +    debug_printf ("aio vaquita thread creation failed, %E");

I like the name, but what's the background for naming a thread like this?
Just curious.  A bit of comment might help to keep it in mind, too :)

> +      /* If we thought we had a slot for this queued async AIO, but lost=
 out */
> +      if (aio->aio_errno =3D=3D ENOBUFS)
> +        {
> +          aio->aio_errno =3D EINPROGRESS;
> +          aioqueue (aio); /* Re-queue the AIO */
> +
> +          /* Another option would be to fail the AIO with error EAGAIN, =
but
> +           * experience with iozone showed apps might not expect to see a
> +           * deferred EAGAIN.  I.e. they should expect EAGAIN on their c=
all to
> +           * aio_read() or aio_write() but probably not expect to see EA=
GAIN
> +           * on an aio_error() query after they'd previously seen EINPRO=
GRESS
> +           * on the initial AIO call.
> +           */
> +          continue;
> +        }

Got it.

> +          /* Do the requested AIO operation manually, synchronously */
> +          switch (aio->aio_lio_opcode)
> +            {
> +              case LIO_READ:
> +                /*XXX Hmm, no direct result? This OK? */

Unfortunately the fhandler read method has been written this way more
than 20 years ago.  I have no idea why and it's ugly as hell.

But there is a result: The second parameter is set to the number of bytes
read or -1 on error, in which case errno is set.

Feel free to rewrite the fhandler read method to look more sane :)

> +#ifdef _POSIX_SYNCHRONIZED_IO

We really don't need this ifdef, not even in the header.  The macro is
certainly defined.

> diff --git a/winsup/cygwin/include/aio.h b/winsup/cygwin/include/aio.h
> new file mode 100644
> index 000000000..34ff29969
> --- /dev/null
> +++ b/winsup/cygwin/include/aio.h
> @@ -0,0 +1,82 @@
> +/* aio.h: Support for Posix asynchronous i/o routines.
> +
> +This file is part of Cygwin.
> +
> +This software is a copyrighted work licensed under the terms of the
> +Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
> +details. */
> +
> +#ifndef _AIO_H
> +#define _AIO_H
> +
> +#include <sys/features.h>
> +#include <sys/queue.h>
> +#include <sys/signal.h>
> +#include <sys/types.h>
> +#include <limits.h> // for AIO_LISTIO_MAX, AIO_MAX, and AIO_PRIO_DELTA_M=
AX
> +
> +#ifndef __INSIDE_CYGWIN__
> +#include <w32api/winternl.h> // for HANDLE and IO_STATUS_BLOCK
> +#endif

Hmm.  Did I miss this last time?  Looks like it.

> +/* struct aiocb is defined by Posix */
> +struct aiocb {
> +    /* these elements of aiocb are Cygwin-specific */
> +    TAILQ_ENTRY(aiocb)   aio_chain;
> +    struct liocb        *aio_liocb;
> +    HANDLE               aio_win_event;
> +    IO_STATUS_BLOCK      aio_win_iosb;
> +    ssize_t              aio_rbytes;
> +    int                  aio_errno;
> +    /* the remaining elements of aiocb are defined by Posix */
> +    int                  aio_lio_opcode;
> +    int                  aio_reqprio; /* Not yet implemented; must be ze=
ro */
> +    int                  aio_fildes;
> +    volatile void       *aio_buf;
> +    size_t               aio_nbytes;
> +    off_t                aio_offset;
> +    struct sigevent      aio_sigevent;
> +};

Can you please change this so it doesn't require to include a
windows header?  You could use void * instead of HANDLE and define
your own __io_t (or whatever) as a struct of void * and uintptr_t
values and only cast them to the Windows types inside of Cygwin.
That ok?


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--v+Mbu5iuT/5Blw/K
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAltMqegACgkQ9TYGna5E
T6BdlxAAhhMBnWNBaL6gTxRy60UcJJ6Nelpn+o1HJVNPK/eEqTdTooVg1n6Ar6oI
YoR0l2RFJ3cV0AOBVsh+xD7YsWaH6uug8rSdxM8iRY5/tTocAv9rmek6Ai1R7Fy7
N3z1iDkEgu/Qb9uX73pzNcglS0rOVjjXYCKQWZLgs63EkK/CFikuY31HLD4GMJNN
wpJal5Nt78Dtt9rnKnjp64MetvqpsoG8GaVLPkyHwT0465aY6TonXlMlwB1cd7Mh
v+Dd3yt78zeRXzjiSNXqAZsL/lYMw1wpOUZNcdS9n2CWcCVh+XHJu22HbEAmK6UR
Xgt7H1W9X+hnANbod6hCu0G92bpBcGqi7hZh9CrpVDkbpBTYoaniSVUwsn6pEbTh
tmMeoeW0c6HWzABc/gZZMPnkEzC3HsShs0eKIllaerLtqT2EcLbvXIaA1Iet5/Ch
kjorYc7sgi+U1fIRLuZARo2ODbhA1iSrrv4m25k7RJRSGE9mpA2/cYIqWlwvusW8
YkDD6VTm8gyUL8Rn3VCtrCYEd1n1ql/9I79ciTBJmKFR8RcHVVTn27h6COrrfHuV
NDGxOeuTPkc9das0GZ6mYwphRc6e+o9dsLQKzDZC8h0Zq/uvSqoxH9tl/7PtlvU+
9lZKTVuU0acQ0IPocrWWnD1ixPZ/rHw611Z+MV9ZxTxFSivmQIY=
=/xRg
-----END PGP SIGNATURE-----

--v+Mbu5iuT/5Blw/K--
