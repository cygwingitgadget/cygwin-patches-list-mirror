Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from smtp-out-so.shaw.ca (smtp-out-so.shaw.ca [64.59.136.138])
 by sourceware.org (Postfix) with ESMTPS id 5C749385B835
 for <cygwin-patches@cygwin.com>; Sat, 11 Apr 2020 04:38:08 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 5C749385B835
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=brian.inglis@systematicsw.ab.ca
Received: from Brian.Inglis@Shaw.ca ([24.64.172.44]) by shaw.ca with ESMTP
 id N7u8j1ycv7t92N7u9jEZ8v; Fri, 10 Apr 2020 22:38:06 -0600
X-Authority-Analysis: v=2.3 cv=Os7UNx3t c=1 sm=1 tr=0
 a=kiZT5GMN3KAWqtYcXc+/4Q==:117 a=kiZT5GMN3KAWqtYcXc+/4Q==:17
 a=BqgCfznX7MUA:10 a=UsIZ3BRvCboA:10 a=kSaO1jrOX3gQbBapYbMA:9
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: Cygwin Patches <cygwin-patches@cygwin.com>
Subject: [PATCH] proc_cpuinfo: Add PPIN support for AMD
Date: Fri, 10 Apr 2020 22:35:28 -0600
Message-Id: <20200411043527.6881-1-Brian.Inglis@SystematicSW.ab.ca>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfHN5y4fxzRO7TMGKo8YrxY/Ij8I8MTgKVvZ2u3lhJgmW4QQn6ElQxiaXkZnfDtUXMENthynMqYj/W1fyDaYv3JHgbi7KAokPuJ4Q2FxqRz7RP+W518wT
 nzBgzTiY8inP2XS7/j+47xDKRU+NmvcR8CvdGTlM24zYRgngtxr+KSPFbdlde0wLEdjyUlrcXeWDmbU8TG1Cziida81A/D82la3Vtyw+lE1cnd7drqXTbEZH
 l6HjHBeljI1pIyiAoOrXsg==
X-Spam-Status: No, score=-35.1 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 GIT_PATCH_1, GIT_PATCH_2, GIT_PATCH_3, KAM_DMARC_STATUS,
 KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_DNSWL_LOW, SPF_HELO_NONE, SPF_NONE,
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
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Sat, 11 Apr 2020 04:38:11 -0000

Newer AMD CPUs support a feature called protected processor
identification number (PPIN). This feature can be detected via
CPUID_Fn80000008_EBX[23].
---
 winsup/cygwin/fhandler_proc.cc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/winsup/cygwin/fhandler_proc.cc b/winsup/cygwin/fhandler_proc.cc
index 605a8443f0..5c5f4bd9ef 100644
--- a/winsup/cygwin/fhandler_proc.cc
+++ b/winsup/cygwin/fhandler_proc.cc
@@ -1262,6 +1262,7 @@ format_proc_cpuinfo (void *, char *&destbuf)
 /*	  ftcprint (features1, 14, "ibrs" ); */	    /* ind br restricted spec */
 /*	  ftcprint (features1, 15, "stibp"); */	    /* 1 thread ind br pred */
 /*	  ftcprint (features1, 17, "stibp_always_on"); */ /* stibp always on */
+	  ftcprint (features1, 23, "amd_ppin");     /* protected proc id no */
 /*	  ftcprint (features1, 24, "ssbd"); */	    /* spec store byp dis */
 	  ftcprint (features1, 25, "virt_ssbd");    /* vir spec store byp dis */
 /*	  ftcprint (features1, 26, "ssb_no"); */    /* ssb fixed in hardware */
-- 
2.21.0

