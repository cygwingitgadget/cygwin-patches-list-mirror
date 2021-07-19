Return-Path: <jon.turney@dronecode.org.uk>
Received: from sa-prd-fep-041.btinternet.com (mailomta31-sa.btinternet.com
 [213.120.69.37])
 by sourceware.org (Postfix) with ESMTPS id 49CF739490AF
 for <cygwin-patches@cygwin.com>; Mon, 19 Jul 2021 16:32:41 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 49CF739490AF
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=dronecode.org.uk
Received: from sa-prd-rgout-004.btmx-prd.synchronoss.net ([10.2.38.7])
 by sa-prd-fep-041.btinternet.com with ESMTP id
 <20210719163240.TCQP18744.sa-prd-fep-041.btinternet.com@sa-prd-rgout-004.btmx-prd.synchronoss.net>;
 Mon, 19 Jul 2021 17:32:40 +0100
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 60D644B9044125F6
X-Originating-IP: [86.139.167.43]
X-OWM-Source-IP: 86.139.167.43 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvtddrfedtgddutddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeefieduveehgfffffeuueehleefgeevfedvffeljeefheduteelteelvdettefhvdenucfkphepkeeirddufeelrdduieejrdegfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddufeelrdduieejrdegfedpmhgrihhlfhhrohhmpeeojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqpdhrtghpthhtohepoegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmqedprhgtphhtthhopeeojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.139.167.43) by
 sa-prd-rgout-004.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 60D644B9044125F6; Mon, 19 Jul 2021 17:32:40 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 1/3] Rename WSYM_sysfile to WSM_default
Date: Mon, 19 Jul 2021 17:31:32 +0100
Message-Id: <20210719163134.9230-2-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210719163134.9230-1-jon.turney@dronecode.org.uk>
References: <20210719163134.9230-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1200.6 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 GIT_PATCH_0, KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H4, RCVD_IN_MSPIKE_WL, SPF_HELO_PASS, SPF_NONE,
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
X-List-Received-Date: Mon, 19 Jul 2021 16:32:42 -0000

Rename WSYM_sysfile to WSM_default, since it selects more than just
sysfile with magic cookie now.
---
 winsup/cygwin/globals.cc | 4 ++--
 winsup/cygwin/path.cc    | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/winsup/cygwin/globals.cc b/winsup/cygwin/globals.cc
index 3b25c2803..066026421 100644
--- a/winsup/cygwin/globals.cc
+++ b/winsup/cygwin/globals.cc
@@ -53,7 +53,7 @@ enum exit_states
    "winsymlinks" setting of the CYGWIN environment variable. */
 enum winsym_t
 {
-  WSYM_sysfile = 0,
+  WSYM_default = 0,
   WSYM_lnk,
   WSYM_native,
   WSYM_nativestrict,
@@ -71,7 +71,7 @@ bool ignore_case_with_glob;
 bool pipe_byte;
 bool reset_com;
 bool wincmdln;
-winsym_t allow_winsymlinks = WSYM_sysfile;
+winsym_t allow_winsymlinks = WSYM_default;
 bool disable_pcon;
 
 bool NO_COPY in_forkee;
diff --git a/winsup/cygwin/path.cc b/winsup/cygwin/path.cc
index 1869fb8c8..cd029c5b4 100644
--- a/winsup/cygwin/path.cc
+++ b/winsup/cygwin/path.cc
@@ -2013,7 +2013,7 @@ symlink_worker (const char *oldpath, path_conv &win32_newpath, bool isdevice)
       /* Don't try native symlinks on FSes not supporting reparse points. */
       else if ((wsym_type == WSYM_native || wsym_type == WSYM_nativestrict)
 	       && !(win32_newpath.fs_flags () & FILE_SUPPORTS_REPARSE_POINTS))
-	wsym_type = WSYM_sysfile;
+	wsym_type = WSYM_default;
 
       /* Attach .lnk suffix when shortcut is requested. */
       if (wsym_type == WSYM_lnk && !win32_newpath.exists ()
@@ -2059,9 +2059,9 @@ symlink_worker (const char *oldpath, path_conv &win32_newpath, bool isdevice)
 	      __leave;
 	    }
 	  /* Otherwise, fall back to default symlink type. */
-	  wsym_type = WSYM_sysfile;
+	  wsym_type = WSYM_default;
 	  fallthrough;
-	case WSYM_sysfile:
+	case WSYM_default:
 	  if (win32_newpath.fs_flags () & FILE_SUPPORTS_REPARSE_POINTS)
 	    {
 	      res = symlink_wsl (oldpath, win32_newpath);
-- 
2.32.0

