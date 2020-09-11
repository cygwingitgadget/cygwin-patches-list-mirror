Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
 by sourceware.org (Postfix) with ESMTPS id BC815396E428
 for <cygwin-patches@cygwin.com>; Fri, 11 Sep 2020 18:35:20 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org BC815396E428
Received: from localhost.localdomain (v038192.dynamic.ppp.asahi-net.or.jp
 [124.155.38.192]) (authenticated)
 by conuserg-08.nifty.com with ESMTP id 08BIYnEO017768;
 Sat, 12 Sep 2020 03:34:54 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 08BIYnEO017768
X-Nifty-SrcIP: [124.155.38.192]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pty: Skip multibyte char boundary check conditionally.
Date: Sat, 12 Sep 2020 03:34:41 +0900
Message-Id: <20200911183441.758-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0,
 RCVD_IN_BARRACUDACENTRAL, RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_BL,
 RCVD_IN_MSPIKE_L4, SPF_HELO_NONE, SPF_PASS,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Fri, 11 Sep 2020 18:35:22 -0000

- For charset in which MB_ERR_INVALID_CHARS does not work properly,
  skip multibyte char boundary check in convert_mb_str().
---
 winsup/cygwin/fhandler_tty.cc | 83 ++++++++++++++++++++---------------
 1 file changed, 47 insertions(+), 36 deletions(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 8910af1e7..dd514049f 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -122,46 +122,57 @@ convert_mb_str (UINT cp_to, char *ptr_to, size_t *len_to,
 		UINT cp_from, const char *ptr_from, size_t len_from,
 		mbstate_t *mbp)
 {
+  bool check_boundary = false;
+  if (MultiByteToWideChar (cp_from, MB_ERR_INVALID_CHARS, "A", 1, NULL, 0))
+    check_boundary = true;
   tmp_pathbuf tp;
   wchar_t *wbuf = tp.w_get ();
   int wlen = 0;
-  char *tmpbuf = tp.c_get ();
-  memcpy (tmpbuf, mbp->__value.__wchb, mbp->__count);
-  if (mbp->__count + len_from > NT_MAX_PATH)
-    len_from = NT_MAX_PATH - mbp->__count;
-  memcpy (tmpbuf + mbp->__count, ptr_from, len_from);
-  int total_len = mbp->__count + len_from;
-  mbp->__count = 0;
-  int mblen = 0;
-  for (const char *p = tmpbuf; p < tmpbuf + total_len; p += mblen)
-    /* Max bytes in multibyte char supported is 4. */
-    for (mblen = 1; mblen <= 4; mblen ++)
-      {
-	/* Try conversion */
-	int l = MultiByteToWideChar (cp_from, MB_ERR_INVALID_CHARS,
-				     p, mblen,
-				     wbuf + wlen, NT_MAX_PATH - wlen);
-	if (l)
-	  { /* Conversion Success */
-	    wlen += l;
-	    break;
-	  }
-	else if (mblen == 4)
-	  { /* Conversion Fail */
-	    l = MultiByteToWideChar (cp_from, 0, p, 1,
-				     wbuf + wlen, NT_MAX_PATH - wlen);
-	    wlen += l;
-	    mblen = 1;
-	    break;
-	  }
-	else if (p + mblen == tmpbuf + total_len)
-	  { /* Multibyte char incomplete */
-	    memcpy (mbp->__value.__wchb, p, mblen);
-	    mbp->__count = mblen;
-	    break;
+  if (!check_boundary)
+    /* If MB_ERR_INVALID_CHARS does not work properly,
+       just convert string without checking */
+    wlen = MultiByteToWideChar (cp_from, 0, ptr_from, len_from,
+				wbuf, NT_MAX_PATH);
+  else
+    {
+      char *tmpbuf = tp.c_get ();
+      memcpy (tmpbuf, mbp->__value.__wchb, mbp->__count);
+      if (mbp->__count + len_from > NT_MAX_PATH)
+	len_from = NT_MAX_PATH - mbp->__count;
+      memcpy (tmpbuf + mbp->__count, ptr_from, len_from);
+      int total_len = mbp->__count + len_from;
+      mbp->__count = 0;
+      int mblen = 0;
+      for (const char *p = tmpbuf; p < tmpbuf + total_len; p += mblen)
+	/* Max bytes in multibyte char supported is 4. */
+	for (mblen = 1; mblen <= 4; mblen ++)
+	  {
+	    /* Try conversion */
+	    int l = MultiByteToWideChar (cp_from, MB_ERR_INVALID_CHARS,
+					 p, mblen,
+					 wbuf + wlen, NT_MAX_PATH - wlen);
+	    if (l)
+	      { /* Conversion Success */
+		wlen += l;
+		break;
+	      }
+	    else if (mblen == 4)
+	      { /* Conversion Fail */
+		l = MultiByteToWideChar (cp_from, 0, p, 1,
+					 wbuf + wlen, NT_MAX_PATH - wlen);
+		wlen += l;
+		mblen = 1;
+		break;
+	      }
+	    else if (p + mblen == tmpbuf + total_len)
+	      { /* Multibyte char incomplete */
+		memcpy (mbp->__value.__wchb, p, mblen);
+		mbp->__count = mblen;
+		break;
+	      }
+	    /* Retry conversion with extended length */
 	  }
-	/* Retry conversion with extended length */
-      }
+    }
   *len_to = WideCharToMultiByte (cp_to, 0, wbuf, wlen,
 				 ptr_to, *len_to, NULL, NULL);
 }
-- 
2.28.0

