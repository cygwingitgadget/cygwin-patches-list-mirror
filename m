Return-Path: <jon.turney@dronecode.org.uk>
Received: from re-prd-fep-047.btinternet.com (mailomta1-re.btinternet.com
 [213.120.69.94])
 by sourceware.org (Postfix) with ESMTPS id 28F61386EC47
 for <cygwin-patches@cygwin.com>; Wed, 26 Aug 2020 21:04:30 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 28F61386EC47
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from re-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.54.5])
 by re-prd-fep-047.btinternet.com with ESMTP id
 <20200826210429.JILC4599.re-prd-fep-047.btinternet.com@re-prd-rgout-002.btmx-prd.synchronoss.net>;
 Wed, 26 Aug 2020 22:04:29 +0100
Authentication-Results: btinternet.com; none
X-Originating-IP: [31.51.205.206]
X-OWM-Source-IP: 31.51.205.206 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedruddvvddgudehfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgjfhgggfestdhqredtredttdenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhephfeftefgieejkeevvedvhfeivdevieelveefffekkeetfffhtedtgfeffeeufedunecuffhomhgrihhnpegrphhpvhgvhihorhdrtghomhdptghonhhsthgrnhhtrdgtohhmpdgthihgfihinhdrtghomhdpthhkthgvrdgthhenucfkphepfedurdehuddrvddthedrvddtieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepfedurdehuddrvddthedrvddtiedpmhgrihhlfhhrohhmpeeojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqpdhrtghpthhtohepoegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmqedprhgtphhtthhopeeojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (31.51.205.206) by
 re-prd-rgout-002.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9C0CC0DC16FDD; Wed, 26 Aug 2020 22:04:29 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 1/3] Cygwin: Add .appveyor.yml
Date: Wed, 26 Aug 2020 22:04:07 +0100
Message-Id: <20200826210409.2497-2-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200826210409.2497-1-jon.turney@dronecode.org.uk>
References: <20200826210409.2497-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 GIT_PATCH_0, KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, KAM_SHORT,
 RCVD_IN_DNSWL_LOW, RCVD_IN_MSPIKE_H3, RCVD_IN_MSPIKE_WL, SPF_HELO_PASS,
 SPF_NONE, TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Wed, 26 Aug 2020 21:04:31 -0000

This is a slightly more polished version of the configuration being used
for CI builds at https://ci.appveyor.com/project/cygwin/cygwin, which is
not currently under version control.
---
 .appveyor.yml | 69 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100644 .appveyor.yml

diff --git a/.appveyor.yml b/.appveyor.yml
new file mode 100644
index 000000000..602c189cd
--- /dev/null
+++ b/.appveyor.yml
@@ -0,0 +1,69 @@
+version: '{build}'=0D
+=0D
+branches:=0D
+  only:=0D
+  - master=0D
+  - /cygwin/=0D
+=0D
+skip_tags: true=0D
+shallow_clone: true=0D
+=0D
+environment:=0D
+  APPVEYOR_SAVE_CACHE_ON_ERROR: true=0D
+  CACHE: C:\cache=0D
+  CYGWIN_MIRROR: http://cygwin.mirror.constant.com=0D
+  matrix:=0D
+  - BUILD: x86_64-pc-cygwin=0D
+    CYGWIN_ROOT: C:\cygwin64=0D
+    PKGARCH: mingw64-x86_64=0D
+    SETUP: setup-x86_64.exe=0D
+  - BUILD: i686-pc-cygwin=0D
+    CYGWIN_ROOT: C:\cygwin=0D
+    PKGARCH: mingw64-i686=0D
+    SETUP: setup-x86.exe=0D
+=0D
+cache: C:\cache=0D
+=0D
+install:=0D
+- if not exist %CACHE% mkdir %CACHE%=0D
+- appveyor DownloadFile http://cygwin.com/%SETUP% -FileName %CACHE%\%SETUP=
%=0D
+- "%CACHE%\\%SETUP% -qnNdO -R %CYGWIN_ROOT% -s %CYGWIN_MIRROR% -l %CACHE% =
-g -P \=0D
+gcc-core,\=0D
+gcc-g++,\=0D
+make,\=0D
+perl,\=0D
+patch,\=0D
+cocom,\=0D
+gettext-devel,\=0D
+libiconv-devel,\=0D
+zlib-devel,\=0D
+%PKGARCH%-gcc-core,\=0D
+%PKGARCH%-gcc-g++,\=0D
+%PKGARCH%-zlib,\=0D
+dblatex,\=0D
+docbook2X,\=0D
+docbook-xml45,\=0D
+docbook-xsl,\=0D
+xmlto,\=0D
+python3-lxml,\=0D
+python3-ply"=0D
+=0D
+build_script:=0D
+- '%CYGWIN_ROOT%/bin/bash -lc "cd $APPVEYOR_BUILD_FOLDER; mkdir build inst=
all"'=0D
+- '%CYGWIN_ROOT%/bin/bash -lc "cd $APPVEYOR_BUILD_FOLDER/build; ../configu=
re --prefix=3D$(realpath $(pwd)/../install) -v"'=0D
+- '%CYGWIN_ROOT%/bin/bash -lc "cd $APPVEYOR_BUILD_FOLDER/build; make"'=0D
+- '%CYGWIN_ROOT%/bin/bash -lc "cd $APPVEYOR_BUILD_FOLDER/build; make insta=
ll"'=0D
+- '%CYGWIN_ROOT%/bin/bash -lc "cd $APPVEYOR_BUILD_FOLDER/build; cd */newli=
b; make info man"'=0D
+- '%CYGWIN_ROOT%/bin/bash -lc "cd $APPVEYOR_BUILD_FOLDER/build; cd */newli=
b; make install-info install-man"'=0D
+=0D
+test: off=0D
+deploy: off=0D
+=0D
+# irc notification via notifico=0D
+notifications:=0D
+- provider: Webhook=0D
+  url: http://n.tkte.ch/h/4848/0nqixIBiOFzf-S_N2PY83dGB=0D
+  method: GET=0D
+  on_build_success: false=0D
+  on_build_failure: false=0D
+  on_build_status_changed: true=0D
--=20
2.28.0

