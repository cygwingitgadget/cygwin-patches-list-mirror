Return-Path: <SRS0=doSl=B3=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	by sourceware.org (Postfix) with ESMTPS id 060AD4BA2E12
	for <cygwin-patches@cygwin.com>; Fri, 27 Mar 2026 13:25:53 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 060AD4BA2E12
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 060AD4BA2E12
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.17.20
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1774617954; cv=none;
	b=tp9MewdlKsJ1V9gfeB0nY+lZ7jmwOFY2VnVDPuytLsaAZzKqqFTBjPZ6o61JuLScj/DDcdOG0a7MoMFH0HBVo2ItEA9WgS3o+1EYLyhH2hk2P1kT9T9ou9UKDpzq9ID7seEl/b7YxwMmOVMI2562u/pMv5Yr8BDyYQ2Zeu/iP9g=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1774617954; c=relaxed/simple;
	bh=9cd1CfZ9kzePduzl203gyzbIlKhwqIhE3ILqzx26sQo=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=a8yJNYFP0ZYMr/hWZYgScnWW678AXIgxbty+QFkD/zAOtigNJRuCEAikq1g88+6T3XVeQ8bamGTYa927ybCPCU5QFN1Un1m+jr9eRyMcem/e0KO0AsOxWv+2TBvxAVSuls761Gqo0/Z5YWvg9xnMD8oqLqoUaObxcd0D54AuuIw=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 060AD4BA2E12
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=HZdIdBsQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1774617952; x=1775222752;
	i=johannes.schindelin@gmx.de;
	bh=AQfZ2bNNQcJOeF5VekwRADmVvKFKRE3sUlEnwoBjQQE=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=HZdIdBsQONnTbCchZhSUXSs7dl1HHBEzO1/msCjIE2hkiKSTIPNE4H+pXiX56jew
	 ugwF8GxkeSxMPCat3UizOkp7R+y24VsOZcKUKe3u0/jDlfQZIa6W2wkEJqd1snkc3
	 dDlbGYManp19pun6J3lUDgLStDeUtqrXXHOamBHvpeAPNGtHeZxFKRuT+/CgE7cUH
	 o1/E8O7HRGH+m4nryZ4h2k/PY+TgbPFoLVyjo8YtadJ6OpAPzZEGreUsL0EEF5sKd
	 pxfTR3ACIbIgBTlZ0ETyI5dVJyxUmgLOEVE/gWDe0crgF6x7HVSAuu3MUfpYxqBRZ
	 kOFf7VkiZ11SQYeIQg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MEm6F-1wLIgF2Nat-006frp; Fri, 27
 Mar 2026 14:25:52 +0100
Date: Fri, 27 Mar 2026 14:25:50 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v7 2/7] Cygwin: pty: Add workaround for handling of
 backspace when pcon enabled
In-Reply-To: <20260325130453.62246-3-takashi.yano@nifty.ne.jp>
Message-ID: <4ef32266-f86b-0555-62a8-16df5e879a24@gmx.de>
References: <20260321113613.9443-1-takashi.yano@nifty.ne.jp> <20260325130453.62246-1-takashi.yano@nifty.ne.jp> <20260325130453.62246-3-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:TtEuWwt5UmZw+AEUX6uCxZfwTsPwqYWoPK6n1W7Qq7EWjSRXSzU
 Q0gIhvN/9QRZ3njnGp/lgHZsALmU/Lyg3pOJ0eBU2L8Ta4jIlnYOn816l6rqheOeA3BcSQA
 UNha/Cbt2KkwCW2hnJO1IoH0tmteIUvksZjuELh3SDTl9YNOaA+IfM5OfdfEA7tYIyaGL+L
 p/7o1x0zGqSc7PO1CReRA==
UI-OutboundReport: notjunk:1;M01:P0:XqvtZHc2Ip0=;rV8t91T+S9+ge5vz4aesoByONCC
 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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

First, I want to acknowledge that this version is a significant
improvement over the previous version that interleaved `WriteFile()` calls
to the pipe with `WriteConsoleInput()` calls to a different handle, which
was fundamentally racy. The v7 approach is much more robust: pre-convert
0x08 to 0x7F before writing to the pipe, knowing that conhost's buggy
reverse path will convert it back. This is a legitimate work-around.

That said, I have a few comments, starting with the commit message:

On Wed, 25 Mar 2026, Takashi Yano wrote:

> In Windows 11, pseudo console has a weird behaviour that the Ctrl-H
> is translated into Ctrl-Backspace (not Backspace). Similary, Backspace
> (0x7f) is translated into Ctrl-H.

As I pointed out in

  https://inbox.sourceware.org/cygwin-patches/2f8628d2-b79a-95a6-480d-7508=
375958d5@gmx.de/

