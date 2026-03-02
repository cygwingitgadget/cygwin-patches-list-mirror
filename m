Return-Path: <SRS0=T3ZE=BC=gmail.com=gitgitgadget@sourceware.org>
Received: from mail-dl1-x122f.google.com (mail-dl1-x122f.google.com [IPv6:2607:f8b0:4864:20::122f])
	by sourceware.org (Postfix) with ESMTPS id AA0724BA2E0A
	for <cygwin-patches@cygwin.com>; Mon,  2 Mar 2026 14:24:47 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org AA0724BA2E0A
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org AA0724BA2E0A
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::122f
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1772461487; cv=none;
	b=AVaFiTs8BfYINvz83O5vLtonVX3XUXzhqrQqfygGIUws2J+uIDp3JWj2CVHzKIzHQAp1OGvqhPdERFzIg5VStOR6TDQktog+rNEyeFTXEwCEJrmtrN0VZiqvPMhkDlZ4AgDLHDGL0ObHkoATr1bqKzLenHOnaxOmP95N+DofVwc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1772461487; c=relaxed/simple;
	bh=bc+LmcU88BoKl+snBK/UCYNd6xmtjVegSqFL4CmOJN8=;
	h=DKIM-Signature:Message-Id:From:Date:Subject:MIME-Version:To; b=KWB0RP+xyDZBwxm/c3263kxxY7DCc595Ssg0O/x4J6uihBVy6ZFs5APpqz8S0rhdj2DO4eZnY0Fbc6MN2/38Z2UuoxzVQS7ushlP9DhClhzd36g/7uQDGsvstbigzRicQJS3VgIdURp+Jg0xCeuH29OKlfgAqA3hTEnooEqQmH8=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org AA0724BA2E0A
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=EzeAY98r
Received: by mail-dl1-x122f.google.com with SMTP id a92af1059eb24-124a635476fso5189759c88.0
        for <cygwin-patches@cygwin.com>; Mon, 02 Mar 2026 06:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772461486; x=1773066286; darn=cygwin.com;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6WXWBlsiOggvPfQqSPl2LUaMfM2PTxOZiIVYpbB7uQQ=;
        b=EzeAY98r9VBK+IfNUv0n8gRo9jU+kxsCGzz+phRAeVBsAEElOFh2Nr2yspOaUbsBer
         fuz3Wqnftaxgw9sPHrte07HQTRUB312AlR04tTGpZMfU1Piz/YBjA/573XjP4v8q5XHv
         OWNIuZxH4oLwZba6qNPxhMZS+1VX/JoTP1sKhW+eHubSC+CqzCd78bVk2U+k2MhlvmsQ
         OCjBnc+B9uyQS8GtDzKbRXppbjdeZ3tuQ34ROV7L9iH4W1XBM24aQXA7cNZTNbFoLMyX
         HniaTI1jYatqL9S7TfEnoTE5wiRk62PfZ2xGP24c0mhjL7F+7Cutq/n1T/4NzoEzlfPo
         yhBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772461486; x=1773066286;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6WXWBlsiOggvPfQqSPl2LUaMfM2PTxOZiIVYpbB7uQQ=;
        b=T47jZEbFYY2htzdvojLlrPEBGL6mB959XjCyRuRU2xryDW0HOO0HoixOm5fZh2L4TR
         gudUfFzhc32145PCZcVqLsN3VhH+JmKeGnfGck3nIhAl4qX0Q1aCskyCGjpAvaeZKiZz
         Pxspzga9TeTIvqOXb6cnYxIwwqZhvB2h/SoIC2xOnnryMHARPv4aBZ9EkbJL4xiXVg52
         BoUIPxuOcqY+IGrN7HFiMj12lEJkbFYgGVR/9iNgJg2f06ceohAu8Vz5CZFAo6LZAtDp
         aH2SobupTyOwBDtDCeEOfKZmU7b7whO0LlduLfQMQ5/RUj41YBlI3rrRDS+83RTh2f+G
         sHYA==
X-Gm-Message-State: AOJu0YwKAo/OUMYWW5sE7nDdf2Xd6OZIvcIF5rKuF/Jqc6/0OAlFV0f3
	DaeWqvuKAKtHRKArcJjKVUR63HmlKA4mQm5iHIIzJ0xfrqi2ZOLGfblZfpX4PePG
X-Gm-Gg: ATEYQzzJTPljeHixpsfpzM5Sbd576lO6b/gSN1infTUIQhjoBB1ADengm71JYGU92g1
	wPiq1mLVNYvSnkz5Ez2dM7R9NMGEpgmTOVaBoQULxADbdXx+S/tInoCHC8WQQJ2tvMjbSXfkcOw
	HbK4vTOm8wogex1vl+fHdP/iCWAEUhnsOGmTlk88290UysiA2gwr/9mC4qQHNsiTL9S/wrLS1oh
	9V3e1N1hCHkqwNooLUU4pKtiOtWGwPw4wPwBykx7v9nKFdZjvoN5spsDPvjhXVbYYeZLU+X28e6
	rzievEVjeDdi9vZNt4MKFOSQHS4/x3Qb5+sLwCYuyDlKWAwhA8K1rW89ZhTA/pI79tBUfV79ZJL
	hNUb4jUbqsi2iBGcW5Kct7UcaPEfX3b+wj688F7pycYieIbEbnljfZPIhoGP+NmbGtFK1vrn2D9
	7LQ59kuPPt56cDTux/6+ZkQgWTPA==
