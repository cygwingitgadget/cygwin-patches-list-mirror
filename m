Return-Path: <SRS0=RPmn=WI=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo001.btinternet.com (btprdrgo001.btinternet.com [65.20.50.6])
	by sourceware.org (Postfix) with ESMTP id 3D1643857709
	for <cygwin-patches@cygwin.com>; Fri, 21 Mar 2025 14:05:27 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 3D1643857709
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 3D1643857709
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.6
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1742565927; cv=none;
	b=oBNWhegsbwZPGepNjiA5ryrIWmqO+KxQMjRENaDeiPY5a2poPXaJvHjjZ2ogqcj1fgNBUFhA23hdTZSdcsUgteTzLWeHyt4i/oEruNNUQVnFKZKo6kG39GBQlGn1hatGVfqywQO9uK/hwTRqkk4r+Tg8rgK7MUhCHVgj7kk22V4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1742565927; c=relaxed/simple;
	bh=c5KXwwCkVOAznepkGS7ajJaehHWO1L5rDF3HRk0HQcM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=v4t6czjOeiUK1RVKe58tEKfZE7jyTKwoo2F8t+Buy6LBjMwF8ThWvWlYw2K3dDXnr/Mv1GSQPJcv1QJY5EbbyNgyqHEauG/Pg6DCMmzr0ZrintPwwGM4r2edozdYFEsDy/xsQh42qhxLxh4Wpa7WvRJPwV0PIPZ0FGDz6DQtYpY=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 3D1643857709
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 67D89BE200914798
X-Originating-IP: [81.153.98.178]
X-OWM-Source-IP: 81.153.98.178
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduhedufedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepleeitdejhfdtveekheeugeffgeevfedtjeejveefhfeiffefkedtvdetheehieejnecukfhppeekuddrudehfedrleekrddujeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekuddrudehfedrleekrddujeekpdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdprhgvvhfkrfephhhoshhtkeduqdduheefqdelkedqudejkedrrhgrnhhgvgekuddqudehfedrsghttggvnhhtrhgrlhhplhhushdrtghomhdprghuthhhpghushgvrhepjhhonhhtuhhrnhgvhiessghtihhnthgvrhhnvghtrdgtohhmpdhgvghokffrpefiuedpoffvtefjohhsthepsghtphhrughrghhotddtuddpnhgspghrtghpthhtohepvddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmpdhrtghpthht
	ohepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (81.153.98.178) by btprdrgo001.btinternet.com (authenticated as jonturney@btinternet.com)
        id 67D89BE200914798; Fri, 21 Mar 2025 14:05:26 +0000
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 1/2] CI: Remove inheritable permissions from working directory
Date: Fri, 21 Mar 2025 14:05:00 +0000
Message-ID: <20250321140502.2122-2-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250321140502.2122-1-jon.turney@dronecode.org.uk>
References: <20250321140502.2122-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,POISEN_SPAM_PILL,POISEN_SPAM_PILL_1,POISEN_SPAM_PILL_3,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Remove inheritable permissions from the working directory, since they
break assumptions that the testsuite makes about the filemode a given
umask will result in.
---
 .github/workflows/cygwin.yml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.github/workflows/cygwin.yml b/.github/workflows/cygwin.yml
index 803462a01..53dd06d3c 100644
--- a/.github/workflows/cygwin.yml
+++ b/.github/workflows/cygwin.yml
@@ -105,6 +105,9 @@ jobs:
     # endings, but this could still be dangerous e.g if we need symlinks in the
     # repo)
     - run: git config --global core.autocrlf input
+    # remove inheritable permissions since they break assumptions testsuite
+    # makes about file modes
+    - run: icacls . /inheritance:r
     - uses: actions/checkout@v3
 
     # install cygwin and build tools
-- 
2.45.1

