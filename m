Return-Path: <cygwin-patches-return-9591-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 43104 invoked by alias); 2 Sep 2019 14:37:21 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 43088 invoked by uid 89); 2 Sep 2019 14:37:21 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-105.6 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_SBL autolearn=ham version=3.3.1 spammy=
X-HELO: mout-xforward.kundenserver.de
Received: from mout-xforward.kundenserver.de (HELO mout-xforward.kundenserver.de) (82.165.159.36) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 02 Sep 2019 14:37:20 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MJV9S-1hl3g44A9I-00JrP8 for <cygwin-patches@cygwin.com>; Mon, 02 Sep 2019 16:37:17 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 6499BA805C9; Mon,  2 Sep 2019 16:37:16 +0200 (CEST)
Date: Mon, 02 Sep 2019 14:37:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v4 1/1] Cygwin: pty: Fix state management for pseudo console support.
Message-ID: <20190902143716.GF4164@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20190901221156.1367-1-takashi.yano@nifty.ne.jp> <20190901221156.1367-2-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="9l24NVCWtSuIVIod"
Content-Disposition: inline
In-Reply-To: <20190901221156.1367-2-takashi.yano@nifty.ne.jp>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SW-Source: 2019-q3/txt/msg00111.txt.bz2


--9l24NVCWtSuIVIod
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 3390

On Sep  2 07:11, Takashi Yano wrote:
> - Pseudo console support introduced by commit
>   169d65a5774acc76ce3f3feeedcbae7405aa9b57 has some bugs which
>   cause mismatch between state variables and real pseudo console
>   state regarding console attaching and r/w pipe switching. This
>   patch fixes this issue by redesigning the state management.
> ---
>  winsup/cygwin/dtable.cc           |  15 +-
>  winsup/cygwin/fhandler.h          |   6 +-
>  winsup/cygwin/fhandler_console.cc |   6 +-
>  winsup/cygwin/fhandler_tty.cc     | 415 ++++++++++++++++--------------
>  winsup/cygwin/fork.cc             |  24 +-
>  winsup/cygwin/spawn.cc            |  65 +++--
>  6 files changed, 289 insertions(+), 242 deletions(-)
> [...]
>  class fhandler_pty_slave: public fhandler_pty_common
>  {
>    HANDLE inuse;			// used to indicate that a tty is in use
>    HANDLE output_handle_cyg, io_handle_cyg;
> +  DWORD pidRestore;

Please don't use camelback.  s/pidRestore/pid_restore/g

> -	      HeapAlloc (GetProcessHeap (), 0, num * sizeof (DWORD));
> -  num =3D GetConsoleProcessList (list, num);
> +	      HeapAlloc (GetProcessHeap (), 0, (num + 16) * sizeof (DWORD));
> +  num =3D GetConsoleProcessList (list, num + 16);

You're still going to change that, right?

> @@ -855,26 +868,6 @@ fhandler_pty_slave::cleanup ()
>  int
>  fhandler_pty_slave::close ()
>  {
> -#if 0
> -  if (getPseudoConsole ())
> -    {
> -      INPUT_RECORD inp[128];
> -      DWORD n;
> -      PeekFunc =3D
> -	PeekConsoleInputA_Orig ? PeekConsoleInputA_Orig : PeekConsoleInput;
> -      PeekFunc (get_handle (), inp, 128, &n);
> -      bool pipe_empty =3D true;
> -      while (n-- > 0)
> -	if (inp[n].EventType =3D=3D KEY_EVENT && inp[n].Event.KeyEvent.bKeyDown)
> -	  pipe_empty =3D false;
> -      if (pipe_empty)
> -	{
> -	  /* Flush input buffer */
> -	  size_t len =3D UINT_MAX;
> -	  read (NULL, len);
> -	}
> -    }
> -#endif

Ideally stuff like that should be in a separate code cleanup patch.

> -      Sleep (60); /* Wait for pty_master_fwd_thread() */
> +      Sleep (20); /* Wait for pty_master_fwd_thread() */

Isn't that a separate issue as well?  A separate patch may be in order
here, kind of like "Cygwin: pseudo console: reduce time sleeping ..."
with a short description why that makes sense?

> +	  /* If not attached this pseudo console, try to attach temporarily. */
                           ^^^^
                            to

> -	  get_ttyp ()->hPseudoConsole =3D NULL;
> +	  //get_ttyp ()->hPseudoConsole =3D NULL; // Do not clear for safty.

Why don't you just drop the line?

Other than that, the patch looks good.

However, I have a few questions in terms of the code in general, namely
in terms of

  ALWAYS_USE_PCON
  USE_API_HOOK
  USE_OWN_NLS_FUNC

Can you describe again why you introduced these macros?

In terms of USE_API_HOOK:

- Shouldn't the hook_api function be moved to hookapi.cc?

- Do we really want to hook every invocation of WriteFile/ReadFile?
  Doesn't that potentially slow down an exec'ed process a lot?
  We're still not using the NT functions throughout outside of the
  console/tty code.

In terms of USE_OWN_NLS_FUNC:

- Why do we need this function at all?  Can't this be handled by
  __loadlocale instead?  If not, what is __loadlocale missing to make
  this work without duplicating the function?


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--9l24NVCWtSuIVIod
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl1tKRwACgkQ9TYGna5E
T6CGmQ//R+aGhsCoARU7zha6A0m1MWJ7+re0vUiFq6mTgNZcgMazys2SExfHqMRd
NSHQCflP1werJbPypRsOCPRfaQY7CadlMkmZhHFwMu3ih7LwceEjwNChDo35ii0P
e+Yr/Q75lVbPHzzi38BHMaL7QHS8+Vqvj87frX64H7nfAru2WnyGopIqWQwfto4G
xFCohbwmziSEsXB+kRn5xXQgtx8853Lp+EAmEkSQZiHL+HGlVl61ASxLlskOKNKw
/RUxV9rNdQQE8Xz5iiQtgRtSC5+qYV3vXIHLvg+L+H2xZsCBUBr7nD38+DmA5Yo2
96l8m3KLGgjAeClDBizzAkKhLwQYohlfIwQ3hnHS1+MV1a1EUDBZvjzwj+X+x3jt
jVr6aD4+PpjNvlAM5P5mHfId5iZzBS0MSqf4OUnlDv1it+lgXRx83zeYyyLMeg5B
fA6HaFrCsfU2UVvqtZetXP0wpBf1iUFvoDyTpVjB6ryhCUCnnqvLiRmVYyEGP2y7
VwXjDEZ7gWVq7d7D5pFbgvlvOZK1rLDovq8sber0TZMUn8IgcO/wODtuwx4sP0mf
PVnXeNT3m4F01BA41qGqEILpxuNzPg7Y8mkD7Sj8jV8sIeDAqNrdF6jm+U47/59z
ASuzREGldvyNgy4x0ZZBsM+ShSwXGIziiakfj/wRupIB8J95sVk=
=TqRX
-----END PGP SIGNATURE-----

--9l24NVCWtSuIVIod--
