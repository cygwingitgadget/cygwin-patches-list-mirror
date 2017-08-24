Return-Path: <cygwin-patches-return-8832-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25188 invoked by alias); 19 Aug 2017 17:51:46 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 25172 invoked by uid 89); 19 Aug 2017 17:51:45 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-101.9 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=Attached, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches, H*c:application
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 19 Aug 2017 17:51:44 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id 0EA1D71AF28C1	for <cygwin-patches@cygwin.com>; Sat, 19 Aug 2017 19:51:42 +0200 (CEST)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id 6C10D5E01D4	for <cygwin-patches@cygwin.com>; Sat, 19 Aug 2017 19:51:41 +0200 (CEST)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 51B43A805F0; Sat, 19 Aug 2017 19:51:41 +0200 (CEST)
Date: Thu, 24 Aug 2017 09:27:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: renameat2
Message-ID: <20170819175141.GC16422@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <992f81ea-736b-ebe3-2177-153b4d2e1852@cornell.edu> <20170818151525.GA6314@calimero.vinschen.de> <f7e3cc27-6989-54d8-8e3e-c11cdd5dfeca@cornell.edu> <20170819095707.GE6314@calimero.vinschen.de> <68b3c713-3261-e9d7-0865-384d18553744@cornell.edu> <20170819162828.GF6314@calimero.vinschen.de> <cf284aed-c86a-b9ac-cff1-cef6477b7e32@cornell.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="Y5rl02BVI9TCfPar"
Content-Disposition: inline
In-Reply-To: <cf284aed-c86a-b9ac-cff1-cef6477b7e32@cornell.edu>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-SW-Source: 2017-q3/txt/msg00034.txt.bz2


--Y5rl02BVI9TCfPar
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 344

On Aug 19 13:24, Ken Brown wrote:
> On 8/19/2017 12:28 PM, Corinna Vinschen wrote:
> > Doc changes coming? :)
>=20
> Attached.

Pushed.  I also generated new developer snapshots.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--Y5rl02BVI9TCfPar
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZmHqtAAoJEPU2Bp2uRE+gKS8QAImckElDh3RsofrAUno/BbO0
D8xX5q46EJF92txIr0Yb3r55N1XOYtzWS3R7RptSMD/kKkc6MSEuvVxj2p+7gYq6
gQefIDl1neLsHtEE9INytC1N8PNkO0jqcRPg9m5gzsu7LZCwn4aoCgPh3oEy0mWC
rNe2np1cRFHaka6FDBW6xoygBbnr9pwWFnKgP4kQ1Tq+AeA1op9iCto/FlWs4/jl
UEh5gztVRCx9rQTYorYXbYKzl59luHN132Th4FwGGdvENcKggLM1fWb+MnFabOwV
vOiZZ7CR4t07wF3xn8cZlZl0WL7v1guEjGzbTV3JNG/D+4qy4yQY/6Osqvj5wegA
+1qau5Ag8r6WzN7SqkuJx4HsH3rQ5FP0OH/jYhN93+Qyh99WJg4pll/sVzuimpra
2JS+Q3/hwC+YZhAq9xjwvMYiyTZesrG7crK/RUURGLkM2FwP/eawRPJEJO+hanAD
H5aC829MVVCf/wqhoaShEVOP4JL4QLj8Vf3wg3TkP1YzomCEA/+UrE9Tzj/Qyfbq
/kfj2ANLklCt7BZ0UhXGpcTzBAQvfS2rD+tsxhjh7+v4Q6YtmP5t6VhC4Y5xq3xI
zZ9Ry4QoYaaR7WoeZDJ2QWieaeqCe+jEdzRG2gt+ax/oCrj1QVJVCfG9cAkT5mS2
Euq02zxc9zr2ezajBdb/
=hkUD
-----END PGP SIGNATURE-----

--Y5rl02BVI9TCfPar--
