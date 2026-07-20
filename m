Return-Path: <SRS0=eG9A=FO=gmail.com=gitgitgadget@sourceware.org>
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
	by sourceware.org (Postfix) with ESMTPS id 6DE784BA2E13
	for <cygwin-patches@cygwin.com>; Mon, 20 Jul 2026 09:43:20 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 6DE784BA2E13
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 6DE784BA2E13
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::836
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1784540600; cv=none;
	b=gl1ycZ6IqEq4ONVkF71uzIlPqIh9+fOh2DdgWntcOKO+1811vUhqbPo6t2YAy//SFphyN2DzE7524Y7v0WbPDiTU37qum4HunmrCSymD2KeeWLRrkmbOV1n2uabQhW9wgK4ei7uQXgkAnnCj6tsWsM/p71+SpTVIMVcDLkZTHC4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1784540600; c=relaxed/simple;
	bh=njPPBimY3in6pKIAPzGf7GTDYqdrLPF9kX05m6GCoWo=;
	h=DKIM-Signature:Message-Id:From:Date:Subject:MIME-Version:To; b=DDqE8f9yKGbri3bUm5JY/Qi+XZsT9/qw7c5zv5bRtFVSITWsWtrNI4fV2xWW7ACpnafd/88txUXqGbRq51dd+oX7OTM6qlU/Rcc76UQZjcOTHGqljLZ1FnQhc4+nDboLst/DImwp5A1phpdCOUyuSrXObYMxV/ItAmY6Mz+GhDM=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=n8384p7/
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 6DE784BA2E13
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=n8384p7/
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-51c21495722so70236451cf.3
        for <cygwin-patches@cygwin.com>; Mon, 20 Jul 2026 02:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784540600; x=1785145400; darn=cygwin.com;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RdBxIzT3ifDnkhyj5smYMWRdPZKTgfhnP57r37UY4mk=;
        b=n8384p7/dgrbfPHZZKiSifoMYFjg4ffpK5CEZ6JusnnNpTOptIkbDlWStHhy3RshSa
         Q+W+xnOCHot6gUJyfVRSregSiliqu1Usg0vs/vAgmoMpFCjk2ZbyfpJpcKGTEaRRh9uk
         WN3/b/WszUEV72WIcVlwy8eQjDtPQdlmDArcHo5ICaknKX2QFb90Ng1yuzYLCj2/7pnt
         jOYxHRYfKhcqcUtizxYQi6Fdudjoj4ul+ljQSMp44pLkj3bRUeQ46NDJHD2sEjUpnpHz
         U3syBhn2HG4MeOipfTOr8pTzSUcD/8YZ2HlCkQj3niX+Bg5gLfrVt4oUXGdXk7D/3bx2
         OZKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784540600; x=1785145400;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RdBxIzT3ifDnkhyj5smYMWRdPZKTgfhnP57r37UY4mk=;
        b=sPg7Cwkt5PjynWhxp2N/zJvtNF1CeVWLgFyETCplLyLk8Utrb2S36Ey71LCwDi4ept
         QW9qwKj8qU6gNluOMfuXkFM2ecOykiyL6w7wNt93BqrVe8l1rwbyEfuaCzit95FKMSIC
         qSQJOmk5d4MZl14vGScgUUUoK7BhTRzufhObvevEO6vq650db36Im+wOM8/kPZ/Am/zu
         4LaHD52ARubBUMdJvdenxnvJuLdzz44JHr51um/PoIErSWv6UppO2cFSBHTa1AmqHmPV
         Sf+E23LMPIpk6EK3i8cny6geqfXfY6zEO9gYICIadmJnVKQCYdiFFCWyfGEaCRCxj1ZV
         9dew==
X-Gm-Message-State: AOJu0Yxo6F6eQvkFVsug0Lexpg24a6HqeijdtbziWjlZ5IN1qLkdbeiR
	TzpwYZ0CEviq9KsUouTlPgFgmNFpmZj563E8nASAOK4Wz42JKsB/iepEJcfNJA==
X-Gm-Gg: AfdE7cnW8+DljAHt21rmzmSVmkO/rA4NOQhcXeeAmmQgAXCb5tBBJ/ePxcQevSoK603
	823LrmLkazLrEZgjdPRiCf308cBQCy2V64AH7FwuixVQ5HZX+sq7NZxPxuDGMg+Mpmrr6BkTeHk
	e2BRHDIfYw8gCtDkwfNqErIzBLHMmm6m+nnv9hoTZXa7HWi+UHFuNHllecMnIRfZOuFJ6VeoJHR
	1POGuOwOddbRUdvrEFYgRbuobdUdaTZWGyFjnEZjdbnsLvSLDyu/ikOVmBBhyMjRi/LBz/0GQMI
	cxXAzsjmSXAYIkWsjipfbLZCCxnQtF17AYqaE/v7y7tNAs/uJXGWXzZaVe18BKIZaYyCSuC1Gqn
	WaUqNMAefUNo90J3lpPi4EF8qhicP71lSAMlRhkCdyK0GJrtUoZc826e0/abODfd1NQsokyN769
	fpr1z/ye7xFDYWwYA4
X-Received: by 2002:a05:622a:1a98:b0:519:8b76:2ce0 with SMTP id d75a77b69052e-5213ccd47b8mr129621651cf.37.1784540599819;
        Mon, 20 Jul 2026 02:43:19 -0700 (PDT)
