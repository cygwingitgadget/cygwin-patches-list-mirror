Return-Path: <SRS0=ZSvf=XG=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo005.btinternet.com (btprdrgo005.btinternet.com [65.20.50.218])
	by sourceware.org (Postfix) with ESMTP id DB4103858CDA
	for <cygwin-patches@cygwin.com>; Sun, 20 Apr 2025 19:25:43 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org DB4103858CDA
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org DB4103858CDA
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.218
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1745177144; cv=none;
	b=uJnn4wko/YOkpdrC2XZON56W/OUnRP8Ibgzwqt38PO9Tbq1dRYS5gwG1p3F2Kc1I/7imVztzX3LZjwZIZozIMtrtBH+z9Ed9c7TqwdXtVBlw2JesdeZyuV0mP1NqTyjyoqzyjtKiwjnKDELG5j1s6YAz/hyd4x7K9dTNL5SKWDc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1745177144; c=relaxed/simple;
	bh=fU3jimgCIlc8GcF/1mtR+x/w4vORFQDbeygefupB5G0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=av9dtAVC1YogG435ka4DmA7iKgNzMWET0TKqzcwzJv8ii6WNwdtbOBPILeOAX6y9ah/UGk6hn7ALjiVi9D6e4PNxO69pQWA+u5/UCmbo/7Uq75Szzp8pIICUVnjqtPRpgJ539o/qIGyfbTawdlt79xBVgJJpc+s/Q+lVvbtes08=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org DB4103858CDA
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 67D89CDB041A59A4
X-Originating-IP: [86.140.112.112]
X-OWM-Source-IP: 86.140.112.112
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfeekjeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepleeitdejhfdtveekheeugeffgeevfedtjeejveefhfeiffefkedtvdetheehieejnecukfhppeekiedrudegtddrudduvddrudduvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddugedtrdduuddvrdduuddvpdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdprhgvvhfkrfephhhoshhtkeeiqddugedtqdduuddvqdduuddvrdhrrghnghgvkeeiqddugedtrdgsthgtvghnthhrrghlphhluhhsrdgtohhmpdgruhhthhgpuhhsvghrpehjohhnthhurhhnvgihsegsthhinhhtvghrnhgvthdrtghomhdpghgvohfkrfepifeupdfovfetjfhoshhtpegsthhprhgurhhgohdttdehpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomhdprhgt
	phhtthhopehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhk
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.140.112.112) by btprdrgo005.btinternet.com (authenticated as jonturney@btinternet.com)
        id 67D89CDB041A59A4; Sun, 20 Apr 2025 20:25:43 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 3/4] Cygwin: CI: Make stress test terser
Date: Sun, 20 Apr 2025 20:25:07 +0100
Message-ID: <20250420192510.3483-4-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250420192510.3483-1-jon.turney@dronecode.org.uk>
References: <20250420192510.3483-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

v2:
Only echo the command in dryrun mode
Capture stress-ng stderr and stdout to a file
Normally only show the test output if it fails
Capture all test output in an artifact
---
 .github/workflows/cygwin.yml      | 10 ++++++++++
 winsup/testsuite/stress/cygstress | 16 +++++++++++-----
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/.github/workflows/cygwin.yml b/.github/workflows/cygwin.yml
index 7d9147977..932926579 100644
--- a/.github/workflows/cygwin.yml
+++ b/.github/workflows/cygwin.yml
@@ -247,5 +247,15 @@ jobs:
       run: |
         export PATH=/usr/bin:$(cygpath ${SYSTEMROOT})/system32
         uname -a
+        export LOGDIR=$(cygpath -a logs)
         winsup/testsuite/stress/cygstress CI
       shell: bash --noprofile --norc -o igncr -eo pipefail '{0}'
+
+    # upload logs artifact
+    - name: Capture logs artifact
+      uses: actions/upload-artifact@v4
+      with:
+        name: stress-logs-${{ matrix.pkgarch }}
+        path: |
+          logs
+      if: ${{ !cancelled() }}
diff --git a/winsup/testsuite/stress/cygstress b/winsup/testsuite/stress/cygstress
index 21e4cb1a6..5a3b955cc 100755
--- a/winsup/testsuite/stress/cygstress
+++ b/winsup/testsuite/stress/cygstress
@@ -477,6 +477,9 @@ command -V taskkill >/dev/null || exit 1
 
 stress_ng_name=${stress_ng##*/}
 tempdir=${TMP:-/tmp}
+logdir=${LOGDIR:-/tmp/logdir}
+
+mkdir -p ${logdir}
 
 find_stress()
 {
@@ -501,12 +504,15 @@ stress()
   shift || return 1
 
   local td="$tempdir/stress-ng.$$.$total.d"
+  local logfile="$logdir/$name"
   local cmd=("$stress_ng" -v -M --oomable --timestamp --verify --temp-path "$td" -t "$timeout")
   test -z "$taskset" || cmd+=(--taskset "$taskset")
   cmd+=(--"$name" "$workers" "$@")
 
-  echo '$' "${cmd[@]}"
-  ! $dryrun || return 0
+  if $dryrun; then
+    echo '$' "${cmd[@]}"
+    return 0
+  fi
 
   (
     t=$(date +%s); : $((t += timeout + 30)); sleep 1
@@ -519,7 +525,7 @@ stress()
 
   mkdir "$td"
   local rc=0
-  "${cmd[@]}" || rc=$?
+  "${cmd[@]}" >$logfile 2>&1 || rc=$?
 
   kill $watchdog 2>/dev/null ||:
   trap - SIGINT SIGTERM
@@ -546,14 +552,14 @@ stress()
   fi
 
   if ! $ok; then
-    echo
     return 1
   fi
   if [ $rc != 0 ]; then
+    cat ${logfile}
     echo ">>> FAILURE: $name" "$@" "(exit status $rc)"; echo
     return 1
   fi
-  echo ">>> SUCCESS: $name" "$@" ""; echo
+  echo ">>> SUCCESS: $name" "$@" ""
 }
 
 if p=$(find_stress); then
-- 
2.45.1

