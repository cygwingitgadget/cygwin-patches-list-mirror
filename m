Return-Path: <cygwin-patches-return-9911-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 104916 invoked by alias); 13 Jan 2020 15:49:57 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 104906 invoked by uid 89); 13 Jan 2020 15:49:56 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-123.8 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=lately
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.187) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 13 Jan 2020 15:49:55 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MhUDj-1jMV2w0wi3-00eaP4 for <cygwin-patches@cygwin.com>; Mon, 13 Jan 2020 16:49:53 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 66C29A806B2; Mon, 13 Jan 2020 16:49:52 +0100 (CET)
Date: Mon, 13 Jan 2020 15:49:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Fix the issue regarding open and close multiple PTYs.
Message-ID: <20200113154952.GI5858@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200101064748.8709-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="BQPnanjtCNWHyqYD"
Content-Disposition: inline
In-Reply-To: <20200101064748.8709-1-takashi.yano@nifty.ne.jp>
X-SW-Source: 2020-q1/txt/msg00017.txt


--BQPnanjtCNWHyqYD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2219

Hi Takashi,

On Jan  1 15:47, Takashi Yano wrote:
> - If two PTYs are opened in the same process and the first one
>   is closed, the helper process for the first PTY remains running.
>   This patch fixes the issue.
> ---
> [...]
> diff --git a/winsup/utils/cygwin-console-helper.cc b/winsup/utils/cygwin-=
console-helper.cc
> index 66004bd15..6255fb93d 100644
> --- a/winsup/utils/cygwin-console-helper.cc
> +++ b/winsup/utils/cygwin-console-helper.cc
> @@ -4,14 +4,24 @@ int
>  main (int argc, char **argv)
>  {
>    char *end;
> +  HANDLE parent =3D NULL;
>    if (argc < 3)
>      exit (1);
> +  if (argc =3D=3D 5)
> +    parent =3D OpenProcess (PROCESS_DUP_HANDLE, FALSE,
> +			  strtoull (argv[4], &end, 0));
>    HANDLE h =3D (HANDLE) strtoull (argv[1], &end, 0);
> +  if (parent)
> +    DuplicateHandle (parent, h, GetCurrentProcess (), &h,
> +		     0, FALSE, DUPLICATE_SAME_ACCESS);
>    SetEvent (h);
> -  if (argc =3D=3D 4) /* Pseudo console helper mode for PTY */
> +  if (argc =3D=3D 4 || argc =3D=3D 5) /* Pseudo console helper mode for =
PTY */
>      {
>        SetConsoleCtrlHandler (NULL, TRUE);
>        HANDLE hPipe =3D (HANDLE) strtoull (argv[3], &end, 0);
> +      if (parent)
> +	DuplicateHandle (parent, hPipe, GetCurrentProcess (), &hPipe,
> +			 0, FALSE, DUPLICATE_SAME_ACCESS);
>        char buf[64];
>        sprintf (buf, "StdHandles=3D%p,%p\n",
>  	       GetStdHandle (STD_INPUT_HANDLE),
> @@ -21,6 +31,9 @@ main (int argc, char **argv)
>        CloseHandle (hPipe);
>      }
>    h =3D (HANDLE) strtoull (argv[2], &end, 0);
> +  if (parent)
> +    DuplicateHandle (parent, h, GetCurrentProcess (), &h,
> +		     0, FALSE, DUPLICATE_SAME_ACCESS);

I think it would be better if cygwin-console-helper closes the parent
handle at this point before waiting.  I have a bad feeling keeping the
PROCESS_DUP_HANDLE handle open for longer than necessary, after the
handle leakage we had in execve lately.

But then again, given that Cygwin uses EXTENDED_STARTUPINFO_PRESENT
anyway, wouldn't it makes sense to pass the required handles with
PROC_THREAD_ATTRIBUTE_HANDLE_LIST to avoid having to open the
parent with PROCESS_DUP_HANDLE?


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--BQPnanjtCNWHyqYD
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl4ckaAACgkQ9TYGna5E
T6BFzxAAgC7g05cqOQJI1puw7u9JwUJM5seMFoXY5ANhL0IhHA7yR2UoAlr7KZy8
0578XAbzFgkYr4W9RPK+5j3cHTOxgoyYPxciA3HWan9CjJILAd1z+R3Puoy8oAWb
NsZZfMBLVkAXpKKJ9G8NrfgPMW8i1gPUNfQwwCOC0K3bzFNWpKS75wgELJTK0PxF
OPDyjYB5VPS5/+IVcOkli1qmdQjkvvxyvUMwuVCEO8SUidtAy46hJa4c2AdT/2GK
uk2Ngv38Cax6etqf+KybX1ZjygOJPok/RVSFz7fMfH8aPmsGrq2BYAm/hwEGbQuG
Gp0hvWMfNxBEJFNq/wjW8p2vORwUlSyU5Ub39Ee6HPTPxursluoPC8dYxxdbXEf/
FvGBdpM7QbrM0f2DUZUdozaWD7mxVOnspU+p/mThZdeN06fMwKaFKjvo/Xr8LXnR
1gp0hie7kxD0AJ1vJdRpIAJ075h2ly+zGjby/+abYEGF0tLZpuoYWFe6DcwtWICk
vVracvIjgOfaRPPq5sClJJLd29tNLJ7mpDdfZ8ZXnBj3FfdlGSU2w61hd7n6K9I1
S/9Di1iTUMuXrKM2xpTDzXQNldOraUGb9iE0JUgGi/9uPND3Th/fY9fz1NIqfYuo
wVPtO6SAeTJKHAf4s2hPvQoPhbwkpyHW1s9bi68bEIvUJ9a5Vxo=
=SokM
-----END PGP SIGNATURE-----

--BQPnanjtCNWHyqYD--
