Return-Path: <cygwin-patches-return-9572-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 39596 invoked by alias); 15 Aug 2019 07:58:34 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 39587 invoked by uid 89); 15 Aug 2019 07:58:34 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-106.1 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HX-Languages-Length:468, screen
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.134) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 15 Aug 2019 07:58:33 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MhULz-1iTMo409A3-00ed6R; Thu, 15 Aug 2019 09:58:27 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 1C204A807B3; Thu, 15 Aug 2019 09:58:26 +0200 (CEST)
Date: Thu, 15 Aug 2019 07:58:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/1] Cygwin: console: Fix workaround for horizontal tab position
Message-ID: <20190815075826.GH11632@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Takashi Yano <takashi.yano@nifty.ne.jp>,	cygwin-patches@cygwin.com
References: <20190815050205.6331-1-takashi.yano@nifty.ne.jp> <20190815050205.6331-2-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="D3V7sVjesNfTdM0Z"
Content-Disposition: inline
In-Reply-To: <20190815050205.6331-2-takashi.yano@nifty.ne.jp>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q3/txt/msg00092.txt.bz2


--D3V7sVjesNfTdM0Z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 401

On Aug 15 14:02, Takashi Yano wrote:
> - The workaround commit 33a21904a702191cebf0e81b4deba2dfa10a406c
>   does not work as expected if window size is changed while screen
>   is alternated. Fixed.
> ---
>  winsup/cygwin/fhandler_console.cc | 47 +++++++++++++++++++------------
>  1 file changed, 29 insertions(+), 18 deletions(-)

Pushed.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--D3V7sVjesNfTdM0Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl1VEKEACgkQ9TYGna5E
T6AAuA/+MQ+ADEHsJmRdrotIO4kZ1o24BTQnMU5mH9inNhI79PRvp/heuG1HjQAP
4xQ4vFEWwXp/oJwe9EOGpZlS/4hbfq3856O8IHHG6N7VfBX8r4x7P49bUafB30wD
sp9+4TMdRPQeZzb9BCeJeQy3IiCExSMVmLYSmBrHBGOsCSLl8DOnZiXJpiianVC8
x1GsixCcR8fLOjIwjNWtnyZgp1BTyS8FsV5Ae8CZmcMvkYgtmU8nPRWEKuF5icwj
lSsNUYbM2b65xtjIuXtzsIEEVW4aFZzPTMuX7GG0yP5GlLySGdxWl7koJK9CTow/
KkqZ3lHmIxD7CpyluUmTsEFHeWddC4bnr47kJaTxkep6jf6lCvRrWpefUhity9LV
mwdV09SW3NxC4y6EQW7iPbRmB/8dDmWiW6bsE/t7YZrFSz20PMeiwd7q8REHB/fP
FATFTBIstbTzgPtjkuuON8DrWhOcaJYr2LXYsWHyvit5WQGL8RArm4M0ev94lqfH
XU0XlXTxs9KtBICOV64C/hE0PV+rq+ftfuQTtW0mX/DaqndWWpfqYYtH/SUUqalc
Liha5ulO74pnujE/cgO4ZMwoXxGr8NUkYkMbi5Tw/axkOtP5CKHo7BqgWs5rMu7m
KpoMjNTEs+K91I8HrZA+bVE+Q+dbDYvVIKHFr00CghSEiYfg3iA=
=gw1V
-----END PGP SIGNATURE-----

--D3V7sVjesNfTdM0Z--
