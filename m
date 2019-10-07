Return-Path: <cygwin-patches-return-9746-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15127 invoked by alias); 7 Oct 2019 16:24:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 15021 invoked by uid 89); 7 Oct 2019 16:24:45 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-15.2 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HContent-Transfer-Encoding:8bit
X-HELO: smtp-out-no.shaw.ca
Received: from smtp-out-no.shaw.ca (HELO smtp-out-no.shaw.ca) (64.59.134.12) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 07 Oct 2019 16:24:43 +0000
Received: from Brian.Inglis@Shaw.ca ([24.64.172.44])	by shaw.ca with ESMTP	id HVnciNyDCUIS2HVoQisFhQ; Mon, 07 Oct 2019 10:24:42 -0600
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: Cygwin Patches <cygwin-patches@cygwin.com>
Cc: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Subject: [PATCH v3 03/10] fhandler_proc.cc(format_proc_cpuinfo): fix AMD physical cores count
Date: Mon, 07 Oct 2019 16:24:00 -0000
Message-Id: <20191007162307.7435-4-Brian.Inglis@SystematicSW.ab.ca>
In-Reply-To: <20191007162307.7435-1-Brian.Inglis@SystematicSW.ab.ca>
References: <20191005222328.57805-1-Brian.Inglis@SystematicSW.ab.ca> <20191007162307.7435-1-Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Reply-To: Cygwin Patches <cygwin-patches@cygwin.com>
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q4/txt/msg00019.txt.bz2

fix AMD physical cores count documented as core_info low byte + 1

---
 winsup/cygwin/fhandler_proc.cc | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/winsup/cygwin/fhandler_proc.cc b/winsup/cygwin/fhandler_proc.cc
index 78518baf9..c94cde910 100644
--- a/winsup/cygwin/fhandler_proc.cc
+++ b/winsup/cygwin/fhandler_proc.cc
@@ -885,11 +885,10 @@ format_proc_cpuinfo (void *, char *&destbuf)
 
 		  cpuid (&unused, &unused, &core_info, &unused, 0x80000008);
 		  cpuid (&unused, &cus, &unused, &unused, 0x8000001e);
-		  siblings = (core_info & 0xff) + 1;
+		  siblings = cpu_cores = (core_info & 0xff) + 1;
 		  logical_bits = (core_info >> 12) & 0xf;
 		  cus = ((cus >> 8) & 0x3) + 1;
 		  ht_bits = mask_bits (cus);
-		  cpu_cores = siblings >> ht_bits;
 		}
 	      else if (maxe >= 0x80000008)
 		{
-- 
2.21.0
