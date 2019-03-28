Return-Path: <cygwin-patches-return-9266-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27812 invoked by alias); 28 Mar 2019 20:31:01 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 27803 invoked by uid 89); 28 Mar 2019 20:31:01 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-104.3 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*F:D*cygwin.com
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.187) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 28 Mar 2019 20:31:00 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MSss2-1hXH6l1u2Q-00UH1B for <cygwin-patches@cygwin.com>; Thu, 28 Mar 2019 21:30:57 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id AD66AA8054D; Thu, 28 Mar 2019 21:30:56 +0100 (CET)
Date: Thu, 28 Mar 2019 20:31:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH RFC] fork: reduce chances for "address space is already occupied" errors
Message-ID: <20190328203056.GB4096@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <8c77b589-fcae-fd0d-f5c5-c2520cfebbfa@ssi-schaefer.com> <20190326182538.GA4096@calimero.vinschen.de> <20190326182824.GB4096@calimero.vinschen.de> <c52ec077-d1e6-f61a-df9c-fe9ede1ba1ff@ssi-schaefer.com> <20190327091640.GE4096@calimero.vinschen.de> <b22069db-a300-56f7-33dd-30a1adbc0c93@ssi-schaefer.com> <678d8ec4-f6c2-1538-aafd-dbb9cfc5dea5@ssi-schaefer.com> <20190328095818.GP4096@calimero.vinschen.de> <fd7b9ab3-ca07-0c80-04da-4f6b2f20d49e@ssi-schaefer.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="LbN0412894TjpI52"
Content-Disposition: inline
In-Reply-To: <fd7b9ab3-ca07-0c80-04da-4f6b2f20d49e@ssi-schaefer.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q1/txt/msg00076.txt.bz2


--LbN0412894TjpI52
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1450

Michael,

On Mar 28 12:48, Michael Haubenwallner wrote:
> On 3/28/19 10:58 AM, Corinna Vinschen wrote:
> > On Mar 28 10:17, Michael Haubenwallner wrote:
> >> As it is not some other dll being loaded at the colliding adress: any
> >> idea how to find out _what_ is allocated there (in the forked child),
> >> to find out whether we can reserve these areas even more early?
> >=20
> > I'm not sure what addresses you're talking about ATM.  The addresses in
> > the 0x4:00000000 - 0x6:00000000 range?
>=20
> No, I'm thinking about the lower address that collides after relocation,
> if there is some cygwin allocated object we may allocate later...
>=20
> > These are the interesting ones.
> > The relocation to some random low address should only occur if there's
> > a collision in this range.
>=20
> This should be easier to find out (by inspecting the loaded dlls).

can you please collect the base addresses of all DLLs generated during
the build, plus their size and make a sorted list?  It would be
interesting to know if the hash algorithm in ld is actually as bad
as I conjecture.

If we can improve on the distribution within the 8 Gigs area by changing
ld's address generation(*), we may improve situations like these without
too much hassle.  As always, not a foolproof way out, but heck, 8 Gigs
is a lot of space for a couple 100 DLLs.


Corinna

(*) Maybe even a RNG is better than a hash here...

--=20
Corinna Vinschen
Cygwin Maintainer

--LbN0412894TjpI52
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlydLwAACgkQ9TYGna5E
T6D+hxAAlA7NRIwR0dxl8PKYkpbLXsu3SP3zYx2a3EdhVwCphUuBOCS4qXoC56S/
uu+kVLXIE6GGgSTZoKK1zrpz3RCsJeetweGuRZY7HLnQopDKtl+li+ltYzwB/ZBs
/dc5Iu0TbczN8vTpkVQ/PyGly7nsF7O0Vzl0BcqXfQdTyJed5/RTXbCwZUvQVxZy
/K8U8crooEU98XzGorgoljco1LR3tOeRq7CVKItj2odko9G9FJu7B1w8DS7Q/c0f
MHHzqXXQ9wobIhJ51/wFUUlyLYLPpTlyexy1ZJp/ffRqBqf87HwMtoZ93l5yiBPJ
Lgcr0AIB4biyOKBHuBA+6vSB85TijcOBhWgFj5o25yUI2zACIMk7/4FSpdFAwz2P
2hLao7cz+UTe5R2smvzKMLg2F8Tjet7+THAY0M2sBZ7WuG9odA0vh8VLs0yeIwQG
RoJZTU2nyibfhiN/27Q91wP0+lBKmenlpYdoGZBEHFAr2ca1m8oAY1O8+/pq0sv2
OVBCiiMlB+G3vNkCwmLHdL2PrsedF002i52vMSekeM8UP1NjLwT7gf2+EOA8lAC6
voICu44Jx2HShvIuqyQJESxhA0ausqfUhNkt/X7cZEy8KQDDVHqSSwz2IG4l99GA
PKbsy4B5P9zePc5kxgWiZBWFCL9QV7CVSUBsTTVjblpo6OTmyZ4=
=esHZ
-----END PGP SIGNATURE-----

--LbN0412894TjpI52--
