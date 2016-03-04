Return-Path: <cygwin-patches-return-8371-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 85125 invoked by alias); 4 Mar 2016 08:56:10 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 85109 invoked by uid 89); 4 Mar 2016 08:56:09 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-96.6 required=5.0 tests=BAYES_00,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC,USER_IN_WHITELIST autolearn=no version=3.3.2 spammy=DOT, forces, H*Ad:U*mail, H*R:D*cygwin.com
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 04 Mar 2016 08:56:09 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id E3D88A80633; Fri,  4 Mar 2016 09:56:06 +0100 (CET)
Date: Fri, 04 Mar 2016 08:56:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Cc: Patrick Bendorf <mail@patrick-bendorf.de>
Subject: Re: [PATCH] ccwrap: fix build with non-english locale set
Message-ID: <20160304085606.GA8296@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com,	Patrick Bendorf <mail@patrick-bendorf.de>
References: <56D3EF72.20504@patrick-bendorf.de> <20160229103339.GB3525@calimero.vinschen.de> <b818ad6d60ddfd3557c3d9e21efc6344@patrick-bendorf.de> <56D43D9B.5020602@dronecode.org.uk> <20160229125813.GE3525@calimero.vinschen.de> <3ecc67c4a2351cf32f28927eea91fc01@patrick-bendorf.de> <56D466A6.1000003@redhat.com> <56D47828.1090208@patrick-bendorf.de> <56D48611.2040704@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Content-Disposition: inline
In-Reply-To: <56D48611.2040704@dronecode.org.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q1/txt/msg00077.txt.bz2


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 779

Patrick,

On Feb 29 17:55, Jon Turney wrote:
> On 29/02/2016 16:56, Patrick Bendorf wrote:
> >thanks eric.
> >just changed and tested it.
> >hopefully the last patch for this matter.
> >
> >@corinna: as attachment to overcome previous problems.
>=20
> Unfortunately, this still isn't quite right, as it forces the 2nd invocat=
ion
> of the compiler to be with LC_ALL, so localized compiler error messages w=
ill
> not be shown for actual compilation problems.
>=20
> So perhaps the setting of LC_ALL should be in the implicitly forked block
> after the open('-|') ?

are you going to look into this by any chance?


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW2U2mAAoJEPU2Bp2uRE+gWKsP/RHs06G29wLkC6Mi/ZfbzDv8
W9vAppY4B4Pahx0ncw94Yx0p9WnP8cPt87nqj/NvMmSMEqwX+MyX6eRwGv8+6/td
MV/8hD1bI8O1GPQGVXypACfglQPEPiEjYNCB9NaPUYqangAxA2bOhWWLvZjixh9w
RmqHLkmDlSfRHwi9BgwrPKy6lkT0/pnBr6O7ZC1VRmhppdUaWTR+nyC6nnUG4lG5
/ZXO2QBHa600HmqIFHgXvW00P518YixjVXrVEW2M04WoRBbRA2qcPWyszhEKnN3l
SRelOLZQsCHMDIf6+2jEf3p/tHWOEwAsox84s4wHuFhOQjoAFyymVl5CmFNK+o+5
d++lArImfdNwBVBFXiYZnTFLX6g8VUPL09M6RuXNizp1jhOOOBQM2RujLWriLEBO
gG38C2Bo+Yhi/zR+k7jOYUiRUTySGZmYvU3iadkWOGvNovgpNLeaeEG4shzE65rC
ZpLqadMjNIveF37Xm1YQVlCJZRHt1fiLLa9hNpbyCqH1nIhF8gnuActyRFmQomqb
dKNSQcLGK4mAOMiUv3JijBzxbbjeFV/wdST+jxAx2H7DekYnyLT8X344L1lDVPk/
zjhyDmQX/9xXRePySjwQoJxDl/AsiSFIF/zj/GgC0PX1WbpJVIhXW9N9xA4iLBYE
P6otwsf6ETF7r3TRsfnk
=V88M
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
