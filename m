Return-Path: <mark@maxrnd.com>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
 by sourceware.org (Postfix) with ESMTPS id 0C7B73857C66
 for <cygwin-patches@cygwin.com>; Mon,  7 Dec 2020 06:17:30 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 0C7B73857C66
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=mark@maxrnd.com
Received: (from daemon@localhost)
 by m0.truegem.net (8.12.11/8.12.11) id 0B76HTvI059522;
 Sun, 6 Dec 2020 22:17:29 -0800 (PST) (envelope-from mark@maxrnd.com)
Received: from 162-235-43-67.lightspeed.irvnca.sbcglobal.net(162.235.43.67),
 claiming to be "localhost.localdomain"
 via SMTP by m0.truegem.net, id smtpdPioE7q; Sun Dec  6 22:17:26 2020
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: Launch cygmagic with bash, not sh
Date: Sun,  6 Dec 2020 22:17:15 -0800
Message-Id: <20201207061715.1028-1-mark@maxrnd.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.4 required=5.0 tests=BAYES_00, GIT_PATCH_0,
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
X-List-Received-Date: Mon, 07 Dec 2020 06:17:34 -0000

On some systems /bin/sh is not /bin/bash and cygmagic has bash-isms in
it.  So even though cygmagic has a /bin/bash shebang, it also needs to be
launched with bash from within Makefile.in.

---
 winsup/cygwin/Makefile.in | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/Makefile.in b/winsup/cygwin/Makefile.in
index b15c746cf..a840f2b83 100644
--- a/winsup/cygwin/Makefile.in
+++ b/winsup/cygwin/Makefile.in
@@ -683,10 +683,10 @@ globals.h: mkglobals_h globals.cc
 ${DLL_OFILES} ${LIBCOS}: globals.h $(srcdir)/$(TLSOFFSETS_H)
 
 shared_info_magic.h: cygmagic shared_info.h
-	/bin/sh $(word 1,$^) $@ "${COMPILE.cc} -E -x c++" $(word 2,$^) SHARED_MAGIC 'class shared_info' USER_MAGIC 'class user_info'
+	/bin/bash $(word 1,$^) $@ "${COMPILE.cc} -E -x c++" $(word 2,$^) SHARED_MAGIC 'class shared_info' USER_MAGIC 'class user_info'
 
 child_info_magic.h: cygmagic child_info.h
-	/bin/sh $(word 1,$^) $@ "${COMPILE.cc} -E -x c++" $(word 2,$^) CHILD_INFO_MAGIC 'class child_info'
+	/bin/bash $(word 1,$^) $@ "${COMPILE.cc} -E -x c++" $(word 2,$^) CHILD_INFO_MAGIC 'class child_info'
 
 dcrt0.o sigproc.o: child_info_magic.h
 
-- 
2.29.2

