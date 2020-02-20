Return-Path: <cygwin-patches-return-10096-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 116821 invoked by alias); 20 Feb 2020 16:38:09 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 116723 invoked by uid 89); 20 Feb 2020 16:38:09 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-106.8 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (217.72.192.74) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 20 Feb 2020 16:38:07 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MnJdC-1jlXVB0taG-00jJ8I for <cygwin-patches@cygwin.com>; Thu, 20 Feb 2020 17:38:05 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id B00A0A8086E; Thu, 20 Feb 2020 17:38:04 +0100 (CET)
Date: Thu, 20 Feb 2020 16:38:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Ignore 0x00 on write().
Message-ID: <20200220163804.GW4092@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200220115145.2033-1-takashi.yano@nifty.ne.jp> <20200220133531.GR4092@calimero.vinschen.de> <20200220134459.GS4092@calimero.vinschen.de> <20200220231312.8d7f478d578970fca29098bf@nifty.ne.jp> <20200220142245.GU4092@calimero.vinschen.de> <20200220234943.2d3bf6ca40d95166a5960051@nifty.ne.jp> <20200220160401.GV4092@calimero.vinschen.de> <db2b11d3-8499-55be-5384-8d6c623138f0@towo.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="rKoHqF+aPLVth8b2"
Content-Disposition: inline
In-Reply-To: <db2b11d3-8499-55be-5384-8d6c623138f0@towo.net>
X-SW-Source: 2020-q1/txt/msg00202.txt


--rKoHqF+aPLVth8b2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1916

On Feb 20 17:22, Thomas Wolff wrote:
> On 20.02.2020 17:04, Corinna Vinschen wrote:
> > On Feb 20 23:49, Takashi Yano wrote:
> > > On Thu, 20 Feb 2020 15:22:45 +0100
> > > Corinna Vinschen wrote:
> > > > On Feb 20 23:13, Takashi Yano wrote:
> > > > > On Thu, 20 Feb 2020 14:44:59 +0100
> > > > > Corinna Vinschen wrote:
> > > > > > But, here's a question: Why do we move the cursor to the right =
at all?
> > > > > > I assume this is compatible with legacy mode, right?
> > > > > Hmm. This may be a bug of legacy console.
> > > > > https://en.wikipedia.org/wiki/Null_character
> > > > > says
> > > > > (some terminals, however, incorrectly display it as space)
> > > > >=20
> > > > > What about ignoring NUL in legacy mode too?
> > > > I'd like that, but this may be a problem in terms of backward
> > > > compatibility.  The behaviour is so old, it actually precedes even =
the
> > > > import of Cygwin code into the original CVS repository, 20 years ag=
o...
> > > If so, can't we say it is the *specification* of TERM=3Dcygwin
> > > that NUL moves the cursor right?
> > Good point.  Yes, in that case it's "working as designed" and
> > we just leave it as is.  I push my patch.
> See `man 5 terminfo`: if NUL does anything else than just padding, the
> terminfo entry must contain a pad or npc entry, which it doesn't.
> Trouble to be expected. I'd rather suggest to align the design with
> applications' expectations.

Is that the cygwin terminfo or the xterm terminfo you're talking about?

In case of the cygwin terminfo, that would mean the cygwin terminal
emulation behaves differently from the terminfo for ages.  I guess
you're right then, we should fix this in the cygwin terminal emulation
to make sure it behaves as descibed in its terminfo.

In case of the xterm terminfo, that would be no problem because my patch
drops the cursor movement for NUL.


Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--rKoHqF+aPLVth8b2
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl5OtewACgkQ9TYGna5E
T6DMKA/+PWFbOZA/WX3ddx/yKN0TTsBYZLs+ZRmDi9sMMZ7HQt/Xzp/Qncw4YHd1
K9qY1S38QZg5Emy2edNtqPhIY/FD0CKZd5RNah8S7kwr7qCg6HaST1b7Q1ZJI8BD
yi4Q63HzcUs6qC/dl3j9o9FUCYJXkYAr/cp4CtKnTDBkA9U1zQlZz/DGh7gwKfs1
v+qxUXxnkIJWH+ROYVWtM2aiOkuUAx4wkAn8jkSh/EBPHH2nE6s2YG1RlH3CHHkQ
sfPe9BCmrJLf95a+Gzr5qcLQYPOcpEREUmK0rCprVDsD5mGO3AUJ82m3QrpBe0Cl
untK+xZkX2K+gsX3S6KSbc+AcwRM19rEzlJWYI55BZdN4+yBFiRdZzGoKauO7hrc
0tVDGoQAc96QNs98rxEhACtlgy72eD2iJLK5AA5TRW4OQ3t/Qq+WiZzQfXmQwSJM
eWa200ETbFPYgG5KDfpvsF2ZAkaqVQWIL7Un5uqYIsR5N14g18WsRgkA7tWkLLfJ
5F3FF61sK0GyXx4qkegcN85oCp8EwFBLYSQ6ccZ5Vrj4agq4ZX0hSOT8HjuGl+SA
uih5BZeXEs5AEDyZjdh6qHzx9VPqmOpOymkVbGNnXz4eyCHK9vGgTf0Z7rvUJ/UU
E5VTrGHw6C5la1EUm6H8YHxFeJzkriWCOgvj3NaRlR3eppJCWjQ=
=IXwq
-----END PGP SIGNATURE-----

--rKoHqF+aPLVth8b2--
