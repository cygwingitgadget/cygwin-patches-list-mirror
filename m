Return-Path: <cygwin-patches-return-9901-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 75446 invoked by alias); 5 Jan 2020 13:26:26 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 75434 invoked by uid 89); 5 Jan 2020 13:26:26 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-19.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=hang, HContent-Transfer-Encoding:8bit
X-HELO: conuserg-05.nifty.com
Received: from conuserg-05.nifty.com (HELO conuserg-05.nifty.com) (210.131.2.72) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 05 Jan 2020 13:26:24 +0000
Received: from localhost.localdomain (ntsitm247158.sitm.nt.ngn.ppp.infoweb.ne.jp [124.27.253.158]) (authenticated)	by conuserg-05.nifty.com with ESMTP id 005DQ3Rm030236;	Sun, 5 Jan 2020 22:26:09 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-05.nifty.com 005DQ3Rm030236
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1578230769;	bh=Qyyj+nnMyNjpnGuHinwwiGkCDvILtI7M6NHilKnf67k=;	h=From:To:Cc:Subject:Date:From;	b=UG03TepbbV4yZwIgYov+W8+2GM8ujErqw6eLI4qjKMOAYU0Tz+a74nRQx1S1z+0UC	 iwmJOs1zFFeCdJic4krZ21wO5y0+yqwvX85MaCSwef2OSEH95IE3vDiRWZC5Tx4ZPX	 CtpDg0OKNVqBubu7whNsPG20Q8/227FeW9gMvBvt6crTs1xllX/qA7ExTiuGAnddiJ	 SwVK+RU+ph/lguflGsZyzQLuSa32Zfb90JwM1eN4TPkDLDxahqnpf2f37fX6Ne27Ko	 KjNyNDFawiyyX+zb6CyapMJzKswgpgHbiTDvMn9B1PTHQ6rSXzo6anZEvGHjAlS1vE	 YoIw+rQV5E1vw==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: console: Make suspending process work properly.
Date: Sun, 05 Jan 2020 13:26:00 -0000
Message-Id: <20200105132555.925-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00007.txt

- After commit f4b47827cf87f055687a0c52a3485d42b3e2b941, suspending
  process by Ctrl-Z does not work in console and results in hang up.
  This patch fixes the issue.
---
 winsup/cygwin/fhandler_console.cc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index 78f42999c..33ff8371f 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -853,7 +853,9 @@ fhandler_console::process_input_message (void)
       if (toadd)
 	{
 	  ssize_t ret;
+	  release_input_mutex ();
 	  line_edit_status res = line_edit (toadd, nread, *ti, &ret);
+	  acquire_input_mutex (INFINITE);
 	  if (res == line_edit_signalled)
 	    {
 	      stat = input_signalled;
-- 
2.21.0
