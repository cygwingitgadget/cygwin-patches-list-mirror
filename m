Return-Path: <SRS0=Mvmz=6W=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	by sourceware.org (Postfix) with ESMTPS id BCF3B4BA2E04
	for <cygwin-patches@cygwin.com>; Tue, 16 Dec 2025 09:17:11 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org BCF3B4BA2E04
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org BCF3B4BA2E04
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.15.19
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1765876632; cv=none;
	b=TI2ejVOu1rVSBXrBDOLnlLRLF8K8TLi1MFQEqfUAGE7Rt/aUOlnjZztty3SWJ300qvuJgE2YydKhXS+A6Vr6iJs8rSHNh3hCclLXnayy3dUnOEKbPTrgwdr6oRtmF04glFMLCHZlaQMqz1ZoPlOJq7wMWxb/1w+u101P/gZpRf8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1765876632; c=relaxed/simple;
	bh=PWWNHHioPafrohXJcgOQvqiv8BYNRuP3taQsRZg3U1U=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=EvfPgDV0UmIOYmTm6keFAF7HKipfr7dOJaFwZE2CAHsPttXl5Axn+2Tm6c3ZJEw48eiRVnMRzNL7AT696H0rAbWGx2DWOpB1sw+2OE/NmwgO0HT2oMID/ps+sQd88Pyk9VdEpmBSmgnXQYHBChre71WTErd9j91+ppeqREQX8uc=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org BCF3B4BA2E04
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=a024s24B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1765876630; x=1766481430;
	i=johannes.schindelin@gmx.de;
	bh=n/4E5RpNLlQgsGrT72JerdFlRUBw3clreOpeK/9+lC8=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=a024s24BYD5s5PmOT6xq7+C1JH45nIsmZDPibVogAWv0CnqcdQ6s9FfCsVyEjfp/
	 8DZlizeFjeDnYwY66XCvC4a2dAKyhmyWN/aCUdchPvzoY0MN6LEqngiY62oUbqbgL
	 V0Tt3TPQTGLr3bPKsvwX4l63ebm5ASlWFHu8hnVsM1sC5ruLsuV7/r6EzitWcG40f
	 kUGLOrgqJM3THnJb5NrtBLCzhfJ7AcKNpfCPEhR148NMXpzbqD/bHlkjao6aNQEj/
	 H1I2e7rmY0STA8rjc1PQM/OhSBmHL5PFwfYBcGNoArdY72ggrRhtdw0me6Yp86nJN
	 r4F2+NwMPnxl5psRqQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.215.18]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N5GDv-1vwprn1FB7-00tFQx; Tue, 16
 Dec 2025 10:17:10 +0100
Date: Tue, 16 Dec 2025 10:17:08 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: termios: Follow symlink in is_console_app()
In-Reply-To: <20251216083945.235-1-takashi.yano@nifty.ne.jp>
Message-ID: <ebc2c64d-55c4-98f5-573f-bebadf3e3979@gmx.de>
References: <20251216083945.235-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:JYixMh6hj4qh1WuvzGEGb7RjsFbK7LR5rBXXo0IBlfzLqLttyvS
 ornFUSH5l3InrTkLUFmN6ryI2gV5pCQX6a8ynZ8XuWltDrYUk8+7fL+oQv4FwhNd0pHbfdL
 Kz0gUbBEwkDD+51zhggZ4V6krUwJCPCybdJGDMLBinegmu5eEYWWQ/SI9DQiJsoROnlGJrV
 mxaMcONvwdiyBa8QneuMA==
UI-OutboundReport: notjunk:1;M01:P0:3lZu8UxQGnQ=;1AyAi0tbsJF6WsizpGzFOQRkfNF
 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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Tue, 16 Dec 2025, Takashi Yano wrote:

> After the commit f74dc93c6359, WSL cannot start by distribution name
> such as debian.exe, which has '.exe' extention but actually is a symlink=
.
> This is because is_console_app () returns false for that symlink due
> to open-failure. This patch fixes the issue using PC_SYM_FOLLOW option
> in path_conv.

The commit message still does not clarify that this has pretty nothing to
do with symlinks, but everything with app execution aliases.

In fact, the commit message still misleads the reader to think that
executing each any every symlink is broken, which could easily lead to a
lot of time wasted wondering why this bug hasn't been detected for a very,
very long time. Let's avoid being this inconsiderate of reviewers' time.

Speaking of reviewers' time: I implore you to rethink the practice of
tossing a v2 over the fence without saying what was wrong with v1 and how
v2 addresses that. If you truly care for the craft of software
engineering, you will realize that explaining your thought process is a
vital part of any contribution, and that is was I am missing here.

> Fixes: f74dc93c6359 ("fix native symlink spawn passing wrong arg0")

Hmm. Since this patch likely fixes the problem reported in
https://inbox.sourceware.org/cygwin/CAAM_cieBo_M76sqZMGgF+tXxswvT=3DjUHL_p=
Shff+aRv9P1Eiug@mail.gmail.com
(and even **implicitly** talks about app execution aliases, because that's
what `debian.exe` resolves to), I am unsure that this footer refers to
**the** most related commit.

> Reviewed-by:

An empty footer? Was that an oversight or intentional?

> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> ---
>  winsup/cygwin/fhandler/termios.cc       | 19 ++++++++++++++-----
>  winsup/cygwin/local_includes/fhandler.h |  2 +-
>  winsup/cygwin/spawn.cc                  |  2 +-
>  3 files changed, 16 insertions(+), 7 deletions(-)
>=20
> diff --git a/winsup/cygwin/fhandler/termios.cc b/winsup/cygwin/fhandler/=
termios.cc
> index 19d6220bc..ff6c06015 100644
> --- a/winsup/cygwin/fhandler/termios.cc
> +++ b/winsup/cygwin/fhandler/termios.cc
> @@ -702,10 +702,19 @@ fhandler_termios::fstat (struct stat *buf)
>  }
> =20
>  static bool
> -is_console_app (const WCHAR *filename)
> +is_console_app (path_conv *pc)

For the sake of readers who aren't familiar with your v1: This is probably
the most interesting change between v1 and v2 of this patch.

Since `NULL` would not make sense in this function, I would deem
`path_conv &pc` more appropriate.

However, it is said that there are two categories of patches in which no
obvious bugs reside: those patches that are so clear and elegant that
there simply cannot be any obvious bug, and those so convoluted or so
overarching that there are at least no _obvious_ bugs.

The structure of this patch looks very little like the former, desirable
category to me. This is worrisome given the extended history of this part
of Cygwin's source code that has seen way more bugs and regressions than
I'd like to unleash on my users. Yet it would be so easy to gain more
confidence in this patch, simply by extracting out the signature change
(and making it a proper reference instead of a pointer)!

>  {
> +  const WCHAR *native_path =3D pc->get_nt_native_path ()->Buffer;
> +  if (pc->issymlink ())

That's probably a bit too overarching. Have you tried whether this patch
is required to execute programs via regular symbolic links instead of app
execution aliases?

> +    {
> +      UNICODE_STRING upath;
> +      RtlInitUnicodeString (&upath, native_path);
> +      path_conv target (&upath, PC_SYM_FOLLOW);
> +      native_path =3D target.get_nt_native_path ()->Buffer;
> +    }
> +
>    HANDLE h;
> -  h =3D CreateFileW (filename, GENERIC_READ, FILE_SHARE_READ,
> +  h =3D CreateFileW (native_path, GENERIC_READ, FILE_SHARE_READ,

How certain can we be that the `Buffer` of that now out-of-scope `target`
is still valid at this point? This code pattern is highly indicative of a
use-after-free problem (if not in the present, then quite likely in the
future).

>  		   NULL, OPEN_EXISTING, 0, NULL);
>    char buf[1024];
>    DWORD n;
> @@ -716,7 +725,7 @@ is_console_app (const WCHAR *filename)
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

In my patch series (which tries to target very specifically the problem of
app execution aliases _without_ risking to cause any regression in only
vaguely-related scenarios such as canonical symlinks), I move this check
up so that the comparatively expensive read operation can be avoided if we
already know that the file extension indicates a console application.

You can find my v2 (with change log since v1 and range-diff...) here:
https://inbox.sourceware.org/cygwin-patches/pull.5.v2.cygwin.1765818395.gi=
tgitgadget@gmail.com/

I understand that it is technically "more correct" to resolve any symlink
and then look at the target file name instead of looking at `filename`
always. In practice, I highly doubt that any app execution alias exists
that has a different file extension than its target.

It would probably make more sense to collaborate and try to combine the
best of your patch with the best of my patch series. For example, I could
easily integrate a patch into my series that changes the signature of
`is_console_app()` to take a `path_conv &` instead of a `WCHAR *`.

Ciao,
Johannes

>    return false;
> @@ -755,7 +764,7 @@ fhandler_termios::ioctl (unsigned int cmd, void *var=
g)
> =20
>  void
>  fhandler_termios::spawn_worker::setup (bool iscygwin, HANDLE h_stdin,
> -				       const WCHAR *runpath, bool nopcon,
> +				       path_conv *pc, bool nopcon,
>  				       bool reset_sendsig,
>  				       const WCHAR *envblock)
>  {
> @@ -794,7 +803,7 @@ fhandler_termios::spawn_worker::setup (bool iscygwin=
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
> index 0de82163e..d2d724fb7 100644
> --- a/winsup/cygwin/local_includes/fhandler.h
> +++ b/winsup/cygwin/local_includes/fhandler.h
> @@ -2036,7 +2036,7 @@ class fhandler_termios: public fhandler_base
>      spawn_worker () :
>        ptys_need_cleanup (false), cons_need_cleanup (false),
>        stdin_is_ptys (false), ptys_ttyp (NULL) {}
> -    void setup (bool iscygwin, HANDLE h_stdin, const WCHAR *runpath,
> +    void setup (bool iscygwin, HANDLE h_stdin, path_conv *pc,
>  		bool nopcon, bool reset_sendsig, const WCHAR *envblock);
>      bool need_cleanup () { return ptys_need_cleanup || cons_need_cleanu=
p; }
>      void cleanup ();
> diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
> index 71add8755..9c062d58f 100644
> --- a/winsup/cygwin/spawn.cc
> +++ b/winsup/cygwin/spawn.cc
> @@ -579,7 +579,7 @@ child_info_spawn::worker (const char *prog_arg, cons=
t char *const *argv,
> =20
>        bool no_pcon =3D mode !=3D _P_OVERLAY && mode !=3D _P_WAIT;
>        term_spawn_worker.setup (iscygwin (), handle (fileno_stdin, false=
),
> -			       runpath, no_pcon, reset_sendsig, envblock);
> +			       &real_path, no_pcon, reset_sendsig, envblock);
> =20
>        /* Set up needed handles for stdio */
>        si.dwFlags =3D STARTF_USESTDHANDLES;
> --=20
> 2.51.0
>=20
>=20
