Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
 by server2.sourceware.org (Postfix) with ESMTPS id D72A33940CE1
 for <cygwin-patches@cygwin.com>; Mon,  9 Mar 2020 08:59:28 +0000 (GMT)
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M8QiW-1jFe6p2cV6-004RDy for <cygwin-patches@cygwin.com>; Mon, 09 Mar 2020
 09:59:27 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 60B1AA827DA; Mon,  9 Mar 2020 09:59:27 +0100 (CET)
Date: Mon, 9 Mar 2020 09:59:27 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: console: Fix behaviour of "ESC 8" after reset.
Message-ID: <20200309085927.GC4042@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200309013836.1999-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ftEhullJWpWg/VHq"
Content-Disposition: inline
In-Reply-To: <20200309013836.1999-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:9FDt6XT+pJCDR3KY6oh/MGmW68IZd1O9UVZRsgUw72rplsJ90fr
 2MHPT6qJZCmyTVgPeGbQ4e+aow1FA3YrNLJ39gqhsoELZrOVyGwswvzBbkghktR4FDiQdit
 DGFP+FgEy3DqCCWyjwM3T6ViBwcHychM1tiX1x9Xw9lWmqWchrODwNiyke/SpxPCs39vdpW
 Un15oPMH0NUgCREC4pIeg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:W7mu8ZuXIzA=:b83dyaq1EaKlA2tIjMBSur
 Nw9/SVj1WENMaDGQFMWGRHelzSSyI3xk7XnSR9IA2KMV1RvnTFb/PqdlGflwrcCyyN+VoISiQ
 Y1oYA2bHR9xw3cPiKPompTMlrZB9xvq4Vr8KGfsU57m7Z33M7Ffw8R/afN/mPshziA5UrjVv6
 7F9NdvxGSjYEdYmZ6ANfKU5cx6X0zjpPrsYwB0h3dTwes5M/Z/pNWxdKe9J2Dta9ScY1cq22n
 cKDnwHO0Q27E38YTChZ48xIppfOagFXcci8eladkJ59p7YDnAvnetMw9vLvaF9/mAQ2wSG/7i
 H3rdVl+sSZaQUNGbAZW7ksEGBqhEY58EP4HyaaiQrcxsecqsYyu9pJEB0qhW/DcTe72AFq3zK
 UtEEhtPntCTQqiMP41AZOKYJv7S06RXYUSbIaikrbKdjgtJXrDbs4VrJkI8idgR9smiKMYajL
 k9D9O1zO+WcJTQX7r7VUnmKfkkX9PtJAn1K4T5PCGGYqcG97JK6Z4RBjWzuOP4L7Of8Esp0xv
 RHBFcngOHMBa6gPTBsdsS+HW4xOmN7CIeQs9v9MjZUAQdScOpfXa2QqzZ+d2sa4dLZr0Ekl5w
 /zwMrC/zuTIfuEeg/iu2aSwhStlqhRm73I9yMFWs1fUobuW0+sezghH84fGDdGQr0UG/fS41U
 l4ggf3Hg+kwRDtlcQRk3oV8umZSXZhCkCkj1Vf7ph/NJGQS+iT/6NSgt6Iy4/K8NJ9K8C31/D
 SDJaduq9atYRNEgbEoe18bc98jBZVsfVO8quL7+bCaGOhWmKnqpB/UtyUL4iMTizcZzChVpEV
 VziFXTomSqGaYaylo5ZbF1VlEeHTVXotylOfPlXz1DK26TIbjKxhEa/n5gKnan88nxYyn0W
X-Spam-Status: No, score=-124.9 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 GIT_PATCH_1, GIT_PATCH_2, GIT_PATCH_3, GOOD_FROM_CORINNA_CYGWIN,
 PDS_OTHER_BAD_TLD, RCVD_IN_DNSWL_NONE, SPF_HELO_NONE,
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
X-List-Received-Date: Mon, 09 Mar 2020 08:59:29 -0000


