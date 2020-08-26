Return-Path: <jon.turney@dronecode.org.uk>
Received: from re-prd-fep-040.btinternet.com (mailomta6-re.btinternet.com
 [213.120.69.99])
 by sourceware.org (Postfix) with ESMTPS id 1E241386F82E
 for <cygwin-patches@cygwin.com>; Wed, 26 Aug 2020 21:04:38 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 1E241386F82E
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from re-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.54.5])
 by re-prd-fep-040.btinternet.com with ESMTP id
 <20200826210437.TJCW10362.re-prd-fep-040.btinternet.com@re-prd-rgout-002.btmx-prd.synchronoss.net>;
 Wed, 26 Aug 2020 22:04:37 +0100
Authentication-Results: btinternet.com; none
X-Originating-IP: [31.51.205.206]
X-OWM-Source-IP: 31.51.205.206 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedruddvvddgudehfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepteegveeltedugedvhedttefhgeehgeffhfeuhfejffeigeekhfdtfffffffhteefnecuffhomhgrihhnpehtvggrqdgtihdrohhrghenucfkphepfedurdehuddrvddthedrvddtieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepfedurdehuddrvddthedrvddtiedpmhgrihhlfhhrohhmpeeojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqpdhrtghpthhtohepoegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmqedprhgtphhtthhopeeojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (31.51.205.206) by
 re-prd-rgout-002.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9C0CC0DC170F8; Wed, 26 Aug 2020 22:04:37 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 3/3] Cygwin: Remove .drone.yml
Date: Wed, 26 Aug 2020 22:04:09 +0100
Message-Id: <20200826210409.2497-4-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200826210409.2497-1-jon.turney@dronecode.org.uk>
References: <20200826210409.2497-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
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
X-List-Received-Date: Wed, 26 Aug 2020 21:04:39 -0000

tea-ci.org was a CI service for MSYS2, but is no longer operating.
---
 .drone.yml | 58 ------------------------------------------------------
 1 file changed, 58 deletions(-)
 delete mode 100644 .drone.yml

diff --git a/.drone.yml b/.drone.yml
deleted file mode 100644
index ad512a031..000000000
--- a/.drone.yml
+++ /dev/null
@@ -1,58 +0,0 @@
-# Build configuration for https://tea-ci.org
-# Tea CI is a fork of Drone CI with Cygwin/Msys2 support
-# Feel free to share Tea CI to more open source developers
-# https://docs.tea-ci.org/usage/overview/
-
-debug: true
-
-build:
-  stage1:
-    image: teaci/cygwin$$arch
-    pull: true
-    shell: cygwin$$arch
-    commands:
-      - uname -a
-      - id
-      - C:/cygwin-installer.exe --site http://mirrors.tea-ci.org/cygwin --local-package-dir Z:/tmp/cygwin -W -P gettext-devel,zlib-devel,libiconv,libiconv-devel,mingw64-i686-gcc-g++,mingw64-i686-zlib,mingw64-x86_64-gcc-core,mingw64-x86_64-gcc-g++,mingw64-x86_64-zlib,dejagnu,dblatex,docbook-xml45,docbook-xsl,xmlto -q &> /dev/null
-      - srcdir=`pwd`
-      - builddir=/oss/build-stage1
-      - installdir=/oss/install-stage1
-      - mkdir -p ${builddir} ${installdir}
-      - cd ${builddir}
-      - ${srcdir}/configure --prefix=${installdir} -v
-      - make
-      - make install
-      - sha1sum ${installdir}/bin/cygwin1.dll /bin/cygwin1.dll
-      # FIXME: Is there an easy way to package new Cygwin then install locally using setup_x86{,-64}.exe?
-      - cp -vf ${installdir}/bin/cygwin1.dll /bin/cygwin1.dll
-
-  test:
-    image: teaci/cygwin$$arch
-    pull: true
-    shell: /bin/bash # Call from Linux native shell, which is a special bonus of Tea CI.
-    commands:
-      # In the worst case, new cygwin1.dll might fail to start with exit status 0, which fools the CI as status success.
-      # The following test does not rely on cygwin exit status, instead we trust Linux grep result.
-      - cygwin$$arch -c "uname -a" | grep CYGWIN_NT
-      - cygwin$$arch -c "id" | grep uid
-      - cygwin$$arch -c "sha1sum --tag /bin/cygwin1.dll" | grep SHA1
-
-  # Compile Cygwin again using the new cygwin1.dll
-  stage2:
-    image: teaci/cygwin$$arch
-    pull: true
-    shell: cygwin$$arch
-    commands:
-      - srcdir=`pwd`
-      - builddir=/oss/build-stage2
-      - installdir=/oss/install-stage2
-      - mkdir -p ${builddir} ${installdir}
-      - cd ${builddir}
-      - ${srcdir}/configure --prefix=${installdir} -v
-      - make
-      - make install
-
-matrix:
-  arch:
-    - 64
-    - 32
-- 
2.28.0

