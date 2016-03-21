Return-Path: <cygwin-patches-return-8461-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 109606 invoked by alias); 21 Mar 2016 19:30:55 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 108251 invoked by uid 89); 21 Mar 2016 19:30:55 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-6.6 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC autolearn=ham version=3.3.2 spammy=H*R:D*cygwin.com, HTo:U*cygwin-patches, H*Ad:U*cygwin-patches
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 21 Mar 2016 19:30:54 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 28193A803F7; Mon, 21 Mar 2016 20:30:52 +0100 (CET)
Date: Mon, 21 Mar 2016 19:30:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 4/5] Don't build utils/lsaauth when cross compiling.
Message-ID: <20160321193052.GG14892@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1458580546-14484-1-git-send-email-pefoley2@pefoley.com> <1458580546-14484-4-git-send-email-pefoley2@pefoley.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="tvOENZuN7d6HfOWU"
Content-Disposition: inline
In-Reply-To: <1458580546-14484-4-git-send-email-pefoley2@pefoley.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q1/txt/msg00167.txt.bz2


--tvOENZuN7d6HfOWU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 541

On Mar 21 13:15, Peter Foley wrote:
> Don't require a mingw compiler when bootstrapping a cross toolchain.

I'm not sure this is the right thing to do.  I'm cross compiling
Cygwin all the time, and I certainly need the mingw compiler to
build the utils and lsaauth dir.  In what case do you not need them,
and shouldn't that bordercase(?) be handled by some configure option?


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--tvOENZuN7d6HfOWU
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW8EvrAAoJEPU2Bp2uRE+ggbMP/Awz/bIKdzQg1a0c1Hk0Vcf4
32+GVpKx7YYAcVAKtck1kmxV0UiiU2jS7SZXZ663gYmszMLPFugh+bZpm19Vv7Nc
INTJWE9ipleLIB258eKyCO9XmxYvir692cRzIAMvG68pT3X6oOlcvOj0nBRE1apP
yK57cl98Jib1zdUDxOl4r31Fa9bcXl+kRj32kAj1DLqMTl4CenVs/HWUn1gKAmP4
pZDlJKdY+ZLjvwjOgzKDp4GU7BcqFsbnZDUR706fQ0IpFX9N2supqjZKZI3Zj/KU
dMiaMpvDG1Yt6NMlff/WAYz84H8Bq6yg+W6g4Fx6wYb3VX1zdIzW1nQqOrUBSABI
Y/Yz7+vyHQ1ikEDmjzGLZKjxnE11yLiY6UXkPxAupYeBUsFeeHlMnAT/E3FLGsDb
hFtAmYlwA3Qh1/Cc5783n1SdZ3XM9jj76xmrVTFU84K+7qM83yR0WFMLx9cMX49a
q/zya92Q7fUR8Gal1fQaY7gbgr/6tRO5Nz/lzb3tbQgRdMOx2SHxd+byYjXaySrp
e52FZpwJPPad6u7J4djfUaTp4OnmVgF/90aLNT3cUkiaGnKZEZbHnMWpIURKrtz8
V3g05pDtzi+T+2q9fPS7pYzlajYD5qECGrfPvq6zLwJsy+54v1FwsC0gvHoCZA7q
t9VlHBF/YK6CMk3VFfC4
=I1DA
-----END PGP SIGNATURE-----

--tvOENZuN7d6HfOWU--
