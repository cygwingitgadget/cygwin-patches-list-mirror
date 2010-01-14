Return-Path: <cygwin-patches-return-6902-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 865 invoked by alias); 14 Jan 2010 04:00:46 -0000
Received: (qmail 850 invoked by uid 22791); 14 Jan 2010 04:00:43 -0000
X-SWARE-Spam-Status: No, hits=-2.0 required=5.0 	tests=AWL,BAYES_00,SPF_SOFTFAIL
X-Spam-Check-By: sourceware.org
Received: from qmta05.emeryville.ca.mail.comcast.net (HELO qmta05.emeryville.ca.mail.comcast.net) (76.96.30.48)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 14 Jan 2010 04:00:38 +0000
Received: from omta04.emeryville.ca.mail.comcast.net ([76.96.30.35]) 	by qmta05.emeryville.ca.mail.comcast.net with comcast 	id V9Mz1d0030lTkoCA5G0ef4; Thu, 14 Jan 2010 04:00:38 +0000
Received: from [192.168.0.106] ([24.10.244.244]) 	by omta04.emeryville.ca.mail.comcast.net with comcast 	id VG0c1d00G5H651C8QG0d57; Thu, 14 Jan 2010 04:00:38 +0000
Message-ID: <4B4E96D3.90300@byu.net>
Date: Thu, 14 Jan 2010 04:00:00 -0000
From: Eric Blake <ebb9@byu.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: dup3/O_CLOEXEC/F_DUPFD_CLOEXEC
References: <20100113212537.GB14511@calimero.vinschen.de>
In-Reply-To: <20100113212537.GB14511@calimero.vinschen.de>
Content-Type: multipart/signed; micalg=pgp-sha1;  protocol="application/pgp-signature";  boundary="------------enig650038A591E88012BE4113B9"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2010-q1/txt/msg00018.txt.bz2

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig650038A591E88012BE4113B9
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-length: 10355

According to Corinna Vinschen on 1/13/2010 2:25 PM:
> Hi,
>=20
> the below patch implements the Linux dup3/O_CLOEXEC/F_DUPFD_CLOEXEC
> extension.  I hope I didn't miss anything important since it affects
> quite a few fhandlers.

> Eric, you asked for it in the first place, do you have a fine testcase
> for this functionality?

For dup3, fcntl(F_DUPFD_CLOEXEC), and pipe2, yes.  For open, accept4, and
others, you'll have to use your imagination, but it is is similar.

http://git.sv.gnu.org/cgit/gnulib.git/tree/tests/test-dup3.c?id=3D84ab6921
then modified slightly:

/* Test duplicating file descriptors.
   Copyright (C) 2009 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* Written by Eric Blake <ebb9@byu.net>, 2009,
   and Bruno Haible <bruno@clisp.org>, 2009.  */

#include <unistd.h>

#include <errno.h>
#include <fcntl.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>

#include <io.h>

#define ASSERT(expr) \
  do  \
    {	 \
      if (!(expr))	\
        {		\
          fprintf (stderr, "%s:%d: assertion failed\n", __FILE__, \
		 __LINE__); \
          fflush (stderr); \
          abort ();	     \
        }		     \
    }			    \
  while (0)

/* Return true if FD is open.  */
static bool
is_open (int fd)
{
  return 0 <=3D fcntl (fd, F_GETFL);
}

/* Return true if FD is not inherited to child processes.  */
static bool
is_cloexec (int fd)
{
  int flags;
  ASSERT ((flags =3D fcntl (fd, F_GETFD)) >=3D 0);
  return (flags & FD_CLOEXEC) !=3D 0;
}

