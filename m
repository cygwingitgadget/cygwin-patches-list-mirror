Return-Path: <cygwin-patches-return-9318-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27040 invoked by alias); 10 Apr 2019 09:05:32 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 27025 invoked by uid 89); 10 Apr 2019 09:05:31 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-126.9 required=5.0 tests=BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HX-Languages-Length:600, H*F:D*cygwin.com
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (217.72.192.74) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 10 Apr 2019 09:05:30 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MBUyX-1h2IoK3jpv-00D0QY for <cygwin-patches@cygwin.com>; Wed, 10 Apr 2019 11:05:27 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 36F9FA80446; Wed, 10 Apr 2019 11:05:27 +0200 (CEST)
Date: Wed, 10 Apr 2019 09:05:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [rebase PATCH] On error, avoid a close on the -1 file descriptor.
Message-ID: <20190410090527.GG4248@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <56411474-c4a0-685e-14a9-bb3662816f71@ssi-schaefer.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="2JFBq9zoW8cOFH7v"
Content-Disposition: inline
In-Reply-To: <56411474-c4a0-685e-14a9-bb3662816f71@ssi-schaefer.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q2/txt/msg00025.txt.bz2


--2JFBq9zoW8cOFH7v
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 584

On Apr  9 11:03, Michael Haubenwallner wrote:
> ---
>  rebase.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/rebase.c b/rebase.c
> index ca3c59d..56537d6 100644
> --- a/rebase.c
> +++ b/rebase.c
> @@ -1441,7 +1441,7 @@ is_rebaseable (const char *pathname)
>=20=20
>    fd =3D open (pathname, O_RDONLY);
>    if (fd =3D=3D -1)
> -    goto done;
> +    return status;
>=20=20
>    offset =3D lseek (fd, pe_signature_offset_offset, SEEK_SET);
>    if (offset =3D=3D -1)
> --=20
> 2.19.2

Pushed.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--2JFBq9zoW8cOFH7v
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlytsdcACgkQ9TYGna5E
T6AWjQ/+PcNQ2u4UKLM4w6w5b4YA6/1/OhpMKAVS/7F8doSAcqlsrYMjjvgKUWQ6
aoe4Mkp4yJrpTyqwuiUTFQv1Qf9HAsg5/ooQBsZVJYYOlCwDaZgVk9dn9wzs6Xmj
mgHeXLtJtakF3RTxjuXkVMVdWBQFY8kfLdzYxt783OvITEKpXhG8PkHJHUjL/e0V
//kMh8DaxurJv4KAYTLSO0WMwZSDvxVmAX8X+bj5PrEdZXlIMscE/942dPgEPNvr
5WaI2kmajIDhKMTR77q5DB+Lpdde7kqlYEHhEDyFgkPY8/fSxpP17OOS3RqkQMIW
85GoYNZ1lp1qj6wwRz58qUatF50HzAe9pHet7pR9tnOXImZCVE9nnTWKZ11L44e2
1IirKNzePblE3Pi9QTW6hGGpzAgmh9q2TVAkcMEXhFYITSfaoerVfwK4KH1cEsCT
Aa/s20lKP02Ra1/+0jtCPPIN2OH+MMKWskzgfv/B+itxBi5iH8VgHM2+NY7fwoFv
J+UPH+ngJ7m9DL0yQNUMxNEi2BUHore+uvWC5c58L3AIa7aKUOfdj7f+8w/YKBh7
IkJDDntHWvdQRYDb+diWo5/vTkevMzzhH2TVcm06FVbCdISayNyXgS+Yn4nJMLoQ
VT9wHzciV8drjEQSATY7yiLXicM3dJUQhQedbfUzQgYslhvxaVk=
=BMy2
-----END PGP SIGNATURE-----

--2JFBq9zoW8cOFH7v--
