Return-Path: <cygwin-patches-return-8284-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 123417 invoked by alias); 14 Dec 2015 09:25:11 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 121928 invoked by uid 89); 14 Dec 2015 09:25:10 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=4.1 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC autolearn=no version=3.3.2
X-HELO: calimero.vinschen.de
Received: from ipbcc02fe8.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.47.232) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 14 Dec 2015 09:25:09 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 34ECDA80645; Mon, 14 Dec 2015 10:25:07 +0100 (CET)
Date: Mon, 14 Dec 2015 09:25:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Trivial fix to last change
Message-ID: <20151214092507.GD3507@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <566B4AB2.1000905@cornell.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="RYJh/3oyKhIjGcML"
Content-Disposition: inline
In-Reply-To: <566B4AB2.1000905@cornell.edu>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q4/txt/msg00037.txt.bz2


--RYJh/3oyKhIjGcML
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1841

On Dec 11 17:14, Ken Brown wrote:
> cygwin1.dll doesn't build on x86 after the last commit (eed35ef).  The
> trivial patch attached fixes it.
>=20
> Ken

> From 1cd61c54994b2ba6c6ec1d1f8f1249f5f8fd4af3 Mon Sep 17 00:00:00 2001
> From: Ken Brown <kbrown@cornell.edu>
> Date: Fri, 11 Dec 2015 17:08:28 -0500
> Subject: [PATCH] Fix regparm attribute of fhandler_base::fstat_helper
>=20
> * winsup/cygwin/fhandler_disk_file.cc (fhandler_base::fstat_helper):
> Align regparm attribute to declaration in fhandler.h.
> ---
>  winsup/cygwin/ChangeLog             | 5 +++++
>  winsup/cygwin/fhandler_disk_file.cc | 2 +-
>  2 files changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/winsup/cygwin/ChangeLog b/winsup/cygwin/ChangeLog
> index 3c9804b..7079baa 100644
> --- a/winsup/cygwin/ChangeLog
> +++ b/winsup/cygwin/ChangeLog
> @@ -1,3 +1,8 @@
> +2015-12-11  Ken Brown  <kbrown@cornell.edu>
> +
> +	* fhandler_disk_file.cc (fhandler_base::fstat_helper): Align
> +	regparm attribute to declaration in fhandler.h.
> +
>  2015-12-10  Corinna Vinschen  <corinna@vinschen.de>
>=20=20
>  	* path.h (class path_conv_handle): Use FILE_ALL_INFORMATION instead of
> diff --git a/winsup/cygwin/fhandler_disk_file.cc b/winsup/cygwin/fhandler=
_disk_file.cc
> index fe9dd03..1dd1b8c 100644
> --- a/winsup/cygwin/fhandler_disk_file.cc
> +++ b/winsup/cygwin/fhandler_disk_file.cc
> @@ -428,7 +428,7 @@ fhandler_base::fstat_fs (struct stat *buf)
>    return res;
>  }
>=20=20
> -int __reg3
> +int __reg2
>  fhandler_base::fstat_helper (struct stat *buf)
>  {
>    IO_STATUS_BLOCK st;
> --=20
> 2.6.2
>=20

Applied.  I really should build on *both* architectures before applying
a patch :-P


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--RYJh/3oyKhIjGcML
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWborzAAoJEPU2Bp2uRE+gcAAP/1aMraDq2PVnO6HlRoykenas
y3Y7JZsss5gfLB7AzORJdlkD28OKKn2LZ2NrCQ4BjXJrSe1gW33+QDFsxKnSMCpf
hPTvTr8pIIV2c29ObXcjkmFsI2QAUsctf0ih2Hzq8aVbm8CHokXZkkT8lNcrnS3Z
BwnnpuLZ7Qaeze/76bJzEJxE9QCVzZML51BjaUyb3iVv8XM4X+1+YY/EsFBG5yMt
dcBqh5uIjREmBgavkhQP2tngM+UEu4fontlTAmK/dycQG3KYM3g0IoMkl+TrDO1n
Coa29xEjat4zgXw1b1JKYEqWzkhluNCzG7ITlVMZkwpdCN1ngxCUP/1gibCNGbAI
WxFVBRpSGDUc22bSE6uNWbO3wEAENLKftoTKlFG6xaMHjRS5mlM6RUA90gOW4n4/
tJT7cVqr2Bu2p8HSgWrEa2tVVk/VSDJNYh00ETRWcmm0fuLUCJJXAD3F7TGIBoGM
FAECs3bt3yAH1HE+GrXZf/1xA2BNC43FsGRFgNCPtPLF89+UBORgrrgrOhYdQXha
dAtJ0nadHs8NmKbHyoNBr3iR1ULQMCxsYSenywPbiFgPsXBvCQJJDSrxBn2C2VUo
1Erq5a6jYB+hIW9kVXzcHs+VEZ1vBGcwzv92WdA4jerATLf+BkznTPCrB3MEC7LD
e1d3sEaT4o1yfZ+ODY/L
=GUIC
-----END PGP SIGNATURE-----

--RYJh/3oyKhIjGcML--
