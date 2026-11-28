Return-Path: <SRS0=WEyG=JR=gmail.com=gitgitgadget@sourceware.org>
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
	by sourceware.org (Postfix) with ESMTPS id F3B2B4615660
	for <cygwin-patches@cygwin.com>; Sat, 28 Nov 2026 07:04:26 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org F3B2B4615660
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org F3B2B4615660
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::531
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1795849467; cv=none;
	b=fLT8qBseoI9gEDf3LQSHmzRRMZBOwWQ1RSPx7e2Z70GtelMNmbaqaJ/eR8KUXh3/vnV2z83Ce2WAGoXgMZb7C8eEM3fYxZcbWA6O7LnlbkWA+axzRmHECAs93BLhXoN+oCkUwnfCMy0zzI5kP0I6LYXyJ2e9yZ+R0/eKWjddVYY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1795849467; c=relaxed/simple;
	bh=nOVm1dsq8WEjnJKk/VOKPhtZ6ZBSFFSNeG9W4MAmIvo=;
	h=DKIM-Signature:Message-Id:From:Date:Subject:MIME-Version:To; b=aYM5dPfX930kMnc1cJ+qVGxLlxcvtmc33nA8uMQeCBmLuidi/jLVClZIWTLi2zmVXxLjdWeV7MPq0DfjQU0waw//h0v/zlMbEg4K/VeefP/FunedtrY+WLB8HswGkdhh2PsjCEbggx2fN8IlNgYP1UJzNXhk0R0R7AzSRwvPR2Q=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UXXdesEG
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org F3B2B4615660
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UXXdesEG
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-cddc250d815so3390785a12.2
        for <cygwin-patches@cygwin.com>; Fri, 27 Nov 2026 23:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795849466; x=1796454266; darn=cygwin.com;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LiqvMIm4o1iifFr8BAGhxzbN62e1//1XFyVC+OGK6SE=;
        b=UXXdesEGFvQUFL7JraX/mIsFK7cqunpOJeJ122qyj9gErUM+b/CIBUkLaq0G3dI+ai
         tpfUq+hh7ANXtOJI5EfYTMkibF52XTMWLTDwnKiYwXAOKZrwU67ZYARTxc8p4QH67AXg
         qaGZ418PZB+kEdKClbsy9x80ALJaLy0YaimJ1A8gONSY/LNGyThm+DMPJFUdh8fVHI9H
         khoH3C6yJTItkAHgBSHH3X4LOFJt5+oUN3PDukQ6UcAv98e2E5PafWsJydjkIp0yGZw/
         nyBAGqeVRnHn2gRQJqvZa1ANGCQGgxtqfNbUlRqylrQEVbMK7jW76KU2gWyJPBP04dZh
         Rd+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795849466; x=1796454266;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LiqvMIm4o1iifFr8BAGhxzbN62e1//1XFyVC+OGK6SE=;
        b=ASv2t1JMzXLOg/vfmiuwjedmSdrjejfnTdwog7Wyncfgy8wqjUwunE+4qGtEtX8aFm
         ry+mrJEIk524KE2oS5vZjvoCo+ZaDNioVbeCmLblDbqMVBtsyCtQ3jyc2NDSElM26Rfa
         PKw8Lwlnuufb5TbS/AvhHTAelKl3+Z/ISKFIsI/E6UwetjUk72ubYhY4CFTCOyKZRGVF
         dsha0Oto+vFQUOzfD84o8G7ZT0wnxHqalLGsmHCfSF57XCDtfY6kYeEw+FBktUmF2sbV
         6Vo7Cr3vSGMMocFU173iR6FLEEKSiBJpfF+4p9s04g0N7+BeHjhBrCxOoGjgAWYL8j4u
         GjZg==
X-Gm-Message-State: APuU4Z/xIx8WQsmObR3Vxo3HzVvEOqEH42n+09a3ECfQw2vnpyfbUVwC
	xLoDRGuzL8mTnCq92Hgfjdcq2cACBX5hRh/ZRHz9yer+Yc2rEGFeSYTIlL/nqw==
