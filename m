Return-Path: <jon.turney@dronecode.org.uk>
Received: from sa-prd-fep-049.btinternet.com (mailomta8-sa.btinternet.com
 [213.120.69.14])
 by sourceware.org (Postfix) with ESMTPS id EE0F639FF057
 for <cygwin-patches@cygwin.com>; Thu, 12 Nov 2020 19:46:50 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org EE0F639FF057
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from sa-prd-rgout-004.btmx-prd.synchronoss.net ([10.2.38.7])
 by sa-prd-fep-049.btinternet.com with ESMTP id
 <20201112194649.LITY8377.sa-prd-fep-049.btinternet.com@sa-prd-rgout-004.btmx-prd.synchronoss.net>;
 Thu, 12 Nov 2020 19:46:49 +0000
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 5ED9B6611A29D170
X-Originating-IP: [86.139.158.14]
X-OWM-Source-IP: 86.139.158.14 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedujedruddvfedguddthecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepfeeiudevhefgffffueeuheelfeegveefvdffleejfeehudetleetledvteethfdvnecukfhppeekiedrudefledrudehkedrudegnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudefledrudehkedrudegpdhmrghilhhfrhhomhepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqedprhgtphhtthhopeeotgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomheqpdhrtghpthhtohepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.139.158.14) by
 sa-prd-rgout-004.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9B6611A29D170; Thu, 12 Nov 2020 19:46:49 +0000
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 3/4] Fix 'make check' in utils
Date: Thu, 12 Nov 2020 19:46:27 +0000
Message-Id: <20201112194629.13493-4-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201112194629.13493-1-jon.turney@dronecode.org.uk>
References: <20201112194629.13493-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1200.7 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 GIT_PATCH_0, KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H4, RCVD_IN_MSPIKE_WL, SPF_HELO_PASS, SPF_NONE,
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
X-List-Received-Date: Thu, 12 Nov 2020 19:46:52 -0000

This has a test of the path translation code used in various
utilities (mount, cygpath, strace).

MOUNT_BINARY is replaced with the absence of MOUNT_TEXT since 26e0b37e.
The isys member of mnt_t struct was removed in b677a99b.

> $ make check
[...]
> total tests: 63
> pass       : 63 (100.0%)
> fail       : 0 (0.0%)
---
 winsup/utils/Makefile.in |  4 ++--
 winsup/utils/path.h      |  2 ++
 winsup/utils/testsuite.h | 16 ++++++++--------
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/winsup/utils/Makefile.in b/winsup/utils/Makefile.in
index a9d66a5ee..46ca13c04 100644
--- a/winsup/utils/Makefile.in
+++ b/winsup/utils/Makefile.in
@@ -123,9 +123,9 @@ MINGW_BINS += testsuite.exe
 MINGW_OBJS += path-testsuite.o testsuite.o
 testsuite.exe: path-testsuite.o
 path-testsuite.cc: path.cc ; @test -L $@ || ln -sf ${filter %.cc,$^} $@
-path-testsuite.o: MINGW_CXXFLAGS += -DTESTSUITE
+path-testsuite.o: MINGW_CXXFLAGS += -DTESTSUITE -Wno-error=write-strings
 # this is necessary because this .c lives in the build dir instead of src
-path-testsuite.o: MINGW_CXX := ${patsubst -I.,-I$(utils_source),$(MINGW_CXX)}
+path-testsuite.o: MINGW_CXXFLAGS += -I$(srcdir)
 path-testsuite.cc path.cc testsuite.cc: testsuite.h
 check: testsuite.exe ; $(<D)/$(<F)
 
diff --git a/winsup/utils/path.h b/winsup/utils/path.h
index ee7c28a7a..af5deeba6 100644
--- a/winsup/utils/path.h
+++ b/winsup/utils/path.h
@@ -22,7 +22,9 @@ int get_word (HANDLE, int);
 int get_dword (HANDLE, int);
 bool from_fstab_line (mnt_t *m, char *line, bool user);
 
+#ifndef TESTSUITE
 extern mnt_t mount_table[255];
+#endif
 extern int max_mount_entry;
 
 #ifndef SYMLINK_MAX
diff --git a/winsup/utils/testsuite.h b/winsup/utils/testsuite.h
index 4ed9eb2c4..d0a47b23a 100644
--- a/winsup/utils/testsuite.h
+++ b/winsup/utils/testsuite.h
@@ -29,14 +29,14 @@ details. */
 
 #if defined(TESTSUITE_MOUNT_TABLE)
 static mnt_t mount_table[] = {
-/* native                 posix               flags                        issys */
- { TESTSUITE_ROOT,        (char*)"/",                MOUNT_BINARY | MOUNT_SYSTEM, 1 },
- { "O:\\other",           (char*)"/otherdir",        MOUNT_BINARY | MOUNT_SYSTEM, 1 },
- { "S:\\some\\dir",       (char*)"/somedir",         MOUNT_BINARY | MOUNT_SYSTEM, 1 },
- { TESTSUITE_ROOT"\\bin", (char*)"/usr/bin",         MOUNT_BINARY | MOUNT_SYSTEM, 1 },
- { TESTSUITE_ROOT"\\lib", (char*)"/usr/lib",         MOUNT_BINARY | MOUNT_SYSTEM, 1 },
- { ".",                   (char*)TESTSUITE_CYGDRIVE, MOUNT_BINARY | MOUNT_SYSTEM | MOUNT_CYGDRIVE, 1 },
- { NULL,                  (char*)NULL,               0,                           0 }
+/* native                 posix               flags */
+ { TESTSUITE_ROOT,        (char*)"/",                MOUNT_SYSTEM},
+ { "O:\\other",           (char*)"/otherdir",        MOUNT_SYSTEM},
+ { "S:\\some\\dir",       (char*)"/somedir",         MOUNT_SYSTEM},
+ { TESTSUITE_ROOT"\\bin", (char*)"/usr/bin",         MOUNT_SYSTEM},
+ { TESTSUITE_ROOT"\\lib", (char*)"/usr/lib",         MOUNT_SYSTEM},
+ { ".",                   (char*)TESTSUITE_CYGDRIVE, MOUNT_SYSTEM | MOUNT_CYGDRIVE},
+ { NULL,                  (char*)NULL,               0}
 };
 
 
-- 
2.29.2

