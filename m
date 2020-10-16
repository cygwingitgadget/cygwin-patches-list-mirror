Return-Path: <jon.turney@dronecode.org.uk>
Received: from re-prd-fep-042.btinternet.com (mailomta10-re.btinternet.com
 [213.120.69.103])
 by sourceware.org (Postfix) with ESMTPS id 676F3386102C
 for <cygwin-patches@cygwin.com>; Fri, 16 Oct 2020 13:46:30 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 676F3386102C
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from re-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.54.6])
 by re-prd-fep-042.btinternet.com with ESMTP id
 <20201016134629.KZVU13627.re-prd-fep-042.btinternet.com@re-prd-rgout-003.btmx-prd.synchronoss.net>;
 Fri, 16 Oct 2020 14:46:29 +0100
Authentication-Results: btinternet.com;
 auth=pass (LOGIN) smtp.auth=jonturney@btinternet.com
X-Originating-IP: [86.143.43.37]
X-OWM-Source-IP: 86.143.43.37 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedujedrieehgdeilecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepueeijeeguddvuedtffeiieelfeffudefkeehgfejffefhedtkeejgeekfedtffefnecukfhppeekiedrudegfedrgeefrdefjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddugeefrdegfedrfeejpdhmrghilhhfrhhomhepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqedprhgtphhtthhopeeotgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomheqpdhrtghpthhtohepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.143.43.37) by
 re-prd-rgout-003.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9C2FD1623AB67; Fri, 16 Oct 2020 14:46:29 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH] Use aclocal option --system-acdir rather than --acdir
Date: Fri, 16 Oct 2020 14:46:15 +0100
Message-Id: <20201016134615.36159-1-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1201.2 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 GIT_PATCH_0, KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_DNSWL_NONE,
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
X-List-Received-Date: Fri, 16 Oct 2020 13:46:33 -0000

In autogen.sh, use 'aclocal --system-acdir' rather than 'aclocal --acdir'.

'--acdir' was deprecated in automake 1.11 and removed in automake 1.13.
---
 winsup/cygserver/autogen.sh | 2 +-
 winsup/cygwin/autogen.sh    | 2 +-
 winsup/utils/autogen.sh     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/winsup/cygserver/autogen.sh b/winsup/cygserver/autogen.sh
index 87a0d9c06..dc2c8b70a 100755
--- a/winsup/cygserver/autogen.sh
+++ b/winsup/cygserver/autogen.sh
@@ -1,4 +1,4 @@
 #!/bin/sh -e
-/usr/bin/aclocal --acdir=..
+/usr/bin/aclocal --system-acdir=..
 /usr/bin/autoconf -f
 exec /bin/rm -rf autom4te.cache
diff --git a/winsup/cygwin/autogen.sh b/winsup/cygwin/autogen.sh
index 87a0d9c06..dc2c8b70a 100755
--- a/winsup/cygwin/autogen.sh
+++ b/winsup/cygwin/autogen.sh
@@ -1,4 +1,4 @@
 #!/bin/sh -e
-/usr/bin/aclocal --acdir=..
+/usr/bin/aclocal --system-acdir=..
 /usr/bin/autoconf -f
 exec /bin/rm -rf autom4te.cache
diff --git a/winsup/utils/autogen.sh b/winsup/utils/autogen.sh
index 87a0d9c06..dc2c8b70a 100755
--- a/winsup/utils/autogen.sh
+++ b/winsup/utils/autogen.sh
@@ -1,4 +1,4 @@
 #!/bin/sh -e
-/usr/bin/aclocal --acdir=..
+/usr/bin/aclocal --system-acdir=..
 /usr/bin/autoconf -f
 exec /bin/rm -rf autom4te.cache
-- 
2.28.0

