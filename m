Return-Path: <cygwin-patches-return-9757-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 78215 invoked by alias); 16 Oct 2019 12:34:36 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 78105 invoked by uid 89); 16 Oct 2019 12:34:36 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-20.0 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*Ad:D*jp, HContent-Transfer-Encoding:8bit
X-HELO: conuserg-02.nifty.com
Received: from conuserg-02.nifty.com (HELO conuserg-02.nifty.com) (210.131.2.69) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 16 Oct 2019 12:34:35 +0000
Received: from localhost.localdomain (ntsitm283243.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.151.243]) (authenticated)	by conuserg-02.nifty.com with ESMTP id x9GCYLi0017325;	Wed, 16 Oct 2019 21:34:28 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-02.nifty.com x9GCYLi0017325
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1571229268;	bh=D3bptOmK57LoGDHQWiw1YFkBFXOaYUDcVxziuIGakKI=;	h=From:To:Cc:Subject:Date:From;	b=SJY58WxcuPiSEDXWVME9fkXI5uo3rjzM9+e/GKlqgCyqj+0NCrkFZy6g4MWLjxFfp	 IJUBKIN3JheendsFSGVQUVnLIfmLlnQyGCKWpMEpEm3/GG5ILzcJJfOyxAXI1clq8n	 CCAHdB/6r0iPzgsxtLV/E31TX8cFmdEp3MbHZrrpcavwfTuSJoAWrOriG9+BrBbR6g	 4GZI+AMmtb+qApY6DfFNCUTgepl6kInEIq1IKXYEdwbHvu2PpR/f3YmHyj1ReHtWCy	 YQ0AXKPxHWPVAMpTAeLmJ0pMtDR2vn6CkG2kDhhPFwI8DCfJrWPb9U6GPxSdTOpdNm	 NQx3bVu0b+QCA==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: pty: Avoid detach console in the process running as service.
Date: Wed, 16 Oct 2019 12:34:00 -0000
Message-Id: <20191016123409.457-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q4/txt/msg00028.txt.bz2

---
 winsup/cygwin/fhandler_tty.cc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index baf3c9794..da6119dfb 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -1048,6 +1048,8 @@ fhandler_pty_slave::try_reattach_pcon (void)
 
   /* Do not detach from the console because re-attaching will
      fail if helper process is running as service account. */
+  if (get_ttyp()->attach_pcon_in_fork)
+    return false;
   if (pcon_attached_to >= 0 &&
       cygwin_shared->tty[pcon_attached_to]->attach_pcon_in_fork)
     return false;
-- 
2.21.0
