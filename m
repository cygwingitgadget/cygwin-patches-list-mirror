Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
 by sourceware.org (Postfix) with ESMTPS id 4C4903840C22
 for <cygwin-patches@cygwin.com>; Mon, 25 Jan 2021 09:40:47 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 4C4903840C22
Received: from localhost.localdomain (x067108.dynamic.ppp.asahi-net.or.jp
 [122.249.67.108]) (authenticated)
 by conuserg-08.nifty.com with ESMTP id 10P9e6xR020289;
 Mon, 25 Jan 2021 18:40:13 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 10P9e6xR020289
X-Nifty-SrcIP: [122.249.67.108]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH v3 0/4] Improve pseudo console support.
Date: Mon, 25 Jan 2021 18:39:46 +0900
Message-Id: <20210125093950.1386-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Mon, 25 Jan 2021 09:40:48 -0000

The new implementation of pseudo console support by commit bb428520
provides the important advantages, while there also has been several
disadvantages compared to the previous implementation.

These patches overturn some of them.

The disadvantage:
 1) The cygwin program which calls console API directly does not work.
is supposed to be able to be overcome as well, however, I am not sure
it is worth enough. This will need a lot of hooks for console APIs.
 --> Respecting Corinna's opinion, we decided not to implement this.

v3: Fix typeahead input issue in GDB. Several other bugs have also
    been fixed.

Takashi Yano (4):
  Cygwin: pty: Inherit typeahead data between two input pipes.
  Cygwin: pty: Keep code page between non-cygwin apps.
  Cygwin: pty: Make apps using console APIs be able to debug with gdb.
  Cygwin: pty: Allow multiple apps to enable pseudo console
    simultaneously.

 winsup/cygwin/fhandler.h      |   18 +-
 winsup/cygwin/fhandler_tty.cc | 1016 +++++++++++++++++++++++++++------
 winsup/cygwin/select.cc       |   18 +-
 winsup/cygwin/select.h        |    8 +-
 winsup/cygwin/spawn.cc        |  102 ++--
 winsup/cygwin/tty.cc          |   11 +-
 winsup/cygwin/tty.h           |   18 +-
 7 files changed, 956 insertions(+), 235 deletions(-)

-- 
2.30.0

