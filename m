Return-Path: <SRS0=aQVm=BR=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	by sourceware.org (Postfix) with ESMTPS id 1C8C84BBCDA7
	for <cygwin-patches@cygwin.com>; Tue, 17 Mar 2026 15:28:36 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 1C8C84BBCDA7
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 1C8C84BBCDA7
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.17.20
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1773761317; cv=none;
	b=cINS6COHc39AtTL/QG5Z1GqHZBXJU+MLvFZrzwYsBIuA3zcwHoP5vu1eTp1DMg1IUyMGP7hmMyhVgdUIO0h87xbpNDQiPAnoZoq5vqBBzzi5mskoCknO10fNKBtCp2d7s7+BHzocbUbmX/Cpo5l2Vxq0A74dCD/fRDByvBqQru4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1773761317; c=relaxed/simple;
	bh=LQLOQb+DGhWgJapMotctsbRs6IuyrvFMhX/cAYYsX7U=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=rvp6h4AaKAdl8tDZBQLbBQKKBfPYcqYqb4nn+f3CjSTZWKmHwB2O7KzTi8L+L7ZkL25NTiUi4mnGVHCU5UmOm+BCyfIe52dlXTVFfu9U4wtWHdtSh3RCSSvIediQ37uyw/dr8CTQolk9qf9sZwzgtq9yd5VJXO5z+omX1RmaGCc=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 1C8C84BBCDA7
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=V3Ik8dZA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1773761310; x=1774366110;
	i=johannes.schindelin@gmx.de;
	bh=ciR8TsKhMWTuqY6ftetPb4aeYoFPcFLKChcHCOzeAGo=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=V3Ik8dZA+Y4+vVK+3iuQjw8/sAkrtFXT9ROg1slI+pxntJZmmzAqv5YaDnQ/3P4o
	 GM41idBEaotSoXPGoIvlCFPBlrv11mae7q3SPJ055Ze2cLKhjzgKc9eBYt/A5VAUw
	 5i2vHr1VULGjTN8pL05YOOMqpLYM6eOMnEUtF4goTYvW7ji+3uK1NpBBDZ4JEBwOB
	 2S8yw+wn9yQYxft01DVHcCdSWOoIfCZgSmDZ/8FqZ5GLBW5IaUYyJ/lAbVN5wyhSK
	 NfkO0rWHpBginhVLOxHXi+G3gCAGc7h53TKwz72HkPiCATi4i0o5bDE+P8xBYx3fE
	 FsIle82/6imBdcnrxQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M9nxt-1vyvpw3hQr-00AOK3; Tue, 17
 Mar 2026 16:28:29 +0100
Date: Tue, 17 Mar 2026 16:28:28 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH 2/6] Cygwin: pty: Add workaround for handling of backspace
 when pcon enabled
In-Reply-To: <20260317122433.721-3-takashi.yano@nifty.ne.jp>
Message-ID: <2f8628d2-b79a-95a6-480d-7508375958d5@gmx.de>
References: <22f45be0-3a22-f9c6-6d91-a7c2484621ef@gmx.de> <20260317122433.721-1-takashi.yano@nifty.ne.jp> <20260317122433.721-3-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:yKkUVeUAukHYaqyOk1QeNPHo0F44Nz0UJde4kvaeTbBTVdil8zC
 K5E8Z8nQs/TdEqMCZahQ3j9ppcJaptXIiNah8XhgL93QvxR+atdsoLAJEWO2pybwa66f4tq
 AwBorMG79XypqATAp+txHLfNiodCamkoAnqVF6eF79qkccA8mo1dlME7UQVsXIj7+3TMe5M
 7QMzngQoLgesEaD9zbpiw==
UI-OutboundReport: notjunk:1;M01:P0:X5CsgUY9jsQ=;ThiMySkEo7/r2XjPFRk1aSPWw85
 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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Tue, 17 Mar 2026, Takashi Yano wrote:

> In Windows 11, pseudo console has a weird behaviour that the Ctrl-H
> is translated into Ctrl-Backspace (not Backspace). Similary, Backspace
> (0x7f) is translated into Ctrl-H. Due to this behaviour, inrec_eq()
> in cons_master_thread() fails to compare backspace/Ctrl-H events in
> the input record sequence. This patch is a workaround for that issue
> which pushes the Ctrl-H or Backspace as a ConsoleInput event instead
> of sending char code to pseudo console.

As I have pointed out already in
https://inbox.sourceware.org/cygwin-patches/724fc579-2984-9ec6-9c8e-69b334=
e966bb@gmx.de/
in response to essentially the same patch, the logic introduced in this
patch is simply too brittle to be considered a valid work-around.

