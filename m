Return-Path: <SRS0=cL0F=JQ=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	by sourceware.org (Postfix) with ESMTPS id 6DFBF445B3A4
	for <cygwin-patches@cygwin.com>; Fri, 27 Nov 2026 15:36:11 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 6DFBF445B3A4
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 6DFBF445B3A4
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=212.227.15.15
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1795793771; cv=none;
	b=K0zOJPKx/5vVbUE7Y2tqaS25wF98pC5ISymZTI9h5rBXfSXwDdiJrF5s2O/w5GA9PDmKCotMeP8PHB6aNu2m1Jy6ilPPTDjlGQ0ZVuO3nwZUiVT6+dKYaToavkE2k0VMn6FcEFdMs6QN8I70sdYz0wu1zNT8fGFVmC46dyAP4ps=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1795793771; c=relaxed/simple;
	bh=onmP73w8C7aFpOVvspFJkVigmt8gf2wY/RULuzczmG8=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=Db1J57WbOgkie7hcBvP1GIiaDNuIjTly+6VmRKzjvnr/Wu8tvbzfNhDqRmZUhMt3NL1Yq1M3+foHxKmLfIDQQH2Eh7uqZmqD5qwHYag+VuFa0lXnVpNYATadzI7o9OnuZXhrpSSdKTCJl/j/tsRwtIR0ADwxbvu92gHVxYT0kwY=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=OJHBWNls
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 6DFBF445B3A4
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=OJHBWNls
DKIM2-Signature:  i=1; m=1; t=1795793770;
 mf=PEpvaGFubmVzLlNjaGluZGVsaW5AZ214LmRlPg==;
 rt=PGN5Z3dpbi1wYXRjaGVzQGN5Z3dpbi5jb20+;
 d=gmx.de;
 s=s31663417:rsa-sha256:g/1ES3MdAvEHsfAs1wAFi/J0lV6Z
   SkogCrEops8D4YOIgq/Bz6sCt+Gx5Reoch3d2hHFjRWrfsz3jM+h84LhSPkz26CYhKvRIlKpUTN
   meb9oesvOLvKMBPa1+wQOwlTBZnj1Y9kIFB+spknQXMw0GNNAVsj201RS/LYJBt68BBaSJXBHZD
   3Zy1+W6UVh/Z28Bb1ueORplESP8Z2cr7fAOvQ4W16yYzuiAo+o+MFl4Le3KlTj9p4iSh8WZi9TO
   CHRoCvfwAQjPbRdXrgwxbVxaP6fYbjf0BKJR+gaeF3RDMKPfgeYnokSF71ZMdxApDVQjaT/oSY1
   aHreknayr1OzuQ==;
Message-Instance:  m=1;
 h=sha256:
   oZ7QfQvHGGVTlEy3OqVzjMV8GQpkhJOkmy2PzIp26kg=:
   onmP73w8C7aFpOVvspFJkVigmt8gf2wY/RULuzczmG8=,
  sha512:
   OgdMfacnnh8VeWQihIXuwiL+l4Ttg2Mu8Ze0fpCbN9EMAQPEsq4jZzOH1lTUd3vzbh28LsNmhKSKEsr2cHDdOA==:
   Y3Ul5oe0MIKqv6idSoGzIBEXQTYkgZaG7ZGOhJqVTWmShfp19HCsZzcHRaK2J/rzdVOSfQlqgUYdGqRuRhSm6w==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1795793770; x=1796398570;
	i=johannes.schindelin@gmx.de;
	bh=E+RHrMWIXtLyrmi98iCu4ZAasGWLcw94nZgIydPyGgI=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=OJHBWNlsi11GJ2cgJbjTwV9z9hO2KEh4Q/w86jOC9MIGZN1d01eKvkKfFSl6btgJ
	 D3MjY0Ax5FTCDqw3mMPSFrWNCUSC58ySA1Ne/30iylZehPCeU8T6mlHrEoGEkOegZ
	 o1cAmTeO5E1kIv76rrc2JYAKe+b00GNrt33dFF88QRc0AS8uE1saDEJmmiL2BzJdb
	 sJIYa2Q8vcQIOb8epRwGBCv94FLJn9gMBKbdp3GwhkESqWAJmI5POaS8U+KhRLHFw
	 UOUkIU6DAa9pxoZVQWa5yWFkJMui49AZWT5xLVITJMIANCD3y+ClkJcQ4AODUIQgs
	 kZwH+l/2xkDDE2p1KQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MVNAr-1xym6g3ylj-00MFzQ; Fri, 27
 Nov 2026 16:36:10 +0100
