Return-Path: <cygwin-patches-return-8939-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 51707 invoked by alias); 28 Nov 2017 10:54:37 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 51693 invoked by uid 89); 28 Nov 2017 10:54:36 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-124.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,KB_WAM_FROM_NAME_SINGLEWORD,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 28 Nov 2017 10:54:34 +0000
Received: from aqua.hirmke.de (business-24-134-7-25.pool2.vodafone-ip.de [24.134.7.25])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id 6B371721E281E	for <cygwin-patches@cygwin.com>; Tue, 28 Nov 2017 11:54:31 +0100 (CET)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id 76FE15E020F	for <cygwin-patches@cygwin.com>; Tue, 28 Nov 2017 11:54:28 +0100 (CET)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id EDE1EA8072C; Tue, 28 Nov 2017 11:54:30 +0100 (CET)
Date: Tue, 28 Nov 2017 10:54:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] cygwin: define _POSIX_TIMEOUTS
Message-ID: <20171128105430.GR547@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20171128101032.16540-1-yselkowi@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="Wb5NtZlyOqqy58h0"
Content-Disposition: inline
In-Reply-To: <20171128101032.16540-1-yselkowi@redhat.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-SW-Source: 2017-q4/txt/msg00069.txt.bz2


--Wb5NtZlyOqqy58h0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1905

On Nov 28 04:10, Yaakov Selkowitz wrote:
> Since commit 8128f5482f2b1889e2336488e9d45a33c9972d11, we have all the
> non-tracing functions listed in posixoptions(7).  The tracing functions
> are gated by their own option, and are obsolecent anyway.
>=20
> Signed-off-by: Yaakov Selkowitz <yselkowi@redhat.com>
> ---
>  newlib/libc/include/sys/features.h | 2 +-
>  winsup/cygwin/sysconf.cc           | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/newlib/libc/include/sys/features.h b/newlib/libc/include/sys=
/features.h
> index 084bf2183..2900b332f 100644
> --- a/newlib/libc/include/sys/features.h
> +++ b/newlib/libc/include/sys/features.h
> @@ -464,7 +464,7 @@ extern "C" {
>  #define _POSIX_THREAD_SAFE_FUNCTIONS		200809L
>  /* #define _POSIX_THREAD_SPORADIC_SERVER	    -1 */
>  #define _POSIX_THREADS				200809L
> -/* #define _POSIX_TIMEOUTS			    -1 */
> +#define _POSIX_TIMEOUTS				200809L
>  #define _POSIX_TIMERS				200809L
>  /* #define _POSIX_TRACE				    -1 */
>  /* #define _POSIX_TRACE_EVENT_FILTER		    -1 */
> diff --git a/winsup/cygwin/sysconf.cc b/winsup/cygwin/sysconf.cc
> index a24a98501..ecd9aeb93 100644
> --- a/winsup/cygwin/sysconf.cc
> +++ b/winsup/cygwin/sysconf.cc
> @@ -588,7 +588,7 @@ static struct
>    {cons, {c:SYMLOOP_MAX}},		/*  79, _SC_SYMLOOP_MAX */
>    {cons, {c:_POSIX_THREAD_CPUTIME}},	/*  80, _SC_THREAD_CPUTIME */
>    {cons, {c:-1L}},			/*  81, _SC_THREAD_SPORADIC_SERVER */
> -  {cons, {c:-1L}},			/*  82, _SC_TIMEOUTS */
> +  {cons, {c:_POSIX_TIMEOUTS}},		/*  82, _SC_TIMEOUTS */
>    {cons, {c:-1L}},			/*  83, _SC_TRACE */
>    {cons, {c:-1L}},			/*  84, _SC_TRACE_EVENT_FILTER */
>    {nsup, {c:0}},			/*  85, _SC_TRACE_EVENT_NAME_MAX */
> --=20
> 2.15.0

ACK


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--Wb5NtZlyOqqy58h0
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJaHUBmAAoJEPU2Bp2uRE+g5Z8P/AmjakAW6g3NonjyxeCvrwqs
heber7HSCoYBofZzpI+EMl8vnLrdHevy4nqeha37tnUTNgV/1rcoboPC51sgpYeG
d/BWyGp+/6XULmJKhai/hhkM2pwXP9Khl0BjFrUj/ffOBG/nEkGPgUiCBZQmBuPf
yExMRdiqA9OBpGvR1r1ouPvHT3c/hlnSdNXwJFr3YUo3HE54OL2qeHAfVyaTpk6h
wO3VC5z+8zStCtFce2iMRzS1GDZ34rIXTQpwtBUUWIHJ+MG/D6wATzEjQiqVDzTn
m0d0RnZupmCYZt8tcVBnmdbH775jvDc7nDuya+I2YhjBWcbU/PGM37ZDuW/tv9JC
Nq4OL6EQEPexAhs50Fz7WB+7dG7TGf0LN67mXJkoISNK/gCzyGrmNpzduGEwifgS
R0pgqm8R5jA4xzhfh5XQiYL1lEIhDgCaEJGuo0+CMEKQlbd595rnfL7FbnwF3k8F
GzPHXeRz+/5koOs8UUwVvW5eMd1jvRPmYoD8B7f/LpEKBfMqSwdgHsd/uWSBK3pK
H4mhLGboteV65LL+MfZSlEFQIcqKEuGFKmFmiLs5xGXQDdof0UHEItoZ6gV8GZbD
i3sC2Nq3PBKo6/MFyiQdw6tDESAlAnW3VPpwX5MjUu17P3Xcv0azJ9VGsHsb8vzZ
CdYpaWqZVP8tHvnA5ECp
=xMy5
-----END PGP SIGNATURE-----

--Wb5NtZlyOqqy58h0--
