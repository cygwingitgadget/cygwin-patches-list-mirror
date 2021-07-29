Return-Path: <jon.turney@dronecode.org.uk>
Received: from sa-prd-fep-045.btinternet.com (mailomta13-sa.btinternet.com
 [213.120.69.19])
 by sourceware.org (Postfix) with ESMTPS id CE59E385040E
 for <cygwin-patches@cygwin.com>; Thu, 29 Jul 2021 17:21:23 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org CE59E385040E
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=dronecode.org.uk
Received: from sa-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.38.5])
 by sa-prd-fep-045.btinternet.com with ESMTP id
 <20210729172122.ZYZQ17681.sa-prd-fep-045.btinternet.com@sa-prd-rgout-002.btmx-prd.synchronoss.net>;
 Thu, 29 Jul 2021 18:21:22 +0100
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 60FF56FA0062DA99
X-Originating-IP: [86.139.158.70]
X-OWM-Source-IP: 86.139.158.70 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvtddrheefgdeihecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepfeeiudevhefgffffueeuheelfeegveefvdffleejfeehudetleetledvteethfdvnecukfhppeekiedrudefledrudehkedrjedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudefledrudehkedrjedtpdhmrghilhhfrhhomhepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqedprhgtphhtthhopeeotgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomheqpdhrtghpthhtohepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.139.158.70) by
 sa-prd-rgout-002.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 60FF56FA0062DA99; Thu, 29 Jul 2021 18:21:22 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 1/2] Rename WSYM_sysfile to WSM_default
Date: Thu, 29 Jul 2021 18:20:11 +0100
Message-Id: <20210729172012.10624-2-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210729172012.10624-1-jon.turney@dronecode.org.uk>
References: <20210729172012.10624-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1200.1 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
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
X-List-Received-Date: Thu, 29 Jul 2021 17:21:25 -0000

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