int
main (void)
{
  int use_cloexec;

  for (use_cloexec =3D 0; use_cloexec <=3D 1; use_cloexec++)
    {
      const char *file =3D "test-dup3.tmp";
      int fd =3D open (file, O_CREAT | O_TRUNC | O_RDWR, 0600);
      int o_flags;
      char buffer[1];

      o_flags =3D 0;
      if (use_cloexec)
	o_flags |=3D O_CLOEXEC;

      /* Assume std descriptors were provided by invoker.  */
      ASSERT (STDERR_FILENO < fd);
      ASSERT (is_open (fd));
      /* Ignore any other fd's leaked into this process.  */
      close (fd + 1);
      close (fd + 2);
      ASSERT (!is_open (fd + 1));
      ASSERT (!is_open (fd + 2));

      /* Assigning to self is invalid.  */
      errno =3D 0;
      ASSERT (dup3 (fd, fd, o_flags) =3D=3D -1);
      ASSERT (errno =3D=3D EINVAL);
      ASSERT (is_open (fd));

      /* If the source is not open, then the destination is unaffected.  */
      errno =3D 0;
      ASSERT (dup3 (fd + 1, fd + 2, o_flags) =3D=3D -1);
      ASSERT (errno =3D=3D EBADF);
      ASSERT (!is_open (fd + 2));
      errno =3D 0;
      ASSERT (dup3 (fd + 1, fd, o_flags) =3D=3D -1);
      ASSERT (errno =3D=3D EBADF);
      ASSERT (is_open (fd));

      /* The destination must be valid.  */
      errno =3D 0;
      ASSERT (dup3 (fd, -2, o_flags) =3D=3D -1);
      ASSERT (errno =3D=3D EBADF);
      errno =3D 0;
      ASSERT (dup3 (fd, 10000000, o_flags) =3D=3D -1);
      ASSERT (errno =3D=3D EBADF);

      /* Using dup3 can skip fds.  */
      ASSERT (dup3 (fd, fd + 2, o_flags) =3D=3D fd + 2);
      ASSERT (is_open (fd));
      ASSERT (!is_open (fd + 1));
      ASSERT (is_open (fd + 2));
      if (use_cloexec)
	ASSERT (is_cloexec (fd + 2));
      else
	ASSERT (!is_cloexec (fd + 2));

      /* Verify that dup3 closes the previous occupant of a fd.  */
      ASSERT (open ("/dev/null", O_WRONLY, 0600) =3D=3D fd + 1);
      ASSERT (dup3 (fd + 1, fd, o_flags) =3D=3D fd);
      ASSERT (close (fd + 1) =3D=3D 0);
      ASSERT (write (fd, "1", 1) =3D=3D 1);
      ASSERT (dup3 (fd + 2, fd, o_flags) =3D=3D fd);
      ASSERT (lseek (fd, 0, SEEK_END) =3D=3D 0);
      ASSERT (write (fd + 2, "2", 1) =3D=3D 1);
      ASSERT (lseek (fd, 0, SEEK_SET) =3D=3D 0);
      ASSERT (read (fd, buffer, 1) =3D=3D 1);
      ASSERT (*buffer =3D=3D '2');

      /* Clean up.  */
      ASSERT (close (fd + 2) =3D=3D 0);
      ASSERT (close (fd) =3D=3D 0);
      ASSERT (unlink (file) =3D=3D 0);
    }

  return 0;
}

