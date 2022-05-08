Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
 by sourceware.org (Postfix) with ESMTPS id 825BC385842B
 for <cygwin-patches@cygwin.com>; Sun,  8 May 2022 15:58:13 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 825BC385842B
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ak044095.dynamic.ppp.asahi-net.or.jp
 [119.150.44.95]) (authenticated)
 by conuserg-11.nifty.com with ESMTP id 248FvZeb020998;
 Mon, 9 May 2022 00:57:41 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 248FvZeb020998
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1652025462;
 bh=3ZyF12AW+EbIswpt+0+6tfLjhQPIDqB/9epIHsdYxok=;
 h=From:To:Cc:Subject:Date:From;
 b=Vmpg0HmVmkHoNJaGn5rnFzu4JpyyBJmwt9sXBWdbmY1bZHwKAdAWNPmT9pItdRTs6
 WDvIipdJ1AmUDwPNYq+qG/PvSKex3z8s9iu4E8e0SL8ljymFe6NpNfDE2dj4YUug3v
 Gz65aOU650YZXBO6925A1S6f0dPNN+0oX0jBhmOlBsIXsQr7Jn3LNTO8pVUvHYLnsD
 UFlyC5d8m29CSTZOM42msWjEPQ3fvjvM+DqeoXRX2+0RbwrD+dwqATE7kjMkvdGxI3
 ln4UL1mY+njTPkrgq2dY0hqLeRmFDsqj0Zj10Hi/GDhGBObsgH1F1gGcmeRB+cTRs0
 oL2+Gn1oC8g2Q==
X-Nifty-SrcIP: [119.150.44.95]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pty: Add missing attach_mutex guard.
Date: Mon,  9 May 2022 00:57:29 +0900
Message-Id: <20220508155729.5953-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Sun, 08 May 2022 15:58:15 -0000

---
 winsup/cygwin/fhandler_tty.cc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index f6a7a6cf9..bb18d139e 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -3422,6 +3422,7 @@ skip_create:
       HeapFree (GetProcessHeap (), 0, hp);
     }
 
+  acquire_attach_mutex (mutex_timeout);
   if (get_ttyp ()->previous_code_page)
     SetConsoleCP (get_ttyp ()->previous_code_page);
   if (get_ttyp ()->previous_output_code_page)
@@ -3452,6 +3453,7 @@ skip_create:
 	mode |= DISABLE_NEWLINE_AUTO_RETURN;
       SetConsoleMode (hpConOut, mode);
     }
+  release_attach_mutex ();
 
   return true;
 
-- 
2.36.0