In any case, there is no need to describe this vaguely as "a weird
behavior", not when I spent considerable time to find out, as a way to
allow us to say precisely what is going on and stop hand-waving about the
root cause. To save you one click, I'll replicate the actual bug fix from
https://github.com/dscho/terminal/commit/1b3d526428c86b9357275f11149d736f8=
928d64b
here:

=2D- snip --
=46rom 1b3d526428c86b9357275f11149d736f8928d64b Mon Sep 17 00:00:00 2001
From: Johannes Schindelin <johannes.schindelin@gmx.de>
Date: Mon, 16 Mar 2026 08:30:17 +0100
Subject: [PATCH] Fix 0x08 (Ctrl-H) being incorrectly decoded as Ctrl+Backs=
pace

The reverse VT input path in _DoControlCharacter mapped the byte 0x08
to a Ctrl+Backspace key event (VK_BACK with LEFT_CTRL_PRESSED and
character 0x7F). This was introduced in PR #3935 (Jan 2020) to make
Ctrl+Backspace delete whole words, which fixed issue #755. At that time,
the forward path (TerminalInput) also sent 0x08 for Ctrl+Backspace, so
the mapping was internally consistent, if a bit unusual.

In September 2022, PR #13894 rewrote the forward path to properly
implement DECBKM (Backarrow Key Mode). Under the default DECBKM
setting, TerminalInput now sends 0x08 for plain Backspace and 0x7F for
Ctrl+Backspace. The reverse path was never updated to match, breaking
the roundtrip: a Backspace keypress encodes to 0x08, which decodes back
as Ctrl+Backspace.

The Cygwin project is working on using OpenConsole.exe for its ConPTY
support, and a proposed patch series contains an ugly workaround for
this bug that bypasses the normal input pipe and injects raw
WriteConsoleInput events whenever 0x08 appears in the stream
(https://inbox.sourceware.org/cygwin-patches/20260312113923.1528-4-takashi=
.yano@nifty.ne.jp/).
Fixing the bug here avoids the need to accept that workaround.

The fix assigns VK_BACK directly and clears writeCtrl, following the
same pattern as the existing L'\x1b' case. This avoids the VkKeyScanW
roundtrip through _GenerateKeyFromChar, which was the root cause: it
reverse-mapped 0x7F to Ctrl+Backspace (since that is the keyboard
combination that produces 0x7F), and then writeCtrl added
LEFT_CTRL_PRESSED back after modifierState was zeroed.

Note that the 0x7F handler (line 221) has the inverse problem: it maps
0x7F to plain Backspace, but the forward path now uses 0x7F for
Ctrl+Backspace. That is a separate issue left for a follow-up.

Assisted-by: Claude Opus 4.6
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
 src/terminal/parser/InputStateMachineEngine.cpp | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/src/terminal/parser/InputStateMachineEngine.cpp b/src/termina=
