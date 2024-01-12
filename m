Return-Path: <SRS0=ExB5=IW=dronecode.org.uk=jon.turney@sourceware.org>
Received: from sa-prd-fep-048.btinternet.com (mailomta19-sa.btinternet.com [213.120.69.25])
	by sourceware.org (Postfix) with ESMTPS id B13753858408
	for <cygwin-patches@cygwin.com>; Fri, 12 Jan 2024 14:10:37 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B13753858408
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org B13753858408
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=213.120.69.25
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1705068639; cv=none;
	b=cGJXSVW73EDeMnbJRWkHTbuaNw5c2o8+UsVBKbRoapwAfT8vyiVfOb5mGgymJU1fiHZ8riJwcp904faKJN0C/A3Bby/X/IlPTZ5edJjgN3Y+IR+RF9keU6j4pYj89vo2IacqmyEMWbLUiC7INcPmOOBaXV3xyqDEAYl8aH3YX9Y=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1705068639; c=relaxed/simple;
	bh=QyHNp7AqNQ9SPMVZU2Q4TYqbG3dHqfhVmSNt6CdfyjI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=RvmANMMYQ9zB6v/hOGSGdrzaimRcZejW9k0zL6djdpOCttG0VAZj5NsVS8MHtjCy893hg/CC95w0PlWEZJ+qWSDXxFGe9YyE4dSlKAVVZ+1kQ2paGzOQ8X8Xa5AyDl62m1IiClXevTTnO3a1BWOFkX9x3cOGjdAz5nafsd2QOcw=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from sa-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.38.8])
          by sa-prd-fep-048.btinternet.com with ESMTP
          id <20240112141036.NFKX7361.sa-prd-fep-048.btinternet.com@sa-prd-rgout-005.btmx-prd.synchronoss.net>;
          Fri, 12 Jan 2024 14:10:36 +0000
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 6567D00805BEFBBA
X-Originating-IP: [86.139.158.103]
X-OWM-Source-IP: 86.139.158.103
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeihedgiedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepleeitdejhfdtveekheeugeffgeevfedtjeejveefhfeiffefkedtvdetheehieejnecukfhppeekiedrudefledrudehkedruddtfeenucevlhhushhtvghrufhiiigvpeegnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddufeelrdduheekrddutdefpdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdpnhgspghrtghpthhtohepvddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmpdhrtghpthhtohepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdprhgvvhfkrfephhhoshhtkeeiqddufeelqdduheekqddutdefrdhrrghnghgvkeeiqddufeelrdgsthgtvghnthhrrghlphhluhhsrdgtohhmpdgruhhthhgpuhhsvghrpehjohhnthhurhhnvgihsegsthhinhhtvghrnhgvthdrtgho
	mhdpghgvohfkrfepifeupdfovfetjfhoshhtpehsrgdqphhrugdqrhhgohhuthdqtddthe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.139.158.103) by sa-prd-rgout-005.btmx-prd.synchronoss.net (authenticated as jonturney@btinternet.com)
        id 6567D00805BEFBBA; Fri, 12 Jan 2024 14:10:36 +0000
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 5/5] Cygwin: Update documentation for cygwin_stackdump
Date: Fri, 12 Jan 2024 14:09:56 +0000
Message-ID: <20240112140958.1694-6-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240112140958.1694-1-jon.turney@dronecode.org.uk>
References: <20240112140958.1694-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

---
 winsup/doc/misc-funcs.xml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/winsup/doc/misc-funcs.xml b/winsup/doc/misc-funcs.xml
index 7463942e6..55c5cac94 100644
--- a/winsup/doc/misc-funcs.xml
+++ b/winsup/doc/misc-funcs.xml
@@ -106,6 +106,10 @@ enum.  The second is an optional pointer.</para>
   <refsect1 id="func-cygwin-stackdump-desc">
     <title>Description</title>
 <para> Outputs a stackdump to stderr from the called location.
+</para>
+<para> Note: This function is has an effect the first time it is called by a process.
+</para>
+<para> Note: This function is deprecated.
 </para>
   </refsect1>
 </refentry>
-- 
2.43.0

