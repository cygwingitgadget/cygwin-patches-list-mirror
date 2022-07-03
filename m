Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-10.nifty.com (conuserg-10.nifty.com [210.131.2.77])
 by sourceware.org (Postfix) with ESMTPS id F3F673857BAC
 for <cygwin-patches@cygwin.com>; Sun,  3 Jul 2022 02:04:27 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org F3F673857BAC
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ak044095.dynamic.ppp.asahi-net.or.jp
 [119.150.44.95]) (authenticated)
 by conuserg-10.nifty.com with ESMTP id 26324BvS015550;
 Sun, 3 Jul 2022 11:04:15 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 26324BvS015550
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1656813855;
 bh=+fGyyhx90ukHfHmQwRAxjtMPdEijDrJko09eTOxUZN8=;
 h=From:To:Cc:Subject:Date:From;
 b=AjEiGUF4tFbTd6/xypD9kLG4DdrW5DHYSRkKYJenPAeayR9HCtA7gvV4gMeNf5PFd
 NoLPsjALqwqQsglDaOgyYDZp38gF7kczXNzCxNnLO+iEmxk1x9NGFuuVr3yuT4lthY
 b8R98YtDqZGVImtjmMerk/9SgPEi4qhF4hSqTQODQRs3jR5PBRB2sd30gSrRUFJ2Rb
 M4fL3IeeXbaHcIDH/FXjw8tD1+Lzq84ZwGQes6SPDGkEHTdDBRbpRfx8U03Kl5/Pe+
 uWu9IcyIG8KI+fYBmMfMNa1349lxXeZwZ/OrMNbzz12zRPvPq/X0Ah3cv/IWcve8yl
 6Z6vVjSMN3hTQ==
X-Nifty-SrcIP: [119.150.44.95]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: console: Fix new bugs in cons_master_thread().
Date: Sun,  3 Jul 2022 11:04:01 +0900
Message-Id: <20220703020401.452-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, RCVD_IN_DNSWL_NONE,
 RCVD_IN_VALIDITY_RPBL, SPF_HELO_NONE, SPF_PASS, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
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
X-List-Received-Date: Sun, 03 Jul 2022 02:04:33 -0000

- The previous commit for console introduced new bugs in error
  handling in cons_master_thread(). This patch fixes that.
---
 winsup/cygwin/fhandler_console.cc | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index c95716c5f..848c96772 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -361,7 +361,8 @@ fhandler_console::cons_master_thread (handle_set_t *p, tty *ttyp)
 	{
 	case WAIT_OBJECT_0:
 	  total_read = 0;
-	  while (cygwait (p->input_handle, (DWORD) 0) == WAIT_OBJECT_0)
+	  while (cygwait (p->input_handle, (DWORD) 0) == WAIT_OBJECT_0
+		 && total_read < inrec_size)
 	    {
 	      DWORD len;
 	      ReadConsoleInputW (p->input_handle, input_rec + total_read,
@@ -477,7 +478,8 @@ remove_record:
 	      /* Try to fix */
 	      acquire_attach_mutex (mutex_timeout);
 	      n = 0;
-	      while (cygwait (p->input_handle, (DWORD) 0) == WAIT_OBJECT_0)
+	      while (cygwait (p->input_handle, (DWORD) 0) == WAIT_OBJECT_0
+		     && n < inrec_size)
 		{
 		  DWORD len;
 		  ReadConsoleInputW (p->input_handle, input_tmp + n,
@@ -492,14 +494,13 @@ remove_record:
 		    if (total_read + j - i >= n)
 		      { /* Something is wrong. Giving up. */
 			acquire_attach_mutex (mutex_timeout);
-			WriteConsoleInputW (p->input_handle, input_tmp, n, &n);
-			n = 0;
-			while (n < total_read)
+			DWORD l = 0;
+			while (l < n)
 			  {
 			    DWORD len;
-			    WriteConsoleInputW (p->input_handle, input_rec + n,
-				      min (total_read - n, inrec_size1), &len);
-			    n += len;
+			    WriteConsoleInputW (p->input_handle, input_tmp + l,
+					      min (n - l, inrec_size1), &len);
+			    l += len;
 			  }
 			release_attach_mutex ();
 			goto skip_writeback;
-- 
2.36.1

