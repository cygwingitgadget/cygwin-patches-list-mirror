Return-Path: <SRS0=Pl6r=5H=dronecode.org.uk=jon.turney@sourceware.org>
Received: from re-prd-fep-047.btinternet.com (mailomta1-re.btinternet.com [213.120.69.94])
	by sourceware.org (Postfix) with ESMTPS id B6B4738493F9
	for <cygwin-patches@cygwin.com>; Tue, 10 Jan 2023 16:37:57 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B6B4738493F9
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=dronecode.org.uk
Received: from re-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.54.6])
          by re-prd-fep-047.btinternet.com with ESMTP
          id <20230110163756.TCKF20465.re-prd-fep-047.btinternet.com@re-prd-rgout-003.btmx-prd.synchronoss.net>;
          Tue, 10 Jan 2023 16:37:56 +0000
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 61A69BAC3ED8A59A
X-Originating-IP: [81.153.98.246]
X-OWM-Source-IP: 81.153.98.246 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvhedrledvgddviecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeelveekheevhffgtdfffeefgfeljedtteegffeijeduffeugeekudekffejhfejgeenucffohhmrghinhepmhgrthhrihigrdhtrghrghgvthenucfkphepkedurdduheefrdelkedrvdegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkedurdduheefrdelkedrvdegiedpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomhdprhgtphhtthhopehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhk
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (81.153.98.246) by re-prd-rgout-003.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as jonturney@btinternet.com)
        id 61A69BAC3ED8A59A; Tue, 10 Jan 2023 16:37:56 +0000
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 8/8] Cygwin: CI: Run cygserver for tests
Date: Tue, 10 Jan 2023 16:37:09 +0000
Message-Id: <20230110163709.16265-9-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230110163709.16265-1-jon.turney@dronecode.org.uk>
References: <20230110163709.16265-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1197.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,GIT_PATCH_0,KAM_DMARC_STATUS,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Note that cygserver must be run using the same cygwin1.DLL as test
programs, as they communicate over a named pipe whose name contains the
'installation key' (which is a hash of the cygwin1.dll's path).

We run cygserver via 'cmd' to avoid the special code which handles a
cygwin parent process starting a cygwin child process, which assumes the
same version of cygwin in both.
---
 .github/workflows/cygwin.yml | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/.github/workflows/cygwin.yml b/.github/workflows/cygwin.yml
index ac167e748..10d0255ef 100644
--- a/.github/workflows/cygwin.yml
+++ b/.github/workflows/cygwin.yml
@@ -52,7 +52,8 @@ jobs:
       fail-fast: false
       matrix:
         include:
-        - pkgarch: x86_64
+        - target: x86_64-pc-cygwin
+          pkgarch: x86_64
     name: Windows native ${{ matrix.pkgarch }}
 
     steps:
@@ -105,6 +106,15 @@ jobs:
         make &&
         make install &&
         (cd */newlib; make info man) &&
-        (cd */newlib; make install-info install-man) &&
-        (cd */winsup; make check || true)
+        (cd */newlib; make install-info install-man)
+      shell: C:\cygwin\bin\bash.exe --noprofile --norc -eo pipefail '{0}'
+
+    # test
+    - name: Test Cygwin
+      run: >-
+        export PATH=/usr/bin:$(cygpath ${SYSTEMROOT})/system32 &&
+        export MAKEFLAGS=-j$(nproc) &&
+        cd build &&
+        (export PATH=${{ matrix.target }}/winsup/testsuite/runtime:${PATH} && cmd /c $(cygpath -wa ${{ matrix.target }}/winsup/cygserver/cygserver) &) &&
+        (cd ${{ matrix.target }}/winsup; make check || true)
       shell: C:\cygwin\bin\bash.exe --noprofile --norc -eo pipefail '{0}'
-- 
2.39.0

