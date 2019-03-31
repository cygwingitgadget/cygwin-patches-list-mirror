Return-Path: <cygwin-patches-return-9281-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 109524 invoked by alias); 31 Mar 2019 09:47:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 109514 invoked by uid 89); 31 Mar 2019 09:47:40 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-104.0 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE,URIBL_BLOCKED autolearn=ham version=3.3.1 spammy=considering, btn, H*F:D*cygwin.com, letter
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (217.72.192.75) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 31 Mar 2019 09:47:39 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id 1Mt7x1-1gvKd32l4b-00tQC8; Sun, 31 Mar 2019 11:47:32 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 8239AA8059A; Sun, 31 Mar 2019 11:47:31 +0200 (CEST)
Date: Sun, 31 Mar 2019 09:47:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Reworks for console code
Message-ID: <20190331094731.GC3337@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Takashi Yano <takashi.yano@nifty.ne.jp>,	cygwin-patches@cygwin.com
References: <20190331152018.c47d6a3a2bc5b9a58e4f06f5@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="rQ2U398070+RC21q"
Content-Disposition: inline
In-Reply-To: <20190331152018.c47d6a3a2bc5b9a58e4f06f5@nifty.ne.jp>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q1/txt/msg00091.txt.bz2


--rQ2U398070+RC21q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 3096

Hi Takashi,

On Mar 31 15:20, Takashi Yano wrote:
> Hi,
>=20
> I would like to propose 3 patches attached to improve console code.

Not a hard requirement, but it would be nice if you could send your
patches as patchset with cover letter via `git send-email' from the
git-email package or in the same style.  See, e. g.
https://sourceware.org/ml/cygwin-patches/2019-q1/msg00036.html

This really simplifies review, discussion and applying patches.
With attached patches, replying to a patch does not quote the patch
so inline commenting is pretty tricky.  Thanks for considering.

Having said that, this is a snippet from patch 1:

+      /* Check if 24bit color is available */
+      DWORD dwVersion =3D GetVersion ();
+      dwVersion =3D (LOBYTE (LOWORD (dwVersion)) << 24)
+       | (HIBYTE (LOWORD (dwVersion)) << 16) | HIWORD (dwVersion);
+      if (dwVersion >=3D ((10 << 24) | (0 << 16) | 14931))
+       {
+         con.cap24bit_color =3D true;

OS features or bug tests should be performed via wincap, see wincap.cc
and wincap.h.  We do not care for Windows test release, so this should
be enabled for W10 1703 and later.  Just add an "has_con_24bit_colors"(*)
flag to the wincaps struct and set it to false on older Windows
versions, true otherwise.  So the above code snippet can go away and
in subsequent code just check for wincap.has_con_24bit_colors ().

(*) exact name of the flag is your choice

+         /* If system has 24bit color capability,
+            use xterm compatible mode. */
+         setenv ("TERM", "xterm-256color", 1);

Having the 24bit color capability check in wincap also means, setting
TERM could be moved into environ.cc, function win32env_to_cygenv()
where we already set TERM=3Dcygwin.  This could then be done conditionally
based on the wincap.has_con_24bit_colors check.


Patch 2:  Looks good, just a question:

+                 if (mouse_event.dwEventFlags =3D=3D MOUSE_MOVED)
+                   {
+                     b =3D con.last_button_code;
+                   }
+                 else if (mouse_event.dwButtonState < con.dwLastButtonStat=
e && !con.ext_mouse_mode6)
+                   {
+                     b =3D 3;
+                     strcpy (sz, "btn up");
+                   }
+                 else if ((mouse_event.dwButtonState & 1) !=3D (con.dwLast=
ButtonState & 1))
+                   {
+                     b =3D 0;
+                     strcpy (sz, "btn1 down");
+                   }
+                 else if ((mouse_event.dwButtonState & 2) !=3D (con.dwLast=
ButtonState & 2))
+                   {
+                     b =3D 2;
+                     strcpy (sz, "btn2 down");
+                   }
+                 else if ((mouse_event.dwButtonState & 4) !=3D (con.dwLast=
ButtonState & 4))
+                   {
+                     b =3D 1;
+                     strcpy (sz, "btn3 down");
+                   }
+

This is not your code but while you're at it, would you mind to reformat
to 80 chars line length max?  Thanks!

Patch 3:  Looks good.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--rQ2U398070+RC21q
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlygjLMACgkQ9TYGna5E
T6Al1hAAgJMYxU5Ia6RvXBkbfU8AG0zpNdptRi4pr81TjQC4ThI7f9bHjQsTjwT1
H4wNjHy0cdyAj/eljy7EuoXJdO2QzuCWPDkbVL53H2MhT9fb8rn36ionfga7jJ1S
XORltR1OQhQ06mQxkRQMd/HGwMH70uxgcKz0gMcDVFRJkiEJFC9rqr9CZOGT6WZo
USU/gxbuVBSWS4b5MfD987y3YESR/+pqg320fvPNPLhq4NMZ3Fr3zJJ/rbTJh6Ym
WwtvNYFplvzx4fOQTctwM5jtyycoLA0P6/3YIQgcuKRuPofbtB0aSs46hptuDu5l
6Az+LAv1b4QcCmpFv26vn4Ne+vTmcbGSNlofeezPI/fMzqpmOcLMEmC6brlr4nfL
dl32bI5miTk1KWUWLAo8R5oqGS3igJTLm8E/WDVTfbZwmWEiZbEGhbo6EvHWyR+x
njB2Z/NAoZxc9qW953pL64vkfVHIzHP4Ss2hIPGO+oTwNBuKgt2NwKv9+n+/3m5S
xlnTFek5n1sx8bRc7aJynp3cHqutol2t0w4gvgrvr/qON7GJE/XEYzagZULqUtbZ
mHjcdeuFv84U4SPUZP9clB8ND0AKSlZyalvXvrVl9XJVwmNG/1l8g/bN7ROqeQpc
QIz9LBpC0zYkb9QWJac2sWzN4KTUgQycVlUDcwtqLKLFC92/LqI=
=C0zT
-----END PGP SIGNATURE-----

--rQ2U398070+RC21q--
