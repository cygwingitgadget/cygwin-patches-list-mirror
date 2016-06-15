Return-Path: <cygwin-patches-return-8581-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 76758 invoked by alias); 15 Jun 2016 15:39:50 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 76717 invoked by uid 89); 15 Jun 2016 15:39:49 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-96.3 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RCVD_IN_SORBS_DUL,RDNS_DYNAMIC autolearn=ham version=3.3.2 spammy=Spam, Hx-languages-length:1898, pictures, View
X-HELO: calimero.vinschen.de
Received: from ipbcc0227e.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.34.126) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 15 Jun 2016 15:39:39 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id F038EA803F7; Wed, 15 Jun 2016 17:39:36 +0200 (CEST)
Date: Wed, 15 Jun 2016 15:39:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [setup] move view from left to right
Message-ID: <20160615153936.GF27295@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <ea3fb37b-8c1f-38be-a52f-3e2dae74d14c@gmail.com> <20160615124947.GE27295@calimero.vinschen.de> <c0854c9c-3b17-4570-733d-fc325b27d1f9@gmail.com> <f1540797-04ba-316b-487e-daaeb85b3381@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="WYTEVAkct0FjGQmd"
Content-Disposition: inline
In-Reply-To: <f1540797-04ba-316b-487e-daaeb85b3381@gmail.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
X-SW-Source: 2016-q2/txt/msg00056.txt.bz2


--WYTEVAkct0FjGQmd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1939

On Jun 15 16:52, Marco Atzeri wrote:
> On 15/06/2016 16:37, Marco Atzeri wrote:
> > On 15/06/2016 14:49, Corinna Vinschen wrote:
> > > Hi Marco,
> > >=20
> > >=20
> > > in theory patches to setup should go to the cygwin-apps list, but
> > > never mind, cygwin-patches is just as well.
> > >=20
> > > On Jun 15 12:06, Marco Atzeri wrote:
> > > > I always found counter intuitive to have the view button filter on
> > > > the right.
> > >=20
> > > Do you have a screenshot to show how this looks, by any chance?
> >=20
>=20
> Spam filter don't like pictures so, I put them here:
> http://matzeri.altervista.org/works/setup/

Thank you.  What strikes me immediately is that the search field and
clear button are not in the same height.  I never noticed before.
Actually, I think search field and clear button are a pixel too narrow.

And in the second picture the "Not installed" text is too far left.

What about this:

- Arrange the "View" button with the left side of the package table.

- Arrange the accompanying text right of the button.

- Move "Search [...] Clear" to the center?

- If you don't mind the extra work, align the y-pos and height of the
  search stuff to the other elements in the row?

> > > > I was also thinking to replace the 3 button choice with
> > > > 2 sets:
> > > >=20
> > > > keep vs update
> > > > exp vs current
> > > >=20
> > > > but the update logic on
> > > >=20
> > > >  ChooserPage::keepClicked()
> > > >  ChooserPage::changeTrust(trusts aTrust)
> > > >=20
> > > > it is not really immediate.
> > >=20
> > > I agree, but the idea makes sense.  If you ever have fun to hack on
> > > this, please feel free.
> >=20
>=20
> I need to refresh my C++ knowledge to understand what
> changeTrust is doing, so it could take a while.

Same here :)


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--WYTEVAkct0FjGQmd
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXYXa4AAoJEPU2Bp2uRE+gNZ0P/368mOxMGieClDTBs66Fip0u
vRqkYhcYzph6NXnA9I1eJ5GE1XjwSvBTh945Uf4JwODz5y0LjHM6a7fp40jG/SWd
3DA2RnDh90JL3W1sBY3/mUZcoHY5gy+E/5L8uQBtl/w4Rmt+Fi3jfvr1oHzju6h1
OpvpthRIA6LIXlkhNIglLLOjIMoC2aO3jWV7MNrBZILee5h8vXk+EBpYCQRAwoda
j4VdUomK0E0O6lCAy4Q+AUKi+ZWLWSXaMl9TMqxDaaiSRmgRKdtK1NXMAidhtAcm
G6CsBhWBGiWATjbHW5TFUweRHEzPBxHDak09oMGwpLiTgj9Poo92RLVGtAyo5sOl
/kOHhBda1TZmlgTpeCNn3oASZPgJkYOUrck7JTMp7qNAvs8FjMgTRgh2cCo0y8o/
jzAmsluZXMJ6DE2iDUpZXTdUV57SqjXU5YKX8mvbeLHP1z1MFc2NSkJnVwT3Kk/9
0R9h+FyblFWDM6ExHgkAR7ayizgjohc42wVmVySKFaftJrB4ziUzFRWfkAZzMeNV
nU9gHimuZgHD2XaArGtcyN1a5NHoNZTQ034yW9lHsc1z6syv41UXBHXKBQSe0cKS
ZvdNsuTKnu1JsbUrmXE5LOehMkEVzY30HeiRwP1iRJmKQswJoswOCNMMwWObCXAn
bYEwYM6ln5UjY8FrL7bL
=vGI+
-----END PGP SIGNATURE-----

--WYTEVAkct0FjGQmd--
