Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
 by sourceware.org (Postfix) with ESMTPS id 14D873857018
 for <cygwin-patches@cygwin.com>; Thu,  3 Feb 2022 08:40:59 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 14D873857018
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (v036249.dynamic.ppp.asahi-net.or.jp
 [124.155.36.249]) (authenticated)
 by conuserg-08.nifty.com with ESMTP id 2138ecDp011977;
 Thu, 3 Feb 2022 17:40:45 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 2138ecDp011977
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1643877645;
 bh=o0DxStoT5reP19KJ1xxE6Kw4u3BQpa4+5wLbKKrgSE0=;
 h=From:To:Cc:Subject:Date:From;
 b=I2j8EA9plFnkJpEF9mL9xlO88zk5cMtXQGSZAdRqTwxUwe6AF7youpSUcMfx0QHwx
 yLC8k3LExhpqmB8KH4kROT2YkzAaNcdsyMHgyet97JxzXan46Sgqdk+6MR5ig5KFEI
 3gf6opJWfilGgd499IzG5pKL0LiYoq+sK3uRkMH1BySUKsyHJZW0GN9FknWcD84HRz
 DTTaL3qaAx6GLuMGmcOVUDelPIRztovlnHXzfgSVWPmT9YvpvERrwVTfDmbYXK6hnS
 sevd4JKk2Jp5ju+28boYGp9iBl0NeMpXs/8fjk500GDqhpQibbRtmj/iFaaLM5ICCI
 XxVtShe9OGdTw==
X-Nifty-SrcIP: [124.155.36.249]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: path: Fix UNC path handling for SMB3 mounted to a
 drive.
Date: Thu,  3 Feb 2022 17:40:26 +0900
Message-Id: <20220203084026.1934-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.7 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Thu, 03 Feb 2022 08:41:04 -0000

- If an UNC path is mounted to a drive using SMB3.11, accessing to
  the drive fails with error "Too many levels of symbolic links."
  This patch fixes the issue.
---
 winsup/cygwin/path.cc | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/path.cc b/winsup/cygwin/path.cc
index 87ac2404a..4ad4e0821 100644
--- a/winsup/cygwin/path.cc
+++ b/winsup/cygwin/path.cc
@@ -3495,10 +3495,19 @@ restart:
 
 	      /* If incoming path has no trailing backslash, but final path
 		 has one, drop trailing backslash from final path so the
-		 below string comparison has a chance to succeed. */
+		 below string comparison has a chance to succeed.
+		 On the contrary, if incoming path has trailing backslash,
+		 but final path does not have one, add trailing backslash
+		 to the final path. */
 	      if (upath.Buffer[(upath.Length - 1) / sizeof (WCHAR)] != L'\\'
-                  && fpbuf[ret - 1] == L'\\')
+		  && fpbuf[ret - 1] == L'\\')
                 fpbuf[--ret] = L'\0';
+	      if (upath.Buffer[(upath.Length - 1) / sizeof (WCHAR)] == L'\\'
+		  && fpbuf[ret - 1] != L'\\' && ret < NT_MAX_PATH - 1)
+		{
+		  fpbuf[ret++] = L'\\';
+		  fpbuf[ret] = L'\0';
+		}
 	      fpbuf[1] = L'?';	/* \\?\ --> \??\ */
 	      RtlInitCountedUnicodeString (&fpath, fpbuf, ret * sizeof (WCHAR));
 	      if (!RtlEqualUnicodeString (&upath, &fpath, !!ci_flag))
-- 
2.34.1

