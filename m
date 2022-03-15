Return-Path: <mark@maxrnd.com>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
 by sourceware.org (Postfix) with ESMTPS id 64DED3858D20
 for <cygwin-patches@cygwin.com>; Tue, 15 Mar 2022 00:47:48 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 64DED3858D20
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=maxrnd.com
Received: (from daemon@localhost)
 by m0.truegem.net (8.12.11/8.12.11) id 22F0llcE021427;
 Mon, 14 Mar 2022 17:47:47 -0700 (PDT) (envelope-from mark@maxrnd.com)
Received: from 162-235-43-67.lightspeed.irvnca.sbcglobal.net(162.235.43.67),
 claiming to be "localhost.localdomain"
 via SMTP by m0.truegem.net, id smtpd9j8EAo; Mon Mar 14 16:47:45 2022
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: Fix gmondump formatting goofs
Date: Mon, 14 Mar 2022 17:47:30 -0700
Message-Id: <20220315004730.15783-1-mark@maxrnd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, SPF_HELO_NONE, SPF_NONE, TXREP,
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
X-List-Received-Date: Tue, 15 Mar 2022 00:47:50 -0000

The rewrite of %X to %p was malhandled.  Fix that/them.

---
 winsup/utils/gmondump.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/winsup/utils/gmondump.c b/winsup/utils/gmondump.c
index ec9db0598..2d29e826d 100644
--- a/winsup/utils/gmondump.c
+++ b/winsup/utils/gmondump.c
@@ -162,7 +162,7 @@ gmondump1 (char *filename)
 
   note ("file %s, gmon version 0x%x, sample rate %d\n",
         filename, hdr.version, hdr.profrate);
-  note ("  address range 0x%p..0x%p\n", hdr.lpc, hdr.hpc);
+  note ("  address range %p..%p\n", hdr.lpc, hdr.hpc);
   note ("  numbuckets %d, hitbuckets %d, hitcount %d, numrawarcs %d\n",
         numbuckets, hitbuckets, hitcount, numrawarcs);
 
@@ -175,7 +175,7 @@ gmondump1 (char *filename)
       int   incr = (hdr.hpc - hdr.lpc) / numbuckets;
       for (res = 0; res < numbuckets; ++bucket, ++res, addr += incr)
         if (*bucket)
-          note ("    address 0x%p, hitcount %d\n", addr, *bucket);
+          note ("    address %p, hitcount %d\n", addr, *bucket);
       bucket -= numbuckets;
 
       if (numrawarcs)
@@ -186,7 +186,7 @@ gmondump1 (char *filename)
             error (0, "unable to read rawarc data");
           note ("  rawarc data follows...\n");
           for (res = 0; res < numrawarcs; ++rawarc, ++res)
-            note ("    from 0x%p, self 0x%p, count %d\n",
+            note ("    from %p, self %p, count %d\n",
                   rawarc->raw_frompc, rawarc->raw_selfpc, rawarc->raw_count);
         }
     }
-- 
2.35.1