Date: Fri, 27 Nov 2026 16:36:08 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v5 2/2] Cygwin: pty: Handle win32 input mode rather than
 omitting it
In-Reply-To: <20261104013007.112-1-takashi.yano@nifty.ne.jp>
Message-ID: <54be6113-28ee-6059-b6a8-bb33be521cad@gmx.de>
References: <20261104013007.112-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:Ks1EcHgsGsn73w5IWKm5378fZzwOs635xDC3whtBvqDX7EBJyf1
 RPu6BIRdSY4wyWNApYslJ8kS012MW0ypw64jZMW8kc4rlExOj4AT4Saa6VQvYq+Cyyqfz5h
 OrPjipLvkwfNW+KfQXFDHJV7jWGQGgZ92k8ibDfVVlT+48I//iplkjw50kUh9ypU8/mISY+
 TFDxnpd+L9Fnq0kc7VBfg==
UI-OutboundReport: notjunk:1;M01:P0:cdY8RjZsJJg=;/FkmHt9liYjiGfhWPYXHZESZeJ6
 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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Wed, 4 Nov 2026, Takashi Yano wrote:

> Currently, win32 input mode request from pseudo console is omitted
> to avoid incorrect Ctrl-C handling. This patch makes pty handle win32
> input mode properly instead of removing that sequence (SCI?9001h/l)
> from the output of the pseudo console.
>=20
> Fixes: b7541ef1242a ("Cygwin: pty: Omit win32-input-mode sequence from p=
seudo console")
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Reviewed-by:
> ---
> v2: Remove SCI?9001h/l if the foreground process is cygwin process.
> v3: Toggle win32 input mode based on pty_input_state in transfer_input()=
.
> v4: Add missing initialization for win32input_mode.
> v5: Disable win32 input mode before calling transfer_input() in
>     cleanup_for_non_cygwin_app().
>     Check if the terminal has win32-input-mode and remember the result.

Sorry, I ran out of time to give this a proper review. So I will just give
you a couple of comments that are mainly coming from my AI assisted
investigation (read: I did not really manage to wrap my head around the
entire patch, so those findings might actually be wrong, from the brief
time I had to look over this rather large patch, though, I think that
there is something to them):

- Temporary handoffs can deliver encoded packets as text. With encoded
  mode active, a Cygwin reader's `mask_switch_to_nat_pipe()` or a
  foreground change through `setpgid_aux()` can call
  `transfer_input(to_cyg)`. That drains ConHost, commits Cygwin routing,
  then requests mode disable without acknowledgement. An already-generated
  packet can wait behind `input_mutex` and arrive afterward.
  `master::write()` decodes only on the native route, so `line_edit()`
  receives packet syntax. Earlier draining cannot recover it; v5's
  cleanup-only barrier misses these callers.

- Concurrent launchers can corrupt setup. Unlike before this patch,
  `term_has_pcon_cap()` now runs before acquiring `pipe_sw_mutex`. Two
  launchers sharing the PTY can enter unchecked and consume the same
  native-pipe responses. Furthermore, `pcon_cap_checked` becomes true
  before Win32 negotiation finishes. Another launcher's
  `setup_pseudoconsole()` can mistake the probe's temporary
  `pcon_activated` for an existing ConHost, before the probe resets
  routing/activation. Per-read input locking does not reserve the whole
  negotiation.

- Mixed input is reordered inside one write. Ordinary bytes wait in the
  compacted buffer while complete encoded packets are written immediately.
  `P` followed by encoded `q` becomes `qP`. Holding the input lock cannot
  repair ordering broken within that locked operation.

- Negotiation destroys typeahead. The new probe drains input into a
  private buffer, locates a report using the last escape, and never
  replays unrelated bytes. A preceding key is irretrievably consumed; a
  following packet can hide the report from `strrchr()`.

- Partial packets cross PTY boundaries. `w32i_buf` and its index are
  function-static. Sequential calls on A then B can flush A's partial
  packet into B's pipe. Per-PTY mutexes cannot isolate shared state;
  closing a PTY does not reset it.

- Encoded signal handling loses existing semantics. For encoded events,
  `process_sigs()` is called only for C/key-down/exact modifier 8,
  requiring six explicit integers. With `ISIG` and a foreground Cygwin
  member not reading the PTY, configured `VQUIT` and remapped `VINTR`
  therefore miss dispatch. Native handling cannot substitute. Right
  Control, NumLock combinations and protocol-permitted omitted defaults
  also defeat the special Ctrl+C match.

My sincerest apologies for this not quite finished review; I wish I had
more resources available for Cygwin! I just hope that this list is better
than no review at all...

Ciao,
Johannes

>=20
>  winsup/cygwin/fhandler/pty.cc      | 178 ++++++++++++++++++++++++++---
>  winsup/cygwin/local_includes/tty.h |   3 +
>  winsup/cygwin/tty.cc               |   2 +
>  3 files changed, 169 insertions(+), 14 deletions(-)
>=20
> diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.=
cc
> index 39525bd08..bd450f0d5 100644
> --- a/winsup/cygwin/fhandler/pty.cc
> +++ b/winsup/cygwin/fhandler/pty.cc
> @@ -2734,6 +2734,71 @@ fhandler_pty_master::write (const void *ptr, size=
_t len)
>        len =3D nlen;
>        for (size_t i =3D 0, j =3D 0; i < len; i++)
>  	{
> +	  const int max_w32i_len =3D 64;
> +	  static char w32i_buf[max_w32i_len];
> +	  static int w32i_idx;
> +	  if (get_ttyp ()->win32input_mode && (buf[i] =3D=3D '\033' || w32i_id=
x))
> +	    {
> +	      DWORD n;
> +	      char c =3D buf[i];
> +	      nlen--;
> +	      /* Workaround for pseudo console in Windows 11 */
> +	      if (!(cons_mode & ENABLE_VIRTUAL_TERMINAL_INPUT))
> +		/* Undesired backspace conversion in pseudo console does
> +		   not happen if ENABLE_VIRTUAL_TERMINAL_INPUT is set. */
> +		if (c =3D=3D '\010') /* Ctrl-H */
> +		  c =3D '\177';  /* Backspace */
> +	      if (c =3D=3D '\003')
> +		{
> +		  WriteFile (to_slave_nat, w32i_buf, w32i_idx, &n, NULL);
> +		  w32i_idx =3D 0;
> +		  /* Ctrl-C should be written separately */
> +		  process_sigs ('\003', get_ttyp (), this);
> +		  WriteFile (to_slave_nat, "\003", 1, &n, NULL);
> +		  continue;
> +		}
> +	      if (c =3D=3D '\033')
> +		{
> +		  if (w32i_idx)
> +		    WriteFile (to_slave_nat, w32i_buf, w32i_idx, &n, NULL);
> +		  w32i_idx =3D 0;
> +		}
> +	      w32i_buf[w32i_idx++] =3D c;
> +	      w32i_buf[w32i_idx] =3D '\0';
> +	      bool do_flush =3D false;
> +	      if (c =3D=3D '_')
> +		{
> +		  int a1, a2, a3, a4, a5, a6;
> +		  if (sscanf (w32i_buf, "\033[%d;%d;%d;%d;%d;%d_",
> +			      &a1, &a2, &a3, &a4, &a5, &a6) =3D=3D 6
> +		      && a1 =3D=3D 0x43 && a4 =3D=3D 1 && a5 =3D=3D 8) /* Ctrl-C */
> +		    process_sigs ('\003', get_ttyp (), this);
> +		  do_flush =3D true;
> +		}
> +	      else if (c =3D=3D 'R' && get_ttyp ()->eow32i)
> +		{
> +		  int x, y;
> +		  if (sscanf (w32i_buf, "\033[%d;%dR", &y, &x) =3D=3D 2)
> +		    {
> +		      get_ttyp ()->eow32i =3D false;
> +		      w32i_idx =3D 0;
> +		    }
> +		}
> +	      else if (isalpha (c))
> +		do_flush =3D true;
> +	      if (do_flush || w32i_idx =3D=3D max_w32i_len - 1)
> +		{
> +		  WriteFile (to_slave_nat, w32i_buf, w32i_idx, &n, NULL);
> +		  w32i_idx =3D 0;
> +		}
> +	      continue;
> +	    }
> +	  if (w32i_idx)
> +	    {
> +	      DWORD n;
> +	      WriteFile (to_slave_nat, w32i_buf, w32i_idx, &n, NULL);
> +	      w32i_idx =3D 0;
> +	    }
>  	  process_sig_state r =3D process_sigs (buf[i], get_ttyp (), this);
>  	  if (r !=3D done_with_debugger &&
>  	      (r !=3D signalled || (ti.c_lflag & NOFLSH) || buf[i] =3D=3D '\00=
3'))
> @@ -3238,8 +3304,7 @@ fhandler_pty_master::workarounds_for_pseudo_consol=
e_output (char *outbuf,
>  	      }
>  	    state =3D 0;
>  	  }
> -	else if (saw_question_mark
> -		 && (arg =3D=3D 9001 || arg =3D=3D 1004)
> +	else if (saw_question_mark && arg =3D=3D 1004
>  		 && (outbuf[i] =3D=3D 'h' || outbuf[i] =3D=3D 'l'))
>  	  {
>  	    memmove (&outbuf[start_at], &outbuf[i+1], rlen-i-1);
> @@ -3247,6 +3312,18 @@ fhandler_pty_master::workarounds_for_pseudo_conso=
le_output (char *outbuf,
>  	    i =3D start_at - 1;
>  	    state =3D 0;
>  	  }
> +	else if (saw_question_mark && ttyp->has_win32input_mode
> +		 && arg =3D=3D 9001 && (outbuf[i] =3D=3D 'h' || outbuf[i] =3D=3D 'l')=
)
> +	  {
> +	    ttyp->win32input_mode =3D (outbuf[i] =3D=3D 'h');
> +	    if (ttyp->pty_input_state =3D=3D tty::to_cyg && outbuf[i] =3D=3D '=
h')
> +	      {
> +		memmove (&outbuf[start_at], &outbuf[i+1], rlen-i-1);
> +		rlen =3D start_at + rlen - i - 1;
> +		i =3D start_at - 1;
> +	      }
> +	    state =3D 0;
> +	  }
>  	else if (outbuf[i] =3D=3D '\033')
>  	  {
>  	    start_at =3D i;
> @@ -4328,6 +4405,49 @@ fhandler_pty_slave::term_has_pcon_cap (const WCHA=
R *env)
>    get_ttyp ()->has_csi6n =3D true;
>    get_ttyp ()->pcon_cap_checked =3D true;
> =20
> +  /* Check for win32 input mode */
> +  WaitForSingleObject (input_mutex, mutex_timeout);
> +  get_ttyp ()->pcon_activated =3D true;
> +  get_ttyp ()->pty_input_state =3D tty::to_nat;
> +  WriteFile (get_output_handle (), "\033[?9001h", 8, &n, NULL);
> +  WriteFile (get_output_handle (), "\033[?9001$p", 9, &n, NULL);
> +  ReleaseMutex (input_mutex);
> +  p =3D buf;
> +  len =3D sizeof (buf) - 1;
> +  wait_cnt =3D 0;
> +  do
> +    {
> +      if (::bytes_available (n, get_handle_nat ()) && n)
> +	{
> +	  ReadFile (get_handle_nat (), p, len, &n, NULL);
> +	  p +=3D n;
> +	  len -=3D n;
> +	  *p =3D '\0';
> +	  char *p1 =3D strrchr (buf, '\033');
> +	  int a1, a2;
> +	  char c, d;
> +	  if (p1 =3D=3D NULL
> +	      || sscanf (p1, "\033[?%d;%d%c%c", &a1, &a2, &c, &d) !=3D 4
> +	      || a1 !=3D 9001 || c !=3D '$' || d !=3D 'y')
> +	    continue;
> +	  get_ttyp ()->has_win32input_mode =3D (a2 =3D=3D 1);
> +	  break;
> +	}
> +      else if (++wait_cnt > 100) /* Timeout */
> +	{
> +	  get_ttyp ()->has_win32input_mode =3D false;
> +	  break;
> +	}
> +      else
> +	Sleep (1);
> +    }
> +  while (len);
> +  WaitForSingleObject (input_mutex, mutex_timeout);
> +  get_ttyp ()->pty_input_state =3D tty::to_cyg;
> +  get_ttyp ()->pcon_activated =3D false;
> +  WriteFile (get_output_handle (), "\033[?9001l", 8, &n, NULL);
> +  ReleaseMutex (input_mutex);
> +
>    return true;
> =20
>  not_has_csi6n:
> @@ -4410,7 +4530,7 @@ fhandler_pty_slave::transfer_input (tty::xfer_dir =
dir, HANDLE from, tty *ttyp,
>  	return;
>      }
> =20
> -  HANDLE to;
> +  HANDLE to, to_master =3D NULL;
>    if (dir =3D=3D tty::to_nat)
>      to =3D ttyp->to_slave_nat ();
>    else
> @@ -4418,8 +4538,11 @@ fhandler_pty_slave::transfer_input (tty::xfer_dir=
 dir, HANDLE from, tty *ttyp,
> =20
>    pinfo p (ttyp->master_pid);
>    if (p)
> -    to =3D get_handle_from_process (p->dwProcessId, to, true);
> -  if (to =3D=3D NULL)
> +    {
> +      to =3D get_handle_from_process (p->dwProcessId, to);
> +      to_master =3D get_handle_from_process (p->dwProcessId, ttyp->to_m=
aster ());
> +    }
> +  if (to =3D=3D NULL || to_master =3D=3D NULL)
>      {
>        char pipe[MAX_PATH];
>        __small_sprintf (pipe,
> @@ -4434,7 +4557,6 @@ fhandler_pty_slave::transfer_input (tty::xfer_dir =
dir, HANDLE from, tty *ttyp,
>        CloseHandle (repl.from_master_nat); /* not used. */
>        CloseHandle (repl.from_master); /* not used. */
>        CloseHandle (repl.to_master_nat); /* not used. */
> -      CloseHandle (repl.to_master); /* not used. */
>        if (dir =3D=3D tty::to_nat)
>  	{
>  	  CloseHandle (repl.to_slave); /* not used. */
> @@ -4445,6 +4567,7 @@ fhandler_pty_slave::transfer_input (tty::xfer_dir =
dir, HANDLE from, tty *ttyp,
>  	  CloseHandle (repl.to_slave_nat); /* not used. */
>  	  to =3D repl.to_slave;
>  	}
> +      to_master =3D repl.to_master;
>      }
> =20
>    UINT cp_from =3D 0, cp_to =3D 0;
> @@ -4606,6 +4729,13 @@ fhandler_pty_slave::transfer_input (tty::xfer_dir=
 dir, HANDLE from, tty *ttyp,
>        while (IsEventSignalled (input_transferred_to_cyg))
>  	yield ();
>      }
> +  if (ttyp->win32input_mode)
> +    {
> +      const char *str =3D dir =3D=3D tty::to_nat ? "\033[?9001h" : "\03=
3[?9001l";
> +      DWORD n;
> +      WriteFile (to_master, str, strlen (str), &n, NULL);
> +    }
> +  CloseHandle (to_master);
>    ttyp->discard_input =3D false;
>  }
> =20
> @@ -4656,9 +4786,9 @@ fhandler_pty_slave::setup_for_non_cygwin_app (bool=
 nopcon,
>  					      const WCHAR *envblock,
>  					      bool stdin_is_ptys)
>  {
> -  WaitForSingleObject (pipe_sw_mutex, INFINITE);
>    if (disable_pcon || !term_has_pcon_cap (envblock))
>      nopcon =3D true;
> +  WaitForSingleObject (pipe_sw_mutex, INFINITE);
>    /* Setting switch_to_nat_pipe is necessary even if pseudo console
>       will not be activated. */
>    fhandler_base *fh =3D ::cygheap->fdtab[0];
> @@ -4702,14 +4832,33 @@ fhandler_pty_slave::cleanup_for_non_cygwin_app (=
handle_set_t *p, tty *ttyp,
>    if (nat_pipe_owner_self (ttyp->nat_pipe_owner_pid))
>      {
>        DWORD switch_to =3D get_winpid_to_hand_over (ttyp, force_switch_t=
o);
> -      if ((!switch_to && (ttyp->pcon_activated || stdin_is_ptys))
> -	  && ttyp->pty_input_state_eq (tty::to_nat))
> +      if ((!switch_to && (ttyp->pcon_activated || stdin_is_ptys)))
>  	{
> -	  acquire_attach_mutex (mutex_timeout);
> -	  transfer_input (tty::to_cyg, p->from_master_nat, ttyp,
> -			  p->input_available_event,
> -			  p->input_transferred_to_cyg);
> -	  release_attach_mutex ();
> +	  if (ttyp->win32input_mode && ttyp->pty_input_state_eq (tty::to_nat))
> +	    {
> +	      DWORD n;
> +	      pinfo pp (ttyp->master_pid);
> +	      HANDLE to_master =3D get_handle_from_process (pp->dwProcessId,
> +							  ttyp->to_master ());
> +	      WriteFile(to_master, "\033[?9001l", 8, &n, NULL);
> +	      ttyp->eow32i =3D true;
> +	      WriteFile(to_master, "\033[6n", 4, &n, NULL);
> +	      CloseHandle (to_master);
> +	      DWORD t0 =3D GetTickCount ();
> +	      ReleaseMutex (p->input_mutex);
> +	      while (ttyp->eow32i && GetTickCount () - t0 < 100)
> +		Sleep (1);
> +	      WaitForSingleObject (p->input_mutex, mutex_timeout);
> +	      ttyp->win32input_mode =3D false;
> +	    }
> +	  if (ttyp->pty_input_state_eq (tty::to_nat))
> +	    {
> +	      acquire_attach_mutex (mutex_timeout);
> +	      transfer_input (tty::to_cyg, p->from_master_nat, ttyp,
> +			      p->input_available_event,
> +			      p->input_transferred_to_cyg);
> +	      release_attach_mutex ();
> +	    }
>  	}
>      }
>    ReleaseMutex (p->input_mutex);
> diff --git a/winsup/cygwin/local_includes/tty.h b/winsup/cygwin/local_in=
cludes/tty.h
> index c5102eb81..765db71ee 100644
> --- a/winsup/cygwin/local_includes/tty.h
> +++ b/winsup/cygwin/local_includes/tty.h
> @@ -146,6 +146,9 @@ private:
>    bool discard_input;
>    bool stop_fwd_thread;
>    bool req_fixup_pcon_cur_pos;
> +  bool has_win32input_mode;
> +  bool win32input_mode;
> +  volatile bool eow32i;
> =20
>  public:
>    HANDLE from_master_nat () const { return _from_master_nat; }
> diff --git a/winsup/cygwin/tty.cc b/winsup/cygwin/tty.cc
> index ba65aca3d..dd84ca2b7 100644
> --- a/winsup/cygwin/tty.cc
> +++ b/winsup/cygwin/tty.cc
> @@ -306,6 +306,9 @@ tty::init ()
>    last_sig =3D 0;
>    discard_input =3D false;
>    stop_fwd_thread =3D false;
> +  has_win32input_mode =3D false;
> +  win32input_mode =3D false;
> +  eow32i =3D false;
>  }
> =20
>  HANDLE
> --=20
> 2.51.0
>=20
>=20
