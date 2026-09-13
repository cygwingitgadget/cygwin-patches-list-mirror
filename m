Return-Path: <SRS0=KMKm=HF=gmail.com=gitgitgadget@sourceware.org>
Received: from mail-pz2-x24.google.com (mail-pz2-x24.google.com [IPv6:2607:f8b0:4864:3b::24])
	by sourceware.org (Postfix) with ESMTPS id 3826B4BB3BA7
	for <cygwin-patches@cygwin.com>; Sun, 13 Sep 2026 12:30:08 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 3826B4BB3BA7
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 3826B4BB3BA7
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:3b::24
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1789302608; cv=none;
	b=uWILAnetXL325uvx5fx4JdMvX4n//dsSBKsbTqk3NcbdxxOonaF7S/qymcWLnZkXcSxKJ7jto8cVyQO3GWJVV2BEBVtSIH7DzYiX7LL9v71f1zOBwRV/1fSS2TV/x/klxKi3QScvCpB54OShyJAMkc/L0ZhMPKyhjE3bG83eHNI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1789302608; c=relaxed/simple;
	bh=GVO4sGUw6UN7Pi8bjwxxl5ngz42eL5lIcR+Pjd0rUVM=;
	h=DKIM-Signature:Message-Id:From:Date:Subject:MIME-Version:To; b=TcXSS4zYYEt2+3Faf/Znj9I/qSjFKt/zwTftq9LMP6GiPuiXMYuE7CnkwbxxFpzHczI6bMI0/bq96ADLs7vhFxw7u5/cr4aIwwr3aREEZyNGCfN+lVhFAviw0S3VREOEeKaONSZ1FM1BZxeLiVuWPrUWWSwz0I2DgVZutCsU9Wg=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oTTjiTHF
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 3826B4BB3BA7
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oTTjiTHF
Received: by mail-pz2-x24.google.com with SMTP id 41be03b00d2f7-cc4d04d73b8so874503a12.1
        for <cygwin-patches@cygwin.com>; Sun, 13 Sep 2026 05:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789302607; x=1789907407; darn=cygwin.com;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6oN4ItJAANJmJYD2TfmptU9TypDkIEC6mUZFp4HNDbA=;
        b=oTTjiTHFU4QDA3TfwaCg00TGgKeHPh7YBw5+AUJIgKMB6BgeMKaxYavthQYLEA5ojX
         KAtVRkawBFGvKIAwkzg4R+JcuSKDBhXpJGEPDb49qTvMmc4/j+LyvChHHMgN1QUBcPb5
         0ewuwATOcpCl1z9yi1m2FZ5xblboav5dKyGtRaYC8yhAqnR0Wr4iR8LUYK70dklCc8mr
         bnZvGkEluLKj+R9KmTB9uNa52mLIzXk7DL6lADhgrO/gO+gflg3l4Hn2BfuWmJa3NEuc
         R3rT1HQm1eWE7KIpJDo330+xGZ8z6QitATwYSVZ6f4ZDRXRI8YZWU5gJl7Sm/MI52ftP
         zDtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789302607; x=1789907407;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6oN4ItJAANJmJYD2TfmptU9TypDkIEC6mUZFp4HNDbA=;
        b=VFmKKgPYUGabIktGm+BdTCnz5Ky6GOooZ2I+VRSE7pVksNs8HoW10nInZJWnbzZhm7
         WQ28WmWqGsyaQqnycQUOdAvqkwIKLFeSDVEu4qvKVYFP+paue8dAQKbMTF7dHzGiZxkf
         2wR0TNxWoru2GuVATTO8IpovZR4ANTFgQD804kKXpTNnvhci3BD3Dx0o43X6yp3doouS
         n8hW6+ojsnFVNDSmTiD1PuH06l5yM02eSofb/uFS1LxRkwCMgfgVKFgePGijVrDmollA
         ZfA/sad3nqleHqMCT2UpotAC4G6Znv1E2l3RReKnvPplfPpunbVd37J5y6kXrGfYBAb0
         CTtw==
X-Gm-Message-State: AFuF++m3tvTEHtKhZxd+hJ3iGWOYSELwLz6DnwjFuo3jVgiAunzYP4Rp
	aetGKEChcF0LfT+1xkkFgZdj/YWFhJa/eemBEkeJ30rvkbon1UcL+G8VGFm+KA==
