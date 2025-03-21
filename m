Return-Path: <SRS0=RPmn=WI=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo001.btinternet.com (btprdrgo001.btinternet.com [65.20.50.6])
	by sourceware.org (Postfix) with ESMTP id 676633857B94
	for <cygwin-patches@cygwin.com>; Fri, 21 Mar 2025 14:05:23 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 676633857B94
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 676633857B94
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.6
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1742565923; cv=none;
	b=u5SvvJmFiuK5ud+ZoQVjNvB6VuxKiZynbhT93xqCeirdTOARN4is63neP28T6pfFRd4yC6I90TbspNArlGR19g7dKlyvNXId4PkdqE+vCJp6eYrHCawD7je8EwBs09Hg3aVi6NtDI4tN+hfBUDpUCOS1Xnm84K3h8/t/y+ScDvw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1742565923; c=relaxed/simple;
	bh=29Cv+jolxeaSDWCLHfc/9Z4kAbNg0eUDwf91y92FypM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=s+0ZKnZ+Zh2LX/bC9vIyDTVkVJcJBAgeBcQLSsF2lCBCY2DXfSyzfVevHGGJ6v3HrDRRiiMSN78GpHBOcovgN4VjC2D5sjZINwA0r7rJ2a/DsH0/mWUGALIgdCDtxaaxE8djENnAtQfPCivUuA5fEKgBVJOPF+NvVZbApxlosss=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 676633857B94
Authentication-Results: btinternet.com;
    auth=pass (LOGIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 67D89BE20091473C
X-Originating-IP: [81.153.98.178]
X-OWM-Source-IP: 81.153.98.178
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduhedufedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepheeuuddthefhueetgfeifefgleeitedtiefgtdffhfdvveeggeetjeeffedthefgnecukfhppeekuddrudehfedrleekrddujeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekuddrudehfedrleekrddujeekpdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdprhgvvhfkrfephhhoshhtkeduqdduheefqdelkedqudejkedrrhgrnhhgvgekuddqudehfedrsghttggvnhhtrhgrlhhplhhushdrtghomhdprghuthhhpghushgvrhepjhhonhhtuhhrnhgvhiessghtihhnthgvrhhnvghtrdgtohhmpdhgvghokffrpefiuedpoffvtefjohhsthepsghtphhrughrghhotddtuddpnhgspghrtghpthhtohepvddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmpdhrtghpthhtohep
	jhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (81.153.98.178) by btprdrgo001.btinternet.com (authenticated as jonturney@btinternet.com)
        id 67D89BE20091473C; Fri, 21 Mar 2025 14:05:21 +0000
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 0/2] Fix CI testsuite run with 3.6
Date: Fri, 21 Mar 2025 14:04:59 +0000
Message-ID: <20250321140502.2122-1-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

I think there's been some changes in the way we compute the ACL for files we
create, which is causing a couple of tests to fail in CI.

Get rid of inheritable permissions, so filemodes follow the simple behaviour
(just controlled by umask) that tests expect.

(It seems like there must be something wrong with the contortions we go 
through to run the testsuite against the just-built DLL, as otherwise we've 
have noticed these failures earlier?)

Jon Turney (2):
  CI: Remove inheritable permissions from working directory
  Revert "Cygwin: CI: XFAIL umask03"

 .github/workflows/cygwin.yml | 3 +++
 winsup/testsuite/Makefile.am | 6 +-----
 2 files changed, 4 insertions(+), 5 deletions(-)

-- 
2.45.1

