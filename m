Return-Path: <jon.turney@dronecode.org.uk>
Received: from sa-prd-fep-043.btinternet.com (mailomta22-sa.btinternet.com
 [213.120.69.28])
 by sourceware.org (Postfix) with ESMTPS id 6464D3842408
 for <cygwin-patches@cygwin.com>; Tue, 21 Jul 2020 14:26:35 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 6464D3842408
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from sa-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.38.5])
 by sa-prd-fep-043.btinternet.com with ESMTP id
 <20200721142634.SFSV26847.sa-prd-fep-043.btinternet.com@sa-prd-rgout-002.btmx-prd.synchronoss.net>;
 Tue, 21 Jul 2020 15:26:34 +0100
Authentication-Results: btinternet.com; none
X-Originating-IP: [31.51.206.146]
X-OWM-Source-IP: 31.51.206.146 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedrgeeigdejfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepfeeiudevhefgffffueeuheelfeegveefvdffleejfeehudetleetledvteethfdvnecukfhppeefuddrhedurddvtdeirddugeeinecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeefuddrhedurddvtdeirddugeeipdhmrghilhhfrhhomhepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqedprhgtphhtthhopeeotgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomheqpdhrtghpthhtohepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (31.51.206.146) by
 sa-prd-rgout-002.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9AA6E07E80162; Tue, 21 Jul 2020 15:26:34 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 2/3] CYgwin: Remove synchronization event from dumper
Date: Tue, 21 Jul 2020 15:26:15 +0100
Message-Id: <20200721142616.28605-3-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200721142616.28605-1-jon.turney@dronecode.org.uk>
References: <20200721142616.28605-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 GIT_PATCH_0, KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_DNSWL_LOW,
 RCVD_IN_MSPIKE_H2, SPF_HELO_PASS, SPF_NONE,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Tue, 21 Jul 2020 14:26:39 -0000

The use of the 'cygwin_error_start_event' for synchronization with
dumper was removed from the DLL in commit 8abeff1e (April 2001).
---
 winsup/utils/dumper.cc | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/winsup/utils/dumper.cc b/winsup/utils/dumper.cc
index fa6d9641a..ace752464 100644
--- a/winsup/utils/dumper.cc
+++ b/winsup/utils/dumper.cc
@@ -627,10 +627,6 @@ dumper::collect_process_information ()
       return 0;
     }
 
-  char event_name[sizeof ("cygwin_error_start_event") + 20];
-  sprintf (event_name, "cygwin_error_start_event%16x", (unsigned int) pid);
-  HANDLE sync_with_debugee = OpenEvent (EVENT_MODIFY_STATE, FALSE, event_name);
-
   DEBUG_EVENT current_event;
 
   while (1)
@@ -701,10 +697,6 @@ dumper::collect_process_information ()
 	      goto failed;
 	    };
 
-	  /* signal a debugee that we've finished */
-	  if (sync_with_debugee)
-	    SetEvent (sync_with_debugee);
-
 	  break;
 
 	default:
@@ -730,10 +722,6 @@ failed:
   /* Otherwise, the debuggee is terminated when this process exits
      (as DebugSetProcessKillOnExit() defaults to TRUE) */
 
-  /* set debugee free */
-  if (sync_with_debugee)
-    SetEvent (sync_with_debugee);
-
   return 0;
 }
 
-- 
2.27.0

