Return-Path: <cygwin-patches-return-10140-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25283 invoked by alias); 28 Feb 2020 14:16:43 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 25242 invoked by uid 89); 28 Feb 2020 14:16:42 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-106.4 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.135) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 28 Feb 2020 14:16:41 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MCKO2-1jH07B00sE-009TTc for <cygwin-patches@cygwin.com>; Fri, 28 Feb 2020 15:16:39 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 6F9B7A819D3; Fri, 28 Feb 2020 15:16:38 +0100 (CET)
Date: Fri, 28 Feb 2020 14:16:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: remove %esp from asm clobber list
Message-ID: <20200228141638.GH4045@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200228120413.1560-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="H88uUF932U8Oj0a6"
Content-Disposition: inline
In-Reply-To: <20200228120413.1560-1-jon.turney@dronecode.org.uk>
X-SW-Source: 2020-q1/txt/msg00246.txt


--H88uUF932U8Oj0a6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1302

On Feb 28 12:04, Jon Turney wrote:
> Mentioning the stack pointer in the clobber list is now a gcc warning.
>=20
> We never wanted gcc to try to restore %esp after this (x86-specific)
> asm, since the whole point of the inline asm here is to adjust %esp to
> satisfy alignment, so remove %esp from the asm clobber list.
>=20
> Of more concern is the alleged requirement that %esp must be unchanged
> over an asm statement (which makes what this code is trying to do
> impossible to write as a C function), although on x86 we are probably ok
> in this particular instance.
>=20
> ../../../../winsup/cygwin/init.cc: In function 'void threadfunc_fe(void*)=
':
> ../../../../winsup/cygwin/init.cc:33:46: error: listing the stack pointer=
 register '%esp' in a clobber list is deprecated [-Werror=3Ddeprecated]
> ../../../../winsup/cygwin/init.cc:33:46: note: the value of the stack poi=
nter after an 'asm' statement must be the same as it was before the stateme=
nt
>=20
> Also, because we now using gcc's "basic" rather than "extended" asm
> syntax we don't need to escape the '%' in '%esp' as '%%esp'.
> ---

As discussed on IRC, let's try to fix that using the gcc funtion
attribute force_align_arg_pointer, as Mingw-w64 already did in 2018.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--H88uUF932U8Oj0a6
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl5ZIMYACgkQ9TYGna5E
T6AXPRAAlQrEzqyIzJumpR/s1K49EeWtw1RATRhp1iJo9TEtPKpBKac0DnqHd8Y1
2cqg4aGH/ORLtvfJguCrwiuebmtbKTn37Ghp6XIAJsckucVLberbpC3uIULyg03R
hJU/9kNLxFn3TKk846dXe9I3+e8ytKJ0hHLjU3YLKjI4+T1c99MthepE/3xI9a5j
zIC1johq9I3IjS7Y2K+47IDiia8Fo1hqQP9fKT7IXXYxH0zHZ3vTs3I4rrjf8lqx
nr7Xs1btF1dk8943CmtoZCel1h7VH+pBwCSqc0cIe3InTMdNPHTAknej2rn0J4FX
NbEPQwcqiujvRxk1jnv1FctV5vLbl7aIZurPwuNtiZE0YXjBFjs/nFu2XFM+O2EW
D/mEL98DbvO0RNKHJ8bquRd+WWrN3ZSKRbksaCrUjHbF3/0zY1aq4VerSfgUWlfN
Tnbyb9PCVJKZDyTRwzaT9ttXazuafkIltsU0b5ZxCfDdxLme7SmTX2QLJO4YZ0r5
1hJphQ+m3oZbbwceDvW9S8v0fSraMEQNGB0u58VUnZMip6mORRS38g0MwTvNdEfT
OP0a188quuRF/RJgKIn+udbdu5QBfPAKavjP4PN1qNOsUvKxaD+axzjnWMwjFomT
95h6CV6728rLm0ejYzAGjspWElxhfN8PbIs+R2Vl5IMj9yySOkQ=
=EPbQ
-----END PGP SIGNATURE-----

--H88uUF932U8Oj0a6--
