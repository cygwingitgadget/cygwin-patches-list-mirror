Return-Path: <SRS0=dNIC=BG=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	by sourceware.org (Postfix) with ESMTPS id 20D324BA2E11
	for <cygwin-patches@cygwin.com>; Fri,  6 Mar 2026 07:46:49 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 20D324BA2E11
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 20D324BA2E11
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.15.15
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1772783209; cv=none;
	b=Hc+gI8tbgGdrzQApk83uWn+PwpoHU4qLAKWMbUn0Lu2Fya8+C5Lez5jSQu/eRvWTxQk9gUqWt9sqSu/9J9hRSo553bc/wVStwKnU7oeIcPuWTAenFOpJQ9BalWOyoK5H8BfMblMZob9Tn3dKERnPBX4AftZHlUbwF/BRsM8hgoE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1772783209; c=relaxed/simple;
	bh=Z+9oHVlJIIoJ/Z/HwWBUwy+Fs5sIt2S8rRcHqvGqpJw=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=aJw8V3F/wtY1Nbe1Quu1RXrAsf8MtKprBhUV/dUJwkpw4PzA57vVPiYk+Dfspc6u0i7vWkLSL+KXaSCoe1oJeQFQl5WdxHMYLgfpOhOu7Y/jIJCUBcwIYJBZ/D3uVUZu2VlGQ9p6fSc2/iJ9fuUGZ3dP17+h8epXy1NeDseCxq0=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 20D324BA2E11
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=iigKHEn8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1772783202; x=1773388002;
	i=johannes.schindelin@gmx.de;
	bh=UJaqMlEEf4gwl8vJDp69SNv39Qh6M2Xu1zkdo4NNzHs=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=iigKHEn82ol88vxOe1lhf8RkXA+P5V7Tfu+Anc9HsG7uImnOOhY+EkDVk7JZnwrc
	 NKmWNmGzlgKTgfke2M46ZtU8tmaGcAZq98e7DfMSyFr9PAIQU5uCL3HFJo+fh28YQ
	 HwFbS0I+K//SNqJ6ZWg0KmjaOTRhkN+bUqAW0TZuRBdbpyFlV+iLL8sDD+7HweAdZ
	 9AYE+MpbVBVFC7b0lUg4NwUdWvuIlFdv+DeN/giGil7zRqsUU3YAfiRF22TFnWOoB
	 QzZwM8RIfKAxtwRKtthOeWKoT3uMnXBVtAlYzPrv1MN+OEjuD5QFC/Mr7JGERT9nx
	 E5NUJC/VsaNZgBQtdA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MLQxN-1wFo9Z0Afj-00U5iP; Fri, 06
 Mar 2026 08:46:42 +0100
Date: Fri, 6 Mar 2026 08:46:40 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/4] Fix out-of-order keystrokes
In-Reply-To: <20260303212405.25a2db7d786ac2db324e8f7a@nifty.ne.jp>
Message-ID: <22f45be0-3a22-f9c6-6d91-a7c2484621ef@gmx.de>
References: <pull.6.cygwin.1772461480.gitgitgadget@gmail.com> <20260303212405.25a2db7d786ac2db324e8f7a@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:KALZYoooxAL3p2scpvG9WOS9AdBvLQpKMXhReqPtugcrRlX9MY2
 CfDGi3C+0CDwDQQ6DPH5IPoZr/3NSbG+QWEphL8T9zEtw4Kh2P2CCJJc23/edU5H+xPVmkE
 /6KpYwnGp0Y+qN5WGdr4QZJEE2+NAMVNkGh5/mxEf+MDttYzsNEBiCH1enKqZ+CcQJ2vurM
 +bqingrUFu9TS1zBJNiAQ==
UI-OutboundReport: notjunk:1;M01:P0:dP1+LiVQWgw=;PQsjiSvppHIqi4CXpwIsAzcH1pi
 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
 rEc76DrQHmJhv/H/eifNCChiptJxH
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,POISEN_SPAM_PILL,POISEN_SPAM_PILL_1,POISEN_SPAM_PILL_3,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>


Hi Takashi,

On Tue, 3 Mar 2026, Takashi Yano wrote:

> On Mon, 02 Mar 2026 14:24:36 +0000
> "Johannes Schindelin wrote:
> > A Git for Windows user reported that typing in a Bash session while a =
native
> > Windows program is running (or has just exited) can produce scrambled =
input
> > -- e.g. typing "git log" yields "igt olg":
> > https://github.com/git-for-windows/git/issues/5632
> >=20
> > I have been experiencing what I suspect is the same bug for a long tim=
e in
> > my tmux sessions: after quitting a pager and immediately pressing curs=
or-up
> > to recall the previous command, often followed by Escape+Backspace, th=
e Bash
> > session simply hangs. I suspect that the escape sequence bytes arrive =
out of
> > order, and hence the sequence does not parse, and the terminal hangs. =
Quite
> > frustrating, and it happens often enough to be a real productivity dra=
in.
> >=20
> > This bug report was therefore always on my mind, and gaining some good
> > experience with AI-assisted coding at work finally gave me the push to
> > investigate properly. I started by writing an AutoHotKey-based UI test=
 (Git
> > for Windows has a small suite of those; they are not included in this =
series
> > because they are specific to our fork). Getting a reliable reproducer
> > required quite a bit of back-and-forth as the bug is timing-sensitive =
and
> > only manifests when pseudo console transitions happen while keystrokes=
 are
> > in flight.
> >=20
> > The investigation itself was substantial. The total session spread ove=
r a
> > week. To be transparent about the methodology: I used AI (Claude Opus)=
 as an
