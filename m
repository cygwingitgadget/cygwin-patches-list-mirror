Return-Path: <cygwin-patches-return-9421-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 85996 invoked by alias); 3 Jun 2019 16:35:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 85986 invoked by uid 89); 3 Jun 2019 16:35:23 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-101.9 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=crazy, UNIX, overlooked, H*F:D*cygwin.com
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.135) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 03 Jun 2019 16:35:22 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MnJdE-1gouL609pc-00jH3n for <cygwin-patches@cygwin.com>; Mon, 03 Jun 2019 18:35:20 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id B5AAFA80653; Mon,  3 Jun 2019 18:35:19 +0200 (CEST)
Date: Mon, 03 Jun 2019 16:35:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH draft 0/6] Remove the fhandler_base_overlapped class
Message-ID: <20190603163519.GJ3437@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20190526151019.2187-1-kbrown@cornell.edu> <826b6cd3-2fbc-0d8c-b665-2c9a797a18f3@cornell.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="3U8TY7m7wOx7RL1F"
Content-Disposition: inline
In-Reply-To: <826b6cd3-2fbc-0d8c-b665-2c9a797a18f3@cornell.edu>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q2/txt/msg00128.txt.bz2


--3U8TY7m7wOx7RL1F
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1501

On May 30 12:56, Ken Brown wrote:
> On 5/26/2019 11:10 AM, Ken Brown wrote:
> > fhandler_pipe is currently the only class derived from
> > fhandler_base_overlapped.  This patch series rewrites parts of
> > fhandler_pipe so that it can be derived from fhandler_base instead.
> > We can then simplify the code by removing fhandler_base_overlapped.
> >=20
> > In particular, this gets rid of the peculiar situation in which a
> > non-blocking write can return with I/O pending, leading to the
> > ugliness in fhandler_base_overlapped::close.
> >=20
> > I've marked these patches as drafts because I've undoubtedly
> > overlooked some things.  Also, I haven't systematically done any
> > regression tests.  I have, however, run all the sample pipe programs
> > in Kerrisk's book "The Linux Programming Interface: Linux and UNIX
> > System Programming Handbook".  I've also run emacs-X11, gdb, git,
> > make, etc., so far without problems.
>=20
> This isn't ready for prime time yet.  I've run into occasional errors
> like this when doing a parallel build of emacs (-j13 in this case):
>=20
> make: INTERNAL: Exiting with 14 jobserver tokens available; should be
> 13!
>=20
> This would seem to indicate problems with make's jobserver pipe.  I've
> already found two bugs in patch 4, but I'm still seeing this error
> once in a while.
>=20
> I'll send a v2 if/when I find the problem.

Either way, you're collecting goldstars like crazy here :)


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--3U8TY7m7wOx7RL1F
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlz1TEcACgkQ9TYGna5E
T6AjkQ/+J9h+0VmLM7aeDLt+4ISGlAlI0UE7J34sZhjN2jBJmQkh6xxuu3oPyFri
wLgHFUw+X6Co8yoO1ZxYSL/V+lJJ7kKWLtrzWSuyFb37llIoOav7HfzQ05Wb6DML
xjYDALJXVw3g7KJWQMBSIToSCLn3/pX1b5ypS4oGpq63hYUcu4gQ+JmjneEPmSRX
nOgdQ0qtMS+uG+s3LwRqHUq0lSKAEnuVhMcCmZcpLz+9peZdS+4XzxMfYeWuxw1q
aL9zckEOQju5OhtrzvvHqyX9/Hbv4ptRT8Y0z/y4ebzBNypZxRRNIn/mNtKOwv4u
dmCPWZQ0dcI1Eil671ZL36PDTUcKMOz6k1M05HsFrVxqoGZUptEXRZylG2cv1f1D
jmP+9lAdfpTW9WpsAq0mjkasT98AOioJVtejSEGz2aDGWolrbZeRrlXq6oWN9QC+
2E+7OxTs+N3rfpXQoBcHfpZyFDU3aCXaKlmFzO8HVp7xGri1HVnpLTvyJbxmUN6R
JDzz9+i62dQSPP6x8d9cKrOOaVJdNx3JYK3i214PR8heaK/UO5MCg7nrzrf1VWhP
aqnmrDJ+r4v4HjGeYyd5K9FI49+kruBXz1PNwA/RwW/90Lgqrxw5ZU7Ic7A1iLoC
uogt50Wb4KS2CXd9t2pwJX6wFalpEkMQACdYNOg3KCWQ2+oCCb0=
=yxOt
-----END PGP SIGNATURE-----

--3U8TY7m7wOx7RL1F--
