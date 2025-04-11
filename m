Return-Path: <SRS0=teM6=W5=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo004.btinternet.com (btprdrgo004.btinternet.com [65.20.50.180])
	by sourceware.org (Postfix) with ESMTP id 8944E3857350
	for <cygwin-patches@cygwin.com>; Fri, 11 Apr 2025 13:09:04 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 8944E3857350
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 8944E3857350
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.180
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1744376944; cv=none;
	b=soXp263nwvghsU2FanddMTPiCUkK6vAMFdVXy5zPHE5d7p+LrGbQLwfyb7zANPim9Rlv24woj/fYPC7cYFaEaGXAMU4ZNFqtft9n02mi99MQjtp4kTWrX4DGU3cDrOVkG2xa+XHwsZ1Y6IdBOjyZh0drZlhaHIPFjtCl5aeYYVU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1744376944; c=relaxed/simple;
	bh=1PYbnE4uKoqv5MaJO/wBY3HDquBneKySyavbCgJj3yM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=NR2J5UQRHdzA8XK6YpgF9E4sjupEnKpUmRvZv828umtpYiGM4GKnfJUND7JrE9eDG9OSqs9zz0/b3tV8sstpc4JIXX11sKu7+jDpczNf7e7ZohIj05FpODBwJMk/1x21Qk1N++2aqMZ7ApPyPylGfZDMc60OmvzcD+TG5gf5T00=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 8944E3857350
Authentication-Results: btinternet.com;
    auth=pass (LOGIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 67D89CAE02F8E436
X-Originating-IP: [81.129.146.194]
X-OWM-Source-IP: 81.129.146.194
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvuddukeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepheeuuddthefhueetgfeifefgleeitedtiefgtdffhfdvveeggeetjeeffedthefgnecukfhppeekuddruddvledrudegiedrudelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkedurdduvdelrddugeeirdduleegpdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdprhgvvhfkrfephhhoshhtkeduqdduvdelqddugeeiqdduleegrdhrrghnghgvkeduqdduvdelrdgsthgtvghnthhrrghlphhluhhsrdgtohhmpdgruhhthhgpuhhsvghrpehjohhnthhurhhnvgihsegsthhinhhtvghrnhgvthdrtghomhdpghgvohfkrfepifeupdfovfetjfhoshhtpegsthhprhgurhhgohdttdegpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomhdprhgtphht
	thhopehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhk
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (81.129.146.194) by btprdrgo004.btinternet.com (authenticated as jonturney@btinternet.com)
        id 67D89CAE02F8E436; Fri, 11 Apr 2025 14:09:03 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 0/4] Add stress-ng to CI
Date: Fri, 11 Apr 2025 14:08:41 +0100
Message-ID: <20250411130846.3355-1-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>


Jon Turney (4):
  Cygwin: CI: Pass the just-built cygwin to a subsequent job
  Cygwin: CI: Run stress-ng
  Cygwin: CI: Make stress test terser
  Cygwin: CI: Disable stress-ng clock test

 .github/workflows/cygwin.yml      |  95 ++++-
 winsup/testsuite/stress/cygstress | 606 ++++++++++++++++++++++++++++++
 2 files changed, 696 insertions(+), 5 deletions(-)
 create mode 100755 winsup/testsuite/stress/cygstress

-- 
2.45.1

