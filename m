Return-Path: <cygwin-patches-return-8458-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 66975 invoked by alias); 21 Mar 2016 19:25:03 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 66960 invoked by uid 89); 21 Mar 2016 19:25:02 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-6.6 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC autolearn=ham version=3.3.2 spammy=H*R:D*cygwin.com, HTo:U*cygwin-patches, H*Ad:U*cygwin-patches
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 21 Mar 2016 19:24:52 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 7E6B2A803F7; Mon, 21 Mar 2016 20:24:50 +0100 (CET)
Date: Mon, 21 Mar 2016 19:25:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 2/5] Link against libdnsapi to avoid undefined reference
Message-ID: <20160321192450.GD14892@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1458580546-14484-1-git-send-email-pefoley2@pefoley.com> <1458580546-14484-2-git-send-email-pefoley2@pefoley.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="7DO5AaGCk89r4vaK"
Content-Disposition: inline
In-Reply-To: <1458580546-14484-2-git-send-email-pefoley2@pefoley.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q1/txt/msg00164.txt.bz2


--7DO5AaGCk89r4vaK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 541

On Mar 21 13:15, Peter Foley wrote:
> /home/peter/cross/src/cygwin/winsup/cygwin/libc/minires-os-if.c:289:
> undefined reference to `DnsFree'
>=20
> winsup/cygwin/ChangeLog
> Makefile.in: Add libdnsapi to DLL_IMPORTS

Apart from the fact that this is wrong and DnsFree should be added to
autoload.cc instead, what exactly is that patch fixing?  DnsFree isn't
used anywhere in Cygwin.


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--7DO5AaGCk89r4vaK
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW8EqCAAoJEPU2Bp2uRE+gdnwP/1kaiFXwLM5m8ytV5aMVccjl
aSZWohgk3IS/IdlgDOJQpLXTiN4Dx2n4kpxzdHwvIKmSsnUKYMLL9zAhWGTPgUJJ
gq42A4zRCvr4Dgw0prCa0YRu5WpKlXh07mgfzAh4bFiiwpWLV816y3csLBmD9Nxv
NejxzoXVEHMoobjaAVYHTfo7lUElR8synfamAoVGnnjfxJLfpM05DbaCSV0EJDGd
JtdRXZbRmhEiqoBVufl3tMQkb7U9UQnk/YLr7k7z3mQutxMt95fane/8llHinu6C
T3Vwh0OWpW3l3kTJNCSpBdMhXUBsLxzT7VJSgIMdT0uoCDpudrBeoD8W/szwRlqk
yLBqgs6rKxoi3zvlqXpun+8ZroPmEdvDNmffbA3Wm3VVVK8dQ00X+kJtwmrkTcGm
HRscNXVTAUW2Qovbt3g/2+lS/nOaQJz+lHIk1AUoC1DHUYs6vGQ4Amme1f47EY1x
TBsSociUn32DqV5z/H7PchiGzx00ccUVRVdTUHeK4CGjAJkvjg+KF2kcRvt1eV9v
f9s/B6tqH/JM4iK4yPE4EtASv69/ylvfDw201Xh34n4zCx8rsrn4RRxamy2Kizs6
JQW2/hN7QwvESdTOjbxxrZ7dv9psjTpKwZi3sqRygpOlMnH8rwRjtEHtMbET8UtS
kRd8pgdp3qhbAHr87ZuX
=AeNB
-----END PGP SIGNATURE-----

--7DO5AaGCk89r4vaK--
