Return-Path: <cygwin-patches-return-10089-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 110030 invoked by alias); 20 Feb 2020 13:35:36 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 110020 invoked by uid 89); 20 Feb 2020 13:35:35 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-118.9 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*F:D*cygwin.com
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.134) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 20 Feb 2020 13:35:34 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MZkd5-1iz7Ux05tH-00Wkfd for <cygwin-patches@cygwin.com>; Thu, 20 Feb 2020 14:35:32 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 617D0A8086E; Thu, 20 Feb 2020 14:35:31 +0100 (CET)
Date: Thu, 20 Feb 2020 13:35:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Ignore 0x00 on write().
Message-ID: <20200220133531.GR4092@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200220115145.2033-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="DXIF1lRUlMsbZ3S1"
Content-Disposition: inline
In-Reply-To: <20200220115145.2033-1-takashi.yano@nifty.ne.jp>
X-SW-Source: 2020-q1/txt/msg00195.txt


--DXIF1lRUlMsbZ3S1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2150

On Feb 20 20:51, Takashi Yano wrote:
> - In xterm compatible mode, 0x00 on write() behaves incompatible
>   with real xterm. In xterm, 0x00 completely ignored. Therefore,
>   0x00 is ignored by console with this patch.
> ---
>  winsup/cygwin/fhandler_console.cc | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_c=
onsole.cc
> index 66e645aa1..705ce696e 100644
> --- a/winsup/cygwin/fhandler_console.cc
> +++ b/winsup/cygwin/fhandler_console.cc
> @@ -1794,6 +1794,16 @@ bool fhandler_console::write_console (PWCHAR buf, =
DWORD len, DWORD& done)
>  	  len -=3D 4;
>  	}
>      }
> +  /* Workaround for ^@ (0x00) handling in xterm compatible mode. */
> +  if (wincap.has_con_24bit_colors () && !con_is_legacy)
> +    {
> +      WCHAR *p =3D buf;
> +      while ((p =3D wmemchr (p, L'\0', len - (p - buf))))
> +	{
> +	  memmove (p, p+1, (len - (p+1 - buf))*sizeof (WCHAR));
> +	  len --;
> +	}
> +    }
>=20=20
>    if (con.iso_2022_G1
>  	? con.vt100_graphics_mode_G1
> --=20
> 2.21.0

Counter-proposal:

diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_con=
sole.cc
index 66e645aa1774..1b3aa0f34aa6 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -2641,8 +2641,9 @@ fhandler_console::write_normal (const unsigned char *=
src,
   memset (&ps, 0, sizeof ps);
   while (found < end
 	 && found - src < CONVERT_LIMIT
+	 && base_chars[*found] !=3D IGN
 	 && ((wincap.has_con_24bit_colors () && !con_is_legacy)
-	     || base_chars[*found] =3D=3D NOR) )
+	     || base_chars[*found] =3D=3D NOR))
     {
       switch (ret =3D f_mbtowc (_REENT, NULL, (const char *) found,
 			       end - found, &ps))
@@ -2732,7 +2733,8 @@ do_print:
 	  cursor_rel (-1, 0);
 	  break;
 	case IGN:
-	  cursor_rel (1, 0);
+	 if (!wincap.has_con_24bit_colors () || con_is_legacy)
+	    cursor_rel (1, 0);
 	  break;
 	case CR:
 	  cursor_get (&x, &y);

But, here's a question: Why do we move the cursor to the right at all?
I assume this is compatible with legacy mode, right?


Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--DXIF1lRUlMsbZ3S1
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl5OiyMACgkQ9TYGna5E
T6AAVg/+O/gb/Uw6OxjRkHBFwMVgVr4tytShOpr4hig3tPwJ4Q47pFvtzvn0txRx
2wnbkfEG0uhcDOe6xPGjIQjmX64DY6RCmmB62yXmQ6qSmGsa3W8riuDmTAGFVoIp
v6z7UqFW3ASzQi91w6qyo5IsL9KkXJ5NoWvql0TK2lXX4O71C4BB/whRX0Jl1+o6
guofH1xNMfcvEgx0YFAQte65+LlW3uSDYpKUEHP8QioOxloN24tCiXFQip/O4O3L
zsEihLE/wIdCt2uNGreIw63iNBZy/knYe/GBKS5U4LaeKvWpQM0hwNE97cSyHVhW
9iuTmsnqRka5DwtDTCG/98iJA0o+KcjB3Gps8a0XoWw+wHoq/+y7ePyb6W4vm395
QBIktnhJPtHMkOnVO4Wc9bnLPcn5UQuTWTDlrxl+izhm0pZ0D8SUpxHaBq6QVcev
UBq+Co60oafSuZFZM/Q7O+GApfdEa2KCKIwfgQhksWEthnya9u66s4xJ6b+9NZx7
oSJy3gUwuJNNWuh1gV4sS0o0kCRMsX735q9ddOko/7xDAT63MF1Vj3QXAnj/hdif
2wBGPZyEFIZeW25iwRCJ4w1KULvAYEC8vDvyFnrp/D4QWQL7ONQCeh0atHMHjFxa
VEXuwntmTT69OOkqwlvM9QgNKAYjOAFKEalZYrUZcwQe0st/KbA=
=MPCM
-----END PGP SIGNATURE-----

--DXIF1lRUlMsbZ3S1--
