Return-Path: <SRS0=T3ZE=BC=gmail.com=gitgitgadget@sourceware.org>
Received: from mail-dy1-x1329.google.com (mail-dy1-x1329.google.com [IPv6:2607:f8b0:4864:20::1329])
	by sourceware.org (Postfix) with ESMTPS id D882D4BA2E18
	for <cygwin-patches@cygwin.com>; Mon,  2 Mar 2026 14:24:45 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D882D4BA2E18
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D882D4BA2E18
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::1329
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1772461486; cv=none;
	b=XozVtv1T46YNeodrfyQhLq5IiZPtpi0nAzZMyXNxBsEHZTMo6DxjHbLkHjJ1IWiAYGw5dp+PP/GE3pwUs8IXN69W+Rd/zzw35HL5kAVXYf05Hxu9OQ0IhlgSPJ23r6ihhjYzkLk4RO/rNTVt5O5PTtDeKqEEl+VYJJ0aOQX4uyI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1772461486; c=relaxed/simple;
	bh=dRJVFFxxAXiiL2aVdWp57EcWLnCPfklbNjYf5mtGi6o=;
	h=DKIM-Signature:Message-Id:From:Date:Subject:MIME-Version:To; b=mXEaZJd4sX2ZH59PXSF3ArpkMLQS1j4qGRAoaxTF+D4bQV4U3KpQcSIfbWiawlW80L0drpaaceSMiRAKqMBvB7QzF996yXrwBODsz1yAjdHTWNLQz7hoOTKthlsuRLGbNp5EXmmslTtW9stPrHCGokmRhmXAifxXdQrTzPcMxxY=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D882D4BA2E18
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=J71ExS0L
Received: by mail-dy1-x1329.google.com with SMTP id 5a478bee46e88-2bdfd129c52so1417411eec.0
        for <cygwin-patches@cygwin.com>; Mon, 02 Mar 2026 06:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772461484; x=1773066284; darn=cygwin.com;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SBeMbscLJp9wa2IgztZ8qwAxakSAYBU7szwUxcMT+fc=;
        b=J71ExS0Lx57hXnpuXmhijL1lghi42mTtSygNJDxP46ZssLi1vxP7WCbFp7CqtJPXUn
         ludxBF1SEIfqu2n6CaVHPymtb50iSORkHivXvLtNkbAtmaXtNenUDqL4kbvj3HMVxP1U
         mCtVP2Rc4LIu4em+TJffyoQXN/lrcoUe73adM1EFVVJD2aau/3xF5aAieRbTZ94cgxrq
         IpwLh8HFAndEzLGOZD9wBi58NB++dkaWUphkDhcp2qXcB5X7CNMW46YEMTdEUG4LCO3u
         7oRB2Y9vrmESqYUfi1fzMRBdwLgEeAodrjViwv6VKA7jg+fseM4BgwJDdJKHD+Js1dK6
         UO2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772461484; x=1773066284;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SBeMbscLJp9wa2IgztZ8qwAxakSAYBU7szwUxcMT+fc=;
        b=ICMuMKhY/tR8za1GSYPPZ/+letfGtJnPQab03WdM2477cgt0DJYxs/+dq7qyq16ahZ
         08fW8L58BigGEPDomf/z84TFlRDzC8QbCOtgLa9LL/5s0WP45FZPl0gde6RyQc5zpkM/
         RMCv7wecGwCGuZ9HVVEZMw49A6a22EqE0wVEJqrYkuQWeYqTt9tkubO5StSwawNAi1cG
         zOIDExju3zRheLbMfnITJEZt2xNxeNczb8b1uKPenat/PB2mxx4qwEr2swuwkwBtdkU9
         My+uk9pgjw1wZDC2g7JYC8h0n4BL6/zN+2RG57E4K9W4DYU/F9AsndZ0g62guvsuBN52
         AbCw==
X-Gm-Message-State: AOJu0Yzchc82SeRcnn9xv+1dbGjoD2SvJyRIY1BFF8jLa6f7Oio/7Jnt
	pfT9Zm+H5uAIVTGZffYQentvCQVF87+D01zrI+oWmB8kzmyTBuG+QChr2PmGa2Au
