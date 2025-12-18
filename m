Return-Path: <SRS0=Z/EC=6Y=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	by sourceware.org (Postfix) with ESMTPS id 706774BA2E05
	for <cygwin-patches@cygwin.com>; Thu, 18 Dec 2025 08:23:00 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 706774BA2E05
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 706774BA2E05
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.15.18
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1766046180; cv=none;
	b=R5AnmXdBTUq4v/kFlKq1+1edXhn4DKwlX3pR+kJBVRjKCZKvWUWaRcD3BkikY5CIEtNPyx4Uu7AdOKqhR9US6LtKYb+ubC8slRwWYhjrHriJ+YXxyZEvyXLQdn8iniZUFyo2mPE4zM6hP/oNULHTCWU4Ixi2t14MDqUFK5wFfow=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1766046180; c=relaxed/simple;
	bh=N0DC9npQh8vB2gzN208IgK5XD54Fi6pkE535q7FDLXI=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=D+CFQ/HjQGxGjOiPXT+j7fB/PmeIv8rG1ur/BCX/74PvmGs5JpYf1Aw/qIJN96gZB/80rmX1mVsCg27wOo2uf+DBzLe/OW10xTZa1TqD/S6XKcxJEKpeVTqeq25/hKx3xXT/5awRWGzaolDMiuGnMLXJezqr8gt8OssUs85+jYU=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 706774BA2E05
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=UaTaUkxS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1766046174; x=1766650974;
	i=johannes.schindelin@gmx.de;
	bh=4HOulmJLTggDuGjKiURs+nxha5kTdUZf2IMme48zSA0=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=UaTaUkxStxa3IAggV0naMEFLg10vJog02ATlz709obIdr0/jeNuwWConCSA/8s9+
	 Ih/vO6nUbEMJ3NUjYeYuAH/OsJwNhop5B+a+P6U8TPFhjEuj5ivwe3fA6bEcJzpsV
	 dekZRKiHl2crUa/w8Ky+WDpDbTyeT3OH3TNLB1vCYtJwGQVLBxNoddvXYSm6SCq//
	 ymUbVkIQ7M1GWNG4wA0Ig8BS+dZgvrT43d070gKCCwkXoPF5ClDY4jFKjNGgU62Ud
	 u0WsJesfjmm5wKFZluODMDjmo4GBGwIKkBx0M/Le/xD6e31B76FGimSDjMeN7KHZ6
	 kEemYzGnyjTM/94cXg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.212.212]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mt79P-1vpaqN0EEj-00zARs; Thu, 18
 Dec 2025 09:22:54 +0100
Date: Thu, 18 Dec 2025 09:22:52 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v4 5/5] Cygwin: termios: Handle app execution alias in
 is_console_app()
In-Reply-To: <20251218072813.1644-6-takashi.yano@nifty.ne.jp>
Message-ID: <3f93cf29-ce67-b8f4-fb5a-c4f6bce50e4d@gmx.de>
References: <20251218072813.1644-1-takashi.yano@nifty.ne.jp> <20251218072813.1644-6-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:l6ho0GFWZePG9Y9uc8T4LAftF4GOg4R6q+xM7WeDNYoH30yIFt7
 U1zW3YriXCXfkE7595VocorEzSC2/1BJZJ1QyWAOKrWUguy19vEBD1H6sJfsiKuYerd5EmW
 RYUjtrpoN8bFZvJN112Ru6ibRgQHu3CO2P81qgDCwPqhVtdCa98FTjS9dkTZV3gQRkAL2oc
 Pcy3DLbWtnly0k53vdbbg==
UI-OutboundReport: notjunk:1;M01:P0:m+dqTcB3zsk=;Ob1BYfRebWnoGGFgShR3e11+i6J
 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
 nhdJjVBPcihHwHPAzzp2peJ3mphIB
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Thu, 18 Dec 2025, Takashi Yano wrote:

> After the commit f74dc93c6359, WSL cannot start by distribution name
> such as debian.exe, which has '.exe' extention but actually is an app
> execution alias. This is because the commit f74dc93c6359 disabled to
> follow windows reparse point by adding PC_SYM_NOFOLLOW_REP flag in
> spawn.cc, that path is used for sapwning a process. As a result, the
> path, that is_console_app () received, had been the reparse point of
> app execution alias, then it returned false for the the path due to
> open-failure because CreateFileW() cannot open an app execution alias,
> while it can open normal reparse point.  If is_console_app() returns
> false, standard handles for console app (such as WSL) would not be
> setup. This causes that the console input cannot be transfered to the
> non-cygwin app.

Just a suggestion: Start by describing the bug instead of leading with the
commit that caused the bug. Something along the lines "Microsoft Store
apps are run via 'app execution aliases', i.e. special reparse points.
Cygwin usually treats those like symbolic links. However, unlike proper
symbolic links, app execution aliases are not resolved when trying to read
the file contents via `CreateFile()`/`ReadFile()` [...]".

