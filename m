Return-Path: <cygwin-patches-return-8059-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4394 invoked by alias); 19 Feb 2015 13:23:44 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 3613 invoked by uid 89); 19 Feb 2015 13:23:43 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.9 required=5.0 tests=AWL,BAYES_00 autolearn=ham version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 19 Feb 2015 13:23:42 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 19421A80BED; Thu, 19 Feb 2015 14:23:40 +0100 (CET)
Date: Thu, 19 Feb 2015 13:23:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Prototype initstate() etc. if _XOPEN_SOURCE is defined appropriately
Message-ID: <20150219132340.GH26084@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <52838E8C.5060708@dronecode.org.uk> <54E5DE55.90603@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;	protocol="application/pgp-signature"; boundary="JkW1gnuWHDypiMFO"
Content-Disposition: inline
In-Reply-To: <54E5DE55.90603@dronecode.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q1/txt/msg00014.txt.bz2


--JkW1gnuWHDypiMFO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 451

Hi Jon,

On Feb 19 13:00, Jon TURNEY wrote:
> 	* include/cygwin/stdlib.h (initstate, random, setstate, srandom):
> 	Check if __XSI_VISIBLE is set by sys/cdefs.h, rather than testing
> 	for _XOPEN_SOURCE directly, to work correctly when _GNU_SOURCE is
> 	set.

Looks good, please apply.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--JkW1gnuWHDypiMFO
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJU5ePcAAoJEPU2Bp2uRE+gRIMP/j8EPkQ1VqJIzjk2FLhtue5L
ATsNeXE3r8qcl1jhj0IgHVsiusfabwr3flqc3fAtc9ElstaE6LfgiuaB9jMOHhWd
/HLUehUeBXAIdz7P7UAp/0brvKnkW8JuUTCpcvEVIUJ+fT1e9pIJepV/c+aJrONG
mHxEAuXv6sBagjOHZmK6aoatBduEWiKzDwwg/iSWN1k/x2RxaZFueGjF43eOlvpf
bjLwOdryQceFt5rDT0rpZrIw7/A3hI6Gu7kC9QJ4j2XXa1qlu6JfzWQzmv3jNTLM
3oC/WpHZ25/1nj7Y16/BYUa2RT0U/8ejWFTX2cXljk55E8PlPxVfigHBr07/Od1T
hXPS+QpnyXb3oIh7XnzmM1aAJWJI79rj4gQBp8BtHhcOoL0lvSyzHL8cHsBFdUdW
4EpuNy6yv0w7XBxhrBdUM/QB02F511ok0AY8/5vAqVDIsWMOG8PTvpAZAoxhzuPy
ZEdTZRuVVUDs2wMIV9JArvCW4J3FgZv2ZuTiiXxbkODrlI50v/u+7PGOQAMqj7PU
d5G/plM2qRJZ+p8x494Qb9w4ujO58vvg1WzTmfIklKlv1f/We8KbRnCebXTkOgMt
xM122CgXO0Yp8asJXKV72smJBWwPrG+m3Pz4Dvk2E0hDAUiVKmVbEdE2lECVmG3N
hcX9JJHJ/HhBBJyz/9a7
=N0iZ
-----END PGP SIGNATURE-----

--JkW1gnuWHDypiMFO--
