Return-Path: <cygwin-patches-return-9400-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 67419 invoked by alias); 3 May 2019 14:14:19 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 67111 invoked by uid 89); 3 May 2019 14:14:19 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-20.0 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_PASS autolearn=ham version=3.3.1 spammy=H*r:4.77, HTo:U*cygwin-patches, prev-gcc, H*RU:sk:michael
X-HELO: atfriesa01.ssi-schaefer.com
Received: from atfriesa01.ssi-schaefer.com (HELO atfriesa01.ssi-schaefer.com) (193.186.16.100) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 03 May 2019 14:14:17 +0000
Received: from samail03.wamas.com (HELO mailhost.salomon.at) ([172.28.33.235])  by atfriesa01.ssi-schaefer.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 May 2019 16:14:15 +0200
Received: from [172.28.42.244]	by mailhost.salomon.at with esmtp (Exim 4.77)	(envelope-from <michael.haubenwallner@ssi-schaefer.com>)	id 1hMYx4-0002X1-Tm; Fri, 03 May 2019 16:14:14 +0200
From: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
Subject: [PATCH] Cygwin: dll_list: stat_real_file_once with ntname
To: cygwin-patches@cygwin.com
Cc: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
Openpgp: preference=signencrypt
Message-ID: <4e4cb543-f808-61f1-57be-06db527c57b3@ssi-schaefer.com>
Date: Fri, 03 May 2019 14:14:00 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2019-q2/txt/msg00107.txt.bz2

NtQueryVirtualMemory for MemorySectionName may return some old path even
if the process was just started, for when some directory in between was
renamed - maybe because the NT file cache is hot for the old path still.
This was seen during gcc bootstrap, returning a MemorySectionName of
".../gcc/xgcc.exe" even if started as ".../prev-gcc/xgcc.exe", where the
directory rename from "gcc" to "prev-gcc" was done the moment before.
As we stat the module's real file right after loading now, there is no
point in using NtQueryVirtualMemory with MemorySectionName any more, and
we can use what GetModuleFileName returned instead.
---
 winsup/cygwin/dll_init.cc |  2 +-
 winsup/cygwin/forkable.cc | 40 +++++++--------------------------------
 2 files changed, 8 insertions(+), 34 deletions(-)

diff --git a/winsup/cygwin/dll_init.cc b/winsup/cygwin/dll_init.cc
index 4ba1bd22d..6a4ed269e 100644
--- a/winsup/cygwin/dll_init.cc
+++ b/winsup/cygwin/dll_init.cc
@@ -381,7 +381,7 @@ dll_list::alloc (HINSTANCE h, per_process *p, dll_type type)
 	  *d->forkable_ntname = L'\0';
 	}
       if (forkables_supported ())
-	d->stat_real_file_once (); /* uses nt_max_path_buf () */
+	d->stat_real_file_once ();
       append (d);
       if (type == DLL_LOAD)
 	loaded_dlls++;
diff --git a/winsup/cygwin/forkable.cc b/winsup/cygwin/forkable.cc
index 1dcafe5e1..4fbc2abb3 100644
--- a/winsup/cygwin/forkable.cc
+++ b/winsup/cygwin/forkable.cc
@@ -161,44 +161,18 @@ dll::stat_real_file_once ()
   if (fii.IndexNumber.QuadPart != -1LL)
     return true;
 
-  tmp_pathbuf tp;
-
-  HANDLE fhandle = INVALID_HANDLE_VALUE;
-  NTSTATUS status, fstatus;
-  PMEMORY_SECTION_NAME pmsi1;
-  MEMORY_SECTION_NAME msi2;
-  pmsi1 = (PMEMORY_SECTION_NAME) dll_list::nt_max_path_buf ();
-  RtlInitEmptyUnicodeString (&msi2.SectionFileName, tp.w_get (), 65535);
-
-  /* Retry opening the real file name until that does not change any more. */
-  status = NtQueryVirtualMemory (NtCurrentProcess (), handle,
-				 MemorySectionName, pmsi1, 65536, NULL);
-  while (NT_SUCCESS (status) &&
-	!RtlEqualUnicodeString (&msi2.SectionFileName,
-				&pmsi1->SectionFileName, FALSE))
+  NTSTATUS fstatus;
+  HANDLE fhandle = dll_list::ntopenfile (ntname, &fstatus);
+  if (fhandle == INVALID_HANDLE_VALUE)
     {
-      debug_printf ("for %s at %p got memory section name '%W'",
-	ntname, handle, pmsi1->SectionFileName.Buffer);
-      RtlCopyUnicodeString (&msi2.SectionFileName, &pmsi1->SectionFileName);
-      if (fhandle != INVALID_HANDLE_VALUE)
-	NtClose (fhandle);
-      pmsi1->SectionFileName.Buffer[pmsi1->SectionFileName.Length] = L'\0';
-      fhandle = dll_list::ntopenfile (pmsi1->SectionFileName.Buffer, &fstatus);
-      status = NtQueryVirtualMemory (NtCurrentProcess (), handle,
-				     MemorySectionName, pmsi1, 65536, NULL);
+      system_printf ("WARNING: Unable (ntstatus %y) to open real file %W",
+		     fstatus, ntname);
+      return false;
     }
-  if (!NT_SUCCESS (status))
-    system_printf ("WARNING: Unable (ntstatus %y) to query real file for %W",
-		   status, ntname);
-  else if (fhandle == INVALID_HANDLE_VALUE)
-    system_printf ("WARNING: Unable (ntstatus %y) to open real file for %W",
-		   fstatus, ntname);
-  if (fhandle == INVALID_HANDLE_VALUE)
-    return false;
 
   if (!dll_list::read_fii (fhandle, &fii))
     system_printf ("WARNING: Unable to read real file attributes for %W",
-		   pmsi1->SectionFileName.Buffer);
+		   ntname);
 
   NtClose (fhandle);
   return fii.IndexNumber.QuadPart != -1LL;
-- 
2.19.2
