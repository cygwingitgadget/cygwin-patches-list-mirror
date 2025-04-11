Return-Path: <SRS0=teM6=W5=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo004.btinternet.com (btprdrgo004.btinternet.com [65.20.50.128])
	by sourceware.org (Postfix) with ESMTP id C5B633830B52
	for <cygwin-patches@cygwin.com>; Fri, 11 Apr 2025 13:09:27 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C5B633830B52
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C5B633830B52
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.128
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1744376968; cv=none;
	b=ULTl/WRDEwLIX184grDrO2ToBAdzQffQ/SSC9oizCXjH8/5VsUK6wfe0cSKYL5LT19k0kRitp+ln/9c7ngJofwTprf9cw2qYUUXnq4zQtOPjJOqYkqeJ+IXV1AYfmdgECFCOnxq78St3PO2FPZ/RygQr3ca+3MMIGChJsylrWUo=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1744376968; c=relaxed/simple;
	bh=S4IREyIoj0Gj1N1xwsWRRvrA+mS9/cxjuoONnj89bJQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=xLsq6HEqNFGFcoCAISbkHRgtnXg4ugYKvX3RMOYZ7Ox1gknBZjAykX5bR8x4baqs9ePyP6tmUWU00FsYwKi/3m2pf+dhRx7vBxmxEA6cSlK7aa0RKkcMroPa8MRrgLfPMeKLjV8kpEi+5QVVDU8/wMjbXEFSkmeWgM9cU+jqE3w=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C5B633830B52
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 67D89CAE02F8E68F
X-Originating-IP: [81.129.146.194]
X-OWM-Source-IP: 81.129.146.194
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvuddukeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepleeitdejhfdtveekheeugeffgeevfedtjeejveefhfeiffefkedtvdetheehieejnecukfhppeekuddruddvledrudegiedrudelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkedurdduvdelrddugeeirdduleegpdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdprhgvvhfkrfephhhoshhtkeduqdduvdelqddugeeiqdduleegrdhrrghnghgvkeduqdduvdelrdgsthgtvghnthhrrghlphhluhhsrdgtohhmpdgruhhthhgpuhhsvghrpehjohhnthhurhhnvgihsegsthhinhhtvghrnhgvthdrtghomhdpghgvohfkrfepifeupdfovfetjfhoshhtpegsthhprhgurhhgohdttdegpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomhdprhgt
	phhtthhopehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhk
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (81.129.146.194) by btprdrgo004.btinternet.com (authenticated as jonturney@btinternet.com)
        id 67D89CAE02F8E68F; Fri, 11 Apr 2025 14:09:27 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 3/4] Cygwin: CI: Make stress test terser
Date: Fri, 11 Apr 2025 14:08:44 +0100
Message-ID: <20250411130846.3355-4-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250411130846.3355-1-jon.turney@dronecode.org.uk>
References: <20250411130846.3355-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Don't echo the command being run
Capture stress-ng output to file
Only show test output if it fails

Capture all test output in an artifact
---
 .github/workflows/cygwin.yml      | 10 ++++++++++
 winsup/testsuite/stress/cygstress | 13 ++++++++-----
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/.github/workflows/cygwin.yml b/.github/workflows/cygwin.yml
index 871ec3d3a..face1dc96 100644
--- a/.github/workflows/cygwin.yml
+++ b/.github/workflows/cygwin.yml
@@ -255,5 +255,15 @@ jobs:
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
index 493ff3e8b..df5e13881 100755
--- a/winsup/testsuite/stress/cygstress
+++ b/winsup/testsuite/stress/cygstress
@@ -478,6 +478,9 @@ command -V "$killall_force" >/dev/null || exit 1
 
 stress_ng_name=${stress_ng##*/}
 tempdir=${TMP:-/tmp}
+logdir=${LOGDIR:-/tmp/logdir}
+
+mkdir -p ${logdir}
 
 find_stress()
 {
@@ -502,11 +505,11 @@ stress()
   shift || return 1
 
   local td="$tempdir/stress-ng.$$.$total.d"
-  local cmd=("$stress_ng" -v -M --oomable --timestamp --verify --temp-path "$td" -t "$timeout")
+  local logfile="$logdir/$name"
+  local cmd=("$stress_ng" -v -M --oomable --timestamp --verify --temp-path "$td" -t "$timeout" --log-file $logfile)
   test -z "$taskset" || cmd+=(--taskset "$taskset")
   cmd+=(--"$name" "$workers" "$@")
 
-  echo '$' "${cmd[@]}"
   ! $dryrun || return 0
 
   (
@@ -520,7 +523,7 @@ stress()
 
   mkdir "$td"
   local rc=0
-  "${cmd[@]}" || rc=$?
+  "${cmd[@]}" >/dev/null || rc=$?
 
   kill $watchdog 2>/dev/null ||:
   trap - SIGINT SIGTERM
@@ -547,14 +550,14 @@ stress()
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

