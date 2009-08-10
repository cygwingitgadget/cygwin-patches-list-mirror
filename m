Return-Path: <cygwin-patches-return-6588-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23853 invoked by alias); 10 Aug 2009 02:58:44 -0000
Received: (qmail 23832 invoked by uid 22791); 10 Aug 2009 02:58:40 -0000
X-SWARE-Spam-Status: No, hits=-1.0 required=5.0 	tests=AWL,BAYES_00,HK_OBFDOM,J_CHICKENPOX_42,J_CHICKENPOX_62,J_CHICKENPOX_66,J_CHICKENPOX_82,SPF_PASS,WEIRD_PORT
X-Spam-Check-By: sourceware.org
Received: from mail-ew0-f217.google.com (HELO mail-ew0-f217.google.com) (209.85.219.217)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 10 Aug 2009 02:58:29 +0000
Received: by ewy17 with SMTP id 17so2816532ewy.2         for <cygwin-patches@cygwin.com>; Sun, 09 Aug 2009 19:58:25 -0700 (PDT)
Received: by 10.210.141.9 with SMTP id o9mr2485342ebd.10.1249873105487;         Sun, 09 Aug 2009 19:58:25 -0700 (PDT)
Received: from ?192.168.2.99? (cpc2-cmbg8-0-0-cust61.cmbg.cable.ntl.com [82.6.108.62])         by mx.google.com with ESMTPS id 7sm10034497eyb.20.2009.08.09.19.58.24         (version=SSLv3 cipher=RC4-MD5);         Sun, 09 Aug 2009 19:58:24 -0700 (PDT)
Message-ID: <4A7F8FF5.5060701@gmail.com>
Date: Mon, 10 Aug 2009 02:58:00 -0000
From: Dave Korn <dave.korn.cygwin@googlemail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [PATCHes] Misc aliasing fixes for building DLL with gcc-4.5.0
Content-Type: multipart/mixed;  boundary="------------010507090801000306000900"
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
X-SW-Source: 2009-q3/txt/msg00042.txt.bz2

This is a multi-part message in MIME format.
--------------010507090801000306000900
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 3074


    Hi everyone,

  I tried compiling winsup with GCC-4.5.0 HEAD, and it finds a bunch of things
to complain about (which then break the -Werror build).  They are mostly
"dereferencing type-punned pointer will break strict-aliasing rules" errors, but
there is also some possibly-undefined behaviour in passwd.cc (looks like a
problem with sequence points to me).

  There are also a couple of functions in fhandler_tty that don't have a return
statement despite not being of void type.  That's because they have infinite
while(1) loops in them, but gcc still complains.  This is probably a bug or
false positive in gcc's warnings, but it seems harmless enough to work around by
adding a "return 0" while waiting for it to be fixed; perhaps it might be
preferable just to disable -Werror for that file in the meantime?  Or we can
just leave them here in the archive for anyone else who runs into the problem to
stumble across and use as a local fix.

  There's one other patch that we might want to wait for a fix rather than work
around; currently there appears to be no way to declare an extern "C" function
as a friend of a class.  I solved that in fork.cc by making fork() an empty stub
that calls out to a C++-linkage function that is the actual friend.  I filed
PR41020 to find out if this is a real bug or a corner case of the C++ language
spec, we'll see what happens with that.

  Appended is one big patch that fixes the lot, and a listing of the individual
error messages from my build logs for anyone who's interested.

winsup/cygwin/ChangeLog:

	* fhandler_disk_file.cc (fhandler_base::fstat_helper): Add new
	overload that accepts LARGE_INTEGER times instead of FILETIMEs.
	(fhandler_base::fstat_by_handle): Remove type-punning casts and
	pass LARGE_INTEGERs to new overload instead.
	(fhandler_base::fstat_by_name): Likewise.	
	* fhandler.h (fhandler_base::fstat_helper): Prototype new overload.
	* fhandler_floppy.cc (fhandler_dev_floppy::get_drive_info): Avoid
	dereferencing type-punned cast.
	* fhandler_proc.cc (format_proc_cpuinfo): Avoid type-punning.
	* passwd.cc (internal_getpwsid): Avoid undefined behaviour.
	* syscalls.cc (gethostid): Use memcpys to avoid type-punning.
	* include/cygwin/in6.h (IN6_ARE_ADDR_EQUAL): Use memcmp to avoid
	dereferencing type-punned pointers.

	* fhandler_tty.cc (process_input): Add dummy return to silence warning.
	(process_ioctl): Likewise.

	* fork.cc (cygfork): New name with friendable C++ linkage for ...
	(fork): ... un-friendable extern "C" function becomes stub calling it.
	(class frok): Declare cygfork() friend, not fork(), avoiding PR41020.

  I've listed the controversial ones last separately from the others for
