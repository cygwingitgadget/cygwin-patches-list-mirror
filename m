Return-Path: <jon.turney@dronecode.org.uk>
Received: from sa-prd-fep-049.btinternet.com (mailomta12-sa.btinternet.com
 [213.120.69.18])
 by sourceware.org (Postfix) with ESMTPS id D2A243857805
 for <cygwin-patches@cygwin.com>; Thu,  7 Jul 2022 11:44:01 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org D2A243857805
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=dronecode.org.uk
Received: from sa-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.38.5])
 by sa-prd-fep-049.btinternet.com with ESMTP id
 <20220707114400.TVYH3227.sa-prd-fep-049.btinternet.com@sa-prd-rgout-002.btmx-prd.synchronoss.net>;
 Thu, 7 Jul 2022 12:44:00 +0100
Authentication-Results: btinternet.com;
 auth=pass (LOGIN) smtp.auth=jonturney@btinternet.com;
 bimi=skipped
X-SNCR-Rigid: 6139417C2EA9D5EC
X-Originating-IP: [86.139.167.41]
X-OWM-Source-IP: 86.139.167.41 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvfedrudeihedggeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepheeuuddthefhueetgfeifefgleeitedtiefgtdffhfdvveeggeetjeeffedthefgnecukfhppeekiedrudefledrudeijedrgedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudefledrudeijedrgedupdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdpnhgspghrtghpthhtohepvddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmpdhrtghpthhtohepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.139.167.41) by
 sa-prd-rgout-002.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as
 jonturney@btinternet.com)
 id 6139417C2EA9D5EC; Thu, 7 Jul 2022 12:44:00 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH] Update FAQs for removal of 32-bit Cygwin
Date: Thu,  7 Jul 2022 12:43:43 +0100
Message-Id: <20220707114343.65340-1-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1198.5 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 GIT_PATCH_0, KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_DNSWL_NONE,
 SPF_HELO_PASS, SPF_NONE, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
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
X-List-Received-Date: Thu, 07 Jul 2022 11:44:03 -0000

Update FAQs for removal of 32-bit Cygwin
Also update FAQs for dropping support for Windows Vista/Server 20008
---
 winsup/doc/faq-programming.xml |  4 +---
 winsup/doc/faq-setup.xml       |  3 ---
 winsup/doc/faq-what.xml        | 12 +++++-------
 3 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/winsup/doc/faq-programming.xml b/winsup/doc/faq-programming.xml
index 3c6bf7b46..c2c4004c1 100644
--- a/winsup/doc/faq-programming.xml
+++ b/winsup/doc/faq-programming.xml
@@ -346,7 +346,7 @@ would be difficult.
 <question><para>Where is Objective C?</para></question>
 <answer>
 
-<para>Support for compiling Objective C is available in the <literal>gcc{4}-objc</literal>
+<para>Support for compiling Objective C is available in the <literal>gcc-objc</literal>
 package; resulting binaries will depend on the <literal>libobjc2</literal>
 package at runtime.
 </para>
@@ -684,8 +684,6 @@ installed; you at least need <literal>gcc-g++</literal>,
 </para>
 
 <para>
-Building for 32-bit Cygwin also requires
-<literal>mingw64-i686-gcc-g++</literal> and <literal>mingw64-i686-zlib</literal>.
 Building for 64-bit Cygwin also requires
 <literal>mingw64-x86_64-gcc-g++</literal> and
 <literal>mingw64-x86_64-zlib</literal>.
diff --git a/winsup/doc/faq-setup.xml b/winsup/doc/faq-setup.xml
index cfa771098..ce1069616 100644
--- a/winsup/doc/faq-setup.xml
+++ b/winsup/doc/faq-setup.xml
@@ -383,9 +383,6 @@ are strongly advised not to attempt to
 at once, unless you have a lot of free disk space, a very high speed network
 connection, and the system will not be required for any other purpose for
 many hours (or days) until installation completes.
-For a 32-bit Cygwin installation, you can not install everything, as the
-installation will fail because the 4GB memory available is insufficient to allow
-all the DLLs required to run along with the programs using them.
 </para>
 </answer></qandaentry>
 
diff --git a/winsup/doc/faq-what.xml b/winsup/doc/faq-what.xml
index 77ba1c5fd..4bdbf4eff 100644
--- a/winsup/doc/faq-what.xml
+++ b/winsup/doc/faq-what.xml
@@ -30,13 +30,11 @@ They can be used from one of the provided Unix shells like bash, tcsh or zsh.
 <question><para>What versions of Windows are supported?</para></question>
 <answer>
 
-<para>Cygwin can be expected to run on all modern, released versions of Windows,
-from Windows Vista, 7, 8, 8.1, 10, Windows Server 2008 and all
-later versions of Windows, except Windows S mode due to its limitations.
-The 32 bit version of Cygwin also runs in the WOW64 32 bit environment on
-released 64 bit versions of Windows including ARM PCs,
-the 64 bit version of course only on 64 bit AMD/Intel compatible PCs.
-</para>
+<para>Cygwin can be expected to run on all modern, released versions of Windows.
+This includes Windows 7, Windows Server 2008 R2 and all later versions of
+Windows, except Windows S mode due to its limitations, on 64 bit AMD/Intel
+compatible PCs, and under x64 emulation on ARM PCs running Windows 11.</para>
+
 <para>Keep in mind that Cygwin can only do as much as the underlying OS
 supports.  Because of this, Cygwin will behave differently, and
 exhibit different limitations, on the various versions of Windows.
-- 
2.36.1

