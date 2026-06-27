Return-Path: <SRS0=+gxg=EX=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	by sourceware.org (Postfix) with ESMTPS id 986024BA2E2B
	for <cygwin-patches@cygwin.com>; Sat, 27 Jun 2026 08:18:48 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 986024BA2E2B
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 986024BA2E2B
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=212.227.17.20
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1782548329; cv=none;
	b=cHyO4vGRDApsFWU+vWLPdIwSNmb3aStzBhM+rVjEF5qHlPiMBH/TakLzp4SBeZNufs5yvpzcu6wGkVoiu7qONOAuYAjbbVCocabzLnbGss5TLUehuIBQIo3QeTvev7E4GkDrL/2l8yNXrX2ctmZ3To2E0Rua2qf6qTyw2XA9QRk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1782548329; c=relaxed/simple;
	bh=JY3qkHwbnsU5Iy0KCQB+ZvtzZwTNhEx4w8h4+FqLKog=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=cP/Ulm+houE0uwD3u43MAg3LUlsn96PdCKftJ+zTMICXfc+CPpgEhHha3Et/z3MxFKSP9rYAU2YcI8f6fkKD+8LMXnZ2I4ngp4C3wpgOCo0FCQ5FvojgqyotADIeTL+bzGWCDN2+hAMKw/+UH/ddK4dzfgOuUR1AK+3hAzlS0S0=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=gxjF88Fp
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 986024BA2E2B
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=gxjF88Fp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1782548312; x=1783153112;
	i=johannes.schindelin@gmx.de;
	bh=Q7yqMCofg90WfuXA5VmQ7tixXebqxnG2fZzaJcCKg5M=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=gxjF88FpTwXHrJPc05JxHAiYg6Wz1Nxm4GLh1WP/UsdYN4PzFnoGVkgY3UrHXd2I
	 j1ISPGzVqqxqHyZTgFFesI5IxX8e42/9/urxXSIzHVjLjsHCZvdgIxV3ELwnHPQln
	 bxnE15HDMjM4iDajlmO0SJOuphIxOXPMkwxF791ZRMH+ri0/buGdYi7CBe6sJYgoI
	 8rtx2wg37y1TlTOh7Be/Hihpy+6tAlWkVRcttEf+MDFnIdv7Z55Xi2YCL2Ihb025B
	 Qi9Ahm/bi2ikXgRYzAhWRMTFZ4gOCrrHqiKXtdb9X0St005IwaYZO+yL8k40Ryn3f
	 kpXtPS9uB1VyduvrKw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M8QS8-1wZ0WW25Kq-005Tbe; Sat, 27
 Jun 2026 10:18:32 +0200
Date: Sat, 27 Jun 2026 10:18:27 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>, Mark Geisert <mark@maxrnd.com>
cc: cygwin-patches@cygwin.com, 
    Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Subject: Re: [PATCH] Cygwin: pty: detect pcon-backed pty for non-Cygwin-spawned
 children
In-Reply-To: <20260624221256.e474f94cc223fcb13ab7db61@nifty.ne.jp>
Message-ID: <2b226810-4032-9933-51cc-e4251d8c32a6@gmx.de>
References: <pull.7.cygwin.1777561444611.gitgitgadget@gmail.com> <20260624221256.e474f94cc223fcb13ab7db61@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:slpVQAW+SlTSPxQ6w7NnCiAYeo1gzcEC2vPHR72jhgwW/KN61Ae
 uJwgNouruYapDovEsDH9wckDSWETEZh5D3TJOgupoh//D1TsDuSbQfDedF+DK3nQVO/bPlK
 OrSwnqKWy1I1McASMw900oZww6ZkVYXSq6ZYAGNeBg9J/opRHDbt7k1aVadcqi6ASMcxirB
 XW7Ij90msaL1Csh69pXqw==
UI-OutboundReport: notjunk:1;M01:P0:BiN2peQp9+U=;hJhdkgkMIJJ6rUAASiJ0wO18ksQ
 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
 c6KYXjvFEwrvODsux/XNcRxJdoGkNA
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi & Mark,

On Wed, 24 Jun 2026, Takashi Yano wrote:

