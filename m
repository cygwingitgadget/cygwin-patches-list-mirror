Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-07.nifty.com (conuserg-07.nifty.com [210.131.2.74])
 by sourceware.org (Postfix) with ESMTPS id EC4823858D1E
 for <cygwin-patches@cygwin.com>; Sat,  5 Mar 2022 01:05:35 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org EC4823858D1E
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ak036016.dynamic.ppp.asahi-net.or.jp
 [119.150.36.16]) (authenticated)
 by conuserg-07.nifty.com with ESMTP id 22515DCv026507;
 Sat, 5 Mar 2022 10:05:18 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 22515DCv026507
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1646442318;
 bh=/JvVuPJpKk55A7Szy8tbuk2bFpqIlyXyeKgU4RNb95M=;
 h=From:To:Cc:Subject:Date:From;
 b=AcIpEz+LkyORGJiCOSVwAhRq8c0jGojnoGPAtvfGltOdeio+bvkdG/60Emd+O+XSa
 beQI5hHmTsqtzBLkR7HIUdxxt5m1HzV8RaDSZZqm7UlUsdEudSoNpLsQVBDGDwGRC4
 CrC1RGpZGn25vG7HBBLFEQ/0N8LoZV//nms91GNMlkiFQ+jCOOkhFRn0pjgSKUTa4q
 NX+eI4tmVqsCCmxybf2SBdOu7xryVByZBAH+FWbLJaEWuzy5aH1BgVCXLczAZPWURv
 vXtEDZY9+6oJ0OOJQqFvogg/bY+Xwbj5I1H2j+u5s5U7YMBfcbmXBWdbEB0kizhQmh
 Kueea5g1ssegQ==
X-Nifty-SrcIP: [119.150.36.16]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pty: Adopt the variable name to the name generally
 used.
Date: Sat,  5 Mar 2022 10:05:12 +0900
Message-Id: <20220305010512.13086-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, RCVD_IN_DNSWL_NONE,
 SPF_HELO_NONE, SPF_PASS, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
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
X-List-Received-Date: Sat, 05 Mar 2022 01:05:40 -0000

- Generally, '\n' is called "line feed" (not "new line"), so the
  variable name p_nl has been changed to p_lf.
---
 winsup/cygwin/fhandler_tty.cc | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index c2e612580..e29b93ceb 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -580,20 +580,20 @@ fhandler_pty_master::accept_input ()
       /* Write line by line for transfer input. */
       char *p0 = p;
       char *p_cr = (char *) memchr (p0, '\r', bytes_left - (p0 - p));
-      char *p_nl = (char *) memchr (p0, '\n', bytes_left - (p0 - p));
+      char *p_lf = (char *) memchr (p0, '\n', bytes_left - (p0 - p));
       DWORD n;
-      while (p_cr || p_nl)
+      while (p_cr || p_lf)
 	{
 	  char *p1 =
-	    p_cr ?  (p_nl ? ((p_cr + 1 == p_nl)
-			     ?  p_nl : min(p_cr, p_nl)) : p_cr) : p_nl;
+	    p_cr ?  (p_lf ? ((p_cr + 1 == p_lf)
+			     ?  p_lf : min(p_cr, p_lf)) : p_cr) : p_lf;
 	  n = p1 - p0 + 1;
 	  rc = WriteFile (write_to, p0, n, &n, NULL);
 	  if (rc)
 	    written += n;
 	  p0 = p1 + 1;
 	  p_cr = (char *) memchr (p0, '\r', bytes_left - (p0 - p));
-	  p_nl = (char *) memchr (p0, '\n', bytes_left - (p0 - p));
+	  p_lf = (char *) memchr (p0, '\n', bytes_left - (p0 - p));
 	}
       if (rc && (n = bytes_left - (p0 - p)))
 	{
@@ -3920,19 +3920,19 @@ fhandler_pty_slave::transfer_input (tty::xfer_dir dir, HANDLE from, tty *ttyp,
 	  /* Call WriteFile() line by line */
 	  char *p0 = ptr;
 	  char *p_cr = (char *) memchr (p0, '\r', len - (p0 - ptr));
-	  char *p_nl = (char *) memchr (p0, '\n', len - (p0 - ptr));
-	  while (p_cr || p_nl)
+	  char *p_lf = (char *) memchr (p0, '\n', len - (p0 - ptr));
+	  while (p_cr || p_lf)
 	    {
 	      char *p1 =
-		p_cr ?  (p_nl ? ((p_cr + 1 == p_nl)
-				 ?  p_nl : min(p_cr, p_nl)) : p_cr) : p_nl;
+		p_cr ?  (p_lf ? ((p_cr + 1 == p_lf)
+				 ?  p_lf : min(p_cr, p_lf)) : p_cr) : p_lf;
 	      *p1 = '\n';
 	      n = p1 - p0 + 1;
 	      if (n && WriteFile (to, p0, n, &n, NULL) && n)
 		transfered = true;
 	      p0 = p1 + 1;
 	      p_cr = (char *) memchr (p0, '\r', len - (p0 - ptr));
-	      p_nl = (char *) memchr (p0, '\n', len - (p0 - ptr));
+	      p_lf = (char *) memchr (p0, '\n', len - (p0 - ptr));
 	    }
 	  n = len - (p0 - ptr);
 	  if (n && WriteFile (to, p0, n, &n, NULL) && n)
-- 
2.35.1