> This patch fixes the issue by locally converting the path, which is
> a path to the app execution alias, once again using PC_SYM_FOLLOW
> (without PC_SYM_NOFOLLOW_REP) option path_conv for using inside of
> is_console_app() to resolve the reparse point here, if the path is
> an app execution alias.
>=20
> Fixes: f74dc93c6359 ("fix native symlink spawn passing wrong arg0")
> Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> ---
>  winsup/cygwin/fhandler/termios.cc       | 23 ++++++++++++++++++-----
>  winsup/cygwin/local_includes/fhandler.h |  2 +-
>  winsup/cygwin/spawn.cc                  |  2 +-
>  3 files changed, 20 insertions(+), 7 deletions(-)
>=20
> diff --git a/winsup/cygwin/fhandler/termios.cc b/winsup/cygwin/fhandler/=
termios.cc
> index f99ae6c80..694a5c20f 100644
> --- a/winsup/cygwin/fhandler/termios.cc
> +++ b/winsup/cygwin/fhandler/termios.cc
> @@ -702,13 +702,26 @@ fhandler_termios::fstat (struct stat *buf)
>  }
> =20
>  static bool
> -is_console_app (const WCHAR *filename)
> +is_console_app (path_conv &pc)
>  {
> -  wchar_t *e =3D wcsrchr (filename, L'.');
> +  tmp_pathbuf tp;
> +  WCHAR *native_path =3D tp.w_get ();
> +  pc.get_wide_win32_path (native_path);
> +
> +  wchar_t *e =3D wcsrchr (native_path, L'.');
>    if (e && (wcscasecmp (e, L".bat") =3D=3D 0 || wcscasecmp (e, L".cmd")=
 =3D=3D 0))
>      return true;
> +
> +  if (pc.is_app_execution_alias ())
> +    {
> +      UNICODE_STRING upath;
> +      RtlInitUnicodeString (&upath, native_path);
> +      path_conv target (&upath, PC_SYM_FOLLOW);
> +      target.get_wide_win32_path (native_path);
> +    }
> +

It might make sense to move this `is_app_execution_alias()` block before
looking at the file extension, not that it will matter a lot in pratices
because as far as I understand, app execution aliases are only ever
created for `.exe` files, with the same base name as the target (or at
least with the same file extension).

Ciao,
Johannes

>    HANDLE h;
> -  h =3D CreateFileW (filename, GENERIC_READ, FILE_SHARE_READ,
> +  h =3D CreateFileW (native_path, GENERIC_READ, FILE_SHARE_READ,
>  		   NULL, OPEN_EXISTING, 0, NULL);
>    if (h =3D=3D INVALID_HANDLE_VALUE)
>      return true;
> @@ -761,7 +774,7 @@ fhandler_termios::ioctl (unsigned int cmd, void *var=
g)
> =20
>  void
>  fhandler_termios::spawn_worker::setup (bool iscygwin, HANDLE h_stdin,
> -				       const WCHAR *runpath, bool nopcon,
> +				       path_conv &pc, bool nopcon,
>  				       bool reset_sendsig,
>  				       const WCHAR *envblock)
>  {
> @@ -800,7 +813,7 @@ fhandler_termios::spawn_worker::setup (bool iscygwin=
, HANDLE h_stdin,
>  	    ptys->setup_locale ();
>  	  }
>      }
> -  if (!iscygwin && ptys_primary && is_console_app (runpath))
> +  if (!iscygwin && ptys_primary && is_console_app (pc))
>      {
>        if (h_stdin =3D=3D ptys_primary->get_handle_nat ())
>  	stdin_is_ptys =3D true;
> diff --git a/winsup/cygwin/local_includes/fhandler.h b/winsup/cygwin/loc=
al_includes/fhandler.h
> index 0de82163e..16f55b4f7 100644
> --- a/winsup/cygwin/local_includes/fhandler.h
> +++ b/winsup/cygwin/local_includes/fhandler.h
> @@ -2036,7 +2036,7 @@ class fhandler_termios: public fhandler_base
>      spawn_worker () :
>        ptys_need_cleanup (false), cons_need_cleanup (false),
>        stdin_is_ptys (false), ptys_ttyp (NULL) {}
> -    void setup (bool iscygwin, HANDLE h_stdin, const WCHAR *runpath,
> +    void setup (bool iscygwin, HANDLE h_stdin, path_conv &pc,
>  		bool nopcon, bool reset_sendsig, const WCHAR *envblock);
>      bool need_cleanup () { return ptys_need_cleanup || cons_need_cleanu=
p; }
>      void cleanup ();
> diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
> index 71add8755..7d993d081 100644
> --- a/winsup/cygwin/spawn.cc
> +++ b/winsup/cygwin/spawn.cc
> @@ -579,7 +579,7 @@ child_info_spawn::worker (const char *prog_arg, cons=
t char *const *argv,
> =20
>        bool no_pcon =3D mode !=3D _P_OVERLAY && mode !=3D _P_WAIT;
>        term_spawn_worker.setup (iscygwin (), handle (fileno_stdin, false=
),
> -			       runpath, no_pcon, reset_sendsig, envblock);
> +			       real_path, no_pcon, reset_sendsig, envblock);
> =20
>        /* Set up needed handles for stdio */
>        si.dwFlags =3D STARTF_USESTDHANDLES;
> --=20
> 2.51.0
>=20
>=20
