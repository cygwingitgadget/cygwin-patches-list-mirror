Return-Path: <jon.turney@dronecode.org.uk>
Received: from re-prd-fep-041.btinternet.com (mailomta29-re.btinternet.com
 [213.120.69.122])
 by sourceware.org (Postfix) with ESMTPS id 009813857C44
 for <cygwin-patches@cygwin.com>; Tue, 27 Jul 2021 12:59:00 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 009813857C44
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=dronecode.org.uk
Received: from re-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.54.5])
 by re-prd-fep-041.btinternet.com with ESMTP id
 <20210727125859.JPDS31350.re-prd-fep-041.btinternet.com@re-prd-rgout-002.btmx-prd.synchronoss.net>;
 Tue, 27 Jul 2021 13:58:59 +0100
Authentication-Results: btinternet.com;
 auth=pass (LOGIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 5ED9C0CC3DBAA430
X-Originating-IP: [86.139.158.70]
X-OWM-Source-IP: 86.139.158.70 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvtddrgeejgdehfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepueeijeeguddvuedtffeiieelfeffudefkeehgfejffefhedtkeejgeekfedtffefnecukfhppeekiedrudefledrudehkedrjedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudefledrudehkedrjedtpdhmrghilhhfrhhomhepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqedprhgtphhtthhopeeotgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomheqpdhrtghpthhtohepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.139.158.70) by
 re-prd-rgout-002.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9C0CC3DBAA430; Tue, 27 Jul 2021 13:58:59 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH] Cygwin: Convert gmondump and profiler synposes to
 <cmdsynposis>
Date: Tue, 27 Jul 2021 13:57:51 +0100
Message-Id: <20210727125751.4791-1-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1200.5 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 GIT_PATCH_0, KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H4, RCVD_IN_MSPIKE_WL, SPF_HELO_PASS, SPF_NONE,
 TXREP autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Tue, 27 Jul 2021 12:59:03 -0000

Convert gmondump and profiler synposes to <cmdsynposis>, since
addition of these crossed with e6b667f1.
---
 winsup/doc/utils.xml | 39 ++++++++++++++++++++++++++++++++-------
 1 file changed, 32 insertions(+), 7 deletions(-)

diff --git a/winsup/doc/utils.xml b/winsup/doc/utils.xml
index 0b7b5d0ea..659541f00 100644
--- a/winsup/doc/utils.xml
+++ b/winsup/doc/utils.xml
@@ -806,9 +806,18 @@ line separates the ACLs for each file.
     </refnamediv>
 
     <refsynopsisdiv>
-    <screen>
-gmondump [OPTION]... FILENAME...
-    </screen>
+      <cmdsynopsis>
+	<command>gmondump</command>
+	<arg>-v</arg>
+	<arg rep="repeat">FILENAME</arg>
+      </cmdsynopsis>
+      <cmdsynopsis>
+	<command>gmondump</command>
+	<group choice="plain">
+	  <arg choice="plain">-h</arg>
+	  <arg choice="plain">-V</arg>
+	</group>
+      </cmdsynopsis>
     </refsynopsisdiv>
 
     <refsect1 id="gmondump-options">
@@ -2190,10 +2199,26 @@ specifying an empty password.
     </refnamediv>
 
     <refsynopsisdiv>
-    <screen>
-profiler [OPTION]... PROGRAM [ARG]...
-profiler [OPTION]... -p PID
-    </screen>
+      <cmdsynopsis>
+	<command>profiler</command>
+	<arg>-defw</arg>
+	<arg>-o <replaceable>FILENAME</replaceable></arg>
+	<arg>-s <replaceable>N</replaceable></arg>
+	<group choice="plain">
+	  <arg choice="plain">
+	    <arg choice="plain"><replaceable>PROGRAM</replaceable></arg>
+	    <arg rep="repeat" choice="plain"><replaceable>ARG</replaceable></arg>
+	  </arg>
+	  <arg choice="plain">-p <replaceable>PID</replaceable></arg>
+	</group>
+      </cmdsynopsis>
+      <cmdsynopsis>
+	<command>profiler</command>
+	<group choice="plain">
+	  <arg choice="plain">-h</arg>
+	  <arg choice="plain">-V</arg>
+	</group>
+      </cmdsynopsis>
     </refsynopsisdiv>
 
     <refsect1 id="profiler-options">
-- 
2.32.0

