Return-Path: <cygwin-patches-return-9578-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 61159 invoked by alias); 28 Aug 2019 06:43:19 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 61147 invoked by uid 89); 28 Aug 2019 06:43:19 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-102.5 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*f:sk:3020fe3, H*i:sk:3020fe3, H*F:D*cygwin.com
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.130) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 28 Aug 2019 06:43:18 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MEVJq-1i06X21Mza-00G4E4 for <cygwin-patches@cygwin.com>; Wed, 28 Aug 2019 08:43:14 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 75404A805D3; Wed, 28 Aug 2019 08:43:13 +0200 (CEST)
Date: Wed, 28 Aug 2019 06:43:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: get_posix_access: avoid negative subscript
Message-ID: <20190828064313.GG11632@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20190826174324.46043-1-kbrown@cornell.edu> <20190827081355.GS11632@calimero.vinschen.de> <3020fe3e-1f5f-f53a-88c2-3d929e7f95d5@cornell.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="mGOycUTcijM/osTd"
Content-Disposition: inline
In-Reply-To: <3020fe3e-1f5f-f53a-88c2-3d929e7f95d5@cornell.edu>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q3/txt/msg00098.txt.bz2


--mGOycUTcijM/osTd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1087

On Aug 27 20:00, Ken Brown wrote:
> On 8/27/2019 4:13 AM, Corinna Vinschen wrote:
> > On Aug 26 17:43, Ken Brown wrote:
> >> Don't refer to lacl[pos] unless we know that pos >=3D 0.
> >=20
> > I'm not sure this is entirely right.  Moving the assignment to
> > class_perm/def_class_perm into the previous if makes sense, but the
> > bools has_class_perm and has_def_class_perm should be set no matter
> > what, to indicate that class perms had been specified.
>=20
> I don't think has_class_perm should be set if class_perm isn't set; that =
would=20
> cause a problem at sec_acl.cc:1169.  For has_def_class_perm it doesn't se=
em to=20

I see what you mean.  class_perm defaults to 0 so the group perms might
be off.

> matter.  Unless I'm missing something, has_def_class_perm is not used whe=
n=20
> new_style is true.
>=20
> > Either way, does this solve a real-world problem?  If so, a pointer
> > or a short description would be nice.
>=20
> No, I just happened to notice it while studying the ACL code.

Ok, thanks, please push.


Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--mGOycUTcijM/osTd
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl1mIoEACgkQ9TYGna5E
T6Dbbw/7BXex0ok7gv42i6SaNSclFdPtaYizAl4canHm5qsvQXHlDEJbPbfTtf2D
tKQMwwpvYXSGCQdNmNykHTvf1k0rb9WtMhicmuLzs3/3n7rlU5A/Yo4noCM9cTMK
63nSBQ2ckE5VrlIBNh2O4R3nkF/kRKVDp24EqT48D6n3PnaFtJtTw4xj8nA57Aso
BMAheli6py6vY5EGJBHe1miK8/DnhKEXFOkWU3D9Xy9qLX3grGu7wVkS4FIVwKlO
ARAp7UARKoMOw28sN0zXKZc2IAg4p3LIJpjEELfq2HA6z6LAO7JrOq64DKmH4atE
tNnjIvJP9XMOCb/AqB86VwO0BMaIcl/NCFHUwZmLyA6AOzoMLj19wi4yKdKaRVLL
Zs0fkTnPNCVoRg3fLwWqjcOg9ebJ9uCsADxFLT38l3Dfah1HxpdWRTWl0AlZCC0L
2cPOZwMdpoN1Pa7w2w6AAf/7i5FHANiGBEwL4BRDkD6wWp+F20godf6F2xTSfO63
gM+pAEgHi+otE21i3+Px+zpOGgSck2kf2XpqyPPWIEb0n7bh76Qac3B9N7nnf3AG
HWxvytRQp1F6dUZBSnEySQxaWVmLS8xAhP7sNz3fmaDuWqKte6o79JObieKn3lNw
+4QdEKIHf7jtxOX8BfTb6NTWPo39WGeBrW3oileFuUwp7EhMOhQ=
=CKI+
-----END PGP SIGNATURE-----

--mGOycUTcijM/osTd--