X-Gm-Gg: AYBFou0gAeDKQk5YWZjS/4icVAukPnRGu/Sfdu35qNyWbRwo1MLaWdcsIctujLKAhJX
	YjVqPm+7dx84Z1UshDnXjEgeGOsw+dQUcRPZAwRc1qHAUdrH3V1Hda3MFG4UzEPyHSRaUf/O18f
	V2cyhvPa9YNRp+iU+/sDDv/0Kh7gTWaHvx9BnTMbv4BFBwXYj/z1RiiEFo18QbxC4V3IVHLsehE
	QTAZuef9TWKtkAHmp2v0HyZFlcLkvYlnEfTvr7GPg2fifPLGxbtqre3bfWtl4IpmbI19b8M17Mw
	DdNA/gNecqzJp5ZxHDr5TyMYyC6IfTmMuXTm3XrZxVwkuxReYQTHfjU9XwtC54snY9aD0/kGw0g
	Cqe+V1QCY0bnxzItEKv6HYRDeDl2kPQGW57K5xYGBKu89ow2Mw9pNW9X6W4uRY7BRhzFulKW+3u
	kfysET8aHVgIakDgxRII4Zwo5Fj42XZce4LK+f46YwK0Tg6DHFXL68voyOJsa4Oy8AZTyYGQCuO
	woL+F6wE4U=
X-Received: by 2002:a05:6a20:da05:b0:3c4:4272:b400 with SMTP id adf61e73a8af0-3db0e44a724mr13873560637.18.1789302607047;
        Sun, 13 Sep 2026 05:30:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.66.174.81])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc4c6550e06sm3515179a12.14.2026.09.13.05.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 05:30:06 -0700 (PDT)
Message-Id: <pull.10.cygwin.1789302605264.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 13 Sep 2026 12:30:05 +0000
Subject: [PATCH] Cygwin: pty: preserve terminal replies after PTY adoption
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>
X-Spam-Status: No, score=-11.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This fixes an issue reported about MSYS2/Win32 interaction, but applies
to regular Cygwin as well. In the following, the original scenario is
described.

MSYS Vim launched by native Git from Bash in MinTTY can delete the first
line, enter Insert mode or insert RGB text at startup. PTY adoption sends
Vim's output directly to MinTTY, but input stays with ConHost until the
first Cygwin read/select. Vim inherits Git's foreground process group, so
the process-group callback does not trigger an earlier handoff.

Vim sends terminal queries before reading. ConHost interprets cursor
position reports as function keys, which the later input transfer delivers
to Vim as keystrokes. A color reply split across the handoff reaches Vim
without its introducer. Fragmented writes are valid; inconsistent routing
corrupts their contents.

Requesting noncanonical input with tcsetattr() provides a control point
before these queries. Handing input to the Cygwin PTY there aligns both
directions before replies can be misdirected, rather than waiting for
consumption. Only the foreground process on an active pseudoconsole takes
this path; canonical, background and pcon-disabled calls are unaffected.

The existing synchronized transfer preserves queued input and line
discipline. Balancing the temporary reader registration without transferring
back keeps input on the Cygwin pipe without a permanent reader claim or
changes to native-owner cleanup. Releasing the output mutex first avoids
holding it across the input-transfer path.

Addresses: https://github.com/git-for-windows/git/issues/6403
Fixes: 6eed1ef74869 ("Cygwin: pty: detect pcon-backed pty for non-Cygwin-spawned children")
Assisted-by: GPT-6
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    Cygwin: pty: preserve terminal replies after PTY adoption
    
    I just merged this into Git for Windows' fork of the MSYS2 runtime, as
    it is a somewhat pressing problem due to Git for Windows v2.56.0-rc0
    already being overdue.
    
    This patch is based on cygwin-3_6-branch, but is easily cherry-picked
    onto master, too.

Published-As: https://github.com/cygwingitgadget/cygwin/releases/tag/pr-10%2Fdscho%2Ffix-vim-terminal-replies-v1
Fetch-It-Via: git fetch https://github.com/cygwingitgadget/cygwin pr-10/dscho/fix-vim-terminal-replies-v1
Pull-Request: https://github.com/cygwingitgadget/cygwin/pull/10

 winsup/cygwin/fhandler/pty.cc | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index c5081bcaf..f6e051b9e 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -1637,6 +1637,15 @@ fhandler_pty_slave::tcsetattr (int, const struct termios *t)
   acquire_output_mutex (mutex_timeout);
   get_ttyp ()->ti = *t;
   release_output_mutex ();
+
+  /* Terminal queries can precede the first read/select after entering
+     noncanonical mode.  Their replies must bypass the native console. */
+  if (!(t->c_lflag & ICANON) && get_ttyp ()->pcon_activated
+      && get_ttyp ()->getpgid () == myself->pgid)
+    {
+      mask_switch_to_nat_pipe (true, true);
+      mask_switch_to_nat_pipe (false, false);
+    }
   return 0;
 }
 

base-commit: c19c1e6ad9d8abad640ffcb95996642cc35955ec
-- 
cygwingitgadget
