Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from smtp-out-so.shaw.ca (smtp-out-so.shaw.ca [64.59.136.138])
 by sourceware.org (Postfix) with ESMTPS id 37914386102A
 for <cygwin-patches@cygwin.com>; Fri, 18 Sep 2020 02:53:39 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 37914386102A
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=brian.inglis@systematicsw.ab.ca
Received: from BWINGLISD.cg.shawcable.net ([24.64.172.44])
 by shaw.ca with ESMTP
 id J6WnkMrP9HxtDJ6Wokdqrp; Thu, 17 Sep 2020 20:53:38 -0600
X-Authority-Analysis: v=2.4 cv=Ce22WJnl c=1 sm=1 tr=0 ts=5f642132
 a=kiZT5GMN3KAWqtYcXc+/4Q==:117 a=kiZT5GMN3KAWqtYcXc+/4Q==:17
 a=L14Cc_XHxir_mNc-6-kA:9
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: cygwin-patches@cygwin.com
Subject: [PATCH v2] winsup/doc/faq-what.xml: FAQ 1.2 Windows versions supported
Date: Thu, 17 Sep 2020 20:53:35 -0600
Message-Id: <20200918025335.43795-1-Brian.Inglis@SystematicSW.ab.ca>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfByF2XHRGjCyLcDVG3TTUS13G0jrCn1VBw5K70lNMIGiJDa94uA1Ipygd3Q+CQj5/XQrLfe7h5ZUlSEYomSHKVKBdTfPIi1wrWE77S2fp0bN1PYjmwo+
 ltVlY5Igjdmw/pnmdjj848r75C1rF8Z+a12rEx0r6p31wZVRV5MsgUm+G5mR0EKdkdv+BB3B3ENAE5s98urdtRRfdjcwVGQ3Yvbhk9UPMxUZV74EByscfXQe
 d51+4NlaqWQbspKdxULb7xR/2qB8twOPXtWwP9nSfqM=
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
X-List-Received-Date: Fri, 18 Sep 2020 02:53:40 -0000

enumerate Vista, 7, 8, 10 progression to be clear, and earliest server 2008;
add 8.1, exclude S mode, add Cygwin32 on ARM, specify 64 bit only AMD/Intel
---
 winsup/doc/faq-what.xml | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/winsup/doc/faq-what.xml b/winsup/doc/faq-what.xml
index ea8496ccbc65..77ba1c5fdd9c 100644
--- a/winsup/doc/faq-what.xml
+++ b/winsup/doc/faq-what.xml
@@ -30,12 +30,12 @@ They can be used from one of the provided Unix shells like bash, tcsh or zsh.
 <question><para>What versions of Windows are supported?</para></question>
 <answer>
 
-<para>Cygwin can be expected to run on all modern, released versions of Windows.
-State January 2016 this includes Windows Vista, Windows Server 2008 and all
-later versions of Windows up to Windows 10 and Windows Server 2016.
+<para>Cygwin can be expected to run on all modern, released versions of Windows,
+from Windows Vista, 7, 8, 8.1, 10, Windows Server 2008 and all
+later versions of Windows, except Windows S mode due to its limitations.
 The 32 bit version of Cygwin also runs in the WOW64 32 bit environment on
-released 64 bit versions of Windows, the 64 bit version of course only on
-64 bit Windows.
+released 64 bit versions of Windows including ARM PCs,
+the 64 bit version of course only on 64 bit AMD/Intel compatible PCs.
 </para>
 <para>Keep in mind that Cygwin can only do as much as the underlying OS
 supports.  Because of this, Cygwin will behave differently, and
-- 
2.28.0

