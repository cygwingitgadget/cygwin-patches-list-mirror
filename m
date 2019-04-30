Return-Path: <cygwin-patches-return-9393-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 42056 invoked by alias); 30 Apr 2019 14:14:59 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 42046 invoked by uid 89); 30 Apr 2019 14:14:59 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-19.6 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_PASS autolearn=ham version=3.3.1 spammy=
X-HELO: atfriesa01.ssi-schaefer.com
Received: from atfriesa01.ssi-schaefer.com (HELO atfriesa01.ssi-schaefer.com) (193.186.16.100) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 30 Apr 2019 14:14:58 +0000
Received: from samail03.wamas.com (HELO mailhost.salomon.at) ([172.28.33.235])  by atfriesa01.ssi-schaefer.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Apr 2019 16:14:55 +0200
Received: from [172.28.42.244]	by mailhost.salomon.at with esmtp (Exim 4.77)	(envelope-from <michael.haubenwallner@ssi-schaefer.com>)	id 1hLTX5-0004Iw-G6; Tue, 30 Apr 2019 16:14:55 +0200
From: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
Subject: [PATCH 2/3] Cygwin: dll_list: stat_real_file_once as dll method
To: cygwin-patches@cygwin.com
Cc: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
References: <20190430141215.21230-1-michael.haubenwallner@ssi-schaefer.com>
Openpgp: preference=signencrypt
Message-ID: <481d3c0a-c6e4-62ae-b329-da2d07593555@ssi-schaefer.com>
Date: Tue, 30 Apr 2019 14:14:00 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190430141215.21230-1-michael.haubenwallner@ssi-schaefer.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-SW-Source: 2019-q2/txt/msg00100.txt.bz2

Make stat_real_file_once a method of struct dll, to be more flexible on
where to use.  Also, debug print memory section name queried for a dll.
This is a preparation to query the file id when loading the dll.
---
 winsup/cygwin/dll_init.h  |  1 +
 winsup/cygwin/forkable.cc | 22 ++++++++++++----------
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/winsup/cygwin/dll_init.h b/winsup/cygwin/dll_init.h
index 0a9749638..e4fbde867 100644
--- a/winsup/cygwin/dll_init.h
+++ b/winsup/cygwin/dll_init.h
@@ -65,6 +65,7 @@ struct dll
 
   void detach ();
   int init ();
+  bool stat_real_file_once ();
   void nominate_forkable (PCWCHAR);
   bool create_forkable ();
   void run_dtors ()
diff --git a/winsup/cygwin/forkable.cc b/winsup/cygwin/forkable.cc
index 30833c406..912a9ac8c 100644
--- a/winsup/cygwin/forkable.cc
+++ b/winsup/cygwin/forkable.cc
@@ -155,10 +155,10 @@ rmdirs (WCHAR ntmaxpathbuf[NT_MAX_PATH])
    file name, as GetModuleFileNameW () yields the as-loaded name.
    While we have the file handle open, also read the attributes.
    NOTE: Uses dll_list::nt_max_path_buf (). */
-static bool
-stat_real_file_once (dll *d)
+bool
+dll::stat_real_file_once ()
 {
-  if (d->fii.IndexNumber.QuadPart != -1LL)
+  if (fii.IndexNumber.QuadPart != -1LL)
     return true;
 
   tmp_pathbuf tp;
@@ -171,35 +171,37 @@ stat_real_file_once (dll *d)
   RtlInitEmptyUnicodeString (&msi2.SectionFileName, tp.w_get (), 65535);
 
   /* Retry opening the real file name until that does not change any more. */
-  status = NtQueryVirtualMemory (NtCurrentProcess (), d->handle,
+  status = NtQueryVirtualMemory (NtCurrentProcess (), handle,
 				 MemorySectionName, pmsi1, 65536, NULL);
   while (NT_SUCCESS (status) &&
 	!RtlEqualUnicodeString (&msi2.SectionFileName,
 				&pmsi1->SectionFileName, FALSE))
     {
+      debug_printf ("for %s at %p got memory section name '%W'",
+	ntname, handle, pmsi1->SectionFileName.Buffer);
       RtlCopyUnicodeString (&msi2.SectionFileName, &pmsi1->SectionFileName);
       if (fhandle != INVALID_HANDLE_VALUE)
 	NtClose (fhandle);
       pmsi1->SectionFileName.Buffer[pmsi1->SectionFileName.Length] = L'\0';
       fhandle = dll_list::ntopenfile (pmsi1->SectionFileName.Buffer, &fstatus);
-      status = NtQueryVirtualMemory (NtCurrentProcess (), d->handle,
+      status = NtQueryVirtualMemory (NtCurrentProcess (), handle,
 				     MemorySectionName, pmsi1, 65536, NULL);
     }
   if (!NT_SUCCESS (status))
     system_printf ("WARNING: Unable (ntstatus %y) to query real file for %W",
-		   status, d->ntname);
+		   status, ntname);
   else if (fhandle == INVALID_HANDLE_VALUE)
     system_printf ("WARNING: Unable (ntstatus %y) to open real file for %W",
-		   fstatus, d->ntname);
+		   fstatus, ntname);
   if (fhandle == INVALID_HANDLE_VALUE)
     return false;
 
-  if (!dll_list::read_fii (fhandle, &d->fii))
+  if (!dll_list::read_fii (fhandle, &fii))
     system_printf ("WARNING: Unable to read real file attributes for %W",
 		   pmsi1->SectionFileName.Buffer);
 
   NtClose (fhandle);
-  return d->fii.IndexNumber.QuadPart != -1LL;
+  return fii.IndexNumber.QuadPart != -1LL;
 }
 
 /* easy use of NtOpenFile */
@@ -605,7 +607,7 @@ dll_list::prepare_forkables_nomination ()
 {
   dll *d = &dlls.start;
   while ((d = d->next))
-    stat_real_file_once (d); /* uses nt_max_path_buf () */
+    d->stat_real_file_once (); /* uses nt_max_path_buf () */
 
   PWCHAR pbuf = nt_max_path_buf ();
 
-- 
2.19.2
