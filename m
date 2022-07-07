Return-Path: <jon.turney@dronecode.org.uk>
Received: from sa-prd-fep-043.btinternet.com (mailomta11-sa.btinternet.com
 [213.120.69.17])
 by sourceware.org (Postfix) with ESMTPS id 384A43858D32
 for <cygwin-patches@cygwin.com>; Thu,  7 Jul 2022 11:44:44 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 384A43858D32
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=dronecode.org.uk
Received: from sa-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.38.8])
 by sa-prd-fep-043.btinternet.com with ESMTP id
 <20220707114443.YEIL3164.sa-prd-fep-043.btinternet.com@sa-prd-rgout-005.btmx-prd.synchronoss.net>;
 Thu, 7 Jul 2022 12:44:43 +0100
Authentication-Results: btinternet.com;
 auth=pass (LOGIN) smtp.auth=jonturney@btinternet.com;
 bimi=skipped
X-SNCR-Rigid: 6139452E2EAABFDE
X-Originating-IP: [86.139.167.41]
X-OWM-Source-IP: 86.139.167.41 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvfedrudeihedggeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepgfejgeejvdektddvfefffeeiteehvedtieehhedtteeiudetfeelueejkefgleffnecuffhomhgrihhnpehsrghmsggrrdhorhhgpdhgnhhurdhorhhgpdhsohhurhgtvgifrghrvgdrohhrghdptgihghifihhnrdgtohhmnecukfhppeekiedrudefledrudeijedrgedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudefledrudeijedrgedupdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdpnhgspghrtghpthhtohepvddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmpdhrtghpthhtohepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.139.167.41) by
 sa-prd-rgout-005.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as
 jonturney@btinternet.com)
 id 6139452E2EAABFDE; Thu, 7 Jul 2022 12:44:43 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH] Update FAQs which are out of date on the details of setup UI
Date: Thu,  7 Jul 2022 12:44:28 +0100
Message-Id: <20220707114428.65374-1-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1198.5 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 GIT_PATCH_0, KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, KAM_SHORT,
 RCVD_IN_DNSWL_NONE, SPF_HELO_PASS, SPF_NONE, TXREP,
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
X-List-Received-Date: Thu, 07 Jul 2022 11:44:45 -0000

---
 winsup/doc/faq-setup.xml | 11 ++++++-----
 winsup/doc/faq-using.xml | 14 +++++++-------
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/winsup/doc/faq-setup.xml b/winsup/doc/faq-setup.xml
index ce1069616..da9fce534 100644
--- a/winsup/doc/faq-setup.xml
+++ b/winsup/doc/faq-setup.xml
@@ -518,10 +518,11 @@ getpwnam(3), disregarding <literal>HOME</literal>.
 <question><para>How do I uninstall individual packages?</para></question>
 <answer>
 
-<para>Run the Cygwin Setup program as you would to install packages.  In the list of
-packages to install, browse the relevant category or click on the
-``View'' button to get a full listing.  Click on the cycle glyph until
-the action reads ``Uninstall''.  Proceed by clicking ``Next''.
+<para>Run the Cygwin Setup program as you would to install packages.  In the
+``Select packages to install'' dialog, choose ``Up To Date'' in the
+<literal>View</literal> drop-down menu, and locate the package.  Choose the
+``Uninstall'' action from the drop-down menu in the ``New'' column. Proceed by
+clicking ``Next''.
 </para>
 </answer></qandaentry>
 
@@ -688,7 +689,7 @@ files, reinstall the "<literal>cygwin</literal>" package using the Cygwin Setup
 this purpose.  See <ulink url="http://rsync.samba.org/"/>,
 <ulink url="http://www.gnu.org/software/wget/"/> for utilities that can do this for you.
 For more information on setting up a custom Cygwin package server, see
-the <ulink url="https://sourceware.org/cygwin-apps/setup.html">Cygwin Setup program page</ulink>.
+the <ulink url="https://cygwin.com/package-server.html.html">Cygwin Package Server page</ulink>.
 
 </para>
 </answer></qandaentry>
diff --git a/winsup/doc/faq-using.xml b/winsup/doc/faq-using.xml
index 7b9bbe1c1..ea5f5a797 100644
--- a/winsup/doc/faq-using.xml
+++ b/winsup/doc/faq-using.xml
@@ -15,13 +15,13 @@
 <para>To repair the damage, you must run the Cygwin Setup program again, and re-install the
 package which provides the missing DLL package.
 </para>
-<para>If you already installed the package at one point, the Cygwin Setup program won't
-show the option to install the package by default.  In the
-``Select packages to install'' dialog, click on the <literal>Full/Part</literal>
-button.  This lists all packages, even those that are already
-installed.  Scroll down to locate the missing package, for instance
-<literal>libncurses8</literal>.  Click on the ``cycle'' glyph until it says
-``Reinstall''.  Continue with the installation.
+<para>If you already installed the package at one point, the Cygwin Setup
+program won't show the option to install the package by default.  In the
+``Select packages to install'' dialog, choose ``Full'' in the
+<literal>View</literal> drop-down menu.  This lists all packages, even those
+that are already installed.  Scroll down to locate the missing package, for
+instance <literal>libncurses8</literal>.  Choose the ``Reinstall'' action from
+the drop-down menu in the ``New'' column.  Continue with the installation.
 </para>
 <para>For a detailed explanation of the general problem, and how to extend
 it to other missing DLLs and identify their containing packages, see
-- 
2.36.1

