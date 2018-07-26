Return-Path: <cygwin-patches-return-9154-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 70778 invoked by alias); 26 Jul 2018 10:17:12 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 70753 invoked by uid 89); 26 Jul 2018 10:17:12 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-101.4 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2 spammy=
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.135) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 26 Jul 2018 10:17:10 +0000
Received: from calimero.vinschen.de ([217.91.18.234]) by mrelayeu.kundenserver.de (mreue002 [212.227.15.167]) with ESMTPSA (Nemesis) id 0MbXro-1fSCPP2ZiW-00IkoJ for <cygwin-patches@cygwin.com>; Thu, 26 Jul 2018 12:17:07 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id E85C8A818D7; Thu, 26 Jul 2018 12:17:06 +0200 (CEST)
Date: Thu, 26 Jul 2018 10:17:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/1] Update _PC_ASYNC_IO return value
Message-ID: <20180726101706.GB6175@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20180725200643.10750-1-yselkowi@redhat.com> <20180726082000.GA6175@calimero.vinschen.de> <Pine.BSF.4.63.1807260140390.12009@m0.truegem.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="mojUlQ0s9EVzWg2t"
Content-Disposition: inline
In-Reply-To: <Pine.BSF.4.63.1807260140390.12009@m0.truegem.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SW-Source: 2018-q3/txt/msg00049.txt.bz2


--mojUlQ0s9EVzWg2t
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2394

On Jul 26 01:51, Mark Geisert wrote:
> Hi Corinna,
>=20
> On Thu, 26 Jul 2018, Corinna Vinschen wrote:
> > On Jul 25 15:06, Yaakov Selkowitz wrote:
> > > > From discussion on IRC:
> > >=20
> > > <yselkowitz> corinna, just sent a patch for _POSIX_ASYNCHRONOUS_IO as=
 a
> > > 	  follow-up to the AIO feature, but am still wondering about
> > > 	  _[POSIX|PC]_ASYNC_IO
> > > [snip]
> > > <corinna> in terms of _PC_ASYNC_IO, the test might be a bit tricky
> > > <corinna> let me check
> > > <corinna> actually, no
> > > <corinna> it's easy
> > > <corinna> Mark implemented the stuff with pread/pwrite only on disk f=
iles
> > > <corinna> but otherwise it's device independent in that he implemente=
d a
> > > 	  workaround for pipes and stuff
> > > <corinna> so, in theory we can just return 1
> > >=20
> > > I'm not sure how to test this atm, but based on the above I have made
> > > the following patch so this doesn't get lost.
> > >=20
> > > Yaakov Selkowitz (1):
> > >   Cygwin: fpathconf: update _PC_ASYNC_IO return value
> > >=20
> > >  winsup/cygwin/fhandler.cc | 1 +
> > >  1 file changed, 1 insertion(+)
> > >=20
> > > --
> > > 2.17.1
> >=20
> > Mark?  Any comment you want to make?
>=20
> Thanks for asking.  Your characterization of my implementation is correct.
> The intent is for aio_* async I/O to be supported on all descriptors.  On
> the most useful case of binary local disk files, inline pread|pwrite is
> used.  But I wanted to make sure the AIO interface would do the right thi=
ng
> on other kinds of descriptors without bothering the user about it.
>=20
> So if the intent of the _PC_ASYNC_IO flag is to say that async I/O is
> supported generally, I do think setting it to 1 is appropriate.  That is,
> if it's talking about the aio_* interfaces.  If there's an O_ASYNC defined
> for app coders, my recent contribution doesn't address that at all.

Good question.  O_ASYNC is a BSD invention, and it's not defined in
POSIX at all.  Since we're in POSIX territory, _PC_ASYNC_IO and
_POSIX_ASYNC_IO can only refer to async io as implemented by your new
aio code:

- _POSIX_ASYNCHRONOUS_IO defines if the implementation supports async io
  at all.
- _POSIX_ASYNC_IO defines if the file in question supports async io.


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--mojUlQ0s9EVzWg2t
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAltZn6IACgkQ9TYGna5E
T6DVVQ/9HA3Job4XY6zQDF/kntGIkS89+ngQPPHngk4RarW9+5Rlmhc/mS3cHff+
Gl9Av2QiUvpOn75YnBMmtnnBUYtrgMyznCGveJWTPXc3oc83gUhSgyEKoHBkXLrq
ZlF0fYLLSVjnJIMVTWXEtCqxdoHjDGQk5Rt3cVwfZa5OP31YM3VFW+JBMMbpmQAh
MJvH5xEyyqK6cnH6bBrWN/2UxEUiLbU+cdNOxjbgb4ctw0W9tWhNtt737FqPE1XL
WnY/665Fd+1+hqUxpB/Z98iCgJRynsExctJDELC3pGBSBk4UCU9hTqtvW68dCI2z
QbHaNyB/2YtpWOmCtMMWsDGQxMKh68fKevOVBi9lFQNcHtiyqFKlSiB9Fdj5Kg9A
tyM1wfvjC2xk7N4a2UisKrm7mlcFE7RfnyedFb6thyU0C0ntuPWLxyNQ1vCLr+dK
dRxOpvcQQmXf+zRGwCTPbyNPkaZAZ4xbzCNeI2QnE1GQY24ouMaztHtYFI7cLnT0
CdYHqBHE9SBD7beWVmQ1o+lPlq92XErAS4PqTK6VIBAKSdohcBYKc2IgKPuzEzHg
su0sJhes/eELPW2KwEgIGLzvsYwapw4DtTXhAvCVlQvpwAXe1p7ZBLgmvYvlg2fK
08JHJ2xNI2/U/j/9I65KiX8dHOSz6CiqEcUQQKKyDCYzo50ek5M=
=Cjt6
-----END PGP SIGNATURE-----

--mojUlQ0s9EVzWg2t--
