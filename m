Return-Path: <cygwin-patches-return-9690-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26195 invoked by alias); 18 Sep 2019 14:28:53 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 25811 invoked by uid 89); 18 Sep 2019 14:28:53 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-19.8 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HDKIM-Filter:v2.10.3, broke, UD:jp, H*Ad:D*jp
X-HELO: conuserg-06.nifty.com
Received: from conuserg-06.nifty.com (HELO conuserg-06.nifty.com) (210.131.2.73) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 18 Sep 2019 14:28:51 +0000
Received: from localhost.localdomain (ntsitm283243.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.151.243]) (authenticated)	by conuserg-06.nifty.com with ESMTP id x8IESUON031738;	Wed, 18 Sep 2019 23:28:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-06.nifty.com x8IESUON031738
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1568816923;	bh=qToXsryRCiXtAPX8FvmoWBSMbwGa/eTtTn+uy2051co=;	h=From:To:Cc:Subject:Date:From;	b=ww1yRYMtntu/1xkCgyRVvUMkV822XShnc2rHaoHWDGHAzwVFX3KRBixaqU3HzqW/N	 tjXb8OagdL/FW3BK2yIBSONYIBw9MxjJIHNmL6ctpQ79Owb1jvrmoLes01qDu7F9o6	 M0y9gXWFtbwzhbf1/p6jq2lpLYCzpqmyqpFff8XqYZ+IZBeGdp2KrDfbEKVskpfZMX	 wzVcSfCfE+0CyPIBQwsYtDlvkMb+FXWqTenhibMcywVzGSiW7hWuR/iCMUqJebIOYw	 VAb48yjW0EyDpAEA1ecLjVcNELuMX4c8IZEJ6gqZCKMKnmcivrRDQde0w6K+jn8lli	 IMB81SeA0JIAA==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: console: Revive Win7 compatibility.
Date: Wed, 18 Sep 2019 14:28:00 -0000
Message-Id: <20190918142831.787-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00210.txt.bz2

- The commit fca4cda7a420d7b15ac217d008527e029d05758e broke Win7
  compatibility. This patch fixes the issue.
---
 winsup/cygwin/fhandler_console.cc | 10 +++++-----
 winsup/cygwin/select.cc           |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index 709b8255d..75143f27a 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -499,8 +499,11 @@ fhandler_console::process_input_message (void)
 
   termios *ti = &(get_ttyp ()->ti);
 
-	  /* Per MSDN, max size of buffer required is below 64K. */
-#define	  INREC_SIZE	(65536 / sizeof (INPUT_RECORD))
+  /* Per MSDN, max size of buffer required is below 64K. */
+  /* (65536 / sizeof (INPUT_RECORD)) is 3276, however,
+     ERROR_NOT_ENOUGH_MEMORY occurs in win7 if this value
+     is used. */
+#define INREC_SIZE 2048
 
   fhandler_console::input_states stat = input_processing;
   DWORD total_read, i;
@@ -1165,9 +1168,6 @@ fhandler_console::ioctl (unsigned int cmd, void *arg)
 	return -1;
       case FIONREAD:
 	{
-	  /* Per MSDN, max size of buffer required is below 64K. */
-#define	  INREC_SIZE	(65536 / sizeof (INPUT_RECORD))
-
 	  DWORD n;
 	  int ret = 0;
 	  INPUT_RECORD inp[INREC_SIZE];
diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
index ed8c98d1c..8fdce06a4 100644
--- a/winsup/cygwin/select.cc
+++ b/winsup/cygwin/select.cc
@@ -1209,7 +1209,7 @@ peek_pty_slave (select_record *s, bool from_select)
 	{
 	  if (ptys->is_line_input ())
 	    {
-#define INREC_SIZE (65536 / sizeof (INPUT_RECORD))
+#define INREC_SIZE 2048
 	      INPUT_RECORD inp[INREC_SIZE];
 	      DWORD n;
 	      PeekConsoleInput (ptys->get_handle (), inp, INREC_SIZE, &n);
-- 
2.21.0
