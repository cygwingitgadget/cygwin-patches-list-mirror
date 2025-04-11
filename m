Return-Path: <SRS0=teM6=W5=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo004.btinternet.com (btprdrgo004.btinternet.com [65.20.50.128])
	by sourceware.org (Postfix) with ESMTP id CD7863857007
	for <cygwin-patches@cygwin.com>; Fri, 11 Apr 2025 13:09:08 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org CD7863857007
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org CD7863857007
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.128
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1744376949; cv=none;
	b=dRl30mAGkit2Va93yoNNAMsHdUkeIqxD7jO9gg+jt2QFg5d8CVYVVEpTAVWD59BPf1Krh2GoRZ1HjgJEyQpiqplBxZTdqZeMTnBAUTJmUiolVYk2rdAqmwAbYP1NpSJ3a38d0p0tJilYAz441eWaL42lhZ7RXol5uYIBXrwQ9jk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1744376949; c=relaxed/simple;
	bh=k+Fvax+d9+c6jVGXTuWMvNbLFjXLgGhNfBZ12Jxrc40=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=fzTjjvpn1XoqSLgiwrUU5hgqAVDmjhVt9sMEGewo02ew1tjNooKnID5yIjhjLI0gQKrVGOFM0AQzGR3fJZOm+eQ0nk6Sg+c5etXYY/t2QCklMSQ9rfAIu9aw0xKT6QZp8NpIXF30+leHGBThDLcCj/5jcEB3Iy+9LwzlMhEL5FQ=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org CD7863857007
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 67D89CAE02F8E50B
X-Originating-IP: [81.129.146.194]
X-OWM-Source-IP: 81.129.146.194
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvuddukeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepleevkeehvefhgfdtffeffefgleejtdetgeffieejudffueegkedukeffjefhjeegnecuffhomhgrihhnpehmrghtrhhigidrthgrrhhgvghtnecukfhppeekuddruddvledrudegiedrudelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkedurdduvdelrddugeeirdduleegpdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdprhgvvhfkrfephhhoshhtkeduqdduvdelqddugeeiqdduleegrdhrrghnghgvkeduqdduvdelrdgsthgtvghnthhrrghlphhluhhsrdgtohhmpdgruhhthhgpuhhsvghrpehjohhnthhurhhnvgihsegsthhinhhtvghrnhgvthdrtghomhdpghgvohfkrfepifeupdfovfetjfhoshhtpegsthhprhgurhhgohdttdegpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheptgihghifihhn
	qdhprghttghhvghssegthihgfihinhdrtghomhdprhgtphhtthhopehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhk
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (81.129.146.194) by btprdrgo004.btinternet.com (authenticated as jonturney@btinternet.com)
        id 67D89CAE02F8E50B; Fri, 11 Apr 2025 14:09:07 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 1/4] Cygwin: CI: Pass the just-built cygwin to a subsequent job
Date: Fri, 11 Apr 2025 14:08:42 +0100
Message-ID: <20250411130846.3355-2-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250411130846.3355-1-jon.turney@dronecode.org.uk>
References: <20250411130846.3355-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

---
 .github/workflows/cygwin.yml | 67 +++++++++++++++++++++++++++++++++---
 1 file changed, 62 insertions(+), 5 deletions(-)

diff --git a/.github/workflows/cygwin.yml b/.github/workflows/cygwin.yml
index 53dd06d3c..79abf3d0f 100644
--- a/.github/workflows/cygwin.yml
+++ b/.github/workflows/cygwin.yml
@@ -148,16 +148,34 @@ jobs:
     - name: Build Cygwin
       run: >-
         export PATH=/usr/bin:$(cygpath ${SYSTEMROOT})/system32 &&
+        export DESTDIR=$(realpath $(pwd)/install) &&
         mkdir build install &&
         (cd winsup; ./autogen.sh) &&
         cd build &&
-        ../configure --prefix=$(realpath $(pwd)/../install) -v &&
+        ../configure --prefix=/usr -v &&
         export MAKEFLAGS=-j$(nproc) &&
         make &&
-        make install &&
+        make install tooldir=/usr gcc_tooldir=/usr DESTDIR=${DESTDIR} &&
         (cd */newlib; make info man) &&
-        (cd */newlib; make install-info install-man)
-      shell: C:\cygwin\bin\bash.exe --noprofile --norc -eo pipefail '{0}'
+        (cd */newlib; make install-info install-man tooldir=/usr gcc_tooldir=/usr DESTDIR=${DESTDIR})
+      shell: bash --noprofile --norc -eo pipefail '{0}'
+
+    # adjust install so it matches the physical arrangement of directories when
+    # unpacked by setup
+    - name: Rearrange for default mountpoints
+      run: |
+        mv -v install/usr/bin install/bin
+        mv -v install/usr/lib install/lib
+      shell: bash --noprofile --norc -o igncr -eo pipefail '{0}'
+
+    # upload installed cygwin as an artifact, for subsequent use in
+    # test job(s)
+    - name: Make Cygwin installation artifact
+      uses: actions/upload-artifact@v4
+      with:
+        name: cygwin-install-${{ matrix.pkgarch }}
+        path: |
+          install
 
     # test
     - name: Test Cygwin
@@ -167,7 +185,7 @@ jobs:
         cd build &&
         (export PATH=${{ matrix.target }}/winsup/testsuite/testinst/bin:${PATH} && cmd /c $(cygpath -wa ${{ matrix.target }}/winsup/cygserver/cygserver) &) &&
         (cd ${{ matrix.target }}/winsup; make check AM_COLOR_TESTS=always)
-      shell: C:\cygwin\bin\bash.exe --noprofile --norc -eo pipefail '{0}'
+      shell: bash --noprofile --norc -eo pipefail '{0}'
 
     # upload test logs to facilitate investigation of problems
     - name: Upload test logs
@@ -182,3 +200,42 @@ jobs:
     # workaround problems with actions/checkout post-run step using cygwin git
     - name: Avoid actions/checkout post-run step using Cygwin git
       run: bash -c 'rm /usr/bin/git.exe'
+
+  windows-test:
+    needs: windows-build
+
+    runs-on: windows-latest
+    strategy:
+      fail-fast: false
+      matrix:
+        include:
+        - target: x86_64-pc-cygwin
+          pkgarch: x86_64
+    name: Windows tests ${{ matrix.pkgarch }}
+
+    steps:
+    # install cygwin
+    - name: Install Cygwin
+      uses: cygwin/cygwin-install-action@master
+      with:
+        platform: ${{ matrix.pkgarch }}
+
+    # fetch the just-built cygwin installation artifact
+    - name: Unpack just-built Cygwin artifact
+      uses: actions/download-artifact@v4
+      with:
+        name: cygwin-install-${{ matrix.pkgarch }}
+        # the path specified here should match the install-dir of
+        # cygwin-install-action above, so we unpack the artifact over it
+        path: 'D:\cygwin'
+
+    # This isn't quite right, as it just overwrites existing files, it doesn't
+    # remove anything which is no longer provided. Ideally, we'd make a cygwin
+    # package of the just-built cygwin version and install it here, but tools
+    # don't exist (yet) to let us do that...
+
+    # run tests
+    - name: Run tests
+      run: |
+        uname -a
+      shell: bash --noprofile --norc -o igncr -eo pipefail '{0}'
-- 
2.45.1

