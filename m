Return-Path: <cygwin-patches-return-10103-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 59583 invoked by alias); 21 Feb 2020 21:33:57 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 59570 invoked by uid 89); 21 Feb 2020 21:33:56 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-15.8 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_LOW autolearn=ham version=3.3.1 spammy=13467, lake, 5.6, Beginning
X-HELO: smtp-out-so.shaw.ca
Received: from smtp-out-so.shaw.ca (HELO smtp-out-so.shaw.ca) (64.59.136.139) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 21 Feb 2020 21:33:55 +0000
Received: from Brian.Inglis@Shaw.ca ([24.64.172.44])	by shaw.ca with ESMTP	id 5FvkjdMf7RnrK5FvljuDms; Fri, 21 Feb 2020 14:33:53 -0700
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: Cygwin Patches <cygwin-patches@cygwin.com>
Cc: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Subject: [PATCH] fhandler_proc/cpuinfo: support fast short REP MOVSB
Date: Fri, 21 Feb 2020 21:33:00 -0000
Message-Id: <20200221212807.61030-1-Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00209.txt

Added in Linux 5.6:
Check FSRM and use REP MOVSB for short copies on systems that have it.

From the Intel Optimization Reference Manual:

3.7.6.1 Fast Short REP MOVSB
Beginning with processors based on Ice Lake Client microarchitecture,
REP MOVSB performance is enhanced with string lengths up to 128 bytes.
Support for fast-short REP MOVSB is indicated by the CPUID feature flag:
CPUID [EAX=7H, ECX=0H).EDX.FAST_SHORT_REP_MOVSB[bit 4] = 1.
There is no change in the REP STOS performance.
---
 winsup/cygwin/fhandler_proc.cc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/winsup/cygwin/fhandler_proc.cc b/winsup/cygwin/fhandler_proc.cc
index 78a69703d..030ade68a 100644
--- a/winsup/cygwin/fhandler_proc.cc
+++ b/winsup/cygwin/fhandler_proc.cc
@@ -1346,6 +1346,7 @@ format_proc_cpuinfo (void *, char *&destbuf)
 
           ftcprint (features1,  2, "avx512_4vnniw");	   /* vec dot prod dw */
           ftcprint (features1,  3, "avx512_4fmaps");       /* vec 4 FMA single */
+          ftcprint (features1,  4, "fsrm");		   /* fast short REP MOVSB */
           ftcprint (features1,  8, "avx512_vp2intersect"); /* vec intcpt d/q */
           ftcprint (features1, 10, "md_clear");            /* verw clear buf */
           ftcprint (features1, 18, "pconfig");		   /* platform config */
-- 
2.21.0
