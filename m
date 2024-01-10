Return-Path: <SRS0=FkOy=IU=dronecode.org.uk=jon.turney@sourceware.org>
Received: from sa-prd-fep-048.btinternet.com (mailomta19-sa.btinternet.com [213.120.69.25])
	by sourceware.org (Postfix) with ESMTPS id 1CD12385842F
	for <cygwin-patches@cygwin.com>; Wed, 10 Jan 2024 13:57:34 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 1CD12385842F
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 1CD12385842F
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=213.120.69.25
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1704895056; cv=none;
	b=anDxS1dlHM45iGNTwmO+4YsbE2zyX2ZX4TaWjSF1NAgz3qCGNSZo4mLy3GdYz32UcbTnxPrKrW8WlcGVp+enVsTjUdXPYtmvdNbYyuu9EP7YDcDffdGCR+o+22Cz+X/+OgYnVK2EMnZaO2Rwvhnj5kMVg06IWvB8WbjdgpQTwfc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1704895056; c=relaxed/simple;
	bh=i5wZT59jXzzKOeVvqwlGzQmc5FgQCVCDWfPjJycJpqw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=xquaYDF4bE+YDERzIOCo3UOfAKJqIPxLHCn2iXzfPDcJbuYqYu+WM9D4SaMfoAV1uxQu/RX9KK4BhCo2KwVQhNZffdD9dwFjKHAZnTiDy0qjbCMok/ur78ucxg+HjCuscU4RQvgqRTvqr/fxeAV+zS/Vv675ZPHqskO99/KmUvs=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from sa-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.38.8])
          by sa-prd-fep-048.btinternet.com with ESMTP
          id <20240110135733.DJVQ7361.sa-prd-fep-048.btinternet.com@sa-prd-rgout-005.btmx-prd.synchronoss.net>;
          Wed, 10 Jan 2024 13:57:33 +0000
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 6567D008058196B6
X-Originating-IP: [86.139.158.103]
X-OWM-Source-IP: 86.139.158.103
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeiuddgheejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepleeitdejhfdtveekheeugeffgeevfedtjeejveefhfeiffefkedtvdetheehieejnecukfhppeekiedrudefledrudehkedruddtfeenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddufeelrdduheekrddutdefpdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdpnhgspghrtghpthhtohepvddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmpdhrtghpthhtohepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdprhgvvhfkrfephhhoshhtkeeiqddufeelqdduheekqddutdefrdhrrghnghgvkeeiqddufeelrdgsthgtvghnthhrrghlphhluhhsrdgtohhmpdgruhhthhgpuhhsvghrpehjohhnthhurhhnvgihsegsthhinhhtvghrnhgvthdrtgho
	mhdpghgvohfkrfepifeupdfovfetjfhoshhtpehsrgdqphhrugdqrhhgohhuthdqtddthe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.139.158.103) by sa-prd-rgout-005.btmx-prd.synchronoss.net (authenticated as jonturney@btinternet.com)
        id 6567D008058196B6; Wed, 10 Jan 2024 13:57:33 +0000
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 2/2] Cygwin: Disable writing core dumps by default.
Date: Wed, 10 Jan 2024 13:57:04 +0000
Message-ID: <20240110135705.557-3-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20240110135705.557-1-jon.turney@dronecode.org.uk>
References: <20240110135705.557-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Change the default core limit from unlimited to 0 (disabled)
---
 winsup/cygwin/mm/cygheap.cc | 2 +-
 winsup/doc/new-features.xml | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

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
2.42.1

