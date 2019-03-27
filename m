Return-Path: <cygwin-patches-return-9245-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14475 invoked by alias); 27 Mar 2019 16:14:05 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 14465 invoked by uid 89); 27 Mar 2019 16:14:04 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-104.3 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=water, van, UD:H, Water
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (217.72.192.74) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 27 Mar 2019 16:14:03 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MBltK-1hGrES3dAy-00C6F9 for <cygwin-patches@cygwin.com>; Wed, 27 Mar 2019 17:14:00 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 44325A8054D; Wed, 27 Mar 2019 17:14:00 +0100 (CET)
Date: Wed, 27 Mar 2019 16:14:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/1] Cygwin: fix: seteuid32() must return EPERM if privileges are not held.
Message-ID: <20190327161400.GI4096@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1553702463-1680-1-git-send-email-houder@xs4all.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="Bqc0IY4JZZt50bUr"
Content-Disposition: inline
In-Reply-To: <1553702463-1680-1-git-send-email-houder@xs4all.nl>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q1/txt/msg00055.txt.bz2


--Bqc0IY4JZZt50bUr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1470

On Mar 27 17:01, J.H. van de Water wrote:
> Starting w/ the intro of S4U, seteuid32() calls lsaprivkeyauth(), then
> s4uauth(). s4uauth calls LsaRegisterLogonProcess().
> LsaRegisterLogonProcess fails w/ STATUS_PORT_CONNECTION_REFUSED, if the
> proper privileges are not held.
> Because of RtlNtStatusToDosError(), this status would be mapped to
> ERROR_ACCESS_DENIED, which in turn would map to EACCES. Therefore it is
> useless to add this status to errmap[] (errno.cc), as s4auauth() should
> return EPERM as errno here (i.e. if process is not privileged).
>=20
> Hence the kludge.
>=20
> Before the intro of S4U, seteuid32() called lsaprivkeyauth(), then
> lsaauth(), then create_token(). Before the intro of Vista, the latter
> would have called NtCreateToken().
> NtCreateToken() would have failed w/ STATUS_PRIVILEGE_NOT_HELD for a
> process w/o the proper privileges. In that case, calling seteuid32()
> would have returned EPERM (as required).
>=20
> Since the intro of Vista, and if the process had been started from an
> UNelevated shell, create_token() does NOT reach NtCreateToken()!
> As create_token() failed to properly set errno in that case, calling
> seteuid32() would return errno as set by lsaauth(), i.e. EACCES, not
> in agreement w/ Posix (a bug which was present for years).
> (lsaauth() called LsaRegisterLogonProcess() which would fail)
> ---

Pushed with a minor style tweak.


Thanks a lot,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--Bqc0IY4JZZt50bUr
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlyboUgACgkQ9TYGna5E
T6Db0A//X7ZGbH2/JeZGu9Q5Ov2+kJDbYXF7TZQjxXMKhzsx6L5ZmdDX+82nfvQV
/JA5eby9GQBYBd53Ck/c6icy4BNaqMlIPChHRzyXTogx7i91bMPXvl07H3rGfAQl
qrP9DF1iqOQWpsjBwCMjlWf/nkOhki8Ukcbec8GE7M9CiwilIeGCWH3/A0DsukEO
d4zFS3IhlwPBSXx/CwJPamm/DDnqYOojWg0Dx/4OMY3Ydw+ogCXo5eU7WQYs0Kpo
7YOtMXSxtI3l2UXS51MZWrz7rIxDasveCSae/UmL8FmsAgJIksDxyd47ev0giWUX
c1kUbTwaEhTD8zuUVCE1032UQ9RqPHqZdsFOXY6EUy4+LxRVc8XaFcWbsGO1N3IP
mpzrsYe+3B65c1GIgRn/7Sif0F5TgSRr9wwwcDIDi4R2Ec8/UEBkjku4wavAIHMu
ADIme+uJPjeSmaHsjHlvqVI02a7a/PGbBaceDQNh64GTYxJp1Vathg803ULn7aOR
ktQVV/xxEYpuR/GNh49xPntZ+JLbTxKOZ7NP1INVT3zC00d0XPyIqvaQSCpW1VA+
nGqbcsDYwnhPCLeBqbKcMcVi87tNmP/ju4CMhWOXsgjZqSeayu4K2SqBiFEoEsDb
xAuHjKzIihxmutC1WWvhIR3+hSBbxXGUuk56h1VA2JeHqIqy5tk=
=JWn4
-----END PGP SIGNATURE-----

--Bqc0IY4JZZt50bUr--