clarity.  These fixes got me through to a complete build of the DLL, but I
haven't tested them yet - I'm in the middle of a bunch of GCC tests, so it'll be
a couple of days before I can replace my in-use DLL and give it a whirl.  (That
gives us time to decide what to do about those last two ones.)

  Assuming nothing then shows up, OK to commit some or all?

    cheers,
      DaveK


--------------010507090801000306000900
Content-Type: text/x-c;
 name="gcc-4.5.0-misc-fixes.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="gcc-4.5.0-misc-fixes.diff"
Content-length: 10938

Index: winsup/cygwin/fhandler.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler.h,v
retrieving revision 1.377
diff -p -u -r1.377 fhandler.h
--- winsup/cygwin/fhandler.h	4 Aug 2009 04:31:08 -0000	1.377
+++ winsup/cygwin/fhandler.h	10 Aug 2009 02:31:53 -0000
@@ -289,6 +289,18 @@ class fhandler_base
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
retrieving revision 1.304
diff -p -u -r1.304 fhandler_disk_file.cc
--- winsup/cygwin/fhandler_disk_file.cc	4 Aug 2009 04:20:36 -0000	1.304
+++ winsup/cygwin/fhandler_disk_file.cc	10 Aug 2009 02:31:54 -0000
@@ -368,11 +368,11 @@ fhandler_base::fstat_by_handle (struct _
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
@@ -436,11 +436,11 @@ fhandler_base::fstat_by_name (struct __s
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
@@ -453,10 +453,10 @@ too_bad:
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
@@ -680,6 +680,28 @@ fhandler_base::fstat_helper (struct __st
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
+++ winsup/cygwin/fhandler_floppy.cc	10 Aug 2009 02:31:54 -0000
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
+++ winsup/cygwin/fhandler_proc.cc	10 Aug 2009 02:31:54 -0000
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
Index: winsup/cygwin/fhandler_tty.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_tty.cc,v
retrieving revision 1.190
diff -p -u -r1.190 fhandler_tty.cc
--- winsup/cygwin/fhandler_tty.cc	24 Jul 2009 20:54:33 -0000	1.190
+++ winsup/cygwin/fhandler_tty.cc	10 Aug 2009 02:31:54 -0000
@@ -225,6 +225,7 @@ process_input (void *)
 	  == line_edit_signalled)
 	tty_master->console->eat_readahead (-1);
     }
+  return 0;
 }
 
 bool
@@ -438,6 +439,7 @@ process_ioctl (void *)
 				  : (void *) &ttyp->arg);
       SetEvent (tty_master->ioctl_done_event);
     }
+  return 0;
 }
 
 /**********************************************************************/
Index: winsup/cygwin/fork.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fork.cc,v
retrieving revision 1.207
diff -p -u -r1.207 fork.cc
--- winsup/cygwin/fork.cc	24 Jul 2009 20:54:33 -0000	1.207
+++ winsup/cygwin/fork.cc	10 Aug 2009 02:31:54 -0000
@@ -32,6 +32,8 @@ details. */
 /* FIXME: Once things stabilize, bump up to a few minutes.  */
 #define FORK_WAIT_TIMEOUT (300 * 1000)     /* 300 seconds */
 
+static int cygfork(void);
+
 class frok
 {
   bool load_dlls;
@@ -41,7 +43,7 @@ class frok
   int this_errno;
   int __stdcall parent (volatile char * volatile here);
   int __stdcall child (volatile char * volatile here);
-  friend int fork ();
+  friend int cygfork (void);
 };
 
 class lock_signals
@@ -557,8 +559,8 @@ cleanup:
   return -1;
 }
 
-extern "C" int
-fork ()
+static int
+cygfork (void)
 {
   frok grouped;
 
@@ -629,6 +631,13 @@ fork ()
   syscall_printf ("%d = fork()", res);
   return res;
 }
+
+extern "C" int
+fork ()
+{
+  return cygfork ();
+}
+
 #ifdef DEBUGGING
 void
 fork_init ()
cvs diff: winsup/cygwin/how-cxx-abi.txt is a new entry, no comparison available
Index: winsup/cygwin/passwd.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/passwd.cc,v
retrieving revision 1.84
diff -p -u -r1.84 passwd.cc
--- winsup/cygwin/passwd.cc	26 Jan 2009 13:20:46 -0000	1.84
+++ winsup/cygwin/passwd.cc	10 Aug 2009 02:31:54 -0000
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
retrieving revision 1.527
diff -p -u -r1.527 syscalls.cc
--- winsup/cygwin/syscalls.cc	24 Jul 2009 20:54:33 -0000	1.527
+++ winsup/cygwin/syscalls.cc	10 Aug 2009 02:31:54 -0000
@@ -3479,8 +3479,12 @@ long gethostid (void)
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
+++ winsup/cygwin/include/cygwin/in6.h	10 Aug 2009 02:31:54 -0000
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

