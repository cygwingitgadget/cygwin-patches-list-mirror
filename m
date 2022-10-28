Return-Path: <jon.turney@dronecode.org.uk>
Received: from re-prd-fep-046.btinternet.com (mailomta17-re.btinternet.com [213.120.69.110])
	by sourceware.org (Postfix) with ESMTPS id E43E7384B832
	for <cygwin-patches@cygwin.com>; Fri, 28 Oct 2022 15:06:14 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org E43E7384B832
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=dronecode.org.uk
Received: from re-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.54.8])
          by re-prd-fep-046.btinternet.com with ESMTP
          id <20221028150613.ZOT3123.re-prd-fep-046.btinternet.com@re-prd-rgout-005.btmx-prd.synchronoss.net>;
          Fri, 28 Oct 2022 16:06:13 +0100
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 613A91243FFB1233
X-Originating-IP: [86.139.199.187]
X-OWM-Source-IP: 86.139.199.187 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvgedrtdeigdekfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeeliedtjefhtdevkeehueegffegveeftdejjeevfefhiefffeektddvteehheeijeenucfkphepkeeirddufeelrdduleelrddukeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudefledrudelledrudekjedpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomhdprhgtphhtthhopehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhk
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.139.199.187) by re-prd-rgout-005.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as jonturney@btinternet.com)
        id 613A91243FFB1233; Fri, 28 Oct 2022 16:06:13 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 1/3] Cygwin: Tidy up formatting of stackdump
Date: Fri, 28 Oct 2022 16:05:56 +0100
Message-Id: <20221028150558.2300-2-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221028150558.2300-1-jon.turney@dronecode.org.uk>
References: <20221028150558.2300-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1199.0 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,GIT_PATCH_0,KAM_DMARC_STATUS,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Resize stackdump headers for b9e97f58
Consistently use \r\n line endings
---
 winsup/cygwin/exceptions.cc | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
index e6f868511..a15bc16c5 100644
--- a/winsup/cygwin/exceptions.cc
+++ b/winsup/cygwin/exceptions.cc
@@ -342,7 +342,7 @@ cygwin_exception::dumpstack ()
       int i;
 
       thestack.init (framep, 1, ctx);	/* Initialize from the input CONTEXT */
-      small_printf ("Stack trace:\r\nFrame        Function    Args\r\n");
+      small_printf ("Stack trace:\r\nFrame         Function      Args\r\n");
       for (i = 0; i < DUMPSTACK_FRAME_LIMIT && thestack++; i++)
 	{
 	  small_printf ("%012X  %012X", thestack.sf.AddrFrame.Offset,
@@ -352,9 +352,9 @@ cygwin_exception::dumpstack ()
 			  thestack.sf.Params[j]);
 	  small_printf (")\r\n");
 	}
-      small_printf ("End of stack trace%s\n",
+      small_printf ("End of stack trace%s\r\n",
 		    i == DUMPSTACK_FRAME_LIMIT ?
-		        " (more stack frames may be present)" : "");
+		    " (more stack frames may be present)" : "");
       if (h)
 	NtClose (h);
     }
-- 
2.38.1

