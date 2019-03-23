Return-Path: <cygwin-patches-return-9213-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 119030 invoked by alias); 23 Mar 2019 03:46:13 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 119017 invoked by uid 89); 23 Mar 2019 03:46:12 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-14.9 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,KAM_NUMSUBJECT,RCVD_IN_DNSWL_LOW autolearn=ham version=3.3.1 spammy=
X-HELO: smtp-out-no.shaw.ca
Received: from smtp-out-no.shaw.ca (HELO smtp-out-no.shaw.ca) (64.59.134.9) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 23 Mar 2019 03:46:10 +0000
Received: from Brian.Inglis@Shaw.ca ([24.64.172.44])	by shaw.ca with ESMTP	id 7Xbjh2vUhLdsa7XbkhtU5l; Fri, 22 Mar 2019 21:46:09 -0600
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: cygwin-patches@cygwin.com
Cc: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Subject: [PATCH] default ps -W process start time to system boot time when inaccessible, 0, -1
Date: Sat, 23 Mar 2019 03:46:00 -0000
Message-Id: <20190323034522.9688-1-Brian.Inglis@SystematicSW.ab.ca>
X-IsSubscribed: yes
X-SW-Source: 2019-q1/txt/msg00023.txt.bz2


diff --git a/winsup/utils/ps.cc b/winsup/utils/ps.cc
index 4fce3e0b3..c81805ab6 100644
--- a/winsup/utils/ps.cc
+++ b/winsup/utils/ps.cc
@@ -337,6 +337,17 @@ main (int argc, char *argv[])
 		p->start_time = to_time_t (&ct);
 	      CloseHandle (h);
 	    }
+	  if (!h || 0 == p->start_time || -1 == p->start_time)
+	    {
+	      SYSTEM_TIMEOFDAY_INFORMATION stodi;
+	      status = NtQuerySystemInformation (SystemTimeOfDayInformation,
+					(PVOID) &stodi, sizeof stodi, NULL);
+	      if (!NT_SUCCESS (status))
+		fprintf (stderr,
+			"NtQuerySystemInformation(SystemTimeOfDayInformation), "
+					"status %08x", status);
+	      p->start_time = to_time_t ((FILETIME*)&stodi.BootTime);
+	    }
 	}
 
       char uname[128];
-- 
2.17.0
