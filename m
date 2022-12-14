Return-Path: <SRS0=Rby/=4M=dronecode.org.uk=jon.turney@sourceware.org>
Received: from sa-prd-fep-047.btinternet.com (mailomta4-sa.btinternet.com [213.120.69.10])
	by sourceware.org (Postfix) with ESMTPS id 8B6A03834C02
	for <cygwin-patches@cygwin.com>; Wed, 14 Dec 2022 17:31:08 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 8B6A03834C02
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=dronecode.org.uk
Received: from sa-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.38.5])
          by sa-prd-fep-047.btinternet.com with ESMTP
          id <20221214173107.KTCU13453.sa-prd-fep-047.btinternet.com@sa-prd-rgout-002.btmx-prd.synchronoss.net>;
          Wed, 14 Dec 2022 17:31:07 +0000
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 6139417C47E10A35
X-Originating-IP: [81.153.98.246]
X-OWM-Source-IP: 81.153.98.246 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvhedrfeefgddutdefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepleeitdejhfdtveekheeugeffgeevfedtjeejveefhfeiffefkedtvdetheehieejnecukfhppeekuddrudehfedrleekrddvgeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekuddrudehfedrleekrddvgeeipdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdpnhgspghrtghpthhtohepvddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmpdhrtghpthhtohepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (81.153.98.246) by sa-prd-rgout-002.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as jonturney@btinternet.com)
        id 6139417C47E10A35; Wed, 14 Dec 2022 17:31:07 +0000
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 1/2] Cygwin: FAQ: Mention configure options to build with reduced dependencies
Date: Wed, 14 Dec 2022 17:30:38 +0000
Message-Id: <20221214173040.8431-2-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221214173040.8431-1-jon.turney@dronecode.org.uk>
References: <20221214173040.8431-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1197.7 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,GIT_PATCH_0,KAM_DMARC_STATUS,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

---
 winsup/doc/faq-programming.xml | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/winsup/doc/faq-programming.xml b/winsup/doc/faq-programming.xml
index 632d1a173..a24b781cf 100644
--- a/winsup/doc/faq-programming.xml
+++ b/winsup/doc/faq-programming.xml
@@ -679,14 +679,21 @@ rewriting the runtime library in question from specs...
 installed; you at least need <literal>gcc-g++</literal>,
 <literal>make</literal>, <literal>automake</literal>,
 <literal>autoconf</literal>, <literal>git</literal>, <literal>perl</literal>,
+<literal>cocom</literal> and <literal>patch</literal>.
+</para>
+
+<para>
+Additionally, building the <code>dumper</code> utility requires
 <literal>gettext-devel</literal>, <literal>libiconv-devel</literal>
-<literal>zlib-devel</literal>, <literal>cocom</literal> and <literal>patch</literal>.
+<literal>zlib-devel</literal>.
 </para>
 
 <para>
-Building for 64-bit Cygwin also requires
-<literal>mingw64-x86_64-gcc-g++</literal> and
-<literal>mingw64-x86_64-zlib</literal>.
+Building those Cygwin utilities which are not themselves Cygwin programs
+(e.g. <code>cygcheck</code> and <code>strace</code>) also requires
+<literal>mingw64-x86_64-gcc-g++</literal> and <literal>mingw64-x86_64-zlib</literal>.
+Building these programs can be disabled with the <literal>--without-cross-bootstrap</literal>
+option to <literal>configure</literal>.
 </para>
 
 <!-- If you want to run the tests, <literal>dejagnu</literal> is also required. -->
-- 
2.39.0

