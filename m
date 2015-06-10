Return-Path: <cygwin-patches-return-8148-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 60645 invoked by alias); 10 Jun 2015 15:44:07 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 60625 invoked by uid 89); 10 Jun 2015 15:44:04 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.4 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 10 Jun 2015 15:44:02 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 11EB0A8093B; Wed, 10 Jun 2015 17:44:00 +0200 (CEST)
Date: Wed, 10 Jun 2015 15:44:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Improve strace to log most Windows debug events
Message-ID: <20150610154400.GI31537@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1433937922-16492-1-git-send-email-jon.turney@dronecode.org.uk> <20150610141120.GG31537@calimero.vinschen.de> <20150610141827.GH31537@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="XIiC+We3v3zHqZ6Z"
Content-Disposition: inline
In-Reply-To: <20150610141827.GH31537@calimero.vinschen.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q2/txt/msg00049.txt.bz2


--XIiC+We3v3zHqZ6Z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1515

On Jun 10 16:18, Corinna Vinschen wrote:
> On Jun 10 16:11, Corinna Vinschen wrote:
> > Hi Jon,
> >=20
> > On Jun 10 13:05, Jon TURNEY wrote:
> > > Not sure if this is wanted, but on a couple of occasions recently I h=
ave been
> > > presented with strace output which contains an exception at an addres=
s in an
> > > unknown module (i.e. not in the cygwin DLL or the main executable), s=
o here is a
> > > patch which adds some more information, including DLL load addresses,=
 to help
> > > interpret such straces.
> >=20
> > That's a nice addition.  Two points, though:
> >=20
> > - Do we *always* want that output or do we want a way to switch it on
> >   and off?  If the latter, we can simply add another _STRACE_foo option
> >   for it.=20=20
> >=20
> > - The GetFileNameFromHandle function could be much simpler.  Rather than
> >   opening a mapping object for ev.u.LoadDll.hFile, just use the existing
> >   mapping object from ev.u.LoadDll.lpBaseOfDll.
>=20
>     ...with the process handle taken from get_child(ev.dwProcessId).

And since I'm generally fuzzy and unclear in my first reply:

Of course, ev.u.LoadDll.lpBaseOfDll is not the mapping *object*, but the
mapping *address*.  So you neither have to call CreateFileMapping nor
MapViewOfFile.  Just call GetMappedFileNameW (get_child (ev.dwProcessId),
ev.u.LoadDll.lpBaseOfDll, ...)


Sorry,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--XIiC+We3v3zHqZ6Z
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVeFtAAAoJEPU2Bp2uRE+gYQQP/Ry3PIrzvJlWBS6oUS6dZEaW
FfhZ8VaRJbmSBgVJw8J/Au3qOWcfpqBhtanT6hpU/5xUdFAKrQBaBsRqgcJ5kAqY
3UtIQ95jBFypgKvNiRCspwKM0BVp1JGXsFE5BmAz08olzUBdeXlTTkKw6Az3avxp
AyUYuAZdFK3k+8+ETpZOj9ryfggI2dzER+YBZvLxYnSspFIBT5KCqkgDgngmAqoB
qWFk1H02Z6wzhBTECt5tM20w7ba9WEwcLMLstMgapHiMQnvZY2NZtRKMN6I1a9wG
PxIEin5z53yi39IzWutLs4u+mK6LOypQCOjeojwlFO+8CZ+Tk38WpDhsZXqLiNiw
Uu96f00Os6gUEo9iP5WA+76+KVQ6EZS3y6qz2g4itIb7y6WggWZIJ1itOue9cc2J
QkpkwjRsS0/fIapIyQ5U45m0B/835zOP4au5mrWyF0jcalict65RaFz3A5QDMzoo
Ka/g0+495V3cZnXenLccw3SGhJ7pXbMpaC/e1KMdTlFlAgJcP0fWkxDg58mxW/3l
X2s6V5BaZpqXWqVhKh62E4VTYbdbSVjFiRowgli7FWW1Hwg31hTEPe2EIXzoMkcV
GVz+GhVgPzUeVj/o6k8WijV5Eprbc4RTPoZhCUIddde1u/kkTepKxydrx+kRwcU1
ts6k9GrMiRdqe63NaScS
=RDp1
-----END PGP SIGNATURE-----

--XIiC+We3v3zHqZ6Z--
