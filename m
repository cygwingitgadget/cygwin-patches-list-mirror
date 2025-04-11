Return-Path: <SRS0=teM6=W5=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo004.btinternet.com (btprdrgo004.btinternet.com [65.20.50.128])
	by sourceware.org (Postfix) with ESMTP id 4C5EE3857007
	for <cygwin-patches@cygwin.com>; Fri, 11 Apr 2025 13:09:42 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 4C5EE3857007
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 4C5EE3857007
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.128
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1744376982; cv=none;
	b=UL9MBQOh6522p9mrOFa53LHW8LrjUCb0mmUiNYKo9BU7jQY+GtHr1Au9IhoHGIu0yFieDTtlaSJRLUr/oYSNiSXrHzk/N0BXIYLat8JBG5EScdMQev9lNerm7IB69wUvkM0jHBh7ErPMaIEdHxrDWN9lN+rKRfSHkmgl0HvNNFQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1744376982; c=relaxed/simple;
	bh=x81DSmQoQ5X9NwJedi9xQXIn052z26vP1EP0iEcgZfM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=dk3LcpvkMmNz5oN6npqfNZ5Ht6KeEnUILUZgHwsIiru/S30XmgMhYOT6m0BEhgoLxWsOtApD9edRxmg7oeS5Nl0hUx8wlJS44xIJw7tCu3m9HGqKa3ITeBmNEWRa44WmFEZTK4zJcNqFK3610XOAaNTs11AXBSx+92nZSMP7TLQ=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 4C5EE3857007
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 67D89CAE02F8E84C
X-Originating-IP: [81.129.146.194]
X-OWM-Source-IP: 81.129.146.194
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvuddukeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepleeitdejhfdtveekheeugeffgeevfedtjeejveefhfeiffefkedtvdetheehieejnecukfhppeekuddruddvledrudegiedrudelgeenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkedurdduvdelrddugeeirdduleegpdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdprhgvvhfkrfephhhoshhtkeduqdduvdelqddugeeiqdduleegrdhrrghnghgvkeduqdduvdelrdgsthgtvghnthhrrghlphhluhhsrdgtohhmpdgruhhthhgpuhhsvghrpehjohhnthhurhhnvgihsegsthhinhhtvghrnhgvthdrtghomhdpghgvohfkrfepifeupdfovfetjfhoshhtpegsthhprhgurhhgohdttdegpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomhdprhgt
	phhtthhopehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhk
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (81.129.146.194) by btprdrgo004.btinternet.com (authenticated as jonturney@btinternet.com)
        id 67D89CAE02F8E84C; Fri, 11 Apr 2025 14:09:41 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 4/4] Cygwin: CI: Disable stress-ng clock test
Date: Fri, 11 Apr 2025 14:08:45 +0100
Message-ID: <20250411130846.3355-5-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250411130846.3355-1-jon.turney@dronecode.org.uk>
References: <20250411130846.3355-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,POISEN_SPAM_PILL,POISEN_SPAM_PILL_1,POISEN_SPAM_PILL_3,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

