Return-Path: <SRS0=jVAF=BF=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	by sourceware.org (Postfix) with ESMTPS id 812C14BA2E0B
	for <cygwin-patches@cygwin.com>; Thu,  5 Mar 2026 10:12:59 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 812C14BA2E0B
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 812C14BA2E0B
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.17.21
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1772705579; cv=none;
	b=CZckfdHrW/EHzqhxIPjWo3uGgz1D9mixehImrI2Ln3fwv/mg3lG6DIllar33UvrYpCCWG48kOEG4pz/0shSKMZQzouhh98NjlrBQcVsPauo4kXHT46nF2KmOANyxKfjLeFYF/nkreiRp/QndL1qPMgJxxR1GZ0H3ma+dozKHTq8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1772705579; c=relaxed/simple;
	bh=Z42RtEgZajhpZSvNRCqQkns95snwrPeBagA1Nw4LEt4=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=CAv/p2CKxGdUgcQc8eqi1oJHckBvikKxz8Z3nRX6BocLLc0Uf0q//JoYJFAGQGD7JnBIp5JPhCbqHyyHw3sxgjDuM9SUFpyGadD14UOT14ntl4WvmwE8NCvxlFM/DbAqasDRd/a3+5YlqdckMSQZ8vsylU5iCHPh4qPg9WcISnk=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 812C14BA2E0B
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=baFb4pTd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1772705573; x=1773310373;
	i=johannes.schindelin@gmx.de;
	bh=qQzmi5E3KB8A7CZRZrlU0IWgpLaJRqHWX6CE25TvxXg=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=baFb4pTd4C/CMxCh5TtZzByx6SMCjwW4zSQ/U2J2H6bxdzIrQqPlOpxPQPxIAfMX
	 nHnESAZyCmjlNgcwPcvXZNl9lF+L0HSSs+lPxp5qIht+pNC2+DQJf2q14uKfhKPUA
	 K6jQn7Nk2pc/JCcG3Kl4osgLQPZfU8WWtLfHJ4LHLLOH3L21kSWeMd6iPRB051Ec8
	 WV33eAwWi8QntS8IQLrRdfwK4+5CBIVLQeVVCI50Qma9Ab88V6/1BJCguAWlwNcu0
	 SJgSs7rps1thrAiYJMY0t8z9tfL3+PxceFYTFcdq4EhqCs//GZVE8HtRYDtDAlz47
	 m/XLY1cr61PEcUyY8g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MtwUm-1vfSx63SMW-016Qha; Thu, 05
 Mar 2026 11:12:52 +0100
Date: Thu, 5 Mar 2026 11:12:50 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Fix input transferring from nat pipe to
 cyg pipe
In-Reply-To: <20260303134058.3517-2-takashi.yano@nifty.ne.jp>
Message-ID: <09e16a98-e580-8846-e69b-1566c0d6871e@gmx.de>
References: <20260303134058.3517-1-takashi.yano@nifty.ne.jp> <20260303134058.3517-2-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-692947909-1772705572=:25200"
X-Provags-ID: V03:K1:IRY7CqP+w7GiqSvIWAfN5Ia+it8RtJkRRacVXlqJUpOm1ltRNqc
 Tb7X7z68GIF6Q485RNIp+vdJaYnFVIOl1W05hggE+elLIUVNzK3VLy0OTR1ZrVTeavnUMhc
 BiG/RMVP4A9prw/qPEVqQQZLGfBa3G2dBwpc+wjXGwxJztByFDmPY7vHk82G7xZ4d7sLe7b
 /eHsqTMShOW7N4tQ+6OGg==
UI-OutboundReport: notjunk:1;M01:P0:dYKTc+dGYsw=;5ATOyfuXh6mDnTu//W7lG1sVwui
 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
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-692947909-1772705572=:25200
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Takashi,

On Tue, 3 Mar 2026, Takashi Yano wrote:

> In disable_pcon mode, input transferring from nat pipe to cyg pipe
> does not work after the commit 04f386e9af99. This is because nat
                                 ^^^^^^^^^^^^

