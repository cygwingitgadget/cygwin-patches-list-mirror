Return-Path: <cygwin-patches-return-9621-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 77548 invoked by alias); 4 Sep 2019 13:55:08 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 77532 invoked by uid 89); 4 Sep 2019 13:55:08 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-103.8 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HX-Languages-Length:1213, screen
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.17.10) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 04 Sep 2019 13:55:06 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id 1Mgf4k-1ifhZj2s7Y-00h40M for <cygwin-patches@cygwin.com>; Wed, 04 Sep 2019 15:55:03 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 3287DA80659; Wed,  4 Sep 2019 15:55:03 +0200 (CEST)
Date: Wed, 04 Sep 2019 13:55:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 2/2] Cygwin: pty: Disable clear screen on new pty if TERM=dumb or emacs*.
Message-ID: <20190904135503.GS4164@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20190904014618.1372-1-takashi.yano@nifty.ne.jp> <20190904014618.1372-3-takashi.yano@nifty.ne.jp> <20190904104738.GP4164@calimero.vinschen.de> <20190904214953.50fc84221ea7508475c80859@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="Mh8CTEa8Ax54aLHp"
Content-Disposition: inline
In-Reply-To: <20190904214953.50fc84221ea7508475c80859@nifty.ne.jp>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SW-Source: 2019-q3/txt/msg00141.txt.bz2


--Mh8CTEa8Ax54aLHp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1208

On Sep  4 21:49, Takashi Yano wrote:
> On Wed, 4 Sep 2019 12:47:38 +0200
> Corinna Vinschen wrote:
> > Why do you check the TERMs again here?  After all, need_clear_screen
> > is only true if one of these terms are used.
>=20
> Because, emacs seems to set environment TERM after fixup_after_exec()
> is called. At the first check, TERM has the value of the terminal
> in which emacs is executed. The first check is just in case.

I still don't get it.

The code in fixup_after_attach() is the only code snippet setting
need_clear_screen =3D true.  And that code also requires term !=3D "dump" &&
term =3D=3D "*emacs*" to set need_clear_screen.

The code in reset_switch_to_pcon() requires that the need_clear_screen
flag is true regardless of checking TERM.  So this code depends on the
successful TERM check from fixup_after_attach anyway.

What am I missing?

While at it, in fixup_after_attach():

+             if (get_ttyp ()->num_pcon_attached_slaves =3D=3D 0 &&
+                 term && strcmp (term, "dumb") &&
+          	  term && !strstr (term, "emacs") &&
+                 !ALWAYS_USE_PCON)

You're checking term for !=3D NULL twice.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--Mh8CTEa8Ax54aLHp
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl1vwjcACgkQ9TYGna5E
T6D9OQ/6ArSCblZnlhLJGL4yuWN/46JOf7Xob6GJktjaxgHN/hbtya/R+YinYtBi
L1b6HzDVI+oQSUT+Sr2E4/efn9zwRGCT5mOyOq//9ny5Y9qP5pphXUZdjSXvDF38
qxfIJWMBGHwkTqrRPBReLjCH0J7KTueZlBxtMebsFLcXqoFiKDrduHmOGsv6JnnP
NC/BuB3K2OxteVaLOqxMXD2IlJOh3JUMCG7VRnCppuVcpIoWFBFqXFCCOQTgJ0/7
+ohplcEshNpHWAFpHUJ3sHObdLot1G6BMo2btjQL0tqbYGdOFL0pHW2dihWGuaeN
/RWn0uRehmxyNdMbl2D3pbl4/ynJgohbAox0p6Q4D2qjX8AyswkMmIl+GiJERSPG
rqJVDeLDSWZwyTvNA3wdBqoCP0S0fDFEe9SwXJQ3yRPJYgNaufw5EVDf1un32+D3
m9pFfGSLHIYGNhxiTXT0brzNWFArk0l2cdtEfARknFi9bQ6pKO2HUNMi1S4r3lT4
pMWHDv/mtehnifL/uXyaHKNC+J+ykCcrAoTMIxD3ImuxOrWwZGTav3+9DMCfVHTP
SS/C0xRNGCHGrrZGQfOUry6Ay3g9ZaaKKuQ5mq4unOlpK2h/TZphhgL1cnNgidHA
3G55MAdOdgvZgGd9xC6wWWTlLAjQGTMNDpDvzZFwFwAWW/HXNiY=
=skQf
-----END PGP SIGNATURE-----

--Mh8CTEa8Ax54aLHp--