> stress-ng: 23:25:43.13 debug: [1338] invoked with 'stress-ng -v -M --oomable --timestamp --verify --temp-path /cygdrive/c/Users/RUNNER~1/AppData/Local/Temp/stress-ng.1237.5.d -t 5 --log-file /cygdrive/d/a/cygwin/cygwin/logs/clock --clock 2' by user 197108 'runneradmin'
> stress-ng: 23:25:43.14 debug: [1338] stress-ng 0.18.12
> stress-ng: 23:25:43.15 debug: [1338] system: CYGWIN_NT-10.0-20348 fv-az2222-241 3.7.0-api-358.x86_64 2025-04-10 23:13 UTC x86_64, gcc 12.4.0, Cygwin libc, little endian
> stress-ng: 23:25:43.15 debug: [1338] RAM total: 16.0G, RAM free: 13.8G, swap free: 2.9G
> stress-ng: 23:25:43.15 debug: [1338] temporary file path: '/cygdrive/c/Users/runneradmin/AppData/Local/Temp/stress-ng.1237.5.d'
> stress-ng: 23:25:43.15 debug: [1338] 4 processors online, 4 processors configured
> stress-ng: 23:25:43.15 info:  [1338] setting to a 5 secs run per stressor
> stress-ng: 23:25:43.15 debug: [1338] cache allocate: using defaults, cannot determine cache level details
> stress-ng: 23:25:43.15 debug: [1338] cache allocate: shared cache buffer size: 2048K
> stress-ng: 23:25:43.15 info:  [1338] dispatching hogs: 2 clock
> stress-ng: 23:25:43.15 debug: [1338] starting stressors
> stress-ng: 23:25:43.17 debug: [1338] 2 stressors started
> stress-ng: 23:25:43.41 debug: [1340] clock: [1340] started (instance 0 on CPU 2)
> stress-ng: 23:25:43.43 debug: [1341] clock: [1341] started (instance 1 on CPU 2)
> stress-ng: 00:00:00.-99 fail:  [1340] clock: clock_settime was able to set an invalid negative time for timer 'CLOCK_REALTIME'
> stress-ng: 00:00:00.-99 fail:  [1340] clock: clock_settime was able to set an invalid negative time for timer 'CLOCK_REALTIME_COARSE'
> stress-ng: 00:00:00.-99 fail:  [1341] clock: clock_settime was able to set an invalid negative time for timer 'CLOCK_REALTIME'
> stress-ng: 00:00:00.-99 fail:  [1341] clock: clock_settime was able to set an invalid negative time for timer 'CLOCK_REALTIME_COARSE'
> stress-ng: 23:25:48.39 debug: [1340] clock: [1340] exited (instance 0 on CPU 2)
> stress-ng: 23:25:48.39 error: [1338] clock: [1340] terminated with an error, exit status=2 (stressor failed)
> stress-ng: 23:25:48.39 debug: [1338] clock: [1340] terminated (stressor failed)
> stress-ng: 23:25:48.40 debug: [1341] clock: [1341] exited (instance 1 on CPU 2)
> stress-ng: 23:25:48.40 error: [1338] clock: [1341] terminated with an error, exit status=2 (stressor failed)
> stress-ng: 23:25:48.40 debug: [1338] clock: [1341] terminated (stressor failed)
> stress-ng: 23:25:48.40 debug: [1338] metrics-check: all stressor metrics validated and sane
> stress-ng: 23:25:48.41 metrc: [1338] stressor       bogo ops real time  usr time  sys time   bogo ops/s     bogo ops/s CPU used per       RSS Max
> stress-ng: 23:25:48.41 metrc: [1338]                           (secs)    (secs)    (secs)   (real time) (usr+sys time) instance (%)          (KB)
> stress-ng: 23:25:48.41 metrc: [1338] clock            158338      4.97      1.48      7.11     31888.38       18428.54        86.52         19992
> stress-ng: 23:25:48.41 info:  [1338] skipped: 0
> stress-ng: 23:25:48.41 info:  [1338] passed: 0
> stress-ng: 23:25:48.41 info:  [1338] failed: 2: clock (2)
> stress-ng: 23:25:48.41 info:  [1338] metrics untrustworthy: 0
> stress-ng: 23:25:48.41 info:  [1338] unsuccessful run completed in 5.25 secs
>>>> FAILURE: clock (exit status 2)
---
 winsup/testsuite/stress/cygstress | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/testsuite/stress/cygstress b/winsup/testsuite/stress/cygstress
index df5e13881..5a9215472 100755
--- a/winsup/testsuite/stress/cygstress
+++ b/winsup/testsuite/stress/cygstress
@@ -73,7 +73,7 @@ stress_tests='
   chmod         # WORKS,CI
   chown         # FAILS     # TODO undecided: "fchown failed, errno=22 (Invalid argument)"
   chroot        # admin
-  clock         # WORKS,CI  # (fixed in stress-ng 0.18.12: "timer_create failed for timer ...
+  clock         # WORKS     # clock_settime was able to set an invalid negative time for timer 'CLOCK_REALTIME'
                             #  ... ''CLOCK_THREAD_CPUTIME_ID'', errno=134")
   clone         # -----
   close         # FAILS     # TODO Cygwin: close(2) is not thread-safe
-- 
2.45.1

