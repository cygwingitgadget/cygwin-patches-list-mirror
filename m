Return-Path: <cygwin-patches-return-10076-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 83187 invoked by alias); 17 Feb 2020 12:46:58 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 83172 invoked by uid 89); 17 Feb 2020 12:46:57 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-18.0 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HContent-Transfer-Encoding:8bit
X-HELO: conuserg-02.nifty.com
Received: from conuserg-02.nifty.com (HELO conuserg-02.nifty.com) (210.131.2.69) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 17 Feb 2020 12:46:56 +0000
Received: from localhost.localdomain (ntsitm196171.sitm.nt.ngn.ppp.infoweb.ne.jp [125.0.207.171]) (authenticated)	by conuserg-02.nifty.com with ESMTP id 01HCkWiq007728;	Mon, 17 Feb 2020 21:46:46 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-02.nifty.com 01HCkWiq007728
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1581943607;	bh=ILkAMBVN8hgux9JGvnGoRN3iUIqFe8Q8cCZVnBRdW58=;	h=From:To:Cc:Subject:Date:From;	b=VQm2dvBg9fFUj/lP/W0dLdktrWZPZy0ezvnO7RtSzjjoDEtvhcSzLp/P9VbcwWTIr	 msIEAIKy96UkmPp1PsxhuNzmiQzAnpZwP2aqbnxTHUtkgZpixcJUuMgfUKcAZCYXvf	 qwTXeqRcGKsVxMElFaX4foBVQVFzgapUPiFUFpi0TATjQjVk0fk0eAvwezilKliDT3	 KNGJ2s7OTKa4ABHTv/P21/YgaghNCP9t9LPWJzyBd0nCl8YfewtYPLEajliQg12Rix	 UJ/vYicDbXZ5bEiwv3XNKch8qQo1TwHUhL7MCav38RUOGIY6DGuNFhzYsfzup6K7n1	 wzoRlhDT2I5rg==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: console: Fix code for restoring console mode.
Date: Mon, 17 Feb 2020 12:46:00 -0000
Message-Id: <20200217124627.1639-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00182.txt

- Commit 774b8996d1f3e535e8267be4eb8e751d756c2cec has a bug that
  restores console output mode into console input. This patch fixes
  the issue.
---
 winsup/cygwin/fhandler_console.cc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index 2afb5c529..9bfee64d3 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -1122,7 +1122,7 @@ fhandler_console::close ()
 			  &obi, sizeof obi, NULL);
   if (NT_SUCCESS (status) && obi.HandleCount == 1)
     if (orig_conout_mode != (DWORD) -1)
-      SetConsoleMode (get_handle (), orig_conout_mode);
+      SetConsoleMode (get_output_handle (), orig_conout_mode);
 
   release_output_mutex ();
 
-- 
2.21.0
