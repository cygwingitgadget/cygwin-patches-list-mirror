Return-Path: <SRS0=APpz=6X=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	by sourceware.org (Postfix) with ESMTPS id 897F74BA2E05
	for <cygwin-patches@cygwin.com>; Wed, 17 Dec 2025 14:56:06 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 897F74BA2E05
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 897F74BA2E05
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.17.20
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1765983366; cv=none;
	b=fetuhodjOzFWVORVHGqSWlRWNxL3OP7TlGFuOd7WW+tYX96j3v0sv+7xUDf5bZ2+38E3fALljm76owV5n9Evz2fwYa2DtietAcWD7s25eT3fq7cEjMxcT8QzGvNNUO0vSRTx6BGG/OQ/Ne6xX1cp2WTdnioik8ciy8DNsQS8ais=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1765983366; c=relaxed/simple;
	bh=ptbKdxfEbrLHzkvVx/hshkXKe90JFuwy+qPO2ws5W2o=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=MIcQ6P0vOMjLd6Oxfdrn41y9C5fvvmfs6VhOj3u3q3kWdeJvK5zHEVg7M55M0cGT9w8vyKDR+HMFMvZIf1623bWYwSgWiia/HC15g5xmgbCm7OA/7aus8hfBymk6pNRD0FGDXGKdqQWrEYLqWMSHR8V/MeaaSfwnunuoq0TpvGk=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 897F74BA2E05
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=TVqfbCFa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1765983359; x=1766588159;
	i=johannes.schindelin@gmx.de;
	bh=yBSrpVTjtJM5/947mCswVsBYztZ7998kuIfU2rv9J7k=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=TVqfbCFao6/GR2hCimTOoqiGIpzE5d6K57upgHecPgh+joyqsqL8iZfvsvKvPsLj
	 HZp1ecqC2tIQ6fg/7I0pNby0OpH3F6EO3Pd7m6HwbZwxQWhkzX8O9DFNuK3mhcXo8
	 m4eWSzDA5GS2XrCCtG//jfHHbIAJumK9Ry8EnHXWPCWYauLbFt2t3UAK/WGA3jSJi
	 Dh4jHt98z313Xq+cCPkJYHQ2As550pHIBIUHrY7xiZeVyt3TgghuziL1WxSC/btQ3
	 D0QYHSF1Vz/6GdaDs8KKy8aO67PCKNFTzj7k2uGTNLV4M65m0gRUUG2VZg8QP5goK
	 H6YR+A3PovCsPXewMw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.212.212]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MLzFx-1vEUeM3HTF-00Lj0J; Wed, 17
 Dec 2025 15:55:59 +0100
Date: Wed, 17 Dec 2025 15:55:58 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3 2/2] Cygwin: termios: Handle app execution alias in
 is_console_app()
In-Reply-To: <20251217093003.375-3-takashi.yano@nifty.ne.jp>
Message-ID: <a4777af3-0f55-1b29-9fa7-cc38c47a3291@gmx.de>
References: <20251217093003.375-1-takashi.yano@nifty.ne.jp> <20251217093003.375-3-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:5aG/8qssvMfG3m4cYGFAjHNQ6nd3FEqil4MxC1WjJEF6v/TWqw1
 kXhJPalCx21xEuwF+HNJSekfueVnjeCkHtSoOhmA2LQZbMVkC+v2UBT1g049iVYwmETIUGp
 D7CW0USBG7fykApj18sVf9SNkeBRrbt+yyOZQecEAtx8l+t1XGMNHMh7+6PKJps+T2J7VsZ
 I90FXg2noHF6Q5Op7ApRQ==
UI-OutboundReport: notjunk:1;M01:P0:pIVlJ+vVQ9g=;DxOpZ2pWI7T140/GeF9WlmbRR80
 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
 OsMrQsrE=
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-11.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Wed, 17 Dec 2025, Takashi Yano wrote:

> After the commit f74dc93c6359, WSL cannot start by distribution name
> such as debian.exe, which has '.exe' extention but actually is an app
> execution alias. The commit f74dc93c6359 disables to follow windows
> reparse point by adding PC_SYM_NOFOLLOW_REP flag in spawn.cc. As a
> result, is_console_app () returns false for the app execution alias
> due to open-failure because CreateFileW() cannot open an app execution
> alias. This patch fixes the issue by converting the path again using
> PC_SYM_FOLLOW (without PC_SYM_NOFOLLOW_REP) option in path_conv if
> the path is an app execution alias.

