Return-Path: <cygwin-patches-return-8649-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18900 invoked by alias); 16 Nov 2016 12:34:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 18890 invoked by uid 89); 16 Nov 2016 12:34:21 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.8 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,SPF_PASS autolearn=ham version=3.3.2 spammy=sk:michael
X-HELO: smtp.salomon.at
Received: from smtp.salomon.at (HELO smtp.salomon.at) (193.186.16.13) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 16 Nov 2016 12:34:11 +0000
Received: from samail03.wamas.com ([172.28.33.235] helo=mailhost.salomon.at)	by smtp.salomon.at with esmtps (UNKNOWN:DHE-RSA-AES256-SHA:256)	(Exim 4.80.1)	(envelope-from <michael.haubenwallner@ssi-schaefer.com>)	id 1c6zPk-0005dj-As; Wed, 16 Nov 2016 13:34:09 +0100
Received: from s01en24.wamas.com ([172.28.41.34])	by mailhost.salomon.at with esmtp (Exim 4.77)	(envelope-from <michael.haubenwallner@ssi-schaefer.com>)	id 1c6zPk-0006uU-1T; Wed, 16 Nov 2016 13:34:08 +0100
Subject: Re: [PATCH 3/6] forkables: Create forkable hardlinks, yet unused.
To: cygwin-patches@cygwin.com
References: <1459364024-24891-1-git-send-email-michael.haubenwallner@ssi-schaefer.com> <1459364024-24891-4-git-send-email-michael.haubenwallner@ssi-schaefer.com>
From: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
Message-ID: <d71ad20f-df44-0b88-bb3a-83abb9d7c709@ssi-schaefer.com>
Date: Wed, 16 Nov 2016 12:34:00 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <1459364024-24891-4-git-send-email-michael.haubenwallner@ssi-schaefer.com>
Content-Type: multipart/mixed; boundary="------------BA5D60D1851001B5866AC462"
X-SW-Source: 2016-q4/txt/msg00007.txt.bz2

This is a multi-part message in MIME format.
--------------BA5D60D1851001B5866AC462
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-length: 3366

(sorry about previous empty mail)

Hi Corinna,

This is a fixup for the race condition where multiple processes failed
to concurrently create identical hardlinks.

So I'm quite successful with the forkable hardlinks now...

/haubi/


On 03/30/2016 08:53 PM, Michael Haubenwallner wrote:
> In preparation to protect fork() against dll- and exe-updates, create
> hardlinks to the main executable and each loaded dll in subdirectories
> of /var/run/cygfork/, if that one exists on the NTFS file system.
> 
> The directory names consist of the user sid, the main executable's NTFS
> IndexNumber, and the most recent LastWriteTime of all involved binaries
> (dlls and main executable).  Next to the main.exe hardlink we create the
> empty file main.exe.local to enable dll redirection.
> 
> The name of the mutex to synchronize hardlink creation/cleanup also is
> assembled from these directory names, to allow for synchronized cleanup
> of even orphaned hardlink directories.
> 
> The hardlink to each dynamically loaded dll goes into another directory,
> named using the NTFS IndexNumber of the dll's original directory.
> 
> 	* dll_init.h (struct dll): Declare member variables fbi, fii,
> 	forkable_ntname.  Declare methods nominate_forkable,
> 	create_forkable.  Define inline method forkedntname.
> 	(struct dll_list): Declare enum forkables_needs.  Declare member
> 	variables forkables_dirx_size, forkables_dirx_ntname,
> 	forkables_mutex_name, forkables_mutex.  Declare private methods
> 	forkable_ntnamesize, prepare_forkables_nomination,
> 	update_forkables_needs, update_forkables, create_forkables,
> 	denominate_forkables, close_mutex, try_remove_forkables.
> 	Declare public method cleanup_forkables.
> 	* dll_init.cc (dll_list::alloc): Allocate memory to hold the
> 	name of the hardlink in struct dll member forkable_ntname.
> 	Initialize struct dll members fbi, fii.
> 	* forkable.cc: Implement static functions mkdirs, rmdirs,
> 	rmdirs_synchronized, read_fii, read_fbi, format_IndexNumber,
> 	rootname, sidname, exename, lwtimename.  Define static array
> 	forkable_nameparts.
> 	(struct dll): Implement nominate_forkable, create_forkable.
> 	(struct dll_list): Implement forkable_ntnamesize,
> 	prepare_forkables_nomination, update_forkables_needs,
> 	update_forkables, create_forkables, close_mutex,
> 	cleanup_forkables, try_remove_forkables, denominate_forkables.
> 	(dll_list::set_forkables_inheritance): Also for forkables_mutex.
> 	(dll_list::request_forkables): Use new methods to create the
> 	hardlinks as necessary.
> 	(dll_list::release_forkables): When hardlink creation turned out
> 	to be impossible, close all the related handles and free the
> 	distinct memory.
> 	* pinfo.cc (pinfo::exit): Call dlls.cleanup_forkables.
> 	* syscalls.cc (_unlink_nt): Rename public unlink_nt function to
> 	static _unlink_nt, with 'shareable' as additional argument.
> 	(unlink_nt): New, wrap _unlink_nt for original behaviour.
> 	(unlink_nt_shareable): New, wrap _unlink_nt to keep a binary
> 	file still loadable while removing one of its hardlinks.
> ---
>  winsup/cygwin/dll_init.cc |   28 +-
>  winsup/cygwin/dll_init.h  |   33 ++
>  winsup/cygwin/forkable.cc | 1036 +++++++++++++++++++++++++++++++++++++++++++++
>  winsup/cygwin/pinfo.cc    |    3 +
>  winsup/cygwin/syscalls.cc |   24 +-
>  5 files changed, 1115 insertions(+), 9 deletions(-)


