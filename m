Return-Path: <SRS0=U2Tp=IH=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [IPv6:2001:268:fa04:731:6a:99:e2:25])
	by sourceware.org (Postfix) with ESMTPS id 0A0564BA2E14
	for <cygwin-patches@cygwin.com>; Sat, 17 Oct 2026 06:22:17 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 0A0564BA2E14
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 0A0564BA2E14
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2001:268:fa04:731:6a:99:e2:25
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1792218139; cv=none;
	b=AAWWfr+Fz1oLMgqWG6x5THtSwHWjJwOZn7aQqp9EkLOHDGBwM8dTYwvBs9U4wtdKVbG4GptR88DMygjgKp8ulDdRgXAe03Fv7fSVrN3fF0Y8Fqy5C9CyBZNyRgPdjC60gvtyBxN1AKLqAYtGTL38dDuO5zUbB2JUG8LPOPTFEug=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1792218139; c=relaxed/simple;
	bh=f2ADRsIZEdKOJzhVmfLpJSU7KZkPELLQQeDRP4XRWnE=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=Az2drX2jpTfuOQcCM7mkPj/kpQkzXFXANuw0ZCw762e+RU/t5okv8vMJKK9Nv+z2LLTTBQZ/HXxbDpDnlXRLE7ZR/8paP/GAgqSVLFvu9yBoEYYJCBJ/uv+U+r/srL6I/9aObJ3AJ+Cphj3NFL8bfsGwnn2gVNHb0EY2Onnknw8=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=ekWRhoXk
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 0A0564BA2E14
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=ekWRhoXk
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20261017062215248.BGVC.102121.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Sat, 17 Oct 2026 15:22:15 +0900
Date: Sat, 17 Oct 2026 15:22:13 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 0/5] Cygwin: pty: preserve terminal replies after PTY
 adoption
Message-Id: <20261017152213.9394289b21159f4c56815788@nifty.ne.jp>
In-Reply-To: <pull.10.v2.cygwin.1792050298.gitgitgadget@gmail.com>
References: <pull.10.cygwin.1789302605264.gitgitgadget@gmail.com>
	<pull.10.v2.cygwin.1792050298.gitgitgadget@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1792218135;
 bh=NtBL4jzzp4SDaHw6Nwwvleg+VBNDYAF3iLxRVSxE6cM=;
 h=Date:From:To:Subject:In-Reply-To;
 b=ekWRhoXkfjd6hp+ECz2mrDh76/SdFagLKhEN4E9o2nre2yHnxFvownuhih2C37CjEkJvS6kL
 ksQfVY/8FsdU7X4/duz1o157H9dFHYl7iOvTFzVHZrjj1qFfFj7m+xegoQbG+39H2DabVO1gwB
 xTjFoCiUnsgil3BmmRaumALeo90zeK+c7HBOM5VlD8hZe478OR4F+Dc9zwRQWBOjn3ZabeDqv5
 2Y+bWQj9+i6f2faBy3DNQryZTk/hms0xB/NqcoMIXyeHp6E8hfHu01S9dKITI96zPL/l1BDlJR
 XvB9bJjFJwV84T0Edtw+vVTr51amE7do07uWVyErut1SE+Ww==
X-Spam-Status: No, score=-11.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Johannes,

Thanks for the patch series.

