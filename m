Return-Path: <jon.turney@dronecode.org.uk>
Received: from re-prd-fep-044.btinternet.com (mailomta25-re.btinternet.com
 [213.120.69.118])
 by sourceware.org (Postfix) with ESMTPS id 1E4C63870856
 for <cygwin-patches@cygwin.com>; Wed, 26 Aug 2020 21:04:34 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 1E4C63870856
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from re-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.54.5])
 by re-prd-fep-044.btinternet.com with ESMTP id
 <20200826210433.MZKG21348.re-prd-fep-044.btinternet.com@re-prd-rgout-002.btmx-prd.synchronoss.net>;
 Wed, 26 Aug 2020 22:04:33 +0100
Authentication-Results: btinternet.com; none
X-Originating-IP: [31.51.205.206]
X-OWM-Source-IP: 31.51.205.206 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedruddvvddgudehfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepuddvteduhffftdetheelkedtffeugeelkedtjeeijeevvdeuheekffefueelkeetnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepfedurdehuddrvddthedrvddtieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepfedurdehuddrvddthedrvddtiedpmhgrihhlfhhrohhmpeeojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqpdhrtghpthhtohepoegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmqedprhgtphhtthhopeeojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (31.51.205.206) by
 re-prd-rgout-002.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9C0CC0DC17076; Wed, 26 Aug 2020 22:04:33 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 2/3] Cygwin: Add github action to cross-build on Fedora
Date: Wed, 26 Aug 2020 22:04:08 +0100
Message-Id: <20200826210409.2497-3-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200826210409.2497-1-jon.turney@dronecode.org.uk>
References: <20200826210409.2497-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.4 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 GIT_PATCH_0, KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_DNSWL_LOW,
 RCVD_IN_MSPIKE_H3, RCVD_IN_MSPIKE_WL, SPF_HELO_PASS, SPF_NONE,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
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
X-List-Received-Date: Wed, 26 Aug 2020 21:04:35 -0000

This helps avoid unpleasant surprises when we come to actually make a
release (which are cross-built in this manner)
---
 .github/workflows/cygwin.yml | 45 ++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 .github/workflows/cygwin.yml

diff --git a/.github/workflows/cygwin.yml b/.github/workflows/cygwin.yml
new file mode 100644
index 000000000..cdad8e67b
--- /dev/null
+++ b/.github/workflows/cygwin.yml
@@ -0,0 +1,45 @@
+name: cygwin
+
+on: push
+
+jobs:
+  fedora-build:
+    runs-on: ubuntu-latest
+    container: fedora:latest
+    strategy:
+      fail-fast: false
+      matrix:
+        include:
+        - target: x86_64-pc-cygwin
+          pkgarch: 64
+        - target: i686-pc-cygwin
+          pkgarch: 32
+    name: Fedora cross ${{ matrix.target }}
+
+    steps:
+    - uses: actions/checkout@v2
+
+    # install build tools
+    - run: dnf install -y make patch perl
+    - run: dnf install -y mingw${{ matrix.pkgarch }}-gcc-c++ mingw${{ matrix.pkgarch }}-winpthreads-static mingw${{ matrix.pkgarch }}-zlib-static
+
+    # cocom isn't packaged in Fedora, so we install from a 3rd party repo
+    - run: dnf install -y https://github.com/rpmsphere/noarch/raw/master/r/rpmsphere-release-$(rpm -E %fedora)-1.noarch.rpm
+    - run: dnf install -y cocom
+
+    # install cross-cygwin toolchain and libs from copr
+    - run: dnf install -y dnf-plugins-core
+    - run: dnf copr enable -y yselkowitz/cygwin
+    - run: dnf install -y cygwin${{ matrix.pkgarch }}-gcc-c++ cygwin${{ matrix.pkgarch }}-gettext cygwin${{ matrix.pkgarch }}-libbfd cygwin${{ matrix.pkgarch }}-libiconv cygwin${{ matrix.pkgarch }}-zlib
+
+    # install doc tools
+    - run: dnf install -y dblatex docbook2X docbook-xsl xmlto
+    - run: dnf install -y python3 python3-lxml python3-ply
+
+    # build
+    - run: mkdir build install
+    - run: cd build && ../configure --target=${{ matrix.target }} --prefix=$(realpath $(pwd)/../install)
+    - run: make -C build
+    - run: make -C build/*/newlib info man
+    - run: make -C build install
+    - run: make -C build/*/newlib install-info install-man
-- 
2.28.0

