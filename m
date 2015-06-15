Return-Path: <cygwin-patches-return-8164-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 81697 invoked by alias); 15 Jun 2015 17:05:44 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 80963 invoked by uid 89); 15 Jun 2015 17:05:43 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.4 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 15 Jun 2015 17:05:43 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id EAEF3A807CE; Mon, 15 Jun 2015 19:05:40 +0200 (CEST)
Date: Mon, 15 Jun 2015 17:05:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 4/8] winsup/doc: Use fo.xsl to customize PDF generation from DocBook XML
Message-ID: <20150615170540.GD26901@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1434371793-3980-1-git-send-email-jon.turney@dronecode.org.uk> <1434371793-3980-5-git-send-email-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="6Nae48J/T25AfBN4"
Content-Disposition: inline
In-Reply-To: <1434371793-3980-5-git-send-email-jon.turney@dronecode.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q2/txt/msg00065.txt.bz2


--6Nae48J/T25AfBN4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 485

On Jun 15 13:36, Jon TURNEY wrote:
> fo.xsl doesn't seem to be used since c2f50c40 switched back from xsltproc=
 to
> xmlto
>=20
> 2015-06-12  Jon Turney  <...>
>=20
> 	* Makefile.in (cygwin-ug-net/cygwin-ug-net.pdf)
> 	(cygwin-api/cygwin-api.pdf): Use fo.xsl to customized DocBook
> 	XML->PDF conversion.

Please apply.

Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--6Nae48J/T25AfBN4
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVfwXkAAoJEPU2Bp2uRE+gWBEQAKR8C1imJ92uLHvSrzhJ9MRZ
aktCXFmZLuwF14pF9w/YoO3e4S34sdgx/Mmsyfg5a5C4DmdjNCeDabIZvBL12dBj
NteNL6AsAMFaxsl4N31otIFeKkDu26aJ4q+vOu2PzZa46Uj386cNtfP2H+kAzQ3U
AyNu8AUGnDRqEojbjRw8MbkD1NQb5AfZm+1j8MZmxwTpWZ0/CWsaqaRF6crMvSpI
kTFVcFT69fSXAMN8CCtAVzU9eTRPWT8fhud22g0Hl9H/p9LLxZyrrSt8m7rE/Zjj
vGJhgmCUlkgpuKU4HXYTFQ3e0XBSLVxlMCclo5thoKoSgKI2hZs1ZEUBhWKy1ov1
LYT73TZERisCzEQ7vXbnrncsIUcRdvxhuVq2U9K8UGNqHdIHmWi1hQec3ETUqbnB
22x3Ff3aa1FGZMiK8inont6zr5YdmY/NxFEDH+/9k4kkBAx0ZRDon8P4a9Hlwq5I
IuV22ZMtr8If03qLmpq7oOlLx+ixSIrr4Arz75738pX+cPkmB1RMs4mzXA3PsGug
Kxwx2rU6zMnyJUotVpcPc7u0m6mGpw4G45T3NgLetgXyHZRrC+Ao2hr12O6/cO7M
BSl21tkYeKZ9ADG0OfSuNAEdvholg6fCK0ZDQBUKEmnWi7J9sCamDzpM4Ng9s6/H
DArbDS7qrXqBaAHU4CL2
=uHpY
-----END PGP SIGNATURE-----

--6Nae48J/T25AfBN4--
