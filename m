Return-Path: <cygwin-patches-return-2976-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 27440 invoked by alias); 16 Sep 2002 10:34:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 27400 invoked from network); 16 Sep 2002 10:34:39 -0000
Subject: Re: pthread_testcancel() causes SEGV
From: Robert Collins <rbcollins@cygwin.com>
To: Thomas Pfaff <tpfaff@gmx.net>
Cc: Jason Tishler <jason@tishler.net>, cygwin-developers@cygwin.com, 
	cygwin-patches@cygwin.com
In-Reply-To: <Pine.WNT.4.44.0209161054270.291-100000@algeria.intern.net>
References: <Pine.WNT.4.44.0209161054270.291-100000@algeria.intern.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-+e7VoU9vR2I8ATJKpoxL"
Date: Mon, 16 Sep 2002 03:34:00 -0000
Message-Id: <1032172510.17676.117.camel@lifelesswks>
Mime-Version: 1.0
X-SW-Source: 2002-q3/txt/msg00424.txt.bz2


--=-+e7VoU9vR2I8ATJKpoxL
Content-Type: multipart/mixed; boundary="=-yulHkQ/kQ/QMrqdOgxTy"


--=-yulHkQ/kQ/QMrqdOgxTy
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Content-length: 1498

On Mon, 2002-09-16 at 19:07, Thomas Pfaff wrote:
>=20
>=20
> On Tue, 10 Sep 2002, Robert Collins wrote:
>=20
> > On Thu, 2002-08-08 at 04:54, Jason Tishler wrote:
> > > Thomas,
> > >
> > > On Wed, Aug 07, 2002 at 09:34:14AM +0200, Thomas Pfaff wrote:
> > > > Thanks for tracking it down.
> > >
> > > No problem.  Thanks for the quick turn around on the patch.  I tested=
 it
> > > and can confirm that it fixes the ipc-daemon service startup problem.
> >
> > Jason,
> > sorry for the *cough* long delay.
> >
> > the attached patch is the 'right way' to deal with this issue IMO. It
> > also gives us full pthread* support for threads created using the win32
> > CreateThread call (although I won't officially support that at this
> > point :}).
> >
>=20
> Rob,
>=20
> you may have noticed that i have added similar code in my pending pthread
> patches.

I hadn't actually. I simply started at the oldest pending thing, and
reviewed it.

> Anyway, since you return a NULL pointer in pthread_self if something went
> wrong i vote for inclusion of my original patch regardless which patch
> will be applied for pthread_self.

Ah, good catch. I'll return a null object instead.

This object will fail in the method call, and log an error. It shouldn't
segv though, and we won't be introducing a null object check that
doesn't need to exist.

I'm checking in the current code, as I refactored to make some things
clearer before I introduced the NULL object.

Attached is my test program for this..

Rob

--=-yulHkQ/kQ/QMrqdOgxTy
Content-Disposition: attachment; filename=cancelwin32.c
Content-Type: text/x-c; name=cancelwin32.c; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-length: 899

#include <pthread.h>
#include <windows.h>


DWORD WINAPI
ThreadFunc (LPVOID lpParam)
{
  char szMsg[80];

  sprintf (szMsg, "Parameter =3D %d.", *(DWORD *) lpParam);
  // MessageBox (NULL, szMsg, "ThreadFunc", MB_OK);
  pthread_cancel(pthread_self());

  return 0;
}

int
main (VOID)
{
  DWORD dwThreadId, dwThrdParam =3D 1;
  HANDLE hThread;
  char szMsg[80];

  hThread =3D CreateThread (NULL,	// no security attributes=20
			  0,	// use default stack size=20=20
			  ThreadFunc,	// thread function=20
			  &dwThrdParam,	// argument to thread function=20
			  0,	// use default creation flags=20
			  &dwThreadId);	// returns the thread identifier=20

  // Check the return value for success.=20

  if (hThread =3D=3D NULL)
    {
      wsprintf (szMsg, "CreateThread failed.");
      MessageBox (NULL, szMsg, "main", MB_OK);
    }
  else
    {
      sleep(2);
      CloseHandle (hThread);
    }
}

--=-yulHkQ/kQ/QMrqdOgxTy--

--=-+e7VoU9vR2I8ATJKpoxL
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part
Content-length: 189

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9hbPdI5+kQ8LJcoIRAilSAJ4mOaPvQx/Rank0G1IDuK8/W76EPQCgu0tI
lfHy29qOeVc1sT1GNv/wdpM=
=sGZ5
-----END PGP SIGNATURE-----

--=-+e7VoU9vR2I8ATJKpoxL--
