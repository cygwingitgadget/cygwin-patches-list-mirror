Return-Path: <cygwin-patches-return-8459-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 68783 invoked by alias); 21 Mar 2016 19:26:04 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 68676 invoked by uid 89); 21 Mar 2016 19:26:03 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-6.6 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC autolearn=ham version=3.3.2 spammy=H*R:D*cygwin.com, HTo:U*cygwin-patches, H*Ad:U*cygwin-patches
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 21 Mar 2016 19:25:53 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id E5BD1A803F7; Mon, 21 Mar 2016 20:25:50 +0100 (CET)
Date: Mon, 21 Mar 2016 19:26:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Update toplevel files from gcc
Message-ID: <20160321192550.GE14892@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <CAOFdcFNPgJrf3KcNaOvmoT+Aj3Gp46w=ob=okPT0vwJ4TvMTCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="qOrJKOH36bD5yhNe"
Content-Disposition: inline
In-Reply-To: <CAOFdcFNPgJrf3KcNaOvmoT+Aj3Gp46w=ob=okPT0vwJ4TvMTCg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q1/txt/msg00165.txt.bz2


--qOrJKOH36bD5yhNe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 823

On Mar 21 12:43, Peter Foley wrote:
> When building a cross compiler targeting cygwin, the target objcopy
> binary wasn't properly picked up.
> It appears that a fix for this has been commited to the gcc tree
> https://gcc.gnu.org/git/?p=3Dgcc.git;a=3Dcommit;h=3Dfc740d700395d97b6719e=
8a0e64f75d01ab0d8fd
>=20
> A patch to copy the updated Makefile.def, Makefile.tpl and
> configure.ac from gcc and regenerate Makefile.in and configure is
> 1.4M, so too large to send to the mailing list.
>=20
> Would it be possible for someone to sync the latest toplevel files from g=
cc?

Yes, but that's time-consuming since there's no automatism.  Give me
a few days.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--qOrJKOH36bD5yhNe
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW8Eq+AAoJEPU2Bp2uRE+gkMQP/3oZHNquY1lqSSVe/K+Oxrsp
FWHM9cazWNyp/4ZNcQYX+0i2wflq+zNa6z2eLqx1fdxqWzCMxEMMfprrO2TT+Kab
JxyqlCMSFAbwS1iApQwIHzwS27kcRcj59ApHwnokSvX+ZVktOh9GZudIC6IKLAoD
kI4IFb6h8rvaqM2Bs9dyCX21w6cl+tZ75j5hNS72gA1gzYQ7KiblAai0Xiq0aAJf
dALkAi1X78q48WXUTjsio0wEwM0V0VfAc9mhg9xXx1tBqg8kILloVuI7UVkel6V1
AdM1JweQovjwUeqKmdmhHYP6CpdLQCEWWx0C2pF9BUUNK76yZFPA/oMMmtCGtEGK
lQO3suJZUUlKycuz1mpGfecaC+mx6m4lZcizwoBbl5OMeNN4xbVWJo2uYTx25MY9
q7Ji41GWY9iSkViRfH9Qx7b0Yiatxz7k+kAYLebdnjsHjNS61F3uFqPVuQs7RRNP
3hawKgS7qXff+Tl5E9axGtyS8xdHBSX8OrvAX5xYE1aMfY/9RU9CzB0i2PGHun1g
UPjmXbsuakOLYExNlvwXECInA8E14borLuVAfVA6p0+I2NITAEP55diwmDQrWzOJ
fXajQ84qqfatVIl5E7OEB/6D4Lm8gMmatnr/w+mF8ZHx9iO6P2Bv8SaXH7d4c4O3
Ut4ERffglNaic+8tt1+Q
=gCcA
-----END PGP SIGNATURE-----

--qOrJKOH36bD5yhNe--
