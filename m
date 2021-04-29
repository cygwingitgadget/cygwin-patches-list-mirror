Return-Path: <jon.turney@dronecode.org.uk>
Received: from sa-prd-fep-048.btinternet.com (mailomta7-sa.btinternet.com
 [213.120.69.13])
 by sourceware.org (Postfix) with ESMTPS id B2A983857036
 for <cygwin-patches@cygwin.com>; Thu, 29 Apr 2021 18:54:41 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org B2A983857036
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from sa-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.38.4])
 by sa-prd-fep-048.btinternet.com with ESMTP id
 <20210429185440.CGLV24424.sa-prd-fep-048.btinternet.com@sa-prd-rgout-001.btmx-prd.synchronoss.net>;
 Thu, 29 Apr 2021 19:54:40 +0100
Authentication-Results: btinternet.com;
 auth=pass (LOGIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 6038717E08C42D90
X-Originating-IP: [81.153.98.246]
X-OWM-Source-IP: 81.153.98.246 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduledrvddvgedgudefvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgggfestdhqredtredttdenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnheptddtvdefgeethefgfeettdeileefuddvieeivdeghedtgeegteekgfdvvdfhvddtnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepkedurdduheefrdelkedrvdegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkedurdduheefrdelkedrvdegiedpmhgrihhlfhhrohhmpeeojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqpdhrtghpthhtohepoegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmqedprhgtphhtthhopeeojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (81.153.98.246) by
 sa-prd-rgout-001.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 6038717E08C42D90; Thu, 29 Apr 2021 19:54:40 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH] Cygwin: CI configuration update
Date: Thu, 29 Apr 2021 19:53:24 +0100
Message-Id: <20210429185324.17357-1-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1200.8 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 GIT_PATCH_0, KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_HELO_PASS, SPF_NONE,
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
X-List-Received-Date: Thu, 29 Apr 2021 18:54:44 -0000

Install autoconf and automake, and run winsup/autogen.sh, and don't have
it silently ignore failures.

On AppVeyor:
- use latest VM image, to reduce time spent installing updates.
- run the testsuite, but ignore the result, as some tests don't work
correctly.
- hardcode the python-lxml and python-ply packages to install, so we get
ones for the right python.
- install texlive collections now needed to build documentation.

On github:
- Use a copr for cocom, since RPMSphere's package updates don't track
fedora:latest very efficently.
---
 .appveyor.yml                | 13 +++++++++++--
 .github/workflows/cygwin.yml | 11 +++++++----
 winsup/autogen.sh            |  1 +
 3 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/.appveyor.yml b/.appveyor.yml
index 602c189cd..66ac35701 100644
--- a/.appveyor.yml
+++ b/.appveyor.yml
@@ -1,4 +1,5 @@
 version: '{build}'=0D
+image: Visual Studio 2019=0D
 =0D
 branches:=0D
   only:=0D
@@ -30,6 +31,8 @@ install:
 - "%CACHE%\\%SETUP% -qnNdO -R %CYGWIN_ROOT% -s %CYGWIN_MIRROR% -l %CACHE% =
-g -P \=0D
 gcc-core,\=0D
 gcc-g++,\=0D
+autoconf,\=0D
+automake,\=0D
 make,\=0D
 perl,\=0D
 patch,\=0D
@@ -40,21 +43,27 @@ zlib-devel,\
 %PKGARCH%-gcc-core,\=0D
 %PKGARCH%-gcc-g++,\=0D
 %PKGARCH%-zlib,\=0D
+dejagnu,\=0D
 dblatex,\=0D
 docbook2X,\=0D
 docbook-xml45,\=0D
 docbook-xsl,\=0D
+texlive-collection-latexrecommended,\=0D
+texlive-collection-fontsrecommended,\=0D
+texlive-collection-pictures,\=0D
 xmlto,\=0D
