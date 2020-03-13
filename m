Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
 by sourceware.org (Postfix) with ESMTPS id 6E9D53942028
 for <cygwin-patches@cygwin.com>; Fri, 13 Mar 2020 09:58:27 +0000 (GMT)
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MElhb-1j5HNR0lxr-00GGB3 for <cygwin-patches@cygwin.com>; Fri, 13 Mar 2020
 10:58:26 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id B1F34A827DC; Fri, 13 Mar 2020 10:58:25 +0100 (CET)
Date: Fri, 13 Mar 2020 10:58:25 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Add FreeConsole to destructor of pty slave.
Message-ID: <20200313095825.GB512788@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200313030649.874-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline
In-Reply-To: <20200313030649.874-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:D68ckHmz+Xb/fvUxFjMKJxJiRsQY7JMmohqnmiSumtLsVFL8qH5
 YnRgUjI2N5fw108D2kiW0g0xpf0YuEFcpvHPSSDZt7+Gy48tx74ofTTB2nL9lTidVZWwVMg
 iNqm4phhmGzoR99yFrGW3Ffg0zl28ol3XXsVXJ4/5JhuB92HD2gy/y/KC/Ti6kRYMwx/2v0
 TMevziYA4hikAm0tB9Cpg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Hhop4sUk4Ro=:dNGM7ZORultzeF5JYRwjBf
 9OdLCOwqSvpqb1kTM1S5er5o6LGLOT9+62gE61tNo2CeuBi/CSLYTvtYm4+hJz2rHcsvTsk2O
 OEy58heAz74RJMZlWNxdmyLWL5dRm3DuYyffXIKVa6yiZ2WHk7+pHxFuPd+7m+1ws3ONK7mc7
 v+RTLOybeSgtQsTEZiNuYxWi3HWcIXMy0CSSb/S+3D5swCBVLaPvWXE6dmS8CDbfjR+1aLPAv
 Szc8Qpb7FuKxcXAdZpKgr6nJXm6svqBGwKdDDAvE1yh5+WaGKbsFDr/NUFBFG3Vsnn4wcMxi5
 m1YvIJB7auwpmfxOgFjM8GrxRDcIvvHuutNvkjUrb0l6tLuB+MSXAZbS/iNzXf17f5tmYB9SF
 nqwPhajLlrgPTY3/BUeeezNyepD0V4o0UarPA7gUiOdYcmmCoNnRiEXWpeFjteTXeakOuJ4s4
 1uixGCvZ6q3GRzxKJF/7EpXPtUSFlGArKwpSc8MQRYTxQF+TmItVapyswvaTWw0vjb1iNguJk
 DY1iQgPb04Y80dLGNfX9kkc3o5KBwrvPVl1xx/lc183rFLCFf5gYsLc7G6dnGxhOecxXk66WM
 p+UIg5fGhQXTTyrP2w7VjFUJHHV+sIqD/x/12j0Kutzyc/Qm4ABqdcBsgbyCbd+o89lOtYo7B
 1yKRD8vG/blFhJ9UVF7FvVDrcwutV3qHT41O7GExcvm9k8gMg9CX4IZcfAt+CAINnP0yOSGB8
 sDOHs3J690+s79QAhtvNHdAHYwzmm7EmMXBY3tW9Q6ZEJZFSHM6urw3aZ4JXfQ3mWUP6IKTR5
 fWaLIH6U/fVqt7gb3mYM4wrV19idjicvCnsXsyqd9Keqnp5vJZCzh69M36P9/WRbZB1/A33
X-Spam-Status: No, score=-126.9 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 GIT_PATCH_1, GIT_PATCH_2, GIT_PATCH_3, GOOD_FROM_CORINNA_CYGWIN,
 RCVD_IN_DNSWL_NONE, SPF_HELO_NONE,
 SPF_NONE autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin-patches mailing list <cygwin-patches.cygwin.com>
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <http://cygwin.com/pipermail/cygwin-patches/>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Fri, 13 Mar 2020 09:58:28 -0000


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mar 13 12:06, Takashi Yano via Cygwin-patches wrote:
> - When pseudo console is closed, all the processes attched to the
>   pseudo console are terminated. This causes the problem reported
>   in https://sourceware.org/pipermail/cygwin/2020-March/244046.html.
>   This patch fixes the issue.
> ---
>  winsup/cygwin/fhandler_tty.cc | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>=20
> diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
> index b42e0aeb6..b2e725d5d 100644
> --- a/winsup/cygwin/fhandler_tty.cc
> +++ b/winsup/cygwin/fhandler_tty.cc
> @@ -706,8 +706,15 @@ fhandler_pty_slave::fhandler_pty_slave (int unit)
>  fhandler_pty_slave::~fhandler_pty_slave ()
>  {
>    if (!get_ttyp ())
> -    /* Why comes here? Who clears _tc? */
> -    return;
> +    {
> +      /* Why comes here? Who clears _tc? */
> +      if (freeconsole_on_close)
> +	{
> +	  FreeConsole ();
> +	  pcon_attached_to =3D -1;
> +	}
> +      return;
> +    }
>    if (get_pseudo_console ())
>      {
>        int used =3D 0;
> --=20
> 2.21.0

Pushed.  However, the comment in that snippet (Why comes...) puzzles
me a bit.  Can you clarify this a bit?


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl5rWUEACgkQ9TYGna5E
T6Cazg/9EYZ7VEtM6K95eHaIdc/G5IKxhaE1HxOkvRvkaD9Wy6mT5+xJByURjTS1
YAUkqTv4aELEOgt41O39GOJG4bxiWL+ezyiprILtS0ZhcxRUiunyBK1ioNxGdwZ/
oJ0178ogqXTmJstUHV34okOnXVs2DAXwyNcBev+Jrr2eFw2k6+o20HxLpTSxfPBL
iBs2R8yioMk0KV1mCcLVy6Garu70/DGGsbGHPoRcHUUKu1NGlsCaBU3qkSfT1U+l
F8OjOBScmKaGMP7NaMHuzqfzXh+pqPfU0k/fYMli77nTNi8zzk9Ryw2IU5N/7iE4
2jYGmYP6s3EKD0NQngGEZC9BLCPIBwp8mKYa6FidGQEkwNCchk6Q1iZJzuqqXSOE
tbIrIV0Xl/Qu3S5FGb8Z9ub12acVZBk9ovQuT/q5Nn12FIJlA6NSffOe4llQc5OA
XgdBc8GFlfvuBtN7oi1UJpMDZmSlocaeNdavaQB2vdcrn2EIo7sdf/0b2SZSn1OI
oxd7yVTztQpx8GIx8KSQ/4sa5MeqTSohbHUpwCmb0Ck0pcnoz499V0+uSCrv8x8g
WgAHIrwi5F0DNBS1TevJvt7YFnxTSbHRWyUJiZ44InsSHh6vKcy8JPjNoIRO63v0
Bh3RF1aOzXwkvEmSBAjedazYyaapFy//Dg38/lNr9FnqteLRFD0=
=zEKt
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--
