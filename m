Return-Path: <cygwin-patches-return-6889-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8907 invoked by alias); 9 Jan 2010 14:01:40 -0000
Received: (qmail 8333 invoked by uid 22791); 9 Jan 2010 14:01:38 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sat, 09 Jan 2010 14:01:34 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id DC0FD6D417D; Sat,  9 Jan 2010 15:01:22 +0100 (CET)
Date: Sat, 09 Jan 2010 14:01:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix misc aliasing warnings.
Message-ID: <20100109140122.GQ23992@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4B486906.4000600@gmail.com>  <20100109133348.GO23992@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100109133348.GO23992@calimero.vinschen.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2010-q1/txt/msg00005.txt.bz2

On Jan  9 14:33, Corinna Vinschen wrote:
> On Jan  9 11:31, Dave Korn wrote:
> > 	* fhandler_disk_file.cc (fhandler_base::fstat_helper): Add new
> > 	overload that accepts LARGE_INTEGER rather than FILETIME arguments.
> > 	(fhandler_base::fstat_by_handle): Don't alias arguments in call
> > 	to fstat_helper, allowing new overload to resolve invocation.
> > 	(fhandler_base::fstat_by_name): Likewise.
> > 	* fhandler.h (fhandler_base::fstat_helper): Prototype new overload.
> 
> Concerning fstat_helper, I don't like to slip another layer into these
> calls to pamper an anal-retentive compiler.  I would rather like to fix
> this by removing the FILETIME type from the affected places and use
> LARGE_INTEGER throughout.  It's not overly tricky, given that FILETIME
> time == LARGE_INTEGER kernel time.

Would you mind to test this one with gcc-4.5?  It replaces the FILETIME
arguments to fstat_helper with PLARGE_INTEGER pointers.  That also
avoids unnecessary value copying and so should be a teensy little bit
faster than before.


Thanks,
Corinna


	* fhandler.h (fhandler_base::fstat_helper): Declare timestamps
	as PLARGE_INTEGER.
	* fhandler_disk_file.cc (fhandler_base::fstat_by_handle):
	Accommodate fstat_helpee change of timestamp arguments.
	(fhandler_base::fstat_by_name): Ditto.
	(fhandler_base::fstat_helper): Define with timestamps as
	PLARGE_INTEGER.  Accommodate in call to to_timestruc_t.


