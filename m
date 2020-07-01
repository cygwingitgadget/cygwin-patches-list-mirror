Return-Path: <jon.turney@dronecode.org.uk>
Received: from sa-prd-fep-048.btinternet.com (mailomta12-sa.btinternet.com
 [213.120.69.18])
 by sourceware.org (Postfix) with ESMTPS id 90A103861967
 for <cygwin-patches@cygwin.com>; Wed,  1 Jul 2020 21:25:55 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 90A103861967
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from sa-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.38.5])
 by sa-prd-fep-048.btinternet.com with ESMTP id
 <20200701212554.DLIQ4139.sa-prd-fep-048.btinternet.com@sa-prd-rgout-002.btmx-prd.synchronoss.net>;
 Wed, 1 Jul 2020 22:25:54 +0100
Authentication-Results: btinternet.com; none
X-Originating-IP: [31.51.206.31]
X-OWM-Source-IP: 31.51.206.31 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedrtddvgdduieefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeefieduveehgfffffeuueehleefgeevfedvffeljeefheduteelteelvdettefhvdenucfkphepfedurdehuddrvddtiedrfedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeefuddrhedurddvtdeirdefuddpmhgrihhlfhhrohhmpeeojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqpdhrtghpthhtohepoegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmqedprhgtphhtthhopeeojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (31.51.206.31) by
 sa-prd-rgout-002.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9AA6E04BC4DF6; Wed, 1 Jul 2020 22:25:54 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 1/8] Cygwin: Slightly improve error_start documentation
Date: Wed,  1 Jul 2020 22:25:22 +0100
Message-Id: <20200701212529.13998-2-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200701212529.13998-1-jon.turney@dronecode.org.uk>
References: <20200701212529.13998-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 GIT_PATCH_0, KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_DNSWL_LOW,
 RCVD_IN_MSPIKE_H4, RCVD_IN_MSPIKE_WL, SPF_HELO_PASS, SPF_NONE,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Wed, 01 Jul 2020 21:25:56 -0000

---
 winsup/doc/cygwinenv.xml | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/winsup/doc/cygwinenv.xml b/winsup/doc/cygwinenv.xml
index f549fee0d..a52b6ac19 100644
--- a/winsup/doc/cygwinenv.xml
+++ b/winsup/doc/cygwinenv.xml
@@ -28,9 +28,13 @@ Defaults to off.</para>
 which is useful for debugging.  <filename>Win32filepath</filename> is
 usually set to the path to <command>gdb</command> or
 <command>dumper</command>, for example
-<filename>C:\cygwin\bin\gdb.exe</filename>. 
+<filename>C:\cygwin\bin\gdb.exe</filename>.
 There is no default set.
 </para>
+<para>
+The filename of the executing program and it's Windows process id are appended
+to the command as arguments.
+</para>
 </listitem>
 
 <listitem>
-- 
2.27.0

