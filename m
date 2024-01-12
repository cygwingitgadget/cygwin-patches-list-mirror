Return-Path: <SRS0=ExB5=IW=dronecode.org.uk=jon.turney@sourceware.org>
Received: from sa-prd-fep-047.btinternet.com (mailomta27-sa.btinternet.com [213.120.69.33])
	by sourceware.org (Postfix) with ESMTPS id 9F861385829D
	for <cygwin-patches@cygwin.com>; Fri, 12 Jan 2024 14:10:23 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 9F861385829D
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 9F861385829D
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=213.120.69.33
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1705068626; cv=none;
	b=UA70d1R/pq/MUF9htOOUV/XtnSu5BIpZBw/M6qfB63lAI6gEKil1cgW21wE9t3L4mpTGGGH/Dl4oDHXL/sXP8QA0iMgSSn5pA4Vj/u0APx4GTBHva+a6wJPoXC2PTbRsxLrFceWmcqoWfyZE03t2N8tPNuSBzA1p3G8qSFbWuYs=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1705068626; c=relaxed/simple;
	bh=nlLX4f9JPEqegfwKc4dyauQOwG1mhYf+1K3uhFgeKUs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=MKAetIyJ44i2DImIi4wyeCRRiX6m8ER75zhNdTUbGlmRUMIGYqaGJ+jHQuOc+e2grKnT970AHBmdCjTRUvR/zrrQLsQoPyDbe7+fGXD/yZRL9tOiAV2eEm+4rS55OLB593aONq3YhG5ruASh5lPsl8AGCffgj4v2+W4kAce8+0o=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from sa-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.38.8])
          by sa-prd-fep-047.btinternet.com with ESMTP
          id <20240112141022.RSAI9056.sa-prd-fep-047.btinternet.com@sa-prd-rgout-005.btmx-prd.synchronoss.net>;
          Fri, 12 Jan 2024 14:10:22 +0000
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 6567D00805BEFA75
X-Originating-IP: [86.139.158.103]
X-OWM-Source-IP: 86.139.158.103
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeihedgiedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepleeitdejhfdtveekheeugeffgeevfedtjeejveefhfeiffefkedtvdetheehieejnecukfhppeekiedrudefledrudehkedruddtfeenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddufeelrdduheekrddutdefpdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdpnhgspghrtghpthhtohepvddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmpdhrtghpthhtohepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdprhgvvhfkrfephhhoshhtkeeiqddufeelqdduheekqddutdefrdhrrghnghgvkeeiqddufeelrdgsthgtvghnthhrrghlphhluhhsrdgtohhmpdgruhhthhgpuhhsvghrpehjohhnthhurhhnvgihsegsthhinhhtvghrnhgvthdrtgho
	mhdpghgvohfkrfepifeupdfovfetjfhoshhtpehsrgdqphhrugdqrhhgohhuthdqtddthe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.139.158.103) by sa-prd-rgout-005.btmx-prd.synchronoss.net (authenticated as jonturney@btinternet.com)
        id 6567D00805BEFA75; Fri, 12 Jan 2024 14:10:22 +0000
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 2/5] Cygwin: Disable writing core dumps by default.
Date: Fri, 12 Jan 2024 14:09:53 +0000
Message-ID: <20240112140958.1694-3-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240112140958.1694-1-jon.turney@dronecode.org.uk>
References: <20240112140958.1694-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.4 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Change the default core limit from unlimited to 0 (disabled)
---
 winsup/cygwin/mm/cygheap.cc | 2 +-
 winsup/cygwin/release/3.5.0 | 3 +++
 winsup/doc/new-features.xml | 6 ++++++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/mm/cygheap.cc b/winsup/cygwin/mm/cygheap.cc
index a20ee5972..3dc0c011f 100644
--- a/winsup/cygwin/mm/cygheap.cc
+++ b/winsup/cygwin/mm/cygheap.cc
@@ -294,7 +294,7 @@ cygheap_init ()
       cygheap->locale.mbtowc = __utf8_mbtowc;
       /* Set umask to a sane default. */
       cygheap->umask = 022;
-      cygheap->rlim_core = RLIM_INFINITY;
+      cygheap->rlim_core = 0;
     }
   if (!cygheap->fdtab)
     cygheap->fdtab.init ();
diff --git a/winsup/cygwin/release/3.5.0 b/winsup/cygwin/release/3.5.0
index ed27ee32a..3e6d60376 100644
--- a/winsup/cygwin/release/3.5.0
+++ b/winsup/cygwin/release/3.5.0
@@ -62,3 +62,6 @@ What changed:
 - When RLIMIT_CORE is more than 1MB, a core dump file which can be loaded by gdb
   is now written on a fatal error. Otherwise, if it's greater than zero, a text
   format .stackdump file is written, as previously.
+
+- The default RLIMIT_CORE is now 0, disabling the generation of core dump or
+  stackdump files.
diff --git a/winsup/doc/new-features.xml b/winsup/doc/new-features.xml
index b6daadc2b..a22b78a60 100644
--- a/winsup/doc/new-features.xml
+++ b/winsup/doc/new-features.xml
@@ -99,6 +99,12 @@ is now written on a fatal error. Otherwise, if it's greater than zero, a text
 format .stackdump file is written, as previously.
 </para></listitem>
 
+<listitem><para>
+The default RLIMIT_CORE is now 0, disabling the generation of core dump or
+stackdump files. Use e.g. <code>ulimit -c unlimited</code> or <code>ulimit -c
+1024</code> to enable them again.
+</para></listitem>
+
 </itemizedlist>
 
 </sect2>
-- 
2.43.0

