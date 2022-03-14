Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
 by sourceware.org (Postfix) with ESMTPS id 2C51A3857829
 for <cygwin-patches@cygwin.com>; Mon, 14 Mar 2022 11:37:46 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 2C51A3857829
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ak036016.dynamic.ppp.asahi-net.or.jp
 [119.150.36.16]) (authenticated)
 by conuserg-11.nifty.com with ESMTP id 22EBb70a008755;
 Mon, 14 Mar 2022 20:37:16 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 22EBb70a008755
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1647257836;
 bh=edQvaYvWFUyZRMbCPqHTCFF/z8kk6oik+m1GlsEi+HE=;
 h=From:To:Cc:Subject:Date:From;
 b=Ub8w4gHfdJ+HvESH7l6PVsCYcjU3gKjc9JCiMs6r5kCpYhhKTvUhOqtcRafumPJ3M
 EHrHZDK8xNunGigyp0R0OUIaVUSpRtxx4JpwyJM6igTzqhsjFITOwKeG8wOJCNtiUJ
 3BHLhIAZYRY582OkUmPhi9HuGij3p2/5qIFnv7Y7tGWrIWVrZcnIo0o64q84P67omL
 ttQ4E70VLbm4zMkdH/swaIlnFK8ZOP6Eak0/nH+h+CnM96Yp5OdlMcsJd7wu6BufQB
 nVkzrbyOXmElS9QYvxCVYyIhEY8xYKVu58BMJf7OHBCEMU+W9k5Duyd8/riMe3LKg9
 LkfgfNeg7pI0w==
X-Nifty-SrcIP: [119.150.36.16]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: path: Convert type of variable 'remlen' to DWORD.
Date: Mon, 14 Mar 2022 20:36:58 +0900
Message-Id: <20220314113658.6009-1-takashi.yano@nifty.ne.jp>
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
X-List-Received-Date: Mon, 14 Mar 2022 11:37:47 -0000

- Variable remlen stores the return value of QueryDosDeviceW(), so
  it is better to be DWORD.
---
 winsup/cygwin/path.cc | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/winsup/cygwin/path.cc b/winsup/cygwin/path.cc
index eceafbbcf..e370843ee 100644
--- a/winsup/cygwin/path.cc
+++ b/winsup/cygwin/path.cc
@@ -3523,8 +3523,7 @@ restart:
 			{(WCHAR) towupper (upath.Buffer[4]), L':', L'\0'};
 		      WCHAR remote[MAX_PATH];
 
-
-		      int remlen = QueryDosDeviceW (drive, remote, MAX_PATH);
+		      DWORD remlen = QueryDosDeviceW (drive, remote, MAX_PATH);
 		      if (remlen < 3)
 			goto file_not_symlink; /* fallback */
 		      remlen -= 2; /* Two L'\0' */
-- 
2.35.1

