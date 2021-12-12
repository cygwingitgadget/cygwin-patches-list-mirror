Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
 by sourceware.org (Postfix) with ESMTPS id C0424385800F
 for <cygwin-patches@cygwin.com>; Sun, 12 Dec 2021 13:05:38 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org C0424385800F
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (z221123.dynamic.ppp.asahi-net.or.jp
 [110.4.221.123]) (authenticated)
 by conuserg-11.nifty.com with ESMTP id 1BCD59Uc022149;
 Sun, 12 Dec 2021 22:05:14 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 1BCD59Uc022149
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1639314314;
 bh=ubQ9ill03A5iVFpWXL20+BJUTMj7mArSGIrytOIANXk=;
 h=From:To:Cc:Subject:Date:From;
 b=Fzp0/5WpUiyvbYZhtVKVfIM/oueo/nmCRjfQwpsO0JzYdDCjhAYRno7ybi1OkZC3/
 Rk9ZXOr2kjJKJwqjsvgkxjV7NI2F1d6BTN0zMpugJ5M/Xj1y1EiVL4C7+bXq5RS1iB
 yeaf7HEBUVxvE1hVVTKJtQDZKGiY1Zaa5T3MBfXy58qnQ6AA1DQs42C5jkTQrljuov
 IBl/gw07ask3vY7gTRfDLpdzIOBwxeRoOt4gJHpehO/dhVcASwSE8+LLp31HzeHWyv
 cW+5U2fSaqryVhDGoPvADkNhbllcwQAWJpOM3SKGIVYybXHRc1l+JF4GJtB9EafNr6
 g1KeUQftQrdHQ==
X-Nifty-SrcIP: [110.4.221.123]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH 0/3] Fix behaviour of non-cygwin apps in background.
Date: Sun, 12 Dec 2021 22:04:58 +0900
Message-Id: <20211212130501.10091-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Sun, 12 Dec 2021 13:05:40 -0000

Takashi Yano (3):
  Cygwin: pty: Fix Ctrl-C handling for non-cygwin apps in background.
  Cygwin: pty: Fix console mode of non-cygwin apps in background.
  Cygwin: console: Fix console mode of non-cygwin apps in background.

 winsup/cygwin/fhandler_tty.cc | 12 +++++++-----
 winsup/cygwin/spawn.cc        |  7 +++++--
 2 files changed, 12 insertions(+), 7 deletions(-)

-- 
2.34.1

