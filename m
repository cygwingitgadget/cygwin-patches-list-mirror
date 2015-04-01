Return-Path: <cygwin-patches-return-8103-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28461 invoked by alias); 1 Apr 2015 14:01:03 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 28446 invoked by uid 89); 1 Apr 2015 14:01:03 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.9 required=5.0 tests=AWL,BAYES_00 autolearn=ham version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 01 Apr 2015 14:01:02 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 313BDA8096E; Wed,  1 Apr 2015 16:01:00 +0200 (CEST)
Date: Wed, 01 Apr 2015 14:01:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/3] Rename struct ucontext to struct __mcontext
Message-ID: <20150401140100.GX13285@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1427894373-2576-1-git-send-email-jon.turney@dronecode.org.uk> <1427894373-2576-2-git-send-email-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;	protocol="application/pgp-signature"; boundary="skzcsJvRJWOW8YcK"
Content-Disposition: inline
In-Reply-To: <1427894373-2576-2-git-send-email-jon.turney@dronecode.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q2/txt/msg00004.txt.bz2


--skzcsJvRJWOW8YcK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 448

On Apr  1 14:19, Jon TURNEY wrote:
> 	* include/cygwin/signal.h : Rename struct ucontext to struct
> 	__mcontext.  Fix layout differences from the Win32 API CONTEXT
> 	type.  Remove unused member _internal.  Rename member which
> 	corresponds to ContextFlags.  Add cr2 member.

GTG.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--skzcsJvRJWOW8YcK
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVG/ocAAoJEPU2Bp2uRE+gpgMP/3pT/HAlFk4wsDuTtxuQPz0U
iCyOwslubHzkTWWNaBdtznHLe0KVoMh/x2umduk0MrKtvNT3FHbeDGqWv3Iu1T33
g00SWZMDerPHvh5/qsOCURywOjmH4AXjkMWYORNGoNtbGwehxwVF8uLAsxR3OvKm
JQRwz7HWFI0jEkbF1y9M+hCmiqmQfMZ8fDMAulobN3Q4th4zZ3+4pl7GMSaL46v0
EI+BEg7u9p9qERcgyRfYTQBzE+SfmRBEyAdofy9A9pC3z0HZS1Hnm1qQbhfLMBWp
Cxosd12TrB7Lsj0+jCRf/A19veZr/e7CdI/9xhuhu5zK9BkoJBmeAzUhsgQlyMDg
uRxYhUD3eCQmC4Y2xAcvgTlEFcEDLY06/AaNPYw0tTzQ4nu60TAycNqueqWbBVQR
Ds87A9+WzCTrudoUMSJ662pPd38KhNq2h5M+PnlexhMzab8z0bRFmy7ooRXyJeMN
brhOeGU9DBhGNiASBwzIwRjG+8ACtZtzXYctfTwUgPQ5gHid2bEwDzPGZAYqkYf/
KEF7SIFE+1uHhziFU8qJXD0fMNeOlo2vK6ZXMCHSfs/v0m2u15SJHGGHB9xmyxOu
+GyMGAvbTmEI2SGc4aSQzlM6uMol5PTokgIdbIQTKKLf9aNDqLPydSQN1CUYWYcD
ARRhO10s0C8IHOu94xr1
=LC4d
-----END PGP SIGNATURE-----

--skzcsJvRJWOW8YcK--
