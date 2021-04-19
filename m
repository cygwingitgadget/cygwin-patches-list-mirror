Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
 by sourceware.org (Postfix) with ESMTPS id D0FC13968C1A
 for <cygwin-patches@cygwin.com>; Mon, 19 Apr 2021 10:31:09 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org D0FC13968C1A
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=takashi.yano@nifty.ne.jp
Received: from localhost.localdomain (v050190.dynamic.ppp.asahi-net.or.jp
 [124.155.50.190]) (authenticated)
 by conuserg-11.nifty.com with ESMTP id 13JAUmC9006642;
 Mon, 19 Apr 2021 19:30:53 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 13JAUmC9006642
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1618828253;
 bh=74CLa2I/0b27/h4ja1Z+WhwIVyT9bSV1seIicwbTLnY=;
 h=From:To:Cc:Subject:Date:From;
 b=GuBiMmuU5hh4iRFDsiJnadwa33ua/UX6o8U1SwAA48U2u/66wtSZDGV5ZePQ26DCH
 LSGQgJH4q9P+USc9Xsj9rBeTqdY87ybbJ78SEnZDigqNYY9QUFZGcGcbUHN0FNN4/x
 Bbv/TETIeVKxJQx3/3X8dfclVOEh9yYMErzw5X18jIRm0IXdDqlg75ST5wuWvmKvDi
 T6/cqjF2GY2NACZe3Xztx7VnYM8yPvFQ9WED1sy85YAPGXItjEZyc1zkcG/2/F3emf
 BTu4kpZUwXYQRuXZAESW1ySoZj0aF/Sd32fRSGoXSCGcO0zvdIaNok3+NOQCq5Cp8Q
 gfrBWMMKcZpmA==
X-Nifty-SrcIP: [124.155.50.190]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH 0/2] Fix race issues.
Date: Mon, 19 Apr 2021 19:30:44 +0900
Message-Id: <20210419103046.21838-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=3.9 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, RCVD_IN_BL_SPAMCOP_NET,
 RCVD_IN_DNSWL_NONE, SPF_HELO_NONE, SPF_PASS,
 TXREP autolearn=no autolearn_force=no version=3.4.2
X-Spam-Level: ***
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
X-List-Received-Date: Mon, 19 Apr 2021 10:31:21 -0000

Takashi Yano (2):
  Cygwin: console: Fix race issue regarding cons_master_thread().
  Cygwin: pty: Fix race issue in inheritance of pseudo console.

 winsup/cygwin/fhandler_console.cc |  10 ++-
 winsup/cygwin/fhandler_tty.cc     | 108 ++++++++++++++++++------------
 winsup/cygwin/tty.cc              |  15 ++---
 winsup/cygwin/tty.h               |   2 +-
 4 files changed, 77 insertions(+), 58 deletions(-)

-- 
2.31.1

