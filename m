Return-Path: <cygwin-patches-return-9917-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 109464 invoked by alias); 13 Jan 2020 16:25:57 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 109451 invoked by uid 89); 13 Jan 2020 16:25:57 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-111.9 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HX-Languages-Length:738
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.187) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 13 Jan 2020 16:25:56 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MrPyJ-1jUFJG2gL9-00oWi4 for <cygwin-patches@cygwin.com>; Mon, 13 Jan 2020 17:25:53 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 0AA73A80384; Mon, 13 Jan 2020 17:25:53 +0100 (CET)
Date: Mon, 13 Jan 2020 16:25:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Add code to restore console mode on close.
Message-ID: <20200113162553.GO5858@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200102131716.1179-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="73fGQZLCrFzENemP"
Content-Disposition: inline
In-Reply-To: <20200102131716.1179-1-takashi.yano@nifty.ne.jp>
X-SW-Source: 2020-q1/txt/msg00023.txt


--73fGQZLCrFzENemP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 681

Hi Takashi,

On Jan  2 22:17, Takashi Yano wrote:
> - The console with 24bit color support has a problem that console
>   mode is changed if cygwin process is executed in cmd.exe which
>   started in cygwin shell. For example, cursor keys become not
>   working if bash -> cmd -> true are executed in this order.
>   This patch fixes the issue.

Is that supposed to work for deeper call trees as well?

I'm asking because I tried something like

  bash -> cmd -> bash -> cmd=20

and it turned out that the cursor keys don't work at all in the second
cmd, while they work fine again in the first cmd when returning to it.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--73fGQZLCrFzENemP
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl4cmhAACgkQ9TYGna5E
T6DBCQ//Uaz9e3E8iJQoFBKEktfevo/OtR7GVDhzgOSA7IOBY/2uX4KhsKqeHKS9
yYI+yqt953ScLPVJCFgLpZFiKiRgPmWsFvEv0UAX9Hl2NvyaxeK0aOt825HdBYoa
p/ef0Z0uSXWrYMVY0qaw/tuRzpup7XEkcRdz9ChavTKTEYlgvulwF9bXFizQHnOv
nGubSfWpm/BOrceRLobHRjGXu4u6D3W9ZZlm40DyomNKVKf0JTN1LRhjG1ksXCB1
HxgIh16tVAFfbvjRLM9ZgZZfW/Mc0r1m2PtQqZMK39brCbq8hX4m1udbHcGLLJwh
/R8fOrsuoVVEJiy8+wDnyRs7GGc1uQhfc9LvZ1gqRln21sC5U3Bk5l9w70um6oPg
4mdKFZ46WG2FFPVRpephexTwiwdtjCoy7F4Mm36JwR5MYhAa4m99xjXNgXvEsMf5
6rPSwPhhUHkRhUd4+YKcXyBbfHJ9R/MITrKeOv4ZGi24XtpcIa1tUaV2zUSEN2yh
1i5qWbgoIyRqBfsg0+/AWTqkTmMyHnO/wkeDeatVf864T6+/fBY+a2lKyMg9Gujr
RANfAJ7NQHUAeGDZzoMXpRjDB27PC2juQH3xAWCMyMawLphmQNQmnsk+HB8v0N9O
nCw7JFgA7zGsNjPzfkHKcy7i34Kpa45vp1n5z4DTfMDu55QyiNw=
=RsvE
-----END PGP SIGNATURE-----

--73fGQZLCrFzENemP--
