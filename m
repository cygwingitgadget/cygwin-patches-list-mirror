Return-Path: <cygwin-patches-return-10169-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14179 invoked by alias); 3 Mar 2020 11:14:07 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 14143 invoked by uid 89); 3 Mar 2020 11:14:06 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-118.6 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.187) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 03 Mar 2020 11:14:05 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id 1M28O9-1j79YR1YZF-002W4I for <cygwin-patches@cygwin.com>; Tue, 03 Mar 2020 12:14:02 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id BBE0FA82778; Tue,  3 Mar 2020 12:14:00 +0100 (CET)
Date: Tue, 03 Mar 2020 11:14:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/1] Collect handling of wpixput and wpbuf into a helper class.
Message-ID: <20200303111400.GZ4045@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <877f246b-08c2-6ccd-faac-6c90661212e5@t-online.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="9gXqgVhKaPB5h51M"
Content-Disposition: inline
In-Reply-To: <877f246b-08c2-6ccd-faac-6c90661212e5@t-online.de>
X-SW-Source: 2020-q1/txt/msg00275.txt


--9gXqgVhKaPB5h51M
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2654

Hi Hans-Bernhard,

On Mar  3 00:07, Hans-Bernhard Br=C3=B6ker wrote:
> Replace direct access to a pair of co-dependent variables
> by calls to methods of a class that encapsulates their relation.
>=20
> Also replace C #define by C++ class constant.
> ---
>  winsup/cygwin/fhandler_console.cc | 135 ++++++++++++++++--------------
>  1 file changed, 70 insertions(+), 65 deletions(-)
>=20
> diff --git a/winsup/cygwin/fhandler_console.cc
> b/winsup/cygwin/fhandler_console.cc
> index c5f269168..af2fb11a4 100644
> --- a/winsup/cygwin/fhandler_console.cc
> +++ b/winsup/cygwin/fhandler_console.cc
> @@ -59,17 +59,22 @@ static struct fhandler_base::rabuf_t con_ra;
>   /* Write pending buffer for ESC sequence handling
>     in xterm compatible mode */
> -#define WPBUF_LEN 256
> -static unsigned char wpbuf[WPBUF_LEN];
> -static int wpixput;
>  static unsigned char last_char;
>  -static inline void
> -wpbuf_put (unsigned char x)

This patch won't apply since commit ecf27dd2e0ed.  Can you please
recreate the patch on top of current master?

Also, a few style issues:

> +// simple helper class to accumulate output in a buffer
> +// and send that to the console on request:

The /* */ style of comments is preferred.  Please use it always
for multiline comments.

> +static class WritePendingBuf

No camelback, please.  Make that `static class write_pending_buf'.

>  {
> -  if (wpixput < WPBUF_LEN)
> -    wpbuf[wpixput++] =3D x;
> -}
> +private:
> +  static const size_t WPBUF_LEN =3D 256u;
> +  unsigned char buf[WPBUF_LEN];
> +  size_t ixput;
> +
> +public:
> +  inline void put(unsigned char x) { if (ixput < WPBUF_LEN) { buf[ixput+=
+]
> =3D x; } };

Please put a space before an opening parenthesis, i.e.

  inline void put (...)

The semicolon after the closing brace is obsolete.

Line length > 80 chars.  Also, it's an expression which is multiline
by default.  Make that

  inline void put (unsigned char x)
  {
    if (ixput < WPBUF_LEN)
      buf[ixput++] =3D x;
  }

> +  inline void empty() { ixput =3D 0u; };
> +  inline void sendOut(HANDLE &handle, DWORD *wn) { WriteConsoleA (handle,
> buf, ixput, wn, 0); };

Camelback, missing space, line too long, obsolete semicolon:

  inline void send_out (HANDLE &handle, DWORD *wn)
  { WriteConsoleA (handle, buf, ixput, wn, 0); }

"send" or "write" or "flush" would be ok as name, too, no underscore :)

Btw., looking through the code with this change I wonder about ixput not
being set to 0 in sendOut, right after calling WriteConsoleA.  That
would drop the need to call empty after calls to sendOut and thus clean
up the code, no?


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--9gXqgVhKaPB5h51M
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl5eO/gACgkQ9TYGna5E
T6C9iA/9Gpf/9xvPzh5eoHP1ZSyr9m9IQEFYf/5G/MS6BfFxkQWOX5KNMoY4Utm3
nOiMp+zUl6rxzJXRMZVIwzm+ZENj6ePJj8uTg8a67FFfB69z63EUJyKdyp93/Qa/
AbIA085B8X3NABHN/KA4jrDfFQHRATlQE0sE0CPglocb3qXMQTAm9Gj4fy95crwb
sONVx45DhEgt5CKm/EoXY0T4Q5uLhvqTXIHtxqv6KpMB3v+cQCOBqf02+upVyUzD
bC4BTvBo5S1fgBgLuqWQUb83UaX+WyV1/LzYxWv3cEC52g2R1Yt6psgQqiXptTz6
yc3pvm2m/1sPYAxTdGCOY22iYqPoGYy1dTEKWttOAGpE2YGouUWLWCB3gsDFqJzY
4oLm4cpt+lN9XCJy/iaJgVzL1UnpOAfJ7Ud57jNZjHioU6HXsbcXqXo5oR6WGF9b
8+/15dNXg8BxhekBuFS1j/4rl7oXx16ZmKJVTZHHQaISxfQDF9VSq09QWzvfeYcL
a6Ai3yJhiFO43RtaLgAHTK81bdBQe9geYpXWdpoidXehPsRY7C0heZiHuPX8N9kM
lgFlgzeKGscz2sF1IB3haHHdWN1VUnl1DSEP/1oRlXxQnKV8Y72Ul9F2nCznL+Fo
swLVFk7i2WqO5/1xgIVLqyzV5ihsSc0W/76Am5OggePG1mHeVRg=
=+gTf
-----END PGP SIGNATURE-----

--9gXqgVhKaPB5h51M--
