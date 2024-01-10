Return-Path: <SRS0=FkOy=IU=dronecode.org.uk=jon.turney@sourceware.org>
Received: from re-prd-fep-043.btinternet.com (mailomta12-re.btinternet.com [213.120.69.105])
	by sourceware.org (Postfix) with ESMTPS id 3D8EC3858426
	for <cygwin-patches@cygwin.com>; Wed, 10 Jan 2024 13:58:10 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 3D8EC3858426
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 3D8EC3858426
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=213.120.69.105
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1704895092; cv=none;
	b=eXXw0+hpNT+HrrmxpC47qxjuw3xdxV80yqn1Qp6y70+1V82dxgfyXlpZQOU65P149U4ZGB7OK4FOpywIEj/sOiLWCkmaoWzTq/X2bWs3JoXjPalvL5Ui2jNaYV71m5K1Skb+Hy3u66Fp+A4MnkjCMdzrdaTpvzMtVuYChFc9tUE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1704895092; c=relaxed/simple;
	bh=KOE87W6zv1CM6UeyT9UOd/1QKhUoZVDhSSae82bgJRU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ZmALYv0w25YVRQkcGZLc3lIhaGkKAE2U5hg2Cd04qIybVJNCyHEtLaGvnhUIga7z0IvM2kqF7X+wWVKu0S0LisZNKiXNAuqBDK1RUImn8m/YTuAPhZHstDxT+cRxO8C8E8lLy+H80wcV8d0+u1W97LINUx6Ftlc1xRoidHU6jdw=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from re-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.54.6])
          by re-prd-fep-043.btinternet.com with ESMTP
          id <20240110135809.NXIZ18910.re-prd-fep-043.btinternet.com@re-prd-rgout-003.btmx-prd.synchronoss.net>;
          Wed, 10 Jan 2024 13:58:09 +0000
Authentication-Results: btinternet.com;
    auth=pass (LOGIN) smtp.auth=jonturney@btinternet.com;
    bimi=skipped
X-SNCR-Rigid: 6577B732038A8D84
X-Originating-IP: [86.139.158.103]
X-OWM-Source-IP: 86.139.158.103
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeiuddgheejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepheeuuddthefhueetgfeifefgleeitedtiefgtdffhfdvveeggeetjeeffedthefgnecukfhppeekiedrudefledrudehkedruddtfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddufeelrdduheekrddutdefpdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdpnhgspghrtghpthhtohepvddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmpdhrtghpthhtohepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdprhgvvhfkrfephhhoshhtkeeiqddufeelqdduheekqddutdefrdhrrghnghgvkeeiqddufeelrdgsthgtvghnthhrrghlphhluhhsrdgtohhmpdgruhhthhgpuhhsvghrpehjohhnthhurhhnvgihsegsthhinhhtvghrnhgvthdrtghomhdp
	ghgvohfkrfepifeupdfovfetjfhoshhtpehrvgdqphhrugdqrhhgohhuthdqtddtfe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.139.158.103) by re-prd-rgout-003.btmx-prd.synchronoss.net (authenticated as jonturney@btinternet.com)
        id 6577B732038A8D84; Wed, 10 Jan 2024 13:58:09 +0000
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH] Cygwin: Fix a stray '\n' in cygcheck manpage
Date: Wed, 10 Jan 2024 13:57:52 +0000
Message-ID: <20240110135752.598-1-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

---
 winsup/doc/utils.xml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/doc/utils.xml b/winsup/doc/utils.xml
index 8261e7ebd..692dae38f 100644
--- a/winsup/doc/utils.xml
+++ b/winsup/doc/utils.xml
@@ -210,7 +210,7 @@ At least one command option or a PROGRAM is required, as shown above.
                        plain console only, not from a pty/rxvt/xterm)
   -e, --search-package list all available packages matching PATTERN
                        PATTERN is a glob pattern with * and ? as wildcard chars
-      search selection specifiers (multiple allowed):\n\
+      search selection specifiers (multiple allowed):
       --requires       list packages depending on packages matching PATTERN
       --build-reqs     list packages depending on packages matching PATTERN
                        when building these packages
-- 
2.42.1

