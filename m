Return-Path: <SRS0=Ftjg=5F=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w05.mail.nifty.com (mta-snd-w05.mail.nifty.com [106.153.227.37])
	by sourceware.org (Postfix) with ESMTPS id 42AD23858C40
	for <cygwin-patches@cygwin.com>; Tue, 28 Oct 2025 11:49:15 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 42AD23858C40
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 42AD23858C40
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1761652155; cv=none;
	b=N/00Rf2cXPbhDAxROdEYigtF5XaSp+mD5D4fbyU+Brue5GMUKUOn1X0kGEOfcDzUQQ9DyjVQHwgFTol3RUS/OUeWD2wOj/sikoRRP7Z2RnFyJtqsRE+3yDC7AxSgKpMMIuKDyJVWZBsb2oEjcLYCnp5j6eCzf8TmJyunMZqJ5/g=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1761652155; c=relaxed/simple;
	bh=ZBAGqbZe7DY4Xk4Z1/MDQiHiES8qFKhtLO/jmrwNc5A=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=ptpkiTtZyKsddXoDJFT8K+MTCY7FMyK2RZTn3UEnadZRWVmrI9ya+bAk6HklOPgMEAtvuEC3mM9P3RnlLBRKYmULRFklVJGBPg9JHOxmP/ti6+14AdhIdf3Da/CHrz9Gc0MKg6Rxe1mpfWFnH0jtHbAvzgMUVmkUTdLDXdqg7B0=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 42AD23858C40
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=HOa74e9p
Received: from HP-Z230 by mta-snd-w05.mail.nifty.com with ESMTP
          id <20251028114913255.WYRU.17135.HP-Z230@nifty.com>;
          Tue, 28 Oct 2025 20:49:13 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Thomas Huth <th.huth@posteo.eu>
Subject: [PATCH 1/2] Cygwin: dll_init: Call __cxa_finalize() for DLL_LOAD even in exit_state
Date: Tue, 28 Oct 2025 20:48:41 +0900
Message-ID: <20251028114853.11052-2-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028114853.11052-1-takashi.yano@nifty.ne.jp>
References: <20251028114853.11052-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1761652153;
 bh=CTCxTqZyhUCaeIV8gidD5JpJv87qR5bN1KwLTMrkDNE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=HOa74e9pGbjEbwlQEfmg7fn97sw1PnjVh/FMVAKcGJm1maB+0LtfYqTAUNabGBQ65hpZ+C02
 hfH3kY3fysKLT5RKoNQiqVy7/4LNgROTphEzpg7JFouTXZrpsQ6aILVIR9jyAm/6PZbcni1CF9
 V4Ti2lHlUYOggJoFVFZGlqQ0lAInwM5dSybr2YGwaOe3TKeteX/FdwlOKVRbeDgNlKdaXYiy7X
 TnlveitcqFx49P9PSEI5ega6JkcMylP5/RT0QW/hOVXMV3ZNN+9k9asARAumIzYhnPiEQYbcTa
 mVhNRQ3Uj6Ffr2lGXIPclzHB2wdk3A2t2L9GYj06UaObT8Wg==
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

If dlclose() for the first DLL is called in the destructor of another
linked DLL, __cxa_finalize() should be called even in exit_state. This
is because if the second destructor is called in exit_state, the first
DLL will be unloaded by dlclose(). Therefore, if __cxa_finalize() is
not called here, the destructor of the first DLL will be called in exit()
even though the first DLL is already unloaded. This causes crash at
exit().  In the case above, __cxa_finalize() should be called before
unloading the first DLL even in exit_state.

Addresses: https://cygwin.com/pipermail/cygwin/2025-October/258877.html
Fixes: c019a66c32f8 ("* dll_init.cc (dll_list::detach) ... Don't call __cxa_finalize in exiting case.")
Reported-by: Thomas Huth <th.huth@posteo.eu>
Reviewed-by:
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/dll_init.cc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/dll_init.cc b/winsup/cygwin/dll_init.cc
index 1369165c9..b6ab4ed11 100644
--- a/winsup/cygwin/dll_init.cc
+++ b/winsup/cygwin/dll_init.cc
@@ -584,7 +584,8 @@ dll_list::detach (void *retaddr)
 	  /* Ensure our exception handler is enabled for destructors */
 	  exception protect;
 	  /* Call finalize function if we are not already exiting */
-	  if (!exit_state)
+	  /* Loaded DLLs need finalize function even in the exiting state */
+	  if (!exit_state || d->type == DLL_LOAD)
 	    __cxa_finalize (d->handle);
 	  d->run_dtors ();
 	}
-- 
2.51.0

