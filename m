Return-Path: <SRS0=D3Vj=SD=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [106.153.227.181])
	by sourceware.org (Postfix) with ESMTPS id 4ED0B3858D20
	for <cygwin-patches@cygwin.com>; Fri,  8 Nov 2024 11:43:31 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 4ED0B3858D20
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 4ED0B3858D20
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.181
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1731066222; cv=none;
	b=WDNSmNb5N+4Y8/iaH1AxTrTIQn3yRUVqF8zgCCCObuvp0koHgAA+RLuPBsKX/ssOdZZaQQtbvMiEEJfEGtkw1kD1vaEzKRNbj8Goh5q0mvtQTFELBPhVXjL5GrS2vw/lecIrDJB53gbjJRnorxeK7EyFT0bht92y2XWDk9q+pEM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1731066222; c=relaxed/simple;
	bh=uVh7bLW+QHBTDCTM3Qgj/0nPfV1R5LTI8AMSR/MFc2I=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=Foa3EKI84HnAr3AO4u8L0gJm0CntAH4gyKriLN1ABjanIV5UZNDFoAKh9pJxOCzfwoaIDyBEpnGgGg+7U3Q4+mGf29DHPVNLRWk1UrChlkMqFEPZJ/r2roqFRk1pmtRCgJ4G5SpnLcV/kjuDXUoDzG6Xz0eUOIPvJaiXaTs374g=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from localhost.localdomain by mta-snd-e05.mail.nifty.com
          with ESMTP
          id <20241108114329169.HXVQ.94949.localhost.localdomain@nifty.com>;
          Fri, 8 Nov 2024 20:43:29 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: console: Fix clean up conditions in close()
Date: Fri,  8 Nov 2024 20:43:00 +0900
Message-ID: <20241108114309.1718-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1731066209;
 bh=Yk2LeXwr7x66tt7bNksvhKg/bfyUiZCSY7qN4kkck50=;
 h=From:To:Cc:Subject:Date;
 b=GLFDKiK1VVCslDHN7nWl3roflAC3DEtsFsXWSXTPDchNx2r5ajIEooVE7QXOrlGcrxSJjmBn
 lWia8F/zAv7GSLtsCqQd+ADPF06NLq0yykSLob5ycMmb+6z4pmLcZ3ZCNhTEYHbMi3c9131rHF
 SvPkB65oZPwt7NdTAuzJYvQoZ7AJPV/86WsU2ejhYTh5qioi8WO5/aKgbigyEfakwsG61LHASv
 jfCZ8aoXqJ8zSp/FoJCGs3uvyY30cWv6Z1yt29yPHH1Z+pdTbaTZx8yju1tHkFkSqdbEyHj20p
 WKv31EBa+3cj6aBKw9qWphsBFi0Y53P0eoc+frD8nhLuFQdA==
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Previously, the condition to clean up input/output mode was based
on wrong premise. This patch fixes that.

Fixes: 8ee8b0c974d7 ("Cygwin: console: Use GetCurrentProcessId() instead of myself->dwProcessId")
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/fhandler/console.cc | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
index 4efba61e2..2651e49a6 100644
--- a/winsup/cygwin/fhandler/console.cc
+++ b/winsup/cygwin/fhandler/console.cc
@@ -1976,7 +1976,8 @@ fhandler_console::close ()
 
   acquire_output_mutex (mutex_timeout);
 
-  if (shared_console_info[unit])
+  if (shared_console_info[unit] && !myself->cygstarted
+      && (dev_t) myself->ctty == get_device ())
     {
       /* Restore console mode if this is the last closure. */
       OBJECT_BASIC_INFORMATION obi;
@@ -1984,8 +1985,7 @@ fhandler_console::close ()
       status = NtQueryObject (get_handle (), ObjectBasicInformation,
 			      &obi, sizeof obi, NULL);
       if (NT_SUCCESS (status)
-	  && obi.HandleCount <= (myself->cygstarted ? 2 : 3)
-	  && (dev_t) myself->ctty == get_device ())
+	  && obi.HandleCount == (con.owner == GetCurrentProcessId () ? 2 : 3))
 	{
 	  /* Cleaning-up console mode for cygwin apps. */
 	  set_output_mode (tty::restore, &get_ttyp ()->ti, &handle_set);
-- 
2.45.1

