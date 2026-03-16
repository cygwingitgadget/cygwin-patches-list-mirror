Return-Path: <SRS0=IhUf=BQ=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	by sourceware.org (Postfix) with ESMTPS id A72DB4BA2E09
	for <cygwin-patches@cygwin.com>; Mon, 16 Mar 2026 09:04:05 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org A72DB4BA2E09
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org A72DB4BA2E09
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.15.15
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1773651846; cv=none;
	b=Zfsv/NGEXWdmpVT8bALjppEr+sTfGCWp/k8nJrpiikCa9j3CFNILtUkxxsSrS83sItOzUW7bK2rGEMRGheBkbYi5ZxoH2RF5JaBcAnL/wtnKncE1sPBG+SHzt8qzunopjd4eaEh2gVp8hj5k8AbMHiS4PVx0j1MWoXvwDhPV29U=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1773651846; c=relaxed/simple;
	bh=FJROjTQRVMaqgDml15WY8EhzbnhFZH0rGKLKrsFHf2M=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=KOAeWB7SXr2O64DwBZLgmn5WI1zovzCerwYK4cqvvlcg9BULp7SUS2pFbTf8gFUJFfGBbs4zNL0h8docOaKj4zepDjmnSC8ihMG1sksr8e9N/aZGVji7HqhH6f2mb9o8ox99RTJX9iJhznR+KrGzGvS5sJO5LTUvGm3Q01XNkoE=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A72DB4BA2E09
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=Mb8kM5pN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1773651844; x=1774256644;
	i=johannes.schindelin@gmx.de;
	bh=H2d498g9EftGZRp6PeB24jqgv+0CtP3NUUj2du5eK88=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Mb8kM5pN6eeqZujB4Ub8gRW8rIwdsb5TkwN10L9vohDDxrqQt4QGQObLBvl/pwzi
	 HwYOOOO0t73I0HBCIlWDOKY3T3i1mnS7Nd2Qheqxyv/0jPEfCNFaEc1SQAxQBHAw2
	 Ssk0I0ypO9dTxq5KT+EhYDBR1CxKXC6GWH6eI/lX5Lr4v/aE68yGUFjaAIDMgWwCb
	 E+LdFlwo169KV6riPArNcO14uW+X6YAOewPrbPpqkXVc62f2bRBxu3Kn7V1ilDamf
	 aFHh1UQTLdWna6ygzV+5Ta3f9EXtamE1HMrJY98m63vJG1AZrM/fjzsiWZ5XM/eUF
	 fUktVb9u5zI17YjeBA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M8QS2-1vxg9Z1qwy-005bPQ; Mon, 16
 Mar 2026 10:04:01 +0100
Date: Mon, 16 Mar 2026 10:03:58 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v5 3/3] Cygwin: pty: Add workaround for handling of Ctrl-H
 when pcon enabled
In-Reply-To: <20260312113923.1528-4-takashi.yano@nifty.ne.jp>
Message-ID: <724fc579-2984-9ec6-9c8e-69b334e966bb@gmx.de>
References: <20260312113923.1528-1-takashi.yano@nifty.ne.jp> <20260312113923.1528-4-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:FYWkMHUv2hxRsiN26VDaVZ3xs+mZJRDWzl+9bT/nIg9XvU3HEvK
 xkWhSfGLYXqTdxSnZ7/A983i5nWJdWCSOMV8g/uuHJjVZX+YPidb80zJrK7zOi3wxvw8BOr
 G4uU4pZCkTSBWuoG3ODN670XqLLsV/SGTbBhZd6RCSgD1TfiF2P+NlSDrKc4Iap9764VGlS
 Q3A/lqEWwWrZkKV+KXsBA==
UI-OutboundReport: notjunk:1;M01:P0:+xfcA/mjgBE=;3/Kf92ifj2CSZWCBbRN2tb98vgl
 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
 xY
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Thu, 12 Mar 2026, Takashi Yano wrote:

> OpenConsole.exe has a bug(?) that the Ctrl-H is translated into
> Ctrl-Backspace (not Backspace). This is a workaround for that issue
> which pushes the Ctrl-H as a ConsoleInput event.