X-Gm-Gg: ATEYQzwNZMMAbLQG1i9eoyg1Al+o4NXtiXpEb/r1jo7uUIe+S87qjXyaUul/lUofZLV
	ZjdVfbHkOnyUBYhb1wAmAgwS1iFgcGwV0OYIKSsdRIgfmpL+IF6Rc4SNB9+Ar+8g5ARDTEoV7Ku
	9z2YiqOWsCIXHFfghULtWUB/aYspB9iiM8ZolbZdCyci3qXcd63T437USRmCClgCHN+sOLxSKvE
	+QrNeTlriIAM0iJbpZkezgN48hdGzFNtTfVa+HcQkQ2sAAR6R5S4in4jGp6dauy3eYrSx4skUiN
	vqDKNXQZHYCv+bNRYzNq4xMY7FtaTuzYzJ5ECLZPaH+zs2OYuvSUqzO8uwdstR34EJf/UZsuAbd
	YC+4gJAC44WfwcxQHrfTk3Cs0MSBza51d1WLHg1nNAmR0/gGgdmnHgFMzSc8ZretfRxauO3NHON
	kJX/gT4F00+E4iTdg6z+GtH5BBzw==
X-Received: by 2002:a05:693c:2c8b:b0:2ba:9cfb:2744 with SMTP id 5a478bee46e88-2bde1ebd56cmr4819203eec.30.1772461484125;
        Mon, 02 Mar 2026 06:24:44 -0800 (PST)
Received: from [127.0.0.1] ([52.159.245.148])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bdfb3f898asm5614065eec.29.2026.03.02.06.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 06:24:43 -0800 (PST)
Message-Id: <c7b8058842d8228a4480236f36d8de11d50c5715.1772461480.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.6.cygwin.1772461480.gitgitgadget@gmail.com>
References: <pull.6.cygwin.1772461480.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 02 Mar 2026 14:24:37 +0000
Subject: [PATCH 1/4] Cygwin: pty: Fix jumbled keystrokes by removing the
 per-keystroke pipe transfer
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,KAM_ASCII_DIVIDERS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When rapidly typing at a Cygwin terminal while a native Windows
program runs and exits (e.g. typing while a short-lived git command
prints output in a mintty terminal), keystrokes can arrive at bash in
the wrong order: typing "git log" may display "igt olg" or similar
scrambled output.

Background: the pseudo console's two-pipe architecture
------------------------------------------------------

The Cygwin PTY maintains two independent pairs of input pipes:

  "cyg" pipe (to_slave / from_master):
    For Cygwin processes.  The master calls line_edit(), which
    implements POSIX line discipline (handling backspace, Ctrl-C,
    canonical-mode buffering, echo), then accept_input() writes
    the processed bytes to this pipe.  The Cygwin slave (e.g.
    bash) reads from the other end.

  "nat" pipe (to_slave_nat / from_master_nat):
    For native Windows console programs.  When the "pseudo console"
    (abbreviated "pcon" in the code) is active, Windows' conhost.exe
    wraps this pipe and provides the Win32 Console API
    (ReadConsoleInput, etc.) to the native app.  The master writes
    raw bytes directly to this pipe.

Both pipes are needed because Cygwin processes and native Windows
programs have incompatible expectations.  Cygwin processes read
POSIX byte streams after line discipline processing.  Native
programs call ReadConsoleInput() for structured key-down/key-up
events -- something a plain pipe cannot provide.

A shared-memory variable `pty_input_state` (values: to_cyg or
to_nat) tracks which pipe currently receives new input.  The
function transfer_input() moves pending data between the two pipes
when the state changes.  The flag `pcon_activated` indicates whether
a Windows pseudo console is currently running.

The problem: oscillation
------------------------

Each time a native program starts or exits in a PTY, the pseudo
console activates or deactivates.  Even a single such transition --
running git.exe and then returning to the bash prompt -- can trigger
the bug.  The effect is amplified when transitions happen in quick
succession (e.g. a shell script calling several short-lived native
commands), creating many oscillation cycles:

  (1) native program starts:     pcon_activated=true, state=to_nat
  (2) native program exits:      pcon deactivated,    state=to_cyg
  (3) next native program:       pcon reactivated,    state=to_nat

