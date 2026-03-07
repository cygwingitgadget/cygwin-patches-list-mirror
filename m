Return-Path: <SRS0=qb86=BH=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	by sourceware.org (Postfix) with ESMTPS id E2B804BA2E11
	for <cygwin-patches@cygwin.com>; Sat,  7 Mar 2026 09:51:47 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E2B804BA2E11
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org E2B804BA2E11
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.17.21
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1772877108; cv=none;
	b=UBkkwHJHdETSPre8oiSCEEMhX962HzRvMmps9poJIGO9JblMoFUxYIyT1/h2U7ln/W3vNTH/q9tFUVCQ32t6WyhJPluXJruZ140Uj6gZPc0eM14K6c5UsUyyCHDdgQCyzoF27DrAUsustewCymWTNtp+WsGEQj4C8HCTQjk/LjU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1772877108; c=relaxed/simple;
	bh=rPWdhe47G3e146EeUX+hdfkl/rbmjm9iPoq0l2jMdH4=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=ku1ILXSXm9x8aVS2iQ14n5clBXhQlsmUKUxzRpfVzn7j43xGOet97vLZe7a/LQK1Pd4Qom+bAHycMnTcVDfW+EfltAmUggx7KVBSFNzoFIuQXd2gwIPg8q/UmShYeYHp1R2FRV0ZqyvvsZTd4Hfs6HkDEJTiOCbBXL1pKZ6UkdY=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E2B804BA2E11
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=Me/qGNqo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1772877101; x=1773481901;
	i=johannes.schindelin@gmx.de;
	bh=xLek4q8++VCnEaktgWKDDjHl6kM6PMZyAlhGUy9xtNE=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Me/qGNqopFeOAE+ZaXg1pg8SaUtIl4drobPP3sJogozMuybZYPOnr7t/YJYb9KRh
	 GeU9KorwVKbKVbyG/QZ1PGDCUNfbNeOPGe4j0wmRqf9FtNdH/P4+XbwSP4GDXHI12
	 WUDH76YvGZe5yb85S+52z4CT6Rx/sq7lisZuhDNG1ks5NgiLAUOchaIQW5wwx3Bec
	 bZh4Z0J5+KvkB3ZsW5HZQOyOo3pflI9caq4lLUaErO9LBbOdjU/cMnXEsBOod7Od6
	 DP+0nTA9VVLFjDpdCd16qsYuFlHq3iMwz6x8cmgTVR6LYvHN98UVAnszBqxhMEFB4
	 hj37RCgCoojgmn9nmA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MjS9C-1vDu2Z1XPW-00e1ER; Sat, 07
 Mar 2026 10:51:41 +0100
Date: Sat, 7 Mar 2026 10:51:39 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Make Ctrl-C work for non-cygwin app in
 GDB
In-Reply-To: <20260228090219.2551-2-takashi.yano@nifty.ne.jp>
Message-ID: <de0c0ac5-a266-804c-79fe-08726ce4f969@gmx.de>
References: <20260228090219.2551-1-takashi.yano@nifty.ne.jp> <20260228090219.2551-2-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:NxRRkzCYwckg0onFJwM/b1yxv9BzFdYjbM31bbx+FO71ujn+jGT
 DY8N50ARCJ0A4nvM9oUs9IB7yuZey54KvMNuzbmn5FjvaSq21ZipG24A+qUSOJZqaucpxcv
 yURF3bB6k4w/xkIsCi382+Bl5k1wjPWOExb7KtIHfUqDp1vudrUtR3hPa7m9bVlP3LwKpHf
 Hbyi24RuTOPrjhrbv/Qiw==
UI-OutboundReport: notjunk:1;M01:P0:fwwlOo2PDdg=;eXDWr2ccPwCqQdXCHtNUGUWt3G4
 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
 y149m9cuGoPJOy9lzjX23SLWbiE2I
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Sat, 28 Feb 2026, Takashi Yano wrote:

> At some point in the past, GDB sets its own pgid to inferior pid
> when the inferior is running.

I _guess_ by "inferior" you refer to the program debugged in GDB? But no,
that cannot be true, as GDB is the parent process of that and shouldn't
_also_ be a child at the same time (which setting pgid in that way would
imply).

> Due to this behaviour, Ctrl-C does not work if the inferior is a
> non-cygwin app.

Wait, what? Setting pgid breaks Ctrl+C? _How_?

> This is because, the current code sends Ctrl-C to GDB only when GDB's
> pgid equeals to terminal pgid. This patch omit checking pgid when
> recognizing GDB process whose inferior is non-cygwin app.

Okay, that's a lot to unpack here, especially because the diff context
below is way too small to give the full picture.

>=20
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Reviewed-by:
> ---
>  winsup/cygwin/fhandler/termios.cc | 18 +++++++++---------
>  winsup/cygwin/tty.cc              |  4 ++--
>  2 files changed, 11 insertions(+), 11 deletions(-)
>=20
> diff --git a/winsup/cygwin/fhandler/termios.cc b/winsup/cygwin/fhandler/=
termios.cc
> index 694a5c20f..00700aed8 100644
> --- a/winsup/cygwin/fhandler/termios.cc
> +++ b/winsup/cygwin/fhandler/termios.cc
> @@ -346,11 +346,11 @@ fhandler_termios::process_sigs (char c, tty* ttyp,=
 fhandler_termios *fh)
>  		     a marker for GDB with non-cygwin inferior in pty code.
>  	 !PID_CYGPARENT: check this for GDB with cygwin inferior or
>  			 cygwin apps started from non-cygwin shell. */
> -      if (c =3D=3D '\003' && p && p->ctty =3D=3D ttyp->ntty && p->pgid =
=3D=3D pgid
> -	  && ((p->process_state & PID_NOTCYGWIN)
> +      if (c =3D=3D '\003' && p && p->ctty =3D=3D ttyp->ntty
> +	  && ((p->pgid =3D=3D pgid && ((p->process_state & PID_NOTCYGWIN)
> +				   || !(p->process_state & PID_CYGPARENT)))
>  	      || ((p->exec_dwProcessId =3D=3D p->dwProcessId)
> -		  && ttyp->pty_input_state_eq (tty::to_nat))
> -	      || !(p->process_state & PID_CYGPARENT)))
> +		  && ttyp->pty_input_state_eq (tty::to_nat))))

This is one complex change of logic. Primarily because the logic was
already complicated before this patch, and it is still complicated after
the patch, but in a different way. And therefore it is very hard for me to
confirm that it is correct, not without further help.

The `p->pgid =3D=3D pgid` condition (whose purpose is hard to understand
without being given any context) now no longer guards the `to_nat` check,
before this change, it did.

That's all I understand after pouring over this diff for 10 minutes, and I
do not feel any closer to being able to confirm that this change is correc=
t.

