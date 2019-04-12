Return-Path: <cygwin-patches-return-9332-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4478 invoked by alias); 12 Apr 2019 18:01:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 4467 invoked by uid 89); 12 Apr 2019 18:01:44 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-107.5 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*F:D*cygwin.com
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.135) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 12 Apr 2019 18:01:43 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id 1M8hph-1hArlV1i9x-004mjb for <cygwin-patches@cygwin.com>; Fri, 12 Apr 2019 20:01:40 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 17E86A806B7; Fri, 12 Apr 2019 20:01:40 +0200 (CEST)
Date: Fri, 12 Apr 2019 18:01:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: use win pid+threadid for forkables dirname
Message-ID: <20190412180140.GE4248@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <869d6cb0-9c14-d1f6-fdf2-f87ff815029b@ssi-schaefer.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="68uOmRXIw+u8y5pO"
Content-Disposition: inline
In-Reply-To: <869d6cb0-9c14-d1f6-fdf2-f87ff815029b@ssi-schaefer.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q2/txt/msg00039.txt.bz2


--68uOmRXIw+u8y5pO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 536

On Apr 12 15:32, Michael Haubenwallner wrote:
> Rather than newest last write time of all dlls loaded, use the forking
> process' windows pid and windows thread id as directory name to create
> the forkable hardlinks into.  While this may create hardlinks more
> often, it does avoid conflicts between dlls not having the newest last
> write time.
> ---
>  winsup/cygwin/forkable.cc | 26 +++++++-------------------
>  1 file changed, 7 insertions(+), 19 deletions(-)

Pushed.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--68uOmRXIw+u8y5pO
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlyw0oMACgkQ9TYGna5E
T6ANNA//c2d9HI+ZQ7D1v7xhiPSxqvAFgwDrmJEVT5Dp3ot/tznxUqEkqv8hd5eB
jwRPQCOHz/dPt4Zmb53Q4DcWtyEgyf0DjNrk8ZmefFemQ90WnFUDJOW77v++SZx8
QdStWoZMIwSBPOaeEoEVHu21vyzOg/AoG4uhmn5ciesviAM1gy+Y+B3qUakS4T+B
5v4Zlj2c6oiWmcaTrymdNzlYQSyfpS7RLYnG91ouc3uQdW5gPTj2IVws+tQ5m+ak
eD6VhTA9T1NcC+CZKwyaYPs9ji8l5xjaoLbzjZk4WOohL+ruBSNAyE2wJC5N0961
Ujg6aAnOjGus9vg8n27FtWSs4nVeW4hGhAdmxNxqYgzr7yX7skgkg72V61AyUOX7
h/KMl4sfMw6m8RuZS5j5GAco+/0Pw3iIOiThSi74K9CZUoS4W08QgZHWGlygUCPw
RzvEcZZfud6eyxJPSIL3kojlxtvKnrRzxPmj4TBe+H2puocucHhcv2HQ+EE5Eatf
epWSXfCuINPm9/BTDRSTDEoHCQTNBOZ2FDg7x9Y16zDyDmT/feyJe0xj5wCO+1HU
JmWiFIDSHcKa8eAC+JBgyHQOWkxN+tAW5bnboKv1irisL+r5wmZ7pLtNULec2IIO
aL0Cu/7+KHgqR0Ee0UXvZDdkaTlLtAVV+miL7iLd7plqEOVh2gs=
=OwwY
-----END PGP SIGNATURE-----

--68uOmRXIw+u8y5pO--
