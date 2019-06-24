Return-Path: <cygwin-patches-return-9453-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10630 invoked by alias); 24 Jun 2019 07:23:48 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 10621 invoked by uid 89); 24 Jun 2019 07:23:47 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-107.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*F:U*corinna-cygwin, H*F:D*cygwin.com
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (217.72.192.74) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 24 Jun 2019 07:23:46 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MGR3r-1hnEMf04wX-00Gptu for <cygwin-patches@cygwin.com>; Mon, 24 Jun 2019 09:23:44 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 8750EA8073B; Mon, 24 Jun 2019 09:23:43 +0200 (CEST)
Date: Mon, 24 Jun 2019 07:23:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3] Cygwin: Implement sched_[gs]etaffinity()
Message-ID: <20190624072343.GA5738@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20190623215106.4847-1-mark@maxrnd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline
In-Reply-To: <20190623215106.4847-1-mark@maxrnd.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q2/txt/msg00160.txt.bz2


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1168

Hi Mark,

On Jun 23 14:51, Mark Geisert wrote:
> This patch set implements the Linux syscalls sched_getaffinity,
> sched_setaffinity, pthread_getaffinity_np, and pthread_setaffinity_np.
> Linux has a straightforward view of the cpu sets used in affinity masks.
> They are simply long (1024-bit) bit masks.  This code emulates that view
> while internally dealing with Windows' distribution of available CPUs amo=
ng
> processor groups.
> ---
>  newlib/libc/include/sched.h            |  23 ++
>  winsup/cygwin/common.din               |   4 +
>  winsup/cygwin/include/cygwin/version.h |   4 +-
>  winsup/cygwin/include/pthread.h        |   2 +
>  winsup/cygwin/miscfuncs.cc             |  20 +-
>  winsup/cygwin/miscfuncs.h              |   1 +
>  winsup/cygwin/release/3.1.0            |   3 +
>  winsup/cygwin/sched.cc                 | 308 +++++++++++++++++++++++++
>  winsup/cygwin/thread.cc                |  19 ++
>  winsup/doc/new-features.xml            |   6 +
>  winsup/doc/posix.xml                   |   4 +
>  11 files changed, 389 insertions(+), 5 deletions(-)

This looks great!  I pushed it.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl0Qen8ACgkQ9TYGna5E
T6Bw3Q//U1++u5W/Q2pZofntXWjRNeN8GlsUHXb5a5eKC+AMPy7hg4ckazJYdsJG
shi20xlQQTCwjhof0/zfeHKo7tHMuhKs2961mFEkKqHQaQymh3MaZjQmQMXdwGZS
RBKST2KPqxKGEYyqKXp1fFPt3CNx/a0DgMXIJ2IgKuvmEB2IkJZzfnJ2RTA+mDdW
rDQdWEcvCkMUG+oydodIsn3P6wy5l2+e9AIxhOH06ldYN5hCC12vrh6Nt6tcFhQ9
/x1rz5tnabL4g/eiZyEAwAGbn3ERVtPSP5V2it4UriOvKy9NcBxVXkz6b+/6fXQu
RtLeesHBicMTn9hWXxFTdRYwh/+V6PU/N6g+fvES+y5oXw6wYomQ2s5iS4OErzgV
0XcH0JeXTrbjb8EmrcY9jD84W9L01ikARnDkNEJDfCiRJGa5meCg6sZY/b6xTu+w
H5i0+zQECycsKGshhY2DbbcHAPYyMEAtKJT5l1HorJYkkuWUwjgelqKuSHBlv6Lo
yK4Tnuu1EDGSNniLREm0roFdcc7A7gQA9OLJJ0rcw05MVjQRD5/W2Avdf/X8fDQZ
MPLYNmclJVW7+CL5wWlbn9Syu3q6IGmiGULo+hiFdI8cuVCPig/NQsVUFvI8l2lJ
ZVCgc8u6lziJlVfVL4onScm0zoXUw536Q65D3VdRxuY1Y0CQnQ0=
=mRKz
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
