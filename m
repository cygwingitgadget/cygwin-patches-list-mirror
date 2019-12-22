Return-Path: <cygwin-patches-return-9874-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 54558 invoked by alias); 22 Dec 2019 09:04:58 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 54547 invoked by uid 89); 22 Dec 2019 09:04:58 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-116.8 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=500000
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.130) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 22 Dec 2019 09:04:56 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id 1M5wTr-1ibWNa1j1n-007Wsu for <cygwin-patches@cygwin.com>; Sun, 22 Dec 2019 10:04:53 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 50F0DA80775; Sun, 22 Dec 2019 10:04:51 +0100 (CET)
Date: Sun, 22 Dec 2019 09:04:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: FIFO: use FILE_PIPE_REJECT_REMOTE_CLIENTS flag
Message-ID: <20191222090451.GF3628@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20191221230129.2177-1-kbrown@cornell.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="YkJPYEFdoxh/AXLE"
Content-Disposition: inline
In-Reply-To: <20191221230129.2177-1-kbrown@cornell.edu>
X-SW-Source: 2019-q4/txt/msg00145.txt.bz2


--YkJPYEFdoxh/AXLE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1505

On Dec 21 23:01, Ken Brown wrote:
> Add that flag to the pipe type argument when creating the Windows
> named pipe.  And add a definition of that flag to ntdll.h (copied from
> /usr/include/w32api/ddk/ntifs.h).
> ---
>  winsup/cygwin/fhandler_fifo.cc | 3 ++-
>  winsup/cygwin/ntdll.h          | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/winsup/cygwin/fhandler_fifo.cc b/winsup/cygwin/fhandler_fifo=
.cc
> index 92797ce60..fd8223000 100644
> --- a/winsup/cygwin/fhandler_fifo.cc
> +++ b/winsup/cygwin/fhandler_fifo.cc
> @@ -184,7 +184,8 @@ fhandler_fifo::create_pipe_instance (bool first)
>    timeout.QuadPart =3D -500000;
>    status =3D NtCreateNamedPipeFile (&ph, access, &attr, &io, sharing,
>  				  first ? FILE_CREATE : FILE_OPEN, 0,
> -				  FILE_PIPE_MESSAGE_TYPE,
> +				  FILE_PIPE_MESSAGE_TYPE
> +				    | FILE_PIPE_REJECT_REMOTE_CLIENTS,
>  				  FILE_PIPE_MESSAGE_MODE,
>  				  nonblocking, max_instances,
>  				  DEFAULT_PIPEBUFSIZE, DEFAULT_PIPEBUFSIZE,
> diff --git a/winsup/cygwin/ntdll.h b/winsup/cygwin/ntdll.h
> index e19cc8ab5..1c07d0255 100644
> --- a/winsup/cygwin/ntdll.h
> +++ b/winsup/cygwin/ntdll.h
> @@ -557,7 +557,8 @@ enum
>  enum
>  {
>    FILE_PIPE_BYTE_STREAM_TYPE =3D 0,
> -  FILE_PIPE_MESSAGE_TYPE =3D 1
> +  FILE_PIPE_MESSAGE_TYPE =3D 1,
> +  FILE_PIPE_REJECT_REMOTE_CLIENTS =3D 2
>  };
>=20=20
>  typedef struct _FILE_PIPE_PEEK_BUFFER {
> --=20
> 2.21.0

Thanks, please push.


Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--YkJPYEFdoxh/AXLE
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl3/MbMACgkQ9TYGna5E
T6CQOg//WhXHN4IbAJTwd0hfTba42pHZvu8zmNGTOCaUA2ITGqwbHhCAdxivF3t5
zsu/lCp1SpM4PUOzsgKuTPYBYiziyJl2P6XwBJej5CQvoXRZ7pQRJQfE+PS7wnRd
ziESfNK78yXdva1Bhwu734uLUDtt6572EevPqT3LHuLMm/O7/rqVUqVQs45yuLNe
Nk89kWIirKV4wFLOjNQZ9lf1Q+pBJ2vMVYYLOA1lcGgBysTnKiS4YwGFAYLtjEob
qinhiACMbDZVQVS8b6Jn2QBrdNvy7IjfG2a3Evj7ZWc+BbP+JkOsnetRFXnaRSnt
5Wk4N3y8gM1xHw/blMiAL2VBsMN7ASRzoeNcIzbPmi8IB+Fhi/Y4OVdhMTfyjjtj
DJKtR7rsEgzylo7DdOosNTjO7aMWRHRf7n1Zd2iXYkZbSU3agdrH25g8/svvy14q
YUETn9mLSPrF9y3xRV2beRxVeq9jP6HxXjiHnAsH7hJsUEPnKRe4pjSm+zNdnsI6
AMEfRzPjOd3ozcjdUNE3CYnKZwMKOn963ApNdStIstVrExjpAQgU5F87f4hD4NMs
B4X/ga37Rz1A2IFbghro5p7/fO1ZQPi8qQw5oNIzLO7QPhBICL1Siva2R2nI84Vz
KOWoiOVsfIghmMKUUfqf+XVMJVRcoFlTFfOnSZC0Y9Rdl15qgSc=
=FbNl
-----END PGP SIGNATURE-----

--YkJPYEFdoxh/AXLE--