X-Received: by 2002:a05:7022:6082:b0:119:e55a:9be4 with SMTP id a92af1059eb24-1278fa9f6fdmr6148678c88.0.1772461486025;
        Mon, 02 Mar 2026 06:24:46 -0800 (PST)
Received: from [127.0.0.1] ([52.159.245.148])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-127899d49ccsm16400264c88.3.2026.03.02.06.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 06:24:45 -0800 (PST)
Message-Id: <d0936448e07081445fb24b611654741bb6020709.1772461480.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.6.cygwin.1772461480.gitgitgadget@gmail.com>
References: <pull.6.cygwin.1772461480.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 02 Mar 2026 14:24:38 +0000
Subject: [PATCH 2/4] Cygwin: pty: Remove pcon_start readahead flush that
 displaces readline data
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

After the previous commit addressed the worst data-stealing code
path, roughly one in five test iterations still shows a stray
character.  Another transfer code path in master::write() is
responsible.

When a native process becomes the PTY foreground, the pseudo console
must be initialized.  During this "pcon_start" phase, master::write()
enters a polling loop that feeds keystrokes to the nascent pseudo
console.  When the loop completes (pcon_start becomes false), there
was a block of code that:

  1. Flushed the master's readahead buffer via accept_input()
  2. Called transfer_input(to_nat) to move all cyg pipe data
     to the nat pipe

The intent was to preserve typeahead: characters typed during pcon
initialization should eventually reach the native process.  But
during pseudo console oscillation (the rapid pcon on/off cycles
described in the previous commit), this fires on every pcon
re-initialization -- and the "typeahead" it transfers includes
readline's entire editing buffer.

Worse, if the terminal emulator was mid-way through sending a rapid
editing sequence like "XY<BS><BS>" (type two characters, then erase
them with backspace), the readahead flush fires after buffering "X"
but before the backspaces arrive.  The orphaned "X" gets pushed to
the cyg pipe via accept_input(), where readline sees it as genuine
input -- producing a stray character that the user never intended.

Remove the accept_input() and transfer_input() calls entirely.
Keep `pcon_start_pid = 0`, which marks the end of initialization.
The readahead data belongs to the Cygwin process (bash is in
canonical mode during command entry) and will be delivered naturally
when line_edit() encounters a newline or when readline switches the
terminal to raw mode after the foreground command exits.  The
setpgid_aux() code path in the slave process still handles the
steady-state cyg-to-nat transfer at process-group boundaries.

Combined with the previous commit, Git for Windows' AutoHotKey-based
UI tests now pass cleanly in the vast majority of iterations.

Regression note: the removed code was motivated by a 2020 bug report
about lost typeahead with native processes:
https://inbox.sourceware.org/cygwin/7e3d947e-b178-30a3-589f-b48e6003fbb3@googlemail.com/
Since the pcon_start window is brief (a few milliseconds) and
setpgid_aux() handles the steady-state transfer, the risk of
typeahead loss is low.

Addresses: https://github.com/git-for-windows/git/issues/5632
Fixes: 10d083c745dd ("Cygwin: pty: Inherit typeahead data between two input pipes.")
Fixes: f20641789427 ("Cygwin: pty: Reduce unecessary input transfer.")
Assisted-by: Claude Opus 4.6
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 winsup/cygwin/fhandler/pty.cc | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index f7db43b9d..2450057c1 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -2186,21 +2186,6 @@ fhandler_pty_master::write (const void *ptr, size_t len)
       if (!get_ttyp ()->pcon_start)
 	{ /* Pseudo console initialization has been done in above code. */
 	  pinfo pp (get_ttyp ()->pcon_start_pid);
-	  if (get_ttyp ()->switch_to_nat_pipe
-	      && get_ttyp ()->pty_input_state_eq (tty::to_cyg))
-	    {
-	      /* This accept_input() call is needed in order to transfer input
-		 which is not accepted yet to non-cygwin pipe. */
-	      WaitForSingleObject (input_mutex, mutex_timeout);
-	      if (get_readahead_valid ())
-		accept_input ();
-	      acquire_attach_mutex (mutex_timeout);
-	      fhandler_pty_slave::transfer_input (tty::to_nat, from_master,
-						  get_ttyp (),
-						  input_available_event);
-	      release_attach_mutex ();
-	      ReleaseMutex (input_mutex);
-	    }
 	  get_ttyp ()->pcon_start_pid = 0;
 	}
 
-- 
cygwingitgadget

