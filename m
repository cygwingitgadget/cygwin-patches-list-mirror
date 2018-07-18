Return-Path: <cygwin-patches-return-9129-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 92055 invoked by alias); 18 Jul 2018 11:26:33 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 91494 invoked by uid 89); 18 Jul 2018 11:26:00 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-101.5 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2 spammy=Hx-languages-length:1703
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.135) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 18 Jul 2018 11:25:58 +0000
Received: from calimero.vinschen.de ([217.91.18.234]) by mrelayeu.kundenserver.de (mreue004 [212.227.15.167]) with ESMTPSA (Nemesis) id 0Mh8jt-1fSMRZ1N8D-00MHqz for <cygwin-patches@cygwin.com>; Wed, 18 Jul 2018 13:25:56 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id C12CBA80773; Wed, 18 Jul 2018 13:25:55 +0200 (CEST)
Date: Wed, 18 Jul 2018 11:26:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3 1/3] POSIX Asynchronous I/O support: aio files
Message-ID: <20180718112555.GH27673@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20180715082025.4920-1-mark@maxrnd.com> <20180715082025.4920-2-mark@maxrnd.com> <20180717145146.GA23667@calimero.vinschen.de> <cf3b3182-abc3-9e49-9440-0fe4fa1e137c@maxrnd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="hkxLWrKAgbGf75mf"
Content-Disposition: inline
In-Reply-To: <cf3b3182-abc3-9e49-9440-0fe4fa1e137c@maxrnd.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SW-Source: 2018-q3/txt/msg00024.txt.bz2


--hkxLWrKAgbGf75mf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1749

On Jul 17 22:55, Mark Geisert wrote:
> Corinna Vinschen wrote:
> > On Jul 15 01:20, Mark Geisert wrote:
> > > +  //XXX ... and infinite timeout?
> >=20
> > Yes, if timeout is a NULL pointer.
>=20
> My XXX concern was whether an app could get stuck here and not be abortab=
le.
> But I take your comments to mean a non-maskable signal will break out of =
the
> sigtimedwait(), so e.g. Ctrl-C, or SIGTERM from outside, could interrupt =
the
> app.

At least SIGKILL should work.

> > > +  res =3D sigtimedwait (&sigmask, &si, to);
> > > +  if (res =3D=3D -1)
> > > +    return -1; /* Return with errno set by failed sigtimedwait() */
> > > +  time1 =3D GetTickCount ();
> >=20
> > This is unsafe.  As a 32 bit function GetTickCount wraps around roughly
> > every 49 days.  Use ULONGLONG GetTickCount64() instead.
>=20
> OK, will fix.
>=20
> > > +  /* Adjust timeout to account for time just waited */
> > > +  msecs -=3D (time1 - time0);
> > > +  if (msecs < 0)
> >=20
> > This can't happen then.
>=20
> Right.
>=20
> > > +  to->tv_sec =3D msecs / 1000;
> > > +  to->tv_nsec =3D (msecs % 1000) * 1000000;
> >=20
> > Uh oh, you're changing caller values, despite timeout being const.
> > `to' shouldn't be a pointer, but a local struct timespec instead.
>=20
> I'll revisit this issue.  This internal aiosuspend() routine is called fr=
om
> both aio_suspend() and lio_listio().  Those two functions have conflicting
> protections on args passed to them and I had some trouble coming up with
> something that would compile cleanly.  As I say, I will look at this agai=
n.

Local var should work.


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--hkxLWrKAgbGf75mf
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAltPI8MACgkQ9TYGna5E
T6Ar+A/+L0Jb0Fc/RhkCQC6xUaAExHGrRLzM57ZBg0Hsi1cVtDuVTqyk8kFQ0T+G
0wQRQwA6oRj1u/IBO2nxlJ/7luem3GTPyk3CYC6RyWAc25emOZb6EWUpoLOfQC2s
VKhtzP7eHfJDxZz1lKYT1VLDNAlmv2VeIbKXxIuvM2wo0XjUUZZQihHk1wENQJgo
TPl0LzrbDwbUmUlbSdad4BeBt7yjCYIyTckMeEj1ACzwycs9VLEL685aOjKgQ7IE
r5A73LNKcgjt5nY6H8xe4GspUOAFm9bPz2RekSVlNuEIg8qqFBHkFalGPaKU7Iff
dSIqgqqcJVCeo6mkqyuwsuaN8DAOLs08p9MgmR0tKOF530iktMmX1f/NBkdaJnId
42UeRjkZ0VpoO9HcDjXoPQeJHTGBE177VD8btr6kLKsex6RIVtaX/5zb+VGbSijj
h1KlRwaemHpiQPUsrcfd8ijjk02efOY1z/CrdYLKcn58Zn5ELaK9iwBt4RRF+ppz
M0ePUy/avTdNdI5FMhVed/8fu0f2BxpOWfempBMj9fHgr8Zv/FnPNFqIiu/LiYvQ
b1NJqq6CoMA5Jw6Eynk2ovb+6T9p2QxKHhPrRWMNvsFz+y9KYkZn7jGRLG4554y1
NvOa3XlBFiK59iqZL3ybAdpF576yWmMuslAx6+/zBAJfD5Fu+yQ=
=aa5p
-----END PGP SIGNATURE-----

--hkxLWrKAgbGf75mf--
