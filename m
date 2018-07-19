Return-Path: <cygwin-patches-return-9132-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 104413 invoked by alias); 19 Jul 2018 11:19:35 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 104392 invoked by uid 89); 19 Jul 2018 11:19:34 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-123.7 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2 spammy=Hx-languages-length:933
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.17.24) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 19 Jul 2018 11:19:33 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue104 [212.227.15.183]) with ESMTPSA (Nemesis) id 0M1od8-1g0XCS1Qh0-00tmMO for <cygwin-patches@cygwin.com>; Thu, 19 Jul 2018 13:19:30 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id A0FDDA80782; Thu, 19 Jul 2018 13:19:29 +0200 (CEST)
Date: Thu, 19 Jul 2018 11:19:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] fix duration handling in sigtimedwait
Message-ID: <20180719111929.GA24725@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20180718112628.GI27673@calimero.vinschen.de> <20180719093540.5156-1-mark@maxrnd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Content-Disposition: inline
In-Reply-To: <20180719093540.5156-1-mark@maxrnd.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SW-Source: 2018-q3/txt/msg00027.txt.bz2


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1003

On Jul 19 02:35, Mark Geisert wrote:
> ---
>  winsup/cygwin/signal.cc | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/winsup/cygwin/signal.cc b/winsup/cygwin/signal.cc
> index e581d28da..de3e88697 100644
> --- a/winsup/cygwin/signal.cc
> +++ b/winsup/cygwin/signal.cc
> @@ -640,6 +640,8 @@ sigtimedwait (const sigset_t *set, siginfo_t *info, c=
onst timespec *timeout)
>        waittime.QuadPart =3D (LONGLONG) timeout->tv_sec * NS100PERSEC
>                            + ((LONGLONG) timeout->tv_nsec + (NSPERSEC/NS1=
00PERSEC) - 1)
>  			    / (NSPERSEC/NS100PERSEC);
> +      /* negate waittime to code as duration for NtSetTimer() below cygw=
ait() */
> +      waittime.QuadPart =3D -waittime.QuadPart;
>      }
>=20=20
>    return sigwait_common (set, info, timeout ? &waittime : cw_infinite);
> --=20
> 2.17.0

Pushed.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAltQc8EACgkQ9TYGna5E
T6A5Qw//c+ZvuNmbly8lgguT6UdeOSEI+Suuqrd9zLDDXaYKhbYlU1HyziVj+gkh
7nHZyDL95eg4riiyr3rRVAtkduSCPlz/lwcrXRP5MN8GtAaQC17vH1fRs8ic5nRi
GO1HZDTVDMl3b2Ym10IQv30q7U3Oh6AIlMGGoDBdZHPP5R44QglYPAEcjjYrTK3/
aCLYSs9BOpS/VVn6x0HCCpeXAHmuEA+7wHG/4y8Ov2TObGJxG1iTMmF7qWE4hhJV
Wl0JmyyqKw/xOpjp7FdGnkAL6LViGWHBiRiu95NPhQJGtiPGTzsOSLigcwHG35c8
6+5n6A8Gj9LNOabNoY3XfjEgAvChCclSZOf7imT6fF3rWluXP6hqlBJdcvbIf6VL
kt1+VN8qSPPVluoMqJndQXudRVcnfwblYtT/gVnLIr1bavZaU67ncDq8gDxiNl+w
ZMdeo4pPmZodQcw5HBPRsIgBcUIZwouSxcQTu+EcQps/CHY/0ld5GjAQU9wPo0KG
CICYVFmpBC1Lk247nvOVflfGSDrlRmDCzhk0XZ+sqOipFCWyByxBJw98jk4I+M9M
cmg4H5NTHxLWKowjAlhKxuB6xpw3d8O81K1dv8yiT0yYc/q6OD55rO+1sufw5nvG
+B/M4Rcvg/lSHvpZConf2lQyD/OA3BUXFIdtBsiUKwZgJduXcQI=
=Stri
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--
