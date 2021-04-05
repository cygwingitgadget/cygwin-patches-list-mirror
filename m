Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
 by sourceware.org (Postfix) with ESMTPS id 9CBD53861969
 for <cygwin-patches@cygwin.com>; Mon,  5 Apr 2021 08:32:54 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 9CBD53861969
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=takashi.yano@nifty.ne.jp
Received: from localhost.localdomain (v050190.dynamic.ppp.asahi-net.or.jp
 [124.155.50.190]) (authenticated)
 by conuserg-12.nifty.com with ESMTP id 1358WNV3000468;
 Mon, 5 Apr 2021 17:32:29 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 1358WNV3000468
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1617611549;
 bh=zRb6fovrTlywpbJW5NXiTkW76edqwd503RGB0+tSmGE=;
 h=From:To:Cc:Subject:Date:From;
 b=rn2fPQayTGKzDbeHT7x4N5fC0Y7WaUyo0uRuV+lqeP0g4PwD5f/HLenht9FVn6oGf
 MLs8WjeNWgMzI9g+jxk6ADur4gu8q7eLJRNqXcLPsJglhXvV7vm8yc0yMWrTVp2B7N
 M38lQURW570OiJ1xAD0vQQ686d9LVJ9Rp5lC/iFG1cUhFSHZim7sjKSbVSS33XHwKZ
 n+t8R6t1npauEZLZNfHBs05o3Mgcs7XVwtm5RBJIJo9vzKM7A07PdJpqCzaoPvrB5N
 u0T7esQMxpd/Q1nhc/fHf1KXDnTpDbYF0/gkHRFweeUf4JjF3nkrsExA7BgR4HPO+E
 GQWbgfHqGl7KA==
X-Nifty-SrcIP: [124.155.50.190]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pty: Use find_exec() rather than path_conv::check().
Date: Mon,  5 Apr 2021 17:32:13 +0900
Message-Id: <20210405083213.978-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Mon, 05 Apr 2021 08:32:57 -0000

- With this patch, find_exec() rather than path_conv::check() is used
  in order to enable searching executable file in the path.
---
 winsup/cygwin/fhandler_tty.cc | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 4601a0b5c..22e6da5fd 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -219,19 +219,20 @@ CreateProcessA_Hooked
       char *p = prog;
       char *p1;
       do
-	if ((p1 = strstr (p, ".exe")) || (p1 = strstr (p, ".com")))
+	if ((p1 = strchr (p, ' ')) || (p1 = p + strlen (p)))
 	  {
-	    p = p1 + 4;
+	    p = p1;
 	    if (*p == ' ')
 	      {
 		*p = '\0';
-		path.check (prog);
+		find_exec (prog, path);
 		*p = ' ';
+		p ++;
 	      }
 	    else if (*p == '\0')
-	      path.check (prog);
+	      find_exec (prog, path);
 	  }
-      while (!path.exists() && p1);
+      while (!path.exists() && *p);
     }
   const char *argv[] = {"", NULL}; /* Dummy */
   av av1;
@@ -282,19 +283,20 @@ CreateProcessW_Hooked
       char *p = prog;
       char *p1;
       do
-	if ((p1 = strstr (p, ".exe")) || (p1 = strstr (p, ".com")))
+	if ((p1 = strchr (p, ' ')) || (p1 = p + strlen (p)))
 	  {
-	    p = p1 + 4;
+	    p = p1;
 	    if (*p == ' ')
 	      {
 		*p = '\0';
-		path.check (prog);
+		find_exec (prog, path);
 		*p = ' ';
+		p ++;
 	      }
 	    else if (*p == '\0')
-	      path.check (prog);
+	      find_exec (prog, path);
 	  }
-      while (!path.exists() && p1);
+      while (!path.exists() && *p);
     }
   const char *argv[] = {"", NULL}; /* Dummy */
   av av1;
-- 
2.31.1