--------------010507090801000306000900
Content-Type: text/plain;
 name="all-errs.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="all-errs.txt"
Content-length: 6895

==> build.log <==
/gnu/winsup/src/winsup/cygwin/fhandler_disk_file.cc: In member function 'int fhandler_base::fstat_by_handle(__stat64*)':
/gnu/winsup/src/winsup/cygwin/fhandler_disk_file.cc:371:36: error: dereferencing type-punned pointer will break strict-aliasing rules
/gnu/winsup/src/winsup/cygwin/fhandler_disk_file.cc:372:36: error: dereferencing type-punned pointer will break strict-aliasing rules
/gnu/winsup/src/winsup/cygwin/fhandler_disk_file.cc:373:34: error: dereferencing type-punned pointer will break strict-aliasing rules
/gnu/winsup/src/winsup/cygwin/fhandler_disk_file.cc:374:34: error: dereferencing type-punned pointer will break strict-aliasing rules
/gnu/winsup/src/winsup/cygwin/fhandler_disk_file.cc:375:34: error: dereferencing type-punned pointer will break strict-aliasing rules
/gnu/winsup/src/winsup/cygwin/fhandler_disk_file.cc: In member function 'int fhandler_base::fstat_by_name(__stat64*)':
/gnu/winsup/src/winsup/cygwin/fhandler_disk_file.cc:439:46: error: dereferencing type-punned pointer will break strict-aliasing rules
/gnu/winsup/src/winsup/cygwin/fhandler_disk_file.cc:440:46: error: dereferencing type-punned pointer will break strict-aliasing rules
/gnu/winsup/src/winsup/cygwin/fhandler_disk_file.cc:441:46: error: dereferencing type-punned pointer will break strict-aliasing rules
/gnu/winsup/src/winsup/cygwin/fhandler_disk_file.cc:442:46: error: dereferencing type-punned pointer will break strict-aliasing rules
/gnu/winsup/src/winsup/cygwin/fhandler_disk_file.cc:443:46: error: dereferencing type-punned pointer will break strict-aliasing rules
/gnu/winsup/src/winsup/cygwin/fhandler_disk_file.cc:456:34: error: dereferencing type-punned pointer will break strict-aliasing rules
/gnu/winsup/src/winsup/cygwin/fhandler_disk_file.cc:457:34: error: dereferencing type-punned pointer will break strict-aliasing rules
/gnu/winsup/src/winsup/cygwin/fhandler_disk_file.cc:458:34: error: dereferencing type-punned pointer will break strict-aliasing rules
/gnu/winsup/src/winsup/cygwin/fhandler_disk_file.cc:459:34: error: dereferencing type-punned pointer will break strict-aliasing rules
make[3]: *** [fhandler_disk_file.o] Error 1

==> build10.log <==
/gnu/winsup/src/winsup/cygwin/syscalls.cc: In function 'long int gethostid()':
/gnu/winsup/src/winsup/cygwin/syscalls.cc:3482:43: error: dereferencing type-punned pointer will break strict-aliasing rules
/gnu/winsup/src/winsup/cygwin/syscalls.cc:3483:49: error: dereferencing type-punned pointer will break strict-aliasing rules
make[3]: *** [syscalls.o] Error 1

==> build2.log <==
/gnu/winsup/src/winsup/cygwin/fhandler_floppy.cc: In member function 'int fhandler_dev_floppy::get_drive_info(hd_geometry*)':
/gnu/winsup/src/winsup/cygwin/fhandler_floppy.cc:59:37: error: dereferencing type-punned pointer will break strict-aliasing rules
make[3]: *** [fhandler_floppy.o] Error 1

==> build3.log <==
/gnu/winsup/src/winsup/cygwin/fhandler_proc.cc: In function '_off64_t format_proc_cpuinfo(void*, char*&)':
/gnu/winsup/src/winsup/cygwin/fhandler_proc.cc:640:76: error: dereferencing type-punned pointer will break strict-aliasing rules
/gnu/winsup/src/winsup/cygwin/fhandler_proc.cc:678:33: error: dereferencing type-punned pointer will break strict-aliasing rules
make[3]: *** [fhandler_proc.o] Error 1