Git for Windows' AutoHotKey-based UI tests create this pattern
deliberately by having PowerShell invoke Cygwin utilities in a tight
loop to achieve near-100% reproduction.

During each transition, master::write() -- which routes every
keystroke from the terminal emulator -- must decide which pipe to
use.

How the transfer steals readline's data
---------------------------------------

In master::write(), after the pcon+nat fast code path and before
calling line_edit(), there was a code block that runs when:

  to_be_read_from_nat_pipe() is true    (a native app is "in charge")
  && pcon_activated is false            (pcon momentarily OFF)
  && pty_input_state is to_cyg          (input going to cyg pipe)

When all three conditions hold, it calls transfer_input(to_nat) to
move ALL pending data from the cyg pipe to the nat pipe.  The intent
was to handle a specific scenario where, with pseudo console
disabled, input lingered in the wrong pipe after a Cygwin child
exited.

The problem is that during oscillation step (2), these conditions
are also true -- and the cyg pipe contains bash's readline buffer
with the partially-typed command line.  On every keystroke during
the gap, this code reads ALL of readline's buffered input out of the
cyg pipe and pushes it into the nat pipe:

  Keystroke 'g' arrives during oscillation gap (step 2):
       |
       v
  transfer_input(to_nat)         <--- reads readline's prior "it"
       |                              from cyg pipe, writes to nat
       v
  line_edit('g')
       |
       v
  accept_input() ---> nat pipe   <--- 'g' also goes to nat pipe
       |
       v
  pcon reactivates (step 3):
       |
       v
  readline reads cyg pipe, but "it" is gone -- it was moved
  to the nat pipe.  Later keystrokes that went correctly to
  the cyg pipe appear before the stolen ones.

  Result: "git" arrives at bash as "tgi" or similar scramble.

The fix
-------

Remove the transfer_input() call entirely.  The original commit's
comment says it was needed "when cygwin-app which is started from
non-cygwin app is terminated if pseudo console is disabled."  That
scenario is already handled by setpgid_aux() in the slave process,
which performs the transfer at the correct moment: the process-group
change when the Cygwin child exits.  The per-keystroke transfer in
master::write() was redundant for that use case and catastrophic
during oscillation.

This single change addresses the majority of the reordering (from
"virtually every character scrambled" to roughly one stray character
per five iterations in testing).  Subsequent commits in this series
address the remaining code paths that can still displace readline
data during oscillation.

Regression note: the removed code was added in response to a
ghost-typing report where vim's ANSI escape responses appeared at
the bash prompt after exiting vim with MSYS=disable_pcon:
https://inbox.sourceware.org/cygwin-patches/nycvar.QRO.7.76.6.2112092345060.90@tvgsbejvaqbjf.bet/
Since setpgid_aux() still handles the pipe transfer at process-group
boundaries, the disable_pcon scenario is covered.  Tested with
MSYS=disable_pcon and Git for Windows' AutoHotKey-based UI tests
without regressions.

Addresses: https://github.com/git-for-windows/git/issues/5632
Fixes: acc44e09d1d0 ("Cygwin: pty: Add missing input transfer when switch_to_pcon_in state.")
Assisted-by: Claude Opus 4.6
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 winsup/cygwin/fhandler/pty.cc | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index 90f58671c..f7db43b9d 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -2250,17 +2250,6 @@ fhandler_pty_master::write (const void *ptr, size_t len)
      or cygwin process is foreground even though pseudo console is
      activated. */
 
-  /* This input transfer is needed when cygwin-app which is started from
-     non-cygwin app is terminated if pseudo console is disabled. */
-  if (to_be_read_from_nat_pipe () && !get_ttyp ()->pcon_activated
-      && get_ttyp ()->pty_input_state == tty::to_cyg)
-    {
-      acquire_attach_mutex (mutex_timeout);
-      fhandler_pty_slave::transfer_input (tty::to_nat, from_master,
-					  get_ttyp (), input_available_event);
-      release_attach_mutex ();
-    }
-
   line_edit_status status = line_edit (p, len, ti, &ret);
   ReleaseMutex (input_mutex);
 
-- 
cygwingitgadget