I still consider this work-around too brittle to merge.

> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Reviewed-by:
> ---
>  winsup/cygwin/fhandler/pty.cc | 44 +++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>=20
> diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.=
cc
> index bd5c24625..6b353c954 100644
> --- a/winsup/cygwin/fhandler/pty.cc
> +++ b/winsup/cygwin/fhandler/pty.cc
> @@ -2513,9 +2513,53 @@ fhandler_pty_master::write (const void *ptr, size=
_t len)
>  	    }
>  	}
> =20
> +      /* OpenConsole.exe has a bug(?) that Ctrl-H is translated into
> +	 Ctrl-Backspace (not Backspace). The following code is a
> +	 workaround for that issue. */
> +      char *bs_pos =3D (char *) memchr (buf, '\010' /* ^H */, nlen);
> +      HANDLE pcon_owner =3D NULL;
> +      HANDLE h_pcon_in =3D NULL;
> +      DWORD resume_pid =3D 0;
> +      if (bs_pos)
> +	{
> +	  pcon_owner =3D OpenProcess (PROCESS_DUP_HANDLE, FALSE,
> +				    get_ttyp ()->nat_pipe_owner_pid);
> +	  DuplicateHandle (pcon_owner, get_ttyp ()->h_pcon_in,
> +			   GetCurrentProcess (), &h_pcon_in,
> +			   0, FALSE, DUPLICATE_SAME_ACCESS);
> +	  resume_pid =3D
> +	    attach_console_temporarily (get_ttyp()->nat_pipe_owner_pid);
> +	}
> +
>        DWORD n;
> +      while (bs_pos)
> +	{
> +	  if (bs_pos - buf > 0)
> +	    WriteFile (to_slave_nat, buf, bs_pos - buf, &n, NULL);
> +	  INPUT_RECORD r;
> +	  r.EventType =3D KEY_EVENT;
> +	  r.Event.KeyEvent.bKeyDown =3D 1;
> +	  r.Event.KeyEvent.wRepeatCount =3D 0;
> +	  r.Event.KeyEvent.wVirtualKeyCode =3D 0;
> +	  r.Event.KeyEvent.wVirtualScanCode =3D 0;
> +	  r.Event.KeyEvent.uChar.AsciiChar =3D '\010'; /* ^H */
> +	  r.Event.KeyEvent.dwControlKeyState =3D LEFT_CTRL_PRESSED;
> +	  WriteConsoleInput(h_pcon_in, &r, 1, &n);
> +	  r.Event.KeyEvent.bKeyDown =3D 0;
> +	  WriteConsoleInput(h_pcon_in, &r, 1, &n);
> +	  nlen -=3D bs_pos - buf + 1;
> +	  buf =3D bs_pos + 1;
> +	  bs_pos =3D (char *) memchr (buf, '\010' /* ^H */, nlen);
> +	}

This still has timing issues because the design is essentially assuming
that it is the only process using that Console, in a single-threaded
scenario. Such a scenario is increasingly rare nowadays.

Besides, OpenConsole.exe _still_ is open source, and therefore it is still
a better idea to fix the issue properly.

I had a go at it (assisted by Claude Opus 4.6):
https://github.com/dscho/terminal/commit/1b3d526428c86b9357275f11149d736f8=
928d64b

Here is a build including an artifact for that fix in case you still have
trouble building OpenConsole.exe locally:

  https://github.com/dscho/terminal/actions/runs/23135369360

Let's prefer a proper fix if at all possible.

Ciao,
Johannes

>        if (nlen)
>  	WriteFile (to_slave_nat, buf, nlen, &n, NULL);
> +
> +      if (resume_pid)
> +	resume_from_temporarily_attach (resume_pid);
> +      if (h_pcon_in)
> +	CloseHandle(h_pcon_in);
> +      if (pcon_owner)
> +	CloseHandle(pcon_owner);
>        ReleaseMutex (input_mutex);
> =20
>        return orig_len;
> --=20
> 2.51.0
>=20
>=20