Received: from [127.0.0.1] ([145.132.99.131])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907786f35dbsm91606426d6.35.2026.07.20.02.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 02:43:19 -0700 (PDT)
Message-Id: <pull.8.cygwin.1784540598759.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 20 Jul 2026 09:43:18 +0000
Subject: [PATCH] Cygwin: pty: keep interactive console input for native
 programs via Cygwin
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_ABUSEAT,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,RCVD_IN_XBL,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Currently, when a native Windows program starts a Cygwin program while a
pseudo console is active, and the Cygwin program then starts another
native Windows program, the final program can lose access to console
input. It then behaves as though its standard input were redirected
instead of remaining interactive.

For example, a native `git.exe` may invoke shell aliases (i.e. execute a
shell command) that would in turn call interactive Git commands who
would no longer work because their standard input appeared to be
redirected. This can be demonstrated as follows:

  git -c 'alias.console-probe=!powershell.exe -NoLogo -NoProfile -Command "
    Write-Output ([Console]::IsInputRedirected)
    try {
      [void][Console]::KeyAvailable
      exit 0
    } catch {
      exit 1
    }
  "' console-probe

Running this command with a Win32 version of `git.exe` currently prints
`True` and exits with exit code 1. In the latest official release, where
this bug is not present, it prints `False` and results in exit code 0.

The reason is to be fonud in the archetype code. Reminder: For each
pseudo terminal (pty), the archetype is the shared pty fhandler that
owns the underlying native handles and supplies them to every
per-file-descriptor fhandler for that pty.

`open_with_arch()` calls `open()`, copies the first pty fhandler's state
into the archetype, and then calls `open_setup()`. At that stage, pcon
handle adoption already took place in `open_setup()`. This was not
anticipated by 60a88896dc (Cygwin: pty: do not leak nat handles when
adopting the pcon's in open_setup(), 2026-06-25), which tried to fix a
leak by closing the superseded native handles as they were replaced in
`open_setup()`.  Because `open_with_arch()` had already copied those
handle values into the archetype, closing them invalidated the
archetype's copies.

The archetype therefore retained stale values for those closed handles,
which later pty fd fhandlers would inherit. If Windows reuses one of
those values for a newly duplicated pcon handle, closing the stale value
closes the new handle instead. The nested native program then receives
unusable console input.

Preserve usable console input by moving the unchanged transactional pcon
handle adoption to `open()`, before the archetype snapshot. The archetype
then receives valid pcon handles, all pty fd fhandlers inherit live
handles, and the superseded raw pipe handles are closed exactly once.

This commit is best viewed with `--color-moved`.

Fixes: 60a88896dce0 ("Cygwin: pty: do not leak nat handles when
 adopting the pcon's in open_setup()")
Assisted-by: GPT-5.6 Sol
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    Fix a regression on cygwin/master
    
    I noticed this regression in Git for Windows' fork, to which I had
    backported the faulty commit from Cygwin's master branch.

Published-As: https://github.com/cygwingitgadget/cygwin/releases/tag/pr-8%2Fdscho%2Ffix-nat-handle-leakfix-cygwin-v1
Fetch-It-Via: git fetch https://github.com/cygwingitgadget/cygwin pr-8/dscho/fix-nat-handle-leakfix-cygwin-v1
Pull-Request: https://github.com/cygwingitgadget/cygwin/pull/8

 winsup/cygwin/fhandler/pty.cc | 44 +++++++++++++++++------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index f3df55f34..37a480933 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -1220,26 +1220,6 @@ fhandler_pty_slave::open (int flags, mode_t)
       release_attach_mutex ();
     }
 
-  set_open_status ();
-  return 1;
-
-err:
-  if (GetLastError () == ERROR_FILE_NOT_FOUND)
-    set_errno (ENXIO);
-  else
-    __seterrno ();
-err_no_errno:
-  termios_printf (errmsg);
-err_no_msg:
-  for (HANDLE **h = handles; *h; h++)
-    if (**h && **h != INVALID_HANDLE_VALUE)
-      CloseHandle (**h);
-  return 0;
-}
-
-bool
-fhandler_pty_slave::open_setup (int flags)
-{
   if (get_ttyp ()->pcon_activated)
     {
       HANDLE pcon_owner = OpenProcess (PROCESS_DUP_HANDLE, FALSE,
@@ -1255,8 +1235,8 @@ fhandler_pty_slave::open_setup (int flags)
 				        0, TRUE, DUPLICATE_SAME_ACCESS);
 	  if (ok_in && ok_out)
 	    {
-	      /* Close the cyg master-side handles open() installed before
-		 replacing them, so they do not leak. */
+	      /* Replace these before open_with_arch() copies them into the
+		 archetype shared by all pty slave fhandlers. */
 	      CloseHandle (get_handle_nat ());
 	      CloseHandle (get_output_handle_nat ());
 	      set_handle_nat (new_in);
@@ -1273,6 +1253,26 @@ fhandler_pty_slave::open_setup (int flags)
 	}
     }
 
+  set_open_status ();
+  return 1;
+
+err:
+  if (GetLastError () == ERROR_FILE_NOT_FOUND)
+    set_errno (ENXIO);
+  else
+    __seterrno ();
+err_no_errno:
+  termios_printf (errmsg);
+err_no_msg:
+  for (HANDLE **h = handles; *h; h++)
+    if (**h && **h != INVALID_HANDLE_VALUE)
+      CloseHandle (**h);
+  return 0;
+}
+
+bool
+fhandler_pty_slave::open_setup (int flags)
+{
   set_flags ((flags & ~O_TEXT) | O_BINARY);
   myself->set_ctty (this, flags);
   report_tty_counts (this, "opened", "");

base-commit: 524d75ff73986b263161665af771cc90e55b5e01
-- 
cygwingitgadget
