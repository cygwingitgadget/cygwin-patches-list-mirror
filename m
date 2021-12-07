Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
 by sourceware.org (Postfix) with ESMTPS id ADDC23858D3C
 for <cygwin-patches@cygwin.com>; Tue,  7 Dec 2021 14:00:51 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org ADDC23858D3C
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (z221123.dynamic.ppp.asahi-net.or.jp
 [110.4.221.123]) (authenticated)
 by conuserg-12.nifty.com with ESMTP id 1B7E0DQE023563;
 Tue, 7 Dec 2021 23:00:18 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 1B7E0DQE023563
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1638885619;
 bh=fy/O152wG1C0A1J9P8+m5koiEvjTiIoIfcP/0FI8es8=;
 h=From:To:Cc:Subject:Date:From;
 b=hX/VoEIzYjeUFORPZjYHtjmhp1g12X0f9K4ZeSTHskHU3F9vyrk45fhw7c0fzk+wf
 uzv1rBYt+bz1LP1kSj/Qea/7dFVl6Uj9UDmM2KzAw4dfDY8KhubnDPL0eL5o34PspS
 Vecw9Vo/BSJaqkyAAOG2GnsY8+UzUsK0+4An7G/VBlc+WZyK79+6tuLzF9ygGpyIA1
 xD6aetypMeLU+NhlvbX7DmDylBV/QyGw89V5hPcH5uQGJADHBSvQndRfFWWLCZ21vB
 yeTaoiTbYYyxPu0P1H9ZPCFlrv68BkhKEkhNI740sNUP43wHes2LZJKI6omyjc9Lp0
 pBKSO3ntzPcjQ==
X-Nifty-SrcIP: [110.4.221.123]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH v2] Cygwin: clipboard: Fix a bug in read().
Date: Tue,  7 Dec 2021 23:00:06 +0900
Message-Id: <20211207140006.912-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, RCVD_IN_DNSWL_NONE,
 SPF_HELO_NONE, SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.4
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
X-List-Received-Date: Tue, 07 Dec 2021 14:00:54 -0000

- Fix a bug in fhandler_dev_clipboard::read() that the second read
  fails with 'Bad address'.

Addresses:
  https://cygwin.com/pipermail/cygwin/2021-December/250141.html
---
 winsup/cygwin/fhandler_clipboard.cc | 2 +-
 winsup/cygwin/release/3.3.4         | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)
 create mode 100644 winsup/cygwin/release/3.3.4

diff --git a/winsup/cygwin/fhandler_clipboard.cc b/winsup/cygwin/fhandler_clipboard.cc
index 0b87dd352..ae10228a7 100644
--- a/winsup/cygwin/fhandler_clipboard.cc
+++ b/winsup/cygwin/fhandler_clipboard.cc
@@ -229,7 +229,7 @@ fhandler_dev_clipboard::read (void *ptr, size_t& len)
       if (pos < (off_t) clipbuf->cb_size)
 	{
 	  ret = (len > (clipbuf->cb_size - pos)) ? clipbuf->cb_size - pos : len;
-	  memcpy (ptr, &clipbuf[1] + pos , ret);
+	  memcpy (ptr, (char *) &clipbuf[1] + pos, ret);
 	  pos += ret;
 	}
     }
diff --git a/winsup/cygwin/release/3.3.4 b/winsup/cygwin/release/3.3.4
new file mode 100644
index 000000000..f1c32a1a5
--- /dev/null
+++ b/winsup/cygwin/release/3.3.4
@@ -0,0 +1,6 @@
+Bug Fixes
+---------
+
+- Fix a bug in fhandler_dev_clipboard::read() that the second read
+  fails with 'Bad address'.
+  Addresses: https://cygwin.com/pipermail/cygwin/2021-December/250141.html
-- 
2.34.1

