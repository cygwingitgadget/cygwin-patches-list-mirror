Return-Path: <cygwin-patches-return-8300-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9944 invoked by alias); 12 Feb 2016 09:31:27 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 9928 invoked by uid 89); 12 Feb 2016 09:31:26 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-96.6 required=5.0 tests=BAYES_00,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC,USER_IN_WHITELIST autolearn=no version=3.3.2 spammy=H*c:HHNHHH, H*F:U*corinna-cygwin, san, 500000
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 12 Feb 2016 09:31:26 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 2BF54A80562; Fri, 12 Feb 2016 10:31:24 +0100 (CET)
Date: Fri, 12 Feb 2016 09:31:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] cygwin: fix errors with GCC 5
Message-ID: <20160212093124.GB19968@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1455244017-11296-1-git-send-email-yselkowi@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="A6N2fC+uXW/VQSAv"
Content-Disposition: inline
In-Reply-To: <1455244017-11296-1-git-send-email-yselkowi@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q1/txt/msg00006.txt.bz2


--A6N2fC+uXW/VQSAv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1587

Hi Yaakov,

On Feb 11 20:26, Yaakov Selkowitz wrote:
> GCC 5 switched from C89 to C11 by default, which implies a change from
> GNU to C99 inline.
>=20
> 	winsup/cygwin/
> 	* exceptions.cc (exception::handle): Fix always-true boolean
> 	comparison warning.
> 	* include/cygwin/config.h (__getreent): Mark gnu_inline.
> 	* winbase.h (ilockcmpexch, ilockcmpexch64): Ditto.
>=20
> Signed-off-by: Yaakov Selkowitz <yselkowi@redhat.com>
> ---
>  winsup/cygwin/exceptions.cc           | 2 +-
>  winsup/cygwin/include/cygwin/config.h | 1 +
>  winsup/cygwin/winbase.h               | 2 ++
>  3 files changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
> index c3a45d2..a50973b 100644
> --- a/winsup/cygwin/exceptions.cc
> +++ b/winsup/cygwin/exceptions.cc
> @@ -645,7 +645,7 @@ exception::handle (EXCEPTION_RECORD *e, exception_lis=
t *frame, CONTEXT *in,
>      me.andreas->leave ();	/* Return from a "san" caught fault */
>  #endif
>=20=20
> -  if (debugging && ++debugging < 500000)
> +  if (debugging && ++debugging)

This is not the right fix.  debugging is still a bool and you changed
the condition just to get rid of the warning.  The right fix is to keep
the condition and change the type of debugging to, e.g, int.  The
gnu_inline snippets are ok, but I'd like to see a description of what
effect this is fixing in the git comment, for future reference.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--A6N2fC+uXW/VQSAv
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWvaZsAAoJEPU2Bp2uRE+gtbQP+wTiu+bAuFaBfR0wkx3/s5Qv
IAzHUYOLsDqped6xMsEU05YtwjtUS/HKwiGO3QGt0txchLrwEgcxHvULywni/YfN
7QZJnw/tHQzSzYe/qiO2SsIZGQPUCDlyXaIxH3h0VqHR0pITyeWfZiulesyED1bh
d9q95Ox2RLGLjrIqMJ16D0hd+4OP9U9fb5ZzXqK1Ob825tCR+5mSDqKtMCmREaAe
jvQMw8M35d5zmpfkcUthyd+7ZE3lyM4/gZK/WlPnD7vKsFU6QaPPBOeNi5VMyzFT
BhP2FN/fhjD6B2NwYVQWPpYOzSCPmFFpNpMQt109eHuzpQUQxQj3+R3MY+N/Ia1a
/v/4YZ2QebAd1EUipLusMPEhso72MKLCDD71acST7u3wNtclZ+Fr5UN9L8JF3GG9
3ld1UUTCi2xvQZruHP6PJgMnfjyt8j0KOvaIsrDGha3pYI2ETOe909r27AFca8Z2
EGHa844l6U7GQmWuDKiU1lIdQlZFkh9or7mD6JirwkVvR842z9EGYr4LxjcHCcp2
dtHvaeVwzskMWNMgSJkj0FnJc4YIRsbUk76iuZkhyNiQ0mNVtaNDJQXLo60DYciI
CqN10hwlrgzDAZ0RfVBipzxitw63QcKhNowpTYLSP8j0TDlU6cCOvwJrOGvdxLaq
IaAXhX0+SPAG4Akd8WNU
=mw38
-----END PGP SIGNATURE-----

--A6N2fC+uXW/VQSAv--
