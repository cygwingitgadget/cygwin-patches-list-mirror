Return-Path: <mark@maxrnd.com>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
 by sourceware.org (Postfix) with ESMTPS id 0E343388A835
 for <cygwin-patches@cygwin.com>; Wed, 13 May 2020 08:24:25 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 0E343388A835
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=mark@maxrnd.com
Received: (from daemon@localhost)
 by m0.truegem.net (8.12.11/8.12.11) id 04D8OKf9090265;
 Wed, 13 May 2020 01:24:20 -0700 (PDT) (envelope-from mark@maxrnd.com)
Received: from 162-235-43-67.lightspeed.irvnca.sbcglobal.net(162.235.43.67),
 claiming to be "localhost.localdomain"
 via SMTP by m0.truegem.net, id smtpdFXH8xz; Wed May 13 01:24:14 2020
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Subject: [Cygwin PATCH 2/9] tzcode resync: README
Date: Wed, 13 May 2020 01:23:42 -0700
Message-Id: <20200513082349.831-2-mark@maxrnd.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200513082349.831-1-mark@maxrnd.com>
References: <20200513082349.831-1-mark@maxrnd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-14.9 required=5.0 tests=BAYES_00, GIT_PATCH_0,
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
X-List-Received-Date: Wed, 13 May 2020 08:24:27 -0000

---
 winsup/cygwin/tzcode/README | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 winsup/cygwin/tzcode/README

diff --git a/winsup/cygwin/tzcode/README b/winsup/cygwin/tzcode/README
new file mode 100644
index 000000000..a200502ea
--- /dev/null
+++ b/winsup/cygwin/tzcode/README
@@ -0,0 +1,37 @@
+/*
+	How the code in this directory is supposed to work...
+	2020/05/13 Mark Geisert <mark@maxrnd.com>
+
+	localtime.cc is the Cygwin-specific module that is compiled into
+	the Cygwin DLL when the latter is built.  It's just a wrapper that
+	#defines a bunch of stuff then #includes localtime.c.
+
+	localtime.c, at any point in time, is a reasonably recent version
+	of /src/lib/libc/time/localtime.c from NetBSD.  The same goes for
+	private.h and tzfile.h.  OTOH namespace.h implements something on
+	NetBSD that is not provided on Cygwin, so it's empty here.
+
+	The idea is that in the future, one just needs to bring over newer
+	versions of localtime.c, private.h, and/or tzfile.h from NetBSD as
+	they become available.
+
+	With luck, you can drop those files into this directory and they
+	can be immediately used to build a newer Cygwin DLL that has the
+	newer NetBSD functionality.  Without luck, you'll have to tweak the
+	wrapper localtime.cc.  In the worst case, some other strategy will
+	need to be figured out, such as manually pulling out the parts of
+	the NetBSD code Cygwin needs to build a stand-alone localtime.cc.
+
+	Re tz_posixrules.h: The data elements can be generated from
+	/usr/share/zoneinfo/posixrules in any version of Cygwin's tzdata
+	package.  Instructions are in the comment heading tz_posixrules.h.
+
+	Addendum:
+	Implementation of the strategy above has uncovered a small number
+	of NetBSD-isms in localtime.c that cannot be worked around with
+	preprocessor tricks.  So there is another file localtime.c.patched
+	that holds just these adjustments for Cygwin, and it's this file
+	that localtime.cc #includes.
+
+	..mark
+*/
-- 
2.21.0

