Return-Path: <cygwin-patches-return-8553-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 76284 invoked by alias); 5 Apr 2016 13:56:02 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 76270 invoked by uid 89); 5 Apr 2016 13:56:02 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-96.6 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC autolearn=ham version=3.3.2 spammy=HTo:U*cygwin-patches, H*R:D*cygwin.com, cursor
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 05 Apr 2016 13:55:51 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id C76B5A8097D; Tue,  5 Apr 2016 15:55:49 +0200 (CEST)
Date: Tue, 05 Apr 2016 13:56:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Cc: Thomas Wolff <towo@towo.net>
Subject: Re: [PATCH] Be truthful about reporting whether readahead is available
Message-ID: <20160405135549.GE26281@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com, Thomas Wolff <towo@towo.net>
References: <4b19a1f32862208db6121371bd7ef395f6699535.1459846294.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="CdrF4e02JqNVZeln"
Content-Disposition: inline
In-Reply-To: <4b19a1f32862208db6121371bd7ef395f6699535.1459846294.git.johannes.schindelin@gmx.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q2/txt/msg00028.txt.bz2


--CdrF4e02JqNVZeln
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2146

Thomas?

Any input?

On Apr  5 10:52, Johannes Schindelin wrote:
> In 7346568 (Make requested console reports work, 2016-03-16), code was
> introduced to report the current cursor position. It works by using a
> pointer that either points to the next byte in the readahead buffer, or
> to a NUL byte if the buffer is depleted, or the pointer is NULL.
>=20
> These conditions are heeded in the fhandler_console::read() method, but
> the condition that the pointer can point at the end of the readahead
> buffer was not handled properly in the get_cons_readahead_valid()
> method.
>=20
> This poses a problem e.g. in Git for Windows (which uses a slightly
> modified MSYS2 runtime which is in turn a slightly modified Cygwin
> runtime) when vim queries the cursor position and immediately goes on to
> read console input, erroneously thinking that the readahead buffer is
> valid when it is already depleted instead. This condition results in an
> apparent freeze that can be helped only by pressing keys repeatedly.
>=20
> The full Git for Windows bug report is here:
>=20
> 	https://github.com/git-for-windows/git/issues/711
>=20
> Let's just teach the get_cons_readahead_valid() method to handle a
> depleted readahead buffer correctly.
>=20
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  winsup/cygwin/fhandler.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
> index 4610557..bd1a923 100644
> --- a/winsup/cygwin/fhandler.h
> +++ b/winsup/cygwin/fhandler.h
> @@ -1453,7 +1453,8 @@ private:
>    bool focus_aware () {return shared_console_info->con.use_focus;}
>    bool get_cons_readahead_valid ()
>    {
> -    return shared_console_info->con.cons_rapoi !=3D NULL;
> +    return shared_console_info->con.cons_rapoi !=3D NULL &&
> +      *shared_console_info->con.cons_rapoi;
>    }
>=20=20
>    select_record *select_read (select_stuff *);
> --=20
> 2.8.0.windows.1


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--CdrF4e02JqNVZeln
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXA8PlAAoJEPU2Bp2uRE+gZQ8P/3zQjzGWszz8s+WPeK8s/vxu
tRssY6Z/qs959+7w9Jaav0y+mh2mWYA3h4Nf5zK9xSM2J1RPlCObAO0oCoDLMQYi
qaqkj9p1JDT3iLgt6+ImzSFOn5cKBL6JKQZZEda8f0DJweP6CHQ3lp1xXiAPjGfX
i0dj7MkE5r1zSvQXPuyOeSEFXWUL31p/G5jsx/X0oIP51wqrmC7Nh7GArSKth/dk
8MixkKStO6BfepTrnhR8WnNp73dideedgyGZtNHj8JE1FHl0EYgCYTkWXtEMdMYp
zEZtoCbLT4dXsKmFZB+HhFS4cTnWCFOKBNmKeZvg9KuIPCch+sRNzSU/Es2CT5IE
yF372FB9NEQZ2zah9M8QxgPl9ZGx9fmbT+tR7AFthfZUGIdMVYc3z8vNhH/5xwIj
TV9TwOe8nmUGq0PAXWKXfnbq4utqqcwB0a8I0wvVpA3V2a/FBBWPJFo6S/OKEzkp
fF4f8W7EBrg77p4B5PKgKLaKU9q0DcCJ7XrvPGgInnrS+JZ2d5LwFGZvJpq7TpXT
VNl9cFcehjlAEOXgF+jlmoXIsUn5y1C6qPQm16xcZncQqD9ozTFyhsGEHjwHSGBC
UMKl/KWFve2lBOy21UVdsR1swBvixx79J9zoCtEL/H/BfGFCrjwJoCcFBfY+qXB0
ZpBMImZlBW6mlEKm6Yqo
=tdWz
-----END PGP SIGNATURE-----

--CdrF4e02JqNVZeln--
