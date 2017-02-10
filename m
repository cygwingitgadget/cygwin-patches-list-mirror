Return-Path: <cygwin-patches-return-8693-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26528 invoked by alias); 10 Feb 2017 14:09:00 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 26475 invoked by uid 89); 10 Feb 2017 14:08:59 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=0.6 required=5.0 tests=AWL,BAYES_50,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2 spammy=nominated, cygwindevelopers, cygwin-developers, intact
X-HELO: smtp.salomon.at
Received: from smtp.salomon.at (HELO smtp.salomon.at) (193.186.16.13) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 10 Feb 2017 14:08:49 +0000
Received: from samail03.wamas.com ([172.28.33.235] helo=mailhost.salomon.at)	by smtp.salomon.at with esmtps (UNKNOWN:DHE-RSA-AES256-SHA:256)	(Exim 4.80.1)	(envelope-from <michael.haubenwallner@ssi-schaefer.com>)	id 1ccBsT-0001RN-34; Fri, 10 Feb 2017 15:08:45 +0100
Received: from [172.28.41.34]	by mailhost.salomon.at with esmtp (Exim 4.77)	(envelope-from <michael.haubenwallner@ssi-schaefer.com>)	id 1ccBsS-0002qy-Uw; Fri, 10 Feb 2017 15:08:45 +0100
To: cygwin-patches@cygwin.com
From: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
Subject: (fixup) [PATCH] forkables: use dynloaded dll's IndexNumber as dirname
Message-ID: <9f8649cf-0293-cce7-f4a1-84433d62152d@ssi-schaefer.com>
Date: Fri, 10 Feb 2017 14:09:00 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101 Thunderbird/45.6.0
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------01F25606868A128F76EE3104"
X-SW-Source: 2017-q1/txt/msg00034.txt.bz2

This is a multi-part message in MIME format.
--------------01F25606868A128F76EE3104
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-length: 552

Hi Corinna,

as realized during write of tl;dr draft for the topic/forkables branch,
> 
> <damn-wrong reason="original directory may not exist any more">
>  * The temporary subdirectory name for a dynamically loaded dll is formed
>    using the original directory's NTFS-IndexNumber.
> </damn-wrong>
> https://cygwin.com/ml/cygwin-developers/2017-01/msg00000.html

here's the patch, intended as fixup for
>
> [PATCH 3/6] forkables: Create forkable hardlinks, yet unused.
> https://cygwin.com/ml/cygwin-developers/2016-12/msg00006.html

Thanks!
/haubi/

--------------01F25606868A128F76EE3104
Content-Type: text/x-patch;
 name="0001-forkables-use-dynloaded-dll-s-IndexNumber-as-dirname.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-forkables-use-dynloaded-dll-s-IndexNumber-as-dirname.pa";
 filename*1="tch"
Content-length: 2059

From 66bc7176ad9a786651c306e27ce354438db5d4af Mon Sep 17 00:00:00 2001
From: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
Date: Thu, 12 Jan 2017 10:03:52 +0100
Subject: [PATCH] forkables: use dynloaded dll's IndexNumber as dirname

---
 winsup/cygwin/forkable.cc | 33 ++++++++-------------------------
 1 file changed, 8 insertions(+), 25 deletions(-)

diff --git a/winsup/cygwin/forkable.cc b/winsup/cygwin/forkable.cc
index c92a44f..6c78d75 100644
--- a/winsup/cygwin/forkable.cc
+++ b/winsup/cygwin/forkable.cc
@@ -409,34 +409,17 @@ dll::nominate_forkable (PCWCHAR dirx_name)
   if (!*forkable_ntname)
     return; /* denominate */
 
-  if (type < DLL_LOAD)
-    wcpcpy (next, modname);
-  else
+  if (type == DLL_LOAD)
     {
-      /* Avoid lots of extra directories for loaded dll's:
-       * mangle full path into one single directory name,
-       * just keep original filename intact. The original
-       * filename is necessary to serve as linked
-       * dependencies of dynamically loaded dlls. */
-      PWCHAR lastpathsep = wcsrchr (ntname, L'\\');
-      if (!lastpathsep)
-        {
-	  forkable_ntname = NULL;
-	  return;
-	}
-      *lastpathsep = L'\0';
-      HANDLE fh = dll_list::ntopenfile (ntname, NULL, FILE_DIRECTORY_FILE);
-      *lastpathsep = L'\\';
-
-      FILE_INTERNAL_INFORMATION fii = { 0 };
-      if (fh != INVALID_HANDLE_VALUE)
-	{
-	  dll_list::read_fii (fh, &fii);
-	  NtClose (fh);
-	}
+      /* Multiple dynamically loaded dlls can have identical basenames
+       * when loaded from different directories.  But still the original
+       * basename may serve as linked dependency for another dynamically
+       * loaded dll.  So we have to create a separate directory for the
+       * dynamically loaded dll - using the dll's IndexNumber as name. */
       next += format_IndexNumber (next, -1, &fii.IndexNumber);
-      wcpcpy (next, lastpathsep);
+      next = wcpcpy (next, L"\\");
     }
+  wcpcpy (next, modname);
 }
 
 /* Create the nominated hardlink for one indivitual dll,
-- 
2.8.3


--------------01F25606868A128F76EE3104--
