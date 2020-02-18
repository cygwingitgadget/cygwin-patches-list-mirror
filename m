Return-Path: <cygwin-patches-return-10085-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 89914 invoked by alias); 18 Feb 2020 10:43:40 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 89905 invoked by uid 89); 18 Feb 2020 10:43:40 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-109.2 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=yesterday
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.130) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 18 Feb 2020 10:43:39 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id 1N2Unv-1jSMGl2ech-013rNq for <cygwin-patches@cygwin.com>; Tue, 18 Feb 2020 11:43:36 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 40021A805B9; Tue, 18 Feb 2020 11:43:36 +0100 (CET)
Date: Tue, 18 Feb 2020 10:43:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: console: Add guard for set/unset xterm compatible mode.
Message-ID: <20200218104336.GI4092@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200218091254.415-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="CNfT9TXqV7nd4cfk"
Content-Disposition: inline
In-Reply-To: <20200218091254.415-1-takashi.yano@nifty.ne.jp>
X-SW-Source: 2020-q1/txt/msg00191.txt


--CNfT9TXqV7nd4cfk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 695

On Feb 18 18:12, Takashi Yano wrote:
> - Setting / unsetting xterm compatible mode may cause race issue
>   between multiple processes. This patch adds guard for that.
> ---
>  winsup/cygwin/fhandler.h          |   6 ++
>  winsup/cygwin/fhandler_console.cc | 125 +++++++++++++++++++++---------
>  winsup/cygwin/select.cc           |  22 ++----
>  winsup/cygwin/spawn.cc            |   8 +-
>  4 files changed, 103 insertions(+), 58 deletions(-)

The patch looks good to me, but I'm curious...

Yesterday you wrote that interlocked counting is not a good
solution due to the 'bash -> cmd -> bash' scenario.  What has
changed your mind?


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--CNfT9TXqV7nd4cfk
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl5Lv9gACgkQ9TYGna5E
T6D82w/+IxNMaZAjIV2eW8PLgtS134fekss4bvTFwUTW8NFMY+GcZ2qyy/5YCzs6
r7c6Oj/YYYnQPNdujnvhLe/oQJUQpXJzWyA++77D26MAYBSowiHfofKZJHcyZjOQ
vt/oP5DkE7Ir6AwO1OFGiY/H+SAmByp4XEsvoMOSHiUtp8jkYKE01yRb/n5J/kBt
W/s20jRnELlzTk1yC6wqFWlDOljDJzsyUn250WLmmn9tTGopqN4rVdrGiUtBCQh2
glPFnC4pYAZpA6lR+NhkvEGO8vNQxRZS5T37wYgfvGdt8G37fkuyWMlN2qM/eNzH
2Ovd88MIukSM1jvQ3jKvmB8mlFnwzyfdRo1/FH9Grp8/6FOm25OBzDQ6IDccGXdL
ZQFrvdXfs7sU7B/EiRVAkGOsurs1OKWfKf14vWQTSM2T8iYPjuyATurPA3zNWR4h
qJXC5speYLBWEbw/F8k8fpkKkg9+vknSo409vZRM5QpGNvUxUNy4iHhjj489fmkP
PKWxVZOSQ3VPbhk3cY7SOEo6VhYu8lsItT9r2RwhwbVEF4XJtXcgETlABsLGyeBl
nvQ1U7SK6vWpw4ANRblHIxhdYu++3zGT+ClK8PMrd7A1yV2p1mVT0CQxCEXMEv/O
eoFhub/O1qb38nLptnEQqusejOKjQhhC59Q1/v7Ln/Q014bZS8Y=
=oM+4
-----END PGP SIGNATURE-----

--CNfT9TXqV7nd4cfk--