l/parser/InputStateMachineEngine.cpp
index e0f663f3f..5fdf9ad1a 100644
=2D-- a/src/terminal/parser/InputStateMachineEngine.cpp
+++ b/src/terminal/parser/InputStateMachineEngine.cpp
@@ -177,10 +177,9 @@ bool InputStateMachineEngine::_DoControlCharacter(con=
st wchar_t wch, const bool
         switch (wch)
         {
         case L'\b':
-            // Process Ctrl+Bksp to delete whole words
-            actualChar =3D '\x7f';
-            success =3D _GenerateKeyFromChar(actualChar, vkey, modifierSt=
ate);
-            modifierState =3D 0;
+            vkey =3D VK_BACK;
+            writeCtrl =3D false;
+            success =3D true;
             break;
         case L'\r':
             writeCtrl =3D false;
=2D- snap --

Since `conhost.exe` is essentially "an LTS version of OpenConsole.exe" (my
wording, for the official word see
https://github.com/microsoft/terminal/discussions/12115#discussioncomment-=
1928563
which explains how `conhost.exe` is built from the same source code as
`OpenConsole.exe`), I can understand that you are now trying to use the
same work-around also for `conhost.exe`.

However, the design of opening the process that owns the console just so
that the Cygwin process can reopen the console handle with the same access
for the purpose of sending raw keyboard events interleaved with the
regular `WriteFile()` of the non-Backspace stuff to a _different_ handle
is so prone to fail that I really believe it better not to take this
patch. Its introduced logic assumes quite a bit about synchronization, for
example, expecting the keyboard events to arrive at the right time, after
the previous `WriteFile(to_slave_nat, ...)` managed to pipe regular
characters through to the console. These assumptions might happen to be
correct a lot of the time, but they _will_ be wrong too often, and as a
consequence the Pseudo Consol support would end up buggier than before
with this patch.

Besides, having two separate loops to handle ^H vs BS assumes that ^H and
BS inputs cannot arrive together, during the same
`fhandler_pty_master::write()` call, which I am fairly certain is
incorrect. With the current design, if there is a BS toward the beginning
of the input and ^H toward the end, the `while (bs_pos1)` loop will
happily write out the `0x7f` byte as part of the `WriteFile (to_slave_nat,
...)` call, excluding the ^H characters of course. And _then_ the `while
(bs_pos2)` loop will happily write all of the input buffer except for the
`0x7f` bytes (but crucially, now including the `0x08` bytes corresponding
to the ^H keystrokes) via the `WriteFile (to_slave_nat, ...)` call, i.e.
it will write most of the payload _again_.

This cannot be correct, and I am rather convinced that the idea behind the
patch (interleaving `WriteFile()` calls to the pipe with sending raw
keyboard events via `WriteConsoleInput()` to a _different_ handle) will
_never_ be robust enough.

Ciao,
Johannes

>=20
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Reviewed-by:
> ---
>  winsup/cygwin/fhandler/pty.cc | 64 +++++++++++++++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
>=20
> diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.=
cc
> index 371e67103..bde88ab0e 100644
> --- a/winsup/cygwin/fhandler/pty.cc
> +++ b/winsup/cygwin/fhandler/pty.cc
> @@ -2290,9 +2290,73 @@ fhandler_pty_master::write (const void *ptr, size=
_t len)
>  	    }
>  	}
> =20
> +      /* In Windows 11, pseudo console has a weird behaviour that
> +	 Ctrl-H is translated into Ctrl-Backspace (not Backspace).
> +	 Similary, backspace (0x7f) is translated into Ctrl-H. The
> +	 following code is a workaround for that issue. */
> +      char *bs_pos1 =3D (char *) memchr (buf, '\010' /* ^H */, nlen);
> +      char *bs_pos2 =3D (char *) memchr (buf, '\177' /* BS */, nlen);
> +      HANDLE h_pcon_in =3D get_ttyp ()->h_pcon_in;
> +      DWORD resume_pid =3D 0;
> +      if ((bs_pos1 || bs_pos2)
> +	  && !nat_pipe_owner_self (get_ttyp ()->nat_pipe_owner_pid))
> +	{
> +	  HANDLE pcon_owner =3D OpenProcess (PROCESS_DUP_HANDLE, FALSE,
> +					   get_ttyp ()->nat_pipe_owner_pid);
> +	  DuplicateHandle (pcon_owner, h_pcon_in,
> +			   GetCurrentProcess (), &h_pcon_in,
> +			   0, FALSE, DUPLICATE_SAME_ACCESS);
> +	  CloseHandle(pcon_owner);
> +	  resume_pid =3D
> +	    attach_console_temporarily (get_ttyp()->nat_pipe_owner_pid);
> +	}
> +
>        DWORD n;
> +      while (bs_pos1)
> +	{
> +	  if (bs_pos1 - buf > 0)
> +	    WriteFile (to_slave_nat, buf, bs_pos1 - buf, &n, NULL);
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
> +	  nlen -=3D bs_pos1 - buf + 1;
> +	  buf =3D bs_pos1 + 1;
> +	  bs_pos1 =3D (char *) memchr (buf, '\010' /* ^H */, nlen);
> +	}
> +      while (bs_pos2)
> +	{
> +	  if (bs_pos2 - buf > 0)
> +	    WriteFile (to_slave_nat, buf, bs_pos2 - buf, &n, NULL);
> +	  INPUT_RECORD r;
> +	  r.EventType =3D KEY_EVENT;
> +	  r.Event.KeyEvent.bKeyDown =3D 1;
> +	  r.Event.KeyEvent.wRepeatCount =3D 0;
> +	  r.Event.KeyEvent.wVirtualKeyCode =3D 0;
> +	  r.Event.KeyEvent.wVirtualScanCode =3D 0;
> +	  r.Event.KeyEvent.uChar.AsciiChar =3D '\177'; /* BS */
> +	  r.Event.KeyEvent.dwControlKeyState =3D 0;
> +	  WriteConsoleInput(h_pcon_in, &r, 1, &n);
> +	  r.Event.KeyEvent.bKeyDown =3D 0;
> +	  WriteConsoleInput(h_pcon_in, &r, 1, &n);
> +	  nlen -=3D bs_pos2 - buf + 1;
> +	  buf =3D bs_pos2 + 1;
> +	  bs_pos2 =3D (char *) memchr (buf, '\177' /* BS */, nlen);
> +	}
>        if (nlen)
>  	WriteFile (to_slave_nat, buf, nlen, &n, NULL);
> +
> +      if (resume_pid)
> +	resume_from_temporarily_attach (resume_pid);
> +      if (h_pcon_in)
> +	CloseHandle(h_pcon_in);
>        ReleaseMutex (input_mutex);
> =20
>        return orig_len;
> --=20
> 2.51.0
>=20
>=20
