Return-Path: <cygwin-patches-return-6886-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10157 invoked by alias); 9 Jan 2010 11:14:40 -0000
Received: (qmail 10121 invoked by uid 22791); 9 Jan 2010 11:14:37 -0000
X-SWARE-Spam-Status: No, hits=-2.2 required=5.0 	tests=AWL,BAYES_00,HK_OBFDOM,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from mail-ew0-f222.google.com (HELO mail-ew0-f222.google.com) (209.85.219.222)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sat, 09 Jan 2010 11:14:32 +0000
Received: by mail-ew0-f222.google.com with SMTP id 22so24059071ewy.19         for <cygwin-patches@cygwin.com>; Sat, 09 Jan 2010 03:14:31 -0800 (PST)
Received: by 10.213.102.133 with SMTP id g5mr5550387ebo.43.1263035670968;         Sat, 09 Jan 2010 03:14:30 -0800 (PST)
Received: from ?192.168.2.99? (cpc2-cmbg8-0-0-cust61.cmbg.cable.ntl.com [82.6.108.62])         by mx.google.com with ESMTPS id 5sm2547883eyf.10.2010.01.09.03.14.29         (version=SSLv3 cipher=RC4-MD5);         Sat, 09 Jan 2010 03:14:30 -0800 (PST)
Message-ID: <4B486906.4000600@gmail.com>
Date: Sat, 09 Jan 2010 11:14:00 -0000
From: Dave Korn <dave.korn.cygwin@googlemail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [PATCH] Fix misc aliasing warnings.
Content-Type: multipart/mixed;  boundary="------------090707020602070607090402"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2010-q1/txt/msg00002.txt.bz2

This is a multi-part message in MIME format.
--------------090707020602070607090402
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 1067


    Hi gang,

  Here's a bunch of fixes for more sensitive aliasing warnings present in
gcc-4.5.0.

winsup/cygwin/ChangeLog:

	* fhandler_disk_file.cc (fhandler_base::fstat_helper): Add new
	overload that accepts LARGE_INTEGER rather than FILETIME arguments.
	(fhandler_base::fstat_by_handle): Don't alias arguments in call
	to fstat_helper, allowing new overload to resolve invocation.
	(fhandler_base::fstat_by_name): Likewise.
	* fhandler.h (fhandler_base::fstat_helper): Prototype new overload.
	* fhandler_floppy.cc (fhandler_dev_floppy::get_drive_info): Avoid
	aliasing.
	* fhandler_proc.cc (format_proc_cpuinfo): Likewise.
	* passwd.cc (internal_getpwsid): Avoid sequence point warning.
	* syscalls.cc (gethostid): Avoid aliasing.
	* include/cygwin/in6.h (IN6_ARE_ADDR_EQUAL): Likewise.

  With this it all builds and the resulting DLL hasn't shown up any surprises,
although I haven't exercised the floppy code any.  (Don't even have one these
days.)  Still, it's probably safe enough to go on head which is unstable after
all.  OK?

    cheers,
      DaveK

--------------090707020602070607090402
Content-Type: text/x-c;
 name="misc-gcc450-aliasing-fixes.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="misc-gcc450-aliasing-fixes.diff"
Content-length: 9063

Index: winsup/cygwin/fhandler.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler.h,v
retrieving revision 1.385
diff -p -u -r1.385 fhandler.h
--- winsup/cygwin/fhandler.h	16 Dec 2009 14:56:10 -0000	1.385
+++ winsup/cygwin/fhandler.h	9 Jan 2010 08:49:23 -0000
@@ -291,6 +291,18 @@ class fhandler_base
 			      DWORD nNumberOfLinks,
 			      DWORD dwFileAttributes)
     __attribute__ ((regparm (3)));
