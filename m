Return-Path: <SRS0=vCDf=52=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w03.mail.nifty.com (mta-snd-w03.mail.nifty.com [106.153.227.35])
	by sourceware.org (Postfix) with ESMTPS id 259BC3857359
	for <cygwin-patches@cygwin.com>; Tue, 18 Nov 2025 14:10:00 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 259BC3857359
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 259BC3857359
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.35
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1763475001; cv=none;
	b=xfqmbTea4jDSLSu4Tkkd1GnzxABJB99dBdZ3mlT8J8fp6tYcm/rH5rCMvfMFEpmkVR+yRrnef3NKwWdhmevTbMuv7j1eju7K/Sl809vHt2tTbG6QJvGAg3BFFWzxzby3CpC+tkWnrguzmhxWxNjyTd7ERRqBzg0w3ubOpbnYo7U=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1763475001; c=relaxed/simple;
	bh=9WhW9Fj02ufHQO1AERMBV0oM99G9BKTquT0eZT+hAB0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=XQevaASghk5tHucQLimSp6oZ94H0why6fTD+S3KpquSmNZeiDToH7zgJlS6E8YhHz/Dv19Qe77sH5LU/dz5UPqOyvC8P4pCwWgRjVB0px3xda2l5gIam8g8bG3q3dbkbUpgtWZZ66U/eMRlCchwoKjQi4dY7yIk5cFrBSj3X0oY=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 259BC3857359
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=NLDs4HWb
Received: from HP-Z230 by mta-snd-w03.mail.nifty.com with ESMTP
          id <20251118140959452.WNYK.47226.HP-Z230@nifty.com>;
          Tue, 18 Nov 2025 23:09:59 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Thomas Huth <th.huth@posteo.eu>,
	Mark Geisert <mark@maxrnd.com>
Subject: [PATCH v2 1/2] Cygwin: dll_init: Call __cxa_finalize() for DLL_LOAD even in exit_state
Date: Tue, 18 Nov 2025 23:09:34 +0900
Message-ID: <20251118140943.7357-2-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251118140943.7357-1-takashi.yano@nifty.ne.jp>
References: <20251118140943.7357-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1763474999;
 bh=791Xtao9QMR3PmlsgtcxW5J9KhqAqhdlGw8tqK0gl8I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=NLDs4HWbF6C5u9hIyXZrGisZk6ki6oGX3n16TTskUUwYxZDZrEd17n1Y9ieaBmJDPsDAkVgq
 ixi9nwQ6XoW6k5rr0Ei+ZsJy/LEagmqntFNr0jzmajWkpfqjNpxbd+x52xt6KY39WYC7kdZXcg
 gRUBvcWrgb6buYEeRaw1JJk5uK6TOxf9ZK35QX8rfutWQGo+zuh9CHfFKQcv1HTamMeInYzOjZ
 03BwSZJrUi7Jtvl1Mtj+Lq4kyZBURRuPdDyrhZZ/noDZXO7jrhdZBRYuSbZhfMBdkI58WmwqvI
 WZ249PSMWgRXJ1qRmSpAYl+qb99ZT9M5n9f0QcYcPQxBjSTQ==
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

If dlclose() for DLL A is called in the destructor of DLL B which
linked with the main program, __cxa_finalize() should be called even
in exit_state. This is because if the destructor of DLL B is called
in exit_state, DLL A will be unloaded by dlclose().
Thereofre, if __cxa_finalize()is not called here, the destructor of
DLL A will be called in exit() even though DLL A is already unloaded.
This causes crash at exit(). In the case above, __cxa_finalize()
should be called before unloading DLL A even in exit_state.

Addresses: https://cygwin.com/pipermail/cygwin/2025-October/258877.html
Fixes: c019a66c32f8 ("* dll_init.cc (dll_list::detach) ... Don't call __cxa_finalize in exiting case.")
Reported-by: Thomas Huth <th.huth@posteo.eu>
Reviewed-by: Mark Geisert <mark@maxrnd.com>, Jon Turney <jon.turney@dronecode.org.uk>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/dll_init.cc | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/dll_init.cc b/winsup/cygwin/dll_init.cc
index 1369165c9..5ef0fa875 100644
--- a/winsup/cygwin/dll_init.cc
+++ b/winsup/cygwin/dll_init.cc
@@ -584,7 +584,10 @@ dll_list::detach (void *retaddr)
 	  /* Ensure our exception handler is enabled for destructors */
 	  exception protect;
 	  /* Call finalize function if we are not already exiting */
-	  if (!exit_state)
+	  /* We always call the finalize function for a dlopen()'ed DLL
+        because its destructor may crash if invoked during exit()
+        after dlclose(). */
+	  if (!exit_state || d->type == DLL_LOAD)
 	    __cxa_finalize (d->handle);
 	  d->run_dtors ();
 	}
-- 
2.51.0

