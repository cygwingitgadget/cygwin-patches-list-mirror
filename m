Return-Path: <SRS0=tdPk=6Q=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo012.btinternet.com (btprdrgo012.btinternet.com [65.20.50.237])
	by sourceware.org (Postfix) with ESMTP id 3E4D74BA2E00
	for <cygwin-patches@cygwin.com>; Wed, 10 Dec 2025 11:40:48 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 3E4D74BA2E00
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 3E4D74BA2E00
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.237
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1765366848; cv=none;
	b=e2A7C5R5mx2F0Qr5M8bwe2o8peKqimeqz1WF8J7bDCkboXk8QKbfqG9JwvPUUo+RpKPhi5hYgukNE3syNitVkGnSwZx5MEkUr3D4TyjUtzvsAj+Vftojrq+VzbSjvrViLDQEnZD7BElB7uRm6ftbmUmTyAuOlYlm6sgS1OYbtZ4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1765366848; c=relaxed/simple;
	bh=6XVGRM4cP9vZXwjWEVo3mJLbRdTy8TxNbXFwQOta38g=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=dYEEO54yl11/o/mZzTNzk2LyjxIx4RQ6ICAT7OpQyBqmV5Y+XjwipENjehsI4gTcEVdeWU5SCOcCc8vbM0FLPIu8sYF7UxUtilDukOIQ9g8+HDPanWdOx2uEpsmNu3vGY07JG7p4QWp2/rQbZtLM3+C0YXya2eEIP5KThP4azoU=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 3E4D74BA2E00
Authentication-Results: btinternet.com;
    auth=pass (LOGIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 68CA1EA80862E2F7
X-Originating-IP: [81.158.20.216]
X-OWM-Source-IP: 81.158.20.216
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdefgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeehuedutdehhfeutefgieefgfelieettdeigfdtfffhvdevgeegteejfeeftdehgfenucfkphepkedurdduheekrddvtddrvdduieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehtrghmsghorhgrpdhinhgvthepkedurdduheekrddvtddrvdduiedpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhrvghvkffrpehhohhsthekuddqudehkedqvddtqddvudeirdhrrghnghgvkeduqdduheekrdgsthgtvghnthhrrghlphhluhhsrdgtohhmpdgruhhthhgpuhhsvghrpehjohhnthhurhhnvgihsegsthhinhhtvghrnhgvthdrtghomhdpghgvohfkrfepifeupdfovfetjfhoshhtpegsthhprhgurhhgohdtuddvpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomhdprhgtphhtthhopehjohhnrdhtuhhrnhgvhiesughrohhn
	vggtohguvgdrohhrghdruhhk
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from tambora (81.158.20.216) by btprdrgo012.btinternet.com (authenticated as jonturney@btinternet.com)
        id 68CA1EA80862E2F7; Wed, 10 Dec 2025 11:40:46 +0000
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH] Cygwin: Update the "building cygwin" FAQ
Date: Wed, 10 Dec 2025 11:40:43 +0000
Message-ID: <20251210114043.16625-1-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,POISEN_SPAM_PILL,POISEN_SPAM_PILL_1,POISEN_SPAM_PILL_3,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Shorten the example path for clarity.

Using --prefix rather than DESTDIR to select the install location is
generically wrong (and specifically wrong because it causes an
incorrectly prefixed /etc/cygserver.conf path to be baked into the
cygserver built).

Install using -j1 because... cygwin's install rules overwrite things
installed by newlib, so running those in parallel can have undesired
results. (something something tooldir something something)
---
 winsup/doc/faq-programming.xml | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/winsup/doc/faq-programming.xml b/winsup/doc/faq-programming.xml
index 696a6462b..ac361839a 100644
--- a/winsup/doc/faq-programming.xml
+++ b/winsup/doc/faq-programming.xml
@@ -747,20 +747,20 @@ download the corresponding source package
 <para>You <emphasis>must</emphasis> build cygwin in a separate directory from
 the source, so create something like a <literal>build/</literal> directory.
 Assuming you checked out the source to
-<literal>/oss/src/newlib-cygwin/</literal>, and you want to install to the
-temporary location <literal>/oss/install/</literal>, these are the required
+<literal>/src/newlib-cygwin/</literal>, and you want to install to the
+temporary location <literal>/install/</literal>, these are the required
 steps to build Cygwin:
 </para>
+
 <screen>
-$ mkdir -p /oss/src/newlib-cygwin/build    # create build dir
-$ mkdir -p /oss/install                    # create install dir
-$ cd /oss/src/newlib-cygwin/winsup         # chdir into Cygwin source dir and...
-$ ./autogen.sh                             # create config files
-$ cd /oss/src/newlib-cygwin/build          # chdir into build dir
-$                                          # create makefiles...
-$ /oss/src/newlib-cygwin/configure --prefix=/oss/install
-$ make                                     # build Cygwin
-$ make install                             # install Cygwin into install dir
+$ mkdir -p /src/newlib-cygwin/build    # create build dir
+$ mkdir -p /install                    # create install dir
+$ cd /src/newlib-cygwin/winsup         # chdir into Cygwin source dir and...
+$ ./autogen.sh                         # create config files
+$ cd /src/newlib-cygwin/build          # chdir into build dir
+$ /src/newlib-cygwin/configure         # create makefiles...
+$ make                                 # build Cygwin
+$ make -j1 install DESTDIR=/install    # install Cygwin into install dir
 </screen>
 
 <para>
-- 
2.51.0

