Return-Path: <mark@maxrnd.com>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
 by sourceware.org (Postfix) with ESMTPS id 14656388A829
 for <cygwin-patches@cygwin.com>; Wed, 13 May 2020 08:24:21 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 14656388A829
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=mark@maxrnd.com
Received: (from daemon@localhost)
 by m0.truegem.net (8.12.11/8.12.11) id 04D8OKtl090262;
 Wed, 13 May 2020 01:24:20 -0700 (PDT) (envelope-from mark@maxrnd.com)
Received: from 162-235-43-67.lightspeed.irvnca.sbcglobal.net(162.235.43.67),
 claiming to be "localhost.localdomain"
 via SMTP by m0.truegem.net, id smtpd9YcvMa; Wed May 13 01:24:12 2020
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Subject: [Cygwin PATCH 1/9] tzcode resync: Makefile.in
Date: Wed, 13 May 2020 01:23:41 -0700
Message-Id: <20200513082349.831-1-mark@maxrnd.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=BAYES_00, GIT_PATCH_0,
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

Establish cygwin subdirectory tzcode to hold updates to imported NetBSD files.

---
 winsup/cygwin/Makefile.in | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/Makefile.in b/winsup/cygwin/Makefile.in
index f273ba793..69aa2277e 100644
--- a/winsup/cygwin/Makefile.in
+++ b/winsup/cygwin/Makefile.in
@@ -27,7 +27,7 @@ export CCWRAP_HEADERS:=. ${srcdir}
 export CCWRAP_SYSTEM_HEADERS:=@cygwin_headers@ @newlib_headers@
 export CCWRAP_DIRAFTER_HEADERS:=@windows_headers@
 
-VPATH+=$(srcdir)/regex $(srcdir)/lib $(srcdir)/libc $(srcdir)/math
+VPATH+=$(srcdir)/regex $(srcdir)/lib $(srcdir)/libc $(srcdir)/math $(srcdir)/tzcode
 
 target_cpu:=@target_cpu@
 target_alias:=@target_alias@
@@ -246,6 +246,8 @@ MATH_OFILES:= \
 	tgammal.o \
 	truncl.o
 
+TZCODE_OFILES:=localtime.o
+
 DLL_OFILES:= \
 	advapi32.o \
 	aio.o \
@@ -333,7 +335,6 @@ DLL_OFILES:= \
 	ldap.o \
 	libstdcxx_wrapper.o \
 	loadavg.o \
-	localtime.o \
 	lsearch.o \
 	malloc_wrapper.o \
 	minires-os-if.o \
@@ -412,6 +413,7 @@ DLL_OFILES:= \
 	$(EXTRA_OFILES) \
 	$(MALLOC_OFILES) \
 	$(MATH_OFILES) \
+	$(TZCODE_OFILES) \
 	$(MT_SAFE_OBJECTS)
 
 EXCLUDE_STATIC_OFILES:=$(addprefix --exclude=,\
-- 
2.21.0

