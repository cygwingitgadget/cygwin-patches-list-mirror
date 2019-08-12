Return-Path: <cygwin-patches-return-9561-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 56981 invoked by alias); 12 Aug 2019 13:49:04 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 56938 invoked by uid 89); 12 Aug 2019 13:49:04 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-20.7 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HX-Languages-Length:925, screen, HContent-Transfer-Encoding:8bit
X-HELO: conuserg-05.nifty.com
Received: from conuserg-05.nifty.com (HELO conuserg-05.nifty.com) (210.131.2.72) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 12 Aug 2019 13:49:02 +0000
Received: from localhost.localdomain (ntsitm268057.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.110.57]) (authenticated)	by conuserg-05.nifty.com with ESMTP id x7CDmj22022710;	Mon, 12 Aug 2019 22:48:53 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-05.nifty.com x7CDmj22022710
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1565617733;	bh=lsM1v/0RRHyfow4lXXbUI3qcK+vgwASrsn59gz5SXUw=;	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;	b=Vz4JdcKRwz2/mgt7SaQ9gQS3cVqYfu2yQBf5nuSndqoNV0nAtzvPu8z1JjFYbPigH	 R5OPeKPwEPIUCCYMAIA2OBc6yCvCIXJ1uoxpMZfQgKStA1UW43jtbsTByL+HA20xmW	 U1VODCbkjLE6yJjzV/Ccjdn1oGTTX8+TIa8QEeIXVTv8eoRLH392pp//1fsizDIB5t	 hp75BKb6P4dmHp8mGZ4arrTkkTj3H/qZOoTrl7yXLQ48ELYbsktCwTrIfx6czwNVu6	 bZFDmiJdaxVYTW4DSqvrnmu/Uq2tW0LwoMhvWjEZxx/Z0Lp1WKkZDoq1aI+Gqy7vxz	 3rQehG8XXASbg==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 1/1] Cygwin: console: Fix cursor position restore after screen alternation.
Date: Mon, 12 Aug 2019 13:49:00 -0000
Message-Id: <20190812134845.2249-2-takashi.yano@nifty.ne.jp>
In-Reply-To: <20190812134845.2249-1-takashi.yano@nifty.ne.jp>
References: <20190812134845.2249-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00082.txt.bz2

- If screen is alternated on console, cursor position is not restored
  correctly in the case of xterm compatible mode is enabled. For example,
  the shell prompt is shown at incorrect position after using vim.
  This patch fixes this problem.
---
 winsup/cygwin/fhandler_console.cc | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index e3656a33a..075593523 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -304,6 +304,9 @@ void
 fhandler_console::set_cursor_maybe ()
 {
   con.fillin (get_output_handle ());
+  /* Nothing to do for xterm compatible mode. */
+  if (wincap.has_con_24bit_colors ())
+    return;
   if (con.dwLastCursorPosition.X != con.b.dwCursorPosition.X ||
       con.dwLastCursorPosition.Y != con.b.dwCursorPosition.Y)
     {
-- 
2.21.0
