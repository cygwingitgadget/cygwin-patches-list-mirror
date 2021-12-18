Return-Path: <jon.turney@dronecode.org.uk>
Received: from re-prd-fep-048.btinternet.com (mailomta26-re.btinternet.com
 [213.120.69.119])
 by sourceware.org (Postfix) with ESMTPS id 1972C3858405
 for <cygwin-patches@cygwin.com>; Sat, 18 Dec 2021 17:48:43 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 1972C3858405
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=dronecode.org.uk
Received: from re-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.54.5])
 by re-prd-fep-048.btinternet.com with ESMTP id
 <20211218174842.TEQA1873.re-prd-fep-048.btinternet.com@re-prd-rgout-002.btmx-prd.synchronoss.net>;
 Sat, 18 Dec 2021 17:48:42 +0000
Authentication-Results: btinternet.com;
 auth=pass (LOGIN) smtp.auth=jonturney@btinternet.com;
 bimi=skipped
X-SNCR-Rigid: 613A8DE80DAEE510
X-Originating-IP: [81.129.146.209]
X-OWM-Source-IP: 81.129.146.209 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvuddrleekgddutdegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeetteeijeeuuddtiefhhffhlefhffeuveekhedvhfefudeghedtheegveefhfeifeenucffohhmrghinheptgihghifihhnrdgtohhmnecukfhppeekuddruddvledrudegiedrvddtleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkedurdduvdelrddugeeirddvtdelpdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmpdhrtghpthhtohepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (81.129.146.209) by
 re-prd-rgout-002.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as
 jonturney@btinternet.com)
 id 613A8DE80DAEE510; Sat, 18 Dec 2021 17:48:42 +0000
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH] cygwin: Add cocom and patch to build prerequisites in FAQ
Date: Sat, 18 Dec 2021 17:47:48 +0000
Message-Id: <20211218174748.12478-1-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1198.5 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 GIT_PATCH_0, KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H3, RCVD_IN_MSPIKE_WL, SPF_HELO_PASS, SPF_NONE,
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
X-List-Received-Date: Sat, 18 Dec 2021 17:48:45 -0000

Add patch, and make cocom unconditional in list of build prerequisites.

Even though the products of these tools are checked in, these are tools
are required when building in a fresh git checkout, presumably due to
the order in which git creates the files resulting in timestamps which
indicate that the output of rules using these tools is more recent than
the input.

Addresses: https://cygwin.com/pipermail/cygwin/2021-December/250124.html

Also drop a duplicate sentence about 'fetch sources from git'.
---
 winsup/doc/faq-programming.xml | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/winsup/doc/faq-programming.xml b/winsup/doc/faq-programming.xml
index 46dd23ab8..3c6bf7b46 100644
--- a/winsup/doc/faq-programming.xml
+++ b/winsup/doc/faq-programming.xml
@@ -679,11 +679,11 @@ rewriting the runtime library in question from specs...
 installed; you at least need <literal>gcc-g++</literal>,
 <literal>make</literal>, <literal>automake</literal>,
 <literal>autoconf</literal>, <literal>git</literal>, <literal>perl</literal>,
-<literal>gettext-devel</literal>, <literal>libiconv-devel</literal> and
-<literal>zlib-devel</literal>.  Fetch the sources from the
-<ulink url="https://cygwin.com/git/newlib-cygwin.git">Cygwin GIT source repository</ulink>.
-If you change a certain core part of Cygwin, namely the layout
-of the Cygwin TLS area, you also have to install <literal>cocom</literal>.
+<literal>gettext-devel</literal>, <literal>libiconv-devel</literal>
+<literal>zlib-devel</literal>, <literal>cocom</literal> and <literal>patch</literal>.
+</para>
+
+<para>
 Building for 32-bit Cygwin also requires
 <literal>mingw64-i686-gcc-g++</literal> and <literal>mingw64-i686-zlib</literal>.
 Building for 64-bit Cygwin also requires
-- 
2.34.1

