Return-Path: <cygwin-patches-return-8489-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 37485 invoked by alias); 23 Mar 2016 11:07:49 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 37423 invoked by uid 89); 23 Mar 2016 11:07:46 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-6.6 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC autolearn=ham version=3.3.2 spammy=Hx-languages-length:1166, H*R:D*cygwin.com, HTo:U*cygwin-patches, H*Ad:U*cygwin-patches
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 23 Mar 2016 11:07:35 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 5C6A9A80643; Wed, 23 Mar 2016 12:07:33 +0100 (CET)
Date: Wed, 23 Mar 2016 11:07:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 09/11] Add c++14 sized deallocation operator
Message-ID: <20160323110733.GS14892@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1458409557-13156-1-git-send-email-pefoley2@pefoley.com> <1458409557-13156-9-git-send-email-pefoley2@pefoley.com> <20160320112837.GO25241@calimero.vinschen.de> <CAOFdcFPP79BaO=KTpF5oB3ewdYCh6GmfaxoJr03kKY7dSOjrKw@mail.gmail.com> <20160321171314.GA14892@calimero.vinschen.de> <CAOFdcFM1D17HSiLdeNv=S6zim6wOcqY41Ud-iTtiDLrN_YRYOg@mail.gmail.com> <20160321180903.GB14892@calimero.vinschen.de> <CAOFdcFN4wkv40M-BJPhhHwjaDxh7YD7iXDhLaUcnW6qw=pwnYg@mail.gmail.com> <20160321195524.GK14892@calimero.vinschen.de> <CAOFdcFOSdpT3Bi=dne+8MQc82Oyio5atpeDF-W7yUMn-mhR3ew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="/KohU7xR/z4Rz7fl"
Content-Disposition: inline
In-Reply-To: <CAOFdcFOSdpT3Bi=dne+8MQc82Oyio5atpeDF-W7yUMn-mhR3ew@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q1/txt/msg00195.txt.bz2


--/KohU7xR/z4Rz7fl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1156

On Mar 21 16:03, Peter Foley wrote:
> On Mon, Mar 21, 2016 at 3:55 PM, Corinna Vinschen
> <corinna-cygwin@cygwin.com> wrote:
> > But using -std=3D when building Cygwin wouldn't change the fact that we
> > might need this delete anyway for applications built with -std=3Dc++14
> > or do I miss something?
>=20
> This patch is specifically for building cygwin1.dll
> I haven't tested building programs with -std=3Dc++14, but that should
> not be affected at all by this patch.
> I believe the only reason this issue occurs at all is that cygwin1.dll
> explicitly does not link with libstdc++.

I applied the original patch and added a diagnostic pragma to disable
the warning for now.

We definitely have keep in mind that we might have to export this
function at one point for C++14 applications playing dirty tricks.
I seriously wonder if we shoudn't do this proactively.  Again, see
https://cygwin.com/ml/cygwin-patches/2009-q3/msg00010.html for the
reasdon to export the functions at all.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--/KohU7xR/z4Rz7fl
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW8nj1AAoJEPU2Bp2uRE+gIm8P/1qNfwT5UWK5f/kR0yI5Gohs
TK3ZmAikTbzBPVpXxN2WQ9Hwn9hkGPz7wp1euL47xi8CSxjNMj8z57jC1v3jpUU6
21ewUxi78u9JVAY+ICsEg892Ryv860ctYXo3K6BuDAm1k1YmRA0dAi8/Ink6awIx
f1wI9GIXYHzK0wbfsgK7QB2Jxsx1VgSQ6qPZn/gOeMqpcf78bhLuRSRSFNLNUPUa
itzO4CpP/lDa7cM7Fl57VKJBNtglor1kV7CNa0D5xLAmgIAXRv6pH4yVzsVhRk6m
2k94t5AXqCGKRPQqf7vWsOVQBSuTMSyd5NjHbe3nVDtvs51eCT+Pb2fQVFtnun8B
i48J9IN0gUrurw3Q83AcuzvLkpHwGeeLU4V41bGcl4Jm8RqFxhuyjvTzWzOFHgt5
9U1pk0LLvSiltrFzc43lCxq1jnHixWHEscMWMQNykxSRN14yIUfFrNPhVw4MAE9j
fwmxEq05O6MY8qePzVcAWzBcD5Im/tjWQ0BGAzE4KNs+8LO6LKusC+Rb2S/Pbgx+
leLn8oonvpy7w2Y28GPj2Aoq+06HL7o104MZr4DRU/O9AlOs8YjuV6Ajg5aVdhAC
M3JpxoTHKC7J8rKZuurdNrljmP5V3gjp8h5NmzjhWapaD8XOrxUGRIDkQXozpNAx
o7FGpGaOVMNxOgXKOyHt
=0YJU
-----END PGP SIGNATURE-----

--/KohU7xR/z4Rz7fl--
