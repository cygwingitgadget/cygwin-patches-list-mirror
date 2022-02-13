Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
 by sourceware.org (Postfix) with ESMTPS id 4C65B3858D1E
 for <cygwin-patches@cygwin.com>; Sun, 13 Feb 2022 14:39:45 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 4C65B3858D1E
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ak036016.dynamic.ppp.asahi-net.or.jp
 [119.150.36.16]) (authenticated)
 by conuserg-11.nifty.com with ESMTP id 21DEdOvD000575;
 Sun, 13 Feb 2022 23:39:32 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 21DEdOvD000575
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1644763172;
 bh=7EOqak8EeHGUHQE45Ya1tmXzbwNuy2klMqEyySDgVLI=;
 h=From:To:Cc:Subject:Date:From;
 b=MNzEm3HNWnOvKloNBx2E1BrqP4hgNuY4zHeM7g2ArEupNyaoK0pXgDo4c7NUUklZw
 cAguts7GpPzClDuYgUmvWgLu2v6b3AKbmEqhAgSGB5tsHUcuGH3V4VGx5Dz3qa0xoE
 zlp0eY1nQT9oTWzSMNS9LglrKCvVxj3ubZ/GCi2v3O15/Ab5kIyHNq/W7HkJit6IHS
 PtJ7fhjDJglvGjTLNpKRug0sG1uSRBZVzH4OAsGJdPBDHRuQKW78abYTPEPmMSkO2V
 VXCZ/a9xjZENimYK1kVsoh9lUJNiNczkshIh5S/VJ1cmjrH5XCLJXsbdYtdWNL8Xh8
 FJLYOWnjYNzRw==
X-Nifty-SrcIP: [119.150.36.16]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH 0/8] Several modifications for pty and console code.
Date: Sun, 13 Feb 2022 23:39:02 +0900
Message-Id: <20220213143910.1947-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, RCVD_IN_DNSWL_NONE, SPF_HELO_NONE,
 SPF_PASS, TXREP,
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
X-List-Received-Date: Sun, 13 Feb 2022 14:39:48 -0000

Takashi Yano (8):
  Cygwin: pty, console: Fix Ctrl-C handling for non-cygwin apps.
  Cygwin: pty: Pass Ctrl-Z (EOF) to non-cygwin apps with disable_pcon.
  Cygwin: pty: Prevent deadlock on echo output.
  Cygwin: pty: Revise the code to wait for completion of forwarding.
  Cygwin: pty: Discard input in from_master_nat pipe on signal as well.
  Cygwin: pty: Fix a bug in tty_min::segpgid().
  Cygwin: console: Fix console mode for non-cygwin inferior of GDB.
  Cygwin: console: Set console mode even if stdin/stdout is redirected.

 winsup/cygwin/fhandler.h          |   2 +
 winsup/cygwin/fhandler_console.cc |  67 +++++++++++++++
 winsup/cygwin/fhandler_termios.cc |  47 +++++++++-
 winsup/cygwin/fhandler_tty.cc     | 138 ++++++++++++++++--------------
 winsup/cygwin/spawn.cc            |  19 ++--
 winsup/cygwin/tty.cc              |  14 +--
 winsup/cygwin/tty.h               |   3 +-
 7 files changed, 204 insertions(+), 86 deletions(-)

-- 
2.35.1

