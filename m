Return-Path: <SRS0=zjkU=SY=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w09.mail.nifty.com (mta-snd-w09.mail.nifty.com [106.153.227.41])
	by sourceware.org (Postfix) with ESMTPS id A35A73858D35
	for <cygwin-patches@cygwin.com>; Fri, 29 Nov 2024 12:00:23 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org A35A73858D35
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org A35A73858D35
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.41
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1732881624; cv=none;
	b=OJZGUSw6nnABFrqbvbp0i7warnGzLv3nuYt/D+PsvFU7GQhzKkJEoTkTgFoAXouQUWTw5BI/yZsz0s8IX0DPFvQK726QQMX33zS4009DR43NQ0om4CPD61aVdG1EeD8Vb0/BJJ+P36FXX2PoQ2HxxZ8/unSSV4pQH8pqhnJGxmA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1732881624; c=relaxed/simple;
	bh=2ABM0NrtYEhj7yx241Tqh+YG5PVPfaiGITZ6aTne+TY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=ACTWhL3/0if8vQsy+zPH651cfB82hrhyGprqWJGyKCcT7xA/ZJQhslk9O+HjK+cOOIEkbFkq6yje6ce8gNjAnjuK9fEN6W0PZbpTa0OalgIHYwErL8jbUTN6m5950tA4JwD9zaKjXcHiacQVxu08rxSwVRRfwkuMUfPRtZ6YwKM=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A35A73858D35
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=VKX46jqN
Received: from localhost.localdomain by mta-snd-w09.mail.nifty.com
          with ESMTP
          id <20241129120022040.ZBJR.90249.localhost.localdomain@nifty.com>;
          Fri, 29 Nov 2024 21:00:22 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Christian Franke <Christian.Franke@t-online.de>,
	Corinna Vinschen <corinna@vinschen.de>
Subject: [PATCH v3 4/9] Cygwin: signal: Optimize the priority of the sig thread
Date: Fri, 29 Nov 2024 20:59:53 +0900
Message-ID: <20241129120007.14516-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1732881622;
 bh=dQor5vp7Z4cRu3TEsESgawDCrxtxXcuSGveE7jTzF9Q=;
 h=From:To:Cc:Subject:Date;
 b=VKX46jqN1BNXOLy1Eu6CERaD5OprfqQL9xb0/mbDw5Q4y6dbaOQ8uFMUG8QC/Kh50rdNDQbu
 hl9oYKl+o5D2IskBj0moJsq6WHwVg4YSdGFV/MYPoeETmfVdRg7Rg1Krw4XsRM2qAxYuQ6urEc
 DGK4+asarXdzPLnwt2Svlo7NMdh7VbbvCHuJNda3IfjKPjj+eJUgEP2M4z306C/PcteP4+eMVX
 8sG1E7pLwKCzysLrOf0R8I6y/KixG+UJSXcVC5bKlNs2K/pKQaSpruh7w9/W7/4C0YDgNUt+0o
 yJEW+b3HfOxjLjSIWEPkEFNBRkfFhOkGZVurSSfgi8Fam5pA==
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Previously, the sig thread ran in THREAD_PRIORITY_HIGHEST priority.
This causes a critical delay in the signal handling in the main
thread if too many signals are received rapidly and the CPU is very
busy. In this case, most of the CPU time is allocated to the sig
thread, so the main thread cannot have a chance of handling signals.
With this patch, to avoid such a situation, the priority of the sig
thread is set to THREAD_PRIORITY_NORMAL priority. Furthermore, if
the signal is alerted to the main thread, but the main thread does
not handle it yet, to increase the chance of handling it in the main
thread, reduce the sig thread priority to THREAD_PRIORITY_LOWEST
priority temporarily before calling _cygtls::handle_SIGCONT().

Addresses: https://cygwin.com/pipermail/cygwin/2024-November/256744.html
Fixes: 53ad6f1394aa ("(cygthread::cygthread): Use three only arguments for detached threads, and start the thread via QueueUserAPC/async_create.")
Reported-by: Christian Franke <Christian.Franke@t-online.de>
Reviewed-by: Corinna Vinschen <corinna@vinschen.de>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/exceptions.cc | 6 ++++++
 winsup/cygwin/sigproc.cc    | 1 +
 2 files changed, 7 insertions(+)

diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
index 0f8c21939..7fc644af1 100644
--- a/winsup/cygwin/exceptions.cc
+++ b/winsup/cygwin/exceptions.cc
@@ -978,6 +978,9 @@ sigpacket::setup_handler (void *handler, struct sigaction& siga, _cygtls *tls)
   CONTEXT cx;
   bool interrupted = false;
 
+  for (int i = 0; i < 100 && tls->current_sig; i++)
+    yield ();
+
   if (tls->current_sig)
     {
       sigproc_printf ("trying to send signal %d but signal %d already armed",
@@ -1482,7 +1485,10 @@ sigpacket::process ()
   if (si.si_signo == SIGCONT)
     {
       tl_entry = cygheap->find_tls (_main_tls);
+      if (_main_tls->current_sig)
+	SetThreadPriority (GetCurrentThread (), THREAD_PRIORITY_LOWEST);
       _main_tls->handle_SIGCONT (tl_entry);
+      SetThreadPriority (GetCurrentThread (), THREAD_PRIORITY_NORMAL);
       cygheap->unlock_tls (tl_entry);
     }
 
diff --git a/winsup/cygwin/sigproc.cc b/winsup/cygwin/sigproc.cc
index 8ffb90a2c..8c788bd20 100644
--- a/winsup/cygwin/sigproc.cc
+++ b/winsup/cygwin/sigproc.cc
@@ -1332,6 +1332,7 @@ wait_sig (VOID *)
 
   hntdll = GetModuleHandle ("ntdll.dll");
 
+  SetThreadPriority (GetCurrentThread (), THREAD_PRIORITY_NORMAL);
   for (;;)
     {
       DWORD nb;
-- 
2.45.1

