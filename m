Return-Path: <mark@maxrnd.com>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
 by sourceware.org (Postfix) with ESMTPS id 978543840C0F
 for <cygwin-patches@cygwin.com>; Tue, 19 May 2020 05:02:44 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 978543840C0F
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=mark@maxrnd.com
Received: (from daemon@localhost)
 by m0.truegem.net (8.12.11/8.12.11) id 04J52hZ7038163
 for <cygwin-patches@cygwin.com>; Mon, 18 May 2020 22:02:43 -0700 (PDT)
 (envelope-from mark@maxrnd.com)
Received: from 162-235-43-67.lightspeed.irvnca.sbcglobal.net(162.235.43.67),
 claiming to be "localhost.localdomain"
 via SMTP by m0.truegem.net, id smtpd5HtRUo; Mon May 18 22:02:40 2020
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH 0/3] Cygwin: tzcode resync v2
Date: Mon, 18 May 2020 22:02:26 -0700
Message-Id: <20200519050229.28209-1-mark@maxrnd.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00, KAM_DMARC_STATUS,
 KAM_LAZY_DOMAIN_SECURITY, KAM_NUMSUBJECT, SPF_HELO_NONE, SPF_NONE,
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
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Tue, 19 May 2020 05:02:47 -0000

This is a reorganization of the previous patch contents to cut down on
extraneous material.  It seems to be complete and could thus be applied
to a copy of the newlib-cygwin tree successfully for testing or review.

Methods of testing can be discussed by reply to this post, or on
cygwin-developers, whichever is most appropriate.  I'm also open to other
strategies of implementation if this one seems risky or unattractive for
some reason.

..mark

[PATCH 1/3] Cygwin: tzcode resync v2: basics
[PATCH 2/3] Cygwin: tzcode resync v2: imports
[PATCH 3/3] Cygwin: tzcode resync v2: details

