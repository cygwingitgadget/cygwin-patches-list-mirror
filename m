Return-Path: <cygwin-patches-return-8685-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 123443 invoked by alias); 12 Jan 2017 08:24:49 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 123336 invoked by uid 89); 12 Jan 2017 08:24:29 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-101.6 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=H*Ad:U*cygwin-patches, HTo:U*cygwin-patches, H*F:D*cygwin.com
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 12 Jan 2017 08:24:27 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id 598C7721E281A	for <cygwin-patches@cygwin.com>; Thu, 12 Jan 2017 09:24:24 +0100 (CET)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id AFCB75E027F	for <cygwin-patches@cygwin.com>; Thu, 12 Jan 2017 09:24:23 +0100 (CET)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 92DF8A804D6; Thu, 12 Jan 2017 09:24:23 +0100 (CET)
Date: Thu, 12 Jan 2017 08:24:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] FAST_CWD: adjust the initial search scope
Message-ID: <20170112082423.GB23119@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <5b4e3785c193feb56fa31eef637db2641e69eefd.1484140876.git.johannes.schindelin@gmx.de> <20170111160303.GA23119@calimero.vinschen.de> <alpine.DEB.2.20.1701112048200.3469@virtualbox>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="uQr8t48UFsdbeI+V"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1701112048200.3469@virtualbox>
User-Agent: Mutt/1.7.1 (2016-10-04)
X-SW-Source: 2017-q1/txt/msg00026.txt.bz2


--uQr8t48UFsdbeI+V
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 901

On Jan 11 20:48, Johannes Schindelin wrote:
> Hi Corinna,
>=20
> On Wed, 11 Jan 2017, Corinna Vinschen wrote:
>=20
> > On Jan 11 14:21, Johannes Schindelin wrote:
> > > A *very* recent Windows build adds more code to the preamble of
> > > RtlGetCurrentDirectory_U() so that the previous heuristic failed to
> > > find the call to the locking routine.
> > >=20
> > > This only affects the 64-bit version of ntdll, where the 0xe8 byte is
> > > now found at offset 40, not the 32-bit version. However, let's just
> > > double the area we search for said byte for good measure.
> >=20
> > any chance to convince the powers that be to open up access to this
> > datastructures without such hacky means?
>=20
> I try my best.

Thanks!  Patch pushed.


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--uQr8t48UFsdbeI+V
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYdz03AAoJEPU2Bp2uRE+g06oP/2jmDTQCFyFfQJsNdLxKXlUH
7YA/14tCyFhJu1sKk+astomQJEzMiGTO136lhUjjA9ddd7FBHGSGL2ofuGYafTny
i8g612w28oKEoK7IrbRbpx0nvDASpDVn2IVnrEtKPNmU1FtT43dnK8AZ6CmU02s8
AVaLH0pPH7l+yRTvLfrHIuUc68zWR4v/MioESXBXvzTm5vAxEOGlzsA76wIqdG18
IyPAT4xTZPBpI3MM6pqrgtrf1M8Cc6f1oef98EQEN+3yVlgTlF48NGCioEyvBQaH
ulxgvvC7Hgg0dmgkNuqFcW5J+/TPaQaHA/bGS5alTI0sa5VspDvhS8ALDPJRN5+6
LWIEoXZVf//dxTthb4g3HL9h+TLV6qLt9rYctdOfniN7McvHjtgLz0ST+rTs4/aT
SLzxgeF2W7gy7xwIL4REf1anEi9VxwxzJhIrnp8sqe+IOsupzY5u3uxySzYi6K2b
RcMvX2WzztDDmVCgyemcVsqnqC8XI8G7/cf5OyT5TxfQ3DlT0wyINA0kXOTJNS21
SbOnhqWxwSe7IjyBPPf/MyDW6ymJ6oRZlyU7TRMnHgqC8lQc0BJwryn1kwT5cOVO
/eIF0NLsUyIumOvx6cFuV/SFtUOdqS1tB3XGDmfAQVrutnvOvMr1oMUOKMLOEsSW
WTAm91Wm0cbAjFt2E1OV
=zcQu
-----END PGP SIGNATURE-----

--uQr8t48UFsdbeI+V--
