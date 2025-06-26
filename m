Return-Path: <SRS0=NNDi=ZJ=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo008.btinternet.com (btprdrgo008.btinternet.com [65.20.50.197])
	by sourceware.org (Postfix) with ESMTP id 2531C385B514
	for <cygwin-patches@cygwin.com>; Thu, 26 Jun 2025 10:59:46 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 2531C385B514
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 2531C385B514
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.197
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750935586; cv=none;
	b=UKECyJRSGIUWzo+rjwJF2WQ+lXiLofqS32ZOaZgRgZv78CRCUza7MXSxB6TTZ3In/uY4yBqC7knfnUp+jk51sovb+7U9Q07r+M1osMIAiFUyapcZxUZgHp6iJ/2vemFXfaA7ky/b21Q9Y5LB9BLJNZSZaeGOfD3F3ZsrT4zMiAo=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750935586; c=relaxed/simple;
	bh=BUidvCIEU4O8TDlHXeC5LzBsrXHnMXG3JPWlDQsO+5I=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=fLux0K3EAkxKaaRdig8dYP3TEqMPORx1EcYZkFaTjA4hyq4n98YU9LmQiSr7nLyW7zn5h4ASos5r32Ai0W0cA973nwRS426wty8UzrNeK+/3Y97bcG7VmOqk/SYtgyRBNMzpVmuWovva0wzpizWoVjHxQTRlFIRSETMnfr1lGbQ=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 2531C385B514
Authentication-Results: btinternet.com;
    auth=pass (LOGIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 67D89D9E0ACA9E70
X-Originating-IP: [86.139.167.63]
X-OWM-Source-IP: 86.139.167.63
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepheeuuddthefhueetgfeifefgleeitedtiefgtdffhfdvveeggeetjeeffedthefgnecukfhppeekiedrudefledrudeijedrieefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudefledrudeijedrieefpdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdprhgvvhfkrfephhhoshhtkeeiqddufeelqdduieejqdeifedrrhgrnhhgvgekiedqudefledrsghttggvnhhtrhgrlhhplhhushdrtghomhdprghuthhhpghushgvrhepjhhonhhtuhhrnhgvhiessghtihhnthgvrhhnvghtrdgtohhmpdhgvghokffrpefiuedpoffvtefjohhsthepsghtphhrughrghhotddtkedpnhgspghrtghpthhtohepvddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmpdhrtghpthhtohepjhhonhdrthhu
	rhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.139.167.63) by btprdrgo008.btinternet.com (authenticated as jonturney@btinternet.com)
        id 67D89D9E0ACA9E70; Thu, 26 Jun 2025 11:59:45 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 0/2] Install all the built documentation files
Date: Thu, 26 Jun 2025 11:59:22 +0100
Message-ID: <20250626105925.29521-1-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Currently, we only install the subset of documentation files which are going
to be included in the cygwin-doc package.

This makes the website deploy unnecessarily complex and wrong, as it
currently deploys from the build directory.

(Wrong, because:

(i) the CSS file currently isn't deployed at all, because it's installed
directly from the source directory. (We just happen to have a similar file
lying around on the webserver).

(ii) all the bodysnatcher nonsense to make the FAQ page conformant HTML
isn't being used at all.)

Instead, install everything, then we can filter out what's not wanted when
we package it.

Jon Turney (2):
  Cygwin: doc: Install FAQ as well
  Cygwin: doc: Install miscellaneous website files

 winsup/doc/Makefile.am | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

-- 
2.45.1

