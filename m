Return-Path: <cygwin-patches-return-8399-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 113565 invoked by alias); 15 Mar 2016 09:03:54 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 113526 invoked by uid 89); 15 Mar 2016 09:03:53 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-96.6 required=5.0 tests=BAYES_00,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC,USER_IN_WHITELIST autolearn=no version=3.3.2 spammy=HX-Envelope-From:sk:corinna, ACK, H*R:U*cygwin-patches, H*R:D*cygwin.com
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 15 Mar 2016 09:03:51 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 92681A8034F; Tue, 15 Mar 2016 10:03:49 +0100 (CET)
Date: Tue, 15 Mar 2016 09:03:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: define byteswap.h inlines as macros
Message-ID: <20160315090349.GA7819@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1458011636-8548-1-git-send-email-yselkowi@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
In-Reply-To: <1458011636-8548-1-git-send-email-yselkowi@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q1/txt/msg00105.txt.bz2


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1873

On Mar 14 22:13, Yaakov Selkowitz wrote:
> The bswap_* "functions" are macros in glibc, so they may be tested for
> by the preprocessor (e.g. #ifdef bswap_16).
>=20
> Signed-off-by: Yaakov Selkowitz <yselkowi@redhat.com>
> ---
>  winsup/cygwin/include/byteswap.h | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>=20
> diff --git a/winsup/cygwin/include/byteswap.h b/winsup/cygwin/include/byt=
eswap.h
> index cd5a726..9f73c5a 100644
> --- a/winsup/cygwin/include/byteswap.h
> +++ b/winsup/cygwin/include/byteswap.h
> @@ -16,23 +16,27 @@ extern "C" {
>  #endif
>=20=20
>  static __inline unsigned short
> -bswap_16 (unsigned short __x)
> +__bswap_16 (unsigned short __x)
>  {
>    return (__x >> 8) | (__x << 8);
>  }
>=20=20
>  static __inline unsigned int
> -bswap_32 (unsigned int __x)
> +__bswap_32 (unsigned int __x)
>  {
> -  return (bswap_16 (__x & 0xffff) << 16) | (bswap_16 (__x >> 16));
> +  return (__bswap_16 (__x & 0xffff) << 16) | (__bswap_16 (__x >> 16));
>  }
>=20=20
>  static __inline unsigned long long
> -bswap_64 (unsigned long long __x)
> +__bswap_64 (unsigned long long __x)
>  {
> -  return (((unsigned long long) bswap_32 (__x & 0xffffffffull)) << 32) |=
 (bswap_32 (__x >> 32));
> +  return (((unsigned long long) __bswap_32 (__x & 0xffffffffull)) << 32)=
 | (__bswap_32 (__x >> 32));
>  }
>=20=20
> +#define bswap_16(x) __bswap_16(x)
> +#define bswap_32(x) __bswap_32(x)
> +#define bswap_64(x) __bswap_64(x)
> +
>  #ifdef __cplusplus
>  }
>  #endif
> --=20
> 2.7.0

ACK.

While we're at it, what about converting the types to implicit types
(__uint16_t, __uint32_t, __uint64_t).  Also, do we want to convert the
inline code to use the x86 bswap instructions?


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW58/1AAoJEPU2Bp2uRE+g6AQP/RnaDZ1SdTXJ/m1IXJ8mCQ6M
arIV/knPXZ8f51PqzKLTZ7Rz8Q6cXxqmhvm2onDevPx3mG4GhN3tyWRPTwGpZnqn
zMv4AnJct3X03siHQ0iDfBaAv+n0jHuZu6B0pFatEyncEpl6udgg7oJLQXfY1RHY
raeJ++bcoVBlEoGY+4LdK2eTAofPXYtujoq2bDYk9G+emiRGnDF/JKke02zGCamP
7TKsu2C+FxfPDH+35+TEmbx6iyfZruIyDCAVJ8FrCN2WYdqOvM4efPFPjnbmiTJD
b40lTqYTFtEguUtsBK1ZmIiNAtqVd94J1M/vQodGT9RTOKX1QPhvEcc9+1YvYsw/
gpcLrZbGo+7EiB5DeXPQ4ONN69126k4u/Q3Egukeh6efs4ElzKgNKWWWPdc+LyHe
i/Evmf7IVvnBj9Q5o6Ox6VJzER7npNRW5fbgkD+xT3THWaN3WSvUUiPGJU4aLqlh
eYknl8n6kxSwOiXSpmldbin3L9Ayz2Ao69S2Dr406MF8fSqHF50dP9uAfSmtrX3N
MWnWGMKqwNNeoEldUkUBJpdLyCzopXnhjWOGlrZ7EpxeDx10NJAepOoDMTLInHaK
gIkJRG31dRxLl3Yi9AyDQQp/sw1OxTk7I8nXL/s1gYMzoQ2ZkPSkpeDv6gs0zdIt
ctNORxQt86KBnzPn4O79
=aoPv
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
