Return-Path: <SRS0=fe21=DF=dronecode.org.uk=jon.turney@sourceware.org>
Received: from sa-prd-fep-046.btinternet.com (mailomta11-sa.btinternet.com [213.120.69.17])
	by sourceware.org (Postfix) with ESMTPS id 24E7F3858439
	for <cygwin-patches@cygwin.com>; Wed, 19 Jul 2023 12:42:01 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 24E7F3858439
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
Received: from sa-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.38.5])
          by sa-prd-fep-046.btinternet.com with ESMTP
          id <20230719124159.XYGE17034.sa-prd-fep-046.btinternet.com@sa-prd-rgout-002.btmx-prd.synchronoss.net>;
          Wed, 19 Jul 2023 13:41:59 +0100
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 64AECEEE00C7CE32
X-Originating-IP: [81.129.146.179]
X-OWM-Source-IP: 81.129.146.179 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedviedrgeekgdeflecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeeliedtjefhtdevkeehueegffegveeftdejjeevfefhiefffeektddvteehheeijeenucfkphepkedurdduvdelrddugeeirddujeelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekuddruddvledrudegiedrudejledpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomhdprhgtphhtthhopehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhrvghvkffrpehhohhsthekuddquddvledqudegiedqudejledrrhgrnhhgvgekuddquddvledrsghttggvnhhtrhgrlhhplhhushdrtghomhdprghuthhhpghushgvrhepjhhonhhtuhhrnhgvhiessghtihhnthgvrhhnvghtrdgtohhm
	pdhgvghokffrpefiuedpoffvtefjohhsthepshgrqdhprhguqdhrghhouhhtqddttddv
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (81.129.146.179) by sa-prd-rgout-002.btmx-prd.synchronoss.net (5.8.814) (authenticated as jonturney@btinternet.com)
        id 64AECEEE00C7CE32; Wed, 19 Jul 2023 13:41:59 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 2/2] Cygwin: Fix Windows file handle leak in stat("file", -1)
Date: Wed, 19 Jul 2023 13:41:42 +0100
Message-Id: <20230719124142.10310-3-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230719124142.10310-1-jon.turney@dronecode.org.uk>
References: <20230719124142.10310-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Don't leak a Windows file handle if stat() is called with a valid
filename, but invalid stat buffer pointer.

We do not destroy fh if an exception happens in the __try block, which
closes a Windows handle it has opened.

Fixes: 73151c54d581 ("syscalls.cc (stat_worker): Don't call build_fh_pc with invalid pc.")
Signed-off-by: Jon Turney <jon.turney@dronecode.org.uk>
---
 winsup/cygwin/syscalls.cc | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
index 73343ecc1..c6999407e 100644
--- a/winsup/cygwin/syscalls.cc
+++ b/winsup/cygwin/syscalls.cc
@@ -1955,6 +1955,7 @@ int
 stat_worker (path_conv &pc, struct stat *buf)
 {
   int res = -1;
+  fhandler_base *fh = NULL;
 
   __try
     {
@@ -1965,8 +1966,6 @@ stat_worker (path_conv &pc, struct stat *buf)
 	}
       else if (pc.exists ())
 	{
-	  fhandler_base *fh;
-
 	  if (!(fh = build_fh_pc (pc)))
 	    __leave;
 
@@ -1976,13 +1975,14 @@ stat_worker (path_conv &pc, struct stat *buf)
 	  res = fh->fstat (buf);
 	  if (!res)
 	    fh->stat_fixup (buf);
-	  delete fh;
 	}
       else
 	set_errno (ENOENT);
     }
   __except (EFAULT) {}
   __endtry
+
+  delete fh;
   syscall_printf ("%d = (%S,%p)", res, pc.get_nt_native_path (), buf);
   return res;
 }
-- 
2.39.0

