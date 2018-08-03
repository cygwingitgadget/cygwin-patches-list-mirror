Return-Path: <cygwin-patches-return-9158-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 82327 invoked by alias); 3 Aug 2018 07:36:57 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 82315 invoked by uid 89); 3 Aug 2018 07:36:57 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-123.7 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2 spammy=van, jh, Water, H*r:500
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (217.72.192.75) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 03 Aug 2018 07:36:54 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue104 [212.227.15.183]) with ESMTPSA (Nemesis) id 0M9XvL-1feelD42YB-00Cz8n; Fri, 03 Aug 2018 09:36:49 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id D609D12E0A3E; Fri,  3 Aug 2018 09:36:47 +0200 (CEST)
Date: Fri, 03 Aug 2018 07:36:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: "J.H. van de Water" <houder@xs4all.nl>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: fegetenv() in winsup/cygwin/fenv.cc should not disable exceptions!
Message-ID: <20180803073647.GA6347@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: "J.H. van de Water" <houder@xs4all.nl>,	cygwin-patches@cygwin.com
References: <1533253512-1717-1-git-send-email-houder@xs4all.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
In-Reply-To: <1533253512-1717-1-git-send-email-houder@xs4all.nl>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SW-Source: 2018-q3/txt/msg00053.txt.bz2


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2056

Hi J.H.,

On Aug  3 01:45, J.H. van de Water wrote:
> fegetenv() in winsup/cygwin/fenv.cc
>=20
> fnstenv MUST be followed by fldenv in fegetenv(), as the former disables =
all
> exceptions in the x87 FPU, which is not appropriate here (fegetenv() ).
> fldenv after fnstenv should reload the x87 FPU w/ the configuration that =
was
> saved by fnstenv, i.e. a configuration that might have exceptions enabled.
>=20
> Note: x86_64 uses SSE for floating-point, not the x87 FPU. However, becau=
se
> feraiseexcept() attempts to provoke an exception using the x87 FPU, the b=
ug
> in fegetenv() will make this attempt futile here (x86_64).
>=20
> Note: WoW uses the x87 FPU for floating-point, not SSE. Here anything that
> would normally result in triggering an exception, not only feraiseexcept(=
),
> will not be able to, as result of the bug in fegetenv().
> ---
>  winsup/cygwin/fenv.cc | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/winsup/cygwin/fenv.cc b/winsup/cygwin/fenv.cc
> index bd3f904..eb5260c 100644
> --- a/winsup/cygwin/fenv.cc
> +++ b/winsup/cygwin/fenv.cc
> @@ -141,7 +141,10 @@ fegetexcept (void)
>  int
>  fegetenv (fenv_t *envp)
>  {
> -  __asm__ volatile ("fnstenv %0" : "=3Dm" (envp->_fpu) : );
> +  /* fnstenv disables all exceptions in the x87 FPU; as this is not what=
 is
> +     desired here, reload the cfg saved from the x87 FPU, back to the FP=
U */
> +  __asm__ volatile ("fnstenv %0"
> +                    "fldenv %0" : "=3Dm" (envp->_fpu) : );
>    if (use_sse)
>      __asm__ volatile ("stmxcsr %0" : "=3Dm" (envp->_sse_mxcsr) : );
>    return 0;
> --=20
> 2.7.5

Thank you!

Pushed with tweaks.  The string in __asm__ statements works a
bit different and I made a slight change to the commit message.

In terms of x86_64, do we have to change the fenv stuff completely
to use only SSE opcodes?  Does that make sense at all?


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAltkBg8ACgkQ9TYGna5E
T6BaTQ//S45WEFQIvQqmPTa/kO7YJLnV5uiXd2bJxJFWCTDg1M9gXlajjJUz/s0a
o9xGDvJGnesjMmxhNUtGhPLsosdP/xI/nFfbbijoEMM8pl+PHhLd3nlWZojWslOM
AU2GscP5dTjgz8W54OZ0r+fLudPaV7Pf5DU3J/AumzcdX0lqXLjM4FbxNazFcUKu
IgfhzBQRymaMrWsRxkY17ISFvozVOx0b/XJbiyGGRNTMUI8xVM1NUDOHkyW7OM/M
Rjb3P1SScWR8zesHfCokDxa9J0qQ5Q6SJbISfmbOXKFBobwvrbviInTG9g20hQPj
PPxUgjq4NyXxlWkM0Kx1XMyE3n2SoCNYDjfWlhU13fbChIIgt4Mhtij0OuJYrHim
mJo4lrHD9QcaZtyR2vrtUaPkWYRQC6nzRS6BN6kt9ocuHpPDhjoL4fAMtvHCWRwn
loEarnL95PfO2OWUae8qZNXe5xrtwuUiOL4qOGJI/Bj5ykDAkxWChF5J87lvoTGk
/nnZro6zOOgt8DP3TWluZMNHmBX0iYYDlf2Cl7IKGWDCKDQ5I75+rLWSGk8SQNWf
gwA38+fISps/subJrnUXqPVjNZLflZAOfCXC50I65Sv8W3wI4OLK0MxrFhVinPjf
4WQIk5nzgytizfsIxo1TSA5s7ghMZ+L7EMashV+ntgWc1rFUdog=
=2lgF
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
