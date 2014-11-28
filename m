Return-Path: <cygwin-patches-return-8038-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1864 invoked by alias); 28 Nov 2014 20:13:05 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 1852 invoked by uid 89); 28 Nov 2014 20:13:04 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.9 required=5.0 tests=AWL,BAYES_00 autolearn=ham version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 28 Nov 2014 20:13:03 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id CE55F8E1439; Fri, 28 Nov 2014 21:13:00 +0100 (CET)
Date: Fri, 28 Nov 2014 20:13:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] build PDFs with xmlto (was: Instability with signals and threads)
Message-ID: <20141128201300.GP3810@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <alpine.DEB.2.02.1411202055420.8559@artax.karlin.mff.cuni.cz> <alpine.DEB.2.02.1411211451420.108656@artax.karlin.mff.cuni.cz> <20141121144333.GA6633@calimero.vinschen.de> <546F5F37.9010509@gmail.com> <20141121160608.GF3810@calimero.vinschen.de> <546F9B5E.80707@cygwin.com> <20141121203628.GA17637@calimero.vinschen.de> <5478C44E.5040903@cygwin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;	protocol="application/pgp-signature"; boundary="dsOl/BEZn+65LpCE"
Content-Disposition: inline
In-Reply-To: <5478C44E.5040903@cygwin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2014-q4/txt/msg00017.txt.bz2


--dsOl/BEZn+65LpCE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 475

On Nov 28 12:51, Yaakov Selkowitz wrote:
> 2014-11-28  Yaakov Selkowitz  <yselkowitz@...>
>=20
> 	* Makefile.in (XSLTPROC): Remove.
> 	(cygwin-ug-net/cygwin-ug-net.pdf): Build with xmlto pdf.
> 	(cygwin-api/cygwin-api.pdf): Ditto.
> 	(faq/faq.html): Fix extraneous anchor removal.

Looks good.  Please apply.


Thanks,
Corinna


--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--dsOl/BEZn+65LpCE
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUeNdMAAoJEPU2Bp2uRE+gQWIP/jPE97Nw/wIofJuXliyt5UKZ
amZ1wI/jvHyLtf5ok+iSfn95LOJ1CcAgvDTmvX1AdvuBYoxnanGh5kW/VGJqsfkE
xfi0uhnFOD5J18EN2Ne9LqRCiCVwNrkG1dm/4vucLilw1rzxgQVgyOOzWJPeCCYV
p2lwSw2s32opfnQJGwl8e9d6L8Bk/S6HWu9tPILBgbTPiWfGlChNv7ncpC9puSjj
L52TBL5DQs9mozhP1jtE2n0XLg0DEVsXlmpG5WypTOF5KG8tsZUTYzoDKR5kxppP
X98D6mIml/lxU7ogr2ZK4LInHsA3XCT7DdPl0FEZwYJ1B8116wFov/TtZ/NLKyHM
m6fL3xpgHdaIXkXH+RmDl8g1IrtEARgvG3ciWZoT3BgYghtcyAzPakBTKxAzTA+1
ib9x/uaa4ILNmIWKSSymlUb9dyr3DIYmzkYoAxTxW3WcN3PEVGRXeWHrsIUTICUG
Otu5DMAon4YfXfw65EDV7xIRemSOwl/wONIQb4g1ByXjEbbV1UD/NCvTpiBsV6dG
njmsi0Id5/Fw1yA/tqt1Ofwyzo8lZiAXztOLcLIVcSm2biKSLADPg12+us6SiutN
pS8iufgPFA8cN/F+Nf6hkQtt0hp7ajPSxnNvQ90Ha78ALEv8Ey1oRF4LCqQsw8X4
huFKvsFMQHDfVy0WQD63
=eQ2S
-----END PGP SIGNATURE-----

--dsOl/BEZn+65LpCE--
