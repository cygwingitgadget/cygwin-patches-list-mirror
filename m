Return-Path: <SRS0=IhUf=BQ=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	by sourceware.org (Postfix) with ESMTPS id 974054BB5881
	for <cygwin-patches@cygwin.com>; Mon, 16 Mar 2026 15:40:11 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 974054BB5881
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 974054BB5881
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.17.20
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1773675612; cv=none;
	b=fK0t71mjyOKY7rMYXsOfgtDQCS83ho0Zue8j5U/zTBox9AeGnbpcq7ukFQXwc8sFqMotqvBb79lYQX6xuJ3tIByY7zuqBHK1q7NuBYCq3u7WdWnPMIOGWNbGB7XOGjf5J2wNEok6AEkaBE4euqvrFZP/iOH9ZjeMet12LiGIF6g=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1773675612; c=relaxed/simple;
	bh=ikIKEhXRWyy3JulU3A3mHAF2lw8AQIjIgKIepDkDrfc=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=uWCa9YgWb8MIzLaOt002Gi97Tc/G3xvrVQPW6WtM6B/Aqh1DVwPI23yG72lL/1bExeunHxvZxyRT9xa/6sOKlxZ3sUvrs4WgjauhvbI4IbnE3UzDQ+0TNr33Es9CHKExYfhdO++kIQs+a81X7bktw2wagMGJm8YwdRnDHaGkC7A=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 974054BB5881
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=sNcrtke0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1773675604; x=1774280404;
	i=johannes.schindelin@gmx.de;
	bh=KWxaLzJXaRN6NTQ+FQdkQ0BQmyGPBNk7OywPPfnTSRw=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=sNcrtke0qcNncY91t/ihp8c510IEQtHTA+kxpDSgEiNJPMg5TR9kAhvy6FodOP2s
	 SCuoHmfd+AsnKvjzlDBXin5KffGqe8ACl0tD54DKXWR1wUDDC1JqUaDF/3kJdCU27
	 Yfvv6C8VU3RpYcO0kKyg8R3J7yCgh9avY0ptCU9uYfs/V8wUdtJ9YmNqXnoRxaCrR
	 f6b+oJOePq09H26LoNaBC2YNyrZX1R58qRcf48BtQ89T7lBR+w3wfSa5WDG9MTCUe
	 H34ZT5KboAeiK0m1aeKmmtBdyPx3XNrXqcEmPYbwMmdjJlgu4rgURffB5vyt3JKER
	 9oKcwIJ7BCaZqDIFPg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MCsUC-1vtKMN39ns-004bnj; Mon, 16
 Mar 2026 16:40:03 +0100
Date: Mon, 16 Mar 2026 16:40:01 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v5 2/3] Cygwin: pty: Update workaround for rlwrap for
 pseudo console
In-Reply-To: <20260312113923.1528-3-takashi.yano@nifty.ne.jp>
Message-ID: <8d775de9-2a03-1e0d-67fc-5c62bb05007d@gmx.de>
References: <20260312113923.1528-1-takashi.yano@nifty.ne.jp> <20260312113923.1528-3-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:1FXYrP+mcp9VHjLf82ASpHcWRNfz/oLhemkI/q6KYzGtH2xGybt
 gWHbILPSP59ZeXVzqhSByUhbX20hZHHpIbv6g+5AvOMNXRcfe4W/Rzr7J/3oq4VrDl5rTBm
 TVXpAubDp52Pt7BUe1iAdc8OsSb3ervHLlkql37DspQfCFKrAHdkNFApmfJArjyYbeooVGZ
 HEvUSKY50gWFx3Slp0jtw==
UI-OutboundReport: notjunk:1;M01:P0:H10gesjesJE=;DEC36Uj5A7RBWGmwisH6A5gfjBC
 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
 x6JhJdr208i
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Thu, 12 Mar 2026, Takashi Yano wrote:

> In tcgetattr(), the conventional workaround for rlwrap v0.40 or later
> is not work as expected with OpenConsole.exe for some reason. This
> patch update the workaround so that it works even with OpenConsole.exe
> by rebuilding tcgetattr responce reffering the corrent console mode
> instead of just overriding it depends on pseudo console setting up
> state. The patch also handle tcsetattr() so that the change is applied
> to the console mode.