Since you repeat this commit as the culprit, I guess that this is your way
to explain to me that before this commit, the standard handles were
correctly set even after 2533912fc76c (Allow executing Windows Store's
"app execution aliases", 2021-03-12) allowed executing Microsoft Store
Apps via their app execution aliases?

> Fixes: f74dc93c6359 ("fix native symlink spawn passing wrong arg0")
> Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> ---
>  winsup/cygwin/fhandler/termios.cc       | 21 ++++++++++++++++-----
>  winsup/cygwin/local_includes/fhandler.h |  2 +-
>  winsup/cygwin/spawn.cc                  |  2 +-
>  3 files changed, 18 insertions(+), 7 deletions(-)
>=20
> diff --git a/winsup/cygwin/fhandler/termios.cc b/winsup/cygwin/fhandler/=
termios.cc
> index 19d6220bc..7fdbf6a97 100644
> --- a/winsup/cygwin/fhandler/termios.cc
> +++ b/winsup/cygwin/fhandler/termios.cc
> @@ -702,10 +702,21 @@ fhandler_termios::fstat (struct stat *buf)
>  }
> =20
>  static bool
> -is_console_app (const WCHAR *filename)
> +is_console_app (path_conv &pc)

I see you insist of mixing the refactor where `path_conv &` is passed
instead of `WCHAR *` with the actual fix.

Not a fan. I regularly hit your commits when bisecting Cygwin runtime
regressions, and I have not yet learned to be okay with finding patches
that do too many things at the same time.

I'm weven less a fan of the non-descriptive variable name `pc` which
unnecessarily increases cognitive load.

But hey, rather than shouting my objections to the form in the void, I'll
just accept that my recommendations are not welcome, and this is the shape
of the patch that you want to have. It does fix the bug, so that's good.

Ciao,
Johannes

>  {
> +  tmp_pathbuf tp;
> +  WCHAR *native_path =3D tp.w_get ();
> +  pc.get_wide_win32_path (native_path);
> +  if (pc.is_app_execution_alias ())
> +    {
> +      UNICODE_STRING upath;
> +      RtlInitUnicodeString (&upath, native_path);
> +      path_conv target (&upath, PC_SYM_FOLLOW);
> +      target.get_wide_win32_path (native_path);
> +    }
> +
>    HANDLE h;
> -  h =3D CreateFileW (filename, GENERIC_READ, FILE_SHARE_READ,
> +  h =3D CreateFileW (native_path, GENERIC_READ, FILE_SHARE_READ,
>  		   NULL, OPEN_EXISTING, 0, NULL);
>    char buf[1024];
>    DWORD n;
> @@ -716,7 +727,7 @@ is_console_app (const WCHAR *filename)
>    IMAGE_NT_HEADERS32 *p =3D (IMAGE_NT_HEADERS32 *) memmem (buf, n, "PE\=
0\0", 4);
>    if (p && (char *) &p->OptionalHeader.DllCharacteristics <=3D buf + n)
>      return p->OptionalHeader.Subsystem =3D=3D IMAGE_SUBSYSTEM_WINDOWS_C=
UI;
> -  wchar_t *e =3D wcsrchr (filename, L'.');
> +  wchar_t *e =3D wcsrchr (native_path, L'.');
>    if (e && (wcscasecmp (e, L".bat") =3D=3D 0 || wcscasecmp (e, L".cmd")=
 =3D=3D 0))
>      return true;
>    return false;
> @@ -755,7 +766,7 @@ fhandler_termios::ioctl (unsigned int cmd, void *var=
g)
> =20
>  void
>  fhandler_termios::spawn_worker::setup (bool iscygwin, HANDLE h_stdin,
> -				       const WCHAR *runpath, bool nopcon,
> +				       path_conv &pc, bool nopcon,
>  				       bool reset_sendsig,
>  				       const WCHAR *envblock)
>  {
> @@ -794,7 +805,7 @@ fhandler_termios::spawn_worker::setup (bool iscygwin=
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
