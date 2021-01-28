Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
 by sourceware.org (Postfix) with ESMTPS id 82AFA384B060
 for <cygwin-patches@cygwin.com>; Thu, 28 Jan 2021 12:21:13 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 82AFA384B060
Received: from localhost.localdomain (x067108.dynamic.ppp.asahi-net.or.jp
 [122.249.67.108]) (authenticated)
 by conuserg-11.nifty.com with ESMTP id 10SCKIxw031456;
 Thu, 28 Jan 2021 21:20:45 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 10SCKIxw031456
X-Nifty-SrcIP: [122.249.67.108]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH v2 1/2] Cygwin: console: Make read() thread-safe.
Date: Thu, 28 Jan 2021 21:20:09 +0900
Message-Id: <20210128122010.1424-2-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210128122010.1424-1-takashi.yano@nifty.ne.jp>
References: <20210128122010.1424-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, RCVD_IN_DNSWL_NONE,
 SPF_HELO_NONE, SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Thu, 28 Jan 2021 12:21:15 -0000

- Currently read() is somehow not thread-safe. This patch fixes the
  issue.
---
 winsup/cygwin/fhandler_console.cc | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index 02d0ac052..d0e5bb33a 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -530,12 +530,14 @@ fhandler_console::read (void *pv, size_t& buflen)
   if (wincap.has_con_24bit_colors ())
     request_xterm_mode_input (true, &handle_set);
 
+  acquire_input_mutex (INFINITE);
   while (!input_ready && !get_cons_readahead_valid ())
     {
       int bgres;
       if ((bgres = bg_check (SIGTTIN)) <= bg_eof)
 	{
 	  buflen = bgres;
+	  release_input_mutex ();
 	  return;
 	}
 
@@ -552,6 +554,7 @@ wait_retry:
 	  pthread::static_cancel_self ();
 	  /*NOTREACHED*/
 	case WAIT_TIMEOUT:
+	  release_input_mutex ();
 	  set_sig_errno (EAGAIN);
 	  buflen = (size_t) -1;
 	  return;
@@ -572,9 +575,7 @@ wait_retry:
 
       int ret;
       acquire_attach_mutex (INFINITE);
-      acquire_input_mutex (INFINITE);
       ret = process_input_message ();
-      release_input_mutex ();
       release_attach_mutex ();
       switch (ret)
 	{
@@ -595,7 +596,6 @@ wait_retry:
     }
 
   /* Check console read-ahead buffer filled from terminal requests */
-  acquire_input_mutex (INFINITE);
   while (con.cons_rapoi && *con.cons_rapoi && buflen)
     {
       buf[copied_chars++] = *con.cons_rapoi++;
@@ -615,11 +615,13 @@ wait_retry:
   return;
 
 err:
+  release_input_mutex ();
   __seterrno ();
   buflen = (size_t) -1;
   return;
 
 sig_exit:
+  release_input_mutex ();
   set_sig_errno (EINTR);
   buflen = (size_t) -1;
 }
@@ -984,9 +986,7 @@ fhandler_console::process_input_message (void)
       if (toadd)
 	{
 	  ssize_t ret;
-	  release_input_mutex ();
 	  line_edit_status res = line_edit (toadd, nread, *ti, &ret);
-	  acquire_input_mutex (INFINITE);
 	  if (res == line_edit_signalled)
 	    {
 	      stat = input_signalled;
-- 
2.30.0