Calling `attach_console_temporarily()` in every `tcgetattr`/`tcsetattr`
call might incur a prohibitively large performance penalty: This involves
`FreeConsole()` + `AttachConsole()` + `FreeConsole()` + `AttachConsole()`.
That's four kernel calls plus the mutex. `tcgetattr` can be called
frequently (rlwrap polls it). This is expensive and introduces latency in
a path that was previously just a memory read.

>=20
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Reviewed-by:
> ---
>  winsup/cygwin/fhandler/pty.cc | 148 ++++++++++++++++++++++++++++++----
>  1 file changed, 131 insertions(+), 17 deletions(-)
>=20
> diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.=
cc
> index 85d29f1cc..bd5c24625 100644
> --- a/winsup/cygwin/fhandler/pty.cc
> +++ b/winsup/cygwin/fhandler/pty.cc
> @@ -1764,18 +1764,37 @@ fhandler_pty_slave::tcgetattr (struct termios *t=
)
>  {
>    *t =3D get_ttyp ()->ti;
> =20
> -  /* Workaround for rlwrap */
> -  cygheap_fdenum cfd (false);
> -  while (cfd.next () >=3D 0)
> -    if (cfd->get_major () =3D=3D DEV_PTYM_MAJOR
> -	&& cfd->get_minor () =3D=3D get_minor ())
> -      {
> -	if (get_ttyp ()->pcon_start)
> -	  t->c_lflag &=3D ~(ICANON | ECHO);
> -	if (get_ttyp ()->pcon_activated)
> -	  t->c_iflag &=3D ~ICRNL;
> -	break;
> -      }

Hmm.  The code now no longer checks whether the master fd is open: The old
code iterated cygheap_fdenum to verify the caller actually has the master
side open. The new code skips this check entirely. The commit message
doesn't mention this behavioral change.

> +  /* Conventional workaround for rlwrap v0.40 or later is not work
> +     as expected with OpenConsole.exe for some reason. The following

I'll never be a fan of reading "for some reason" in a patch that changes
behavior in a fundamental way. If such changes (which typically come with
a high risk of unintended side effects) are made, I'd rather want to have
a really good reason for that. In this instance, I have concerns that the
underlying problem might not be understood well enough, and hence the
chosen approach might need to be improved to fully address the bug.

Could you please describe the full picture here?

> +     workaround is perhaps better solution even for apps other than
> +     rlwrap under pcon_activated mode. */
> +  if (get_ttyp ()->pcon_activated
> +      && (to_be_read_from_nat_pipe ()
> +	  || get_ttyp ()->pcon_start || get_ttyp ()->pcon_start_csi_c))
> +    {
> +      DWORD mode =3D ENABLE_LINE_INPUT | ENABLE_ECHO_INPUT;
> +      t->c_lflag &=3D ~(ICANON | ECHO);
> +      t->c_iflag &=3D ~ICRNL;

Hmm. What if the application specifically set ICRNL? This unconditional
clearing=20

> +      HANDLE pcon_owner =3D OpenProcess (PROCESS_DUP_HANDLE, FALSE,
> +				       get_ttyp ()->nat_pipe_owner_pid);

This call could fail.

> +      HANDLE h_pcon_in;
> +      DuplicateHandle (pcon_owner, get_ttyp ()->h_pcon_in,
> +		       GetCurrentProcess (), &h_pcon_in,
> +		       0, FALSE, DUPLICATE_SAME_ACCESS);

if this `DuplicateHandle()` call fails, `h_pcon_in` is uninitialized, yet
it is happily used in the `GetConsoleMode()` call below.

And since this is a near-duplicate of the other `tcgetattr()` method and
both `tcsetattr()` methods touched by this patch, this problem is
multiplied by 4.

> +      DWORD resume_pid =3D
> +	attach_console_temporarily (get_ttyp()->nat_pipe_owner_pid);
> +      if (!GetConsoleMode (h_pcon_in, &mode)
> +	  && (get_ttyp ()->pcon_start || get_ttyp ()->pcon_start_csi_c))
> +	mode =3D 0;
> +      resume_from_temporarily_attach (resume_pid);
> +      CloseHandle (h_pcon_in);
> +      CloseHandle (pcon_owner);
> +
> +      if (mode & ENABLE_LINE_INPUT)
> +	t->c_lflag |=3D ICANON;
> +      if (mode & ENABLE_ECHO_INPUT)
> +	t->c_lflag |=3D ECHO;
> +    }
>    return 0;
>  }
> =20
> @@ -1784,6 +1803,40 @@ fhandler_pty_slave::tcsetattr (int, const struct =
termios *t)
>  {
>    acquire_output_mutex (mutex_timeout);
>    get_ttyp ()->ti =3D *t;
> +
> +  if (get_ttyp ()->pcon_activated
> +      && (to_be_read_from_nat_pipe ()
> +	  || get_ttyp ()->pcon_start || get_ttyp ()->pcon_start_csi_c))
> +    {
> +      DWORD mode;
> +      HANDLE pcon_owner =3D OpenProcess (PROCESS_DUP_HANDLE, FALSE,
> +				       get_ttyp ()->nat_pipe_owner_pid);
> +      HANDLE h_pcon_in;
> +      DuplicateHandle (pcon_owner, get_ttyp ()->h_pcon_in,
> +		       GetCurrentProcess (), &h_pcon_in,
> +		       0, FALSE, DUPLICATE_SAME_ACCESS);
> +      DWORD resume_pid =3D
> +	attach_console_temporarily (get_ttyp()->nat_pipe_owner_pid);
> +      if (!GetConsoleMode (h_pcon_in, &mode)
> +	  && (get_ttyp ()->pcon_start || get_ttyp ()->pcon_start_csi_c))
> +	mode =3D 0;
> +
> +      mode &=3D ~(ENABLE_LINE_INPUT | ENABLE_ECHO_INPUT
> +		| ENABLE_PROCESSED_INPUT);
> +      if (t->c_lflag & ICANON)
> +	mode |=3D ENABLE_LINE_INPUT;
> +      if (t->c_lflag & ECHO)
> +	mode |=3D ENABLE_ECHO_INPUT;
> +      if (t->c_lflag & ISIG)
> +	mode |=3D ENABLE_PROCESSED_INPUT;
> +      SetConsoleMode (h_pcon_in, mode);

Wouldn't this potentially wreak havoc with native Win32 apps that are
attached to this Console? They typically do not handle it well when their
Console changes under their feet.

> +
> +      resume_from_temporarily_attach (resume_pid);
> +      CloseHandle (h_pcon_in);
> +      CloseHandle (pcon_owner);
> +
> +      get_ttyp ()->ti.c_iflag |=3D ICRNL;
> +    }

This code seems to be a near duplicate of the master side, same goes for
the `tcgetattr()` methods. This is not only hard to review, in my
experience it _will_ lead to maintenance nightmares.

Couldn't this be refactored to not only be much easier to maintain and
reduce redundant code dramatically, but at the same time also improve
readability and the ease of review in a quite meaningful way? I mean, the
`c_lflag` handling is _already_ duplicated across
`fhandler_pty_slave::setup_pseudoconsole()` and
`fhandler_console::set_input_mode()`... I'd rather see this copy/edit
pattern reduced than increased.

Ciao,
Johannes

>    release_output_mutex ();
>    return 0;
>  }
> @@ -2508,11 +2561,38 @@ int
>  fhandler_pty_master::tcgetattr (struct termios *t)
>  {
>    *t =3D cygwin_shared->tty[get_minor ()]->ti;
> -  /* Workaround for rlwrap v0.40 or later */
> -  if (get_ttyp ()->pcon_start)
> -    t->c_lflag &=3D ~(ICANON | ECHO);
> -  if (get_ttyp ()->pcon_activated)
> -    t->c_iflag &=3D ~ICRNL;
> +
> +  /* Conventional workaround for rlwrap v0.40 or later is not work
> +     as expected with OpenConsole.exe for some reason. The following
> +     workaround is perhaps better solution even for apps other than
> +     rlwrap under pcon_activated mode. */
> +  if (get_ttyp ()->pcon_activated
> +      && (to_be_read_from_nat_pipe ()
> +	  || get_ttyp ()->pcon_start || get_ttyp ()->pcon_start_csi_c))
> +    {
> +      t->c_lflag &=3D ~(ICANON | ECHO);
> +      t->c_iflag &=3D ~ICRNL;
> +
> +      HANDLE pcon_owner =3D OpenProcess (PROCESS_DUP_HANDLE, FALSE,
> +				       get_ttyp ()->nat_pipe_owner_pid);
> +      HANDLE h_pcon_in;
> +      DuplicateHandle (pcon_owner, get_ttyp ()->h_pcon_in,
> +		       GetCurrentProcess (), &h_pcon_in,
> +		       0, FALSE, DUPLICATE_SAME_ACCESS);
> +      DWORD resume_pid =3D
> +	attach_console_temporarily (get_ttyp()->nat_pipe_owner_pid);
> +      DWORD mode =3D ENABLE_LINE_INPUT | ENABLE_ECHO_INPUT;
> +      if (!GetConsoleMode (h_pcon_in, &mode)
> +	  && (get_ttyp ()->pcon_start || get_ttyp ()->pcon_start_csi_c))
> +	mode =3D 0;
> +      resume_from_temporarily_attach (resume_pid);
> +      CloseHandle (h_pcon_in);
> +      CloseHandle (pcon_owner);
> +      if (mode & ENABLE_LINE_INPUT)
> +	t->c_lflag |=3D ICANON;
> +      if (mode & ENABLE_ECHO_INPUT)
> +	t->c_lflag |=3D ECHO;
> +    }
>    return 0;
>  }
> =20
> @@ -2520,6 +2600,40 @@ int
>  fhandler_pty_master::tcsetattr (int, const struct termios *t)
>  {
>    cygwin_shared->tty[get_minor ()]->ti =3D *t;
> +
> +  if (get_ttyp ()->pcon_activated
> +      && (to_be_read_from_nat_pipe ()
> +	  || get_ttyp ()->pcon_start || get_ttyp ()->pcon_start_csi_c))
> +    {
> +      HANDLE pcon_owner =3D OpenProcess (PROCESS_DUP_HANDLE, FALSE,
> +				       get_ttyp ()->nat_pipe_owner_pid);
> +      HANDLE h_pcon_in;
> +      DuplicateHandle (pcon_owner, get_ttyp ()->h_pcon_in,
> +		       GetCurrentProcess (), &h_pcon_in,
> +		       0, FALSE, DUPLICATE_SAME_ACCESS);
> +      DWORD resume_pid =3D
> +	attach_console_temporarily (get_ttyp()->nat_pipe_owner_pid);
> +      DWORD mode;
> +      if (!GetConsoleMode (h_pcon_in, &mode)
> +	  && (get_ttyp ()->pcon_start || get_ttyp ()->pcon_start_csi_c))
> +	mode =3D 0;
> +
> +      mode &=3D ~(ENABLE_LINE_INPUT | ENABLE_ECHO_INPUT
> +		| ENABLE_PROCESSED_INPUT);
> +      if (t->c_lflag & ICANON)
> +	mode |=3D ENABLE_LINE_INPUT;
> +      if (t->c_lflag & ECHO)
> +	mode |=3D ENABLE_ECHO_INPUT;
> +      if (t->c_lflag & ISIG)
> +	mode |=3D ENABLE_PROCESSED_INPUT;
> +      SetConsoleMode (h_pcon_in, mode);
> +
> +      resume_from_temporarily_attach (resume_pid);
> +      CloseHandle (h_pcon_in);
> +      CloseHandle (pcon_owner);
> +
> +      cygwin_shared->tty[get_minor ()]->ti.c_iflag |=3D ICRNL;
> +    }
>    return 0;
>  }
> =20
> --=20
> 2.51.0
>=20
>=20