+  int __stdcall fstat_helper (struct __stat64 *buf,
+			      LARGE_INTEGER ftChangeTime,
+			      LARGE_INTEGER ftLastAccessTime,
+			      LARGE_INTEGER ftLastWriteTime,
+			      LARGE_INTEGER ftCreationTime,
+			      DWORD dwVolumeSerialNumber,
+			      ULONGLONG nFileSize,
+			      LONGLONG nAllocSize,
+			      ULONGLONG nFileIndex,
+			      DWORD nNumberOfLinks,
+			      DWORD dwFileAttributes)
+    __attribute__ ((regparm (3)));
   int __stdcall fstat_by_nfs_ea (struct __stat64 *buf) __attribute__ ((regparm (2)));
   int __stdcall fstat_by_handle (struct __stat64 *buf) __attribute__ ((regparm (2)));
   int __stdcall fstat_by_name (struct __stat64 *buf) __attribute__ ((regparm (2)));
Index: winsup/cygwin/fhandler_disk_file.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_disk_file.cc,v
retrieving revision 1.318
diff -p -u -r1.318 fhandler_disk_file.cc
--- winsup/cygwin/fhandler_disk_file.cc	27 Nov 2009 14:27:22 -0000	1.318
+++ winsup/cygwin/fhandler_disk_file.cc	9 Jan 2010 08:49:23 -0000
@@ -373,11 +373,11 @@ fhandler_base::fstat_by_handle (struct _
   pc.file_attributes (fbi.FileAttributes);
   return fstat_helper (buf,
 		   fbi.ChangeTime.QuadPart
-		   ? *(FILETIME *) (void *) &fbi.ChangeTime
-		   : *(FILETIME *) (void *) &fbi.LastWriteTime,
-		   *(FILETIME *) (void *) &fbi.LastAccessTime,
-		   *(FILETIME *) (void *) &fbi.LastWriteTime,
-		   *(FILETIME *) (void *) &fbi.CreationTime,
+		   ? fbi.ChangeTime
+		   : fbi.LastWriteTime,
+		   fbi.LastAccessTime,
+		   fbi.LastWriteTime,
+		   fbi.CreationTime,
 		   get_dev (),
 		   fsi.EndOfFile.QuadPart,
 		   fsi.AllocationSize.QuadPart,
@@ -441,11 +441,11 @@ fhandler_base::fstat_by_name (struct __s
   pc.file_attributes (fdi_buf.fdi.FileAttributes);
   return fstat_helper (buf,
 		       fdi_buf.fdi.ChangeTime.QuadPart ?
-		       *(FILETIME *) (void *) &fdi_buf.fdi.ChangeTime :
-		       *(FILETIME *) (void *) &fdi_buf.fdi.LastWriteTime,
-		       *(FILETIME *) (void *) &fdi_buf.fdi.LastAccessTime,
-		       *(FILETIME *) (void *) &fdi_buf.fdi.LastWriteTime,
-		       *(FILETIME *) (void *) &fdi_buf.fdi.CreationTime,
+		       fdi_buf.fdi.ChangeTime :
+		       fdi_buf.fdi.LastWriteTime,
+		       fdi_buf.fdi.LastAccessTime,
+		       fdi_buf.fdi.LastWriteTime,
+		       fdi_buf.fdi.CreationTime,
 		       pc.fs_serial_number (),
 		       fdi_buf.fdi.EndOfFile.QuadPart,
 		       fdi_buf.fdi.AllocationSize.QuadPart,
@@ -458,10 +458,10 @@ too_bad:
   /* Arbitrary value: 2006-12-01 */
   RtlSecondsSince1970ToTime (1164931200L, &ft);
   return fstat_helper (buf,
-		       *(FILETIME *) (void *) &ft,
-		       *(FILETIME *) (void *) &ft,
-		       *(FILETIME *) (void *) &ft,
-		       *(FILETIME *) (void *) &ft,
+		       ft,
+		       ft,
+		       ft,
+		       ft,
 		       0,
 		       0ULL,
 		       -1LL,
@@ -692,6 +692,28 @@ fhandler_base::fstat_helper (struct __st
 }
 
 int __stdcall
+fhandler_base::fstat_helper (struct __stat64 *buf,
+			     LARGE_INTEGER ftChangeTime,
+			     LARGE_INTEGER ftLastAccessTime,
+			     LARGE_INTEGER ftLastWriteTime,
+			     LARGE_INTEGER ftCreationTime,
+			     DWORD dwVolumeSerialNumber,
+			     ULONGLONG nFileSize,
+			     LONGLONG nAllocSize,
+			     ULONGLONG nFileIndex,
+			     DWORD nNumberOfLinks,
+			     DWORD dwFileAttributes)
+{
+  return fstat_helper (buf,
+	((FILETIME) {ftChangeTime.u.LowPart, ftChangeTime.u.HighPart}),
+	((FILETIME) {ftLastAccessTime.u.LowPart, ftLastAccessTime.u.HighPart}),
+	((FILETIME) {ftLastWriteTime.u.LowPart, ftLastWriteTime.u.HighPart}),
+	((FILETIME) {ftCreationTime.u.LowPart, ftCreationTime.u.HighPart}),
+	dwVolumeSerialNumber, nFileSize, nAllocSize,
+	nFileIndex, nNumberOfLinks, dwFileAttributes);
+}
+
+int __stdcall
 fhandler_disk_file::fstat (struct __stat64 *buf)
 {
   return fstat_fs (buf);
Index: winsup/cygwin/fhandler_floppy.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_floppy.cc,v
retrieving revision 1.55
diff -p -u -r1.55 fhandler_floppy.cc
--- winsup/cygwin/fhandler_floppy.cc	24 Jul 2009 20:54:33 -0000	1.55
+++ winsup/cygwin/fhandler_floppy.cc	9 Jan 2010 08:49:23 -0000
@@ -56,7 +56,8 @@ fhandler_dev_floppy::get_drive_info (str
 	__seterrno ();
       else
 	{
-	  di = &((DISK_GEOMETRY_EX *) dbuf)->Geometry;
+	  DISK_GEOMETRY_EX *dgx = (DISK_GEOMETRY_EX *) dbuf;
+	  di = &dgx->Geometry;
 	  if (!DeviceIoControl (get_handle (),
 				IOCTL_DISK_GET_PARTITION_INFO_EX, NULL, 0,
 				pbuf, 256, &bytes_read, NULL))
Index: winsup/cygwin/fhandler_proc.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_proc.cc,v
retrieving revision 1.87
diff -p -u -r1.87 fhandler_proc.cc
--- winsup/cygwin/fhandler_proc.cc	9 Jun 2009 09:45:29 -0000	1.87
+++ winsup/cygwin/fhandler_proc.cc	9 Jan 2010 08:49:23 -0000
@@ -637,7 +637,9 @@ format_proc_cpuinfo (void *, char *&dest
 	  read_value ("Identifier", REG_SZ);
 	  bufptr += __small_sprintf (bufptr, "identifier      : %s\n", szBuffer);
 	  read_value ("~Mhz", REG_DWORD);
-	  bufptr += __small_sprintf (bufptr, "cpu MHz         : %u\n", *(DWORD *) szBuffer);
+	  union { char szbuff[sizeof (DWORD)]; DWORD dw; } u;
+	  memcpy (u.szbuff, szBuffer, sizeof (DWORD));
+	  bufptr += __small_sprintf (bufptr, "cpu MHz         : %u\n", u.dw);
 
 	  print ("flags           :");
 	  if (IsProcessorFeaturePresent (PF_3DNOW_INSTRUCTIONS_AVAILABLE))
@@ -675,7 +677,9 @@ format_proc_cpuinfo (void *, char *&dest
 	  bufptr += __small_sprintf (bufptr, "vendor_id\t: %s\n",
 				     (char *)vendor_id);
 	  read_value ("~Mhz", REG_DWORD);
-	  unsigned cpu_mhz = *(DWORD *)szBuffer;
+	  union { char szbuff[sizeof (DWORD)]; DWORD dw; } u;
+	  memcpy (u.szbuff, szBuffer, sizeof (DWORD));
+	  unsigned cpu_mhz = u.dw;
 	  if (maxf >= 1)
 	    {
 	      unsigned features2, features1, extra_info, cpuid_sig;
Index: winsup/cygwin/passwd.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/passwd.cc,v
retrieving revision 1.84
diff -p -u -r1.84 passwd.cc
--- winsup/cygwin/passwd.cc	26 Jan 2009 13:20:46 -0000	1.84
+++ winsup/cygwin/passwd.cc	9 Jan 2010 08:49:24 -0000
@@ -98,11 +98,14 @@ internal_getpwsid (cygpsid &sid)
     {
       endptr = strchr (sid_string + 2, 0) - 1;
       for (int i = 0; i < pr.curr_lines; i++)
-	if ((pw = passwd_buf + i)->pw_dir > pw->pw_gecos + 8)
-	  for (ptr1 = endptr, ptr2 = pw->pw_dir - 2;
-	       *ptr1 == *ptr2; ptr2--)
+	{
+	  pw = passwd_buf + i;
+	  if (pw->pw_dir > pw->pw_gecos + 8)
+	    for (ptr1 = endptr, ptr2 = pw->pw_dir - 2;
+	      *ptr1 == *ptr2; ptr2--)
 	    if (!*--ptr1)
 	      return pw;
+	}
     }
   return NULL;
 }
Index: winsup/cygwin/syscalls.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/syscalls.cc,v
retrieving revision 1.548
diff -p -u -r1.548 syscalls.cc
--- winsup/cygwin/syscalls.cc	17 Dec 2009 18:33:05 -0000	1.548
+++ winsup/cygwin/syscalls.cc	9 Jan 2010 08:49:24 -0000
@@ -3641,8 +3641,12 @@ long gethostid (void)
     status = UuidCreate (&Uuid);
   if (status == RPC_S_OK)
     {
-      data[4] = *(unsigned *)&Uuid.Data4[2];
-      data[5] = *(unsigned short *)&Uuid.Data4[6];
+      unsigned d4;
+      unsigned short d5;
+      memcpy (&d4, &Uuid.Data4[2], sizeof (unsigned));
+      memcpy (&d5, &Uuid.Data4[6], sizeof (unsigned short));
+      data[4] = d4;
+      data[5] = d5;
       // Unfortunately Windows will sometimes pick a virtual Ethernet card
       // e.g. VMWare Virtual Ethernet Adaptor
       debug_printf ("MAC address of first Ethernet card: %02x:%02x:%02x:%02x:%02x:%02x",
Index: winsup/cygwin/include/cygwin/in6.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/cygwin/in6.h,v
retrieving revision 1.6
diff -p -u -r1.6 in6.h
--- winsup/cygwin/include/cygwin/in6.h	18 Jan 2007 10:25:40 -0000	1.6
+++ winsup/cygwin/include/cygwin/in6.h	9 Jan 2010 08:49:24 -0000
@@ -16,10 +16,7 @@ details. */
 #define INET6_ADDRSTRLEN 46
 
 #define IN6_ARE_ADDR_EQUAL(a, b) \
-	(((const uint32_t *)(a))[0] == ((const uint32_t *)(b))[0] \
-	 && ((const uint32_t *)(a))[1] == ((const uint32_t *)(b))[1] \
-	 && ((const uint32_t *)(a))[2] == ((const uint32_t *)(b))[2] \
-	 && ((const uint32_t *)(a))[3] == ((const uint32_t *)(b))[3])
+	(!memcmp ((a), (b), 4 * sizeof (uint32_t)))
 
 #define IN6_IS_ADDR_UNSPECIFIED(addr) \
 	(((const uint32_t *)(addr))[0] == 0 \

--------------090707020602070607090402--
