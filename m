Return-Path: <cygwin-patches-return-9228-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 96619 invoked by alias); 24 Mar 2019 02:23:12 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 96557 invoked by uid 89); 24 Mar 2019 02:23:12 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-16.0 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_LOW autolearn=ham version=3.3.1 spammy=privilege
X-HELO: smtp-out-no.shaw.ca
Received: from smtp-out-no.shaw.ca (HELO smtp-out-no.shaw.ca) (64.59.134.9) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 24 Mar 2019 02:23:10 +0000
Received: from Brian.Inglis@Shaw.ca ([24.64.172.44])	by shaw.ca with ESMTP	id 7smrhAgebLdsa7smyhvL7Q; Sat, 23 Mar 2019 20:23:09 -0600
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: Cygwin Patches <cygwin-patches@cygwin.com>
Cc: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Subject: [PATCH 2/2] get and convert boot time once and use as needed
Date: Sun, 24 Mar 2019 02:23:00 -0000
Message-Id: <20190324022239.48618-3-Brian.Inglis@SystematicSW.ab.ca>
In-Reply-To: <20190324022239.48618-1-Brian.Inglis@SystematicSW.ab.ca>
References: <20190324022239.48618-1-Brian.Inglis@SystematicSW.ab.ca>
X-IsSubscribed: yes
X-SW-Source: 2019-q1/txt/msg00038.txt.bz2

---
 winsup/utils/ps.cc | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/winsup/utils/ps.cc b/winsup/utils/ps.cc
index c81805ab6..75a91f5be 100644
--- a/winsup/utils/ps.cc
+++ b/winsup/utils/ps.cc
@@ -164,6 +164,7 @@ main (int argc, char *argv[])
   const char *lfmt   = "%c %7d %7d %7d %10u %4s %8u %8s %s\n";
   char ch;
   void *drive_map = NULL;
+  time_t boot_time = -1;
 
   aflag = lflag = fflag = sflag = 0;
   uid = getuid ();
@@ -237,9 +238,12 @@ main (int argc, char *argv[])
 
   if (query == CW_GETPINFO_FULL)
     {
+      HANDLE tok;
+      NTSTATUS status;
+      SYSTEM_TIMEOFDAY_INFORMATION stodi;
+
       /* Enable debug privilege to allow to enumerate all processes,
 	 not only processes in current session. */
-      HANDLE tok;
       if (OpenProcessToken (GetCurrentProcess (),
 			    TOKEN_QUERY | TOKEN_ADJUST_PRIVILEGES,
 			    &tok))
@@ -256,6 +260,15 @@ main (int argc, char *argv[])
 	}
 
       drive_map = (void *) cygwin_internal (CW_ALLOC_DRIVE_MAP);
+
+      /* Get system boot time to default process start time */
+      status = NtQuerySystemInformation (SystemTimeOfDayInformation,
+				(PVOID) &stodi, sizeof stodi, NULL);
+      if (!NT_SUCCESS (status))
+	fprintf (stderr,
+		"NtQuerySystemInformation(SystemTimeOfDayInformation), "
+				"status %#010x\n", status);
+      boot_time = to_time_t ((FILETIME*)&stodi.BootTime);
     }
 
   for (int pid = 0;
@@ -337,16 +350,10 @@ main (int argc, char *argv[])
 		p->start_time = to_time_t (&ct);
 	      CloseHandle (h);
 	    }
+	  /* Default to boot time when process start time inaccessible, 0, -1 */
 	  if (!h || 0 == p->start_time || -1 == p->start_time)
 	    {
-	      SYSTEM_TIMEOFDAY_INFORMATION stodi;
-	      status = NtQuerySystemInformation (SystemTimeOfDayInformation,
-					(PVOID) &stodi, sizeof stodi, NULL);
-	      if (!NT_SUCCESS (status))
-		fprintf (stderr,
-			"NtQuerySystemInformation(SystemTimeOfDayInformation), "
-					"status %08x", status);
-	      p->start_time = to_time_t ((FILETIME*)&stodi.BootTime);
+	      p->start_time = boot_time;
 	    }
 	}
 
-- 
2.17.0
