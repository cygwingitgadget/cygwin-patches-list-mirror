Return-Path: <SRS0=rdKM=DZ=dronecode.org.uk=jon.turney@sourceware.org>
Received: from sa-prd-fep-043.btinternet.com (mailomta27-sa.btinternet.com [213.120.69.33])
	by sourceware.org (Postfix) with ESMTPS id DF2823858005
	for <cygwin-patches@cygwin.com>; Tue,  8 Aug 2023 16:02:18 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org DF2823858005
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
Received: from sa-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.38.8])
          by sa-prd-fep-043.btinternet.com with ESMTP
          id <20230808160217.FQOQ1396.sa-prd-fep-043.btinternet.com@sa-prd-rgout-005.btmx-prd.synchronoss.net>;
          Tue, 8 Aug 2023 17:02:17 +0100
Authentication-Results: btinternet.com;
    auth=pass (LOGIN) smtp.auth=jonturney@btinternet.com;
    bimi=skipped
X-SNCR-Rigid: 64CADCC500AD6584
X-Originating-IP: [86.140.112.76]
X-OWM-Source-IP: 86.140.112.76 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedviedrledvgdelhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpefhuefgheehtdfgfeevtdevleekgfejleegfffgieejleeugffftefgvdduudeiudenucffohhmrghinheptgihghifihhnrdgtohhmnecukfhppeekiedrudegtddrudduvddrjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudegtddrudduvddrjeeipdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdpnhgspghrtghpthhtohepvddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmpdhrtghpthhtohepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdprhgvvhfkrfephhhoshhtkeeiqddugedtqdduuddvqdejiedrrhgrnhhgvgekiedqudegtddrsghttggvnhhtrhgrlhhplhhushdrtghomhdprghuthhhpghushgvrhepjhhonhhtuhhrnhgvhies
	sghtihhnthgvrhhnvghtrdgtohhmpdhgvghokffrpefiuedpoffvtefjohhsthepshgrqdhprhguqdhrghhouhhtqddttdeh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.140.112.76) by sa-prd-rgout-005.btmx-prd.synchronoss.net (5.8.814.02) (authenticated as jonturney@btinternet.com)
        id 64CADCC500AD6584; Tue, 8 Aug 2023 17:02:17 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH] Cygwin: testsuite: Add socketpair_full test
Date: Tue,  8 Aug 2023 17:01:57 +0100
Message-Id: <20230808160157.6571-1-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Add the socketpair_full test from [1], fixed by [2], slightly improved by
the addition of a timeout.

This test might perhaps be better named.

This might also serve as an example of how to add new tests.

[1] https://cygwin.com/pipermail/cygwin-developers/2023-July/012640.html
[2] dedbbd74d0a8 ("Cygwin: select: workaround FD_WRITE network event handling")

---
 winsup/testsuite/Makefile.am                  |  1 +
 winsup/testsuite/winsup.api/socketpair_full.c | 59 +++++++++++++++++++
 2 files changed, 60 insertions(+)
 create mode 100644 winsup/testsuite/winsup.api/socketpair_full.c

diff --git a/winsup/testsuite/Makefile.am b/winsup/testsuite/Makefile.am
index 228955668..28b23b758 100644
--- a/winsup/testsuite/Makefile.am
+++ b/winsup/testsuite/Makefile.am
@@ -48,6 +48,7 @@ check_PROGRAMS = \
 	winsup.api/shmtest \
 	winsup.api/sigchld \
 	winsup.api/signal-into-win32-api \
+	winsup.api/socketpair_full \
 	winsup.api/systemcall \
 	winsup.api/user_malloc \
 	winsup.api/waitpid \
diff --git a/winsup/testsuite/winsup.api/socketpair_full.c b/winsup/testsuite/winsup.api/socketpair_full.c
new file mode 100644
index 000000000..d432bc76d
--- /dev/null
+++ b/winsup/testsuite/winsup.api/socketpair_full.c
@@ -0,0 +1,59 @@
+//
+// This test verifies that a socket correctly indicates not ready to write when
+// poll()ed if a subsequent write() would block
+//
+//
+
+#include <assert.h>
+#include <poll.h>
+#include <stdio.h>
+#include <sys/socket.h>
+#include <unistd.h>
+
+static void timeout(int signum)
+{
+  exit(1);
+}
+
+int main()
+{
+  char wbuf[100] = { 0, };
+  int out;
+
+  signal(SIGALRM, timeout);
+
+  {
+    int sv[2];
+    int s;
+
+    s = socketpair (AF_UNIX, SOCK_STREAM, 0, sv);
+    assert (s == 0);
+
+    out = sv[0];
+  }
+
+  size_t in_flight = 0;
+  while (1)
+    {
+      struct pollfd fds[1];
+      fds[0].fd = out;
+      fds[0].events = POLLOUT;
+
+      int r = poll(fds, 1, 0);
+      assert(r >= 0);
+
+      // fd is not ready to write
+      if (!(fds[0].revents & POLLOUT))
+        break;
+
+      alarm(5);
+
+      // otherwise, fd is ready to write, implies some data may be written without blocking
+      ssize_t s = write (out, wbuf, sizeof wbuf);
+      assert (s > 0);
+      in_flight += s;
+      printf("%zd written, total in_flight %zd\n", s, in_flight);
+
+      alarm(0);
+    }
+}
-- 
2.39.0

