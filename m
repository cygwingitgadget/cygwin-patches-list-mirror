Return-Path: <cygwin-patches-return-10101-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 77527 invoked by alias); 21 Feb 2020 19:10:32 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 77507 invoked by uid 89); 21 Feb 2020 19:10:31 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-18.1 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HX-Languages-Length:1823, H*MI:1027, HContent-Transfer-Encoding:8bit
X-HELO: conuserg-04.nifty.com
Received: from conuserg-04.nifty.com (HELO conuserg-04.nifty.com) (210.131.2.71) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 21 Feb 2020 19:10:29 +0000
Received: from localhost.localdomain (ntsitm196171.sitm.nt.ngn.ppp.infoweb.ne.jp [125.0.207.171]) (authenticated)	by conuserg-04.nifty.com with ESMTP id 01LJA4Ep006137;	Sat, 22 Feb 2020 04:10:10 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-04.nifty.com 01LJA4Ep006137
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1582312210;	bh=JaYDmsB2/t5mkDDcAi3gVWsY8/Ml5FYQnI6n1t8R7Uo=;	h=From:To:Cc:Subject:Date:From;	b=NrZH+ytPJHNln0pVjx452Bk+MCqn8323E6RJB02k93Yp/FejsLnq/h87zXZtFu4TA	 Tk+a4hhFXYCpPi3ys2XbwNhLUykuRuH+4CotNQC7jgV099GSJXK0jI6z7MMy3DZL3x	 93ArcmUJ6rzRkDgnt+XB0VXYPbifO6ZX1UsKDgyiO7hn1WOUO/q4Qses8ft1aRUldn	 GI1MnldSEyD87fiEe1cAYTIBVpJenYpDsFwRm3KltT8zjbVc9Job51vJXcEZ+inc89	 z0cwAm5l08F0/dYfpizIj78KCsBCsg3mrWo3Lsk48ERdKlIfnwEppZf+0QvhJdC0/7	 BjJt6B07NccmQ==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: console: Fix segfault on shared_console_info access.
Date: Fri, 21 Feb 2020 19:10:00 -0000
Message-Id: <20200221191000.1027-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00207.txt

- Accessing shared_console_info accidentaly causes segmentation
  fault when it is a NULL pointer. The cause of the problem reported
  in https://cygwin.com/ml/cygwin/2020-02/msg00197.html is this NULL
  pointer access in request_xterm_mode_output(). This patch fixes
  the issue.
---
 winsup/cygwin/fhandler_console.cc | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index 42040a971..e298dd60c 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -256,7 +256,8 @@ fhandler_console::request_xterm_mode_input (bool req)
     return;
   if (req)
     {
-      if (InterlockedIncrement (&con.xterm_mode_input) == 1)
+      if (!shared_console_info ||
+	  InterlockedIncrement (&con.xterm_mode_input) == 1)
 	{
 	  DWORD dwMode;
 	  GetConsoleMode (get_handle (), &dwMode);
@@ -266,7 +267,8 @@ fhandler_console::request_xterm_mode_input (bool req)
     }
   else
     {
-      if (InterlockedDecrement (&con.xterm_mode_input) == 0)
+      if (!shared_console_info ||
+	  InterlockedDecrement (&con.xterm_mode_input) == 0)
 	{
 	  DWORD dwMode;
 	  GetConsoleMode (get_handle (), &dwMode);
@@ -283,7 +285,8 @@ fhandler_console::request_xterm_mode_output (bool req)
     return;
   if (req)
     {
-      if (InterlockedExchange (&con.xterm_mode_output, 1) == 0)
+      if (!shared_console_info ||
+	  InterlockedExchange (&con.xterm_mode_output, 1) == 0)
 	{
 	  DWORD dwMode;
 	  GetConsoleMode (get_output_handle (), &dwMode);
@@ -293,7 +296,8 @@ fhandler_console::request_xterm_mode_output (bool req)
     }
   else
     {
-      if (InterlockedExchange (&con.xterm_mode_output, 0) == 1)
+      if (!shared_console_info ||
+	  InterlockedExchange (&con.xterm_mode_output, 0) == 1)
 	{
 	  DWORD dwMode;
 	  GetConsoleMode (get_output_handle (), &dwMode);
-- 
2.21.0
