Return-Path: <SRS0=C8bn=OI=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e02.mail.nifty.com (mta-snd-e02.mail.nifty.com [106.153.226.34])
	by sourceware.org (Postfix) with ESMTPS id EE15D3864C65
	for <cygwin-patches@cygwin.com>; Mon,  8 Jul 2024 14:31:51 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org EE15D3864C65
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org EE15D3864C65
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.34
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1720449113; cv=none;
	b=w9vl463U2dL83LqhyWN5E6vpUWR1q/GrJnKZ8o79GihnWzZntb8bxGl7sGMBlwgtykp/YnMojonKO5uDY+EbVFDK171JIx1F/eDFoDEUUOLSG3qJ8qZ6Obpy2mUhBO8n7ew70OOs+VRq1dy9QQylyHfdIFZ1d9jCurrqqfLW42Y=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1720449113; c=relaxed/simple;
	bh=o3UIRvIyH1t87jSwakN2Ms7hwBf1tUHHXELeiZm0iyo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=DFRgrkzGoH9atdnzQMTCqpnsGnVrsPZBbzydFFI4sDuZqMdz+sjVEIjCEexsIEMPRPLfjzIdToyHcG0v0tHAEyMslEub9Dnch+eCsNZkBofV9U3+O1yI2H5YNah67Uel8J0Ilw/mn6KycSQQbQjbx2ULfvxou8Z+tWIvhkaIsmw=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from localhost.localdomain by mta-snd-e02.mail.nifty.com
          with ESMTP
          id <20240708143150211.IJJH.44461.localhost.localdomain@nifty.com>;
          Mon, 8 Jul 2024 23:31:50 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: console: Fix for GNU screen/tmux in ConEmu
Date: Mon,  8 Jul 2024 23:31:18 +0900
Message-ID: <20240708143127.1921-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1720449110;
 bh=nOvSGhOi25KpqAxlU+oU4GTmYZBA7CD5qhkTWVddgio=;
 h=From:To:Cc:Subject:Date;
 b=jB0tSYqFE5NuiDBekzLjr7xBza76XQOCkMr86Tni8MkHYT974lryu+gRGx11lHi1eOBgYItn
 XwGmFl1lhlFKH/EtkRgN2pRcdrQlstKlPOrT8nbjx1hTrJePAQKP1DKZuZwh2LoYEmMKAypCvK
 IQVS6UWvq++nqFweqXs/2m+L1gTank1UGlpoLofHn9eZabf1ILLsXY9pnMXBmquZIsJvI8MpcO
 dTjpzPkcB42gczXWKNjtWJMcOiRh/Eqdprjei8+n3vjk4GAjQ4mQKK4xuRwncX+biNppvaA+G1
 DeAch7WpKKl5nk2CSpO51fG19c+5WEtoxL5YxSZImHHe05VQ==
X-Spam-Status: No, score=-10.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

If the master process of GNU screen or tmux is started in ConEmu
and ConEmu is closed, reataching to the GNU screen/tmux in another
console will not work correctly. This is because the ConEmu master
process was already closed even though some console APIs are hooked
by ConEmuHk64.dll to communicate with ConEmu master process. With
this patch, to make them unhooked, DllMain() of ConEmuHk64.dll is
called with DLL_PROCESS_DETACH.

Fixes: 3721a756b0d8 ("Cygwin: console: Make the console accessible from other terminals.")
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/fhandler/console.cc | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
index 8c08a8af8..d4c3f1020 100644
--- a/winsup/cygwin/fhandler/console.cc
+++ b/winsup/cygwin/fhandler/console.cc
@@ -33,6 +33,7 @@ details. */
 #include "child_info.h"
 #include "cygwait.h"
 #include "winf.h"
+#include "psapi.h"
 
 /* Don't make this bigger than NT_MAX_PATH as long as the temporary buffer
    is allocated using tmp_pathbuf!!! */
@@ -1970,7 +1971,23 @@ fhandler_console::close ()
   if (!have_execed && !invisible_console
       && (!CTTY_IS_VALID (myself->ctty)
 	  || get_device () == (dev_t) myself->ctty))
-    free_console ();
+    {
+      /* ConEmu hack. Detach from ConEmu to unhook console APIs. */
+      HMODULE h = GetModuleHandle ("ConEmuHk64.dll");
+      if (h)
+	{
+	  MODULEINFO mi;
+	  if (GetModuleInformation (GetCurrentProcess (), h, &mi, sizeof (mi)))
+	    {
+	      BOOL (*DllMain)(HINSTANCE, DWORD, LPVOID) =
+		(BOOL (*)(HINSTANCE, DWORD, LPVOID)) mi.EntryPoint;
+	      DllMain (h, DLL_PROCESS_DETACH, NULL);
+	    }
+	}
+
+      /* Freeing console to detach the process from the console. */
+      free_console ();
+    }
 
   release_output_mutex ();
 
-- 
2.45.1

