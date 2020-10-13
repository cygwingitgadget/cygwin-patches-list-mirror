Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from smtp-out-no.shaw.ca (smtp-out-no.shaw.ca [64.59.134.9])
 by sourceware.org (Postfix) with ESMTPS id A160D38618EB
 for <cygwin-patches@cygwin.com>; Tue, 13 Oct 2020 15:11:12 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org A160D38618EB
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=brian.inglis@systematicsw.ab.ca
Received: from BWINGLISD.cg.shawcable.net ([24.64.172.44])
 by shaw.ca with ESMTP
 id SLxGkyVK5TWWpSLxHkMvZG; Tue, 13 Oct 2020 09:11:11 -0600
X-Authority-Analysis: v=2.4 cv=EcV2/NqC c=1 sm=1 tr=0 ts=5f85c38f
 a=kiZT5GMN3KAWqtYcXc+/4Q==:117 a=kiZT5GMN3KAWqtYcXc+/4Q==:17
 a=h_dkKMdqjYuC9GeYJ54A:9
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: cygwin-patches@cygwin.com
Subject: [PATCH] format_proc_cpuinfo: add enqcmd cpuinfo flag
Date: Tue, 13 Oct 2020 09:11:08 -0600
Message-Id: <20201013151108.36189-1-Brian.Inglis@SystematicSW.ab.ca>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Reply-To: cygwin-patches@cygwin.com
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfHF8sYoWrcW4EmQndc034d0VXWFGgO0Uz1yWHIyTIUiI6bC7GW5TuJ7g6PyU6lgITU+gugm7VML5nWuM6D8B2OFybDgBe+vR0zwSk3hNi9Qq24UNzZQu
 CY1MwLqpQWonxTkCrrBJns9ZshCh9jk/r7fOhXW33sCZTEeUJnA5hrOUPyLeio4DT+niGV71wkox68547rNppQPaCs+axhv3Gp6ZHsJaFNH99DBxZllEWykM
 Sn5LbOnbw3ufCvk779MZRgy+ci20Q5NdYVWAiZlAx+g=
X-Spam-Status: No, score=-12.6 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_DNSWL_LOW,
 RCVD_IN_MSPIKE_H3, RCVD_IN_MSPIKE_WL, SPF_HELO_NONE, SPF_NONE,
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
X-List-Received-Date: Tue, 13 Oct 2020 15:11:14 -0000

Add linux-next 5.9 cpuinfo flag for Intel enqcmd/s instructions:
x86/cpufeatures: Enumerate ENQCMD and ENQCMDS instructions:
Work submission instruction comes in two flavors. ENQCMD can be called
both in ring 3 and ring 0 and always uses the contents of a PASID MSR
when shipping the command to the device. ENQCMDS allows a kernel driver
to submit commands on behalf of a user process. The driver supplies the
PASID value in ENQCMDS. There isn't any usage of ENQCMD in the kernel as
of now.
The CPU feature flag is shown as "enqcmd" in /proc/cpuinfo.
---
 winsup/cygwin/fhandler_proc.cc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/winsup/cygwin/fhandler_proc.cc b/winsup/cygwin/fhandler_proc.cc
index 6f6e8291a0ca..13397150ff53 100644
--- a/winsup/cygwin/fhandler_proc.cc
+++ b/winsup/cygwin/fhandler_proc.cc
@@ -1563,6 +1563,7 @@ format_proc_cpuinfo (void *, char *&destbuf)
 	  ftcprint (features1, 25, "cldemote");         /* cldemote instr */
 	  ftcprint (features1, 27, "movdiri");          /* movdiri instr */
 	  ftcprint (features1, 28, "movdir64b");        /* movdir64b instr */
+	  ftcprint (features1, 29, "enqcmd");		/* enqcmd/s instructions*/
         }
 
       /* AMD MCA cpuid 0x80000007 ebx */
-- 
2.28.0

