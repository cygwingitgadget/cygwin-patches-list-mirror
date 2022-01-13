Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-09.nifty.com (conuserg-09.nifty.com [210.131.2.76])
 by sourceware.org (Postfix) with ESMTPS id 81ABC3948820
 for <cygwin-patches@cygwin.com>; Thu, 13 Jan 2022 12:29:04 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 81ABC3948820
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ae233132.dynamic.ppp.asahi-net.or.jp
 [14.3.233.132]) (authenticated)
 by conuserg-09.nifty.com with ESMTP id 20DCSLD2010973;
 Thu, 13 Jan 2022 21:28:26 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 20DCSLD2010973
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1642076906;
 bh=ZIjMn9VEINb5mKCaQp5CTcmaammuc3cNX9omNSRhRWk=;
 h=From:To:Cc:Subject:Date:From;
 b=mmnbd/y+ALY2QJigWFumPX2DlzbPBSmIFwnZG35TvFPM5u3c+niff5aHZMsy2usSb
 dNIrzL+eTXEteCZRNGU2w20zDfGZlVqC58Fk3rIpD1SEbPxmU7htflINcSL82cCSjj
 Ru3lmzHiWS8NaXsMoJ6Snn68cX+DCgmcrMZleqMwYrX3mTYdMlZaKSMdKOzRkbvxp4
 NDAU/8JotM5fgLypk5UMw95vYOblHNZ+it3d69rGAN4yLkxymbtMbBpXrmklSu9cGm
 IJ1CDN12sM2K1LGdSHbrSkpIsc7MCCnPkQOGLF3sSuWkOfkkxFlwH4WcqjvASfeFYw
 JHy5BHnt4/6dw==
X-Nifty-SrcIP: [14.3.233.132]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH 0/4] Some fixes for console and pty.
Date: Thu, 13 Jan 2022 21:28:07 +0900
Message-Id: <20220113122811.241-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, RCVD_IN_DNSWL_NONE, SPF_HELO_NONE,
 SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.4
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
X-List-Received-Date: Thu, 13 Jan 2022 12:29:07 -0000

Takashi Yano (4):
  Cygwin: pty, console: Fix deadlock in GDB regarding mutex.
  Cygwin: pty: Fix memory leak in master_fwd_thread.
  Cygwin: pty: Stop closing and recreating attach_mutex.
  Cygwin: console: Fix potential deadlock regarding acuqiring mutex.

 winsup/cygwin/fhandler.h          |  5 ++
 winsup/cygwin/fhandler_console.cc | 92 +++++++++++++++++++-----------
 winsup/cygwin/fhandler_termios.cc |  8 ++-
 winsup/cygwin/fhandler_tty.cc     | 95 +++++++++++++++++++------------
 winsup/cygwin/select.cc           | 25 ++------
 winsup/cygwin/spawn.cc            |  8 ++-
 winsup/cygwin/tty.cc              |  7 ++-
 winsup/cygwin/tty.h               |  1 +
 8 files changed, 146 insertions(+), 95 deletions(-)

-- 
2.34.1

