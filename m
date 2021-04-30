Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from smtp-out-so.shaw.ca (smtp-out-so.shaw.ca [64.59.136.137])
 by sourceware.org (Postfix) with ESMTPS id EC1AC3A47433
 for <cygwin-patches@cygwin.com>; Fri, 30 Apr 2021 13:19:25 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org EC1AC3A47433
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=brian.inglis@systematicsw.ab.ca
Received: from BWINGLISD.cg.shawcable.net. ([68.147.0.90])
 by shaw.ca with ESMTP
 id cT3DlVAAPlrmAcT3El26Uy; Fri, 30 Apr 2021 07:19:24 -0600
X-Authority-Analysis: v=2.4 cv=DK3sXwBb c=1 sm=1 tr=0 ts=608c03dc
 a=T+ovY1NZ+FAi/xYICV7Bgg==:117 a=T+ovY1NZ+FAi/xYICV7Bgg==:17
 a=CEE9eUwYcGiNUC0X2AQA:9
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: cygwin-patches@cygwin.com
Subject: [PATCH] format_proc_swaps: ensure space between fields for clarity
Date: Fri, 30 Apr 2021 07:19:20 -0600
Message-Id: <20210430131921.36002-1-Brian.Inglis@SystematicSW.ab.ca>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfFdD11WcGpfz4yserXH9tkfWGQFXXVz9M9EdgztoZAjlh9+howHB1s8GA3FvHarA9NaDXvFha5CDrOeO/sLyeciZgclfnyxSOLm34fWNXeayFGcKZDXC
 iE24VCcfxhyAdfLXpWDpnNKIUIhhIxErOiLRao5iBFn088cCrbCLxpIYt36pZoyqCyhtJabLw9uRmh886fj+KWljUDLqNEUGL40K0gig8dQHPBYSJQSfZDA/
 ifymujSKQ3nY+g/rUNmSfySlaAIE9HjaoCN2N/wmVVk=
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_BARRACUDACENTRAL,
 RCVD_IN_DNSWL_LOW, SPF_HELO_NONE, SPF_NONE,
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
X-List-Received-Date: Fri, 30 Apr 2021 13:19:27 -0000

page/swap space name >= 40 or size/used >= 8 leaves no space between fields;
ensure a space after name and add extra tabs after size and used fields;
output appears like Linux 5.8 after changes to mm/swapfile(swap_show);

proc-swaps-space-before.log:
==> /proc/swaps <==
Filename				Type		Size	Used	Priority
/mnt/c/pagefile.sys                     file            11567748292920  0
/mnt/d/pagefile.sys                     file            12582912205960  0

proc-swaps-space-after.log:
==> /proc/swaps <==
Filename				Type		Size		Used		Priority
/mnt/c/pagefile.sys			file		11567748	241024		0
/mnt/d/pagefile.sys			file		12582912	182928		0
---
 winsup/cygwin/fhandler_proc.cc | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/winsup/cygwin/fhandler_proc.cc b/winsup/cygwin/fhandler_proc.cc
index 7cd0b3af02..eb4efb07d4 100644
--- a/winsup/cygwin/fhandler_proc.cc
+++ b/winsup/cygwin/fhandler_proc.cc
@@ -1920,7 +1920,7 @@ format_proc_swaps (void *, char *&destbuf)
     }
 
   bufptr += __small_sprintf (bufptr,
-			     "Filename\t\t\t\tType\t\tSize\tUsed\tPriority\n");
+			"Filename\t\t\t\tType\t\tSize\t\tUsed\t\tPriority\n");
 
   if (spi && NT_SUCCESS (status))
     {
@@ -1932,8 +1932,17 @@ format_proc_swaps (void *, char *&destbuf)
 	  used = (unsigned long long) spp->TotalUsed * wincap.page_size ();
 	  cygwin_conv_path (CCP_WIN_W_TO_POSIX, spp->FileName.Buffer,
 			    filename, NT_MAX_PATH);
-	  bufptr += sprintf (bufptr, "%-40s%-16s%-8llu%-8llu%-8d\n",
-			     filename, "file", total >> 10, used >> 10, 0);
+	  /* ensure space between fields for clarity */
+	  size_t tabo = strlen (filename) / 8;	/* offset tabs to space name */
+	  bufptr += sprintf (bufptr, "%s%s%s\t\t%llu%s\t%llu%s\t%d\n",
+				    filename,
+				    tabo < 5 ? "\t\t\t\t\t" + tabo : " ",
+					"file",
+					    total >> 10,
+					    total < 10000000000 ? "\t" : "",
+						used  >> 10,
+						used  < 10000000000 ? "\t" : "",
+								0);
 	}
       while (spp->NextEntryOffset
 	     && (spp = (PSYSTEM_PAGEFILE_INFORMATION)
-- 
2.31.1

