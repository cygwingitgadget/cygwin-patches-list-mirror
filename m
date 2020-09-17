Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from smtp-out-so.shaw.ca (smtp-out-so.shaw.ca [64.59.136.137])
 by sourceware.org (Postfix) with ESMTPS id 9DF4D3944437
 for <cygwin-patches@cygwin.com>; Thu, 17 Sep 2020 18:29:22 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 9DF4D3944437
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=brian.inglis@systematicsw.ab.ca
Received: from BWINGLISD.cg.shawcable.net ([24.64.172.44])
 by shaw.ca with ESMTP
 id IyelkNeRCLWW5IyemkmFkL; Thu, 17 Sep 2020 12:29:21 -0600
X-Authority-Analysis: v=2.4 cv=Z5JSoFdA c=1 sm=1 tr=0 ts=5f63ab01
 a=kiZT5GMN3KAWqtYcXc+/4Q==:117 a=kiZT5GMN3KAWqtYcXc+/4Q==:17 a=w_pzkKWiAAAA:8
 a=-68wpslBUNL7k_b9RikA:9 a=A90EPXCT5DQA:10 a=sRI3_1zDfAgwuvI8zelB:22
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: cygwin-patches@cygwin.com
Subject: [PATCH] winsup/doc/faq-what.xml: FAQ 1.2 Windows versions supported
Date: Thu, 17 Sep 2020 12:29:17 -0600
Message-Id: <20200917182917.6116-1-Brian.Inglis@SystematicSW.ab.ca>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfMSBLt41xakxQ17ZPondrs8JSdurE8rZiENl+zhtODMSWnFwTT1IkcU6JlulNab7wf4kvCzWzw8yVfJmmmlAzIsOUP8oBx49hoXxD9uFQe2jnIzu0a21
 JdT+rGS6fnaJy/5klVurf5KWehtdgsioHt+X5ZHhplzrx1UIRQw+E9HI1nU6pwc4568YxecIdH7AifSMJB4jZmCPTkeZmi82rLDhS2jpQA+NQybVz4VTUHvU
 7EpggXvlk9VMqCbUWqXsEIiu9TbA04aLRB8q5q+uRPs=
X-Spam-Status: No, score=-11.7 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_DNSWL_LOW, SPF_HELO_NONE,
 SPF_NONE, TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Thu, 17 Sep 2020 18:29:24 -0000

Based on thread https://cygwin.com/pipermail/cygwin/2020-September/246318.html
enumerate Vista, 7, 8, 10 progression to be clear, and earliest server 2008
---
 winsup/doc/faq-what.xml | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/winsup/doc/faq-what.xml b/winsup/doc/faq-what.xml
index ea8496ccbc65..09747532c2e8 100644
--- a/winsup/doc/faq-what.xml
+++ b/winsup/doc/faq-what.xml
@@ -30,9 +30,9 @@ They can be used from one of the provided Unix shells like bash, tcsh or zsh.
 <question><para>What versions of Windows are supported?</para></question>
 <answer>
 
-<para>Cygwin can be expected to run on all modern, released versions of Windows.
-State January 2016 this includes Windows Vista, Windows Server 2008 and all
-later versions of Windows up to Windows 10 and Windows Server 2016.
+<para>Cygwin can be expected to run on all modern, released versions of Windows,
+from Windows Vista, 7, 8, 10, Windows Server 2008, and all
+later versions of Windows.
 The 32 bit version of Cygwin also runs in the WOW64 32 bit environment on
 released 64 bit versions of Windows, the 64 bit version of course only on
 64 bit Windows.
-- 
2.28.0

