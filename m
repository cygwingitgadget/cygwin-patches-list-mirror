Return-Path: <cygwin-patches-return-9398-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 103939 invoked by alias); 2 May 2019 08:05:35 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 103930 invoked by uid 89); 2 May 2019 08:05:35 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-20.0 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_PASS autolearn=ham version=3.3.1 spammy=HX-Languages-Length:1735
X-HELO: atfriesa01.ssi-schaefer.com
Received: from atfriesa01.ssi-schaefer.com (HELO atfriesa01.ssi-schaefer.com) (193.186.16.100) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 02 May 2019 08:05:33 +0000
Received: from samail03.wamas.com (HELO mailhost.salomon.at) ([172.28.33.235])  by atfriesa01.ssi-schaefer.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 May 2019 10:05:30 +0200
Received: from [172.28.53.61]	by mailhost.salomon.at with esmtps (UNKNOWN:AES128-SHA:128)	(Exim 4.77)	(envelope-from <michael.haubenwallner@ssi-schaefer.com>)	id 1hM6ig-0000FO-D1; Thu, 02 May 2019 10:05:30 +0200
From: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
Subject: [PATCH] Cygwin: dll_list: drop unused read_fbi method
To: cygwin-patches@cygwin.com
Cc: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
References: <20190430163813.GU3383@calimero.vinschen.de>
Message-ID: <94255e80-7793-00a3-d879-b2adf46bc9a6@ssi-schaefer.com>
Date: Thu, 02 May 2019 08:05:00 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190430163813.GU3383@calimero.vinschen.de>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
X-SW-Source: 2019-q2/txt/msg00105.txt.bz2

---
 winsup/cygwin/dll_init.h  |  1 -
 winsup/cygwin/forkable.cc | 23 -----------------------
 2 files changed, 24 deletions(-)

diff --git a/winsup/cygwin/dll_init.h b/winsup/cygwin/dll_init.h
index e4fbde867..3c274cf35 100644
--- a/winsup/cygwin/dll_init.h
+++ b/winsup/cygwin/dll_init.h
@@ -119,7 +119,6 @@ public:
 			    ULONG openopts = 0, ACCESS_MASK access = 0,
 			    HANDLE rootDir = NULL);
   static bool read_fii (HANDLE fh, PFILE_INTERNAL_INFORMATION pfii);
-  static bool read_fbi (HANDLE fh, PFILE_BASIC_INFORMATION pfbi);
   static PWCHAR form_ntname (PWCHAR ntbuf, size_t bufsize, PCWCHAR name);
   static PWCHAR form_shortname (PWCHAR shortbuf, size_t bufsize, PCWCHAR name);
   static PWCHAR nt_max_path_buf ()
diff --git a/winsup/cygwin/forkable.cc b/winsup/cygwin/forkable.cc
index e78784c2f..1dcafe5e1 100644
--- a/winsup/cygwin/forkable.cc
+++ b/winsup/cygwin/forkable.cc
@@ -268,29 +268,6 @@ dll_list::read_fii (HANDLE fh, PFILE_INTERNAL_INFORMATION pfii)
   return true;
 }
 
-bool
-dll_list::read_fbi (HANDLE fh, PFILE_BASIC_INFORMATION pfbi)
-{
-  pfbi->FileAttributes = INVALID_FILE_ATTRIBUTES;
-  pfbi->LastWriteTime.QuadPart = -1LL;
-
-  NTSTATUS status;
-  IO_STATUS_BLOCK iosb;
-  status = NtQueryInformationFile (fh, &iosb,
-				   pfbi, sizeof (*pfbi),
-				   FileBasicInformation);
-  if (!NT_SUCCESS (status))
-    {
-      system_printf ("WARNING: %y = NtQueryInformationFile (%p,"
-		     " BasicInfo, io.Status %y)",
-		     status, fh, iosb.Status);
-      pfbi->FileAttributes = INVALID_FILE_ATTRIBUTES;
-      pfbi->LastWriteTime.QuadPart = -1LL;
-      return false;
-    }
-  return true;
-}
-
 /* Into buf if not NULL, write the IndexNumber in pli.
    Return the number of characters (that would be) written. */
 static int
-- 
2.19.2
