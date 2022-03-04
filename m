Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
 by sourceware.org (Postfix) with ESMTPS id 6A60D3858D39
 for <cygwin-patches@cygwin.com>; Fri,  4 Mar 2022 15:49:01 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 6A60D3858D39
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ak036016.dynamic.ppp.asahi-net.or.jp
 [119.150.36.16]) (authenticated)
 by conuserg-11.nifty.com with ESMTP id 224Fmfum006607;
 Sat, 5 Mar 2022 00:48:45 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 224Fmfum006607
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1646408926;
 bh=1npSqUhpdM2VUa0GUKfagpMVPJ2hZIRCVtyRKv+bn/I=;
 h=From:To:Cc:Subject:Date:From;
 b=FPxoM3HCpyveEq+3qNCul4Fba7JLBLM5io1FpCd4XdeJSXQ+JS58irKgqBixFrd32
 eX+VBE7KdRZ2HsdCs8l5XOJWjScTHVPMIlUiUsm69wcTpbvApUkkksoGj1WI+9vR29
 ffr46LXzuuRNOLuf5hVBLzeMH4alPDqckT9DecYOMjZ6R3mVtDInKsjeQUentY5mnh
 t/22/1cWlJpW+uqbRxbR1+bkvusZrfCAqXTTTrm1l+25WpFOo6CwzhboNS7B40qKAX
 krUOkUnmwQ5QyjC9G2tG+iLh0+/1AKHYybtow5BQAyI9QC8PPM7WCJGGfK2hGen6D5
 vNOB3CZlgaqgQ==
X-Nifty-SrcIP: [119.150.36.16]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pty: Take account of CR+NL line feed in input.
Date: Sat,  5 Mar 2022 00:48:34 +0900
Message-Id: <20220304154834.1880-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Fri, 04 Mar 2022 15:49:04 -0000

- Currently, individual CR or NL is treated as line feed in
  accept_input() and transfer_input(). This patch takes account
  of CR+NL as well.
---
 winsup/cygwin/fhandler_tty.cc | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 3ed84709e..0c762d75e 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -571,16 +571,21 @@ fhandler_pty_master::accept_input ()
       paranoid_printf ("about to write %u chars to slave", bytes_left);
       /* Write line by line for transfer input. */
       char *p0 = p;
-      char *p1 = p;
+      char *p_cr = (char *) memchr (p0, '\r', bytes_left - (p0 - p));
+      char *p_nl = (char *) memchr (p0, '\n', bytes_left - (p0 - p));
       DWORD n;
-      while ((p1 = (char *) memchr (p0, '\n', bytes_left - (p0 - p)))
-	     || (p1 = (char *) memchr (p0, '\r', bytes_left - (p0 - p))))
+      while (p_cr || p_nl)
 	{
+	  char *p1 =
+	    p_cr ?  (p_nl ? ((p_cr + 1 == p_nl)
+			     ?  p_nl : min(p_cr, p_nl)) : p_cr) : p_nl;
 	  n = p1 - p0 + 1;
 	  rc = WriteFile (write_to, p0, n, &n, NULL);
 	  if (rc)
 	    written += n;
 	  p0 = p1 + 1;
+	  p_cr = (char *) memchr (p0, '\r', bytes_left - (p0 - p));
+	  p_nl = (char *) memchr (p0, '\n', bytes_left - (p0 - p));
 	}
       if (rc && (n = bytes_left - (p0 - p)))
 	{
@@ -3905,16 +3910,20 @@ fhandler_pty_slave::transfer_input (tty::xfer_dir dir, HANDLE from, tty *ttyp,
 	    }
 	  /* Call WriteFile() line by line */
 	  char *p0 = ptr;
-	  char *p_cr, *p_nl;
-	  while ((p_cr = (char *) memchr (p0, '\r', len - (p0 - ptr)))
-		 || (p_nl = (char *) memchr (p0, '\n', len - (p0 - ptr))))
+	  char *p_cr = (char *) memchr (p0, '\r', len - (p0 - ptr));
+	  char *p_nl = (char *) memchr (p0, '\n', len - (p0 - ptr));
+	  while (p_cr || p_nl)
 	    {
-	      char *p1 = p_cr ? (p_nl ? min (p_cr, p_nl) : p_cr) : p_nl;
+	      char *p1 =
+		p_cr ?  (p_nl ? ((p_cr + 1 == p_nl)
+				 ?  p_nl : min(p_cr, p_nl)) : p_cr) : p_nl;
 	      *p1 = '\n';
 	      n = p1 - p0 + 1;
 	      if (n && WriteFile (to, p0, n, &n, NULL) && n)
 		transfered = true;
 	      p0 = p1 + 1;
+	      p_cr = (char *) memchr (p0, '\r', len - (p0 - ptr));
+	      p_nl = (char *) memchr (p0, '\n', len - (p0 - ptr));
 	    }
 	  n = len - (p0 - ptr);
 	  if (n && WriteFile (to, p0, n, &n, NULL) && n)
-- 
2.35.1

