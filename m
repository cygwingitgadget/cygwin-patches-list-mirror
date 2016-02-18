Return-Path: <cygwin-patches-return-8327-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14418 invoked by alias); 18 Feb 2016 10:51:31 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 12544 invoked by uid 89); 18 Feb 2016 10:51:30 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-96.6 required=5.0 tests=BAYES_00,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC,USER_IN_WHITELIST autolearn=no version=3.3.2 spammy=H*R:U*cygwin-patches, H*F:U*corinna-cygwin, HX-Envelope-From:sk:corinna, HTo:U*cygwin-patches
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 18 Feb 2016 10:51:30 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id E75AFA803FA; Thu, 18 Feb 2016 11:51:27 +0100 (CET)
Date: Thu, 18 Feb 2016 10:51:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] cygwin: accept SIGIOT as alias of SIGABRT
Message-ID: <20160218105127.GC8575@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1455772898-11800-1-git-send-email-yselkowi@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="XWOWbaMNXpFDWE00"
Content-Disposition: inline
In-Reply-To: <1455772898-11800-1-git-send-email-yselkowi@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q1/txt/msg00033.txt.bz2


--XWOWbaMNXpFDWE00
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 479

On Feb 17 23:21, Yaakov Selkowitz wrote:
> 	winsup/cygwin/
> 	* include/cygwin/signal.h (SIGIOT): Define SIGIOT in terms of SIGABRT.
> 	* strsig.cc (struct sigdesc): Ditto.
>=20
> 	winsup/doc/
> 	* utils.xml (kill): Document SIGIOT.
>=20
> Signed-off-by: Yaakov Selkowitz <yselkowi@redhat.com>

ACK, please apply.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--XWOWbaMNXpFDWE00
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWxaIvAAoJEPU2Bp2uRE+gUu0P/RD9GzDPybRihrwIqtLl99Yr
ZfwAmqGFsHfkt/27vqLJw0pSIfc8dQWdLo0ZxOjS02UsD5dBOiWz9GJFlskH3ohT
lA3AXzJuGvif09LyW0HrKPDgBNy+vaHMUPxnu+UdMY/TLMvw4TMA3j7ObMd47gHO
dqV337T3mLSObK0GT7Wp/56/qI50TlPekW/4MRKfhv/V5p8/3eM0Rof0mIY7IUEj
XiXv8kM5kEKRzKvmtuYg2RpdLsBVkuHbNKOmatLHfC9c7/AaHEe+up+wkMHK1MJT
7/JLTV76+pFlmMFTcNKxii+pcsRARLv0d5dLQAdQb0xIFbleSGHpLr7SsNl5/Ono
Ma/u+fHAFEhtWy6bXP9qpTIGy++nru4jFR2/9Pu9EocA1YJWaGWRFYzIs0zuzL+K
4R1vgs4l66YavHil/en73voe77kzQw4P8im60kNDZ6r1jMBXZ7Xeir+yGsGzoSA5
epTOoFKTiSDVOLWiU9hRvprNeQ/DEy52NYyjWTnH8y6J8s/0Nj3H5/D1xA7QUY/Y
A0q7gdfcPubgbsYpU3fjr/aHj9+8Sz08jepQTp8Z1evaAwK4dw37BzZXTsDNxp2H
ADTI32QhBRDG5Zm9uxzYFIEDAgQWZdPYr1lKWB7UtbVoDWFG5yyzF/kmojJPZwuK
HWaDUYYz9/AM+2wolMBL
=6DtV
-----END PGP SIGNATURE-----

--XWOWbaMNXpFDWE00--
