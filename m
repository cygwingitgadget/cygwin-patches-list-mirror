Return-Path: <cygwin-patches-return-8122-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 101393 invoked by alias); 7 Apr 2015 10:17:13 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 101377 invoked by uid 89); 7 Apr 2015 10:17:12 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.4 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 07 Apr 2015 10:17:11 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 3A22DA80A4C; Tue,  7 Apr 2015 12:17:09 +0200 (CEST)
Date: Tue, 07 Apr 2015 10:17:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 2/3] Provide ucontext to signal handlers
Message-ID: <20150407101709.GA31073@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1427894373-2576-1-git-send-email-jon.turney@dronecode.org.uk> <1427894373-2576-3-git-send-email-jon.turney@dronecode.org.uk> <20150401142219.GY13285@calimero.vinschen.de> <551F0FA2.2020304@dronecode.org.uk> <20150404084014.GW13285@calimero.vinschen.de> <55200BFB.4070303@dronecode.org.uk> <552169BB.4050507@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;	protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Content-Disposition: inline
In-Reply-To: <552169BB.4050507@dronecode.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q2/txt/msg00023.txt.bz2


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 611

On Apr  5 17:58, Jon TURNEY wrote:
> On 04/04/2015 17:06, Jon TURNEY wrote:
> >On 04/04/2015 09:40, Corinna Vinschen wrote:
> >>So, what if we drop all the -fomit-frame-pointer from Makefile.in and
> >>add an
> >>
> >>   exceptions_CFLAGS:=3D-fno-omit-frame-pointer
> >>
> >>Does that help?
> >
> >Yes, that seems to do the trick.  Patch attached.
>=20
> Aargh.  Some of these things are not like the others.  Let's try that
> again...

Thanks, applied.


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVI66lAAoJEPU2Bp2uRE+gR9EP/1F3c9EwtBnezdIFkHmmiw8w
kPyFbo6xBdHH8m5JkxxolrVzJLskkSjRpTd3ihtI9ig/M4RuegfP2EsFVBF++np2
8OaMQWHCY9GcxkGMOIqZsa7+Edn6uyHVG9Mjwz9BBJUBgrtaAH6Pfj1SM2X6R+nY
s0vstfaCTPKmq58bDHVQzvPHdcRRmM2eebt7ti0igrovh2rJHhSL/z2V0ShEY5nr
F/NSwpLevGgeQZzKbEm6NdcPAiifgebqkozsAB9TUUN2K7WcHNfU1tTWpaxTdPUs
PpLUfQr3awz5XAsHi+8/dnTnGD4jPkJU9o+5hMREZNP2gKrsZwbGD5enRPo9seWh
b7KGDFcwWFtEIYC8ArYhog520nw2ecFmLkE+EPhB7n79HzScWYkswRVcOVuQG3LV
EHAF8bgD8yy5IK0dw/gZP0Lg5dodvyIZfN8ZSZ3FNwH8Guu2Ji4SYGJzGq6mj38B
vBH1/jX3y/dEU8XMojfvyjjHXYEKJdN6oEsuxH0ZCAj5aoJIqQrsFNaldZcqYuHm
PUgj8Y2pVbCSujEBWNmKI8LcJul+FaMKL9uu0pg3jxsIluMVnMxzm3Pw70PY5ARy
H9ZPXWdjYne6GLZo+qgVy8LYlQz4qSuOuCfnrcfOUMyVER/dk+5BsnVfObDOKwbR
FSbRj8eifaA5Zw8Tau83
=KHv4
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--
