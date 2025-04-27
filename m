Return-Path: <SRS0=xsK9=XN=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo012.btinternet.com (btprdrgo012.btinternet.com [65.20.50.237])
	by sourceware.org (Postfix) with ESMTP id 3D6E13858D1E
	for <cygwin-patches@cygwin.com>; Sun, 27 Apr 2025 21:05:25 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 3D6E13858D1E
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 3D6E13858D1E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.237
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1745787925; cv=none;
	b=kU89fXrD6ZHfzrbbImRRTV05OrfgxVIxmRXxHSq3tXwXQ2WMPnFBk/ex3NyXz01trkjpqnmcyBSdspnIg4uPqYranpKowpfos0sZfQQ8dZ9kbFYq3wmN3xsOVOzFHpDOQQP5OseGIx+aZ4oE52wtbA42PSugZgZrDSd6+imVtXI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1745787925; c=relaxed/simple;
	bh=d9olW2gBeMZrQlkSMShYBtYIJoC2hh8nZzi2aFSHySY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=FXgAjYKZybct6jVa7iUYRDlclW5AuokwIsI1Xmsps0QC01tCL4nx4TSbHhdThGt2WnCohUFjpGWLDWofCw6kD9bsPcQmLdFsjmd36VuqY/AcCg0XdmcUDWRyWOLzcBBES8NKfV7z/POssCV5QkqQO/87K5XzB7G/Nf/mSpNogJ0=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 3D6E13858D1E
Authentication-Results: btinternet.com;
    auth=pass (LOGIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 67D89E7C04D8A0B4
X-Originating-IP: [86.143.43.122]
X-OWM-Source-IP: 86.143.43.122
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvheeludduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepheeuuddthefhueetgfeifefgleeitedtiefgtdffhfdvveeggeetjeeffedthefgnecukfhppeekiedrudegfedrgeefrdduvddvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudegfedrgeefrdduvddvpdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdprhgvvhfkrfephhhoshhtkeeiqddugeefqdegfedquddvvddrrhgrnhhgvgekiedqudegfedrsghttggvnhhtrhgrlhhplhhushdrtghomhdprghuthhhpghushgvrhepjhhonhhtuhhrnhgvhiessghtihhnthgvrhhnvghtrdgtohhmpdhgvghokffrpefiuedpoffvtefjohhsthepsghtphhrughrghhotdduvddpnhgspghrtghpthhtohepfedprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmpdhrtghpthhtohep
	tgihghifihhnsehjughrrghkvgdrtghomhdprhgtphhtthhopehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhk
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.143.43.122) by btprdrgo012.btinternet.com (authenticated as jonturney@btinternet.com)
        id 67D89E7C04D8A0B4; Sun, 27 Apr 2025 22:05:24 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>,
	Jeremy Drake <cygwin@jdrake.com>
Subject: [PATCH] Cygwin: CI: Add running on arm64 to stress test matrix
Date: Sun, 27 Apr 2025 22:05:03 +0100
Message-ID: <20250427210504.1962-1-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Use an output variable from cygwin-install-action to inform where we
unpack the just-built cygwin artifact, because apparently the Windows
ARM64 runners have a different configuration (no D: drive).

Also, drop unused 'target' variable from that matrix
---
 .github/workflows/cygwin.yml | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/.github/workflows/cygwin.yml b/.github/workflows/cygwin.yml
index fa00834ce..54d7de1bb 100644
--- a/.github/workflows/cygwin.yml
+++ b/.github/workflows/cygwin.yml
@@ -204,14 +204,18 @@ jobs:
   windows-stress-test:
     needs: windows-build
 
-    runs-on: windows-latest
     strategy:
       fail-fast: false
       matrix:
         include:
-        - target: x86_64-pc-cygwin
-          pkgarch: x86_64
-    name: Windows tests ${{ matrix.pkgarch }}
+        - pkgarch: x86_64
+          runarch: x86_64
+          runner: windows-latest
+        - pkgarch: x86_64
+          runarch: arm64
+          runner: windows-11-arm
+    runs-on: ${{ matrix.runner }}
+    name: Windows tests ${{ matrix.pkgarch }} on ${{ matrix.runarch }}
 
     steps:
     - run: git config --global core.autocrlf input
@@ -219,6 +223,7 @@ jobs:
 
     # install cygwin
     - name: Install Cygwin
+      id: cygwin-install
       uses: cygwin/cygwin-install-action@master
       with:
         platform: ${{ matrix.pkgarch }}
@@ -233,9 +238,9 @@ jobs:
       uses: actions/download-artifact@v4
       with:
         name: cygwin-install-${{ matrix.pkgarch }}
-        # the path specified here should match the install-dir of
-        # cygwin-install-action above, so we unpack the artifact over it
-        path: 'D:\cygwin'
+        # use the install-dir of cygwin-install-action above, so we unpack the
+        # artifact over it
+        path: ${{ steps.cygwin-install.outputs.root }}
 
     # This isn't quite right, as it just overwrites existing files, it doesn't
     # remove anything which is no longer provided. Ideally, we'd make a cygwin
@@ -255,7 +260,7 @@ jobs:
     - name: Capture logs artifact
       uses: actions/upload-artifact@v4
       with:
-        name: stress-logs-${{ matrix.pkgarch }}
+        name: stress-logs-${{ matrix.pkgarch }}-on-${{ matrix.runarch }}
         path: |
           logs
       if: ${{ !cancelled() }}
-- 
2.45.1

