Return-Path: <cygwin-patches-return-9048-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 116629 invoked by alias); 17 Apr 2018 20:07:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 116616 invoked by uid 89); 17 Apr 2018 20:07:22 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-123.6 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,KAM_NUMSUBJECT,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2 spammy=H*F:U*corinna-cygwin, HX-Envelope-From:sk:corinna, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.133) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 17 Apr 2018 20:07:21 +0000
Received: from calimero.vinschen.de ([217.91.18.234]) by mrelayeu.kundenserver.de (mreue007 [212.227.15.167]) with ESMTPSA (Nemesis) id 0LlLpD-1eY5w133yB-00bL0B for <cygwin-patches@cygwin.com>; Tue, 17 Apr 2018 22:07:18 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 6077DA81EE2; Tue, 17 Apr 2018 22:07:18 +0200 (CEST)
Date: Tue, 17 Apr 2018 20:07:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: fix build with GCC 7
Message-ID: <20180417200718.GG15911@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20180417155458.18332-1-yselkowi@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline
In-Reply-To: <20180417155458.18332-1-yselkowi@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-UI-Out-Filterresults: notjunk:1;V01:K0:GUyzWuoqhGM=:NRXJZVGjv79T1vhIFCb+GI JEfskEmMR1a4df7NmP5234aFqjYQ2L/wpluW43+34gTBiQm231F2sBXYIpl0W4sBwSU8FpXHa oDZWSiSeq4iwrCY5ta5TWrAUOZYCHd3WwCDnQ8KOAc/f551V6NzbR7z6nzLWKU5X9kA9/pjUW gc5VrOVmdwXxZeGTB1R0LpNMC5kKrk0TBlpfmROQyQ1rXgZ5gB4reRPdq2UnFYvXfF6REmOYb /cAlzMsz0lA7vdT8Lt0Sj/Qsni8iPaJ5TqT/NXFZWNYe1ayretTQhUcNWktTm+dTn914FcLV/ 6gRhlkAL6J8rchpIasm2TUn8LzAhrZWguHYWTKW3hLXKRt3zsUpVNseCAa5HtCQ/9J/9XWq0x 7VwtjkVXMFfuPJqtdPi8bNVVr4g2esR2ZRoqvnF62pU8Rf9jwcSiSpX5YaX94AC8pFOj9sFga zAO7PHl2dfSxhToAtDeERYstXgx8r+Svyx1RaMaCMwdSY8xTvwp7HZbjxYiJ0o/ktybxUutYF L4v4K6hpB92vLfKJnMGh6+ThTBSz0fOPFW/cAdnFk+ibsp9RY1XdM8Ny2RATtBJ/y47VYGNpM tT+qz5KLzgYkNoZxxzphtGMPovdo9tJJGRJWxcBkSZbrM7pOUGktDMV5Uo431SSHlCM1CeaN2 xKmZp7yOHzPaHDpYRXtMX4RYhtER1gFFcnU+IYS5Eh9DG/NmlRxs7QWXVvXAb/24iF8k7VVKs 5LHz8ICjZVjT7ByyO1y6U8BR0hSUIUqwdRx/eg==
X-SW-Source: 2018-q2/txt/msg00005.txt.bz2


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1451

On Apr 17 10:54, Yaakov Selkowitz wrote:
> GCC 7 is able to see straight through this trick, so use a more formal
> method to avoid the warning.
>=20
> Signed-off-by: Yaakov Selkowitz <yselkowi@redhat.com>
> ---
>  winsup/cygwin/random.cc | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
>=20
> diff --git a/winsup/cygwin/random.cc b/winsup/cygwin/random.cc
> index 802c33b8a..163fc040c 100644
> --- a/winsup/cygwin/random.cc
> +++ b/winsup/cygwin/random.cc
> @@ -279,14 +279,6 @@ srandom(unsigned x)
>  		(void)random();
>  }
>=20=20
> -/* Avoid a compiler warning when we really want to get at the junk in
> -   an uninitialized variable. */
> -static unsigned long
> -dummy (unsigned volatile long *x)
> -{
> -  return *x;
> -}
> -
>  /*
>   * srandomdev:
>   *
> @@ -313,7 +305,11 @@ srandomdev()
>  		unsigned long junk;
>=20=20
>  		gettimeofday(&tv, NULL);
> -		srandom((getpid() << 16) ^ tv.tv_sec ^ tv.tv_usec ^ dummy(&junk));
> +		/* Avoid a compiler warning when we really want to get at the
> +		   junk in an uninitialized variable. */
> +#pragma GCC diagnostic ignored "-Wmaybe-uninitialized"
> +		srandom((getpid() << 16) ^ tv.tv_sec ^ tv.tv_usec ^ junk);
> +#pragma GCC diagnostic pop
>  		return;
>  	}
>=20=20
> --=20
> 2.17.0

Yes, please push.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlrWU/YACgkQ9TYGna5E
T6Budg//YC+SyWNuhhefx0uQTyYSiRnrsM+Tqtw9KtF4mhopVkZ7tAahIu6ofN8r
1chiG3N3xPGFbnYxrG65oNI1WSsGFusWFPJ7waXAwTVNfL4ONt+vopgjEhhFQ7G3
EaN+U1F8wrEys+jpk4/7F9cgJZl8NFfz9nWKhs9pzi3zgukPKTIZsUrcb/4oD5tt
2i7NR69NfimJFBNvAYIF3zuOPA8tmXzGUEM64ESD2ImJX0KUEf7FA35+gujGw4Ds
vcMiaOIpE/KpAD4BnudLUnDZTlsCMZL0sI8SnWSoAvxVjy68Uu3/mtKJonNv4pIL
7i4Ra74KXUPWFAB0NNixz7q1ylkiaRa5IA9dHvVYudSd+AEb6QQhCFanmuiyf5TQ
Snfw2CZ+x2ImwHhrKuV3bPu63pAnjNdMeuMsLVVPEexiR9+ek+y3Bw1DMAIYYslr
2LAwsEUolW+SF98XM/zNBHLcJ0+fx5S/wt14uQJBlqOd6u3nMwPDyYrXkb1M2YaA
LTHUMbbEtxktUWfkK2PCSob8TgVG8zPRF/vO6TRA59ioJI0Nw1y6r0ZfzSD4bm41
KQ3kySWAdl1e04phs7+yGA/pTyXBbEOCF1G/U1iK1+fi8rWH6vE+shieHMAEud+i
oFlrm3PGgyP7PZ1Nig5TBpQFuFrg0XcOC8Ri/G+WqO+rJTCvCIQ=
=FXn+
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--