-python3-lxml,\=0D
-python3-ply"=0D
+python38-lxml,\=0D
+python38-ply"=0D
 =0D
 build_script:=0D
 - '%CYGWIN_ROOT%/bin/bash -lc "cd $APPVEYOR_BUILD_FOLDER; mkdir build inst=
all"'=0D
+- '%CYGWIN_ROOT%/bin/bash -lc "cd $APPVEYOR_BUILD_FOLDER; cd winsup; ./aut=
ogen.sh"'=0D
 - '%CYGWIN_ROOT%/bin/bash -lc "cd $APPVEYOR_BUILD_FOLDER/build; ../configu=
re --prefix=3D$(realpath $(pwd)/../install) -v"'=0D
 - '%CYGWIN_ROOT%/bin/bash -lc "cd $APPVEYOR_BUILD_FOLDER/build; make"'=0D
 - '%CYGWIN_ROOT%/bin/bash -lc "cd $APPVEYOR_BUILD_FOLDER/build; make insta=
ll"'=0D
 - '%CYGWIN_ROOT%/bin/bash -lc "cd $APPVEYOR_BUILD_FOLDER/build; cd */newli=
b; make info man"'=0D
 - '%CYGWIN_ROOT%/bin/bash -lc "cd $APPVEYOR_BUILD_FOLDER/build; cd */newli=
b; make install-info install-man"'=0D
+- '%CYGWIN_ROOT%/bin/bash -lc "cd $APPVEYOR_BUILD_FOLDER/build; cd */winsu=
p; make check || true"'=0D
 =0D
 test: off=0D
 deploy: off=0D
diff --git a/.github/workflows/cygwin.yml b/.github/workflows/cygwin.yml
index cdad8e67b..f9a9a7ae5 100644
--- a/.github/workflows/cygwin.yml
+++ b/.github/workflows/cygwin.yml
@@ -20,15 +20,17 @@ jobs:
     - uses: actions/checkout@v2
=20
     # install build tools
-    - run: dnf install -y make patch perl
+    - run: dnf install -y autoconf automake make patch perl
     - run: dnf install -y mingw${{ matrix.pkgarch }}-gcc-c++ mingw${{ matr=
ix.pkgarch }}-winpthreads-static mingw${{ matrix.pkgarch }}-zlib-static
=20
-    # cocom isn't packaged in Fedora, so we install from a 3rd party repo
-    - run: dnf install -y https://github.com/rpmsphere/noarch/raw/master/r=
/rpmsphere-release-$(rpm -E %fedora)-1.noarch.rpm
+    # enable 'dnf copr'
+    - run: dnf install -y dnf-plugins-core
+
+    # cocom isn't packaged in Fedora, so we install from a copr
+    - run: dnf copr enable -y jturney/cocom
     - run: dnf install -y cocom
=20
     # install cross-cygwin toolchain and libs from copr
-    - run: dnf install -y dnf-plugins-core
     - run: dnf copr enable -y yselkowitz/cygwin
     - run: dnf install -y cygwin${{ matrix.pkgarch }}-gcc-c++ cygwin${{ ma=
trix.pkgarch }}-gettext cygwin${{ matrix.pkgarch }}-libbfd cygwin${{ matrix=
.pkgarch }}-libiconv cygwin${{ matrix.pkgarch }}-zlib
=20
@@ -38,6 +40,7 @@ jobs:
=20
     # build
     - run: mkdir build install
+    - run: cd winsup && ./autogen.sh
     - run: cd build && ../configure --target=3D${{ matrix.target }} --pref=
ix=3D$(realpath $(pwd)/../install)
     - run: make -C build
     - run: make -C build/*/newlib info man
diff --git a/winsup/autogen.sh b/winsup/autogen.sh
index 1db91add9..2dae1ae37 100755
--- a/winsup/autogen.sh
+++ b/winsup/autogen.sh
@@ -1,3 +1,4 @@
+set -e
 /usr/bin/aclocal --force
 /usr/bin/autoconf -f
 /usr/bin/automake -ac
--=20
2.31.1

