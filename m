Return-Path: <SRS0=WkqS=WD=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id E13423858D20
	for <cygwin-patches@cygwin.com>; Sun, 16 Mar 2025 09:23:04 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E13423858D20
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org E13423858D20
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1742116985; cv=none;
	b=WT0JYHqqCMYPO/n3NZ2hRtx/7mVD+AOuBpHxnx4xVn4ocOG01w+IETdqSkJKXQm7pw6jlgD8iVB5Bxes4jOER9y1ophUHMh56Q96GdCvN52yKXufmHOfeUWwiBBcYQBBh92aJ3nWk8dGXmdUcXjjc2PoK/xG4IHaFxeJLRTwQVc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1742116985; c=relaxed/simple;
	bh=/+Y+a05BpT8jEhwkv1islu24eKTp7wvDqQxsLLIJIcc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=C/47uiYBlNm9sWAX15eKH5M0m/qehC1J5PyqM4N4oaud1nkIgOXOdKt/nq80smKxEAHANpK2tFzi7nrvZvopmc4k+5bDin42p51odL1K/r1/GKarzEGe+9m46rEqpEUzmyf92GhUqZ0DeKRa9hyPC/iNgXOTLU/PqbqBIyZOQoA=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E13423858D20
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 52G9SPjT047198;
	Sun, 16 Mar 2025 02:28:25 -0700 (PDT)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-245-188.fiber.dynamic.sonic.net(50.1.245.188), claiming to be "localhost.localdomain"
 via SMTP by m0.truegem.net, id smtpd6E77xq; Sun Mar 16 01:28:22 2025
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Cc: Mark Geisert <mark@maxrnd.com>,
        Christian Franke <Christian.Franke@t-online.de>
Subject: [PATCH] Cygwin: Carry process affinity through to result
Date: Sun, 16 Mar 2025 02:21:52 -0700
Message-ID: <20250316092247.391-1-mark@maxrnd.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <https://cygwin.com/pipermail/cygwin/2025-March/257628.html>
References: <https://cygwin.com/pipermail/cygwin/2025-March/257628.html>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.1 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Due to deficient testing, the current code doesn't return a valid result
to users of sched_getaffinity().  Carry the result procmask through to
the generation of result cpu mask.

Recognize Windows' limitation that if the process is multi-group (i.e.,
has threads in multiple cpu groups) there is no visibility to which
processors in other groups are being used.  One could remedy this by
looping through all the process' threads, but that could be expensive
so is left for future contemplation.

Reported-by: Christian Franke <Christian.Franke@t-online.de>
Addresses: https://cygwin.com/pipermail/cygwin/2025-March/257616.html
Signed-off-by: Mark Geisert <mark@maxrnd.com>
Fixes: 641ecb07533e ("Cygwin: Implement sched_[gs]etaffinity()")

---
 winsup/cygwin/sched.cc | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/sched.cc b/winsup/cygwin/sched.cc
index 2f4fbc31a..ce1e94345 100644
--- a/winsup/cygwin/sched.cc
+++ b/winsup/cygwin/sched.cc
@@ -588,8 +588,11 @@ __sched_getaffinity_sys (pid_t pid, size_t sizeof_set, cpu_set_t *set)
 	}
 
       KAFFINITY miscmask = groupmask (__get_cpus_per_group ());
+      /* if process is multi-group, we don't have processor visibility. */
+      if (procmask == 0)
+	procmask = miscmask;
       for (int i = 0; i < groupcount; i++)
-	setgroup (sizeof_set, set, grouparray[i], miscmask);
+	setgroup (sizeof_set, set, grouparray[i], miscmask & procmask);
     }
   else
     status = ESRCH;
-- 
2.45.1