> On Thu, 30 Apr 2026 15:04:04 +0000
> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com> wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >=20
> > When a Cygwin process (e.g. `bash` under MinTTY) spawns a native
> > Win32 child (e.g. `git.exe`) with pseudo console support enabled,
> > the child gets a pseudo console that bridges the pty. If that native
> > child then spawns a Cygwin grandchild (e.g. `vim`, `less`), the
> > grandchild inherits the pseudo console's console handles. In
> > `init_std_file_from_handle()`, the grandchild's msys2-runtime sees
> > `GetConsoleScreenBufferInfo()` succeed on those handles and, with
> > no valid `ctty` set, falls back to `FH_CONSOLE` and gives the
> > process `cons0` instead of connecting to the pty.
> >=20
> [...]
>=20
> Pushed to master branch with my fixup patches.

I had a buffer-grow follow-up to this patch sitting in
https://github.com/git-for-windows/msys2-runtime/pull/131/commits/77e01abd=
83836b4b7488328ca899aea3a8e4ffbe
that I should have sent before you picked up the original and pushed it to
master; sorry for the delay.

=2D- snip --
=46rom 77e01abd83836b4b7488328ca899aea3a8e4ffbe Mon Sep 17 00:00:00 2001
From: Johannes Schindelin <johannes.schindelin@gmx.de>
Date: Fri, 29 May 2026 19:07:26 +0200
Subject: [PATCH] Cygwin: pty: grow GetConsoleProcessList buffer in
 find_pcon_pty()

find_pcon_pty() was passing a fixed 128-DWORD stack array to
GetConsoleProcessList(). If the calling Cygwin process happens to be
attached to a console with more than 128 processes, the Win32
function returns the required size and the buffer contents are
undefined; the existing if-zero check did not catch that case, so
the subsequent loop walked uninitialised data and could either miss
the candidate pty or, worse, match against junk PIDs and return the
wrong tty index.

Adopt the buffer-too-small dance from
fhandler_termios::get_console_process_id() in
winsup/cygwin/fhandler/termios.cc, which already had to solve this
problem and which also notes that the new condrv does not accept
oversized first-call buffers
(https://github.com/microsoft/terminal/issues/18264#issuecomment-251544854=
8).
The buffer comes from tmp_pathbuf so the same NT_MAX_PATH cap
(currently 1024 DWORDs, i.e. 4096 processes) applies; we bail out
with -1 if even that is not enough rather than allocate unbounded
memory or guess. Bumping the start-with size from 1 would defeat the
condrv work-around mentioned above, so we keep the same one-element
initial probe as termios.cc and let the loop grow.

Suggested-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Assisted-by: Opus 4.7
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
(cherry picked from commit b65e1544d45567f0033c57a0aa1543c5e654950a)
=2D--
 winsup/cygwin/tty.cc | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/winsup/cygwin/tty.cc b/winsup/cygwin/tty.cc
index 5cce05de34..9bc2a084fb 100644
=2D-- a/winsup/cygwin/tty.cc
+++ b/winsup/cygwin/tty.cc
@@ -19,6 +19,7 @@ details. */
 #include "cygheap.h"
 #include "pinfo.h"
 #include "shared_info.h"
+#include "tls_pbuf.h"
=20
 HANDLE NO_COPY tty_list::mutex =3D NULL;
=20
@@ -135,7 +136,9 @@ tty_list::init ()
 int
 tty_list::find_pcon_pty ()
 {
-  DWORD pids[128];
+  tmp_pathbuf tp;
+  DWORD *pids =3D (DWORD *) tp.c_get ();
+  const DWORD buf_size =3D NT_MAX_PATH / sizeof (DWORD);
   DWORD count =3D 0;
   bool got_pids =3D false;
=20
@@ -144,10 +147,20 @@ tty_list::find_pcon_pty ()
       if (!ttys[i].has_active_pcon ())
 	continue;
=20
-      /* Fetch the console process list lazily, only on first candidate. =
*/
+      /* Fetch the console process list lazily, only on first candidate.
+	 The buffer-too-large dance mirrors the one in termios.cc's
+	 get_console_process_id() and works around new condrv's dislike
+	 of oversized first-call buffers, see
+	 https://github.com/microsoft/terminal/issues/18264#issuecomment-2515448=
548 */
       if (!got_pids)
 	{
-	  count =3D GetConsoleProcessList (pids, 128);
+	  DWORD buf_size1 =3D 1;
+	  while ((count =3D GetConsoleProcessList (pids, buf_size1)) > buf_size1=
)
+	    {
+	      if (count > buf_size)
+		return -1;
+	      buf_size1 =3D count;
+	    }
 	  if (!count)
 	    return -1;
 	  got_pids =3D true;
=2D- snap --

Ciao,
Johannes