X-Gm-Gg: AZFdTZcZar18GIE2FNAStcBrd19CzWaEUnMhqmstf3K3plU9rEcf1acaBZyJInU4Ckr
	oXCXk6MKYoIlbZBvS7xt7ewWvyoz4kX6bwKl5diIG/0vHJoNeVB+FoNoKbhHZSWF4R6wXhmnl+p
	wplW8USvEfJhfB6KfFHE5nmcLbxmVlrW1hDx6U23kF0DNguxlgHae4nRmLnAjRxp7PZPPQjPMg+
	kiVkdAXAkpwlZRsMdg669HadkVcyxJJWRD4G7hpjYLjgDsDLHElya+T0nYJO8QBvCx48j1YdvYS
	tz4LRKD35AkAbmPfTgSOgiOxjjbG/xhx9PAWeHraK/wKHGoYBbg96EDn9dO/l+X3w5Q9b0HVFVN
	peSGTQJe/DBO/64ms2hIVhs676Y9BswUc/VsJM2Lt1ZeKqiycQcGG+FBFUq37GGtBoCUxRM6nzX
	ZUW68nyaByICT1VBhPdWxOmIDMM6FUtlexbJnuunl5PQF725t+txQqRsrDsBQX/n2aNGLmFPwHO
	Rccnbb7mXjfyoEQMbwuVQxlyEG+sxF+dYhCalpdtHDqVi2mjHtRPGE9c6llE3o+uK76QkfvIn5i
	t70fQwk1pdUc1+EHnfqfKNNvk19DhpuGOvDl4HZPktoklXNMQRkDQA==
X-Received: by 2002:a17:90b:4f8f:b0:3b4:f260:72de with SMTP id 98e67ed59e1d1-3b4f2607685mr11678602a91.64.1795849465669;
        Fri, 27 Nov 2026 23:04:25 -0800 (PST)
Received: from [127.0.0.1] ([128.85.44.231])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405d639fdsm44908128a91.10.2026.11.27.23.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 23:04:25 -0800 (PST)
Message-Id: <d62679ee4e4a79c636e44d57f6ca22b8e5d651d2.1795849462.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.19.cygwin.1795849462.gitgitgadget@gmail.com>
References: <pull.19.cygwin.1795849462.gitgitgadget@gmail.com>
From: "David Declerck via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 28 Nov 2026 07:04:21 +0000
Subject: [PATCH 1/2] Cygwin: fork: lock FIFO client handler lists until the
 child copied them
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    David Declerck <david.declerck@ocamlpro.com>
X-Spam-Status: No, score=-10.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

From: David Declerck <david.declerck@ocamlpro.com>

Forking while a FIFO reader creates new pipe instances can leave the
child with handle values it never inherited. Windows snapshots inherited
handles at CreateProcessW(), but the child copies the FIFO bookkeeping
later. Changes between those two operations can therefore make the
child's client list inconsistent with its inherited handles.

Those stale values can coincide with newly allocated child event
handles. Closing the inherited FIFO then closes unrelated events,
causing subsequent operations to fail with ERROR_INVALID_HANDLE.

Keep each FIFO reader's client list frozen from before process creation
until the first child synchronization confirms that copying is complete.
Protecting only CreateProcessW() would leave the later copy exposed.
Acquire the FIFO client locks before the allocator and cygheap locks:
the reader thread can reallocate its list while holding its client lock,
so the opposite order could deadlock.

The descriptor table must remain stable while identifying the readers,
and a shared handler must not be locked twice. The child already resets
its copied client-list lock during FIFO fixup after fork.

Matched private MSYS2 3.6.12 builds corroborate the failure and fix:
the unpatched build fails when exercising FIFO churn alongside forks
and child event allocation, while the patched build passes. The focused
100-fork, 1000-event regression also passes with the patch under the
native test runner and fails without it.

Addresses: https://github.com/msys2/msys2-runtime/pull/402
Assisted-by: GPT-6.1 Sol
Signed-off-by: David Declerck <david.declerck@ocamlpro.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 winsup/cygwin/dtable.cc                 | 19 +++++++++++++++++++
 winsup/cygwin/fork.cc                   | 12 ++++++++++++
 winsup/cygwin/local_includes/dtable.h   |  1 +
 winsup/cygwin/local_includes/fhandler.h |  6 ++++++
 4 files changed, 38 insertions(+)

