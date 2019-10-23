Return-Path: <cygwin-patches-return-9790-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 67208 invoked by alias); 23 Oct 2019 12:05:53 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 67198 invoked by uid 89); 23 Oct 2019 12:05:53 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-115.8 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE,UNSUBSCRIBE_BODY autolearn=ham version=3.3.1 spammy=1066, attaching, sshd, screen
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.17.24) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 23 Oct 2019 12:05:51 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MkYkC-1hjHcJ0ZLC-00m66t for <cygwin-patches@cygwin.com>; Wed, 23 Oct 2019 14:05:49 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 11AAEA8040F; Wed, 23 Oct 2019 14:05:42 +0200 (CEST)
Date: Wed, 23 Oct 2019 12:05:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Disable clear screen for ssh sessions with -t option.
Message-ID: <20191023120542.GA16240@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20191018143306.GG16240@calimero.vinschen.de> <20191019085051.4d2cc80811854d21b193fed6@nifty.ne.jp> <20191021094356.GI16240@calimero.vinschen.de> <20191022090930.b312514dcf8495c1db4bb461@nifty.ne.jp> <20191022065506.GL16240@calimero.vinschen.de> <20191022162316.54c3bc2ff19dbc7ae1bdedf2@nifty.ne.jp> <20191022080242.GN16240@calimero.vinschen.de> <20191022182405.0ce3d7c17b0e7d924430b89c@nifty.ne.jp> <20191022134048.GP16240@calimero.vinschen.de> <20191023122717.66d241bd0a7814b7216d78f5@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="lGQpFNrcSq0Rb43w"
Content-Disposition: inline
In-Reply-To: <20191023122717.66d241bd0a7814b7216d78f5@nifty.ne.jp>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SW-Source: 2019-q4/txt/msg00061.txt.bz2


--lGQpFNrcSq0Rb43w
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2835

Hi Takashi,

On Oct 23 12:27, Takashi Yano wrote:
> On Tue, 22 Oct 2019 15:40:48 +0200
> Corinna Vinschen wrote:
> > Am I doing something wrong?  This code crashes mintty on my
> > installation.  At start, a string of "6n6n6n6n..." appears and then
> > mintty exits.
>=20
> I cannot reproduce that.... How about this one?

In my limited testing it seems to work nicely.

> diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
> index da6119dfb2cf..26f99669f4fc 100644
> --- a/winsup/cygwin/fhandler_tty.cc
> +++ b/winsup/cygwin/fhandler_tty.cc
> @@ -1296,6 +1296,30 @@ detach:
>    restore_reattach_pcon ();
>  }
>=20=20
> +/* If master process is running as service, attaching to
> +   pseudo console should be done in fork. If attaching
> +   is done in spawn for inetd or sshd, it fails because
> +   the helper process is running as privileged user while
> +   slave process is not. This function is used to determine
> +   if the process is running as a srvice or not. */
> +static bool
> +is_running_as_service (void)

This function should probably use check_token_membership(PSID).
I'm also not quite sure if checking for mandatory_system_integrity_sid
makes sense.  Are there examples where the service SID is missing
but the integrity is set to system integrity level?

>  ssize_t __stdcall
>  fhandler_pty_slave::write (const void *ptr, size_t len)
>  {
> @@ -1305,6 +1329,30 @@ fhandler_pty_slave::write (const void *ptr, size_t=
 len)
>    if (bg <=3D bg_eof)
>      return (ssize_t) bg;
>=20=20
> +  if (get_ttyp ()->need_clear_screen_on_write)
> +    {
> +      if (is_running_as_service ())

This check is redundant.  The only way to set need_clear_screen_on_write
to true is if is_running_as_service() was already checked for below.

> +	{
> +	  struct termios ti, ti_new;
> +	  tcgetattr (&ti);
> +	  ti_new =3D ti;
> +	  ti_new.c_lflag &=3D (~ICANON | ECHO);
> +	  tcsetattr (TCSANOW, &ti_new);
> +	  char buf[32];
> +	  DWORD n;
> +	  WriteFile (get_output_handle_cyg (), "\033[6n", 4, &n, NULL);
> +	  ReadFile (get_handle_cyg (), buf, sizeof(buf)-1, &n, NULL);
> +	  ResetEvent (input_available_event);
> +	  tcsetattr (TCSANOW, &ti);
> +	  buf[n] =3D '\0';
> +	  int rows, cols;
> +	  sscanf (buf, "\033[%d;%dR", &rows, &cols);

Wouldn't it be safer to initialize rows and cols to 0 and to check the
result of sscanf?

>  HANDLE
> diff --git a/winsup/cygwin/tty.h b/winsup/cygwin/tty.h
> index 927d7afd9384..c7aeef85b482 100644
> --- a/winsup/cygwin/tty.h
> +++ b/winsup/cygwin/tty.h
> @@ -106,6 +106,7 @@ private:
>    int num_pcon_attached_slaves;
>    UINT term_code_page;
>    bool need_clear_screen;
> +  bool need_clear_screen_on_write;

Maybe the name should be aligned to the fact that it doesn't clear the
screen anymore?


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--lGQpFNrcSq0Rb43w
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl2wQhUACgkQ9TYGna5E
T6B8IxAAoPM3BNE3TujMIaDLvgkpQ9WjLviI+E6ZJBsBn5AKCY3XegyVU85v71JV
InsbU+XgWev2FDmTYvwEhgHVwuOR5xrX0mc3rZzcmqFrjAisgpIKNDUG/0YMsmLa
nxMfOS9FUiss60lC9J+FjMPhi8aC1aaBLaquvmGvY0Y1uszDeJAIswneUWeBZOKB
YI/LgHw3wGxpg1Zq6Z6539vejNEz48+bgmA/VtZr6kKfC/z7wd14gdM2iqN8eH4Y
+St0GpHqpOjAbyfyV0dLZRaQXbCMbIN2sTQKX2swTMgCI4IYGY+bhrbjebz5a6Rt
HU8aaRYc0g/i8clUkIc/twq/weNKEDcs/+fTjenTcsqbPJk0/PRC7XplG8tfiUTs
KqkNgSqP7e4lKn3Iuh6/GtnBqbR8VImEJB+UF2W0VCKq6wY8ebCvGOxKCPLfhybO
tHg5sFTl5IQtjM68yWKO6Prx4kcGQKIzAkcoPiSqNQSXf8+jswt9PYRTkET4hhaV
auUsY6YNe88m22pQzQEKiNDeG/93G23deT7ohSBFJ8o2QLwYW50MU2vSFTqJw1ox
9/ZCr+a5hC/nxpW88q3iaWzXCr+GZ3mHTs/vSTCijGXkkPN5cMBQMaNgSmjkZ947
4Cbpnj1X/y+1qQ5XcCDT44zdSJA25GFaq8HOxsx78k6eev4tmXE=
=/Cpf
-----END PGP SIGNATURE-----

--lGQpFNrcSq0Rb43w--
