Return-Path: <cygwin-patches-return-8344-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 35157 invoked by alias); 19 Feb 2016 10:48:03 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 35045 invoked by uid 89); 19 Feb 2016 10:48:02 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-96.6 required=5.0 tests=BAYES_00,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC,USER_IN_WHITELIST autolearn=no version=3.3.2 spammy=HX-Envelope-From:sk:corinna, H*R:U*cygwin-patches, H*F:U*corinna-cygwin, HTo:U*cygwin-patches
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 19 Feb 2016 10:48:02 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id D4AA3A80306; Fri, 19 Feb 2016 11:47:59 +0100 (CET)
Date: Fri, 19 Feb 2016 10:48:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] cygwin: Export clog10, clog10f
Message-ID: <20160219104759.GC5574@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1455814389-12684-1-git-send-email-yselkowi@redhat.com> <1455814413-6864-1-git-send-email-yselkowi@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="S1BNGpv0yoYahz37"
Content-Disposition: inline
In-Reply-To: <1455814413-6864-1-git-send-email-yselkowi@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q1/txt/msg00050.txt.bz2


--S1BNGpv0yoYahz37
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 433

On Feb 18 10:53, Yaakov Selkowitz wrote:
> 	winsup/cygwin/
> 	* common.din: Add clog10, clog10f.
> 	* include/cygwin/version.h (CYGWIN_VERSION_API_MINOR): Bump.
>=20
> 	winsup/doc/
> 	* posix.xml (std-gnu): Add clog10, clog10f.

Patch is ok if the newlib patch is ok.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--S1BNGpv0yoYahz37
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWxvLfAAoJEPU2Bp2uRE+gXp4QAJ1TsHPQC9wvkUPPG1Gs7aVP
+zyWJs9ZckrzZVPmhMRTYueqObqeE1VURGseBoo4rtKdCMBESukZMjV7NZq5NGYL
0dDap+qRt2Lts9AdaE43P52qjxZ46m/iVOqbCg1kZcc8mtJ+4HR2uWMwUl3FIOWn
EVcsga8a+QODwHEMRkSGoDTz2kiPFrXJlezoPyJfRWGzS+zDg6y12XjN3VkVMkXF
lCXNq+0a6f2MLPzC3+uGmS1G2VqpUotOl5kxGfJVfOCupZaPsYG2V7l+LHbvAfkU
nDRwTjAEmI5Uj/WoLEjgGj+jmwEvDRG5smQ1bLNDsOh4bQyAOg2Tx1muuL0owPEW
hQdD/rS91Jln9WgpV0E2L2k8ggBa/+9P1R4GFGorgen3PjBhT0dR56YLPT05Cfsg
suJRu9HOqgZR16RwWj2RyZog84sN3VZlc737H6C+94UPLBMygKiCTJUdqF9QnPVP
wq9P1c8yrK4PG7DFb/3+lemmdt+bxNZHWcdqZkRA1bo+p/h9XTUjM1/c+VHCd7J9
GZkjN4j50i9aQcWkroUu8ss1om/DcLkmSML42dNlrNm7G7gJLGSQV20QYX/NvpCr
kfRXehuMvftYt2IhcktLZGZcyoCLbOLhT8LdoE3FUGzKGIOUU8/V/450WLceeu1R
+zB3ZESgFWyAfb+Jv39Z
=Q55C
-----END PGP SIGNATURE-----

--S1BNGpv0yoYahz37--
