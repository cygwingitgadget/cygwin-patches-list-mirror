Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from smtp-out-so.shaw.ca (smtp-out-so.shaw.ca [64.59.136.139])
 by sourceware.org (Postfix) with ESMTPS id EA7303857035
 for <cygwin-patches@cygwin.com>; Tue,  7 Jul 2020 19:01:14 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org EA7303857035
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=brian.inglis@systematicsw.ab.ca
Received: from Brian.Inglis@Shaw.ca ([24.64.172.44]) by shaw.ca with ESMTP
 id ssq8j53hLYYpxssqAj3Mdy; Tue, 07 Jul 2020 13:01:14 -0600
X-Authority-Analysis: v=2.3 cv=OubUNx3t c=1 sm=1 tr=0
 a=kiZT5GMN3KAWqtYcXc+/4Q==:117 a=kiZT5GMN3KAWqtYcXc+/4Q==:17
 a=BqgCfznX7MUA:10 a=UsIZ3BRvCboA:10 a=Iw7cVeLtZWkNrTt46JwA:9
 a=pHzHmUro8NiASowvMSCR:22 a=nt3jZW36AmriUCFCBwmW:22
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: cygwin-patches@cygwin.com
Subject: [PATCH 2/2] format_proc_cpuinfo: fix microcode revision shift
 direction
Date: Tue,  7 Jul 2020 13:00:37 -0600
Message-Id: <20200707190036.3404-2-Brian.Inglis@SystematicSW.ab.ca>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200707190036.3404-1-Brian.Inglis@SystematicSW.ab.ca>
References: <20200707190036.3404-1-Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfLuA2uxEVBhlOi3xIGHmA+Le0nvAX5WlQ8m+9g3uaY/vrYHP2GwIzg9v8xKRKS/IgnGwKPoeZ5/QUC7YyhXvXJcEW7DykHPxKygZ8HVgUicN5Yz/fe4k
 I7EI0YwaxiHb5nBp9B6iMIQA7gPTYfQYLyVLDgGcSLEZqTo5YZ5hkqDB2ZnzbtMDZSeZOmuB79jih5P+tBdNHrHJnIBCW3/ySBDkTpptp21JpeRgEDaALJHs
 kKZ+zFEpLoJrpRYXLSzNiA==
X-Spam-Status: No, score=-14.6 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_DNSWL_LOW, SPF_HELO_NONE,
 SPF_NONE, TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Tue, 07 Jul 2020 19:01:16 -0000

---
 winsup/cygwin/fhandler_proc.cc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler_proc.cc b/winsup/cygwin/fhandler_proc.cc
index f637dfd8e4..2396bfe573 100644
--- a/winsup/cygwin/fhandler_proc.cc
+++ b/winsup/cygwin/fhandler_proc.cc
@@ -735,7 +735,7 @@ format_proc_cpuinfo (void *, char *&destbuf)
 	      memcpy (&microcode, uc[uci].uc_microcode, sizeof (microcode));
 
 	      if (!(microcode & 0xFFFFFFFFLL))	/* some values in high bits */
-		  microcode <<= 32;		/* shift them down */
+		  microcode >>= 32;		/* shift them down */
 	    }
 	}
 
-- 
2.27.0

