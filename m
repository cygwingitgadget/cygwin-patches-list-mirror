Return-Path: <mark@maxrnd.com>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
 by sourceware.org (Postfix) with ESMTPS id D08A13850413
 for <cygwin-patches@cygwin.com>; Wed, 23 Jun 2021 08:56:39 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org D08A13850413
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=maxrnd.com
Received: (from daemon@localhost)
 by m0.truegem.net (8.12.11/8.12.11) id 15N8ucg1069174;
 Wed, 23 Jun 2021 01:56:38 -0700 (PDT) (envelope-from mark@maxrnd.com)
Received: from 162-235-43-67.lightspeed.irvnca.sbcglobal.net(162.235.43.67),
 claiming to be "localhost.localdomain"
 via SMTP by m0.truegem.net, id smtpdV0KnhI; Wed Jun 23 01:56:35 2021
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: Zero out gmon header before use
Date: Wed, 23 Jun 2021 01:56:14 -0700
Message-Id: <20210623085614.1697-1-mark@maxrnd.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.1 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, SPF_HELO_NONE, SPF_NONE,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Wed, 23 Jun 2021 08:56:41 -0000

Tools that process gmon.out files can be confused by gmon header fields
with garbage in them due to lack of initialization.  Repair that.

---
 winsup/cygwin/gmon.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/winsup/cygwin/gmon.c b/winsup/cygwin/gmon.c
index b31842cd9..8b1c449c4 100644
--- a/winsup/cygwin/gmon.c
+++ b/winsup/cygwin/gmon.c
@@ -224,6 +224,7 @@ _mcleanup(void)
 	write(log, dbuf, len);
 #endif
 	hdr = (struct gmonhdr *)&gmonhdr;
+	bzero(hdr, sizeof *hdr);
 	hdr->lpc = p->lowpc;
 	hdr->hpc = p->highpc;
 	hdr->ncnt = p->kcountsize + sizeof(gmonhdr);
-- 
2.31.1