Index: fhandler.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler.h,v
retrieving revision 1.388
diff -u -p -r1.388 fhandler.h
--- fhandler.h	28 Dec 2009 17:24:03 -0000	1.388
+++ fhandler.h	9 Jan 2010 13:57:58 -0000
@@ -280,10 +280,10 @@ class fhandler_base
   virtual int __stdcall fstat (struct __stat64 *buf) __attribute__ ((regparm (2)));
   int __stdcall fstat_fs (struct __stat64 *buf) __attribute__ ((regparm (2)));
   int __stdcall fstat_helper (struct __stat64 *buf,
-			      FILETIME ftChangeTime,
-			      FILETIME ftLastAccessTime,
-			      FILETIME ftLastWriteTime,
-			      FILETIME ftCreationTime,
+			      PLARGE_INTEGER ChangeTime,
+			      PLARGE_INTEGER LastAccessTime,
+			      PLARGE_INTEGER LastWriteTime,
+			      PLARGE_INTEGER CreationTime,
 			      DWORD dwVolumeSerialNumber,
 			      ULONGLONG nFileSize,
 			      LONGLONG nAllocSize,
Index: fhandler_disk_file.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_disk_file.cc,v
retrieving revision 1.318
diff -u -p -r1.318 fhandler_disk_file.cc
--- fhandler_disk_file.cc	27 Nov 2009 14:27:22 -0000	1.318
+++ fhandler_disk_file.cc	9 Jan 2010 13:57:58 -0000
@@ -372,12 +372,11 @@ fhandler_base::fstat_by_handle (struct _
     fbi.FileAttributes &= ~FILE_ATTRIBUTE_DIRECTORY;
   pc.file_attributes (fbi.FileAttributes);
   return fstat_helper (buf,
-		   fbi.ChangeTime.QuadPart
-		   ? *(FILETIME *) (void *) &fbi.ChangeTime
-		   : *(FILETIME *) (void *) &fbi.LastWriteTime,
-		   *(FILETIME *) (void *) &fbi.LastAccessTime,
-		   *(FILETIME *) (void *) &fbi.LastWriteTime,
-		   *(FILETIME *) (void *) &fbi.CreationTime,
+		   fbi.ChangeTime.QuadPart ? &fbi.ChangeTime
+					   : &fbi.LastWriteTime,
+		   &fbi.LastAccessTime,
+		   &fbi.LastWriteTime,
+		   &fbi.CreationTime,
 		   get_dev (),
 		   fsi.EndOfFile.QuadPart,
 		   fsi.AllocationSize.QuadPart,
@@ -440,12 +439,11 @@ fhandler_base::fstat_by_name (struct __s
     fdi_buf.fdi.FileAttributes &= ~FILE_ATTRIBUTE_DIRECTORY;
   pc.file_attributes (fdi_buf.fdi.FileAttributes);
   return fstat_helper (buf,
-		       fdi_buf.fdi.ChangeTime.QuadPart ?
-		       *(FILETIME *) (void *) &fdi_buf.fdi.ChangeTime :
-		       *(FILETIME *) (void *) &fdi_buf.fdi.LastWriteTime,
-		       *(FILETIME *) (void *) &fdi_buf.fdi.LastAccessTime,
-		       *(FILETIME *) (void *) &fdi_buf.fdi.LastWriteTime,
-		       *(FILETIME *) (void *) &fdi_buf.fdi.CreationTime,
+		       fdi_buf.fdi.ChangeTime.QuadPart
+		       ? &fdi_buf.fdi.ChangeTime : &fdi_buf.fdi.LastWriteTime,
+		       &fdi_buf.fdi.LastAccessTime,
+		       &fdi_buf.fdi.LastWriteTime,
+		       &fdi_buf.fdi.CreationTime,
 		       pc.fs_serial_number (),
 		       fdi_buf.fdi.EndOfFile.QuadPart,
 		       fdi_buf.fdi.AllocationSize.QuadPart,
@@ -458,10 +456,10 @@ too_bad:
   /* Arbitrary value: 2006-12-01 */
   RtlSecondsSince1970ToTime (1164931200L, &ft);
   return fstat_helper (buf,
-		       *(FILETIME *) (void *) &ft,
-		       *(FILETIME *) (void *) &ft,
-		       *(FILETIME *) (void *) &ft,
-		       *(FILETIME *) (void *) &ft,
+		       &ft,
+		       &ft,
+		       &ft,
+		       &ft,
 		       0,
 		       0ULL,
 		       -1LL,
@@ -506,7 +504,7 @@ fhandler_base::fstat_fs (struct __stat64
   return res;
 }
 
-/* The ftChangeTime is taken from the NTFS ChangeTime entry, if reading
+/* The ChangeTime is taken from the NTFS ChangeTime entry, if reading
    the file information using NtQueryInformationFile succeeded.  If not,
    it's faked using the LastWriteTime entry from GetFileInformationByHandle
    or FindFirstFile.  We're deliberatly not using the creation time anymore
@@ -518,10 +516,10 @@ fhandler_base::fstat_fs (struct __stat64
    the latter might be old and not reflect the actual state of the file. */
 int __stdcall
 fhandler_base::fstat_helper (struct __stat64 *buf,
-			     FILETIME ftChangeTime,
-			     FILETIME ftLastAccessTime,
-			     FILETIME ftLastWriteTime,
-			     FILETIME ftCreationTime,
+			     PLARGE_INTEGER ChangeTime,
+			     PLARGE_INTEGER LastAccessTime,
+			     PLARGE_INTEGER LastWriteTime,
+			     PLARGE_INTEGER CreationTime,
 			     DWORD dwVolumeSerialNumber,
 			     ULONGLONG nFileSize,
 			     LONGLONG nAllocSize,
@@ -532,10 +530,10 @@ fhandler_base::fstat_helper (struct __st
   IO_STATUS_BLOCK st;
   FILE_COMPRESSION_INFORMATION fci;
 
-  to_timestruc_t (&ftLastAccessTime, &buf->st_atim);
-  to_timestruc_t (&ftLastWriteTime, &buf->st_mtim);
-  to_timestruc_t (&ftChangeTime, &buf->st_ctim);
-  to_timestruc_t (&ftCreationTime, &buf->st_birthtim);
+  to_timestruc_t ((PFILETIME) LastAccessTime, &buf->st_atim);
+  to_timestruc_t ((PFILETIME) LastWriteTime, &buf->st_mtim);
+  to_timestruc_t ((PFILETIME) ChangeTime, &buf->st_ctim);
+  to_timestruc_t ((PFILETIME) CreationTime, &buf->st_birthtim);
   buf->st_dev = dwVolumeSerialNumber;
   buf->st_size = (_off64_t) nFileSize;
   /* The number of links to a directory includes the

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
