Return-Path: <cygwin-patches-return-8062-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 102196 invoked by alias); 10 Mar 2015 20:24:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 102183 invoked by uid 89); 10 Mar 2015 20:24:47 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.9 required=5.0 tests=AWL,BAYES_00 autolearn=ham version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 10 Mar 2015 20:24:46 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id DA04DA8092D; Tue, 10 Mar 2015 21:24:37 +0100 (CET)
Date: Tue, 10 Mar 2015 20:24:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] cygwin: fix __x86_64__ conditional in stdint.h
Message-ID: <20150310202437.GA3800@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1426004792-11916-1-git-send-email-yselkowi@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;	protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Content-Disposition: inline
In-Reply-To: <1426004792-11916-1-git-send-email-yselkowi@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q1/txt/msg00017.txt.bz2


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1344

On Mar 10 11:26, Yaakov Selkowitz wrote:
> Signed-off-by: Yaakov Selkowitz <yselkowi@redhat.com>
> ---
>  winsup/cygwin/ChangeLog        | 4 ++++
>  winsup/cygwin/include/stdint.h | 2 +-
>  2 files changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/winsup/cygwin/ChangeLog b/winsup/cygwin/ChangeLog
> index 550490a..cd2dbb9 100644
> --- a/winsup/cygwin/ChangeLog
> +++ b/winsup/cygwin/ChangeLog
> @@ -1,3 +1,7 @@
> +2015-03-10  Yaakov Selkowitz  <yselkowitz@cygwin.com>
> +
> +	* include/stdint.h: Fix __x86_64__ conditional.
> +
>  2015-03-05  Corinna Vinschen  <corinna@vinschen.de>
>=20=20
>  	* tty.h (tty::set_master_ctl_closed): Rename from set_master_closed.
> diff --git a/winsup/cygwin/include/stdint.h b/winsup/cygwin/include/stdin=
t.h
> index b670884..94b6b76 100644
> --- a/winsup/cygwin/include/stdint.h
> +++ b/winsup/cygwin/include/stdint.h
> @@ -114,7 +114,7 @@ typedef unsigned long long uintmax_t;
>  #if !defined (__cplusplus) || defined (__STDC_LIMIT_MACROS) \
>      || defined (__INSIDE_CYGWIN__)
>=20=20
> -#if __x86_64__
> +#ifdef __x86_64__
>  # define __I64(n) n ## L
>  # define __U64(n) n ## UL
>  #else

Thanks for catching.  Please apply.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJU/1MFAAoJEPU2Bp2uRE+gEWsP/i2g6UehFsU/gVYWUZk4reba
qJF3HYG4sp+lNxzlGEq1L1ElpZmWH7lD+fxQYv/ynics960foE4GfUjUv79SI63W
/I4h87C4VbeCVGjhpzhQLs35QsTsAcUSn9Yzb/Se4u0FwWsD1JP/dsb2ngtiqD8s
k67P56iLE4Mzf6XAxjWsJ0Q1Dvnw4jovOpAHlQ4lpQTNmoKn9fGkDp0C1Y1+3srB
h2w16bKaLPnVU0Ueh1LEiB1lzzlzz8rKGoZJfJ0owRgVZBJKH9ei8Y/UdRZDk3iZ
iWV/2KM+rGb0kN5K7rfmzq0tv1T8ab+0IiwqfTk1iobw08CunzLc/jjkHPSjndTY
mQoGp4lBAc2JhpWEWtmXhPCIfFebqQfIWCSUGcHMtPx9OFbNYMCQJXadX3q2rCKZ
xO4Mo2NvBOMy6U9FXdM9+6CWMUidi7BMWKUaa22GZIJUgZZK0Tvc2raexdVvR+9w
c/nkBwF3h1AD9KtWC7xVTjvjI01oY5hXUyZIQGumdc7uYdzkBL+kXrUKErAu/VBt
7GfNMdA10bhoaldfUUDAxPqw3sjixz9Y3GoqxLdg5k+IIQNdgbkmR5CxOORo7LFT
UubxZz3iX2oxMxPvzpqGqGWfVOY61nar9vfATQeMz0guVY5/aQ1+Rpw8a+A4u0na
QReFUziwplLN3mkq+ZZN
=tidM
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--
