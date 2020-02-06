Return-Path: <cygwin-patches-return-10043-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 83392 invoked by alias); 6 Feb 2020 19:03:35 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 83213 invoked by uid 89); 6 Feb 2020 19:03:35 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-107.3 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.17.24) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 06 Feb 2020 19:03:34 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MN4qp-1jGUNC1j2T-00J48B for <cygwin-patches@cygwin.com>; Thu, 06 Feb 2020 20:03:31 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id CBD89A806E3; Thu,  6 Feb 2020 20:03:30 +0100 (CET)
Date: Thu, 06 Feb 2020 19:03:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Use pinfo() rather than kill() with signal 0.
Message-ID: <20200206190330.GT3403@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200206104817.1116-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="fU0UwhtRbpo05rnG"
Content-Disposition: inline
In-Reply-To: <20200206104817.1116-1-takashi.yano@nifty.ne.jp>
X-SW-Source: 2020-q1/txt/msg00149.txt


--fU0UwhtRbpo05rnG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 526

On Feb  6 19:48, Takashi Yano wrote:
> - PTY code has a problem that tcsh is terminated if the following
>   command is executed.
>     true; chcp &
>   This seems to be caused by invalid pointer access which occurs
>   when the process exits during the kill() code is execuetd. This
>   patch avoids the issue by not using kill().

Pushed.

I'm inclined to release 3.1.3 next week.  Is that ok with you or
do you anticipate more patches which should go into 3.1.3?


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--fU0UwhtRbpo05rnG
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl48YwIACgkQ9TYGna5E
T6AZBA//fBcS0ZP7pDfd/uIRTjd0ctf8gPl0jLuiQCddBGcue/A2QIAIUSazE2Lo
08oDKYIwP/Rt8VqISrKbRSIUHRNIIajC7aZjfD0xYKQumLFn8tfypEqa+frhXj4z
KxrbG/ORXStxM9YHT+ZOdjK95hgthItk+bbcgfYSSBC/FfA4o4l9kAcTs/XGPJNh
bTHNRJ5n4vlz08HSY9nJMPaHDxJW+TthbiCK5JUHfEdNs8on5vl1R+vIDoHjImaJ
sSu71SZCeDnnkjEM8ZGwR3mchOAMg796TIdAfXaAtc9GyqtEWmqQbncJ2w2Iuz5/
upOD9KUesWkyL3z9uagHEx3SYmvF6JsgbSWPAG6hLPNquI8pzYCJueLy4fPMnWmy
ydct2NLZdYXi0Ajv5+JBLo+gX6q2yMswcdDeZnHleAbnsGOimLPK+ednsSyIKfxX
u5YolXrle+W1xCOSHJXHPD8lM76lJoW4hZOz5aGp69wNivjGnR+ykcysoE0eC4As
GGhZu3bKMhP3iE16xhHIpleTfgWY9jPDXzobt7kiWxD0+2FAK1Pr37JK8xyFHwlh
khwc4CXfH3liJvGeF/p+DbF0r9vPOS6eQeDE0Vm/0vlz+nogm7hk8p1/THUQ7ara
+5kPrkCSNTRoib0D8VBIOeIxIBVsqvHvca5i2uD7t4934BpHCMk=
=Pq/i
-----END PGP SIGNATURE-----

--fU0UwhtRbpo05rnG--
