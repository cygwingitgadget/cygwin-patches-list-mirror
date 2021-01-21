Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-10.nifty.com (conuserg-10.nifty.com [210.131.2.77])
 by sourceware.org (Postfix) with ESMTPS id A93803854804
 for <cygwin-patches@cygwin.com>; Thu, 21 Jan 2021 13:10:22 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org A93803854804
Received: from localhost.localdomain (x067108.dynamic.ppp.asahi-net.or.jp
 [122.249.67.108]) (authenticated)
 by conuserg-10.nifty.com with ESMTP id 10LD9eEV019369;
 Thu, 21 Jan 2021 22:09:49 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 10LD9eEV019369
X-Nifty-SrcIP: [122.249.67.108]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH 0/4] Improve pseudo console support.
Date: Thu, 21 Jan 2021 22:09:07 +0900
Message-Id: <20210121130911.855-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, RCVD_IN_DNSWL_NONE, SPF_HELO_NONE,
 SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Thu, 21 Jan 2021 13:10:26 -0000

The new implementation of pseudo console support by commit bb428520
provides the important advantages, while there also has been several
disadvantages compared to the previous implementation.

These patches overturn some of them.

The disadvantage:
 1) The cygwin program which calls console API directly does not work.
is supposed to be able to be overcome as well, however, I am not sure
it is worth enough. This will need a lot of hooks for console APIs.

Takashi Yano (4):
  Cygwin: pty: Inherit typeahead data between two input pipes.
  Cygwin: pty: Keep code page between non-cygwin apps.
  Cygwin: pty: Make apps using console APIs be able to debug with gdb.
  Cygwin: pty: Allow multiple apps to enable pseudo console
    simultaneously.

 winsup/cygwin/fhandler.h      |  15 +-
 winsup/cygwin/fhandler_tty.cc | 800 ++++++++++++++++++++++++++--------
 winsup/cygwin/spawn.cc        | 102 +++--
 winsup/cygwin/tty.cc          |  11 +-
 winsup/cygwin/tty.h           |  18 +-
 5 files changed, 725 insertions(+), 221 deletions(-)

-- 
2.30.0

