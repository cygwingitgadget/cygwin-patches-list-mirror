Return-Path: <SRS0=dFmi=PD=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo005.btinternet.com (btprdrgo005.btinternet.com [65.20.50.218])
	by sourceware.org (Postfix) with ESMTP id 68375385841D
	for <cygwin-patches@cygwin.com>; Sun,  4 Aug 2024 21:48:49 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 68375385841D
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 68375385841D
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.218
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1722808130; cv=none;
	b=ijpqueLYixZMwQnOKHsUarRo/LvYWUqA3vPpzOlJc1L391/O3X1nuVXsMamkWAQ4rqHyi9uLpkyYQyfl3di+jg8Z1CX2F3aFmAGzv8Vdu9FHaMQ5wGqtYTZCxRUfVzPK0xJlCGnnEs328oTgrQtQ3SrBgaQzWhPP0v2f1IJ2aJ4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1722808130; c=relaxed/simple;
	bh=zC2+udG1ifDIRFh6AtKccW2OH4ynKI/h1G8+8jDNNQE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=TRcPIQ5AlZ0STBAo5ZABrhKQnL8xIuW1tOK5kkYSb6ph6MVihYi52k3iI/uEV+z8qs52lJj9ADQTf7W9ORst0u3TpnPOlTyQdoQ5nAAQgypVZYvucepVC14IS1Btu2DFaFt1n3FOG2nqs6ygDlPFGfEyL3mzl1CYOgBP/tT/hww=
ARC-Authentication-Results: i=1; server2.sourceware.org
Authentication-Results: btinternet.com;
    auth=pass (LOGIN) smtp.auth=jonturney@btinternet.com;
    bimi=skipped
X-SNCR-Rigid: 66944170026F1C78
X-Originating-IP: [86.140.193.104]
X-OWM-Source-IP: 86.140.193.104
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeeftddrkeehgddtfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvfevufffkffogggtgfesthekredtredtjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhephedvffegudekfeeffeeigeduleffueetffeuffduhfejgffhhedvvddufeekjeeknecukfhppeekiedrudegtddrudelfedruddtgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddugedtrdduleefrddutdegpdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdpnhgspghrtghpthhtohepvddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmpdhrtghpthhtohepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdprhgvvhfkrfephhhoshhtkeeiqddugedtqdduleefqddutdegrdhrrghnghgvkeeiqddugedtrdgsthgtvghnthhrrghlphhluhhsrdgtohhmpdgruhhthhgpuhhsvghrpehjohhnthhurhhnvgihsegsthhinhhtvghrnhgvthdrtghomhdp
	ghgvohfkrfepifeupdfovfetjfhoshhtpegsthhprhgurhhgohdttdeh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.140.193.104) by btprdrgo005.btinternet.com (authenticated as jonturney@btinternet.com)
        id 66944170026F1C78; Sun, 4 Aug 2024 22:48:48 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 0/6] Fix/supress warnings with gcc 12
Date: Sun,  4 Aug 2024 22:48:21 +0100
Message-ID: <20240804214829.43085-1-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,KAM_NUMSUBJECT,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Fix/supress warnings seen with gcc 12.

Jon Turney (6):
  Cygwin: Suppress array-bounds warning from NtCurrentTeb()
  Cygwin: Fix warnings about narrowing conversions of NTSTATUS constants
  Cygwin: Fix warning about address known to be non-NULL in
    /proc/locales
  Cygwin: Fix warning about narrowing conversions in tape options
  Cygwin: Fix warnings about narrowing conversions of socket ioctls
  Cygwin: Suppress false positive use-after-free warnings in
    __set_lc_time_from_win()

 winsup/cygwin/exceptions.cc            |  2 +-
 winsup/cygwin/fhandler/proc.cc         |  3 +--
 winsup/cygwin/fhandler/tape.cc         |  4 ++--
 winsup/cygwin/local_includes/mtinfo.h  |  2 +-
 winsup/cygwin/local_includes/ntdll.h   |  2 +-
 winsup/cygwin/local_includes/winlean.h |  3 +++
 winsup/cygwin/net.cc                   |  2 +-
 winsup/cygwin/nlsfuncs.cc              | 10 ++++++++++
 winsup/cygwin/pinfo.cc                 |  2 +-
 winsup/cygwin/sigproc.cc               |  2 +-
 10 files changed, 22 insertions(+), 10 deletions(-)

-- 
2.45.1

