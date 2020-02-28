Return-Path: <cygwin-patches-return-10141-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 80765 invoked by alias); 28 Feb 2020 14:45:14 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 80682 invoked by uid 89); 28 Feb 2020 14:45:04 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-118.9 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.131) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 28 Feb 2020 14:45:03 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MvKTJ-1jPDhd1Y5B-00rKIF; Fri, 28 Feb 2020 15:45:00 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id CD880A819D3; Fri, 28 Feb 2020 15:44:59 +0100 (CET)
Date: Fri, 28 Feb 2020 14:45:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Cc: Hans-Bernhard =?utf-8?Q?Br=C3=B6ker?= <HBBroeker@t-online.de>
Subject: Re: [PATCH v2 1/4] Cygwin: console: Add workaround for broken IL/DL in xterm mode.
Message-ID: <20200228144459.GI4045@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com,	Hans-Bernhard =?utf-8?Q?Br=C3=B6ker?= <HBBroeker@t-online.de>
References: <20200226153302.584-1-takashi.yano@nifty.ne.jp> <20200226153302.584-2-takashi.yano@nifty.ne.jp> <05cca441-eb83-4600-90f3-bf82ec7a0190@dronecode.org.uk> <20200228111409.149929dcf710cabf99a879b3@nifty.ne.jp> <20200228133122.GG4045@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="/7+LvQqw8N5lf/3J"
Content-Disposition: inline
In-Reply-To: <20200228133122.GG4045@calimero.vinschen.de>
X-SW-Source: 2020-q1/txt/msg00247.txt


--/7+LvQqw8N5lf/3J
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1548

On Feb 28 14:31, Corinna Vinschen wrote:
> [CC Hans]
>=20
> On Feb 28 11:14, Takashi Yano wrote:
> > On Thu, 27 Feb 2020 18:03:47 +0000
> > Jon Turney wrote:
> > > > +#define wpbuf_put(x) \
> > > > +  wpbuf[wpixput++] =3D x; \
> > > > +  if (wpixput > WPBUF_LEN) \
> > > > +    wpixput--;
> > > > +
> > >=20
> > > So I think either the macro need it contents contained by a 'do { ...=
 }=20
> > > while(0)',  or that instance of it needs to be surrounded by braces, =
to=20
> > > do what you intend.
> >=20
> > Thanks for the advice. Fortunately, "if" statement does not
> > cause a problem even if it is accidentally executed outside
> > "else" block in this case.
> >=20
> > Hans,
> > as for making a patch for this issue, may I leave it to you
> > because you are already working on it?=20
> >=20
> > --=20
> > Takashi Yano <takashi.yano@nifty.ne.jp>

What about an inline function instead?

diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_con=
sole.cc
index 64e12b8320a1..6c3e33818aca 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -63,10 +63,14 @@ static struct fhandler_base::rabuf_t con_ra;
 static unsigned char wpbuf[WPBUF_LEN];
 static int wpixput;
 static unsigned char last_char;
-#define wpbuf_put(x) \
-  wpbuf[wpixput++] =3D x; \
-  if (wpixput > WPBUF_LEN) \
+
+static inline void
+wpbuf_put (unsigned char x)
+{
+  wpbuf[wpixput++] =3D x;
+  if (wpixput > WPBUF_LEN)
     wpixput--;
+}
=20
 static void
 beep ()


Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--/7+LvQqw8N5lf/3J
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl5ZJ2sACgkQ9TYGna5E
T6DWLQ//WZmCphI13swoeXpGV6AjV5pPIgV4uRteuDR/WGWomqkLduPX7+TrY0pJ
iTI8z9ZNBf0oXoTL8LT6CQAHGfCNRdIo0uKDq2quOzlW6cJTZDXf8fPAYlh9aA/1
tnWpam8/ewJHFfpjrS/UqfX/0D5xM1cWXqUNTu1r0Ctt8ZqTsNZqjEK0ledpwLch
vMhdnVznDqzSLGuV5eC0uiDrcLOJLJHHcbSFf89AwVsgtRufXx+9zmVOAHY47Grb
KTqR35nLcwgBUN2PgevuYXI21/+EbrJXLFRSUgVByXM/orMg03NNPe0sQ7QM+3MS
y0HOAM2dJ5Celp0+aOItL+oJQCn5Q6wJP947mJ4U9ynt1U3eAl0035kTIKEYI/xY
nyXAy0j1Pm6HGQT9gb/QS5czG1fYIvt7hHYpK6gEfHwFfMmGlhLQt8vyNNNWJcC8
cX5aIagFV23DJIVXSWwaCZVHnNn7HjoYoLnuP6Su4Zw+TtEVy0fKmSPrNN3/JgcZ
BC95ZZtJ/a5KpxCiDHOXbrwAe6vj1E7WsHmRmPZ7qsPSPhCCRZCwFJSsKn8Xrw89
P6Q3PVxB1PpiGAQdw2wxHLZm5lxQRYq9P2MXK3GdUBaAVxFiunuuUzz6TN4GghN9
eUMIiZjG45uEcdfhEtzfSdjjKgXjUth0TgGjUiIZuQOLwHuqWVM=
=2HFo
-----END PGP SIGNATURE-----

--/7+LvQqw8N5lf/3J--
