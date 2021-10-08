Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com
 [210.131.2.80])
 by sourceware.org (Postfix) with ESMTPS id BBAFF3858431
 for <cygwin-patches@cygwin.com>; Fri,  8 Oct 2021 09:52:38 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org BBAFF3858431
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from Express5800-S70 (z221123.dynamic.ppp.asahi-net.or.jp
 [110.4.221.123]) (authenticated)
 by conssluserg-01.nifty.com with ESMTP id 1989q9F2007106
 for <cygwin-patches@cygwin.com>; Fri, 8 Oct 2021 18:52:10 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 1989q9F2007106
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1633686730;
 bh=bSEmBKDq1i1wAoS4rUco7Izxr1VdIdXL2Z4KGgavfj4=;
 h=Date:From:To:Subject:In-Reply-To:References:From;
 b=A794IMMoOk8yY5V5jHi2ABbUQd637z+/+DfIedRjW/t5N8hFQv3nlG9+xUdvYJ0SO
 wOA10anA5drNI/CZWxDGWD4DIp9TQquo0xKJMbs/smLMdAx1ikOR4vrJ09O01HtS7F
 ZZss5WlOXl4tntrhxPw5P9GPj+lRN8i2GSFj1wRvrgOsQfkgPwiMHWWkFctI6dJx/P
 StFXtk3Z30RIhbSUWxeUelbb1/BWttOCD7iJEROXl6GBVEB6Vbpsmk7bsHyZ9yu18K
 bm6e1gDls0f5Qf1HMiBTGzgUlTn7djE+dasYqDn9985c4JfOJpFMfk/og3U1vLNNs2
 Ub68pKkzonO/w==
X-Nifty-SrcIP: [110.4.221.123]
Date: Fri, 8 Oct 2021 18:52:10 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Make native clipboard layout same for 32- and
 64-bit
Message-Id: <20211008185210.cac713f28dea727a1467cf94@nifty.ne.jp>
In-Reply-To: <20211007052237.7139-1-mark@maxrnd.com>
References: <20211007052237.7139-1-mark@maxrnd.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, NICE_REPLY_A,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_PASS,
 TXREP autolearn=ham autolearn_force=no version=3.4.4
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
X-List-Received-Date: Fri, 08 Oct 2021 09:52:42 -0000

How about simply just:

diff --git a/winsup/cygwin/fhandler_clipboard.cc b/winsup/cygwin/fhandler_clipboard.cc
index ccdb295f3..d822f4fc4 100644
--- a/winsup/cygwin/fhandler_clipboard.cc
+++ b/winsup/cygwin/fhandler_clipboard.cc
@@ -28,9 +28,10 @@ static const WCHAR *CYGWIN_NATIVE = L"CYGWIN_NATIVE_CLIPBOARD";
 
 typedef struct
 {
-  timestruc_t	timestamp;
-  size_t	len;
-  char		data[1];
+  uint64_t tv_sec;
+  uint64_t tv_nsec;
+  uint64_t len;
+  char data[1];
 } cygcb_t;
 
 fhandler_dev_clipboard::fhandler_dev_clipboard ()
@@ -74,7 +75,10 @@ fhandler_dev_clipboard::set_clipboard (const void *buf, size_t len)
 	}
       clipbuf = (cygcb_t *) GlobalLock (hmem);
 
-      clock_gettime (CLOCK_REALTIME, &clipbuf->timestamp);
+      struct timespec ts;
+      clock_gettime (CLOCK_REALTIME, &ts);
+      clipbuf->tv_sec = ts.tv_sec;
+      clipbuf->tv_nsec = ts.tv_nsec;
       clipbuf->len = len;
       memcpy (clipbuf->data, buf, len);
 
@@ -179,7 +183,10 @@ fhandler_dev_clipboard::fstat (struct stat *buf)
 	  && (hglb = GetClipboardData (format))
 	  && (clipbuf = (cygcb_t *) GlobalLock (hglb)))
 	{
-	  buf->st_atim = buf->st_mtim = clipbuf->timestamp;
+	  struct timespec ts;
+	  ts.tv_sec = clipbuf->tv_sec;
+	  ts.tv_nsec = clipbuf->tv_nsec;
+	  buf->st_atim = buf->st_mtim = ts;
 	  buf->st_size = clipbuf->len;
 	  GlobalUnlock (hglb);
 	}

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