diff --git a/winsup/cygwin/dtable.cc b/winsup/cygwin/dtable.cc
index c1c153a1b..b52960ae1 100644
--- a/winsup/cygwin/dtable.cc
+++ b/winsup/cygwin/dtable.cc
@@ -1110,6 +1110,25 @@ dtable::fixup_before_fork (DWORD target_proc_id)
   unlock ();
 }
 
+/* Lock or unlock the client handler list of each FIFO reader, once per
+   fhandler, while a child is being forked. */
+void
+dtable::fifo_fork_lock (bool lock_it)
+{
+  lock ();
+  fhandler_base *fh;
+  for (size_t i = 0; i < size; i++)
+    if ((fh = fds[i]) != NULL && fh->isfifo ())
+      {
+	size_t j;
+	for (j = 0; j < i && fds[j] != fh; j++)
+	  continue;
+	if (j == i)
+	  ((fhandler_fifo *) fh)->fork_lock (lock_it);
+      }
+  unlock ();
+}
+
 void
 dtable::fixup_before_exec (DWORD target_proc_id)
 {
diff --git a/winsup/cygwin/fork.cc b/winsup/cygwin/fork.cc
index 2aa52737c..e3e6e365a 100644
--- a/winsup/cygwin/fork.cc
+++ b/winsup/cygwin/fork.cc
@@ -326,6 +326,12 @@ frok::parent (volatile char * volatile stack_here)
   si.lpReserved2 = (LPBYTE) &ch;
   si.cbReserved2 = sizeof (ch);
 
+  /* Keep FIFO readers from changing their client handler lists until
+     the child has copied them.  Before the malloc lock: the reader
+     thread may realloc while holding its lock. */
+  cygheap->fdtab.fifo_fork_lock (true);
+  bool fifos_locked = true;
+
   /* NEVER, EVER, call a function which in turn calls malloc&friends while this
      malloc lock is active! */
   __malloc_lock ();
@@ -418,6 +424,10 @@ frok::parent (volatile char * volatile stack_here)
       break;
     }
 
+  /* The child has copied cygheap and heap. */
+  cygheap->fdtab.fifo_fork_lock (false);
+  fifos_locked = false;
+
   /* Restore impersonation */
   cygheap->user.reimpersonate ();
   fix_impersonation = false;
@@ -574,6 +584,8 @@ cleanup:
       cygheap->unlock ();
       __malloc_unlock ();
     }
+  if (fifos_locked)
+    cygheap->fdtab.fifo_fork_lock (false);
 
   /* Remember to de-allocate the fd table. */
   if (hchild)
diff --git a/winsup/cygwin/local_includes/dtable.h b/winsup/cygwin/local_includes/dtable.h
index 89c776c2d..93ae4fa40 100644
--- a/winsup/cygwin/local_includes/dtable.h
+++ b/winsup/cygwin/local_includes/dtable.h
@@ -99,6 +99,7 @@ public:
   void delete_archetype (fhandler_base *);
   void fixup_before_exec (DWORD win_proc_id);
   void fixup_before_fork (DWORD win_proc_id);
+  void fifo_fork_lock (bool);
   void lock () {lock_process::locker.acquire ();}
   void unlock () {lock_process::locker.release ();}
   inline void reserve (int fd) { fds.reserve (fd); }
diff --git a/winsup/cygwin/local_includes/fhandler.h b/winsup/cygwin/local_includes/fhandler.h
index b7341f277..24cbcad28 100644
--- a/winsup/cygwin/local_includes/fhandler.h
+++ b/winsup/cygwin/local_includes/fhandler.h
@@ -1490,6 +1490,12 @@ public:
   DWORD fifo_reader_thread_func ();
   void fifo_client_lock () { _fifo_client_lock.lock (); }
   void fifo_client_unlock () { _fifo_client_lock.unlock (); }
+  /* Held by fork until the child has copied fc_handler. */
+  void fork_lock (bool lock_it)
+  {
+    if (reader)
+      lock_it ? fifo_client_lock () : fifo_client_unlock ();
+  }
   void record_connection (fifo_client_handler&, bool = true,
 			  fifo_client_connect_state = fc_connected);
 
-- 
cygwingitgadget

