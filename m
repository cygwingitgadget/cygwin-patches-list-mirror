Return-Path: <cygwin-patches-return-8343-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32135 invoked by alias); 19 Feb 2016 10:47:14 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 32119 invoked by uid 89); 19 Feb 2016 10:47:13 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-96.6 required=5.0 tests=BAYES_00,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC,USER_IN_WHITELIST autolearn=no version=3.3.2 spammy=HX-Envelope-From:sk:corinna, H*R:U*cygwin-patches, H*F:U*corinna-cygwin, completing
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 19 Feb 2016 10:47:12 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id BB0B1A80306; Fri, 19 Feb 2016 11:47:10 +0100 (CET)
Date: Fri, 19 Feb 2016 10:47:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: gprof profiling of multi-threaded Cygwin programs
Message-ID: <20160219104710.GB5574@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <56C404FF.502@maxrnd.com> <20160217104241.GA31536@calimero.vinschen.de> <Pine.BSF.4.63.1602172218120.19332@m0.truegem.net> <20160218104125.GB8575@calimero.vinschen.de> <Pine.BSF.4.63.1602181654480.11717@m0.truegem.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="61jdw2sOBCFtR2d/"
Content-Disposition: inline
In-Reply-To: <Pine.BSF.4.63.1602181654480.11717@m0.truegem.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q1/txt/msg00049.txt.bz2


--61jdw2sOBCFtR2d/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1008

On Feb 18 16:57, Mark Geisert wrote:
> On Thu, 18 Feb 2016, Corinna Vinschen wrote:
> >On Feb 17 22:35, Mark Geisert wrote:
> >>I do see that a case could be made for general profiling documentation =
in
> >>winsup/doc/programming.xml but that's more than I want to take on at the
> >>moment.
> >
> >It doesn't have to be part of the source patch.  It would just be nice
> >if you could write a few words about profiling.  I'm *not* asking for
> >a complete gprof doc or somehting like that, it's safe to assume that
> >the users of the tool know how to read man or info pages.  Therefore,
> >something short like gcc.xml or gdb.xml would be totally sufficient.
> >Even shorter than those.  Just a few words about profiling in general,
> >and an example would be cool.
>=20
> Ah, OK.  That I can/will do after completing the source patch.

Thank you!


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--61jdw2sOBCFtR2d/
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWxvKuAAoJEPU2Bp2uRE+gRRkQAIoBosHS13cao5LphRdhTwbK
L3r5dv29fuUYG7x6MnT2eTWydtwmPEdPlAsUvwZ2gevBPnk+FEKR1QxAG8A6GU5x
YI8esCyjus3sXt/YeG8MCkSdIc4LtQcHIHsaE7cfSmbS0IqjBLLhmexiJvK7TPPD
rew3mnLZAvK7mI03s/ZbOYsPgeU5hW9v8h1kb6Af49DkpuSVSn7wf70XZZkmWCQg
WOoXDb+6gOKGPIjcZZLuHEn+ZhUQj/aRRf8SLijpllgySPgBrQ37jwY5hOL3cIaz
NHjii7PiF3doSznO1UAFQFR2k5paoDlaTp1zdLzYqQ1oSp/S/qls0uHJFgFSBxwP
7vRdDAwBb5WJWpXjDb77Lyp1OgLwXGeFHuuq/qT+B0fNpSfmWDRjwNGlsQiz2EFg
2OndRGQOLlvzuQgtc3luJ2AgaGoB1Q93XW6f70T7v+C1AAA/YdXjN0432QmZRWKa
cwdoweEusISrsGzfuvA99yHU1B8zhWzzG7Cv4u+WQicUP0itJ53Xb4ZsKwsCzKnj
7W+d8yj0qnd9QNUHWKObTLbGlBr6hEebTuB096Ik6Ov80/azpmr8LNkDmNOoTTmC
SxBSEbGaKZ7yhhF7tpBMkX435/ty4/WCwP/+8wGwsYuw/TVOLiwDxaWnPEBCXuCu
zSe1AKMhrzT0M1jZ7i7w
=T9xJ
-----END PGP SIGNATURE-----

--61jdw2sOBCFtR2d/--
