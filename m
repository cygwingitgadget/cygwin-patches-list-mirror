Return-Path: <cygwin-patches-return-10121-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18775 invoked by alias); 25 Feb 2020 23:45:46 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 18766 invoked by uid 89); 25 Feb 2020 23:45:46 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-15.8 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_LOW autolearn=ham version=3.3.1 spammy=HContent-Transfer-Encoding:8bit
X-HELO: smtp-out-so.shaw.ca
Received: from smtp-out-so.shaw.ca (HELO smtp-out-so.shaw.ca) (64.59.136.137) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 25 Feb 2020 23:45:44 +0000
Received: from Brian.Inglis@Shaw.ca ([24.64.172.44])	by shaw.ca with ESMTP	id 6jtVjvwiT17ZD6jtWjPdlb; Tue, 25 Feb 2020 16:45:42 -0700
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: Cygwin Patches <cygwin-patches@cygwin.com>
Cc: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Subject: [PATCH] cpuinfo:power management: add proc_feedback, acc_power
Date: Tue, 25 Feb 2020 23:45:00 -0000
Message-Id: <20200225234415.37317-1-Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Bcc: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00227.txt

linux 4.6 x86/cpu: Add advanced power management bits
Bit 11 of CPUID 8000_0007 edx is processor feedback interface.
Bit 12 of CPUID 8000_0007 edx is accumulated power.

Print proper names in /proc/cpuinfo

[missed enabling this 2016 change during previous major cpuinfo update
as no power related changes were made to the Linux files since then]
---
 winsup/cygwin/fhandler_proc.cc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/fhandler_proc.cc b/winsup/cygwin/fhandler_proc.cc
index 030ade68a..605a8443f 100644
--- a/winsup/cygwin/fhandler_proc.cc
+++ b/winsup/cygwin/fhandler_proc.cc
@@ -1397,8 +1397,8 @@ format_proc_cpuinfo (void *, char *&destbuf)
 /*	  ftcprint (features1,  8, "invariant_tsc"); */ /* TSC invariant */
 	  ftcprint (features1,  9, "cpb");          /* core performance boost */
 	  ftcprint (features1, 10, "eff_freq_ro");  /* ro eff freq interface */
-/*	  ftcprint (features1, 11, "proc_feedback"); */ /* proc feedback if */
-/*	  ftcprint (features1, 12, "acc_power"); */ /* core power reporting */
+	  ftcprint (features1, 11, "proc_feedback");/* proc feedback if */
+	  ftcprint (features1, 12, "acc_power");    /* core power reporting */
 /*	  ftcprint (features1, 13, "connstby"); */  /* connected standby */
 /*	  ftcprint (features1, 14, "rapl"); */	    /* running average power limit */
 	}
-- 
2.21.0
