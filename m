Return-Path: <cygwin-patches-return-9855-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 78787 invoked by alias); 18 Nov 2019 10:13:07 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 78777 invoked by uid 89); 18 Nov 2019 10:13:06 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-105.6 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_JMF_BL,RCVD_IN_SBL autolearn=ham version=3.3.1 spammy=
X-HELO: mout-xforward.kundenserver.de
Received: from mout-xforward.kundenserver.de (HELO mout-xforward.kundenserver.de) (82.165.159.44) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 18 Nov 2019 10:13:05 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id 1N7RDn-1hnrUp00b7-017qKd for <cygwin-patches@cygwin.com>; Mon, 18 Nov 2019 11:13:02 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 93859A806BF; Mon, 18 Nov 2019 11:13:01 +0100 (CET)
Date: Mon, 18 Nov 2019 10:13:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Convert CamelCase names to snake_case names.
Message-ID: <20191118101301.GC3372@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20191115232724.1270-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="IdGNrZu1oYcejyEu"
Content-Disposition: inline
In-Reply-To: <20191115232724.1270-1-takashi.yano@nifty.ne.jp>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SW-Source: 2019-q4/txt/msg00126.txt.bz2


--IdGNrZu1oYcejyEu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 568

On Nov 16 08:27, Takashi Yano wrote:
> ---
>  winsup/cygwin/dtable.cc           |  6 +--
>  winsup/cygwin/fhandler.h          |  8 ++--
>  winsup/cygwin/fhandler_console.cc |  2 +-
>  winsup/cygwin/fhandler_tty.cc     | 68 +++++++++++++++----------------
>  winsup/cygwin/fork.cc             |  8 ++--
>  winsup/cygwin/spawn.cc            | 18 ++++----
>  winsup/cygwin/tty.cc              |  2 +-
>  winsup/cygwin/tty.h               |  8 ++--
>  8 files changed, 60 insertions(+), 60 deletions(-)

Pushed.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--IdGNrZu1oYcejyEu
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl3Sbq0ACgkQ9TYGna5E
T6CFuhAAn1HUEyGg6nfkrTGZxwsV5r5B8M2hp/wK6TTyuF0v9dmC1K9RB8S/sfFi
dcvmEfKnFUXS82MP9T3QaZi5o4062fCLMjYZVSl5/Eqc/FSwM+0LkztalK19pFhr
eGZOXIDJMJw7/QzpGDTfnY7kBCQHDLym8CMyvL6zjm3HwdtCyL3MPZWIHwzqvRjk
xS448MOLdBV07k5RXNHw18ffbAavi40CyyBKalF6xBH3nTT2FddD1RfWtYuhqovB
RfU1Fe+Kdz4jsCvr1UPfqJ+Yc1uYuSi0ZkTUwkwzBTT/NZmaPwjxZk1MXznMPFwl
1ubwjpYnwD1dFXiHzJZqNX7vPbcNxsbGJKSJnqXvdLpGsmWYgAZEDoW//bnEelQ/
yjmdmtdoXoIjoUZQGmUrbsLuSUVog3WRUUP7olYzv/UH8AgJ1Fs3rncdT+BqvDxK
neQ52eRRTLis5EnHqalDogMs579cvkvbndfjWIi+zEDG1ZuLNW2QWFuDP4y5OfFL
9yuUnEmcjQWiAbsef4P0kz6gaxzrKTuB2fkigMizi29Z71hnKKQDE8kI408bvXch
6csARESfQcul6lt/vhBRQVrOfTQgpgkqAwQxStzrhrDHCDd7ZhcZumgp2Tff+gra
0UXd/fj3VG0njXGep3nLNT754t2DSFAmiu/2v7aSteyvZac9cqo=
=c54E
-----END PGP SIGNATURE-----

--IdGNrZu1oYcejyEu--
