Return-Path: <cygwin-patches-return-8436-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 70294 invoked by alias); 20 Mar 2016 11:20:36 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 70277 invoked by uid 89); 20 Mar 2016 11:20:36 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-6.6 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC autolearn=ham version=3.3.2 spammy=Hx-languages-length:300, H*R:D*cygwin.com, HTo:U*cygwin-patches, H*Ad:U*cygwin-patches
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 20 Mar 2016 11:20:25 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 9F303A805AC; Sun, 20 Mar 2016 12:20:23 +0100 (CET)
Date: Sun, 20 Mar 2016 11:20:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 08/11] Fix typoed comparison
Message-ID: <20160320112023.GN25241@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1458409557-13156-1-git-send-email-pefoley2@pefoley.com> <1458409557-13156-8-git-send-email-pefoley2@pefoley.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="jQIvE3yXcK9X9HBh"
Content-Disposition: inline
In-Reply-To: <1458409557-13156-8-git-send-email-pefoley2@pefoley.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q1/txt/msg00142.txt.bz2


--jQIvE3yXcK9X9HBh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 296

On Mar 19 13:45, Peter Foley wrote:
> winsup/cygwin/ChangeLog
> * thread.cc (semaphore::open): Fix mistaken conditional.

Applied.


THanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--jQIvE3yXcK9X9HBh
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW7od3AAoJEPU2Bp2uRE+gxKYP/R7mk6WHkIEwmqIyzXfCFgYr
VHPck6yzHMCukgU9sRHOTgIpXQ25YDGFIji/IJSHfEyxT6VBpbLLqLUJw3IWcpea
KlUUc4c6lRZsGcNTerHDmskjCWZTJzSAzVguFvJl8oPlO5u9HEymI9plQHIgvy5O
xZrnxbEgH+oO39m2Ubu/1NcmGvUQBmqA01TgjAlA4rcPLTwEpLp3O+eY1o2HjpZ2
EGYEXDlqVB+rZjngLAW3Q+MrUhm5JbmTNpJqODyDsShTR0RxPTLD8UeN4qFjA7mg
9Y+3q86rqYc4hw+L+5HkeJm72Uo1p0hR9ylDCufDhYg0xBacEosw4k/05Vk923C3
sNKCJesZsbyo6GAoP3GWP8I7MSit8NvkirD3ZzR+IUqdWKQSQWf8iScF5Qpl9RkM
f/cKChvFFwkXbf5j1P2LOvDNaXMGHGCiF1AhzR1ozHd15dcxroH569zz4vosHrPW
5KLp4oc9BT3zehIGtPgMlERurMoIazVSNsU0ffU6jkkoL5JTuZIFWgk17R3M5JKo
7M7vPYu9gvbAaInCnBNhVl94QVc5SaQ6kZc7oatE2PtTXJ0jGalDKf3r1SfLrKsi
46slTukrSmABv8+L5W3Qu6dOLl9GPhD+GjS0OGeXmAAOM4KerBmQC3+JLJ+/9YBu
uigUOm4LUcm8ZOP9x8lE
=ZCtq
-----END PGP SIGNATURE-----

--jQIvE3yXcK9X9HBh--
