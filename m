Return-Path: <cygwin-patches-return-9121-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 61776 invoked by alias); 16 Jul 2018 14:30:36 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 61619 invoked by uid 89); 16 Jul 2018 14:30:24 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-110.5 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2 spammy=worries, syscalls, perfect
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.187) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 16 Jul 2018 14:30:21 +0000
Received: from calimero.vinschen.de ([217.91.18.234]) by mrelayeu.kundenserver.de (mreue004 [212.227.15.167]) with ESMTPSA (Nemesis) id 0LpAhs-1gHS8W1TD2-00eug3 for <cygwin-patches@cygwin.com>; Mon, 16 Jul 2018 16:30:04 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id C149CA80576; Mon, 16 Jul 2018 16:30:03 +0200 (CEST)
Date: Mon, 16 Jul 2018 14:30:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3 3/3] POSIX Asynchronous I/O support: other files
Message-ID: <20180716143003.GB27673@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20180715082025.4920-1-mark@maxrnd.com> <20180715082025.4920-4-mark@maxrnd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="2/Dpz40iF3jpiHxF"
Content-Disposition: inline
In-Reply-To: <20180715082025.4920-4-mark@maxrnd.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SW-Source: 2018-q3/txt/msg00016.txt.bz2


--2/Dpz40iF3jpiHxF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1062

On Jul 15 01:20, Mark Geisert wrote:
> Updates to misc files to integrate AIO into the Cygwin source tree.
> Much of it has to be done when adding any new syscalls.  There are
> some updates to limits.h for AIO-specific limits.  And some doc mods.
> ---
>  winsup/cygwin/Makefile.in              |  1 +
>  winsup/cygwin/common.din               |  8 ++++++++
>  winsup/cygwin/include/cygwin/version.h |  6 ++++--
>  winsup/cygwin/include/limits.h         | 17 +++++++----------
>  winsup/cygwin/sysconf.cc               |  6 +++---
>  winsup/cygwin/thread.cc                |  4 ++--
>  winsup/doc/new-features.xml            |  6 ++++++
>  winsup/doc/posix.xml                   | 16 ++++++++--------
>  winsup/utils/strace.cc                 |  2 +-
>  9 files changed, 40 insertions(+), 26 deletions(-)

Perfect, just the text in release/2.11.0 is missing, but I can add
that, too, no worries.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--2/Dpz40iF3jpiHxF
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAltMq+sACgkQ9TYGna5E
T6DzlQ//bG9mkBlddfclnoRGoOM/PLkNlkn84LgHVFfgBWbl8lYQON+EfqX45lmu
AcxIDr99VU9Toe6UJY8OYcDnRbegQainJPnUgVwnre3G9JoR4p9vLoImGeV2DS19
FMhOAKGR6Nkmn5JELFOgMSKS6UTriAGVnUqXDCaewmdCMdXUh3hMlh32fhr9chOu
H0hflMw9joj0QL6B0dHB2DF24KJeExLpy+WnHkc2BQdb/jr0VGRVCSu+eAA+7O0g
SI+dgVbjv2Bv1vo/kl+nmaG+aNbyZn5+6Jy0Taqe1KOXIs78W+oatY1uodBRgX4L
bsaUQYaPj3lER5AXxKUpdDhAE8y3gcOJ9YInwhAAkDLyfG5NbDNx3EOD9uj7jFnJ
33HdZcF+rwYzO39Y3bcPBMh1s3dPvlT0VUX6Gnquz+BC76bkLUT8JeoJ6/XD/RwV
IUGglWLfC2fscjrLH6m7wQdmw6lJ8MX4eIaadOCizTXNUWpLM4QZXxEV1tYnVHg1
N5+1oN4+NzyTQwcn/6SkCRwCaTPft+IZSs55WLQCi9ozQCV75VeA1xs/Gxr+/hXF
64Lw3/LhyEZGU4ktYuYNCPftdXNORsUEgwy6wEHsvgHVhRgl5YixlGQYRgnPJE1l
/A2MazoGePd4S5ufpsICDLj6Rkuu6gaOjvajDlrFMYBdd9RIrtE=
=MGbH
-----END PGP SIGNATURE-----

--2/Dpz40iF3jpiHxF--