Likewise for fcntl and pipe2 (although I won't paste them here):
http://git.sv.gnu.org/cgit/gnulib.git/tree/tests/test-fcntl.c?id=3Db72fe29b
http://git.sv.gnu.org/cgit/gnulib.git/tree/tests/test-pipe2.c?id=3Dd72a5819

But there's a few things we need to fix first before it is even worth
trying to run those tests.

> +++ winsup/cygwin/dtable.cc	13 Jan 2010 21:22:13 -0000
> @@ -579,7 +579,11 @@ dtable::dup_worker (fhandler_base *oldfh
>  	}
>        else
>  	{
> -	  newfh->close_on_exec (false);
> +	  /* The O_CLOEXEC flag enforces close-on-exec behaviour. */
> +	  if (flags & O_CLOEXEC)
> +	    newfh->set_close_on_exec (true);

Is that a typo?

> +	  else
> +	    newfh->close_on_exec (false);

If not, why not just newfh->close_on_exec (!!(flags & O_CLOEXEC)), instead
of the if-else?

>  {
>    int res =3D -1;
>    fhandler_base *newfh =3D NULL;	// =3D NULL to avoid an incorrect warni=
ng
>=20=20
>    MALLOC_CHECK;
> -  debug_printf ("dup2 (%d, %d)", oldfd, newfd);
> +  debug_printf ("dup3 (%d, %d, %d)", oldfd, newfd, flags);

I'd prefer %#x for flags, rather than %d (two instances in this function).

>    lock ();
>=20=20
>    if (not_open (oldfd))
> @@ -602,21 +606,25 @@ dtable::dup2 (int oldfd, int newfd)
>        set_errno (EBADF);
>        goto done;
>      }
> -
>    if (newfd < 0)
>      {
>        syscall_printf ("new fd out of bounds: %d", newfd);
>        set_errno (EBADF);
>        goto done;
>      }
> -
> +  if ((flags & ~O_CLOEXEC) !=3D 0)
> +    {
> +      syscall_printf ("invalid flags value %x", flags);
> +      set_errno (EINVAL);
> +      return -1;
> +    }
>    if (newfd =3D=3D oldfd)
>      {
>        res =3D newfd;
>        goto done;
>      }

Per Linux, newfd=3D=3Doldfd must fail with EINVAL:
http://www.kernel.org/doc/man-pages/online/pages/man2/dup3.2.html

I see how you are filtering this case out in dup3(), but I wonder if it
would be easier to make this function assume that newfd!=3Doldfd (in other
words, make both dup2 and dup3 do the appropriate special casing, so this
function doesn't have to do any).  More on that below.

> +++ winsup/cygwin/fcntl.cc	13 Jan 2010 21:22:13 -0000
> @@ -49,6 +49,15 @@ fcntl64 (int fd, int cmd, ...)
>  	  res =3D -1;
>  	}
>        break;
> +    case F_DUPFD_CLOEXEC:
> +      if ((int) arg >=3D 0 && (int) arg < OPEN_MAX_MAX)
> +	res =3D dup3 (fd, cygheap_fdnew (((int) arg) - 1), O_CLOEXEC);
> +      else
> +	{
> +	  set_errno (EINVAL);
> +	  res =3D -1;
> +	}
> +      break;

Why not consolidate the two branches, and write this as:

case F_DUPFD:
case F_DUPFD_CLOEXEC:
  if ((int) arg >=3D 0 && (int) arg < OPEN_MAX_MAX)
    res =3D dup3 (fd, cygheap_fdnew (((int) arg) - 1),
                (cmd =3D=3D F_DUPFD_CLOEXEC) * O_CLOEXEC);
  else
...

> +++ winsup/cygwin/fhandler.cc	13 Jan 2010 21:22:13 -0000
> +++ winsup/cygwin/fhandler_fifo.cc	13 Jan 2010 21:22:14 -0000
> @@ -94,7 +94,9 @@ fhandler_fifo::open (int flags, mode_t)
>      {
>        char char_sa_buf[1024];
>        LPSECURITY_ATTRIBUTES sa_buf =3D
> -	sec_user ((PSECURITY_ATTRIBUTES) char_sa_buf, cygheap->user.sid());
> +	flags & O_CLOEXEC
> +	? sec_user_nih ((PSECURITY_ATTRIBUTES) char_sa_buf, cygheap->user.sid())
> +	: sec_user ((PSECURITY_ATTRIBUTES) char_sa_buf, cygheap->user.sid());

In addition to cgf's comment about this repetition, is it any more compact
to write:

((flags & O_CLOEXEC) ? sec_user_nih : sec_user) ((PSECURITY_ATTRIBUTES)
char_sa_buf, cygheap->user.sid());

> +++ winsup/cygwin/syscalls.cc	13 Jan 2010 21:22:16 -0000
> @@ -119,7 +119,7 @@ close_all_files (bool norelease)
>  int
>  dup (int fd)
>  {
> -  return cygheap->fdtab.dup2 (fd, cygheap_fdnew ());
> +  return cygheap->fdtab.dup3 (fd, cygheap_fdnew (), 0);
>  }
>=20=20
>  int
> @@ -131,7 +131,25 @@ dup2 (int oldfd, int newfd)
>        set_errno (EBADF);
>        return -1;
>      }
> -  return cygheap->fdtab.dup2 (oldfd, newfd);
> +  return cygheap->fdtab.dup3 (oldfd, newfd, 0);

If you fix fdtab.dup3 above to omit the oldfd=3D=3Dnewfd, then you need to =
add
something like this before trying dup3:

if (oldfd =3D=3D newfd)
  {
    cygheap_fdget cfd (oldfd);
    if (cfd < 0)
      {
        set_errno (EBADF);
        return -1;
      }
    return oldfd;
  }

> +}
> +
> +int
> +dup3 (int oldfd, int newfd, int flags)
> +{
> +  if (newfd >=3D OPEN_MAX_MAX)
> +    {
> +      syscall_printf ("-1 =3D dup3 (%d, %d, %d) (%d too large)", oldfd, =
newfd, flags, newfd);

Again with the %#x instead of %d for flags.

> +      set_errno (EBADF);
> +      return -1;
> +    }
> +  if (!cygheap->fdtab.not_open (oldfd) && oldfd =3D=3D newfd)

Is not_open() expensive?  If so, reverse the order of the conditionals for
speed.

> +    {
> +      syscall_printf ("-1 =3D dup3 (%d, %d, %d) (newfd=3D=3Doldfd)", old=
fd, newfd, flags);
> +      set_errno (EINVAL);
> +      return -1;
> +    }
> +  return cygheap->fdtab.dup3 (oldfd, newfd, flags);

According to spec, Linux dup3(-1,-1,0) can fail with either EBADF or
EINVAL; I haven't tested that on Linux yet, but am assuming that your
choice of EBADF for this condition was intentional?

As long as we are exporting dup3, why not also pipe2, accept4, mkostemp,
and mkostemps?  Plus there are tweaks to existing interfaces (the 'e' flag
to fopen, fdopen, freopen, popen; the SOCK_CLOEXEC flag to socket and
socketpair), some of which need more newlib patches.  And while it looks
like mq_open should not care about O_CLOEXEC, there may be some cleanup
needed there.

Linux also has other functions that now take a flag for O_CLOEXEC
purposes, such as epoll_create1 (compared to the older epoll_create); but
none of the other functions appeared to be based on standardized
interfaces, nor to have a counterpart in cygwin yet.

--=20
Don't work too hard, make some time for fun as well!

Eric Blake             ebb9@byu.net


--------------enig650038A591E88012BE4113B9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-length: 320

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAktOluoACgkQ84KuGfSFAYDSrQCcD5OofiUQcu1527kzvZxgYJcr
81cAoMl/wM889qbfWmb/6bL/fp+ASKxc
=/b5O
-----END PGP SIGNATURE-----

--------------enig650038A591E88012BE4113B9--
