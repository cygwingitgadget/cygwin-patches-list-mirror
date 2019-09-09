Return-Path: <cygwin-patches-return-9665-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 66153 invoked by alias); 9 Sep 2019 12:08:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 66138 invoked by uid 89); 9 Sep 2019 12:08:45 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-19.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HContent-Transfer-Encoding:8bit
X-HELO: conuserg-03.nifty.com
Received: from conuserg-03.nifty.com (HELO conuserg-03.nifty.com) (210.131.2.70) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 09 Sep 2019 12:08:43 +0000
Received: from localhost.localdomain (ntsitm268057.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.110.57]) (authenticated)	by conuserg-03.nifty.com with ESMTP id x89C8Piu021844;	Mon, 9 Sep 2019 21:08:32 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-03.nifty.com x89C8Piu021844
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1568030912;	bh=F84ZZ1iAyJ4+Ibzmhi85pwmQov/fLoCHtzKherpVooo=;	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;	b=GPUFuPRLOhVaGynTuCICxAMT3MgiskLSwoQYXI4O3Wwgh4reoVQRS4BmYmYJbBlL8	 rUxDomtp+ugsOX4Kbai+RSn8kNq29ljvarxRIF41Ac+nhof5irKGB5/QOW5w8tDV7q	 MEh/B8PzCd62ybUaYCPqJZyzch1ZupypP2eksg5e6eTtHGhWtJKInYYovdI8NuVSwU	 MovuXJea1fhr6pjymvAfq8dchffXOeBzf9hom5jydyLwW8CKGQCCTn5jxNBe3+ZZpK	 lHtgpbno8XUo4ZRbZETAjOVFem43iOHlmdCAo3HC2M8bS1yByUdjBJ3Qdf7xGPQWPO	 e/AgNnvx/9gcQ==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 1/1] Cygwin: pty: Prevent the helper process from exiting by Ctrl-C.
Date: Mon, 09 Sep 2019 12:08:00 -0000
Message-Id: <20190909120820.201-2-takashi.yano@nifty.ne.jp>
In-Reply-To: <20190909120820.201-1-takashi.yano@nifty.ne.jp>
References: <20190909120820.201-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00185.txt.bz2

---
 winsup/utils/cygwin-console-helper.cc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/winsup/utils/cygwin-console-helper.cc b/winsup/utils/cygwin-console-helper.cc
index ad451ecf5..66004bd15 100644
--- a/winsup/utils/cygwin-console-helper.cc
+++ b/winsup/utils/cygwin-console-helper.cc
@@ -10,6 +10,7 @@ main (int argc, char **argv)
   SetEvent (h);
   if (argc == 4) /* Pseudo console helper mode for PTY */
     {
+      SetConsoleCtrlHandler (NULL, TRUE);
       HANDLE hPipe = (HANDLE) strtoull (argv[3], &end, 0);
       char buf[64];
       sprintf (buf, "StdHandles=%p,%p\n",
-- 
2.21.0
