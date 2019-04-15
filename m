Return-Path: <cygwin-patches-return-9353-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 58971 invoked by alias); 15 Apr 2019 08:17:44 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 58704 invoked by uid 89); 15 Apr 2019 08:17:43 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-116.0 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE,UNSUBSCRIBE_BODY autolearn=ham version=3.3.1 spammy=H*r:500, H*F:U*corinna-cygwin, HX-Envelope-From:sk:corinna, H*F:D*cygwin.com
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.135) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 15 Apr 2019 08:17:42 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id 1Mgvj3-1gdpmA2KM9-00hQdD for <cygwin-patches@cygwin.com>; Mon, 15 Apr 2019 10:17:39 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id C0F04A80736; Mon, 15 Apr 2019 10:17:38 +0200 (CEST)
Date: Mon, 15 Apr 2019 08:17:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 13/14] Cygwin: FIFO: improve raw_write
Message-ID: <20190415081738.GA3599@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20190414191543.3218-1-kbrown@cornell.edu> <20190414191543.3218-14-kbrown@cornell.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Content-Disposition: inline
In-Reply-To: <20190414191543.3218-14-kbrown@cornell.edu>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q2/txt/msg00060.txt.bz2


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2178

Hi Ken,

On Apr 14 19:16, Ken Brown wrote:
> Don't set the write end of the pipe to non-blocking mode if the FIFO
> is opened in blocking mode.
>=20
> In fhandler_fifo::raw_write in blocking mode, wait for the write to
> complete rather than returning -1 with EAGAIN.
>=20
> If the amount to write is large, write in smaller chunks (of size
> determined by a new data member max_atomic_write), as in
> fhandler_base_overlapped.
> ---
>  winsup/cygwin/fhandler.h       |  1 +
>  winsup/cygwin/fhandler_fifo.cc | 96 +++++++++++++++++++++++++++-------
>  2 files changed, 79 insertions(+), 18 deletions(-)
>=20
> [...]
> diff --git a/winsup/cygwin/fhandler_fifo.cc b/winsup/cygwin/fhandler_fifo=
.cc
> index fe4c67bdf..ce078d74d 100644
> --- a/winsup/cygwin/fhandler_fifo.cc
> +++ b/winsup/cygwin/fhandler_fifo.cc
> @@ -22,6 +22,9 @@
>  #include "ntdll.h"
>  #include "cygwait.h"
>=20=20
> +#define STATUS_THREAD_SIGNALED	((NTSTATUS)0xE0000001)
> +#define STATUS_THREAD_CANCELED	((NTSTATUS)0xE0000002)

We want to move this to ntdll.h at one point, with a comment about
"cygwin-only" etc.  If you want to do that right now, feel free.

There's a small problem in this patch:

>  {
>    ssize_t ret =3D -1;
> +  size_t nbytes =3D 0, chunk;
>    NTSTATUS status;
     ^^^^^^^^^^^^^^^^

>    IO_STATUS_BLOCK io;
> +  HANDLE evt =3D NULL;
> [...]
> +  if (status =3D=3D STATUS_THREAD_SIGNALED && !_my_tls.call_signal_handl=
er ())
> +    set_errno (EINTR);
> +  else if (status =3D=3D STATUS_THREAD_CANCELED)
> +    pthread::static_cancel_self ();

fhandler_fifo.cc: In member function =E2=80=98virtual ssize_t fhandler_fifo=
::raw_write(const void*, size_t)=E2=80=99:
fhandler_fifo.cc:711:8: error: =E2=80=98status=E2=80=99 may be used uniniti=
alized in this function [-Werror=3Dmaybe-uninitialized]
   else if (status =3D=3D STATUS_THREAD_CANCELED)
        ^~

You only see this with -O2.  There's actually a chance this may occur if
the incoming len is 0.  Can you check, especially in terms of the
default value status should start up with here?

The other patches look good, just send a v2 of this single patch is all.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAly0PiIACgkQ9TYGna5E
T6BdGw//UAAbxpJZ1iuo92GdXONzF1yIBjETKcbCvLyy7aPhG0bddyz4CMow/nEr
jFkYyp5Mh5FqNwZpuma0nd83YZwNgJwIgakCBmulQ+JH91F8T5yDIG7Ci+WtzE88
3z9XZeJfbFeTQ3e+Dr4Y0BC6ji9Y8YwIs9z6A715wQHrfgxBSiAmRPQ7JBNLXkA5
DqO97KoFzq/7cW3dtU/6G+4qoQN/smCoOwqhhvT6leJI7j5QsBxNZSRBViHsBVmT
Dw47tm2nkbPxu74nYJzsc2WFTCaayRRBqFGVMmmDkeydxk/FUSCTgMiQ8QgKN69E
nIPrGY3MFYKxEn54rlXCfXaFzrl0D/FZiOUlMzqn+RJwxfFRAbJHwLcLEv6Gl4aK
gzcEOHR9jCMeuENc2AAGbUQnwE70hKXctft8jcBobf8LW6gOfQbgPmSvCRclx88O
9Hd2Y9B6TRzSU4jRB0uRJQYWx2zMVGD3fDSga4q8vaQ/Tmj8/FBCo07Fjqq6RrPK
cNc5uWHZblLoZhmh/4Gj6uoWGzWy/amq4NSV222ypTEa7vwAN7tFx322wwuH5mmw
nDa1p9bOhZTfuu9ilSysPgAco2SM6VVa6aJjo4VYmrFJxBq4A8+0HEx2+0dKuWtG
8tM/aj+hiwtTnCRoSZTB+hf9l7fbcViiqTGsVmW1Q5ZrJyX0sKM=
=gkKJ
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
