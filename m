Return-Path: <cygwin-patches-return-9595-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 78866 invoked by alias); 4 Sep 2019 01:45:24 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 78756 invoked by uid 89); 4 Sep 2019 01:45:24 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-18.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HContent-Transfer-Encoding:8bit
X-HELO: conuserg-05.nifty.com
Received: from conuserg-05.nifty.com (HELO conuserg-05.nifty.com) (210.131.2.72) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 04 Sep 2019 01:45:23 +0000
Received: from localhost.localdomain (ntsitm268057.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.110.57]) (authenticated)	by conuserg-05.nifty.com with ESMTP id x841iibF012450;	Wed, 4 Sep 2019 10:45:15 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-05.nifty.com x841iibF012450
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1567561515;	bh=wvKEzsdfzh203PDg7gzcdzaDTSqOUSD13ChxJsXxO3s=;	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;	b=WXq6FKzFvXJTu3t41rlnl794kRyqrdibgIG9/SYtMFDEDQJqgS2Ble1e/Rhy0eIOI	 DVWMAIR9TPFr9w2A8rOq9S+CmtDaesMTkfhuSbqLNXEJOZzCa1Y37ubC7wFXqUMYDn	 nuOw0AgjZUBJatjCTIz1Nsnd46AdIj1Wv8YW5+jUtizm2tWfjdBfiBMi2V9NeoWxWG	 kVEyqdq+DNQ9kGq8pILsjkRHTrBpqimXle3NwIR3eyPlH5faFW1qvo1pibwV9Zwo5i	 dkas2Z5XC+5HQrHJIGcmqWfLdCACMyIDeyLEe5PS6P40UKPnp1z2dH2xiVVXZnkcC5	 hHRCA0AA8T1jA==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 2/4] Cygwin: pty: Speed up a little hooked Win32 API for pseudo console.
Date: Wed, 04 Sep 2019 01:45:00 -0000
Message-Id: <20190904014426.1284-3-takashi.yano@nifty.ne.jp>
In-Reply-To: <20190904014426.1284-1-takashi.yano@nifty.ne.jp>
References: <20190904014426.1284-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00115.txt.bz2

- Some Win32 APIs are hooked in pty code for pseudo console support.
  This causes slow down. This patch improves speed a little.
---
 winsup/cygwin/fhandler_tty.cc | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 4dbe96b4a..94ef2f8d4 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -155,7 +155,9 @@ DEF_HOOK (PeekConsoleInputW);
 #define CHK_CONSOLE_ACCESS(h) \
 { \
   DWORD dummy; \
-  if (!isHybrid && GetConsoleMode (h, &dummy)) \
+  if (!isHybrid \
+      && GetFileType (h) == FILE_TYPE_CHAR \
+      && GetConsoleMode (h, &dummy)) \
     { \
       isHybrid = true; \
       set_switch_to_pcon (); \
-- 
2.21.0