(where I also included a proper fix for the upstream bug, to be submitted
pending testing), this should not be described vaguely as "a weird
behaviour". The root cause is well understood: the reverse VT input path
in conhost's `_DoControlCharacter()` maps the byte 0x08 to a
Ctrl+Backspace key event (VK_BACK with LEFT_CTRL_PRESSED and character
0x7F). This was introduced in PR #3935 (Jan 2020) to make Ctrl+Backspace
delete whole words. In September 2022, PR #13894 rewrote the forward path
to properly implement DECBKM (Backarrow Key Mode), but the reverse path
was never updated to match, breaking the roundtrip.

The commit message should say that, not "a weird behaviour".

> Due to this behaviour, inrec_eq() in cons_master_thread() fails to
> compare backspace/Ctrl-H events in the input record sequence. This patch
> is a workaround for the issue that replaces Ctrl-H with backspace
> (0x7f), which will be translated into Ctrl-H in pseudo console.
>=20
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> ---
>  winsup/cygwin/fhandler/console.cc | 12 ++++++-
>  winsup/cygwin/fhandler/pty.cc     | 57 ++++++++++++++++++++++++++-----
>  2 files changed, 60 insertions(+), 9 deletions(-)
>=20
> diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/=
console.cc
> index 2f59f8f24..9678775d1 100644
> --- a/winsup/cygwin/fhandler/console.cc
> +++ b/winsup/cygwin/fhandler/console.cc
> @@ -318,6 +318,16 @@ inrec_eq (const INPUT_RECORD *a, const INPUT_RECORD=
 *b, DWORD n)
>  	     written event. Therefore they are ignored. */
>  	  const KEY_EVENT_RECORD *ak =3D &a[i].Event.KeyEvent;
>  	  const KEY_EVENT_RECORD *bk =3D &b[i].Event.KeyEvent;
> +	  WCHAR c1 =3D ak->uChar.UnicodeChar;
> +	  WCHAR c2 =3D bk->uChar.UnicodeChar;
> +	  if (inside_pcon)
> +	    {
> +	      /* Workaround for pseudo console in Windows 11 */
> +	      if (c1 =3D=3D 8) /* Ctrl-H */
> +		c1 =3D 127; /* Backspace */
> +	      if (c2 =3D=3D 8) /* Ctrl-H */
> +		c2 =3D 127; /* Backspace */
> +	    }


This change in `inrec_eq()` makes sense as a companion to the
pre-conversion: `transfer_input()` reads back INPUT_RECORDs that went
through conhost's buggy reverse path, so the comparison needs to treat
0x08 and 0x7F as equivalent.

