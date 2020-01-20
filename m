Return-Path: <cygwin-patches-return-9964-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20776 invoked by alias); 20 Jan 2020 15:07:31 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 20767 invoked by uid 89); 20 Jan 2020 15:07:30 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-113.3 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*f:sk:ed4780c, H*MI:sk:ed4780c, H*i:sk:ed4780c
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (217.72.192.73) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 20 Jan 2020 15:07:20 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id 1N7RHv-1jgdit03f3-017onN for <cygwin-patches@cygwin.com>; Mon, 20 Jan 2020 16:07:18 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 2C66AA80706; Mon, 20 Jan 2020 16:07:17 +0100 (CET)
Date: Mon, 20 Jan 2020 15:07:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v4 0/4] Support opening a symlink with O_PATH | O_NOFOLLOW
Message-ID: <20200120150717.GI20672@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200117161037.1828-1-kbrown@cornell.edu> <20200120095607.GD20672@calimero.vinschen.de> <ed4780cb-709a-b130-4221-18974648d584@cornell.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="/2994txjAzEdQwm5"
Content-Disposition: inline
In-Reply-To: <ed4780cb-709a-b130-4221-18974648d584@cornell.edu>
X-SW-Source: 2020-q1/txt/msg00070.txt


--/2994txjAzEdQwm5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1820

On Jan 20 14:57, Ken Brown wrote:
> On 1/20/2020 4:56 AM, Corinna Vinschen wrote:
> > On Jan 17 16:10, Ken Brown wrote:
> >> Currently, opening a symlink with O_NOFOLLOW fails with ELOOP.
> >> Following Linux, the first patch in this series allows the call to
> >> succeed if O_PATH is also specified.
> >>
> >> According to the Linux man page for open(2), "the call returns a file
> >> descriptor referring to the symbolic link.  This file descriptor can
> >> be used as the dirfd argument in calls to fchownat(2), fstatat(2),
> >> linkat(2), and readlinkat(2) with an empty pathname to have the calls
> >> operate on the symbolic link."
> >>
> >> The second patch achieves this for readlinkat.  The third patch does
> >> this for fstatat and fchownat by adding support for the AT_EMPTY_PATH
> >> flag.  Nothing needs to be done for linkat, which already supports the
> >> AT_EMPTY_PATH flag.
> >>
> >>
> >> Ken Brown (4):
> >>    Cygwin: allow opening a symlink with O_PATH | O_NOFOLLOW
> >>    Cygwin: readlinkat: allow pathname to be empty
> >>    Cygwin: fstatat, fchownat: support the AT_EMPTY_PATH flag
> >>    Cygwin: document recent changes
> >>
> >>   winsup/cygwin/release/3.1.3 | 19 +++++++++--
> >>   winsup/cygwin/syscalls.cc   | 68 ++++++++++++++++++++++++++++++++---=
--
> >>   winsup/doc/new-features.xml | 19 +++++++++++
> >>   3 files changed, 94 insertions(+), 12 deletions(-)
> >=20
> > This looks good to me.  Please push.  I just wonder if this isn't
> > new feature enough to bump the Cygwin version to 3.2...
>=20
> Maybe.  You're in a better position to judge this than I am.  If you deci=
de to=20
> do it, I'll tweak the documentation accordingly.

I'm not sure yet.  Just push as is for now.  Tweaking the docs for
3.2 is trivial.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--/2994txjAzEdQwm5
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl4lwiUACgkQ9TYGna5E
T6Cctw/8CvaqZne+y5YFjcBP/hmdeMHB8+4BLWknezhBSjmvzVhYTsMPif+MML4D
/bJu5HZ0mrSrgxPZ2XI2EYcCIH6V0THfn02bN2SWQfUO2GWcoC3Uf0qM63FgsEgN
Xar3YnAETXAQGDfuPakKCjz1bbJJcsAm/P+Q3q1/E2gl5Smh/D83wje3nTIzydXw
2NeRYnZTIGHgiVYufO/rwAV8PwjJZ70rflO47R6QuX83D2zLLDLIvtZRLmIGCo0G
v2t344b6SHN4DNA67sMGmS1PYF2mOaIg0yQ2PLHMQoMUSQU1AUnpQRexrIBSazoX
3jfCne2sDx67DA/gr57jQaAK9zKo0sp6dDrejSvQm5l1jJPOitDvCIdHj+phOk0V
yFDebfuBTwN5ZlYw7s11zr3ZsM3nuTh8X+ZV91gY0uuUBtVGitoRKw2/RRXPzivB
Wr2CzJvCOcKL7jiTM9GT9r+74109I55oGh88cBk5J/8ZUmIR4qnvUiuTMkdFjGXi
Nl8bQs46U7x9bJ6qzvc0cGNk3pglbmQgg386+ijnf+MEAjRuHHsttXwC5KCuejyF
PQPb6Bl8shJepcBTRTD91tkt5ZEBz2YltX4lWz7oLKtFh41hZmADAvEpJjmxaV1H
3yjd34A60zutuDXeftLF33Al+19z4yCIsml0tTtWeZ5AevThtyY=
=EdPZ
-----END PGP SIGNATURE-----

--/2994txjAzEdQwm5--
