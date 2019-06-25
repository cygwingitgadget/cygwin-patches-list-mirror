Return-Path: <cygwin-patches-return-9458-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 120303 invoked by alias); 25 Jun 2019 07:43:53 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 120294 invoked by uid 89); 25 Jun 2019 07:43:53 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-115.5 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*F:D*cygwin.com, states
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.187) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 25 Jun 2019 07:43:51 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MXGes-1i5USJ1M4s-00Ym1Y for <cygwin-patches@cygwin.com>; Tue, 25 Jun 2019 09:43:49 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id AD8F1A807B0; Tue, 25 Jun 2019 09:43:48 +0200 (CEST)
Date: Tue, 25 Jun 2019 07:43:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: timerfd: avoid a deadlock
Message-ID: <20190625074348.GF5738@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20190624201852.26148-1-kbrown@cornell.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="u65IjBhB3TIa72Vp"
Content-Disposition: inline
In-Reply-To: <20190624201852.26148-1-kbrown@cornell.edu>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q2/txt/msg00165.txt.bz2


--u65IjBhB3TIa72Vp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1413

Hi Ken,

On Jun 24 20:19, Ken Brown wrote:
> If a timer expires while the timerfd thread is in its inner loop,
> check for the thread cancellation event before trying to enter
> a_critical_section.  It's possible that timerfd_tracker::dtor has
> entered its critical section and is trying to cancel the thread.  See
> http://www.cygwin.org/ml/cygwin/2019-06/msg00096.html.
> ---
>  winsup/cygwin/timerfd.cc | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/winsup/cygwin/timerfd.cc b/winsup/cygwin/timerfd.cc
> index 8e4c94e66..e8261ef2e 100644
> --- a/winsup/cygwin/timerfd.cc
> +++ b/winsup/cygwin/timerfd.cc
> @@ -137,6 +137,11 @@ timerfd_tracker::thread_func ()
>  	      continue;
>  	    }
>=20=20
> +	  /* Avoid a deadlock if dtor has just entered its critical
> +	     section and is trying to cancel the thread. */
> +	  if (IsEventSignalled (cancel_evt))
> +	    goto canceled;

This looks still racy, what if cancel_evt is set just between the
IsEventSignalled() and enter_critical_section() calls?

Hmm.

What if we redefine enter_critical_section() to return three
states.  It calls WFMO on cancel_evt and _access_mtx, in this order,
so that a cancel event is honored.  Or maybe introduce another
function like enter_critical_section_cancelable() which is only
called in this single instance in timerfd_tracker::thread_func?


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--u65IjBhB3TIa72Vp
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl0R0LQACgkQ9TYGna5E
T6CnWRAAh00d9WeD5bMv+a2iVriruxwoBXlcGj9lH635IYBONjecx3vbgIXSF4R4
srg6YNRmA/B8cwQPBSEh5zSestd8cKpT/Q0X2cDl83O1XWU7gopisMb/0WSFDj8v
BzAmcY+dMU/A2zp075RdaxSUU7TSYOhiS+cH/RF/blLvq/wlteEYfK54u8pPoC4r
fAPxZH1RkJXVSDTvum7/Y0Zbr3SylIrKo93WjHqPTgm2Bz3UZVzKUJRVTDAMG1BL
1tTDMhxe7qJ6NtyqSCHALR/zSNj3MLoJYEUII4GWL5OWxLGNVt0Es66g30L09oqZ
dm05f6DVT2X84dXIxZLM9j+Ukf67f2StmxR5E6qr90JfukOxk55X5zDDcir5QHbK
e5cHakU6JwG4pgC1jjHVddClCXZ5j6Fk1VpwyOo1tk9su6yNzhNFWgAxcenaPpES
1is6llIsukBK094Is3FLObsRq0aDL/gkUyGScoqJk/oxaqE8tsefYXhBdmQOmRmM
NU3c32FcQYFYpAUBe8CZFPs3SYc4zyqng/iWSgXDy2AJuK5AF1/k/mWKZ2aG0kUC
oqHvb0HKEtFz69zCX4v+6N9AUIbw/zy/I86RLGVwt7Bv7gQ0mmAOPxh2PtTveEjB
0OxQiJ2JA9YjU5wGwLRtXFiZUBLoVHgWAPq7ZzFJ4oZ+YnifOd8=
=KYxU
-----END PGP SIGNATURE-----

--u65IjBhB3TIa72Vp--
