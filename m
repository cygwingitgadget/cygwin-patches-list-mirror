Return-Path: <SRS0=ExB5=IW=dronecode.org.uk=jon.turney@sourceware.org>
Received: from sa-prd-fep-047.btinternet.com (mailomta28-sa.btinternet.com [213.120.69.34])
	by sourceware.org (Postfix) with ESMTPS id C90EF385828A
	for <cygwin-patches@cygwin.com>; Fri, 12 Jan 2024 14:10:28 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C90EF385828A
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C90EF385828A
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=213.120.69.34
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1705068631; cv=none;
	b=mKlGrBAPjej8eq/mjyF4YedyJwfP/GMv0uJrzml2zPuC4wsRa0TksSlV3iZOY7X8Fy8hB7RBzxWNw1CrQ3fjwjfexHM/JACF1Xqwwh0nhn3Z0bAw+hChbjy9eAVORDKhgNhZqKkiCwT0SlPMQATX9uGN7bBSvOHXO1bnpiEOck8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1705068631; c=relaxed/simple;
	bh=tG0M8of30QmzHroxHA1C0WYMqst3I7vSotG5AMfp0cw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=j27BraE6JwfUM87ddf3TWp89wVyEVLpmDYM17QhnmNYdxNUwpcp0hJRJ6IgxOXt2b+VVJBH53hriIosSFbrY6evZK0TTWyNz1Kk3qiMIUN3GTw6jZg2Um/Pbsf4tPtKRxfcdPQbj86AT78T6/QssOXHw1FplOiZ7ElQRMf3z3Io=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from sa-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.38.8])
          by sa-prd-fep-047.btinternet.com with ESMTP
          id <20240112141027.RSAU9056.sa-prd-fep-047.btinternet.com@sa-prd-rgout-005.btmx-prd.synchronoss.net>;
          Fri, 12 Jan 2024 14:10:27 +0000
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 6567D00805BEFAC9
X-Originating-IP: [86.139.158.103]
X-OWM-Source-IP: 86.139.158.103
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeihedgiedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepleeitdejhfdtveekheeugeffgeevfedtjeejveefhfeiffefkedtvdetheehieejnecukfhppeekiedrudefledrudehkedruddtfeenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddufeelrdduheekrddutdefpdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdpnhgspghrtghpthhtohepvddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmpdhrtghpthhtohepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdprhgvvhfkrfephhhoshhtkeeiqddufeelqdduheekqddutdefrdhrrghnghgvkeeiqddufeelrdgsthgtvghnthhrrghlphhluhhsrdgtohhmpdgruhhthhgpuhhsvghrpehjohhnthhurhhnvgihsegsthhinhhtvghrnhgvthdrtgho
	mhdpghgvohfkrfepifeupdfovfetjfhoshhtpehsrgdqphhrugdqrhhgohhuthdqtddthe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.139.158.103) by sa-prd-rgout-005.btmx-prd.synchronoss.net (authenticated as jonturney@btinternet.com)
        id 6567D00805BEFAC9; Fri, 12 Jan 2024 14:10:27 +0000
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 3/5] Cygwin: Define and use __WCOREFLAG
Date: Fri, 12 Jan 2024 14:09:54 +0000
Message-ID: <20240112140958.1694-4-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240112140958.1694-1-jon.turney@dronecode.org.uk>
References: <20240112140958.1694-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.4 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Also fix a typo in description of exit status
---
 winsup/cygwin/exceptions.cc         | 2 +-
 winsup/cygwin/include/cygwin/wait.h | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
index 6bd34392a..05ffdc27e 100644
--- a/winsup/cygwin/exceptions.cc
+++ b/winsup/cygwin/exceptions.cc
@@ -1334,7 +1334,7 @@ signal_exit (int sig, siginfo_t *si, void *)
 	if (cygheap->rlim_core == 0Ul)
 	  break;
 
-	sig |= 0x80; /* Set flag in exit status to show that we've "dumped core" */
+	sig |= __WCOREFLAG; /* Set flag in exit status to show that we've "dumped core" */
 
 	/* If core dump size is >1MB, try to invoke dumper to write a
 	   .core file */
diff --git a/winsup/cygwin/include/cygwin/wait.h b/winsup/cygwin/include/cygwin/wait.h
index 7e40c8d6c..0d42e8920 100644
--- a/winsup/cygwin/include/cygwin/wait.h
+++ b/winsup/cygwin/include/cygwin/wait.h
@@ -16,12 +16,13 @@ details. */
 #define WUNTRACED 2
 #define WCONTINUED 8
 #define __W_CONTINUED	0xffff
+#define __WCOREFLAG 0x80
 
 /* A status is 16 bits, and looks like:
       <1 byte info> <1 byte code>
 
       <code> == 0, child has exited, info is the exit value
-      <code> == 1..7e, child has exited, info is the signal number.
+      <code> == 1..7e, child has exited, code is the signal number.
       <code> == 7f, child has stopped, info was the signal number.
       <code> == 80, there was a core dump.
 */
@@ -34,6 +35,6 @@ details. */
 #define WEXITSTATUS(_w)		(((_w) >> 8) & 0xff)
 #define WTERMSIG(_w)		((_w) & 0x7f)
 #define WSTOPSIG		WEXITSTATUS
-#define WCOREDUMP(_w)		(WIFSIGNALED(_w) && ((_w) & 0x80))
+#define WCOREDUMP(_w)		(WIFSIGNALED(_w) && ((_w) & __WCOREFLAG))
 
 #endif /* _CYGWIN_WAIT_H */
-- 
2.43.0