>  	  /* Fixup repeat count */
>  	  WORD r1 =3D ak->wRepeatCount;
>  	  WORD r2 =3D bk->wRepeatCount;
> @@ -326,7 +336,7 @@ inrec_eq (const INPUT_RECORD *a, const INPUT_RECORD =
*b, DWORD n)
>  	  if (r2 =3D=3D 0)
>  	    r2 =3D 1;
>  	  if (ak->bKeyDown !=3D bk->bKeyDown
> -	      || ak->uChar.UnicodeChar !=3D bk->uChar.UnicodeChar
> +	      || c1 !=3D c2
>  	      || r1 !=3D r2)
>  	    return false;
>  	}
> diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.=
cc
> index 371e67103..72a8ba140 100644
> --- a/winsup/cygwin/fhandler/pty.cc
> +++ b/winsup/cygwin/fhandler/pty.cc
> @@ -2266,28 +2266,65 @@ fhandler_pty_master::write (const void *ptr, siz=
e_t len)
>      { /* Reaches here when non-cygwin app is foreground and pseudo cons=
ole
>  	 is activated. */
>        tmp_pathbuf tp;
> -      char *buf =3D (char *) ptr;
> +      char *buf =3D tp.c_get ();
>        size_t nlen =3D len;
>        if (get_ttyp ()->term_code_page !=3D CP_UTF8)
>  	{
>  	  static mbstate_t mbp;
> -	  buf =3D tp.c_get ();
>  	  nlen =3D NT_MAX_PATH;
>  	  convert_mb_str (CP_UTF8, buf, &nlen,
>  			  get_ttyp ()->term_code_page, (const char *) ptr, len,
>  			  &mbp);
>  	}
> +      else
> +	memcpy (buf, ptr, nlen);
> +
> +      /* Retrieve console mode */
> +      HANDLE h_pcon_in =3D get_ttyp ()->h_pcon_in;
> +      DWORD cons_mode;
> +      if (!nat_pipe_owner_self (get_ttyp ()->nat_pipe_owner_pid))
> +	{
> +	  HANDLE pcon_owner =3D OpenProcess (PROCESS_DUP_HANDLE, FALSE,
> +					   get_ttyp ()->nat_pipe_owner_pid);
> +	  DuplicateHandle (pcon_owner, h_pcon_in,
> +			   GetCurrentProcess (), &h_pcon_in,
> +			   0, FALSE, DUPLICATE_SAME_ACCESS);
> +	  CloseHandle(pcon_owner);


Two issues here.

First, a correctness issue: there is no NULL check on the `OpenProcess()`
return value. If the owner process exited between reading
`nat_pipe_owner_pid` from shared memory and calling `OpenProcess()`, then
`pcon_owner` is NULL, `DuplicateHandle(NULL, ...)` will fail, `h_pcon_in`
will have an undefined value, and `GetConsoleMode()` below will read
garbage (or crash). This needs at minimum a NULL check on `pcon_owner`,
with a fallback path.

Second, a performance concern: this entire sequence (`OpenProcess()` +
`DuplicateHandle()` + `attach_console_temporarily()` + `GetConsoleMode()`
+ `resume_from_temporarily_attach()` + `CloseHandle()`) runs on _every_
call to master::write() in the fast path, even when no 0x08 byte is
present in the buffer. The console mode retrieval should either be moved
inside the conversion loop (only executed when a 0x08 byte is actually
encountered), or cached (although caching the value might run afoul of
time of check vs time of use ("TOCTOU") issues).

> +	  DWORD resume_pid =3D
> +	    attach_console_temporarily (get_ttyp()->nat_pipe_owner_pid);
> +	  GetConsoleMode (h_pcon_in, &cons_mode);
> +	  resume_from_temporarily_attach (resume_pid);
> +	  CloseHandle (h_pcon_in);
> +	}
> +      else
> +	GetConsoleMode (h_pcon_in, &cons_mode);
> =20
> -      for (size_t i =3D 0; i < nlen; i++)
> +      for (size_t i =3D 0, j =3D 0; i < nlen; i++)
>  	{
>  	  process_sig_state r =3D process_sigs (buf[i], get_ttyp (), this);
> -	  if (r =3D=3D done_with_debugger)
> +	  if (r !=3D done_with_debugger)
>  	    {
> -	      for (size_t j =3D i; j < nlen - 1; j++)
> -		buf[j] =3D buf[j + 1];
> -	      nlen--;
> -	      i--;
> +	      char c =3D buf[i];
> +	      if (!(cons_mode & ENABLE_VIRTUAL_TERMINAL_INPUT))
> +		/* Workaround for pseudo console in Windows 11 */
> +		/* Undesired backspace conversion in pseudo console does
> +		   not happen if ENABLE_VIRTUAL_TERMINAL_INPUT is set. */
> +		switch (c)
> +		  {
> +		  case '\010': /* Ctrl-H */
> +		    c =3D '\177'; /* Backspace */
> +		    break;
> +		  case '\177': /* Backspace */
> +#if 0 /* Unfortunately, Ctrl-H will be translated into Ctrl-Backspace
> +	 (not Backspace) */
> +		    c =3D '\010'; /* Ctrl-H */
> +#endif


The `#if 0` dead code should either be removed entirely or replaced with
a comment explaining _why_ the reverse mapping cannot work (and ideally
referencing the conhost bug, so a future reader knows when it might
become safe to revisit). Dead code guarded by `#if 0` without a tracking
reference is confusing for future readers (which might very well be me).

> +		    break;
> +		  }
> +	      buf[j++] =3D c;
>  	    }
> +	  else
> +	    nlen--;
>  	}
> =20
>        DWORD n;
> @@ -4031,6 +4068,10 @@ fhandler_pty_slave::transfer_input (tty::xfer_dir=
 dir, HANDLE from, tty *ttyp,
>  	    if (r[i].EventType =3D=3D KEY_EVENT && r[i].Event.KeyEvent.bKeyDow=
n)
>  	      {
>  		DWORD ctrl_key_state =3D r[i].Event.KeyEvent.dwControlKeyState;
> +		if (r[i].Event.KeyEvent.uChar.AsciiChar =3D=3D '\010' /* Ctrl-H */
> +		    && !(ctrl_key_state & ALT_PRESSED))
> +		  /* Workaround for pseudo console in Windows 11 */
> +		  r[i].Event.KeyEvent.uChar.AsciiChar =3D '\177'; /* Backspace */

This is the corresponding fix in `transfer_input()`: When reading
INPUT_RECORDs back from the console buffer in `transfer_input()`, they
have already been through conhost's buggy reverse path, so the 0x08 needs
to be mapped back to 0x7F here too. Consistent with the pre-conversion in
`master::write()`.

One open question that I already asked in

  https://inbox.sourceware.org/cygwin-patches/c4dc071d-fa7e-ed2e-0c14-3fdd=
b5240f1c@gmx.de/

but have not yet received an answer to: how was this bug originally
discovered/reproduced? I still do not know how to trigger the Backspace
problem in a regular Windows Terminal running on OpenConsole.exe, and I
need a concrete repro to test the upstream fix I prepared.

Thanks,
Johannes

>  		if (r[i].Event.KeyEvent.uChar.AsciiChar)
>  		  {
>  		    if ((ctrl_key_state & ALT_PRESSED)
> --=20
> 2.51.0
>=20
>=20