--ftEhullJWpWg/VHq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mar  9 10:38, Takashi Yano wrote:
> - This patch matches the behaviour of "ESC 8" (DECRC) to the real
>   xterm after full reset (RIS), soft reset (DECSTR) and "CSI 3 J".
> ---
>  winsup/cygwin/fhandler_console.cc | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_c=
onsole.cc
> index 1c376291f..2a239b866 100644
> --- a/winsup/cygwin/fhandler_console.cc
> +++ b/winsup/cygwin/fhandler_console.cc
> @@ -2124,6 +2124,11 @@ fhandler_console::char_command (char c)
>  	  break;
>  	case 'J': /* ED */
>  	  wpbuf.put (c);
> +	  if (con.args[0] =3D=3D 3 && con.savey >=3D 0)
> +	    {
> +	      con.fillin (get_output_handle ());
> +	      con.savey -=3D con.b.srWindow.Top;
> +	    }
>  	  if (con.args[0] =3D=3D 3 && wincap.has_con_broken_csi3j ())
>  	    { /* Workaround for broken CSI3J in Win10 1809 */
>  	      CONSOLE_SCREEN_BUFFER_INFO sbi;
> @@ -2168,6 +2173,7 @@ fhandler_console::char_command (char c)
>  	    {
>  	      con.scroll_region.Top =3D 0;
>  	      con.scroll_region.Bottom =3D -1;
> +	      con.savex =3D con.savey =3D -1;
>  	    }
>  	  wpbuf.put (c);
>  	  /* Just send the sequence */
> @@ -3070,6 +3076,7 @@ fhandler_console::write (const void *vsrc, size_t l=
en)
>  		{
>  		  con.scroll_region.Top =3D 0;
>  		  con.scroll_region.Bottom =3D -1;
> +		  con.savex =3D con.savey =3D -1;
>  		}
>  	      /* ESC sequences below (e.g. OSC, etc) are left to xterm
>  		 emulation in xterm compatible mode, therefore, are not
> --=20
> 2.21.0

Pushed.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--ftEhullJWpWg/VHq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl5mBW8ACgkQ9TYGna5E
T6B0Ew/8Dve4ZhlKp0CHmwWnPLqmm9PeeJQPy4oVgCCcrp/zznTuarSAn4wpxuh/
OA8+W7FmDEDk5OeEjuMHjwKl4H9qnRToY33EzEaJJeagQvbz93cvoU3lfgoZa/vA
HbfYYbEh6prXaBAGhEzgXR2FcaRrj4hgj18qsWOFSU4VJgKQR4hmRtK+L0LaEOw3
yTubWJixZepA1D1XOQhfbiYVjoMhMGj2md8bEv7ek/UmWmqVLkt2bQwXdGU1EdEj
pgz3olBm9SF0OQdqdDAWFrVTdC1qmpsaIxguPXPztDKHZBh79iHwhicfy7czMaWI
O/anDl8X0EFuZPuEhSGofBG+EiO6AvJtdpKKZdtOrdxuSZ27mv0iE/GwpZt32ic9
BMVKKnGbqBEZT4r8NuuJzK18mf6NQF40Xeqfiq07qbirfAECRj69lb2QXbbtYj0T
DpXFzTrZcSFUG0ziN+qB9o6jzVgBm97o9Fx4UdgeTT/ccE7MongQuJymQYxjbvwu
1yrI/bFpWccQ+6OVAYvY8E5BiTwUqupHZRpC8v46CX6lWSRzeXkbErGIbhh5twGI
lYXuSqpXxzPxSNhGxtkt7LxFnDP4Qc+eWRs9ML9PoB9mZZM0g/VRwDvCTCLJ1EfF
hV2KXo5PCf+ohkZ9mSxVu7Cq287mnByozJKjvHJo1wHH4N9f1kc=
=3j4s
-----END PGP SIGNATURE-----

--ftEhullJWpWg/VHq--