On Thu, 15 Oct 2026 07:44:53 +0000
Johannes Schindelin wrote:
> MSYS Vim launched by native Git from Bash in MinTTY can delete the first
> line, enter Insert mode or insert RGB text at startup. The problem is
> incorrect PTY adoption, and the same problem applies to the Cygwin runtime
> (but is less common because native Windows programs are not mixed with
> Cygwin programs as ofte as with MSYS programs).
> 
> I merged v1 of this into Git for Windows v2.56.0, as it was somewhat
> pressing.
> 
> This patch is based on cygwin-3_6-branch, but is easily cherry-picked onto
> master, too.
> 
> Changes since v1:
> 
>  * Instead of changing input routing when the program changes terminal mode,
>    v2 changes it already when the foreground Cygwin program starts through
>    exec().
>  * Added a test case that gets run as part of Cygwin's test suite.
> 
> Johannes Schindelin (5):
>   Cygwin: pty: restore foreground input routing after exec
>   Cygwin: testsuite: allow cygrun without the testing namespace
>   Cygwin: testsuite: cover foreground PTY input recovery after exec
>   Cygwin: pty: recover input for children of native programs
>   Cygwin: testsuite: cover PTY input recovery with a native parent
> 
>  winsup/cygwin/fhandler/pty.cc                 |  51 +++--
>  winsup/cygwin/local_includes/fhandler.h       |   2 +
>  winsup/testsuite/.gitattributes               |   1 +
>  winsup/testsuite/Makefile.am                  |  27 +++
>  winsup/testsuite/cygrun.c                     |  12 +-
>  winsup/testsuite/cygrun.sh                    |   7 +-
>  winsup/testsuite/mingw/Makefile.am            |   5 +-
>  winsup/testsuite/mingw/pty-native-input.c     |  89 ++++++++
>  .../winsup.api/pty-background-native.c        | 197 ++++++++++++++++++
>  9 files changed, 374 insertions(+), 17 deletions(-)
>  create mode 100644 winsup/testsuite/.gitattributes
>  create mode 100644 winsup/testsuite/mingw/pty-native-input.c
>  create mode 100644 winsup/testsuite/winsup.api/pty-background-native.c
> 
> 
> base-commit: 867eb7748e6e5a0e8430ce9f46af27b4b1e8f204
> Published-As: https://github.com/cygwingitgadget/cygwin/releases/tag/pr-10%2Fdscho%2Ffix-vim-terminal-replies-v2
> Fetch-It-Via: git fetch https://github.com/cygwingitgadget/cygwin pr-10/dscho/fix-vim-terminal-replies-v2
> Pull-Request: https://github.com/cygwingitgadget/cygwin/pull/10
> 
> Range-diff vs v1:
> 
>  1:  a29a15748 < -:  --------- Cygwin: pty: preserve terminal replies after PTY adoption
>  -:  --------- > 1:  7f0615fc8 Cygwin: pty: restore foreground input routing after exec
>  -:  --------- > 2:  4f53a727d Cygwin: testsuite: allow cygrun without the testing namespace
>  -:  --------- > 3:  92d13761f Cygwin: testsuite: cover foreground PTY input recovery after exec
>  -:  --------- > 4:  f1a25a8e5 Cygwin: pty: recover input for children of native programs
>  -:  --------- > 5:  5bbc7634a Cygwin: testsuite: cover PTY input recovery with a native parent
> 
> -- 
> cygwingitgadget

Calling fixup_input_state_for_cygwin_app() seems a great idea!
Thanks!

Two things.
(1) This patch series cannot be applied git master cleanly.
(2) Typeahead input is broken without pseudo console enabled
    with this patch series.
      1. Run `env CYGWIN=disable_pcn script`
      2. Run `cmd`
      3. Run `sleep 10`
      4. Type ps<enter>ps<enter> while sleeping.
    The the second `ps` will not be executed in cmd.

Regarding (2), I think we have two options.

(a) Add an extra fix such as:
diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index 294bf8007..8f3b14327 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -1286,8 +1286,23 @@ fhandler_pty_slave::cleanup ()
   while (arch->num_reader)
     mask_switch_to_nat_pipe (false, false);
 
-  if (get_ttyp ()->pcon_activated && get_ttyp ()->getpgid () == myself->pgid)
-    req_fixup_pcon_state ();
+  if (get_ttyp ()->getpgid () == myself->pgid)
+    {
+      if (get_ttyp ()->pcon_activated)
+	req_fixup_pcon_state ();
+      else if (get_ttyp ()->switch_to_nat_pipe)
+	{
+	  WaitForSingleObject (input_mutex, mutex_timeout);
+	  if (get_ttyp ()->pty_input_state_eq (tty::to_cyg))
+	    {
+	      acquire_attach_mutex (mutex_timeout);
+	      transfer_input (tty::to_nat, get_handle (), get_ttyp (),
+			      input_available_event, input_transferred_to_cyg);
+	      release_attach_mutex ();
+	    }
+	  ReleaseMutex (input_mutex);
+	}
+    }
 
   /* This used to always call fhandler_pty_common::close when we were execing
      but that caused multiple closes of the handles associated with this pty.

(b) Call fixup_input_state_for_cygwin_app() only when pcon_activated
    in fixup_after_exi() and post_open_setup().

What do you think?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
