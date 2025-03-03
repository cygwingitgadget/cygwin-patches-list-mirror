Return-Path: <SRS0=81Ig=VW=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e03.mail.nifty.com (mta-snd-e03.mail.nifty.com [106.153.227.115])
	by sourceware.org (Postfix) with ESMTPS id 599AF3858D21
	for <cygwin-patches@cygwin.com>; Mon,  3 Mar 2025 07:24:33 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 599AF3858D21
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 599AF3858D21
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.115
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1740986674; cv=none;
	b=ArtaCqOGyFv1iDneWh7wfXtSLdQ+rGmPyIwoStKJI76W94oecBLkt6cNKyIiP/X4RVqsIHpwMKhWyNEpJeC6jiEyyOm9dhcP8BUdy1YsND+5/SdOa3oaVgSao8xKLWk3mCXkuTouy4hL0WJ3eB06G7GPDonXEZQ8A8yvRlcgVk8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1740986674; c=relaxed/simple;
	bh=qy4gzNIMh99qPsS1YzLtAjqi7G4/yArDZ/pKhIEbMos=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=DoYcZvxpqxywqMlnWi3+nlFXUeH7GA3tRJW89STm9Ry43NM+RY0fERBurPEvXi3QnP4Wu9wJAAITN3yqSC/aGqS4uwmvU/pB88jBMi1njFEkVlg9a6TGG0IFAJ0W9lCKt3PC6blJh52yuyRIIrqmjycQB05qT2RIRL/OEHHP5tE=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 599AF3858D21
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=kz90whwP
Received: from localhost.localdomain by mta-snd-e03.mail.nifty.com
          with ESMTP
          id <20250303072430742.SVA.110778.localhost.localdomain@nifty.com>;
          Mon, 3 Mar 2025 16:24:30 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Mike,
	Marcelais,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Cygwin: console: Redesign mode set strategy on close().
Date: Mon,  3 Mar 2025 16:24:03 +0900
Message-ID: <20250303072411.2193-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1740986670;
 bh=uCh9GvG/iO1QVQewcMiSFzxsgYMfAgpgE9uu6I+Gv1E=;
 h=From:To:Cc:Subject:Date;
 b=kz90whwPlLKvstV9fIBGyVHwchKZRUzce6F9A88HQVMGUtF9E7OMzQnrjPSI5Ke7KUVwl7RJ
 klYtfPPKa0FrwJ2xPmkDSRr2FNRmibtqv8GTL/YQ4IhQJKsdNl8Bvz7N2XIdg8ZU+U8pMQopcq
 eto/S99+w7RnxrZ8s4FJuyqBrsEs26uxkDI/Xj7LZ/HkOas5h64LKgiM7EGl0uSznOtfNUXYeM
 Qt55fx8Rex8RNk7jEIfisVG7feealDymrYat63Q0I3X1cxAIzgaf7WXcp21OCGJld2N1DVFTZl
 cvnc3JGj76OZaQOxXZmB74JlA9rfqQ/XlWrKZHJakuoQyfnQ==
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

The required console mode for a non-cygwin process is different from
that for a cygwin process. There are currently three modes: tty::cygwin,
tty::native, and tty::restore. The latter two are for the non-cygwin
processes. tty::restore is the mode for the non-cygwin processes that
started the cygwin process, used to restore the previous behaviour.
tty::native is the mode that reflects some terminfo flags. The issue
below is caused because the console mode fails to be restored to the
previous console mode used by cmd.exe.
This patch redesigns the strategy to determine which mode should be
set on console close() to fix all similar problems.

Addresses: https://github.com/microsoft/git/issues/730#issuecomment-2688925411
Fixes: 30d266947842 ("Cygwin: console: Fix clean up conditions in close()")
Reported-by: Mike Marcelais, Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/fhandler/console.cc       | 56 ++++++++++++++-----------
 winsup/cygwin/local_includes/fhandler.h |  1 +
 2 files changed, 32 insertions(+), 25 deletions(-)

diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
index 12a218576..da335b3e3 100644
--- a/winsup/cygwin/fhandler/console.cc
+++ b/winsup/cygwin/fhandler/console.cc
@@ -916,8 +916,7 @@ fhandler_console::cleanup_for_non_cygwin_app (handle_set_t *p)
   /* Cleaning-up console mode for non-cygwin app. */
   /* conmode can be tty::restore when non-cygwin app is
      exec'ed from login shell. */
-  tty::cons_mode conmode =
-    (con.owner == GetCurrentProcessId ()) ? tty::restore : tty::cygwin;
+  tty::cons_mode conmode = cons_mode_on_close (p);
   set_output_mode (conmode, ti, p);
   set_input_mode (conmode, ti, p);
   set_disable_master_thread (con.owner == GetCurrentProcessId ());
@@ -1976,31 +1975,13 @@ fhandler_console::close (int flag)
 
   acquire_output_mutex (mutex_timeout);
 
-  if (shared_console_info[unit] && !myself->cygstarted
+  if (shared_console_info[unit] && myself->ppid == 1
       && (dev_t) myself->ctty == get_device ())
     {
-      /* Restore console mode if this is the last closure. */
-      OBJECT_BASIC_INFORMATION obi;
-      NTSTATUS status;
-      status = NtQueryObject (get_handle (), ObjectBasicInformation,
-			      &obi, sizeof obi, NULL);
-      /* If the process is not myself->cygstarted and is the console owner,
-	 the process is the last process on this console device. The console
-	 owner has two console handles, i.e. one is io_handle and the other
-	 is the dupplicated handle for cons_master_thread.
-	 If myself->cygstarted is false and the process is not console owner,
-	 the process is supposed to be started by the exec command in the
-	 owner shell. In this case, the owner process is still alive in the
-	 background and waiting for this process. So the handle count is
-	 three (two in the owner process, one is mine). */
-      if (NT_SUCCESS (status)
-	  && obi.HandleCount == (con.owner == GetCurrentProcessId () ? 2 : 3))
-	{
-	  /* Cleaning-up console mode for cygwin apps. */
-	  set_output_mode (tty::restore, &get_ttyp ()->ti, &handle_set);
-	  set_input_mode (tty::restore, &get_ttyp ()->ti, &handle_set);
-	  set_disable_master_thread (true, this);
-	}
+      tty::cons_mode conmode = cons_mode_on_close (&handle_set);
+      set_output_mode (conmode, &get_ttyp ()->ti, &handle_set);
+      set_input_mode (conmode, &get_ttyp ()->ti, &handle_set);
+      set_disable_master_thread (true, this);
     }
 
   if (shared_console_info[unit] && con.owner == GetCurrentProcessId ())
@@ -4704,3 +4685,28 @@ fhandler_console::fstat (struct stat *st)
     }
   return 0;
 }
+
+tty::cons_mode
+fhandler_console::cons_mode_on_close (handle_set_t *p)
+{
+  const _minor_t unit = p->unit;
+
+  if (myself->ppid != 1) /* Execed from normal cygwin process. */
+    return tty::cygwin;
+
+  if (!process_alive (con.owner)) /* The Master process already died. */
+    return tty::restore;
+  if (con.owner == GetCurrentProcessId ()) /* Master process */
+    return tty::restore;
+
+  PROCESS_BASIC_INFORMATION pbi;
+  NTSTATUS status =
+    NtQueryInformationProcess (GetCurrentProcess (), ProcessBasicInformation,
+			       &pbi, sizeof (pbi), NULL);
+  if (NT_SUCCESS (status)
+      && con.owner == (DWORD) pbi.InheritedFromUniqueProcessId)
+    /* The parent is the stub process. */
+    return tty::restore;
+
+  return tty::native; /* Otherwise */
+}
diff --git a/winsup/cygwin/local_includes/fhandler.h b/winsup/cygwin/local_includes/fhandler.h
index 3945225c6..b00a1a195 100644
--- a/winsup/cygwin/local_includes/fhandler.h
+++ b/winsup/cygwin/local_includes/fhandler.h
@@ -2366,6 +2366,7 @@ private:
 
   void setup_pcon_hand_over ();
   static void pcon_hand_over_proc ();
+  static tty::cons_mode cons_mode_on_close (handle_set_t *);
 
   friend tty_min * tty_list::get_cttyp ();
 };
-- 
2.45.1

