Return-Path: <cygwin-patches-return-8363-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20440 invoked by alias); 29 Feb 2016 12:57:32 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 20421 invoked by uid 89); 29 Feb 2016 12:57:32 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-96.6 required=5.0 tests=BAYES_00,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC,USER_IN_WHITELIST autolearn=no version=3.3.2 spammy=invocation, HX-Envelope-From:sk:corinna, H*R:D*cygwin.com, HTo:U*cygwin-patches
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 29 Feb 2016 12:57:31 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 0F353A8040B; Mon, 29 Feb 2016 13:57:29 +0100 (CET)
Date: Mon, 29 Feb 2016 12:57:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] ccwrap: fix build with non-english locale set
Message-ID: <20160229125729.GD3525@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <56D3EF72.20504@patrick-bendorf.de> <20160229103339.GB3525@calimero.vinschen.de> <b818ad6d60ddfd3557c3d9e21efc6344@patrick-bendorf.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="iFRdW5/EC4oqxDHL"
Content-Disposition: inline
In-Reply-To: <b818ad6d60ddfd3557c3d9e21efc6344@patrick-bendorf.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q1/txt/msg00069.txt.bz2


--iFRdW5/EC4oqxDHL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1600

On Feb 29 13:19, mail@patrick-bendorf.de wrote:
> Hi Corinna,
>=20
> Am 2016-02-29 11:33, schrieb Corinna Vinschen:
> >Hi Patrick,
> >
> >On Feb 29 08:12, Patrick Bendorf wrote:
> >>/winsup/
> >>* ccwrap: fix build with non-english locale set
> >
> >First of all, why fix it?  Without at least a short explanation what you
> >observe without this patch, this change seems arbitrary.
> >
> short explanation: after setting up cygwin on my systems the default loca=
le
> is set to "de_DE.UTF-8". this leads to ccwrap not picking up certain
> "-isystem" arguments, which in turn leads to "stddef.h: no such file or
> directory". this breaks the build process for systems having non english
> locale.
>=20
> consider the following two pastebins from a system with an english locale
> and mine. a whole bunch of "-isystem" can not be found on my system using
> german locale.
> http://pastebin.com/ip5L7dZY
> http://pastebin.com/wZBc2cqr
>=20
> ccwrap scans the output of the first compiler invocation (line 21) for so=
me
> specific english output on and around line 43.
> output of first invocation on german locale system:
> http://pastebin.com/ZZzVGReh
> [...]
> >Ideally the above would test for the current build system being Cygwin
> >and use "C.UTF-8" on Cygwin, "C" otherwise.
> >
> thanks for pointing that out.
> i changed the patch to check uname -o for cygwin string and set the locale
> to either C or C.UTF-8

Patch applied.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--iFRdW5/EC4oqxDHL
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW1EA4AAoJEPU2Bp2uRE+gH8sP/04L2tNde2zq5THlkbWbRpvs
IP9pvrQ1dsQScNOf0TXbF6Jdy1tYn0I1bBbxeCM5AAAVFaU9PO9D38h9aFEz5cyH
uzZ35gTjeT+b6JxhAWiA+rXZwHkgFirINHnKbiY0rLqOPBBBp28IJ+lXo646zAqA
ph3IsBBsqbb0sSYkVgG3KBOLwqir6heU37+VHZ+k7/9pXlKQJ4CBrYCvwjKKX+B9
TxSYfYetP/n4oq3ryYoZCDAz6yOILWRfoObQXZreS60FR3mBHYTmNBri3FDI5oUO
AKu0utu9tyCibyb5I7bIgKqFuzU0XM5tHxWM6dK6okH8X8CJEvMZklMOJXIubhk1
YylqN5UXoeEgkTKzdMOKnvWVyhzD+97r9GSS8FuQAc5JDoWjeGCFQrslMNGI9++3
t94WMpRQVqs0mrtFBzqW0IMYJoOWWbkp9PvtTst/ojAzFBLLq41b1kASGmGueHJw
uk3zdYLs1J1DxANdgb0aTpBqSioIWCIOKhcydx2guR8Ce3FevUbPgPWdnduYvUl+
+PVYYLutRTnVZp7O5XExcIbmoCzIJr9OgWIAhTP2KQx5nj2TCUqKGIw6yhHTS3vy
hcvUsC20z6gNaBowVXMraIgNpen3HYhveotIFypXoWp25w1/ZtKvWFW/W6wakTjH
c8vRy9IyNBmtonUhQkZ6
=chkC
-----END PGP SIGNATURE-----

--iFRdW5/EC4oqxDHL--