When I imagine myself reading this in a couple of months, I foresee
wishing for the commit OID to be amended by the usual information
(`--format=3Dreference` in Git parlance). In this instance: 04f386e9af
(Cygwin: console: Inherit pcon hand over from parent pty, 2024-10-31).

> pipe hand over is wrongly handled in get_winpid_to_hand_over().
> This function should return the PID that should acquire ownership
> of the nat pipe. However, when pseudo console is disabled, it
> returns PID of cygwin process (such as cygwin shell) when no
> other native (non-cygwin) app is not found.
>=20
> The case that even cygwin app should take over the ownership
> of nat pipe, is happen only in pcon_activated case. This patch
> adds pcon_activated check to the condition where even a cygwin
> app is allowable as a target to hand over.

While this looks technically correct, I suggest that the commit message
should lead with the context and impact, illustrating the bug's symptoms.
The reason? While I now understand what this patch is about, I would have
liked the commit message to help me get there quicker.

Also, I was scratching my head a bit why there is only one changed
condition in the diff when the function contains _three_ calls to
`get_console_process_id()`. The explanation is that the other two calls
filter out Cygwin processes (because those calls use `nat =3D true`). I
guess it cannot hurt to keep trying to get potential other candidates
connected to the console (even if I thought that `disable_pcon` meant that
there simply is no console).

With that in mind, I iterated a bit on a commit message with the help of
Claude Opus, and this is a draft I'd like to take as inspiration:

   Cygwin: pty: Fix nat pipe hand-over when pcon is disabled

   The nat pipe ownership hand-over mechanism relies on the console
   process list =E2=80=94 the set of processes attached to a console, enum=
erable
   via `GetConsoleProcessList()`. This list only exists when there is a
   pseudo console. When pseudo console support is disabled, there is no
   console associated with the PTY, so this list is meaningless.

   04f386e9af (Cygwin: console: Inherit pcon hand over from parent pty,
   2024-10-31) added a last-resort fallback in `get_winpid_to_hand_over()`
   that hands nat pipe ownership to any process in the console process
   list, including Cygwin processes. This fallback is needed when a
   Cygwin process must take over management of an active pseudo console
   after the original owner exits.

   When the pseudo console is disabled, this fallback incorrectly finds a
   Cygwin process (such as the shell) and assigns it nat pipe ownership.
   Since there is no pseudo console for that process to manage, ownership
   never gets released, input stays stuck on the nat pipe, and keyboard
   input to the shell breaks.

   Only the third (last-resort) call in the cascade needs guarding: the
   first two calls filter for native (non-Cygwin) processes via the `nat`
   parameter, and handing ownership to another native process is fine
   regardless of pcon state. It is only the fallback to Cygwin processes
   that is dangerous without an active pseudo console.

   Guard the fallback with a `pcon_activated` check, since handing nat
   pipe ownership to a Cygwin process only makes sense when there is an
   active pseudo console for it to manage.

It could probably use some clarification as to why the other two calls
aren't disabled (I guess the explanation is along the lines that even in
`disable_pcon` mode, there _could_ be an attached Console instance and we
would want to find processes attached to that instance).

Thoughts?

The diff itself is to the point, I like it.

Ciao,
Johannes

>=20
> Fixes: 04f386e9af99 ("Cygwin: console: Inherit pcon hand over from paren=
t pty")
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Reviewed-by:
> ---
>  winsup/cygwin/fhandler/pty.cc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.=
cc
> index 3e8c7ff9f..03f31d1fe 100644
> --- a/winsup/cygwin/fhandler/pty.cc
> +++ b/winsup/cygwin/fhandler/pty.cc
> @@ -3596,7 +3596,7 @@ fhandler_pty_slave::get_winpid_to_hand_over (tty *=
ttyp,
>        if (!switch_to)
>  	switch_to =3D get_console_process_id (current_pid,
>  					    false, true, false, true);
> -      if (!switch_to)
> +      if (!switch_to && ttyp->pcon_activated)
>  	switch_to =3D get_console_process_id (current_pid,
>  					    false, false, false, false);
>      }
> --=20
> 2.51.0
>=20
>=20

--8323328-692947909-1772705572=:25200--
