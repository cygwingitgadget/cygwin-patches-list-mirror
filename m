Return-Path: <cygwin-patches-return-9076-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 78146 invoked by alias); 5 Jun 2018 09:41:00 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 78088 invoked by uid 89); 5 Jun 2018 09:40:59 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-124.1 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2 spammy=DOT, H*R:D*cygwin.com, age, H*Ad:U*cygwin-patches
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.135) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 05 Jun 2018 09:40:58 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue003 [212.227.15.167]) with ESMTPSA (Nemesis) id 0Lbv6m-1g7Cy32mOa-00jHkd for <cygwin-patches@cygwin.com>; Tue, 05 Jun 2018 11:40:55 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id A842CA8195B; Tue,  5 Jun 2018 11:40:54 +0200 (CEST)
Date: Tue, 05 Jun 2018 09:41:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/5] Cygwin: Clarify some code in environ.cc
Message-ID: <20180605094054.GA17401@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20180604193607.17088-1-kbrown@cornell.edu> <20180604193607.17088-2-kbrown@cornell.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
Content-Disposition: inline
In-Reply-To: <20180604193607.17088-2-kbrown@cornell.edu>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SW-Source: 2018-q2/txt/msg00033.txt.bz2


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1674

On Jun  4 15:36, Ken Brown wrote:
> ---
>  winsup/cygwin/environ.cc | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/winsup/cygwin/environ.cc b/winsup/cygwin/environ.cc
> index 43225341c..b452d21a5 100644
> --- a/winsup/cygwin/environ.cc
> +++ b/winsup/cygwin/environ.cc
> @@ -545,6 +545,7 @@ _getenv_r (struct _reent *, const char *name)
>    return findenv_func (name, &offset);
>  }
>=20=20
> +/* Return size of environment block, including terminating NULL. */
>  static int __stdcall
>  envsize (const char * const *in_envp)
>  {
> @@ -582,11 +583,16 @@ _addenv (const char *name, const char *value, int o=
verwrite)
>    else
>      {				/* Create new slot. */
>        int sz =3D envsize (cur_environ ());
> +
> +      /* Allocate space for two new slots even though only one is needed.
> +	 According to the commit message for commit ebd645e
> +	 (2001-10-03), this is done to "work around problems with some
> +	 buggy applications." */
>        int allocsz =3D sz + (2 * sizeof (char *));

Given the age, I wonder if we shouldn't expect applications to behave
finally.  We could remove this for testing.

>        offset =3D (sz - 1) / sizeof (char *);
>=20=20
> -      /* Allocate space for additional element plus terminating NULL. */
> +      /* Allocate space for additional element. */
>        if (cur_environ () =3D=3D lastenviron)
>  	lastenviron =3D __cygwin_environ =3D (char **) realloc (cur_environ (),
>  							    allocsz);
> --=20
> 2.17.0

LGTM, otherwise.

Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlsWWqYACgkQ9TYGna5E
T6Cysg//c93KZwbojL1fC18OWjBQAoC8p56yJQJulExVxv24QmS9BNuipgV7/u8T
HeyjmGGox9ouxg+2OEX3py/WnKWxDUCYh4eEYxBl7b1otuGIast2p8ptb4uJ9wMC
Z3+laEYt45OZHiNz7wl8P2bRxLigrr9KwGNNKLTPiaJkeOMYKF7jPx49j5KP3INQ
ChluGpLobazJ+UHjeDrAOEaNZC51/EbdB4074SO/jPoFGPHi2zv+77n/SXNS5S5q
H2pbnZEjAmn/LFLeSrqpWC5CkIP/b64WeQUZajs/l/mnPoRrSqKyTdTlyP0SEXKw
vTe+fh9gLBJ/Q6J4JU7qVO/MJLNAjEsEnAMmWor14V6uah0LNf6sfyqT2wXrwjkJ
0Gh6f1tJEgcdvxgC0jr6SMchl6mHI76hiH0wiJN5fCn5OwCKsz9qvDzTT7i+BcYr
7FC+8md4uyIMEAxg+2lV9HcIbRRx39XSfcg/kf1WlEePRkiqVmkllizE73Tt8Sw7
PBaSu8ph9Dw9X0pnYDQrMw6SqgbQLyiHWy3mjp8fk5OsRs0Aw+14qR/uAIr7feO7
wceoCG1b9m0WVxkR5pKQA8ZfMVQMM5wi+1nHdWNxK8IfbozFCFCG9d4Nv4I4DN4s
BY5WWHU/Ul88M9iFPOWOr4Ty2MAgFTv6zUy9QJo3hwLpPIXhLTM=
=NyqW
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--
