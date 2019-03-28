Return-Path: <cygwin-patches-return-9254-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 98281 invoked by alias); 28 Mar 2019 09:58:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 98021 invoked by uid 89); 28 Mar 2019 09:58:23 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-105.0 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*F:D*cygwin.com
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (217.72.192.73) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 28 Mar 2019 09:58:21 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id 1M5gAG-1h3MzA3Tys-007HkI for <cygwin-patches@cygwin.com>; Thu, 28 Mar 2019 10:58:18 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 38EA9A8057D; Thu, 28 Mar 2019 10:58:18 +0100 (CET)
Date: Thu, 28 Mar 2019 09:58:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH RFC] fork: reduce chances for "address space is already occupied" errors
Message-ID: <20190328095818.GP4096@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <8c77b589-fcae-fd0d-f5c5-c2520cfebbfa@ssi-schaefer.com> <20190326182538.GA4096@calimero.vinschen.de> <20190326182824.GB4096@calimero.vinschen.de> <c52ec077-d1e6-f61a-df9c-fe9ede1ba1ff@ssi-schaefer.com> <20190327091640.GE4096@calimero.vinschen.de> <b22069db-a300-56f7-33dd-30a1adbc0c93@ssi-schaefer.com> <678d8ec4-f6c2-1538-aafd-dbb9cfc5dea5@ssi-schaefer.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="E6lVPAHcXg6biC3t"
Content-Disposition: inline
In-Reply-To: <678d8ec4-f6c2-1538-aafd-dbb9cfc5dea5@ssi-schaefer.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q1/txt/msg00064.txt.bz2


--E6lVPAHcXg6biC3t
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 770

On Mar 28 10:17, Michael Haubenwallner wrote:
> As it is not some other dll being loaded at the colliding adress: any
> idea how to find out _what_ is allocated there (in the forked child),
> to find out whether we can reserve these areas even more early?

I'm not sure what addresses you're talking about ATM.  The addresses in
the 0x4:00000000 - 0x6:00000000 range?  These are the interesting ones.
The relocation to some random low address should only occur if there's
a collision in this range.

I'm not quite sure how to find out what happens, unless you stop the
process in reserve_space and inspect the memory layout with sysinternal's
vmmap tool:

https://docs.microsoft.com/en-us/sysinternals/downloads/vmmap


Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--E6lVPAHcXg6biC3t
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlycmroACgkQ9TYGna5E
T6BYUw/7B3ecxFywNr87yCYIuF986ST8L4G/ay3iC6BF7w3y2RX6tUyxxtCQWEcV
0XFfwGFI8s2dzYdtn4kJmN8eyBohdmh5Gthp7Oz0btljOoOeAuvG2Q7DH7xy3wLK
UWdMc3IFqcC0CIUHr7+51c2LWsYigaY59/jKE1Iauc1SyOECSXJR7lYkACv2mx4J
4dJStnwLbPvwf7YVtHe1XNkWhGPOKxHRlUs9JkcWb+hkCjRmg6rJdF4gNgatMXiP
tRT4qMVsP7kP6KsBhk/3D6cBM4NBIO9p3fGH9bkhR3vEfibRPwLHej4NrdeFZNFi
oVhb4rSFyj8SUAxfvafsZ5qGIsEou9vy8teQyd8fU5j4dJTz8WIXKNoL4Eo51UmP
rSEFWqiXxinNFBi7MG423STExXBZ1MdM8cQqhouZlPaanM86PqQ61ubIDL/NtQGY
GLOV05ev+TeAPBIpSEV+7Ga7CJTe0qyMG6T8NXFnjVC0+I+fguLHJIIECt6sfnjm
LvwxcPBbfRhR+4uaZB0rIAzjQtQhU8kBkBZ9pPA92WDolWu7GZnbHdHpFXRlSxR/
+6bpYI/L4kPkzWhyEhgOO2kLBqTA5HE/Q/kqZyhQ6o97gQTHYl6tvfORwjncEOW2
2kA8AdwH87uTNTSvVxjmqudyM+W8jtUVUK3vLa9fSes0N8FLfjc=
=dFfZ
-----END PGP SIGNATURE-----

--E6lVPAHcXg6biC3t--