==> build4.log <==
/gnu/winsup/src/winsup/cygwin/fhandler_socket.cc: In function 'bool address_in_use(const sockaddr*)':
/gnu/winsup/src/winsup/cygwin/fhandler_socket.cc:819:7: error: dereferencing type-punned pointer will break strict-aliasing rules
/gnu/winsup/src/winsup/cygwin/fhandler_socket.cc:819:7: error: dereferencing type-punned pointer will break strict-aliasing rules
make[3]: *** [fhandler_socket.o] Error 1

==> build5.log <==
/gnu/winsup/src/winsup/cygwin/fhandler_tty.cc: In function 'DWORD process_input(void*)':
/gnu/winsup/src/winsup/cygwin/fhandler_tty.cc:228:1: error: no return statement in function returning non-void
/gnu/winsup/src/winsup/cygwin/fhandler_tty.cc: In function 'DWORD process_ioctl(void*)':
/gnu/winsup/src/winsup/cygwin/fhandler_tty.cc:441:1: error: no return statement in function returning non-void
make[3]: *** [fhandler_tty.o] Error 1

==> build6.log <==
/gnu/winsup/src/newlib/libc/include/sys/unistd.h:62:9: error: ambiguates old declaration 'pid_t fork()'
/gnu/winsup/src/winsup/cygwin/fork.cc: In function 'int fork()':
/gnu/winsup/src/winsup/cygwin/fork.cc:37:8: error: 'bool frok::load_dlls' is private
/gnu/winsup/src/winsup/cygwin/fork.cc:566:11: error: within this context
/gnu/winsup/src/winsup/cygwin/fork.cc:38:19: error: 'child_info_fork frok::ch' is private
/gnu/winsup/src/winsup/cygwin/fork.cc:573:15: error: within this context
/gnu/winsup/src/winsup/cygwin/fork.cc:38:19: error: 'child_info_fork frok::ch' is private
/gnu/winsup/src/winsup/cygwin/fork.cc:575:15: error: within this context
/gnu/winsup/src/winsup/cygwin/fork.cc:38:19: error: 'child_info_fork frok::ch' is private
/gnu/winsup/src/winsup/cygwin/fork.cc:597:33: error: within this context
/gnu/winsup/src/winsup/cygwin/fork.cc:279:1: error: 'int frok::parent(volatile char*)' is private
/gnu/winsup/src/winsup/cygwin/fork.cc:603:32: error: within this context
/gnu/winsup/src/winsup/cygwin/fork.cc:166:1: error: 'int frok::child(volatile char*)' is private
/gnu/winsup/src/winsup/cygwin/fork.cc:606:26: error: within this context
/gnu/winsup/src/winsup/cygwin/fork.cc:39:15: error: 'const char* frok::error' is private
/gnu/winsup/src/winsup/cygwin/fork.cc:616:20: error: within this context
/gnu/winsup/src/winsup/cygwin/fork.cc:40:7: error: 'int frok::child_pid' is private
/gnu/winsup/src/winsup/cygwin/fork.cc:617:1: error: within this context
/gnu/winsup/src/winsup/cygwin/fork.cc:41:7: error: 'int frok::this_errno' is private
/gnu/winsup/src/winsup/cygwin/fork.cc:617:1: error: within this context
/gnu/winsup/src/winsup/cygwin/fork.cc:39:15: error: 'const char* frok::error' is private
/gnu/winsup/src/winsup/cygwin/fork.cc:620:80: error: within this context
/gnu/winsup/src/winsup/cygwin/fork.cc:39:15: error: 'const char* frok::error' is private
/gnu/winsup/src/winsup/cygwin/fork.cc:622:25: error: within this context
/gnu/winsup/src/winsup/cygwin/fork.cc:40:7: error: 'int frok::child_pid' is private
/gnu/winsup/src/winsup/cygwin/fork.cc:624:1: error: within this context
/gnu/winsup/src/winsup/cygwin/fork.cc:41:7: error: 'int frok::this_errno' is private
/gnu/winsup/src/winsup/cygwin/fork.cc:624:1: error: within this context
/gnu/winsup/src/winsup/cygwin/fork.cc:41:7: error: 'int frok::this_errno' is private
/gnu/winsup/src/winsup/cygwin/fork.cc:627:7: error: within this context
make[3]: *** [fork.o] Error 1

==> build9.log <==
/gnu/winsup/src/winsup/cygwin/passwd.cc: In function 'passwd* internal_getpwsid(cygpsid&)':
/gnu/winsup/src/winsup/cygwin/passwd.cc:101:54: error: operation on 'pw' may be undefined
make[3]: *** [passwd.o] Error 1


--------------010507090801000306000900--
