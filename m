Return-Path: <cygwin-patches-return-8948-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22389 invoked by alias); 29 Nov 2017 20:40:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 21748 invoked by uid 89); 29 Nov 2017 20:40:44 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-124.3 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,KB_WAM_FROM_NAME_SINGLEWORD,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=letter
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 29 Nov 2017 20:40:43 +0000
Received: from aqua.hirmke.de (business-24-134-7-25.pool2.vodafone-ip.de [24.134.7.25])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id 95D3A721E2825	for <cygwin-patches@cygwin.com>; Wed, 29 Nov 2017 21:40:39 +0100 (CET)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id 6D2B65E020F	for <cygwin-patches@cygwin.com>; Wed, 29 Nov 2017 21:40:36 +0100 (CET)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id D10F7A8072C; Wed, 29 Nov 2017 21:40:38 +0100 (CET)
Date: Wed, 29 Nov 2017 20:40:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/2] cygwin: add Object Size Checking to sys/poll.h
Message-ID: <20171129204038.GA3725@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20171129174527.10536-1-yselkowi@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
Content-Disposition: inline
In-Reply-To: <20171129174527.10536-1-yselkowi@redhat.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-SW-Source: 2017-q4/txt/msg00078.txt.bz2


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1965

On Nov 29 11:45, Yaakov Selkowitz wrote:
> Signed-off-by: Yaakov Selkowitz <yselkowi@redhat.com>
> ---
>  winsup/cygwin/include/ssp/poll.h | 26 ++++++++++++++++++++++++++
>  winsup/cygwin/include/sys/poll.h |  4 ++++
>  2 files changed, 30 insertions(+)
>  create mode 100644 winsup/cygwin/include/ssp/poll.h
>=20
> diff --git a/winsup/cygwin/include/ssp/poll.h b/winsup/cygwin/include/ssp=
/poll.h
> new file mode 100644
> index 000000000..831e626d6
> --- /dev/null
> +++ b/winsup/cygwin/include/ssp/poll.h
> @@ -0,0 +1,26 @@
> +#ifndef _SSP_POLL_H_
> +#define _SSP_POLL_H_
> +
> +#include <ssp/ssp.h>
> +
> +#if __SSP_FORTIFY_LEVEL > 0
> +__BEGIN_DECLS
> +
> +__ssp_decl(int, poll, (struct pollfd *__fds, nfds_t __nfds, int __timeou=
t))
> +{
> +  __ssp_check (__fds, __nfds * sizeof(*__fds), __ssp_bos);
> +  return __ssp_real_poll (__fds, __nfds, __timeout);
> +}
> +
> +#if __GNU_VISIBLE
> +__ssp_decl(int, ppoll, (struct pollfd *__fds, nfds_t __nfds, const struc=
t timespec *__timeout_ts, const sigset_t *__sigmask))
> +{
> +  __ssp_check (__fds, __nfds * sizeof(*__fds), __ssp_bos);
> +  return __ssp_real_ppoll (__fds, __nfds, __timeout_ts, __sigmask);
> +}
> +#endif
> +
> +__END_DECLS
> +
> +#endif /* __SSP_FORTIFY_LEVEL > 0 */
> +#endif /* _SSP_POLL_H_ */
> diff --git a/winsup/cygwin/include/sys/poll.h b/winsup/cygwin/include/sys=
/poll.h
> index 0da4c3f03..65822edb3 100644
> --- a/winsup/cygwin/include/sys/poll.h
> +++ b/winsup/cygwin/include/sys/poll.h
> @@ -47,4 +47,8 @@ extern int ppoll __P ((struct pollfd *fds, nfds_t nfds,
>=20=20
>  __END_DECLS
>=20=20
> +#if __SSP_FORTIFY_LEVEL > 0
> +#include <ssp/poll.h>
> +#endif
> +
>  #endif /* _SYS_POLL_H */
> --=20
> 2.15.0

ACK to both patches.

For patch series, please add a cover letter, it's not too much effort
and clearer.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJaHxtGAAoJEPU2Bp2uRE+g6dsP/izY01p8tT5Ypuk/OaH5gwNq
U4892I2kyy9yZv1jlGDCpJAGWj2QdmA8aM5gyamSTjun+IpE8pQKUab9iNsq+ePp
vrHAhqZyiHhLhMWlsnt0MoZ/DDrosmffZwSt+7g9OSaKB6W3fdH+L1ITYDqCuQ50
t9/ersP3Y66T15uQLnNqAyeLJYmmmcTkYHW2CrWOKdtktv3Dwd93KUtpFcMQwCvn
k+kADMMrUh/YJW/QWPUNDqVms332X5ffeLgmBG8adrsqmnSw2Q7BhQWJ+6cdruoI
nKag4EmqbhQmsdisNHkhKYDotAcZio95sUq73XhXusBO3c1Vc2p1Pkx+C0CV5ulY
Xfby5+H6oRJXDn+311CG0Z7tbiUju917F+coE5j6lWu1IDOH+8pvm/fxbOJoBlHy
Lwqm+C2fqIKgU+J2a8B+boqkludSy+Q8Z4f0/beK7g3t9ey5xuLIB/RQyPeCxcUH
5wpsOxHKHDF7Zqain1swcZnNmG+pfVQFK3AAOnLDgU+CGoHLmJPgRe0ExTMLsEU0
oyY8EkOEc7A5709qnMWGHDwQ8jtVYGUQiQ1Y53hmRNDEwQWNLKH+iLn01ijF+Bap
SxAVz3JYtXRWk88vd+xqYciFrz9/CsS+slGjMUikGGa3ZnEyFo8gaLmvf37k0zDp
lBIB6n6lkWbyCoST8aME
=RoTy
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--
