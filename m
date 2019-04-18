Return-Path: <cygwin-patches-return-9361-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 68990 invoked by alias); 18 Apr 2019 17:36:12 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 68981 invoked by uid 89); 18 Apr 2019 17:36:12 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-117.0 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*F:D*cygwin.com
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.17.10) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 18 Apr 2019 17:36:10 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MA844-1h6hdl2ZFC-00Bcxo for <cygwin-patches@cygwin.com>; Thu, 18 Apr 2019 19:36:07 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id CAD4CA8075A; Thu, 18 Apr 2019 19:36:06 +0200 (CEST)
Date: Thu, 18 Apr 2019 17:36:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: FIFO: avoid hang after exec
Message-ID: <20190418173606.GH3599@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20190418153941.2171-1-kbrown@cornell.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="Pa4xkLBhPDIhDLv1"
Content-Disposition: inline
In-Reply-To: <20190418153941.2171-1-kbrown@cornell.edu>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q2/txt/msg00068.txt.bz2


--Pa4xkLBhPDIhDLv1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1594

On Apr 18 15:39, Ken Brown wrote:
> Define fhandler:fifo::fixup_after_exec, which sets listen_client_thr
> and lct_termination_evt to NULL.  This forces the listen_client thread
> to restart on the first attempt to read after an exec.  Previously the
> exec'd process could hang in fhandler_fifo::raw_read.
> ---
>  winsup/cygwin/fhandler.h       | 1 +
>  winsup/cygwin/fhandler_fifo.cc | 9 +++++++++
>  2 files changed, 10 insertions(+)
>=20
> diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
> index 8fb176b24..da007ee45 100644
> --- a/winsup/cygwin/fhandler.h
> +++ b/winsup/cygwin/fhandler.h
> @@ -1301,6 +1301,7 @@ public:
>    ssize_t __reg3 raw_write (const void *ptr, size_t ulen);
>    bool arm (HANDLE h);
>    void fixup_after_fork (HANDLE);
> +  void fixup_after_exec ();
>    int __reg2 fstatvfs (struct statvfs *buf);
>    void clear_readahead ()
>    {
> diff --git a/winsup/cygwin/fhandler_fifo.cc b/winsup/cygwin/fhandler_fifo=
.cc
> index 1d02adbaa..bc9c23998 100644
> --- a/winsup/cygwin/fhandler_fifo.cc
> +++ b/winsup/cygwin/fhandler_fifo.cc
> @@ -942,6 +942,15 @@ fhandler_fifo::fixup_after_fork (HANDLE parent)
>    fifo_client_unlock ();
>  }
>=20=20
> +void
> +fhandler_fifo::fixup_after_exec ()
> +{
> +  fhandler_base::fixup_after_exec ();
> +  listen_client_thr =3D NULL;
> +  lct_termination_evt =3D NULL;
> +  fifo_client_unlock ();
> +}
> +
>  void
>  fhandler_fifo::set_close_on_exec (bool val)
>  {
> --=20
> 2.17.0

Pushed.  Developer snapshots should be up in 15 mins, give or take.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--Pa4xkLBhPDIhDLv1
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAly4tYYACgkQ9TYGna5E
T6Bh4g/+Mfp7aV+T8hjJilI5L3DLsU6m5wSoKsAOzNoNbXeuxlnlG9b/qENnNMhK
BSDprT09n4FH5hyn2vctrdrwT54uyEXOwuo1oQSHAlnj2sj/Z1X4Ug+MqGG2a3sM
dOMoz69YdIsuxj0T1uvex8HcGbfEZmKyEdGmMUOUx4V2R2dPViQ7VaO7c+vL3z4i
J1Q1/VZATccYv2d7QJixvCPZ4pOGHmCvYTX8kP89ntOWFWbmv2EHcM5lwCtTsEbq
PMP9G4nFdOSo3dxZ+abxft7ZhVXCxu3x1KMyVz6EhDu90eGkz/ke1qhXypSYcjfo
G2bpbdX1H9CJEdF+9aDfu68lt2au8+cwRm821Z0p5uM+ZZgFUeia+dbIBgjAELa8
OunC/4CnpGSC0mawN8kBaYsjBjg50UBKHXjZBSMtA8+STK6k8nWrGUYQxvdfWwNH
FbbqFOMpHIVTLEKFlZjT5nCJYyVUggqWgv5jZgn98m4dy2Muopov9nvDKpOgCjPK
kbjI/TngAj4CVOpnyU03krfYedLMZYxbkI3nj4jkzZ6w5Mcu5oMESn9h4l0xtbgD
AHJXXSSN9M5YDxntdBP7V9IAiV/l/MfAeid34WKEZdzikLUHGDyF+W8RcF61CeI6
ejyZRLnRUYnCVxbkrIBGR8IoqKl4c3C1JsQdgZGkovtW4W77Sro=
=zovy
-----END PGP SIGNATURE-----

--Pa4xkLBhPDIhDLv1--