>  	{
>  	  /* Ctrl-C event will be sent only to the processes attaching
>  	     to the same console. Therefore, attach to the console to
> @@ -403,12 +403,12 @@ fhandler_termios::process_sigs (char c, tty* ttyp,=
 fhandler_termios *fh)
>  	  if (!p->cygstarted && !(p->process_state & PID_NOTCYGWIN)
>  	      && (p->process_state & PID_DEBUGGED))
>  	    with_debugger =3D true; /* inferior is cygwin app */
> -	  if (!(p->process_state & PID_NOTCYGWIN)
> -	      && (p->exec_dwProcessId =3D=3D p->dwProcessId) /* Check marker *=
/
> -	      && ttyp->pty_input_state_eq (tty::to_nat)
> -	      && p->pid =3D=3D pgid)
> -	    with_debugger_nat =3D true; /* inferior is non-cygwin app */
>  	}
> +      if (p &&  p->ctty =3D=3D ttyp->ntty
> +	  && !(p->process_state & PID_NOTCYGWIN)
> +	  && (p->exec_dwProcessId =3D=3D p->dwProcessId) /* Check marker */
> +	  && ttyp->pty_input_state_eq (tty::to_nat))
> +	with_debugger_nat =3D true; /* inferior is non-cygwin app */

Okay, so now this lengthy `if` statement was moved outside of a block, but
the three diff context line are too few to help us here. So I looked it
up: it is a block guarded by:

	if (p && p->ctty =3D=3D ttyp->ntty && p->pgid =3D=3D pgid)

Which means that the new code skips both `p->pgid =3D=3D pgid` and `p->pid=
 =3D=3D
pgid` checks.

But here, we're outside of the big `PID_NOTCYGWIN: check this for
non-cygwin process` block, so it is conceivable that this change
introduces unintended side effects for the non-GDB cases.

>      }
>    if ((with_debugger || with_debugger_nat) && need_discard_input)
>      {
> diff --git a/winsup/cygwin/tty.cc b/winsup/cygwin/tty.cc
> index 0c49dc2bd..3ab30c0a7 100644
> --- a/winsup/cygwin/tty.cc
> +++ b/winsup/cygwin/tty.cc
> @@ -340,8 +340,8 @@ tty::nat_fg (pid_t pgid)
>    for (unsigned i =3D 0; i < pids.npids; i++)
>      {
>        _pinfo *p =3D pids[i];
> -      if (p->ctty =3D=3D ntty && p->pgid =3D=3D pgid
> -	  && ((p->process_state & PID_NOTCYGWIN)
> +      if (p->ctty =3D=3D ntty
> +	  && (((p->process_state & PID_NOTCYGWIN) && p->pgid =3D=3D pgid)

This change is slightly less gnarly than the first one in this patch, and
it recapitulates the idea that I _believe_ to understand to be behind that
first change: to stop guarding the GDB check behind a `p->pgid =3D=3D pgid=
`,
but keep that guard for the other condition(s).

So now I am starting to understand the connection between the diff and the
explanation in the commit message. But I have to say that I am highly
suspicious of unintentional side effects: The commit message talks about a
specific GDB behavior change that was introduced "[a]t some point in the
past", and then describes a very specific pgid scenario. The diff,
however, does not add that scenario to the guards, it takes the pgid guard
away completely. This leaves a lot of room for scenarios that do not
involve GDB at all to run into unintentional & unwanted behavioral
changes.

In general, I would expect this patch to benefit greatly from wrappers
around the conditions that are currently in place verbatim: reading

	(p->process_state & PID_NOTCYGWIN) && p->pgid =3D=3D pgid

tells me very, very little, while reading

	!p->is_foreground_process_a_cygwin_process ()

would immediately give me enough context to understand the intention of
the condition.

Please consider refactoring especially these gnarly, deeply nested
conditions to a more readable form by wrapping them in simple, small
helper methods whose names refer to the intention more than to the
implementation details ("is this a GDB child process", "is Cygwin in the
foreground", etc instead of "in which process state are we in", "does the
current pgid match the pgid of `p`", etc).

It is okay for inlined conditions to duplicate sub-conditions. If you end
up with `a () || b () || c ()` conditions where all of `a ()`, `b ()` and
`c ()` start with the same, say, `p->pgid =3D=3D pgid &&` guard, the compi=
ler
will simplify the machine code. If the actual names of those methods are
descriptive, it will make the code a lot more readable, and hence much
easier to review, and hence much less likely to be buggy.

Just to make myself clear: I do not fully understand this patch in the
current shape, and therefore cannot confirm whether or not it is correct.

Ciao,
Johannes

>  	      /* Below is true for GDB with non-cygwin inferior */
>  	      || p->exec_dwProcessId =3D=3D p->dwProcessId))
>  	return true;
> --=20
> 2.51.0
>=20
>=20
