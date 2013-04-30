Return-Path: <cygwin-patches-return-7865-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22967 invoked by alias); 30 Apr 2013 02:49:12 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 22954 invoked by uid 89); 30 Apr 2013 02:49:11 -0000
X-Spam-SWARE-Status: No, score=-3.0 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_HOSTKARMA_YE,SPF_PASS,TW_MK,TW_SW,TW_TV autolearn=ham version=3.3.1
Received: from mail-ie0-f180.google.com (HELO mail-ie0-f180.google.com) (209.85.223.180)    by sourceware.org (qpsmtpd/0.84/v0.84-167-ge50287c) with ESMTP; Tue, 30 Apr 2013 02:49:08 +0000
Received: by mail-ie0-f180.google.com with SMTP id to1so69469ieb.39        for <cygwin-patches@cygwin.com>; Mon, 29 Apr 2013 19:49:07 -0700 (PDT)
X-Received: by 10.50.114.3 with SMTP id jc3mr2757366igb.75.1367290147326;        Mon, 29 Apr 2013 19:49:07 -0700 (PDT)
Received: from [192.168.0.101] (S0106000cf16f58b1.wp.shawcable.net. [24.79.212.134])        by mx.google.com with ESMTPSA id w8sm6121493igl.9.2013.04.29.19.49.05        for <cygwin-patches@cygwin.com>        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);        Mon, 29 Apr 2013 19:49:06 -0700 (PDT)
Message-ID: <517F3122.8080609@users.sourceforge.net>
Date: Tue, 30 Apr 2013 02:49:00 -0000
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [PATCH] fix GCC 4.7 warnings
Content-Type: multipart/mixed; boundary="------------040607010900080706050207"
X-Virus-Found: No
X-SW-Source: 2013-q2/txt/msg00003.txt.bz2

This is a multi-part message in MIME format.
--------------040607010900080706050207
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 97

The attached patch fixes the remaining warnings in HEAD with GCC 4.7.3. 
  OK to apply?


Yaakov

--------------040607010900080706050207
Content-Type: text/x-patch;
 name="cygwin-gcc47.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="cygwin-gcc47.patch"
Content-length: 26635

2013-04-29  Yaakov Selkowitz  <yselkowitz@...>

	Throughout, (mainly in fhandler*) fix remaining gcc 4.7 mismatch
	warnings between regparm definitions and declarations.
	* smallprint.cc (__small_vswprintf): Fix unused-but-set-variable
	warning.
	* spawn.cc (child_info_spawn::worker): Ditto.
	* thread.cc (verifyable_object_isvalid): Temporarily define as
	non-inline with gcc 4.7+, regardless of target.

