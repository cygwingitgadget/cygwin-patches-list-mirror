Return-Path: <cygwin-patches-return-8229-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 68507 invoked by alias); 29 Jul 2015 16:21:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 68324 invoked by uid 89); 29 Jul 2015 16:21:46 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.4 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 29 Jul 2015 16:21:38 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id BFDC2A80907; Wed, 29 Jul 2015 18:21:35 +0200 (CEST)
Date: Wed, 29 Jul 2015 16:21:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: RtlFillMemory fails on block sizes over 0x7fffffff
Message-ID: <20150729162135.GA20388@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3BD89E0BA5F96349B765DE1100906A6D016FC0267F@UKCH-PRD-EXMB01.illumina.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
In-Reply-To: <3BD89E0BA5F96349B765DE1100906A6D016FC0267F@UKCH-PRD-EXMB01.illumina.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q3/txt/msg00011.txt.bz2


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 847

On Jul 29 14:11, Petrovski, Roman wrote:
> Hi, just ran into a problem which boils down to the following at least wi=
th Windows 7:
>=20
> char *p =3D (char*)malloc(0x80000000UL);	//works fine, allocates memory a=
s requested
> memset(p, 0, 0x80000000UL);			//Watch process segfault.
>=20
> The RtlFillMemory either crashes or underfills the buffer depending on th=
e size given.
> Looks like internally it treats size as a signed 4-byte integer.
>=20
> Please apply the patch below or implement an alternative.

Thanks for the patch, but I'll rather be looking into an assembler
alternative.  I'm planning to pull in the NetBSD implementation, with
the tweaks required for MS ABI.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVuP2PAAoJEPU2Bp2uRE+gN+gQAJMNFUwf4s/aWBWkkCxv1xdV
eKE+r3DC6VW2FHd4Z5FXWcyALAKPBjwxuPjczOvXOZU9TYry85eSmz7h/mrqPiul
LHpzTVjdoOeWxjWRKGQz/bG119Iyyjm1UPJBLaiBtc1iWecmKQRN9iifjQURTYma
MjN2GZ7KFLJCNNOiSeLpT1kfAXreBzk22Pc2HoELSAuuBN4VzLEcpEnIvQGHTkIo
uHJCnr6hHsrAN9bKa7EukW1qteATD2G5foh5KGX0nWWusYv7zXXdaC2Azce+2dCN
wxR3d7FNWrXl0uPF73qkD7Ux2Q+iXNz1BWq29qcrg88mRr/wH4MIzDdZa/K2NtdW
V2S8JEl3YdSo5oTGfZHbutlbKGmxzWUeOwZcvrr84XeUclg8U0Wk+2EzePFwjM4K
C+fcfsv2d8JzCASLNdOv5ODkbkUHe9ufC7/Pg8ZKyVr4cEXlC7RNcee4SJ2C+69n
xu6NEu2Np9hm3h6pMrc2TxeIMvvWt2PU3RJr3ThoqiBKGhRD5cCgzEjsn5HljOsA
+TpwQ1dCPA4GYs7vF8U6++a/7wkLDoH7TUt7UHHfU6S0FXKh+UK96NF3P5gOtNyZ
X958/WeDshTlDOTdmc/Nd+dvJJSXiZPOxbw56euvH2NNem2MDuonkwXO73+7dcbi
UHy73ILhb+6UbFolY4BI
=EhVk
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
