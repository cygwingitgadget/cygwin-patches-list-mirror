Return-Path: <cygwin-patches-return-9392-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 41363 invoked by alias); 30 Apr 2019 14:14:14 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 41350 invoked by uid 89); 30 Apr 2019 14:14:14 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-19.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_PASS autolearn=ham version=3.3.1 spammy=fbi, newest, needless
X-HELO: atfriesa01.ssi-schaefer.com
Received: from atfriesa01.ssi-schaefer.com (HELO atfriesa01.ssi-schaefer.com) (193.186.16.100) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 30 Apr 2019 14:14:12 +0000
Received: from samail03.wamas.com (HELO mailhost.salomon.at) ([172.28.33.235])  by atfriesa01.ssi-schaefer.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Apr 2019 16:14:09 +0200
Received: from [172.28.42.244]	by mailhost.salomon.at with esmtp (Exim 4.77)	(envelope-from <michael.haubenwallner@ssi-schaefer.com>)	id 1hLTWL-0004Fc-6v; Tue, 30 Apr 2019 16:14:09 +0200
From: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
Subject: [PATCH 1/3] Cygwin: dll_list: drop FILE_BASIC_INFORMATION
To: cygwin-patches@cygwin.com
Cc: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
Openpgp: preference=signencrypt
Message-ID: <6166ec52-cb38-cd01-8f76-5b3500c0f3a9@ssi-schaefer.com>
Date: Tue, 30 Apr 2019 14:14:00 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-SW-Source: 2019-q2/txt/msg00099.txt.bz2

Querying FILE_BASIC_INFORMATION is needless since using win pid+threadid
for forkables dirname rather than newest last write time.
---
 winsup/cygwin/dll_init.cc | 1 -
 winsup/cygwin/dll_init.h  | 1 -
 winsup/cygwin/forkable.cc | 7 +++----
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/winsup/cygwin/dll_init.cc b/winsup/cygwin/dll_init.cc
index 4baa48dc1..28f4e53a8 100644
--- a/winsup/cygwin/dll_init.cc
+++ b/winsup/cygwin/dll_init.cc
@@ -372,7 +372,6 @@ dll_list::alloc (HINSTANCE h, per_process *p, dll_type type)
       d->image_size = ((pefile*)h)->optional_hdr ()->SizeOfImage;
       d->preferred_base = (void*) ((pefile*)h)->optional_hdr()->ImageBase;
       d->type = type;
-      d->fbi.FileAttributes = INVALID_FILE_ATTRIBUTES;
       d->fii.IndexNumber.QuadPart = -1LL;
       if (!forkntsize)
 	d->forkable_ntname = NULL;
diff --git a/winsup/cygwin/dll_init.h b/winsup/cygwin/dll_init.h
index c4a133f01..0a9749638 100644
--- a/winsup/cygwin/dll_init.h
+++ b/winsup/cygwin/dll_init.h
@@ -59,7 +59,6 @@ struct dll
   DWORD image_size;
   void* preferred_base;
   PWCHAR modname;
-  FILE_BASIC_INFORMATION fbi;
   FILE_INTERNAL_INFORMATION fii;
   PWCHAR forkable_ntname;
   WCHAR ntname[1]; /* must be the last data member */
diff --git a/winsup/cygwin/forkable.cc b/winsup/cygwin/forkable.cc
index 4580610b1..30833c406 100644
--- a/winsup/cygwin/forkable.cc
+++ b/winsup/cygwin/forkable.cc
@@ -158,7 +158,7 @@ rmdirs (WCHAR ntmaxpathbuf[NT_MAX_PATH])
 static bool
 stat_real_file_once (dll *d)
 {
-  if (d->fbi.FileAttributes != INVALID_FILE_ATTRIBUTES)
+  if (d->fii.IndexNumber.QuadPart != -1LL)
     return true;
 
   tmp_pathbuf tp;
@@ -194,13 +194,12 @@ stat_real_file_once (dll *d)
   if (fhandle == INVALID_HANDLE_VALUE)
     return false;
 
-  if (!dll_list::read_fii (fhandle, &d->fii) ||
-      !dll_list::read_fbi (fhandle, &d->fbi))
+  if (!dll_list::read_fii (fhandle, &d->fii))
     system_printf ("WARNING: Unable to read real file attributes for %W",
 		   pmsi1->SectionFileName.Buffer);
 
   NtClose (fhandle);
-  return d->fbi.FileAttributes != INVALID_FILE_ATTRIBUTES;
+  return d->fii.IndexNumber.QuadPart != -1LL;
 }
 
 /* easy use of NtOpenFile */
-- 
2.19.2
