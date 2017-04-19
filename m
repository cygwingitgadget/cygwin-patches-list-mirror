Return-Path: <cygwin-patches-return-8745-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 61585 invoked by alias); 19 Apr 2017 18:48:35 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 48101 invoked by uid 89); 19 Apr 2017 18:48:17 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-124.3 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 19 Apr 2017 18:48:15 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id 4AE24721E281E	for <cygwin-patches@cygwin.com>; Wed, 19 Apr 2017 20:48:14 +0200 (CEST)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id 984B15E0418	for <cygwin-patches@cygwin.com>; Wed, 19 Apr 2017 20:48:13 +0200 (CEST)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 7EBB3A80C15; Wed, 19 Apr 2017 20:48:13 +0200 (CEST)
Date: Wed, 19 Apr 2017 18:48:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] strace: Fix "over-optimization" flaw in strace.
Message-ID: <20170419184813.GH30642@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20170418100400.GA29220@calimero.vinschen.de> <20170419160602.3952-1-daniel.santos@pobox.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="0XhtP95kHFp3KGBe"
Content-Disposition: inline
In-Reply-To: <20170419160602.3952-1-daniel.santos@pobox.com>
User-Agent: Mutt/1.8.0 (2017-02-23)
X-SW-Source: 2017-q2/txt/msg00016.txt.bz2


--0XhtP95kHFp3KGBe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1016

On Apr 19 11:06, Daniel Santos wrote:
> Recent versions of gcc are optimizing away the TLS buffer allocated in
> main, so we need to tell gcc that it's really used.  RtlSecureZeroMemory
> accomplishes this while also inlining the memset.
>=20
> Signed-off-by: Daniel Santos <daniel.santos@pobox.com>
> ---
>  winsup/utils/strace.cc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/winsup/utils/strace.cc b/winsup/utils/strace.cc
> index beab67b90..ae62cdc5f 100644
> --- a/winsup/utils/strace.cc
> +++ b/winsup/utils/strace.cc
> @@ -1191,7 +1191,7 @@ main (int argc, char **argv)
>       registry setting to 0x100000 (TOP_DOWN). */
>    char buf[CYGTLS_PADSIZE];
>=20=20
> -  memset (buf, 0, sizeof (buf));
> +  RtlSecureZeroMemory (buf, sizeof (buf));
>    exit (main2 (argc, argv));
>  }
>=20=20
> --=20
> 2.11.0

Pushed.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--0XhtP95kHFp3KGBe
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY97DtAAoJEPU2Bp2uRE+gMPoP/1TCiiHCf7SV09HY0pxyCgsO
loY0p7EYI1AZLJLD66+Ta0RImbT++8P1WWJO5jVBqLsO/2vmK7eY0gW6EczmI1kk
rcfUS5p4cOCqmjJdyfCYNiyPy+nIUHnVTLk0jj5k10FQlfB00VRXgrHp2AV62nFt
J8U14WN05WT7E9QZyPstJkDBDZozbijrV+B4H630e/VpJjbQ63zsu7jD0DuEMjP4
FoIqZv6DpMjvC5YDgW8i3eccp/scT+Pp0MvOi/ObIdODv5Jn8cKynWsUMOlSbpA4
aJD+xaHsJySTSKDMtdpcRGGiJcs+JAi9KLCeeGx89rljEVREVIq/X/FFhvUyQq7i
Eg/tPrD4uQMFTATx2kMsh8QS4RU3oef8uBSpwAIC/qe+KqKwg+lVaezeYBdPa3Ts
/J25GCc3Nq1nuldmVNdPER/5M+jD0gjlWmZxfuHGWQd2Wqu9LmZSN0o4H6eSgPj4
NLX43LiYBLvPQ9EDnZY9FcPrHZrh3nUDBegJkJuCBWHz3lcveav8BfF5Gau392hm
y+vQ7O096q90zsMEN/vNmHkddztXGJg34y4LH4z3hZkNKK0AWk9myaHH8uSB6+b1
GvBmszP2iyEfnq8uYj9X9YfAC96/9nL7KMkwlCpwhsZ1CztonZa3yTE9XlVNNwTp
tqqejo0fmzsOP8Hzoy/e
=s7y0
-----END PGP SIGNATURE-----

--0XhtP95kHFp3KGBe--
