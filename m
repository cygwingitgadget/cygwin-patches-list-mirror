Return-Path: <SRS0=ZSvf=XG=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo005.btinternet.com (btprdrgo005.btinternet.com [65.20.50.218])
	by sourceware.org (Postfix) with ESMTP id 0BEFC3858D3C
	for <cygwin-patches@cygwin.com>; Sun, 20 Apr 2025 19:25:27 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 0BEFC3858D3C
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 0BEFC3858D3C
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.218
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1745177127; cv=none;
	b=HeNWntkCvEMUzf1CgGZCyKZxSgjglECfNBVjeO8Lf0C2j2VyQA7XqS6i3xiZmoKXEdRe81czxnxIp54GLhWSSTpQmfzC0L/lpFXyFclyud+yZvd4w59TFWAlob6/QL7ETn32JLCCXTkcocL0vthImuNeQjbib2nHJVZZooJEDR8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1745177127; c=relaxed/simple;
	bh=62fkmSHSvRvAGqhWB2qX/wq8fCj0jq2R0PNMnCan+Lg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ZBmC3h/6mRrDjx39UniQgSdQYsmMnjNWNBg96Z8Ji+4ssAIQX8BBbld8ciU/qH9mNUaWJ/i/aWCDv2Z4W4L0fFWCz07h/CjhHERwysBjCYK5HX4aem46QsbSBmcSUJ+ErsE5DBvh/eUnXU5sKS0jp6ePn7a9WtkGFOwCJoQw1bM=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 0BEFC3858D3C
Authentication-Results: btinternet.com;
    auth=pass (LOGIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 67D89CDB041A57E6
X-Originating-IP: [86.140.112.112]
X-OWM-Source-IP: 86.140.112.112
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfeekjeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepheeuuddthefhueetgfeifefgleeitedtiefgtdffhfdvveeggeetjeeffedthefgnecukfhppeekiedrudegtddrudduvddrudduvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddugedtrdduuddvrdduuddvpdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdprhgvvhfkrfephhhoshhtkeeiqddugedtqdduuddvqdduuddvrdhrrghnghgvkeeiqddugedtrdgsthgtvghnthhrrghlphhluhhsrdgtohhmpdgruhhthhgpuhhsvghrpehjohhnthhurhhnvgihsegsthhinhhtvghrnhgvthdrtghomhdpghgvohfkrfepifeupdfovfetjfhoshhtpegsthhprhgurhhgohdttdehpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomhdprhgtphht
	thhopehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhk
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.140.112.112) by btprdrgo005.btinternet.com (authenticated as jonturney@btinternet.com)
        id 67D89CDB041A57E6; Sun, 20 Apr 2025 20:25:25 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 0/4] Add stress-ng to CI (v2)
Date: Sun, 20 Apr 2025 20:25:04 +0100
Message-ID: <20250420192510.3483-1-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Jon Turney (4):
  Cygwin: CI: Pass the just-built cygwin to a subsequent job
  Cygwin: CI: Run stress-ng
  Cygwin: CI: Make stress test terser
  Cygwin: CI: Disable stress-ng clock test

 .github/workflows/cygwin.yml      |  87 ++++-
 winsup/testsuite/stress/cygstress | 608 ++++++++++++++++++++++++++++++
 2 files changed, 690 insertions(+), 5 deletions(-)
 create mode 100755 winsup/testsuite/stress/cygstress

-- 
2.45.1

