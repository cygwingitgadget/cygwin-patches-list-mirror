Return-Path: <cygwin-patches-return-10018-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 58942 invoked by alias); 28 Jan 2020 17:02:50 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 58924 invoked by uid 89); 28 Jan 2020 17:02:49 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-109.8 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=UD:www.cygwin.com, wwwcygwincom, www.cygwin.com, H*F:D*cygwin.com
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.131) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 28 Jan 2020 17:02:47 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MGxYh-1ik6340Oqx-00E78e for <cygwin-patches@cygwin.com>; Tue, 28 Jan 2020 18:02:45 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id C6BD0A80BC1; Tue, 28 Jan 2020 18:02:44 +0100 (CET)
Date: Tue, 28 Jan 2020 17:02:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: console: Share readahead buffer within the same process.
Message-ID: <20200128170244.GF3549@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200127121432.1681-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="mJm6k4Vb/yFcL9ZU"
Content-Disposition: inline
In-Reply-To: <20200127121432.1681-1-takashi.yano@nifty.ne.jp>
X-SW-Source: 2020-q1/txt/msg00124.txt


--mJm6k4Vb/yFcL9ZU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 825

On Jan 27 21:14, Takashi Yano wrote:
> - The cause of the problem reported in
>   https://www.cygwin.com/ml/cygwin/2020-01/msg00220.html is that the
>   chars input before dup() cannot be read from the new file descriptor.
>   This is because the readahead buffer (rabuf) in the console is newly
>   created by dup(), and does not inherit from the parent. This patch
>   fixes the issue.
> ---
>  winsup/cygwin/fhandler.cc         | 56 +++++++++++++++----------------
>  winsup/cygwin/fhandler.h          | 33 +++++++++++++-----
>  winsup/cygwin/fhandler_console.cc | 40 +++++++++++++++++++++-
>  winsup/cygwin/fhandler_termios.cc | 35 +++++++++----------
>  winsup/cygwin/fhandler_tty.cc     |  2 +-
>  5 files changed, 111 insertions(+), 55 deletions(-)

Pushed.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--mJm6k4Vb/yFcL9ZU
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl4waTQACgkQ9TYGna5E
T6BCpg/6Aq8q/eT1Ph8U4hSuVY6cvNMD8yehEqnto/2AnaBmiflQm50tTTKQDYNb
gaDuLGyy9msVw/FNtgIWjBB79jPpVIflSIOf5bv3dDKLQZv0iYTz+EgFGpmbvV4g
OHkopIoa2cWzOblurtGsYbC28SW6+iWLzH8dwjcc/Dmm3JTh8ABtaN5QvwXqeBwl
xR0lQPUS5+Bc0AhZll8AdyZQfDB2cbt7H6Jhac8p2UIQ/e1pN3pt9Owe/5J0T9Db
AluSMk9chvxGy+E5I+gGvgk2FCxat+EY2IiXflGcNAcB21RBVn49NhlbiCZUNgob
UWQ1l6QvR+Heic9AB+LMIl1oLWJJ2EF+WTfKg54+L9if77FsSCOFwld3uKc6xaui
wXZvr5VjVOk1ArFAZKgmhSDyqdhyQ0uDP3BRBrx1r7RBV/RUOK44Hh/TL7igAcLu
f7Q3u3poF4lCKG4fz4+SXiKSbfbWdft2ntMDmx8hcSAyHr/jOFRkyxA7MDVWY438
uyYSHh6cFhdX7lcPMXJNwIPnV0sFHdfhiOwUM4AL8zBs6LEZFitq2ka8ExcsZeeV
6M7FO+cCb/MfXrR7j2ooMeXMTxCyXtCDRcjjGrYqEwB1mMKTtUKKgSYRFhKlfubY
40oh3I0krtI3Ztm8KrmY1L/jSc3vudfGckwA6497tf+zV9nReAE=
=kA8x
-----END PGP SIGNATURE-----

--mJm6k4Vb/yFcL9ZU--
