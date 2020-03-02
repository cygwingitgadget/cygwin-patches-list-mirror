Return-Path: <cygwin-patches-return-10155-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 53617 invoked by alias); 2 Mar 2020 01:14:17 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 53608 invoked by uid 89); 2 Mar 2020 01:14:17 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-18.8 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HX-Languages-Length:1704, HContent-Transfer-Encoding:8bit
X-HELO: conuserg-05.nifty.com
Received: from conuserg-05.nifty.com (HELO conuserg-05.nifty.com) (210.131.2.72) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 02 Mar 2020 01:14:16 +0000
Received: from localhost.localdomain (ntsitm196171.sitm.nt.ngn.ppp.infoweb.ne.jp [125.0.207.171]) (authenticated)	by conuserg-05.nifty.com with ESMTP id 0221D5nQ031112;	Mon, 2 Mar 2020 10:14:12 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-05.nifty.com 0221D5nQ031112
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1583111652;	bh=PBHzOmmGu75PA7Fiuk2vIAuj+ngBTl0/hnFsvwjhMXc=;	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;	b=fPLeirTkErCwaSyuSRwtSft1GisHdqve3gHLqyj0Lbiw+gwKWKRcV6a682mlzVB0F	 7luI2jwVkLGZ0DAze4WeKfA7/NYCsXf12EZngOCrgLjKnCeC/aFUMXzlEhWCutoUqo	 XE8WXNr/aUwinucM0O9saYnSpNGa+a4spz2IL9oInq2VL5IAg3bxvvZdQTzO578zux	 Jc86R10Bw0HZFM2wQ3bdS683ll4fiv1sIuKJIHp79P/B1a2VUkNI5Uzmh3vgEz5nEn	 NPPj6nj8SxFt4SHvt9O+sgPHg+UfZm/wjN/Hf+sCZ3l4SPbmEu0DBY5+KjswerZkDd	 F/3j3rSpRPIyA==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 2/4] Cygwin: console: Fix setting/unsetting xterm mode for input.
Date: Mon, 02 Mar 2020 01:14:00 -0000
Message-Id: <20200302011258.592-3-takashi.yano@nifty.ne.jp>
In-Reply-To: <20200302011258.592-1-takashi.yano@nifty.ne.jp>
References: <20200302011258.592-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00261.txt

- This patch fixes the issue that xterm compatible mode for input
  is not correctly set/unset in some situation such as:
   1) cat is stopped by ctrl-c.
   2) The window size is changed in less.
  In case 1), request_xterm_mode_input(true) is called in read(),
  however, cat is stopped without request_xterm_mode_input(false).
  In case 2), less uses longjmp in signal handler, therefore,
  corresponding request_xterm_mode_input(false) is not called if
  the SIGWINCH signal is sent within read(). With this patch,
  InterlockedExchange() is used instead of InterlockedIncrement/
  Decrement().
---
 winsup/cygwin/fhandler_console.cc | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index 7c97a7868..9c5b80181 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -267,7 +267,7 @@ fhandler_console::request_xterm_mode_input (bool req)
     return;
   if (req)
     {
-      if (InterlockedIncrement (&con.xterm_mode_input) == 1)
+      if (InterlockedExchange (&con.xterm_mode_input, 1) == 0)
 	{
 	  DWORD dwMode;
 	  GetConsoleMode (get_handle (), &dwMode);
@@ -277,7 +277,7 @@ fhandler_console::request_xterm_mode_input (bool req)
     }
   else
     {
-      if (InterlockedDecrement (&con.xterm_mode_input) == 0)
+      if (InterlockedExchange (&con.xterm_mode_input, 0) == 1)
 	{
 	  DWORD dwMode;
 	  GetConsoleMode (get_handle (), &dwMode);
@@ -1171,6 +1171,7 @@ fhandler_console::close ()
       if ((NT_SUCCESS (status) && obi.HandleCount == 1)
 	  || myself->pid == con.owner)
 	request_xterm_mode_output (false);
+      request_xterm_mode_input (false);
     }
 
   release_output_mutex ();
-- 
2.21.0
