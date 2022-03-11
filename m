Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
 by sourceware.org (Postfix) with ESMTPS id 6E25B385141D
 for <cygwin-patches@cygwin.com>; Fri, 11 Mar 2022 21:37:29 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 6E25B385141D
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ak036016.dynamic.ppp.asahi-net.or.jp
 [119.150.36.16]) (authenticated)
 by conuserg-12.nifty.com with ESMTP id 22BLb9Ra019128;
 Sat, 12 Mar 2022 06:37:14 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 22BLb9Ra019128
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1647034634;
 bh=qcM5kpTrJ3em3ZDDjvuh4GaVKDMA6y1t5pmps4FOEiE=;
 h=From:To:Cc:Subject:Date:From;
 b=oAwoHEM9toK2TB7sTP1LaM17vt56eMHxOKvc+ZGr8xUr6vusgcDVclhCNtm4pmpLQ
 WGZxdLrGRrLHYkDqUUsS6L7MxZ0mj5MYiLzdQi2bTTqD8uWibxhd+BUvWL1rZr8efI
 oAnziVVzGdpfs4PMoRfVjlgGsxs+Tt+o6j9xBiS5NXbOqyDmkazQ2zObvzOFuvXUmp
 R3RDmziZAEqFumSrmCUtOLL5RjYgm/nq2cTA/MGKuu0lrtS/Xb/QedxoKIiGD4v2mf
 fLvAdrTWKqE2Lhbik4kpp4SqEWkDOH3l0YQrYJeowGIZThsF1j9WxNVLR9bhykfeZg
 HQ5T6Lmi5afeA==
X-Nifty-SrcIP: [119.150.36.16]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: fsync: Return EINVAL for special files.
Date: Sat, 12 Mar 2022 06:37:06 +0900
Message-Id: <20220311213707.1463-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_PASS, TXREP,
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
X-List-Received-Date: Fri, 11 Mar 2022 21:37:31 -0000

- Unlike linux, fsync() calls FlushFileBuffers() even for special
  files. This cause the problem reported in:
    https://cygwin.com/pipermail/cygwin/2022-March/251022.html
  This patch fixes the issue.
---
 winsup/cygwin/fhandler.cc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler.cc b/winsup/cygwin/fhandler.cc
index 98d7a3b2d..fc7bf0a0e 100644
--- a/winsup/cygwin/fhandler.cc
+++ b/winsup/cygwin/fhandler.cc
@@ -1750,7 +1750,7 @@ fhandler_base::utimens (const struct timespec *tvp)
 int
 fhandler_base::fsync ()
 {
-  if (!get_handle () || nohandle ())
+  if (!get_handle () || nohandle () || pc.isspecial ())
     {
       set_errno (EINVAL);
       return -1;
-- 
2.35.1

