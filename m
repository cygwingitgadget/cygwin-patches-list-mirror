Return-Path: <jon.turney@dronecode.org.uk>
Received: from sa-prd-fep-040.btinternet.com (mailomta26-sa.btinternet.com
 [213.120.69.32])
 by sourceware.org (Postfix) with ESMTPS id 2C8FD384240D
 for <cygwin-patches@cygwin.com>; Tue, 21 Jul 2020 14:26:37 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 2C8FD384240D
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from sa-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.38.5])
 by sa-prd-fep-040.btinternet.com with ESMTP id
 <20200721142636.KCTV5290.sa-prd-fep-040.btinternet.com@sa-prd-rgout-002.btmx-prd.synchronoss.net>;
 Tue, 21 Jul 2020 15:26:36 +0100
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
 id 5ED9AA6E07E801B5; Tue, 21 Jul 2020 15:26:36 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 3/3] Cygwin: Speed up dumper
Date: Tue, 21 Jul 2020 15:26:16 +0100
Message-Id: <20200721142616.28605-4-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200721142616.28605-1-jon.turney@dronecode.org.uk>
References: <20200721142616.28605-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
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
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Tue, 21 Jul 2020 14:26:39 -0000

Stop after we've written the dump in response to the initial breakpoint
EXCEPTION_DEBUG_EVENT we recieve for attaching to the process.

(rather than bogusly sitting there for 20 seconds waiting for more debug
events from a stopped process after we've already written the dump).
---
 winsup/utils/dumper.cc | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/winsup/utils/dumper.cc b/winsup/utils/dumper.cc
index ace752464..e80758e0c 100644
--- a/winsup/utils/dumper.cc
+++ b/winsup/utils/dumper.cc
@@ -615,8 +615,6 @@ out:
 int
 dumper::collect_process_information ()
 {
-  int exception_level = 0;
-
   if (!sane ())
     return 0;
 
@@ -631,7 +629,7 @@ dumper::collect_process_information ()
 
   while (1)
     {
-      if (!WaitForDebugEvent (&current_event, 20000))
+      if (!WaitForDebugEvent (&current_event, INFINITE))
 	return 0;
 
       deb_printf ("got debug event %d\n", current_event.dwDebugEventCode);
@@ -675,12 +673,6 @@ dumper::collect_process_information ()
 
 	case EXCEPTION_DEBUG_EVENT:
 
-	  exception_level++;
-	  if (exception_level == 2)
-	    break;
-	  else if (exception_level > 2)
-	    return 0;
-
 	  collect_memory_sections ();
 
 	  /* got all info. time to dump */
@@ -697,6 +689,9 @@ dumper::collect_process_information ()
 	      goto failed;
 	    };
 
+	  /* We're done */
+	  goto failed;
+
 	  break;
 
 	default:
-- 
2.27.0