> > investigative tool throughout this process. I dictated context and dir=
ection
> > via speech recognition, the AI searched the code, instrumented the cod=
e
> > liberally, and dug into the PTY internals. Every decision about what t=
o
> > investigate, what to fix and how was mine, the AI merely executed my p=
lans.
> > I typed very little (leaving typing to Parakeet's speech recognition a=
nd to
> > Claude Opus); the keystrokes are not mine, but the ideas are. For that
> > reason I use "Assisted-by" rather than "Co-authored-by" trailers in th=
e
> > commits.
> >=20
> > The root cause is what Opus labeled "pseudo console oscillation" (I ca=
lled
> > it "flickering" but agree that "oscillation" is a better term): each t=
ime a
> > native program starts or exits, pcon_activated and pty_input_state cha=
nge
> > rapidly, and several code paths in master::write() react by calling
> > transfer_input() to move data between the cyg and nat pipes. During
> > oscillation, these transfers steal readline's buffered data from the c=
yg
> > pipe, causing characters to arrive out of order.
> >=20
> > My suspicion is that the originally reported bug is fixed entirely by =
the
> > first patch (1/4). The remaining three address edge cases that the
> > reproducer exposed through its more aggressive oscillation pattern. Yo=
u
> > might say that I over-deliver a bit, but that seems like a good thing =
in
> > this instance.
> >=20
> > I tested both with and without MSYS=3Ddisable_pcon to verify that the
> > scenarios the removed code was originally intended to handle are still
> > covered by setpgid_aux(). This is even automated in Git for Windows' f=
ork
> > via the AutoHotKey-based tests; for full details see
> > https://github.com/git-for-windows/msys2-runtime/pull/124.
>=20
> [...]
>=20
> I tried to reproduce the issue, however I could not yet.
>=20
> Is the issue reproducible in pcon_activated case?
> Or disable_pcon case?
>=20
> If you can reproduce the issue in cygwin, could you kindly please
> let me know how to reproduce it?

It is admittedly difficult to reproduce. It took me a good 4 days to get
to a reliable reproducer. And I failed to do this in manual mode, I had to
employ the help of AutoHotKey to do it. The result can be seen here:
https://github.com/dscho/msys2-runtime/blob/fix-jumbled-character-order/ui=
-tests/keystroke-order.ahk

Unfortunately, it is not quite stand-alone, it requires `powershell.exe`
in the `PATH`, and
https://github.com/dscho/msys2-runtime/blob/fix-jumbled-character-order/ui=
-tests/ui-test-library.ahk
and
https://github.com/dscho/msys2-runtime/blob/fix-jumbled-character-order/ui=
-tests/cpu-stress.ps1
in the same directory. I just verified that it reproduces even with vanill=
a
Cygwin, using the latest AutoHotKey version from
https://github.com/AutoHotkey/AutoHotkey/releases/tag/v2.0.21. I ensured
that Cygwin's `bin` directory is first in the `PATH` and then ran, from a
PowerShell session:

  & "<path-to>\AutoHotkey64.exe" /force keystroke-order.ahk "$PWD\log.txt"

What this test does: It runs a small PowerShell script designed to add a
bit of CPU load and then spawns a Cygwin process (`sleep 1`). While these
are running, it then types _very_ rapidly four characters, then two
backspaces, then repeats that quite a few times ("ABXY" then deleting
"XY", then "CDXY", deleting "XY", etc). The number of characters was
chosen high enough that this reproducer basically reproduces the issue on
the first try. The "log.txt" file contains a detailed log including the
verdict. In my latest test, for example, it shows:

  Iteration 1 of 20
  MISMATCH in iteration 1!
  Expected: ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789
  Got:      ABCDEFGHIJKLMNOPQRXSTUVWXYZabcdefghijklmnopqrstuvwxyz012345678=
9

You will spot the "X" between "R" and "S", meaning that the backspace was
not able to remove the "X" because it was routed to the wrong pipe, or
after the "X" was already consumed.

> In addition, after applying these four patches, non-cygwin apps
> lose its input. Please try cmd.exe in pcon_activated mode.

When I tried this with the MSYS2 runtime, it simply worked. But when I
tried it in Cygwin, it reproduced! To be clear, this is the meaning I
extracted from the quoted text:

	Patch 2/4 "Cygwin: pty: Remove pcon_start readahead flush that
	displaces readline data" is too broad, it breaks the scenario when
	in an interactive Bash session in a MinTTY window (without
	`disable_pcon`), `cmd.exe` is launched interactively: You will see
	the typed characters, but `cmd.exe` won't receive them.

And this indeed reproduced here, but only with Cygwin. In MSYS2, it still
worked with the patches as-are. I will keep investigating, but in the
meantime I'd like to propose this fixup:

=2D- snip --
Subject: [PATCH] fixup! Cygwin: pty: Remove pcon_start readahead flush tha=
t
 displaces readline data

=2D--
 winsup/cygwin/fhandler/pty.cc | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index 693e1a8062..1a3c50721b 100644
=2D-- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -2216,6 +2216,11 @@ fhandler_pty_master::write (const void *ptr, size_t=
 len)
       if (!get_ttyp ()->pcon_start)
 	{ /* Pseudo console initialization has been done in above code. */
 	  pinfo pp (get_ttyp ()->pcon_start_pid);
+	  if (get_ttyp ()->switch_to_nat_pipe
+	      && get_ttyp ()->pty_input_state_eq (tty::to_cyg))
+	    {
+	      get_ttyp ()->pty_input_state =3D tty::to_nat;
+	    }
 	  get_ttyp ()->pcon_start_pid =3D 0;
 	}
=20
=2D- snap --

What do you think?

Ciao,
Johannes
