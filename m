Return-Path: <cygwin-patches-return-8876-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1798 invoked by alias); 10 Oct 2017 11:48:37 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 1786 invoked by uid 89); 10 Oct 2017 11:48:37 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-124.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=H*R:D*cygwin.com, H*c:application, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 10 Oct 2017 11:48:36 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id E9A11721BBD35	for <cygwin-patches@cygwin.com>; Tue, 10 Oct 2017 13:48:32 +0200 (CEST)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id 3A2775E039E	for <cygwin-patches@cygwin.com>; Tue, 10 Oct 2017 13:48:32 +0200 (CEST)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 2C7C3A80665; Tue, 10 Oct 2017 13:48:32 +0200 (CEST)
Date: Tue, 10 Oct 2017 11:48:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] cygwin: fix potential buffer overflow in fork
Message-ID: <20171010114832.GB30630@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1b4e1413-fa59-a954-f839-507abce7df11@ssi-schaefer.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="Yylu36WmvOXNoKYn"
Content-Disposition: inline
In-Reply-To: <1b4e1413-fa59-a954-f839-507abce7df11@ssi-schaefer.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-SW-Source: 2017-q4/txt/msg00006.txt.bz2


--Yylu36WmvOXNoKYn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1581

Hi Michael,

On Oct  9 18:58, Michael Haubenwallner wrote:
> When fork fails, we can use "%s" now with system_sprintf for the errmsg
> rather than a (potentially too small) buffer for the format string.

How could buf be too small?

>=20
> * fork.cc (fork): Use "%s" with system_printf now.
> ---
>  winsup/cygwin/fork.cc | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
>=20
> diff --git a/winsup/cygwin/fork.cc b/winsup/cygwin/fork.cc
> index 73a72f530..bcbef12d8 100644
> --- a/winsup/cygwin/fork.cc
> +++ b/winsup/cygwin/fork.cc
> @@ -618,13 +618,8 @@ fork ()
>        if (!grouped.errmsg)
>  	syscall_printf ("fork failed - child pid %d, errno %d", grouped.child_p=
id, grouped.this_errno);
>        else
> -	{
> -	  char buf[strlen (grouped.errmsg) + sizeof ("child %d - , errno 429496=
7295  ")];
> -	  strcpy (buf, "child %d - ");
> -	  strcat (buf, grouped.errmsg);
> -	  strcat (buf, ", errno %d");
> -	  system_printf (buf, grouped.child_pid, grouped.this_errno);
> -	}
> +	system_printf ("child %d - %s, errno %d", grouped.child_pid,
> +		       grouped.errmsg, grouped.this_errno);
>=20=20
>        set_errno (grouped.this_errno);
>      }
> --=20
> 2.14.2

I guess this also means we can drop the if/else, kind of like

  system_printf ("child %d %s%s, errno %d",
		 grouped.child_pid,
		 grouped.errmsg ? "- " : "",
		 grouped.errmsg ?: "",
		 grouped.this_errno);

What do you think?


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--Yylu36WmvOXNoKYn
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZ3LOPAAoJEPU2Bp2uRE+gcyYP/iqQKRZ20OZHvO8+z/4uIoKU
cE3/F2n5omAMSOc9smm5maX934J6ckoFa27R+tgV2p81LwBp5ZgT5gvBW/uACsOL
VLyLguqCjt5kf5Qv7cdwikwkpa8zJbiclg+q0AQWxbNe4TzBbl6qkym0Cq3pEYVL
WDIPhthE2G0GHMrSRRwXZ7QiSMsJTQBpbLpMpBm3mYJQC2HWdy1NOTsV5qhpHZRe
sxEGcVSxjw56QPiJwky7T8uK1vqyKrlpDw3/EN5kq1usX0zAPkPH5sRriWaedvmI
B9Je5BvoSlC5q4feyIJW3VASLPcnmi2e3vH2fjbKZnijosxm3WNRymKHVEn6Wt2H
gatO1CMM20EMptZQdtRND9BiFTrZa6Y7JzTkZ/ApdZ84Ly+Zq3zvy7mLXXACItuw
nb9ATNmSeX5L/5v9mnzJmEYuZLOrtUcescdscMeanWOp2o32d7mlM339/L0mIDFd
NEzIKtiCdYy6ZX2WLok/8FPhxzj7GcK5qwBJb07qPcb9M3BxMSAEaLyJGfOnsJrs
ghM5nbcEbs1V+doQaxKJzZGQbuX0vuN8jPLRuNWtiz4NyTfvFhvuiNLVv5sIaT15
EhrORy25JvvIcTN9u4x+xuaHpBY4LqH8BWFszrTmdS2H1WxjtiQJ3TResUwc64ea
xic6PrLqbjCcL47EJ9tI
=+TLj
-----END PGP SIGNATURE-----

--Yylu36WmvOXNoKYn--