Index: fhandler.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler.cc,v
retrieving revision 1.432
diff -u -p -r1.432 fhandler.cc
--- fhandler.cc	23 Apr 2013 09:44:32 -0000	1.432
+++ fhandler.cc	30 Apr 2013 02:35:18 -0000
@@ -216,7 +216,7 @@ fhandler_base::set_flags (int flags, int
 
 /* Cover function to ReadFile to achieve (as much as possible) Posix style
    semantics and use of errno.  */
-void __stdcall
+void __reg3
 fhandler_base::raw_read (void *ptr, size_t& len)
 {
   NTSTATUS status;
@@ -282,7 +282,7 @@ retry:
 
 /* Cover function to WriteFile to provide Posix interface and semantics
    (as much as possible).  */
-ssize_t __stdcall
+ssize_t __reg3
 fhandler_base::raw_write (const void *ptr, size_t len)
 {
   NTSTATUS status;
@@ -722,7 +722,7 @@ done:
    an \n.  If last char is an \r, look ahead one more char, if \n then
    modify \r, if not, remember char.
 */
-void __stdcall
+void __reg3
 fhandler_base::read (void *in_ptr, size_t& len)
 {
   char *ptr = (char *) in_ptr;
@@ -1055,14 +1055,14 @@ fhandler_base::lseek (off_t offset, int 
   return res;
 }
 
-ssize_t __stdcall
+ssize_t __reg3
 fhandler_base::pread (void *, size_t, off_t)
 {
   set_errno (ESPIPE);
   return -1;
 }
 
-ssize_t __stdcall
+ssize_t __reg3
 fhandler_base::pwrite (void *, size_t, off_t)
 {
   set_errno (ESPIPE);
@@ -1278,7 +1278,7 @@ fhandler_base::fstat (struct stat *buf)
   return 0;
 }
 
-int __stdcall
+int __reg2
 fhandler_base::fstatvfs (struct statvfs *sfs)
 {
   /* If we hit this base implementation, it's some device in /dev.
Index: fhandler_console.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_console.cc,v
retrieving revision 1.279
diff -u -p -r1.279 fhandler_console.cc
--- fhandler_console.cc	23 Apr 2013 09:44:32 -0000	1.279
+++ fhandler_console.cc	30 Apr 2013 02:35:18 -0000
@@ -318,7 +318,7 @@ fhandler_console::mouse_aware (MOUSE_EVE
 		 || dev_state.use_mouse >= 3));
 }
 
-void __stdcall
+void __reg3
 fhandler_console::read (void *pv, size_t& buflen)
 {
   push_process_state process_state (PID_TTYIN);
Index: fhandler_dev.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_dev.cc,v
retrieving revision 1.10
diff -u -p -r1.10 fhandler_dev.cc
--- fhandler_dev.cc	23 Apr 2013 09:44:32 -0000	1.10
+++ fhandler_dev.cc	30 Apr 2013 02:35:18 -0000
@@ -81,7 +81,7 @@ fhandler_dev::fstat (struct stat *st)
   return 0;
 }
 
-int __stdcall
+int __reg2
 fhandler_dev::fstatvfs (struct statvfs *sfs)
 {
   int ret = -1, opened = 0;
Index: fhandler_disk_file.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_disk_file.cc,v
retrieving revision 1.383
diff -u -p -r1.383 fhandler_disk_file.cc
--- fhandler_disk_file.cc	23 Apr 2013 09:44:32 -0000	1.383
+++ fhandler_disk_file.cc	30 Apr 2013 02:35:18 -0000
@@ -319,7 +319,7 @@ path_conv::ndisk_links (DWORD nNumberOfL
    This returns the content of a struct fattr3 as defined in RFC 1813.
    The content is the NFS equivalent of struct stat. so there's not much
    to do here except for copying. */
-int __stdcall
+int __reg2
 fhandler_base::fstat_by_nfs_ea (struct stat *buf)
 {
   fattr3 *nfs_attr = pc.nfsattr ();
@@ -362,7 +362,7 @@ fhandler_base::fstat_by_nfs_ea (struct s
   return 0;
 }
 
-int __stdcall
+int __reg2
 fhandler_base::fstat_by_handle (struct stat *buf)
 {
   /* Don't use FileAllInformation info class.  It returns a pathname rather
@@ -420,7 +420,7 @@ fhandler_base::fstat_by_handle (struct s
   return fstat_helper (buf, fsi.NumberOfLinks);
 }
 
-int __stdcall
+int __reg2
 fhandler_base::fstat_by_name (struct stat *buf)
 {
   NTSTATUS status;
@@ -464,7 +464,7 @@ fhandler_base::fstat_by_name (struct sta
   return fstat_helper (buf, 1);
 }
 
-int __stdcall
+int __reg2
 fhandler_base::fstat_fs (struct stat *buf)
 {
   int res = -1;
@@ -508,7 +508,7 @@ fhandler_base::fstat_fs (struct stat *bu
   return res;
 }
 
-int __stdcall
+int __reg3
 fhandler_base::fstat_helper (struct stat *buf,
 			     DWORD nNumberOfLinks)
 {
@@ -708,7 +708,7 @@ fhandler_disk_file::fstat (struct stat *
   return fstat_fs (buf);
 }
 
-int __stdcall
+int __reg2
 fhandler_disk_file::fstatvfs (struct statvfs *sfs)
 {
   int ret = -1, opened = 0;
@@ -783,7 +783,7 @@ out:
   return ret;
 }
 
-int __stdcall
+int __reg1
 fhandler_disk_file::fchmod (mode_t mode)
 {
   extern int chmod_device (path_conv& pc, mode_t mode);
@@ -891,7 +891,7 @@ out:
   return res;
 }
 
-int __stdcall
+int __reg2
 fhandler_disk_file::fchown (uid_t uid, gid_t gid)
 {
   int oret = 0;
@@ -959,7 +959,7 @@ fhandler_disk_file::fchown (uid_t uid, g
   return res;
 }
 
-int _stdcall
+int __reg3
 fhandler_disk_file::facl (int cmd, int nentries, aclent_t *aclbufp)
 {
   int res = -1;
@@ -1535,7 +1535,7 @@ fhandler_disk_file::prw_open (bool write
   return 0;
 }
 
-ssize_t __stdcall
+ssize_t __reg3
 fhandler_disk_file::pread (void *buf, size_t count, off_t offset)
 {
   ssize_t res;
@@ -1609,7 +1609,7 @@ non_atomic:
   return res;
 }
 
-ssize_t __stdcall
+ssize_t __reg3
 fhandler_disk_file::pwrite (void *buf, size_t count, off_t offset)
 {
   if ((get_flags () & O_ACCMODE) == O_RDONLY)
@@ -1924,7 +1924,7 @@ free_dir:
   return res;
 }
 
-ino_t __stdcall
+ino_t __reg2
 readdir_get_ino (const char *path, bool dot_dot)
 {
   char *fname;
@@ -2393,7 +2393,7 @@ fhandler_cygdrive::fstat (struct stat *b
   return 0;
 }
 
-int __stdcall
+int __reg2
 fhandler_cygdrive::fstatvfs (struct statvfs *sfs)
 {
   /* Virtual file system.  Just return an empty buffer with a few values
Index: fhandler_dsp.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_dsp.cc,v
retrieving revision 1.63
diff -u -p -r1.63 fhandler_dsp.cc
--- fhandler_dsp.cc	23 Apr 2013 09:44:32 -0000	1.63
+++ fhandler_dsp.cc	30 Apr 2013 02:35:18 -0000
@@ -1095,7 +1095,7 @@ fhandler_dev_dsp::write (const void *ptr
   return len - len_s + written;
 }
 
-void __stdcall
+void __reg3
 fhandler_dev_dsp::read (void *ptr, size_t& len)
 {
   debug_printf ("ptr=%p len=%ld", ptr, len);
Index: fhandler_fifo.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_fifo.cc,v
retrieving revision 1.58
diff -u -p -r1.58 fhandler_fifo.cc
--- fhandler_fifo.cc	23 Apr 2013 09:44:32 -0000	1.58
+++ fhandler_fifo.cc	30 Apr 2013 02:35:18 -0000
@@ -274,7 +274,7 @@ fhandler_fifo::wait (HANDLE h)
    }
 }
 
-void __stdcall
+void __reg3
 fhandler_fifo::raw_read (void *in_ptr, size_t& len)
 {
   size_t orig_len = len;
Index: fhandler_floppy.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_floppy.cc,v
retrieving revision 1.68
diff -u -p -r1.68 fhandler_floppy.cc
--- fhandler_floppy.cc	23 Apr 2013 09:44:32 -0000	1.68
+++ fhandler_floppy.cc	30 Apr 2013 02:35:18 -0000
@@ -381,7 +381,7 @@ fhandler_dev_floppy::get_current_positio
   return off.QuadPart;
 }
 
-void __stdcall
+void __reg3
 fhandler_dev_floppy::raw_read (void *ptr, size_t& ulen)
 {
   DWORD bytes_read = 0;
@@ -513,7 +513,7 @@ err:
   ulen = (size_t) -1;
 }
 
-ssize_t __stdcall
+ssize_t __reg3
 fhandler_dev_floppy::raw_write (const void *ptr, size_t len)
 {
   DWORD bytes_written = 0;
Index: fhandler_mailslot.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_mailslot.cc,v
retrieving revision 1.18
diff -u -p -r1.18 fhandler_mailslot.cc
--- fhandler_mailslot.cc	23 Apr 2013 09:44:32 -0000	1.18
+++ fhandler_mailslot.cc	30 Apr 2013 02:35:18 -0000
@@ -146,7 +146,7 @@ fhandler_mailslot::open (int flags, mode
   return res;
 }
 
-ssize_t __stdcall
+ssize_t __reg3
 fhandler_mailslot::raw_write (const void *ptr, size_t len)
 {
   /* Check for 425/426 byte weirdness */
Index: fhandler_mem.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_mem.cc,v
retrieving revision 1.62
diff -u -p -r1.62 fhandler_mem.cc
--- fhandler_mem.cc	23 Apr 2013 09:44:32 -0000	1.62
+++ fhandler_mem.cc	30 Apr 2013 02:35:18 -0000
@@ -160,7 +160,7 @@ fhandler_dev_mem::write (const void *ptr
   return ulen;
 }
 
-void __stdcall
+void __reg3
 fhandler_dev_mem::read (void *ptr, size_t& ulen)
 {
   if (!ulen || pos >= (off_t) mem_size)
Index: fhandler_procsys.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_procsys.cc,v
retrieving revision 1.13
diff -u -p -r1.13 fhandler_procsys.cc
--- fhandler_procsys.cc	23 Apr 2013 09:44:32 -0000	1.13
+++ fhandler_procsys.cc	30 Apr 2013 02:35:19 -0000
@@ -391,7 +391,7 @@ fhandler_procsys::closedir (DIR *dir)
   return fhandler_virtual::closedir (dir);
 }
 
-void __stdcall
+void __reg3
 fhandler_procsys::read (void *ptr, size_t& len)
 {
   NTSTATUS status;
Index: fhandler_random.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_random.cc,v
retrieving revision 1.44
diff -u -p -r1.44 fhandler_random.cc
--- fhandler_random.cc	23 Apr 2013 09:44:32 -0000	1.44
+++ fhandler_random.cc	30 Apr 2013 02:35:19 -0000
@@ -114,7 +114,7 @@ fhandler_dev_random::pseudo_read (void *
   return len;
 }
 
-void __stdcall
+void __reg3
 fhandler_dev_random::read (void *ptr, size_t& len)
 {
   if (!len)
Index: fhandler_serial.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_serial.cc,v
retrieving revision 1.92
diff -u -p -r1.92 fhandler_serial.cc
--- fhandler_serial.cc	23 Apr 2013 09:44:32 -0000	1.92
+++ fhandler_serial.cc	30 Apr 2013 02:35:19 -0000
@@ -41,7 +41,7 @@ fhandler_serial::overlapped_setup ()
   overlapped_armed = 0;
 }
 
-void __stdcall
+void __reg3
 fhandler_serial::raw_read (void *ptr, size_t& ulen)
 {
   int tot;
@@ -167,7 +167,7 @@ out:
 
 /* Cover function to WriteFile to provide Posix interface and semantics
    (as much as possible).  */
-ssize_t __stdcall
+ssize_t __reg3
 fhandler_serial::raw_write (const void *ptr, size_t len)
 {
   DWORD bytes_written;
Index: fhandler_socket.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_socket.cc,v
retrieving revision 1.300
diff -u -p -r1.300 fhandler_socket.cc
--- fhandler_socket.cc	23 Apr 2013 09:44:32 -0000	1.300
+++ fhandler_socket.cc	30 Apr 2013 02:35:19 -0000
@@ -846,7 +846,7 @@ fhandler_socket::fstat (struct stat *buf
   return res;
 }
 
-int __stdcall
+int __reg2
 fhandler_socket::fstatvfs (struct statvfs *sfs)
 {
   if (get_device () == FH_UNIX)
@@ -1527,7 +1527,7 @@ fhandler_socket::recv_internal (LPWSAMSG
   return ret;
 }
 
-void __stdcall
+void __reg3
 fhandler_socket::read (void *in_ptr, size_t& len)
 {
   char *ptr = (char *) in_ptr;
Index: fhandler_tape.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_tape.cc,v
retrieving revision 1.88
diff -u -p -r1.88 fhandler_tape.cc
--- fhandler_tape.cc	23 Apr 2013 09:44:32 -0000	1.88
+++ fhandler_tape.cc	30 Apr 2013 02:35:19 -0000
@@ -1237,7 +1237,7 @@ fhandler_dev_tape::close ()
   return ret ? -1 : cret;
 }
 
-void __stdcall
+void __reg3
 fhandler_dev_tape::raw_read (void *ptr, size_t &ulen)
 {
   char *buf = (char *) ptr;
@@ -1339,7 +1339,7 @@ fhandler_dev_tape::raw_read (void *ptr, 
   unlock ();
 }
 
-ssize_t __stdcall
+ssize_t __reg3
 fhandler_dev_tape::raw_write (const void *ptr, size_t len)
 {
   if (!_lock (true))
Index: fhandler_tty.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_tty.cc,v
retrieving revision 1.278
diff -u -p -r1.278 fhandler_tty.cc
--- fhandler_tty.cc	23 Apr 2013 09:44:32 -0000	1.278
+++ fhandler_tty.cc	30 Apr 2013 02:35:19 -0000
@@ -684,7 +684,7 @@ fhandler_pty_slave::write (const void *p
   return towrite;
 }
 
-void __stdcall
+void __reg3
 fhandler_pty_slave::read (void *ptr, size_t& len)
 {
   ssize_t totalread = 0;
@@ -1150,7 +1150,7 @@ fhandler_pty_slave::fch_close_handles ()
   close_maybe (inuse);
 }
 
-int __stdcall
+int __reg1
 fhandler_pty_slave::fchmod (mode_t mode)
 {
   int ret = -1;
@@ -1176,7 +1176,7 @@ errout:
   return ret;
 }
 
-int __stdcall
+int __reg2
 fhandler_pty_slave::fchown (uid_t uid, gid_t gid)
 {
   int ret = -1;
@@ -1355,7 +1355,7 @@ fhandler_pty_master::write (const void *
   return i;
 }
 
-void __stdcall
+void __reg3
 fhandler_pty_master::read (void *ptr, size_t& len)
 {
   bg_check_types bg = bg_check (SIGTTIN);
Index: fhandler_virtual.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_virtual.cc,v
retrieving revision 1.60
diff -u -p -r1.60 fhandler_virtual.cc
--- fhandler_virtual.cc	23 Apr 2013 09:44:32 -0000	1.60
+++ fhandler_virtual.cc	30 Apr 2013 02:35:19 -0000
@@ -181,7 +181,7 @@ fhandler_virtual::close ()
   return 0;
 }
 
-void __stdcall
+void __reg3
 fhandler_virtual::read (void *ptr, size_t& len)
 {
   if (len == 0)
@@ -266,7 +266,7 @@ fhandler_virtual::facl (int cmd, int nen
   return res;
 }
 
-int __stdcall
+int __reg2
 fhandler_virtual::fstatvfs (struct statvfs *sfs)
 {
   /* Virtual file system.  Just return an empty buffer with a few values
Index: fhandler_windows.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_windows.cc,v
retrieving revision 1.38
diff -u -p -r1.38 fhandler_windows.cc
--- fhandler_windows.cc	21 Jan 2013 04:38:27 -0000	1.38
+++ fhandler_windows.cc	30 Apr 2013 02:35:19 -0000
@@ -84,7 +84,7 @@ fhandler_windows::write (const void *buf
   return sizeof (MSG);
 }
 
-void __stdcall
+void __reg3
 fhandler_windows::read (void *buf, size_t& len)
 {
   MSG *ptr = (MSG *) buf;
Index: fhandler_zero.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_zero.cc,v
retrieving revision 1.33
diff -u -p -r1.33 fhandler_zero.cc
--- fhandler_zero.cc	23 Apr 2013 09:44:32 -0000	1.33
+++ fhandler_zero.cc	30 Apr 2013 02:35:19 -0000
@@ -41,7 +41,7 @@ fhandler_dev_zero::write (const void *, 
   return len;
 }
 
-void __stdcall
+void __reg3
 fhandler_dev_zero::read (void *ptr, size_t& len)
 {
   memset (ptr, 0, len);
Index: miscfuncs.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/miscfuncs.cc,v
retrieving revision 1.92
diff -u -p -r1.92 miscfuncs.cc
--- miscfuncs.cc	23 Apr 2013 09:44:33 -0000	1.92
+++ miscfuncs.cc	30 Apr 2013 02:35:19 -0000
@@ -177,7 +177,7 @@ cygwin_strupr (char *string)
   return string;
 }
 
-int __stdcall
+int __reg2
 check_invalid_virtual_addr (const void *s, unsigned sz)
 {
   MEMORY_BASIC_INFORMATION mbuf;
Index: ntea.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/ntea.cc,v
retrieving revision 1.27
diff -u -p -r1.27 ntea.cc
--- ntea.cc	21 Jan 2013 04:38:27 -0000	1.27
+++ ntea.cc	30 Apr 2013 02:35:19 -0000
@@ -30,7 +30,7 @@ details. */
 #define NEXT_FEA(p) ((PFILE_FULL_EA_INFORMATION) (p->NextEntryOffset \
 		     ? (char *) p + p->NextEntryOffset : NULL))
 
-ssize_t __stdcall
+ssize_t __reg3
 read_ea (HANDLE hdl, path_conv &pc, const char *name, char *value, size_t size)
 {
   OBJECT_ATTRIBUTES attr;
@@ -216,7 +216,7 @@ out:
   return ret;
 }
 
-int __stdcall
+int __reg3
 write_ea (HANDLE hdl, path_conv &pc, const char *name, const char *value,
 	  size_t size, int flags)
 {
Index: path.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/path.cc,v
retrieving revision 1.675
diff -u -p -r1.675 path.cc
--- path.cc	24 Apr 2013 10:16:12 -0000	1.675
+++ path.cc	30 Apr 2013 02:35:20 -0000
@@ -343,7 +343,7 @@ path_conv::add_ext_from_sym (symlink_inf
 
 static void __reg2 mkrelpath (char *dst, bool caseinsensitive);
 
-static void __stdcall
+static void __reg2
 mkrelpath (char *path, bool caseinsensitive)
 {
   tmp_pathbuf tp;
@@ -1362,7 +1362,7 @@ normalize_win32_path (const char *src, c
 /* nofinalslash: Remove trailing / and \ from SRC (except for the
    first one).  It is ok for src == dst.  */
 
-void __stdcall
+void __reg2
 nofinalslash (const char *src, char *dst)
 {
   int len = strlen (src);
@@ -2951,7 +2951,7 @@ readlink (const char *path, char *buf, s
    done during the opendir call and the hash or the filename within
    the directory.  FIXME: Not bullet-proof. */
 /* Cygwin internal */
-ino_t __stdcall
+ino_t __reg2
 hash_path_name (ino_t hash, PUNICODE_STRING name)
 {
   if (name->Length == 0)
@@ -2965,7 +2965,7 @@ hash_path_name (ino_t hash, PUNICODE_STR
   return hash;
 }
 
-ino_t __stdcall
+ino_t __reg2
 hash_path_name (ino_t hash, PCWSTR name)
 {
   UNICODE_STRING uname;
@@ -2973,7 +2973,7 @@ hash_path_name (ino_t hash, PCWSTR name)
   return hash_path_name (hash, &uname);
 }
 
-ino_t __stdcall
+ino_t __reg2
 hash_path_name (ino_t hash, const char *name)
 {
   UNICODE_STRING uname;
Index: pinfo.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/pinfo.cc,v
retrieving revision 1.322
diff -u -p -r1.322 pinfo.cc
--- pinfo.cc	23 Apr 2013 09:44:33 -0000	1.322
+++ pinfo.cc	30 Apr 2013 02:35:20 -0000
@@ -492,7 +492,7 @@ _pinfo::set_ctty (fhandler_termios *fh, 
 
 /* Test to determine if a process really exists and is processing signals.
  */
-bool __stdcall
+bool __reg1
 _pinfo::exists ()
 {
   return this && process_state && !(process_state & (PID_EXITED | PID_REAPED | PID_EXECED));
Index: pipe.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/pipe.cc,v
retrieving revision 1.147
diff -u -p -r1.147 pipe.cc
--- pipe.cc	23 Apr 2013 09:44:33 -0000	1.147
+++ pipe.cc	30 Apr 2013 02:35:20 -0000
@@ -394,7 +394,7 @@ fhandler_pipe::ioctl (unsigned int cmd, 
   return 0;
 }
 
-int __stdcall
+int __reg2
 fhandler_pipe::fstatvfs (struct statvfs *sfs)
 {
   set_errno (EBADF);
Index: sec_helper.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/sec_helper.cc,v
retrieving revision 1.102
diff -u -p -r1.102 sec_helper.cc
--- sec_helper.cc	23 Apr 2013 09:44:33 -0000	1.102
+++ sec_helper.cc	30 Apr 2013 02:35:20 -0000
@@ -522,7 +522,7 @@ sec_acl (PACL acl, bool original, bool a
   return true;
 }
 
-PSECURITY_ATTRIBUTES __stdcall
+PSECURITY_ATTRIBUTES __reg3
 __sec_user (PVOID sa_buf, PSID sid1, PSID sid2, DWORD access2, BOOL inherit)
 {
   PSECURITY_ATTRIBUTES psa = (PSECURITY_ATTRIBUTES) sa_buf;
Index: signal.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/signal.cc,v
retrieving revision 1.119
diff -u -p -r1.119 signal.cc
--- signal.cc	23 Apr 2013 09:44:33 -0000	1.119
+++ signal.cc	30 Apr 2013 02:35:20 -0000
@@ -187,7 +187,7 @@ sigprocmask (int how, const sigset_t *se
   return res;
 }
 
-int __stdcall
+int __reg3
 handle_sigprocmask (int how, const sigset_t *set, sigset_t *oldset, sigset_t& opmask)
 {
   /* check that how is in right range */
@@ -227,7 +227,7 @@ handle_sigprocmask (int how, const sigse
   return 0;
 }
 
-int __stdcall
+int __reg2
 _pinfo::kill (siginfo_t& si)
 {
   int res;
Index: smallprint.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/smallprint.cc,v
retrieving revision 1.23
diff -u -p -r1.23 smallprint.cc
--- smallprint.cc	23 Apr 2013 09:44:33 -0000	1.23
+++ smallprint.cc	30 Apr 2013 02:35:20 -0000
@@ -484,7 +484,9 @@ __small_vswprintf (PWCHAR dst, const WCH
   while (*fmt)
     {
       unsigned int n = 0x7fff;
+#ifdef __x86_64__
       bool l_opt = false;
+#endif
       if (*fmt != L'%')
 	*dst++ = *fmt++;
       else
@@ -519,7 +521,9 @@ __small_vswprintf (PWCHAR dst, const WCH
 		  len = len * 10 + (c - L'0');
 		  continue;
 		case L'l':
+#ifdef __x86_64__
 		  l_opt = true;
+#endif
 		  continue;
 		case L'c':
 		case L'C':
Index: spawn.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/spawn.cc,v
retrieving revision 1.342
diff -u -p -r1.342 spawn.cc
--- spawn.cc	23 Apr 2013 09:44:33 -0000	1.342
+++ spawn.cc	30 Apr 2013 02:35:20 -0000
@@ -85,7 +85,7 @@ perhaps_suffix (const char *prog, path_c
    of name is placed in buf and returned.  Otherwise the contents of buf
    is undefined and NULL is returned.  */
 
-const char * __stdcall
+const char * __reg3
 find_exec (const char *name, path_conv& buf, const char *mywinenv,
 	   unsigned opt, const char **known_suffix)
 {
@@ -760,7 +760,6 @@ loop:
   /* Name the handle similarly to proc_subproc. */
   ProtectHandle1 (pi.hProcess, childhProc);
 
-  pid_t pid;
   if (mode == _P_OVERLAY)
     {
       myself->dwProcessId = pi.dwProcessId;
@@ -768,7 +767,6 @@ loop:
       myself.hProcess = hExeced = pi.hProcess;
       real_path.get_wide_win32_path (myself->progname); // FIXME: race?
       sigproc_printf ("new process name %W", myself->progname);
-      pid = myself->pid;
       if (!iscygwin ())
 	close_all_files ();
     }
@@ -808,7 +806,6 @@ loop:
 	  res = -1;
 	  goto out;
 	}
-      pid = child->pid;
     }
 
   /* Start the child running */
Index: strfuncs.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/strfuncs.cc,v
retrieving revision 1.50
diff -u -p -r1.50 strfuncs.cc
--- strfuncs.cc	21 Jan 2013 04:38:28 -0000	1.50
+++ strfuncs.cc	30 Apr 2013 02:35:20 -0000
@@ -410,7 +410,7 @@ __big5_mbtowc (struct _reent *r, wchar_t
        to buffer size, it's a bug in Cygwin and the buffer in the calling
        function should be raised.
 */
-size_t __stdcall
+size_t __reg3
 sys_cp_wcstombs (wctomb_p f_wctomb, const char *charset, char *dst, size_t len,
 		 const wchar_t *src, size_t nwc)
 {
@@ -496,7 +496,7 @@ sys_cp_wcstombs (wctomb_p f_wctomb, cons
   return n;
 }
 
-size_t __stdcall
+size_t __reg3
 sys_wcstombs (char *dst, size_t len, const wchar_t * src, size_t nwc)
 {
   return sys_cp_wcstombs (cygheap->locale.wctomb, cygheap->locale.charset,
@@ -513,7 +513,7 @@ sys_wcstombs (char *dst, size_t len, con
    Note that this code is shared by cygserver (which requires it via
    __small_vsprintf) and so when built there plain calloc is the
    only choice.  */
-size_t __stdcall
+size_t __reg3
 sys_wcstombs_alloc (char **dst_p, int type, const wchar_t *src, size_t nwc)
 {
   size_t ret;
@@ -539,7 +539,7 @@ sys_wcstombs_alloc (char **dst_p, int ty
    conversion.  This is so that fhandler_console can switch to an alternate
    charset, which is the charset returned by GetConsoleCP ().  Most of the
    time this is used for box and line drawing characters. */
-size_t __stdcall
+size_t __reg3
 sys_cp_mbstowcs (mbtowc_p f_mbtowc, const char *charset, wchar_t *dst,
 		 size_t dlen, const char *src, size_t nms)
 {
@@ -648,7 +648,7 @@ sys_cp_mbstowcs (mbtowc_p f_mbtowc, cons
   return count;
 }
 
-size_t __stdcall
+size_t __reg3
 sys_mbstowcs (wchar_t * dst, size_t dlen, const char *src, size_t nms)
 {
   return sys_cp_mbstowcs (cygheap->locale.mbtowc, cygheap->locale.charset,
@@ -656,7 +656,7 @@ sys_mbstowcs (wchar_t * dst, size_t dlen
 }
 
 /* Same as sys_wcstombs_alloc, just backwards. */
-size_t __stdcall
+size_t __reg3
 sys_mbstowcs_alloc (wchar_t **dst_p, int type, const char *src, size_t nms)
 {
   size_t ret;
Index: syscalls.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/syscalls.cc,v
retrieving revision 1.646
diff -u -p -r1.646 syscalls.cc
--- syscalls.cc	24 Apr 2013 10:16:12 -0000	1.646
+++ syscalls.cc	30 Apr 2013 02:35:21 -0000
@@ -1847,7 +1847,7 @@ sync ()
 }
 
 /* Cygwin internal */
-int __stdcall
+int __reg2
 stat_worker (path_conv &pc, struct stat *buf)
 {
   int res = -1;
Index: thread.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/thread.cc,v
retrieving revision 1.282
diff -u -p -r1.282 thread.cc
--- thread.cc	23 Apr 2013 09:44:34 -0000	1.282
+++ thread.cc	30 Apr 2013 02:35:21 -0000
@@ -38,8 +38,8 @@ extern "C" void __fp_lock_all ();
 extern "C" void __fp_unlock_all ();
 extern "C" int valid_sched_parameters(const struct sched_param *);
 extern "C" int sched_set_thread_priority(HANDLE thread, int priority);
-#ifdef __x86_64__
-/* FIXME: Temporarily workaround gcc 4.8 bug. */
+#if __GNUC__ == 4 && __GNUC_MINOR__ >= 7
+/* FIXME: Temporarily workaround gcc 4.7+ bug. */
 static verifyable_object_state
 #else
 static inline verifyable_object_state
@@ -122,8 +122,8 @@ __cygwin_lock_unlock (_LOCK_T *lock)
   paranoid_printf ("threadcount %d.  unlocked", MT_INTERFACE->threadcount);
 }
 
-#ifdef __x86_64__
-/* FIXME: Temporarily workaround gcc 4.8 bug. */
+#if __GNUC__ == 4 && __GNUC_MINOR__ >= 7
+/* FIXME: Temporarily workaround gcc 4.7+ bug. */
 static verifyable_object_state
 #else
 static inline verifyable_object_state
Index: tty.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/tty.cc,v
retrieving revision 1.94
diff -u -p -r1.94 tty.cc
--- tty.cc	23 Apr 2013 09:44:34 -0000	1.94
+++ tty.cc	30 Apr 2013 02:35:21 -0000
@@ -85,7 +85,7 @@ tty::init_session ()
     cygheap->fdtab.get_debugger_info ();
 }
 
-int __stdcall
+int __reg2
 tty_list::attach (int n)
 {
   int res;
Index: window.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/window.cc,v
retrieving revision 1.41
diff -u -p -r1.41 window.cc
--- window.cc	21 Jan 2013 04:38:29 -0000	1.41
+++ window.cc	30 Apr 2013 02:35:21 -0000
@@ -26,7 +26,7 @@ wininfo NO_COPY winmsg;
 
 muto NO_COPY wininfo::_lock;
 
-int __stdcall
+int __reg3
 wininfo::process (HWND hwnd, UINT uMsg, WPARAM wParam, LPARAM lParam)
 {
 #ifndef NOSTRACE
@@ -57,7 +57,7 @@ process_window_events (HWND hwnd, UINT u
 }
 
 /* Handle windows events.  Inherits ownership of the wininfo lock */
-DWORD WINAPI
+DWORD __reg1 WINAPI
 wininfo::winthread ()
 {
   MSG msg;

--------------040607010900080706050207--
