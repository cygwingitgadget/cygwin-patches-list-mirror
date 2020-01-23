Return-Path: <cygwin-patches-return-9979-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 73770 invoked by alias); 23 Jan 2020 09:23:13 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 73753 invoked by uid 89); 23 Jan 2020 09:23:12 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-15.8 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,KAM_SHORT,RCVD_IN_DNSWL_LOW autolearn=ham version=3.3.1 spammy=retired, HContent-Transfer-Encoding:8bit
X-HELO: smtp-out-so.shaw.ca
Received: from smtp-out-so.shaw.ca (HELO smtp-out-so.shaw.ca) (64.59.136.138) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 23 Jan 2020 09:23:11 +0000
Received: from Brian.Inglis@Shaw.ca ([24.64.172.44])	by shaw.ca with ESMTP	id uYhfiXhmzRnrKuYhgiSAYJ; Thu, 23 Jan 2020 02:23:09 -0700
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: Cygwin Patches <cygwin-patches@cygwin.com>
Cc: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Subject: [PATCH] fhandler_proc.cc:format_proc_cpuinfo add rdpru flag
Date: Thu, 23 Jan 2020 09:23:00 -0000
Message-Id: <20200123090626.58604-1-Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00085.txt

rdpru flag is cpuid xfn 80000008 ebx bit 4 added in linux 5.5;
see AMD64 Architecture Programmerâs Manual Volume 3:
General-Purpose and System Instructions
https://www.amd.com/system/files/TechDocs/24594.pdf#page=329
and elsewhere in that document

---
 winsup/cygwin/fhandler_proc.cc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/winsup/cygwin/fhandler_proc.cc b/winsup/cygwin/fhandler_proc.cc
index 8c331f5f4..78a69703d 100644
--- a/winsup/cygwin/fhandler_proc.cc
+++ b/winsup/cygwin/fhandler_proc.cc
@@ -1255,6 +1255,7 @@ format_proc_cpuinfo (void *, char *&destbuf)
 	  ftcprint (features1,  0, "clzero");	    /* clzero instruction */
 	  ftcprint (features1,  1, "irperf");       /* instr retired count */
 	  ftcprint (features1,  2, "xsaveerptr");   /* save/rest FP err ptrs */
+	  ftcprint (features1,  4, "rdpru");	    /* user level rd proc reg */
 /*	  ftcprint (features1,  6, "mba"); */	    /* memory BW alloc */
 	  ftcprint (features1,  9, "wbnoinvd");     /* wbnoinvd instruction */
 /*	  ftcprint (features1, 12, "ibpb" ); */	    /* ind br pred barrier */
-- 
2.21.0
