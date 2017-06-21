Return-Path: <cygwin-patches-return-8796-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 38139 invoked by alias); 21 Jun 2017 20:48:42 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 37929 invoked by uid 89); 21 Jun 2017 20:48:33 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-124.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=para, H*c:application, authorization, H*Ad:U*cygwin-patches
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 21 Jun 2017 20:48:18 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id 272D4721E282F	for <cygwin-patches@cygwin.com>; Wed, 21 Jun 2017 22:48:08 +0200 (CEST)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id 8F8C45E08AC	for <cygwin-patches@cygwin.com>; Wed, 21 Jun 2017 22:48:07 +0200 (CEST)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 8E413A80581; Wed, 21 Jun 2017 22:48:07 +0200 (CEST)
Date: Wed, 21 Jun 2017 20:48:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Update documentation of cygwin setup proxy configuration details
Message-ID: <20170621204807.GC1595@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20170621183545.211512-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="Bu8it7iiRSEf40bY"
Content-Disposition: inline
In-Reply-To: <20170621183545.211512-1-jon.turney@dronecode.org.uk>
User-Agent: Mutt/1.8.0 (2017-02-23)
X-SW-Source: 2017-q2/txt/msg00067.txt.bz2


--Bu8it7iiRSEf40bY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1638

On Jun 21 19:35, Jon Turney wrote:
> Signed-off-by: Jon Turney <jon.turney@dronecode.org.uk>
> ---
>  winsup/doc/setup-net.xml | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
>=20
> diff --git a/winsup/doc/setup-net.xml b/winsup/doc/setup-net.xml
> index 211bbed69..82b1e0dc9 100644
> --- a/winsup/doc/setup-net.xml
> +++ b/winsup/doc/setup-net.xml
> @@ -132,14 +132,11 @@ or in case you need to reinstall a package.
>=20=20
>  <sect2 id=3D"setup-connection"><title>Connection Method</title>
>  <para>
> -The <literal>Direct Connection</literal> method of downloading will=20
> -directly download the packages, while the IE5 method will leverage your=
=20
> -IE5 cache for performance. If your organisation uses a proxy server or
> -auto-configuration scripts, the IE5 method also uses these settings.
> -If you have a proxy server, you can manually type it into=20
> -the <literal>Use Proxy</literal> section. Unfortunately,=20
> -<command>setup.exe</command> does not currently support password
> -authorization for proxy servers.
> +The <literal>Direct Connection</literal> method of downloading will
> +directly connect.  If your system is configured to use a proxy server or
> +auto-configuration scripts, the <literal>Use System Proxy Settings</lite=
ral>
> +method uses those settings.  Alternatively, you can manually enter proxy
> +settings into the <literal>Use HTTP/FTP Proxy</literal> section.
>  </para>
>  </sect2>
>=20=20
> --=20
> 2.12.3

ACK


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--Bu8it7iiRSEf40bY
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZStuHAAoJEPU2Bp2uRE+g/yAP/3HUOmd3ZAzA+4Zhd5OeH6eV
B+RoD7R7Qdyqj7SBwQCJJ8DPnptBRZkd+Au5glGWcFQ7/v8izJ1p1N7/gyHvHFYI
XCCen4ycuRjc0DaC+bWyXcW0MRsiAroh04w/ZCTNSzy0kQKGw4Yyhlqt/xmCCQL/
a7bSfi+rIHS47egVG43Yy9Xq14ESnzRHOEASHU7uPySzpfUpFKnJncNvbdSWwYFc
6TpRHjIKz9Fx+WZFfvmls2dECqgLXHmuUMLlR5S7IV9ehap2knMlyX6n++TRvGqe
Mk3Gps4qz9IrxlOIwO3I2vGePBEzh6R+wDL6tatFGt6Iey9xzaKkQkgdUjXBpt5c
s5+aIMvI7D4DatF/lYFQ92unsh8Zd5HkTEAM91TUfip4G5MrsbW9+JFwNegP+1Rv
wmDuA3Pmu8nQdZ+OQX6wLNzRjr5JXlhTV2TOgJ+xp5fGyEixUD7ZmqXIIs33EkKg
Fe5FMfkkFzSLHS4aLf82zmf0PoZFrBOVOrbYkc0U7pxer49+wEjogQdHemEOBu/a
8yAXzZz4GZcBcxFhpEOHlIe4zi1/YgP+eNwl3daHnh67ahYiWOJSNuw7GzNClTUy
Qb96627bzcVyfQeEn2lxb/K8geORIkTdOmUpRDFbj3ASuHJdOPY+fMSK8vhl0CUk
4KAOGHcdLnJ9j1FUEx4q
=e3R8
-----END PGP SIGNATURE-----

--Bu8it7iiRSEf40bY--
