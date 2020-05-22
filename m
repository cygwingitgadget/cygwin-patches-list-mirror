Return-Path: <mark@maxrnd.com>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
 by sourceware.org (Postfix) with ESMTPS id F3CAC3851C0C
 for <cygwin-patches@cygwin.com>; Fri, 22 May 2020 09:33:11 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org F3CAC3851C0C
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=mark@maxrnd.com
Received: (from daemon@localhost)
 by m0.truegem.net (8.12.11/8.12.11) id 04M9XAgr026033
 for <cygwin-patches@cygwin.com>; Fri, 22 May 2020 02:33:10 -0700 (PDT)
 (envelope-from mark@maxrnd.com)
Received: from 162-235-43-67.lightspeed.irvnca.sbcglobal.net(162.235.43.67),
 claiming to be "localhost.localdomain"
 via SMTP by m0.truegem.net, id smtpdW9Ju0J; Fri May 22 02:33:04 2020
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH 0/3 v3] Cygwin: tzcode resync
Date: Fri, 22 May 2020 02:32:50 -0700
Message-Id: <20200522093253.995-1-mark@maxrnd.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.4 required=5.0 tests=BAYES_00, KAM_DMARC_STATUS,
 KAM_LAZY_DOMAIN_SECURITY, SPF_HELO_NONE, SPF_NONE,
 TXREP autolearn=no autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Fri, 22 May 2020 09:33:15 -0000

This is v3 of this patch set incorporating review comments on v2.  I've
minimized the size of the localtime.c.patch file by beefing up #defines
in the wrapper localtime.cc.  I believe I've addressed all comments.

This patch set has been tested on both 64- and 32-bit Cygwin.  The
initial shell opens with timezone correctly set.  xclock, date, uptime
all show the correct local time.  Overriding TZ in the environment on a
call to date, as in 'TZ=Asia/Tokyo date' shows correctly adjusted time.

..mark

[PATCH 1/3 v3] Cygwin: tzcode resync: basics
[PATCH 2/3 v3] Cygwin: tzcode resync: imports
[PATCH 3/3 v3] Cygwin: tzcode resync: details

