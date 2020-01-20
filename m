Return-Path: <cygwin-patches-return-9957-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 101086 invoked by alias); 20 Jan 2020 09:56:21 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 101075 invoked by uid 89); 20 Jan 2020 09:56:20 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-113.8 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.131) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 20 Jan 2020 09:56:10 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id 1N0nvJ-1jnMA106eD-00wo9o for <cygwin-patches@cygwin.com>; Mon, 20 Jan 2020 10:56:08 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 923EBA80734; Mon, 20 Jan 2020 10:56:07 +0100 (CET)
Date: Mon, 20 Jan 2020 09:56:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v4 0/4] Support opening a symlink with O_PATH | O_NOFOLLOW
Message-ID: <20200120095607.GD20672@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200117161037.1828-1-kbrown@cornell.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="ZoaI/ZTpAVc4A5k6"
Content-Disposition: inline
In-Reply-To: <20200117161037.1828-1-kbrown@cornell.edu>
X-SW-Source: 2020-q1/txt/msg00063.txt


--ZoaI/ZTpAVc4A5k6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1421

On Jan 17 16:10, Ken Brown wrote:
> Currently, opening a symlink with O_NOFOLLOW fails with ELOOP.
> Following Linux, the first patch in this series allows the call to
> succeed if O_PATH is also specified.
>=20
> According to the Linux man page for open(2), "the call returns a file
> descriptor referring to the symbolic link.  This file descriptor can
> be used as the dirfd argument in calls to fchownat(2), fstatat(2),
> linkat(2), and readlinkat(2) with an empty pathname to have the calls
> operate on the symbolic link."
>=20
> The second patch achieves this for readlinkat.  The third patch does
> this for fstatat and fchownat by adding support for the AT_EMPTY_PATH
> flag.  Nothing needs to be done for linkat, which already supports the
> AT_EMPTY_PATH flag.
>=20
>=20
> Ken Brown (4):
>   Cygwin: allow opening a symlink with O_PATH | O_NOFOLLOW
>   Cygwin: readlinkat: allow pathname to be empty
>   Cygwin: fstatat, fchownat: support the AT_EMPTY_PATH flag
>   Cygwin: document recent changes
>=20
>  winsup/cygwin/release/3.1.3 | 19 +++++++++--
>  winsup/cygwin/syscalls.cc   | 68 ++++++++++++++++++++++++++++++++-----
>  winsup/doc/new-features.xml | 19 +++++++++++
>  3 files changed, 94 insertions(+), 12 deletions(-)

This looks good to me.  Please push.  I just wonder if this isn't
new feature enough to bump the Cygwin version to 3.2...


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--ZoaI/ZTpAVc4A5k6
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl4leTcACgkQ9TYGna5E
T6Cy8w//ak/esGx1KQWRiW8Hq6QXZGEKi4qz08FpcEcf/ujmtPzSqiM6V14Y5RMy
Cu3MI9TFqea+0lwH/0Dta5by0XthWA118uiSy03QMG8RN4ERlGzCoMv16oYkjWMu
szY0atX1NjVNpaxpmbdxuVSAmk4VHVh+pt+K1nOsHmY3MksZmNaJM5mYh2EWbvwh
yNKzMSbEV+pbrQOvZwInCWpX4e1qOjbStSfXqxZqDzLRXgL7E6rNf0RR/XtVLsiz
pzTnPpLoKv6VCp8wucRxaX1pe78T83TiFI+vFdE8nFsFghhMMWLPKN2PL5SBdziU
Sf8P5kCwiQP+dkPOtJxz5Fn5CytJ9X4pNwrnHJ7O0QGtecb1uIYrjaRB3YBfIQCt
W9S8FtvkWHsA8w97bGsnf2hGc0plAPoS7ph0PMrm90dTQn2q60801ugGFDuEvRtK
B9deFskrPO2ObTDL8xqdPmCYrgZ0k/RZF9Qgto14ct437+PjbSzlJ/Ltihu5lCRr
ITV+IfNExMsE4+9xjfAHsscrdNB9alnpw/0QOziAWEwwkG7dhSC8KaykiO736bun
ZhstBmRaUQL/3S/aW4pQoSBRABJOA6nI5Y+1AcIV0jjtf4YhExAkuP56O2RoPlfu
3srK1+R3HK6ptZH8fgGHsgfbJcF6fRlI5oI3anGR6NnwQic9liE=
=Gh19
-----END PGP SIGNATURE-----

--ZoaI/ZTpAVc4A5k6--
