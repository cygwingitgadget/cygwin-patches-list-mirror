Return-Path: <SRS0=RPmn=WI=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo001.btinternet.com (btprdrgo001.btinternet.com [65.20.50.6])
	by sourceware.org (Postfix) with ESMTP id AF918385842C
	for <cygwin-patches@cygwin.com>; Fri, 21 Mar 2025 14:08:16 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org AF918385842C
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org AF918385842C
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.6
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1742566096; cv=none;
	b=TFhbeVtDwTgvvrHIkL49pNyWMXmZmaYzmYPzmL24Qb3X36gi8QWUmD23fRDULduZcI8+AJM82NDijbP346xOoG3Z66V3e5YAaDDPB1RSPTneMyF+Q8xykXfrZbjC9RM55tVfnGj1ZVPoCESw3cCA8daix+8qzkCNebzmvkgEev8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1742566096; c=relaxed/simple;
	bh=1Zul2ijYlgzWJirfIKy4zCHE6ixubGGkfA0h1QMkGDs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=amnAeICPcZWxQ3tVPcvpZMIDwtGwSHs5lsxh5Z69i71NO9nURORVpOO3ssIP1JPKcGbAls0xMy9609sTch2Ls9mzUjWodUzW3WBqGZjCvEQGOiW1zwgom8krw7pNjHCGjpEl+UYMLwTtmt/fQNcxX41mbnHQAJzp6w94x/zD7Gw=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org AF918385842C
Authentication-Results: btinternet.com;
    auth=pass (LOGIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 67D89BE20091593C
X-Originating-IP: [81.153.98.178]
X-OWM-Source-IP: 81.153.98.178
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduhedufedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepleeitdejhfdtveekheeugeffgeevfedtjeejveefhfeiffefkedtvdetheehieejnecukfhppeekuddrudehfedrleekrddujeeknecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekuddrudehfedrleekrddujeekpdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdprhgvvhfkrfephhhoshhtkeduqdduheefqdelkedqudejkedrrhgrnhhgvgekuddqudehfedrsghttggvnhhtrhgrlhhplhhushdrtghomhdprghuthhhpghushgvrhepjhhonhhtuhhrnhgvhiessghtihhnthgvrhhnvghtrdgtohhmpdhgvghokffrpefiuedpoffvtefjohhsthepsghtphhrughrghhotddtuddpnhgspghrtghpthhtohepvddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmpdhrtghpthht
	ohepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (81.153.98.178) by btprdrgo001.btinternet.com (authenticated as jonturney@btinternet.com)
        id 67D89BE20091593C; Fri, 21 Mar 2025 14:08:15 +0000
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 2/2] Revert "Cygwin: CI: XFAIL umask03"
Date: Fri, 21 Mar 2025 14:08:02 +0000
Message-ID: <20250321140803.2155-1-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250321140502.2122-1-jon.turney@dronecode.org.uk>
References: <20250321140502.2122-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This reverts commit cbe7543cdfdb7f3d270214877d4a4c3e78710bd3.
---
 winsup/testsuite/Makefile.am | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/winsup/testsuite/Makefile.am b/winsup/testsuite/Makefile.am
index 228955668..8f2967a6d 100644
--- a/winsup/testsuite/Makefile.am
+++ b/winsup/testsuite/Makefile.am
@@ -333,16 +333,12 @@ TESTS = $(check_PROGRAMS) \
 	mingw/cygload
 
 # expected fail tests
-XFAIL_TESTS_CI_true = \
-	winsup.api/ltp/umask03$(EXEEXT)
-
 XFAIL_TESTS = \
 	winsup.api/ltp/setgroups01 \
 	winsup.api/ltp/setuid02 \
 	winsup.api/ltp/ulimit01 \
 	winsup.api/ltp/unlink08 \
-	winsup.api/samples/sample-fail \
-	$(XFAIL_TESTS_CI_$(GITHUB_ACTIONS))
+	winsup.api/samples/sample-fail
 
 # cygrun.sh test-runner script, and variables used by it:
 LOG_COMPILER = $(srcdir)/cygrun.sh
-- 
2.45.1