--------------BA5D60D1851001B5866AC462
Content-Type: text/x-patch;
 name="0001-forkables-fix-creating-dirs-and-.local-file-in-paral.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-forkables-fix-creating-dirs-and-.local-file-in-paral.pa";
 filename*1="tch"
Content-length: 2248

From 7a824877dbfe2aee0437378a52b8946000a38cbe Mon Sep 17 00:00:00 2001
From: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
Date: Fri, 11 Nov 2016 14:29:21 +0100
Subject: [PATCH] forkables: fix creating dirs and .local file in parallel

---
 winsup/cygwin/forkable.cc | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/winsup/cygwin/forkable.cc b/winsup/cygwin/forkable.cc
index 0a8a528..b712834 100644
--- a/winsup/cygwin/forkable.cc
+++ b/winsup/cygwin/forkable.cc
@@ -65,14 +65,14 @@ mkdirs (PWCHAR ntdirname, int lastsepcount)
 	  IO_STATUS_BLOCK iosb;
 	  status = NtCreateFile (&dh, GENERIC_READ | SYNCHRONIZE,
 				 &oa, &iosb, NULL, FILE_ATTRIBUTE_NORMAL,
-				 FILE_SHARE_READ,
-				 FILE_OPEN_IF, /* allow concurrency */
+				 FILE_SHARE_READ | FILE_SHARE_WRITE,
+				 FILE_CREATE,
 				 FILE_DIRECTORY_FILE
 				 | FILE_SYNCHRONOUS_IO_NONALERT,
 				 NULL, 0);
 	  if (NT_SUCCESS(status))
 	    NtClose (dh);
-	  else
+	  else if (status != STATUS_OBJECT_NAME_COLLISION) /* already exists */
 	    success = false;
 	  debug_printf ("%y = NtCreateFile (%p, dir %W)", status, dh, ntdirname);
 	}
@@ -806,14 +806,14 @@ dll_list::create_forkables ()
       IO_STATUS_BLOCK iosb;
       status = NtCreateFile (&hlocal, GENERIC_WRITE | SYNCHRONIZE,
 			     &oa, &iosb, NULL, FILE_ATTRIBUTE_NORMAL,
-			     FILE_SHARE_READ,
-			     FILE_OPEN_IF, /* allow concurrency */
+			     FILE_SHARE_READ | FILE_SHARE_WRITE,
+			     FILE_CREATE,
 			     FILE_NON_DIRECTORY_FILE
 			     | FILE_SYNCHRONOUS_IO_NONALERT,
 			     NULL, 0);
       if (NT_SUCCESS (status))
 	CloseHandle (hlocal);
-      else
+      else if (status != STATUS_OBJECT_NAME_COLLISION) /* already exists */
 	success = false;
       debug_printf ("%y = NtCreateFile (%p, %W)", status, hlocal, ntname);
     }
@@ -874,7 +874,10 @@ rmdirs_synchronized (WCHAR ntbuf[NT_MAX_PATH], int depth, int maxdepth,
       if (mutex)
 	{
 	  if (lasterror != ERROR_ALREADY_EXISTS)
-	    rmdirs (ntbuf);
+	    {
+	      debug_printf ("cleaning up for mutex %W", mutexname);
+	      rmdirs (ntbuf);
+	    }
 	  BOOL bret = CloseHandle (mutex);
 	  debug_printf ("%d = CloseHandle (%p, %W): %E",
 			bret, mutex, mutexname);
-- 
2.8.3


--------------BA5D60D1851001B5866AC462--
