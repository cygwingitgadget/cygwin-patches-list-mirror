Return-Path: <SRS0=ExB5=IW=dronecode.org.uk=jon.turney@sourceware.org>
Received: from sa-prd-fep-045.btinternet.com (mailomta22-sa.btinternet.com [213.120.69.28])
	by sourceware.org (Postfix) with ESMTPS id C78413858D37
	for <cygwin-patches@cygwin.com>; Fri, 12 Jan 2024 14:10:14 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C78413858D37
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C78413858D37
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=213.120.69.28
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1705068618; cv=none;
	b=tk0ocJVJZMrrfFYRxCHTcpCrtrjN/fXa1VAAHOg//qOR3/YFbSfFkecGbRZvdSO9r1394KzjjShDVHdcgXU8ycaRZWCiGvBNbwSCv0EHCDmW6gqlGXg+cYdEbFef4ehMViaQOgQnL+FWi8ktfOvrT8BcN0Zun3+mj7C0GI09V7o=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1705068618; c=relaxed/simple;
	bh=/ByfFOgFyKvszGlND5oVR9I1GdVkrKYo+fIcdHdTBK8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=neb5BRL0Ye9/X+1onx0rYA3pec+N7Tza4kpXe8sHQf7lCylWdTFXCw1hShuQWxjuza4jEQ8+WEDNwfv9Cw49Lj7vUQBzho+3g4kLSp14rBIDrwqoeasykal4B2twT6R/8aEDpzys+Yj12iPARc67AGD8zpgC/RqgTK/DQDyLVhI=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from sa-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.38.8])
          by sa-prd-fep-045.btinternet.com with ESMTP
          id <20240112141013.KJFO29451.sa-prd-fep-045.btinternet.com@sa-prd-rgout-005.btmx-prd.synchronoss.net>;
          Fri, 12 Jan 2024 14:10:13 +0000
Authentication-Results: btinternet.com;
    auth=pass (LOGIN) smtp.auth=jonturney@btinternet.com;
    bimi=skipped
X-SNCR-Rigid: 6567D00805BEF9A2
X-Originating-IP: [86.139.158.103]
X-OWM-Source-IP: 86.139.158.103
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeihedgheelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepheeuuddthefhueetgfeifefgleeitedtiefgtdffhfdvveeggeetjeeffedthefgnecukfhppeekiedrudefledrudehkedruddtfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddufeelrdduheekrddutdefpdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdpnhgspghrtghpthhtohepvddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmpdhrtghpthhtohepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdprhgvvhfkrfephhhoshhtkeeiqddufeelqdduheekqddutdefrdhrrghnghgvkeeiqddufeelrdgsthgtvghnthhrrghlphhluhhsrdgtohhmpdgruhhthhgpuhhsvghrpehjohhnthhurhhnvgihsegsthhinhhtvghrnhgvthdrtghomhdp
	ghgvohfkrfepifeupdfovfetjfhoshhtpehsrgdqphhrugdqrhhgohhuthdqtddthe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.139.158.103) by sa-prd-rgout-005.btmx-prd.synchronoss.net (authenticated as jonturney@btinternet.com)
        id 6567D00805BEF9A2; Fri, 12 Jan 2024 14:10:13 +0000
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 0/5] Coredump under 'ulimit -c' control (v2)
Date: Fri, 12 Jan 2024 14:09:51 +0000
Message-ID: <20240112140958.1694-1-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Write a coredump under 'ulimit -c' control and related changes.

The idea here is to make debugging using a coredump work as usual on a unix,
e.g.:

$ ulimit -c unlimited

$ ./segv-program
*** starting '"C:\cygwin64\bin\dumper.exe" "C:\cygwin64\work\segv-program.exe" 16156' for pid 1398, tid 7136

$ gdb segv-program.exe segv-program.exe.core
[...]

Jon Turney (5):
  Cygwin: Make 'ulimit -c' control writing a coredump
  Cygwin: Disable writing core dumps by default.
  Cygwin: Define and use __WCOREFLAG
  Cygwin: Treat api_fatal() similarly to a core-dumping signal
  Cygwin: Update documentation for cygwin_stackdump

 winsup/cygwin/dcrt0.cc                |   6 +-
 winsup/cygwin/environ.cc              |   1 +
 winsup/cygwin/exceptions.cc           | 122 ++++++++++++++++++++++----
 winsup/cygwin/include/cygwin/wait.h   |   5 +-
 winsup/cygwin/local_includes/winsup.h |   2 +
 winsup/cygwin/mm/cygheap.cc           |   2 +-
 winsup/cygwin/release/3.5.0           |   7 ++
 winsup/doc/cygwinenv.xml              |  25 ++++--
 winsup/doc/misc-funcs.xml             |   4 +
 winsup/doc/new-features.xml           |  12 +++
 winsup/doc/utils.xml                  |  43 +++++----
 11 files changed, 180 insertions(+), 49 deletions(-)

-- 
2.43.0

