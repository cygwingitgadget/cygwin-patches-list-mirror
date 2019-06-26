Return-Path: <cygwin-patches-return-9468-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 111597 invoked by alias); 26 Jun 2019 09:16:55 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 111588 invoked by uid 89); 26 Jun 2019 09:16:55 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-116.6 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*F:D*cygwin.com
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.130) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 26 Jun 2019 09:16:45 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MoOIi-1iLxI22GAS-00on3C for <cygwin-patches@cygwin.com>; Wed, 26 Jun 2019 11:16:42 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 94848A807CF; Wed, 26 Jun 2019 11:16:41 +0200 (CEST)
Date: Wed, 26 Jun 2019 09:16:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Fix return value of sched_getaffinity
Message-ID: <20190626091641.GS5738@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20190625114004.GI5738@calimero.vinschen.de> <20190626081441.35923-1-mark@maxrnd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="jtcAeju3WzRmRF+o"
Content-Disposition: inline
In-Reply-To: <20190626081441.35923-1-mark@maxrnd.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q2/txt/msg00175.txt.bz2


--jtcAeju3WzRmRF+o
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1056

Hi Mark,

On Jun 26 01:14, Mark Geisert wrote:
> Have sched_getaffinity() interface like glibc's, and provide an
> undocumented internal interface __sched_getaffinity_sys() like the Linux
> kernel's sched_getaffinity() for benefit of taskset(1).
>=20
> ---
>  newlib/libc/include/sched.h            |  1 +
>  winsup/cygwin/common.din               |  1 +
>  winsup/cygwin/include/cygwin/version.h |  2 +-
>  winsup/cygwin/sched.cc                 | 29 +++++++++++++++++---------
>  4 files changed, 22 insertions(+), 11 deletions(-)
>=20
> diff --git a/newlib/libc/include/sched.h b/newlib/libc/include/sched.h
> index fc44209d6..bdd57d442 100644
> --- a/newlib/libc/include/sched.h
> +++ b/newlib/libc/include/sched.h
> @@ -111,6 +111,7 @@ typedef struct
>    __cpu_mask __bits[__CPU_GROUPMAX];
>  } cpu_set_t;
>=20=20
  #ifdef __CYGWIN__
> +int __sched_getaffinity_sys (pid_t, size_t, cpu_set_t *);
  #endif

ideally outside the #if __GNU_VISIBLE bracketing.

The rest of the patch looks good.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--jtcAeju3WzRmRF+o
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl0TN/kACgkQ9TYGna5E
T6B9vA//W21D8UfVz+6sRemQ8Op58kjnx552gdMJkOmv9jIuCt/Enup10bIzBMvO
nH65ywcIfIX3mMkSR0LdVX8kzOdWxG3ITqss/od4Q4dxOvHihSOB7Qvh56q9uXXS
qXNmE83QCAu/WBsDNFq9bmlRYRP1UBhYMmLuQtlxv60PdezF/16SAIK8CP3BdQHW
HnvHlRersKTx4vWArMG//CrKFy299fWStOF6OkbiV2ESoRBZtRrPLW61150wwKBs
2UH1P9QAa3x/mV6FpzVMQ/6U4Qs2kFflo91sjQIBbFPKSuxB6LubBBFNFYUSqbnY
YrRv11qwtJo6dEbRZQaIJ8is45W84kPC5jmjb2WREBQYD1OQDxcjZOwvEKJ691G/
d+onxkvfsL44Fph4FPW5kPLh1kcNlUh05NAUixFuIjhKkI3FCjcQWODImyPsXpbF
8xpR16iJMJ+ubMSU2mXuLnODCym+/WXyPRGjuwULcLDkkX/YC3YJW8ko46aoCpZ0
vCx4YM43TZXrG9THdOVeFlTxPC8VhfpwbqA8QaZNC9Og5We9fZ/vHl6vk869hrlx
kue8wmxmcOr+hvHadg6pnUIHGFXqRsDFhXz7xopRuvBQpbNrYcM9vmNMqYFWgh6q
fHefnewuBc2hVY+mq1gzNVgXRPHTwWNzcBy2eQLdEETaM3TjaeA=
=eRKU
-----END PGP SIGNATURE-----

--jtcAeju3WzRmRF+o--
