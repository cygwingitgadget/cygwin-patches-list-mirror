Return-Path: <cygwin-patches-return-8406-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 102102 invoked by alias); 15 Mar 2016 13:13:32 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 102090 invoked by uid 89); 15 Mar 2016 13:13:32 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=0.3 required=5.0 tests=AWL,BAYES_50,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW autolearn=no version=3.3.2 spammy=Hey, HX-CTCH-RefID:0.000,recu, consistently, ssp
X-HELO: rgout0601.bt.lon5.cpcloud.co.uk
Received: from rgout0601.bt.lon5.cpcloud.co.uk (HELO rgout0601.bt.lon5.cpcloud.co.uk) (65.20.0.128) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 15 Mar 2016 13:13:22 +0000
X-OWM-Source-IP: 86.179.112.186 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-CTCH-RefID: str=0001.0A090204.56E80A6E.0009,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-Junkmail-Premium-Raw: score=27/50,refid=2.7.2:2016.3.15.94816:17:27.888,ip=86.179.112.186,rules=__HAS_FROM, __TO_MALFORMED_2, __TO_NO_NAME, __SUBJ_ALPHA_END, __HAS_MSGID, __SANE_MSGID, __HAS_X_MAILER, __ANY_URI, __URI_NO_WWW, BODYTEXTP_SIZE_3000_LESS, BODY_SIZE_2000_2999, __MIME_TEXT_ONLY, RDNS_GENERIC_POOLED, __URI_NS, SXL_IP_DYNAMIC[186.112.179.86.fur], HTML_00_01, HTML_00_10, BODY_SIZE_5000_LESS, RDNS_SUSP_GENERIC, RDNS_SUSP, BODY_SIZE_7000_LESS, NO_URI_HTTPS
X-CTCH-Spam: Unknown
Received: from localhost.localdomain (86.179.112.186) by rgout06.bt.lon5.cpcloud.co.uk (8.6.122.06) (authenticated as jonturney@btinternet.com)        id 56E19ECD008A006C; Tue, 15 Mar 2016 13:13:33 +0000
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH] Attempt to fix Coverity issues in ssp
Date: Tue, 15 Mar 2016 13:13:00 -0000
Message-Id: <1458047571-10808-1-git-send-email-jon.turney@dronecode.org.uk>
X-SW-Source: 2016-q1/txt/msg00112.txt.bz2

	* ssp.c (lookup_thread_id): Consistently check if tix is a null
	pointer.
	(run_program): Annotate that STATUS_BREAKPOINT falls-through to
	STATUS_SINGLE_STEP case.
	(main): Guard against high_pc-low_pc overflow and malloc failure.

Signed-off-by: Jon Turney <jon.turney@dronecode.org.uk>
---
 winsup/utils/ssp.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/winsup/utils/ssp.c b/winsup/utils/ssp.c
index c9165f3..0bca544 100644
--- a/winsup/utils/ssp.c
+++ b/winsup/utils/ssp.c
@@ -182,7 +182,10 @@ static HANDLE
 lookup_thread_id (DWORD threadId, int *tix)
 {
   int i;
-  *tix = 0;
+
+  if (tix)
+    *tix = 0;
+
   for (i=0; i<num_active_threads; i++)
     if (active_thread_ids[i] == threadId)
       {
@@ -463,6 +466,7 @@ run_program (char *cmdline)
 		      thread_return_address[tix] = rv;
 		}
 	      set_step_threads (event.dwThreadId, stepping_enabled);
+	      /* fall-through */
 	    case STATUS_SINGLE_STEP:
 	      opcode_count++;
 	      pc = (CONTEXT_REG)event.u.Exception.ExceptionRecord.ExceptionAddress;
@@ -854,6 +858,7 @@ main (int argc, char **argv)
   int c, i;
   int total_pcount = 0, total_scount = 0;
   FILE *gmon;
+  ssize_t range;
 
   setbuf (stdout, 0);
 
@@ -906,14 +911,20 @@ main (int argc, char **argv)
   sscanf (argv[optind++], ADDR_SSCANF_FMT, &low_pc);
   sscanf (argv[optind++], ADDR_SSCANF_FMT, &high_pc);
 
-  if (low_pc > high_pc-8)
+  range = high_pc - low_pc;
+  if (range <= 0)
     {
       fprintf (stderr, "Hey, low_pc must be lower than high_pc\n");
       exit (1);
     }
 
-  hits = (HISTCOUNTER *)malloc (high_pc-low_pc+4);
-  memset (hits, 0, high_pc-low_pc+4);
+  hits = (HISTCOUNTER *)malloc (range+4);
+  if (!hits)
+    {
+      fprintf (stderr, "Ouch, malloc failed\n");
+      exit (1);
+    }
+  memset (hits, 0, range+4);
 
   fprintf (stderr, "prun: [" CONTEXT_REG_FMT "," CONTEXT_REG_FMT "] Running '%s'\n",
 	  low_pc, high_pc, argv[optind]);
@@ -922,13 +933,13 @@ main (int argc, char **argv)
 
   hdr.lpc = low_pc;
   hdr.hpc = high_pc;
-  hdr.ncnt = high_pc-low_pc + sizeof (hdr);
+  hdr.ncnt = range + sizeof (hdr);
   hdr.version = GMONVERSION;
   hdr.profrate = 100;
 
   gmon = fopen ("gmon.out", "wb");
   fwrite (&hdr, 1, sizeof (hdr), gmon);
-  fwrite (hits, 1, high_pc-low_pc, gmon);
+  fwrite (hits, 1, range, gmon);
   write_call_edges (gmon);
   fclose (gmon);
 
-- 
2.7.0
