Return-Path: <cygwin-patches-return-9328-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 44471 invoked by alias); 12 Apr 2019 13:33:10 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 44457 invoked by uid 89); 12 Apr 2019 13:33:10 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-18.8 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_PASS autolearn=ham version=3.3.1 spammy=forking, HX-Languages-Length:2175
X-HELO: atfriesa01.ssi-schaefer.com
Received: from atfriesa01.ssi-schaefer.com (HELO atfriesa01.ssi-schaefer.com) (193.186.16.100) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 12 Apr 2019 13:32:59 +0000
Received: from samail03.wamas.com (HELO mailhost.salomon.at) ([172.28.33.235])  by atfriesa01.ssi-schaefer.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Apr 2019 15:32:58 +0200
Received: from fril0049.wamas.com ([172.28.42.244])	by mailhost.salomon.at with esmtp (Exim 4.77)	(envelope-from <michael.haubenwallner@ssi-schaefer.com>)	id 1hEwIb-0004wP-5I; Fri, 12 Apr 2019 15:32:57 +0200
From: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
Subject: [PATCH] Cygwin: use win pid+threadid for forkables dirname
To: cygwin-patches@cygwin.com
Cc: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
Openpgp: preference=signencrypt
Message-ID: <869d6cb0-9c14-d1f6-fdf2-f87ff815029b@ssi-schaefer.com>
Date: Fri, 12 Apr 2019 13:33:00 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-SW-Source: 2019-q2/txt/msg00035.txt.bz2

Rather than newest last write time of all dlls loaded, use the forking
process' windows pid and windows thread id as directory name to create
the forkable hardlinks into.  While this may create hardlinks more
often, it does avoid conflicts between dlls not having the newest last
write time.
---
 winsup/cygwin/forkable.cc | 26 +++++++-------------------
 1 file changed, 7 insertions(+), 19 deletions(-)

diff --git a/winsup/cygwin/forkable.cc b/winsup/cygwin/forkable.cc
index d1b0f5723..4580610b1 100644
--- a/winsup/cygwin/forkable.cc
+++ b/winsup/cygwin/forkable.cc
@@ -340,30 +340,18 @@ exename (PWCHAR buf, ssize_t bufsize)
   return format_IndexNumber (buf, bufsize, &d->fii.IndexNumber);
 }
 
-/* Into buf if not NULL, write the newest dll's LastWriteTime.
+/* Into buf if not NULL, write the current Windows Thread Identifier.
    Return the number of characters (that would be) written. */
 static int
-lwtimename (PWCHAR buf, ssize_t bufsize)
+winthrname (PWCHAR buf, ssize_t bufsize)
 {
   if (!buf)
-    return sizeof (LARGE_INTEGER) * 2;
-  if (bufsize >= 0 && bufsize <= (int)sizeof (LARGE_INTEGER) * 2)
+    return sizeof (DWORD) * 4;
+  if (bufsize >= 0 && bufsize <= (int)sizeof (DWORD) * 4)
     return 0;
 
-  LARGE_INTEGER newest = { 0 };
-  /* Need by-handle-file-information for _all_ loaded dlls,
-     as most recent ctime forms the hardlinks directory. */
-  dll *d = &dlls.start;
-  while ((d = d->next))
-    {
-      /* LastWriteTime more properly tells the last file-content modification
-	 time, because a newly created hardlink may have a different
-	 CreationTime compared to the original file. */
-      if (d->fbi.LastWriteTime.QuadPart > newest.QuadPart)
-	newest = d->fbi.LastWriteTime;
-    }
-
-  return __small_swprintf (buf, L"%016X", newest);
+  return __small_swprintf (buf, L"%08X%08X",
+			   GetCurrentProcessId(), GetCurrentThreadId());
 }
 
 struct namepart {
@@ -382,7 +370,7 @@ forkable_nameparts[] = {
   { L"<sid>",         sidname,          true,  true,  },
   { L"<exe>",         exename,          false, false, },
   { MUTEXSEP,            NULL,          false, false, },
-  { L"<ctime>",    lwtimename,          true,  true,  },
+  { L"<winthr>",   winthrname,          true,  true,  },
 
   { NULL, NULL },
 };
-- 
2.19.2
