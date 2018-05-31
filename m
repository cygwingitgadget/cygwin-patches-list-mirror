Return-Path: <cygwin-patches-return-9062-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 120622 invoked by alias); 31 May 2018 08:06:38 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 120382 invoked by uid 89); 31 May 2018 08:06:15 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-123.7 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2 spammy=H*F:D*cygwin.com, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.135) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 31 May 2018 08:06:13 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue007 [212.227.15.167]) with ESMTPSA (Nemesis) id 0MhamE-1fjpqq2Qb4-00Ma8E for <cygwin-patches@cygwin.com>; Thu, 31 May 2018 10:06:10 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 7EA69A8191D; Thu, 31 May 2018 10:06:09 +0200 (CEST)
Date: Thu, 31 May 2018 08:06:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Fix declaration of pthread_rwlock_* functions
Message-ID: <20180531080609.GA15191@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <cfb6a3b0-57f6-8594-0872-db65d371a997@cornell.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
In-Reply-To: <cfb6a3b0-57f6-8594-0872-db65d371a997@cornell.edu>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-UI-Out-Filterresults: notjunk:1;V01:K0:/o7995kwcIQ=:kKN7xaRwkASsDySfKFaD4b 5+Yor74ziGtS22nMC7C8iAFiYZ7yZJgZ0C00PnkAIRH17LS0Uzfxwv15xdIrZ/yQSbD4ZO1/I yWBv21pI1ES2v5dnQtgPaCqjoG/h8jUWIkQoaVruhy0qvYHol6sLqfrPXgOP1XmbgFMWdY0QE MPoBvNqbN/gHAP0oW6RXL2TmzfH6u3he/Tp3vFr4ice+qZpbFaHUzbE348YAqxje7n8swTb9v xSjG0SRXz2z7enBBtayn7dyS9d+f4IS9J/+tofuc5Zg5qnFHChxSA9cByjiyYr5KTkRvD3rRU OeoL9xjyO841Bx+wDztiCVVcFVQeFgWWGt4C1nL6whnpF5ef372ivShoRXIx9uNJUpx6oAcPR Sgnf1r0K1Bselc3LunhEgtCN1xgFOql0uV9dCn4pPG1ktvfrL/U+m+xzHzPCoMrhyrgRRB3IY +IFvYf72M+QY1HfQGrkXh+tNGMS/x9j2bb1nC8ArJbSNw8I4o0WJ7oDGhAyTKudf3zGNPQxM4 BLo958E6qqudjbavKdyqd2uACNl32u/u0DiPpg8ugzLL5oEmOcqW1Nf1185lJbQJb+bSerP4r EGeaDQcA4lCzGEMuozN+qo+v9YTB1ki8BxcYk9B6SChnYBDWOgO62Y5ki9AVhwspmJ80rAkwJ 9bj1VXcAYscyw2twF9p1U3jJG064+zx/IuG7hYfF97oLhIC4hHsMf3XtQP9Z+bKC9YXg=
X-SW-Source: 2018-q2/txt/msg00019.txt.bz2


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1533

On May 30 16:28, Ken Brown wrote:
> The attached patch fixes the second problem reported in
> https://cygwin.com/ml/cygwin/2018-05/msg00316.html, though I'm not sure i=
t's
> the right fix.
>=20
> Ken

> From 4940baac08cd9339d771d9db90a880c61610ae4c Mon Sep 17 00:00:00 2001
> From: Ken Brown <kbrown@cornell.edu>
> Date: Wed, 30 May 2018 16:19:01 -0400
> Subject: [PATCH] Declare the pthread_rwlock_* functions if __cplusplus >=
=3D
>  201402L
>=20
> Some of these functions are used in the <shared_mutex> C++ header.
> ---
>  winsup/cygwin/include/pthread.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/winsup/cygwin/include/pthread.h b/winsup/cygwin/include/pthr=
ead.h
> index 3dfc2bc80..fed616532 100644
> --- a/winsup/cygwin/include/pthread.h
> +++ b/winsup/cygwin/include/pthread.h
> @@ -187,7 +187,7 @@ int pthread_spin_unlock (pthread_spinlock_t *);
>  #endif
>=20=20
>  /* RW Locks */
> -#if __XSI_VISIBLE >=3D 500 || __POSIX_VISIBLE >=3D 200112
> +#if __XSI_VISIBLE >=3D 500 || __POSIX_VISIBLE >=3D 200112 || __cplusplus=
 >=3D 201402L
>  int pthread_rwlock_destroy (pthread_rwlock_t *rwlock);
>  int pthread_rwlock_init (pthread_rwlock_t *rwlock, const pthread_rwlocka=
ttr_t *attr);
>  int pthread_rwlock_rdlock (pthread_rwlock_t *rwlock);
> --=20
> 2.17.0
>=20

LGTM but the guards are Yaakov's domain.  Yaakov, any input?


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlsPrPEACgkQ9TYGna5E
T6C4Dw/9HcFL6LH3TBcWM/XhNPFjrf52biOvrAeneUiKEW6JXLLdNWRbBtlD+SBq
tr++FtfhLfs2ulbMfnyKkQEHsnlB+dWW3AuqHJUbeuilL0eVctc1IRTbi2NcxFk/
QogilJPXFslW6NgI02bCsON3JDg90gtprBQAaM/p33vx/+qbhwfwVQTEvFR7mwvH
pmdSddx8KCN7GI0ZM7XvZpoQG0sIL4L23CrzELOR/WS34PgRKYmRvR2HIqo8Wh8d
wFypmypoxVXiWAVSITrcK7nlNOs6wx28bDaqfYQVYuCWrTaf+oB0Ov5QG53fF0XY
sgBdO4PdIjzZPzj/Kzi0jervCLeCBj4+eF89z9V31wZwSkSWE3ZiZFV+aiTwa64b
2vL/njEroEqlKzXnCSt294X478HmTQIqeBIEq9KJIdFUVOSI3wPAx6mGegEPtbVt
herz/gSqrT1yQAs92hq8xnZ08Sog+0Cc+AwpmBjQJM07Q/wCHiaRmOelN9MZctw/
axAhKA+5BPchatnNE4wSs4jnT2G9VjlfBTbNTLY+Li5FCr7fcc04UWi+02CeJhwH
7VtFefJtIpKY4vUBEt/jxdK/ntu/lQTTrhjOGsVPkLiLzzc6RuM0dDAaC3xGFm74
W71xEvlcyPPojDCYxAQNtcU9YWXrDZQFJJXL4FYOsviMMf1KW0Q=
=p1SU
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--
