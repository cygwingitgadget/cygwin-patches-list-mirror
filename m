Return-Path: <cygwin-patches-return-9377-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 107744 invoked by alias); 23 Apr 2019 15:23:57 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 107732 invoked by uid 89); 23 Apr 2019 15:23:57 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-114.7 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=snapshots, Erik, erik, mins
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (217.72.192.74) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 23 Apr 2019 15:23:55 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id 1Mj7yt-1ge8Pl2eX7-00fB5t; Tue, 23 Apr 2019 17:23:52 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id C14C7A80772; Tue, 23 Apr 2019 17:23:51 +0200 (CEST)
Date: Tue, 23 Apr 2019 15:23:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: "Erik M. Bray" <erik.m.bray@gmail.com>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Minor improvements to socket error handling:
Message-ID: <20190423152351.GE30041@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: "Erik M. Bray" <erik.m.bray@gmail.com>,	cygwin-patches@cygwin.com
References: <20190423145533.34172-1-erik.m.bray@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="Qz2CZ664xQdCRdPu"
Content-Disposition: inline
In-Reply-To: <20190423145533.34172-1-erik.m.bray@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q2/txt/msg00084.txt.bz2


--Qz2CZ664xQdCRdPu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1270

On Apr 23 16:55, Erik M. Bray wrote:
> * Change default fallback for failed winsock error -> POSIX error
>   mappings to EACCES, which is a valid errno for more socket-related
>   syscalls.
>=20
> * Added a few previously missing entries to the wsock_errmap table
>   that have obvious POSIX errno.h analogues.
> ---
>  winsup/cygwin/net.cc | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/winsup/cygwin/net.cc b/winsup/cygwin/net.cc
> index cd296d19d..437712c63 100644
> --- a/winsup/cygwin/net.cc
> +++ b/winsup/cygwin/net.cc
> @@ -177,6 +177,9 @@ static const errmap_t wsock_errmap[] =3D {
>    {WSAEREMOTE, "WSAEREMOTE", EREMOTE},
>    {WSAEINVAL, "WSAEINVAL", EINVAL},
>    {WSAEFAULT, "WSAEFAULT", EFAULT},
> +  {WSAEBADF, "WSAEBADF", EBADF},
> +  {WSAEACCES, "WSAEACCES", EACCES},
> +  {WSAEMFILE, "WSAEMFILE", EMFILE},
>    {0, "NOERROR", 0},
>    {0, NULL, 0}
>  };
> @@ -188,7 +191,7 @@ find_winsock_errno (DWORD why)
>      if (why =3D=3D wsock_errmap[i].w)
>        return wsock_errmap[i].e;
>=20=20
> -  return EPERM;
> +  return EACCES;
>  }
>=20=20
>  void
> --=20
> 2.15.1

Pushed, thanks!

I'm building dev snapshots right now, should be up in a couple of mins.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--Qz2CZ664xQdCRdPu
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAly/LgcACgkQ9TYGna5E
T6AxqBAAmALDCzXg2MHdCTxdmUT11RDcEdPjelZFoo2iFLqiyVr4KoGjDhNRVeKq
tRx0WFYRzTRRbQFuB6ejJtHhhWtV7UumyHIjqFmzYNGeRlRFyOYn0HN1mPOPMZRp
clvDsqEmuhtZ3+RnFK7MqUkCL4fK7YTDyR6TF1E2RGUxLzuFt+fYnieYyYQgYsc3
pz405DxsjDLQeMMhzvhzeju8GPHJaeJSuYFADaGEw+Xpv6M2seOH+4JT6uVTt7Ak
O/+xuQpYOw/s/z17iMo4eoKX57eiyJwrDDj+JKZnfAiwCu/yalrK9zo9OKGlIrbF
X5Fo6G2mdldePi+a+2OvtcHPXpY7wps/gzJVu8RZqvIZWQ1vHx+mm02s++Uvgzn3
Dxz5eEPnps8NG6U3wcRDkMunntr2Y/cKSuBjlbqhhq3ZlDhMeXHSF6zEqVhwxPmT
5ODU8XOnSb9Ig9CTK7XT+LySDtrZh15JM92xqKsm6+ucQYr1OUNH5LBJq2FPqlTI
qfK/NnXRXE6HvXeyWzLH8U3sW/PLhYPEIL8L5cOGG/eyglD4GldH8Ybhy55YsAuc
IxQMjrmQU1VgfaYEXY1pLog4XlJk3SCJM5sjl5Rn82TFZ2kSSrgm+kBp7Y1lG4iX
sm5KwIH0o2mzJndfYgiktoqfUygBhXluj23OEO9ltuFDpKx3dxg=
=go5v
-----END PGP SIGNATURE-----

--Qz2CZ664xQdCRdPu--
