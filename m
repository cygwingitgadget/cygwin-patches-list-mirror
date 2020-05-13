Return-Path: <mark@maxrnd.com>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
 by sourceware.org (Postfix) with ESMTPS id 1BF48388A835
 for <cygwin-patches@cygwin.com>; Wed, 13 May 2020 08:24:22 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 1BF48388A835
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=mark@maxrnd.com
Received: (from daemon@localhost)
 by m0.truegem.net (8.12.11/8.12.11) id 04D8OLi2090319;
 Wed, 13 May 2020 01:24:21 -0700 (PDT) (envelope-from mark@maxrnd.com)
Received: from 162-235-43-67.lightspeed.irvnca.sbcglobal.net(162.235.43.67),
 claiming to be "localhost.localdomain"
 via SMTP by m0.truegem.net, id smtpdT4MJmv; Wed May 13 01:24:15 2020
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Subject: [Cygwin PATCH 6/9] tzcode resync: namespace.h
Date: Wed, 13 May 2020 01:23:46 -0700
Message-Id: <20200513082349.831-6-mark@maxrnd.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200513082349.831-1-mark@maxrnd.com>
References: <20200513082349.831-1-mark@maxrnd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-16.0 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, SPF_HELO_NONE, SPF_NONE,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
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
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Wed, 13 May 2020 08:24:24 -0000

Empty file not including current NetBSD namespace.h because Cygwin
doesn't implement that functionality.  This allows compilation that
avoids an error due to a missing include file.

---
 winsup/cygwin/tzcode/namespace.h | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 winsup/cygwin/tzcode/namespace.h

diff --git a/winsup/cygwin/tzcode/namespace.h b/winsup/cygwin/tzcode/namespace.h
new file mode 100644
index 000000000..e69de29bb
-- 
2.21.0

