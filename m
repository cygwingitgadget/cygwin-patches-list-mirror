Return-Path: <cygwin-patches-return-7628-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22015 invoked by alias); 29 Mar 2012 14:39:35 -0000
Received: (qmail 21411 invoked by uid 22791); 29 Mar 2012 14:39:27 -0000
X-SWARE-Spam-Status: No, hits=0.7 required=5.0	tests=AWL,BAYES_50,SPF_NEUTRAL,TW_MK,TW_TV,TW_YG
X-Spam-Check-By: sourceware.org
Received: from smtp4.epfl.ch (HELO smtp4.epfl.ch) (128.178.224.218)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Thu, 29 Mar 2012 14:38:59 +0000
Received: (qmail 30767 invoked by uid 107); 29 Mar 2012 14:38:54 -0000
Received: from 76-10-162-117.dsl.teksavvy.com (HELO [192.168.0.100]) (76.10.162.117) (authenticated)  by smtp4.epfl.ch (AngelmatoPhylax SMTP proxy) with ESMTPA; Thu, 29 Mar 2012 16:38:54 +0200
Message-ID: <4F7473FE.2020704@cs.utoronto.ca>
Date: Thu, 29 Mar 2012 14:39:00 -0000
From: Ryan Johnson <ryan.johnson@cs.utoronto.ca>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:11.0) Gecko/20120327 Thunderbird/11.0.1
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Compiler warnings when building latest cygwin cvs with gcc-4.6 (1/2)
References: <4F747373.5030605@cs.utoronto.ca>
In-Reply-To: <4F747373.5030605@cs.utoronto.ca>
Content-Type: multipart/mixed; boundary="------------050906080603020108030107"
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
X-SW-Source: 2012-q1/txt/msg00051.txt.bz2

This is a multi-part message in MIME format.
--------------050906080603020108030107
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 2271

On 29/03/2012 10:36 AM, Ryan Johnson wrote:
> Patch 1: fix function attribute conflicts
         * dcrt0.cc (getstack): Simplify function attribute declarations.
         (do_exit): Remove conflicting function attributes.
         * environ.cc (various): Ditto.
         * errno.cc (various): Ditto.
         * exceptions.cc (_cygtls::interrupt_setup): Ditto.
         (sigpacket::process): Ditto.
         (rtl_unwind): Simplify function attribute declarations.
         * fhandler.cc (fhandler_base_overlapped::wait_overlapped): Ditto.
         (various): Remove conflicting function attributes.
         * fhandler.h (various fhandler_*): Correct miscounted regparm
         attribute for fchmod/fchown.
         * fhandler_clipboard.cc (various): Remove conflicting function
         attributes.
         * fhandler_console.cc (various): Ditto.
         * fhandler_disk_file.cc (various): Ditto.
         * fhandler_dsp.cc (various): Ditto.
         * fhandler_fifo.cc (various): Ditto.
         * fhandler_floppy.cc (various): Ditto.
         * fhandler_mailslot.cc (various): Ditto.
         * fhandler_mem.cc (various): Ditto.
         * fhandler_procsys.cc (various): Ditto.
         * fhandler_random.cc (various): Ditto.
         * fhandler_raw.cc (various): Ditto.
         * fhandler_serial.cc (various): Ditto.
         * fhandler_tape.cc (various): Ditto.
         * fhandler_tty.cc (various): Ditto.
         * fhandler_virtual.cc (various): Ditto.
         * fhandler_windows.cc (various): Ditto.
         * fhandler_zero.cc (various): Ditto.
         * fork.cc (various): Ditto.
         * miscfuncs.cc (check_invalid_virtual_addr): Ditto.
         * ntea.cc (various): Ditto.
         * path.cc (various): Ditto.
         (mkrelpath): Simplify function attribute declarations.
         * pinfo.cc (_pinfo::exists): Remove conflicting function
         attributes.
         * pipe.cc (fhandler_pipe::fstatvfs): Ditto.
         * sec_helper.cc (__sec_user): Ditto.
         * signal.cc (various): Ditto.
         * sigproc.cc (various): Ditto.
         * spawn.cc (find_exec): Ditto.
         * strfuncs.cc (various): Ditto.
         * syscalls.cc (stat_worker): Ditto.
         * tty.cc (tty_list::attach): Ditto.
         * window.cc (various): Ditto.


--------------050906080603020108030107
Content-Type: text/plain; charset=windows-1252;
 name="gcc-4.6-attributes.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="gcc-4.6-attributes.patch"
Content-length: 37733

? winsup/cygwin/cscope.out
Index: winsup/cygwin/dcrt0.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/dcrt0.cc,v
retrieving revision 1.426
diff -u -r1.426 dcrt0.cc
--- winsup/cygwin/dcrt0.cc	20 Mar 2012 23:13:40 -0000	1.426
+++ winsup/cygwin/dcrt0.cc	29 Mar 2012 13:20:06 -0000
@@ -439,8 +439,7 @@
   b[0] = '\0';
 }
 
-void *getstack (void *) __attribute__ ((noinline));
-volatile char *
+volatile char *  __attribute__ ((noinline))
 getstack (volatile char * volatile p)
 {
   *p ^= 1;
@@ -1068,7 +1067,7 @@
   sig_dispatch_pending (true);
 }
 
-void __stdcall
+void
 do_exit (int status)
 {
   syscall_printf ("do_exit (%d), exit_state %d", status, exit_state);
Index: winsup/cygwin/environ.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/environ.cc,v
retrieving revision 1.199
diff -u -r1.199 environ.cc
--- winsup/cygwin/environ.cc	26 Feb 2012 15:47:43 -0000	1.199
+++ winsup/cygwin/environ.cc	29 Mar 2012 13:20:07 -0000
@@ -374,7 +374,7 @@
   to the beginning of the environment variable name.  *in_posix is any
   known posix value for the environment variable. Returns a pointer to
   the appropriate conversion structure.  */
-win_env * __stdcall
+win_env * 
 getwinenv (const char *env, const char *in_posix, win_env *temp)
 {
   if (!match_first_char (env, WC))
@@ -871,7 +871,7 @@
   return strcmp (*p, *q);
 }
 
-char * __stdcall
+char * 
 getwinenveq (const char *name, size_t namelen, int x)
 {
   WCHAR name0[namelen - 1];
@@ -971,7 +971,7 @@
    filled with null terminated strings, terminated by double null characters.
    Converts environment variables noted in conv_envvars into win32 form
    prior to placing them in the string.  */
-char ** __stdcall
+char **
 build_env (const char * const *envp, PWCHAR &envblock, int &envc,
 	   bool no_envblock)
 {
Index: winsup/cygwin/errno.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/errno.cc,v
retrieving revision 1.87
diff -u -r1.87 errno.cc
--- winsup/cygwin/errno.cc	3 Dec 2011 21:43:25 -0000	1.87
+++ winsup/cygwin/errno.cc	29 Mar 2012 13:20:07 -0000
@@ -312,7 +312,7 @@
 int NO_COPY_INIT _sys_nerr = sizeof (_sys_errlist) / sizeof (_sys_errlist[0]);
 };
 
-int __stdcall
+int
 geterrno_from_win_error (DWORD code, int deferrno)
 {
   for (int i = 0; errmap[i].w != 0; ++i)
@@ -329,14 +329,14 @@
 
 /* seterrno_from_win_error: Given a Windows error code, set errno
    as appropriate. */
-void __stdcall
+void
 seterrno_from_win_error (const char *file, int line, DWORD code)
 {
   syscall_printf ("%s:%d windows error %d", file, line, code);
   errno = _impure_ptr->_errno =  geterrno_from_win_error (code, EACCES);
 }
 
-int __stdcall
+int
 geterrno_from_nt_status (NTSTATUS status, int deferrno)
 {
   return geterrno_from_win_error (RtlNtStatusToDosError (status));
@@ -344,7 +344,7 @@
 
 /* seterrno_from_nt_status: Given a NT status code, set errno
    as appropriate. */
-void __stdcall
+void
 seterrno_from_nt_status (const char *file, int line, NTSTATUS status)
 {
   DWORD code = RtlNtStatusToDosError (status);
@@ -355,7 +355,7 @@
 }
 
 /* seterrno: Set `errno' based on GetLastError (). */
-void __stdcall
+void
 seterrno (const char *file, int line)
 {
   seterrno_from_win_error (file, line, GetLastError ());
Index: winsup/cygwin/exceptions.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/exceptions.cc,v
retrieving revision 1.375
diff -u -r1.375 exceptions.cc
--- winsup/cygwin/exceptions.cc	12 Feb 2012 22:43:33 -0000	1.375
+++ winsup/cygwin/exceptions.cc	29 Mar 2012 13:20:08 -0000
@@ -449,8 +449,7 @@
 }
 
 extern "C" DWORD __stdcall RtlUnwind (void *, void *, void *, DWORD);
-static void __stdcall rtl_unwind (exception_list *, PEXCEPTION_RECORD) __attribute__ ((noinline, regparm (3)));
-void __stdcall
+void 
 rtl_unwind (exception_list *frame, PEXCEPTION_RECORD e)
 {
   __asm__ ("\n\
@@ -786,7 +785,7 @@
   return interrupted;
 }
 
-void __stdcall
+void
 _cygtls::interrupt_setup (int sig, void *handler, struct sigaction& siga)
 {
   push ((__stack_t) sigdelayed);
@@ -1143,7 +1142,7 @@
   mask_sync.release ();
 }
 
-int __stdcall
+int
 sigpacket::process ()
 {
   DWORD continue_now;
Index: winsup/cygwin/fhandler.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler.cc,v
retrieving revision 1.427
diff -u -r1.427 fhandler.cc
--- winsup/cygwin/fhandler.cc	12 Mar 2012 21:29:36 -0000	1.427
+++ winsup/cygwin/fhandler.cc	29 Mar 2012 13:20:09 -0000
@@ -215,7 +215,7 @@
 
 /* Cover function to ReadFile to achieve (as much as possible) Posix style
    semantics and use of errno.  */
-void __stdcall
+void
 fhandler_base::raw_read (void *ptr, size_t& ulen)
 {
 #define bytes_read ulen
@@ -281,7 +281,7 @@
 
 /* Cover function to WriteFile to provide Posix interface and semantics
    (as much as possible).  */
-ssize_t __stdcall
+ssize_t
 fhandler_base::raw_write (const void *ptr, size_t len)
 {
   NTSTATUS status;
@@ -722,7 +722,7 @@
    an \n.  If last char is an \r, look ahead one more char, if \n then
    modify \r, if not, remember char.
 */
-void __stdcall
+void
 fhandler_base::read (void *in_ptr, size_t& len)
 {
   char *ptr = (char *) in_ptr;
@@ -812,7 +812,7 @@
   debug_printf ("returning %d, %s mode", len, rbinary () ? "binary" : "text");
 }
 
-ssize_t __stdcall
+ssize_t
 fhandler_base::write (const void *ptr, size_t len)
 {
   int res;
@@ -904,7 +904,7 @@
   return res;
 }
 
-ssize_t __stdcall
+ssize_t
 fhandler_base::readv (const struct iovec *const iov, const int iovcnt,
 		      ssize_t tot)
 {
@@ -961,7 +961,7 @@
   return len;
 }
 
-ssize_t __stdcall
+ssize_t
 fhandler_base::writev (const struct iovec *const iov, const int iovcnt,
 		       ssize_t tot)
 {
@@ -1081,14 +1081,14 @@
   return res;
 }
 
-ssize_t __stdcall
+ssize_t 
 fhandler_base::pread (void *, size_t, _off64_t)
 {
   set_errno (ESPIPE);
   return -1;
 }
 
-ssize_t __stdcall
+ssize_t 
 fhandler_base::pwrite (void *, size_t, _off64_t)
 {
   set_errno (ESPIPE);
@@ -1263,7 +1263,7 @@
   return -1;
 }
 
-int __stdcall
+int
 fhandler_base::fstat (struct __stat64 *buf)
 {
   if (is_fs_special ())
@@ -1304,7 +1304,7 @@
   return 0;
 }
 
-int __stdcall
+int
 fhandler_base::fstatvfs (struct statvfs *sfs)
 {
   /* If we hit this base implementation, it's some device in /dev.
@@ -1866,7 +1866,7 @@
 
 /* Overlapped I/O */
 
-int __stdcall __attribute__ ((regparm (1)))
+int
 fhandler_base_overlapped::setup_overlapped ()
 {
   OVERLAPPED *ov = get_overlapped_buffer ();
@@ -1877,7 +1877,7 @@
   return ov->hEvent ? 0 : -1;
 }
 
-void __stdcall __attribute__ ((regparm (1)))
+void
 fhandler_base_overlapped::destroy_overlapped ()
 {
   OVERLAPPED *ov = get_overlapped ();
@@ -1891,7 +1891,7 @@
   get_overlapped () = NULL;
 }
 
-bool __stdcall __attribute__ ((regparm (1)))
+bool
 fhandler_base_overlapped::has_ongoing_io ()
 {
   if (!io_pending)
@@ -1905,7 +1905,7 @@
   return false;
 }
 
-fhandler_base_overlapped::wait_return __stdcall __attribute__ ((regparm (3)))
+fhandler_base_overlapped::wait_return
 fhandler_base_overlapped::wait_overlapped (bool inres, bool writing, DWORD *bytes, bool nonblocking, DWORD len)
 {
   if (!get_overlapped ())
@@ -2013,7 +2013,7 @@
   return res;
 }
 
-void __stdcall __attribute__ ((regparm (3)))
+void
 fhandler_base_overlapped::raw_read (void *ptr, size_t& len)
 {
   DWORD nbytes;
@@ -2038,7 +2038,7 @@
   len = (size_t) nbytes;
 }
 
-ssize_t __stdcall __attribute__ ((regparm (3)))
+ssize_t
 fhandler_base_overlapped::raw_write (const void *ptr, size_t len)
 {
   size_t nbytes;
Index: winsup/cygwin/fhandler.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler.h,v
retrieving revision 1.456
diff -u -r1.456 fhandler.h
--- winsup/cygwin/fhandler.h	26 Mar 2012 11:24:51 -0000	1.456
+++ winsup/cygwin/fhandler.h	29 Mar 2012 13:20:11 -0000
@@ -339,8 +339,8 @@
 public:
   virtual int __stdcall fstatvfs (struct statvfs *buf) __attribute__ ((regparm (2)));
   int utimens_fs (const struct timespec *) __attribute__ ((regparm (2)));
-  virtual int __stdcall fchmod (mode_t mode) __attribute__ ((regparm (1)));
-  virtual int __stdcall fchown (__uid32_t uid, __gid32_t gid) __attribute__ ((regparm (2)));
+  virtual int __stdcall fchmod (mode_t mode) __attribute__ ((regparm (2)));
+  virtual int __stdcall fchown (__uid32_t uid, __gid32_t gid) __attribute__ ((regparm (3)));
   virtual int __stdcall facl (int, int, __acl32 *) __attribute__ ((regparm (3)));
   virtual ssize_t __stdcall fgetxattr (const char *, void *, size_t) __attribute__ ((regparm (3)));
   virtual int __stdcall fsetxattr (const char *, const void *, size_t, int) __attribute__ ((regparm (3)));
@@ -596,8 +596,8 @@
 
   int __stdcall fstat (struct __stat64 *buf) __attribute__ ((regparm (2)));
   int __stdcall fstatvfs (struct statvfs *buf) __attribute__ ((regparm (2)));
-  int __stdcall fchmod (mode_t mode) __attribute__ ((regparm (1)));
-  int __stdcall fchown (__uid32_t uid, __gid32_t gid) __attribute__ ((regparm (2)));
+  int __stdcall fchmod (mode_t mode) __attribute__ ((regparm (2)));
+  int __stdcall fchown (__uid32_t uid, __gid32_t gid) __attribute__ ((regparm (3)));
   int __stdcall facl (int, int, __acl32 *) __attribute__ ((regparm (3)));
   int __stdcall link (const char *) __attribute__ ((regparm (2)));
 
@@ -970,8 +970,8 @@
   int lock (int, struct __flock64 *);
   bool isdevice () const { return false; }
   int __stdcall fstat (struct __stat64 *buf) __attribute__ ((regparm (2)));
-  int __stdcall fchmod (mode_t mode) __attribute__ ((regparm (1)));
-  int __stdcall fchown (__uid32_t uid, __gid32_t gid) __attribute__ ((regparm (2)));
+  int __stdcall fchmod (mode_t mode) __attribute__ ((regparm (2)));
+  int __stdcall fchown (__uid32_t uid, __gid32_t gid) __attribute__ ((regparm (3)));
   int __stdcall facl (int, int, __acl32 *) __attribute__ ((regparm (3)));
   ssize_t __stdcall fgetxattr (const char *, void *, size_t) __attribute__ ((regparm (3)));
   int __stdcall fsetxattr (const char *, const void *, size_t, int) __attribute__ ((regparm (3)));
@@ -1455,8 +1455,8 @@
   int get_unit ();
   virtual char const *ttyname () { return pc.dev.name; }
   int __stdcall fstat (struct __stat64 *buf) __attribute__ ((regparm (2)));
-  int __stdcall fchmod (mode_t mode) __attribute__ ((regparm (1)));
-  int __stdcall fchown (__uid32_t uid, __gid32_t gid) __attribute__ ((regparm (2)));
+  int __stdcall fchmod (mode_t mode) __attribute__ ((regparm (2)));
+  int __stdcall fchown (__uid32_t uid, __gid32_t gid) __attribute__ ((regparm (3)));
 
   fhandler_pty_slave (void *) {}
 
@@ -1824,8 +1824,8 @@
   int close ();
   int __stdcall fstat (struct stat *buf) __attribute__ ((regparm (2)));
   int __stdcall fstatvfs (struct statvfs *buf) __attribute__ ((regparm (2)));
-  int __stdcall fchmod (mode_t mode) __attribute__ ((regparm (1)));
-  int __stdcall fchown (__uid32_t uid, __gid32_t gid) __attribute__ ((regparm (2)));
+  int __stdcall fchmod (mode_t mode) __attribute__ ((regparm (2)));
+  int __stdcall fchown (__uid32_t uid, __gid32_t gid) __attribute__ ((regparm (3)));
   int __stdcall facl (int, int, __acl32 *) __attribute__ ((regparm (3)));
   virtual bool fill_filebuf ();
   char *get_filebuf () { return filebuf; }
Index: winsup/cygwin/fhandler_clipboard.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_clipboard.cc,v
retrieving revision 1.50
diff -u -r1.50 fhandler_clipboard.cc
--- winsup/cygwin/fhandler_clipboard.cc	26 Mar 2012 11:24:51 -0000	1.50
+++ winsup/cygwin/fhandler_clipboard.cc	29 Mar 2012 13:20:11 -0000
@@ -155,7 +155,7 @@
 }
 
 /* FIXME: arbitrary seeking is not handled */
-ssize_t __stdcall
+ssize_t
 fhandler_dev_clipboard::write (const void *buf, size_t len)
 {
   if (!eof)
@@ -192,7 +192,7 @@
     }
 }
 
-int __stdcall
+int
 fhandler_dev_clipboard::fstat (struct __stat64 *buf)
 {
   buf->st_mode = S_IFCHR | STD_RBITS | STD_WBITS | S_IWGRP | S_IWOTH;
@@ -226,7 +226,7 @@
   return 0;
 }
 
-void __stdcall
+void
 fhandler_dev_clipboard::read (void *ptr, size_t& len)
 {
   HGLOBAL hglb;
Index: winsup/cygwin/fhandler_console.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_console.cc,v
retrieving revision 1.266
diff -u -r1.266 fhandler_console.cc
--- winsup/cygwin/fhandler_console.cc	10 Mar 2012 17:51:33 -0000	1.266
+++ winsup/cygwin/fhandler_console.cc	29 Mar 2012 13:20:12 -0000
@@ -312,7 +312,7 @@
 		 || dev_state.use_mouse >= 3));
 }
 
-void __stdcall
+void
 fhandler_console::read (void *pv, size_t& buflen)
 {
   push_process_state process_state (PID_TTYIN);
@@ -1918,7 +1918,7 @@
   return found + trunc_buf.len;
 }
 
-ssize_t __stdcall
+ssize_t
 fhandler_console::write (const void *vsrc, size_t len)
 {
   bg_check_types bg = bg_check (SIGTTOU);
Index: winsup/cygwin/fhandler_disk_file.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_disk_file.cc,v
retrieving revision 1.373
diff -u -r1.373 fhandler_disk_file.cc
--- winsup/cygwin/fhandler_disk_file.cc	16 Feb 2012 11:02:05 -0000	1.373
+++ winsup/cygwin/fhandler_disk_file.cc	29 Mar 2012 13:20:14 -0000
@@ -207,7 +207,7 @@
 #if 0
 /* This function is obsolete.  We're keeping it in so we don't forget
    that we already did all that at one point. */
-unsigned __stdcall
+unsigned
 path_conv::ndisk_links (DWORD nNumberOfLinks)
 {
   if (!isdir () || isremote ())
@@ -290,7 +290,7 @@
    This returns the content of a struct fattr3 as defined in RFC 1813.
    The content is the NFS equivalent of struct stat. so there's not much
    to do here except for copying. */
-int __stdcall
+int
 fhandler_base::fstat_by_nfs_ea (struct __stat64 *buf)
 {
   fattr3 *nfs_attr = pc.nfsattr ();
@@ -330,7 +330,7 @@
   return 0;
 }
 
-int __stdcall
+int
 fhandler_base::fstat_by_handle (struct __stat64 *buf)
 {
   /* Don't use FileAllInformation info class.  It returns a pathname rather
@@ -388,7 +388,7 @@
   return fstat_helper (buf, fsi.NumberOfLinks);
 }
 
-int __stdcall
+int
 fhandler_base::fstat_by_name (struct __stat64 *buf)
 {
   NTSTATUS status;
@@ -432,7 +432,7 @@
   return fstat_helper (buf, 1);
 }
 
-int __stdcall
+int
 fhandler_base::fstat_fs (struct __stat64 *buf)
 {
   int res = -1;
@@ -476,7 +476,7 @@
   return res;
 }
 
-int __stdcall
+int
 fhandler_base::fstat_helper (struct __stat64 *buf,
 			     DWORD nNumberOfLinks)
 {
@@ -670,13 +670,13 @@
   return 0;
 }
 
-int __stdcall
+int
 fhandler_disk_file::fstat (struct __stat64 *buf)
 {
   return fstat_fs (buf);
 }
 
-int __stdcall
+int
 fhandler_disk_file::fstatvfs (struct statvfs *sfs)
 {
   int ret = -1, opened = 0;
@@ -768,7 +768,7 @@
   return ret;
 }
 
-int __stdcall
+int
 fhandler_disk_file::fchmod (mode_t mode)
 {
   extern int chmod_device (path_conv& pc, mode_t mode);
@@ -876,7 +875,7 @@
   return res;
 }
 
-int __stdcall
+int
 fhandler_disk_file::fchown (__uid32_t uid, __gid32_t gid)
 {
   int oret = 0;
@@ -944,7 +943,7 @@
   return res;
 }
 
-int _stdcall
+int _stdcall   __attribute__ ((regparm (3)))
 fhandler_disk_file::facl (int cmd, int nentries, __aclent32_t *aclbufp)
 {
   int res = -1;
@@ -1516,7 +1515,7 @@
   return 0;
 }
 
-ssize_t __stdcall
+ssize_t
 fhandler_disk_file::pread (void *buf, size_t count, _off64_t offset)
 {
   if ((get_flags () & O_ACCMODE) == O_WRONLY)
@@ -1586,7 +1585,7 @@
   return res;
 }
 
-ssize_t __stdcall
+ssize_t
 fhandler_disk_file::pwrite (void *buf, size_t count, _off64_t offset)
 {
   if ((get_flags () & O_ACCMODE) == O_RDONLY)
@@ -1902,7 +1901,7 @@
   return res;
 }
 
-__ino64_t __stdcall
+__ino64_t
 readdir_get_ino (const char *path, bool dot_dot)
 {
   char *fname;
Index: winsup/cygwin/fhandler_dsp.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_dsp.cc,v
retrieving revision 1.61
diff -u -r1.61 fhandler_dsp.cc
--- winsup/cygwin/fhandler_dsp.cc	9 Feb 2012 15:23:17 -0000	1.61
+++ winsup/cygwin/fhandler_dsp.cc	29 Mar 2012 13:20:15 -0000
@@ -1046,7 +1046,7 @@
 #define IS_WRITE() ((get_flags() & O_ACCMODE) != O_RDONLY)
 #define IS_READ() ((get_flags() & O_ACCMODE) != O_WRONLY)
 
-ssize_t __stdcall
+ssize_t
 fhandler_dev_dsp::write (const void *ptr, size_t len)
 {
   debug_printf ("ptr=%08x len=%d", ptr, len);
@@ -1092,7 +1092,7 @@
   return len - len_s + written;
 }
 
-void __stdcall
+void
 fhandler_dev_dsp::read (void *ptr, size_t& len)
 {
   debug_printf ("ptr=%08x len=%d", ptr, len);
Index: winsup/cygwin/fhandler_fifo.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_fifo.cc,v
retrieving revision 1.54
diff -u -r1.54 fhandler_fifo.cc
--- winsup/cygwin/fhandler_fifo.cc	22 Jan 2012 21:43:25 -0000	1.54
+++ winsup/cygwin/fhandler_fifo.cc	29 Mar 2012 13:20:15 -0000
@@ -269,7 +269,7 @@
    }
 }
 
-void __stdcall
+void
 fhandler_fifo::raw_read (void *in_ptr, size_t& len)
 {
   size_t orig_len = len;
@@ -308,7 +308,7 @@
   len = -1;
 }
 
-int __stdcall
+int
 fhandler_fifo::fstatvfs (struct statvfs *sfs)
 {
   fhandler_disk_file fh (pc);
Index: winsup/cygwin/fhandler_floppy.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_floppy.cc,v
retrieving revision 1.62
diff -u -r1.62 fhandler_floppy.cc
--- winsup/cygwin/fhandler_floppy.cc	8 Mar 2012 09:36:11 -0000	1.62
+++ winsup/cygwin/fhandler_floppy.cc	29 Mar 2012 13:20:15 -0000
@@ -423,7 +423,7 @@
   return off.QuadPart;
 }
 
-void __stdcall
+void
 fhandler_dev_floppy::raw_read (void *ptr, size_t& ulen)
 {
   DWORD bytes_read = 0;
@@ -555,7 +555,7 @@
   ulen = (size_t) -1;
 }
 
-int __stdcall
+int
 fhandler_dev_floppy::raw_write (const void *ptr, size_t len)
 {
   DWORD bytes_written = 0;
Index: winsup/cygwin/fhandler_mailslot.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_mailslot.cc,v
retrieving revision 1.16
diff -u -r1.16 fhandler_mailslot.cc
--- winsup/cygwin/fhandler_mailslot.cc	14 Feb 2012 11:27:43 -0000	1.16
+++ winsup/cygwin/fhandler_mailslot.cc	29 Mar 2012 13:20:16 -0000
@@ -28,7 +28,7 @@
 {
 }
 
-int __stdcall
+int
 fhandler_mailslot::fstat (struct __stat64 *buf)
 {
   debug_printf ("here");
@@ -146,7 +146,7 @@
   return res;
 }
 
-ssize_t __stdcall
+ssize_t
 fhandler_mailslot::raw_write (const void *ptr, size_t len)
 {
   /* Check for 425/426 byte weirdness */
Index: winsup/cygwin/fhandler_mem.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_mem.cc,v
retrieving revision 1.59
diff -u -r1.59 fhandler_mem.cc
--- winsup/cygwin/fhandler_mem.cc	22 Dec 2011 11:02:33 -0000	1.59
+++ winsup/cygwin/fhandler_mem.cc	29 Mar 2012 13:20:16 -0000
@@ -116,7 +116,7 @@
   return 1;
 }
 
-ssize_t __stdcall
+ssize_t
 fhandler_dev_mem::write (const void *ptr, size_t ulen)
 {
   if (!ulen || pos >= mem_size)
@@ -159,7 +159,7 @@
   return ulen;
 }
 
-void __stdcall
+void
 fhandler_dev_mem::read (void *ptr, size_t& ulen)
 {
   if (!ulen || pos >= mem_size)
Index: winsup/cygwin/fhandler_procsys.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_procsys.cc,v
retrieving revision 1.11
diff -u -r1.11 fhandler_procsys.cc
--- winsup/cygwin/fhandler_procsys.cc	3 Dec 2011 21:43:25 -0000	1.11
+++ winsup/cygwin/fhandler_procsys.cc	29 Mar 2012 13:20:16 -0000
@@ -391,7 +391,7 @@
   return fhandler_virtual::closedir (dir);
 }
 
-void __stdcall
+void
 fhandler_procsys::read (void *ptr, size_t& len)
 {
   NTSTATUS status;
@@ -410,7 +410,7 @@
     len = io.Information;
 }
 
-ssize_t __stdcall
+ssize_t
 fhandler_procsys::write (const void *ptr, size_t len)
 {
   /* FIXME: Implement nonblocking I/O, interruptibility and cancelability. */
Index: winsup/cygwin/fhandler_random.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_random.cc,v
retrieving revision 1.43
diff -u -r1.43 fhandler_random.cc
--- winsup/cygwin/fhandler_random.cc	14 Nov 2011 01:29:48 -0000	1.43
+++ winsup/cygwin/fhandler_random.cc	29 Mar 2012 13:20:16 -0000
@@ -71,7 +71,7 @@
   return len;
 }
 
-ssize_t __stdcall
+ssize_t
 fhandler_dev_random::write (const void *ptr, size_t len)
 {
   if (!len)
@@ -114,7 +114,7 @@
   return len;
 }
 
-void __stdcall
+void
 fhandler_dev_random::read (void *ptr, size_t& len)
 {
   if (!len)
Index: winsup/cygwin/fhandler_raw.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_raw.cc,v
retrieving revision 1.74
diff -u -r1.74 fhandler_raw.cc
--- winsup/cygwin/fhandler_raw.cc	14 Nov 2011 01:37:02 -0000	1.74
+++ winsup/cygwin/fhandler_raw.cc	29 Mar 2012 13:20:16 -0000
@@ -32,7 +32,7 @@
     delete [] devbuf;
 }
 
-int __stdcall
+int
 fhandler_dev_raw::fstat (struct __stat64 *buf)
 {
   debug_printf ("here");
Index: winsup/cygwin/fhandler_serial.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_serial.cc,v
retrieving revision 1.85
diff -u -r1.85 fhandler_serial.cc
--- winsup/cygwin/fhandler_serial.cc	8 Mar 2012 09:36:11 -0000	1.85
+++ winsup/cygwin/fhandler_serial.cc	29 Mar 2012 13:20:17 -0000
@@ -39,7 +39,7 @@
   overlapped_armed = 0;
 }
 
-void __stdcall
+void
 fhandler_serial::raw_read (void *ptr, size_t& ulen)
 {
   int tot;
@@ -168,7 +168,7 @@
 
 /* Cover function to WriteFile to provide Posix interface and semantics
    (as much as possible).  */
-ssize_t __stdcall
+ssize_t
 fhandler_serial::raw_write (const void *ptr, size_t len)
 {
   DWORD bytes_written;
Index: winsup/cygwin/fhandler_socket.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_socket.cc,v
retrieving revision 1.285
diff -u -r1.285 fhandler_socket.cc
--- winsup/cygwin/fhandler_socket.cc	8 Mar 2012 09:36:11 -0000	1.285
+++ winsup/cygwin/fhandler_socket.cc	29 Mar 2012 13:20:18 -0000
@@ -806,7 +806,7 @@
   return -1;
 }
 
-int __stdcall
+int
 fhandler_socket::fstat (struct __stat64 *buf)
 {
   int res;
@@ -833,7 +833,7 @@
   return res;
 }
 
-int __stdcall
+int
 fhandler_socket::fstatvfs (struct statvfs *sfs)
 {
   if (get_device () == FH_UNIX)
@@ -1334,7 +1334,7 @@
   return res;
 }
 
-void __stdcall
+void
 fhandler_socket::read (void *in_ptr, size_t& len)
 {
   WSABUF wsabuf = { len, (char *) in_ptr };
Index: winsup/cygwin/fhandler_tape.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_tape.cc,v
retrieving revision 1.79
diff -u -r1.79 fhandler_tape.cc
--- winsup/cygwin/fhandler_tape.cc	8 Mar 2012 09:36:11 -0000	1.79
+++ winsup/cygwin/fhandler_tape.cc	29 Mar 2012 13:20:19 -0000
@@ -1252,7 +1252,7 @@
   return ret ? -1 : cret;
 }
 
-void __stdcall
+void
 fhandler_dev_tape::raw_read (void *ptr, size_t &ulen)
 {
   char *buf = (char *) ptr;
@@ -1353,7 +1353,7 @@
   unlock ();
 }
 
-ssize_t __stdcall
+ssize_t
 fhandler_dev_tape::raw_write (const void *ptr, size_t len)
 {
   if (!_lock (true))
Index: winsup/cygwin/fhandler_tty.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_tty.cc,v
retrieving revision 1.258
diff -u -r1.258 fhandler_tty.cc
--- winsup/cygwin/fhandler_tty.cc	8 Mar 2012 09:36:11 -0000	1.258
+++ winsup/cygwin/fhandler_tty.cc	29 Mar 2012 13:20:20 -0000
@@ -607,7 +607,7 @@
   return ret;
 }
 
-ssize_t __stdcall
+ssize_t
 fhandler_pty_slave::write (const void *ptr, size_t len)
 {
   DWORD n, towrite = len;
@@ -659,7 +659,7 @@
   return towrite;
 }
 
-void __stdcall
+void
 fhandler_pty_slave::read (void *ptr, size_t& len)
 {
   int totalread = 0;
@@ -1051,7 +1051,7 @@
   return retval;
 }
 
-int __stdcall
+int
 fhandler_pty_slave::fstat (struct __stat64 *st)
 {
   fhandler_base::fstat (st);
@@ -1135,7 +1135,7 @@
   close_maybe (inuse);
 }
 
-int __stdcall
+int
 fhandler_pty_slave::fchmod (mode_t mode)
 {
   int ret = -1;
@@ -1161,7 +1161,7 @@
   return ret;
 }
 
-int __stdcall
+int
 fhandler_pty_slave::fchown (__uid32_t uid, __gid32_t gid)
 {
   int ret = -1;
@@ -1319,7 +1319,7 @@
     close_with_arch ();
 }
 
-ssize_t __stdcall
+ssize_t
 fhandler_pty_master::write (const void *ptr, size_t len)
 {
   int i;
@@ -1345,7 +1345,7 @@
   return i;
 }
 
-void __stdcall
+void
 fhandler_pty_master::read (void *ptr, size_t& len)
 {
   bg_check_types bg = bg_check (SIGTTIN);
Index: winsup/cygwin/fhandler_virtual.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_virtual.cc,v
retrieving revision 1.57
diff -u -r1.57 fhandler_virtual.cc
--- winsup/cygwin/fhandler_virtual.cc	14 Nov 2011 01:29:48 -0000	1.57
+++ winsup/cygwin/fhandler_virtual.cc	29 Mar 2012 13:20:20 -0000
@@ -181,7 +181,7 @@
   return 0;
 }
 
-void __stdcall
+void
 fhandler_virtual::read (void *ptr, size_t& len)
 {
   if (len == 0)
@@ -206,7 +206,7 @@
   position += len;
 }
 
-ssize_t __stdcall
+ssize_t
 fhandler_virtual::write (const void *ptr, size_t len)
 {
   set_errno (EACCES);
@@ -266,7 +266,7 @@
   return res;
 }
 
-int __stdcall
+int
 fhandler_virtual::fstatvfs (struct statvfs *sfs)
 {
   /* Virtual file system.  Just return an empty buffer with a few values
Index: winsup/cygwin/fhandler_windows.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_windows.cc,v
retrieving revision 1.33
diff -u -r1.33 fhandler_windows.cc
--- winsup/cygwin/fhandler_windows.cc	21 Jul 2011 20:21:46 -0000	1.33
+++ winsup/cygwin/fhandler_windows.cc	29 Mar 2012 13:20:20 -0000
@@ -62,7 +62,7 @@
   return 1;
 }
 
-ssize_t __stdcall
+ssize_t
 fhandler_windows::write (const void *buf, size_t)
 {
   MSG *ptr = (MSG *) buf;
@@ -84,7 +84,7 @@
   return sizeof (MSG);
 }
 
-void __stdcall
+void
 fhandler_windows::read (void *buf, size_t& len)
 {
   MSG *ptr = (MSG *) buf;
Index: winsup/cygwin/fhandler_zero.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_zero.cc,v
retrieving revision 1.31
diff -u -r1.31 fhandler_zero.cc
--- winsup/cygwin/fhandler_zero.cc	24 Jul 2009 20:54:33 -0000	1.31
+++ winsup/cygwin/fhandler_zero.cc	29 Mar 2012 13:20:20 -0000
@@ -30,7 +30,7 @@
   return 1;
 }
 
-ssize_t __stdcall
+ssize_t 
 fhandler_dev_zero::write (const void *, size_t len)
 {
   if (get_device () == FH_FULL)
@@ -41,7 +41,7 @@
   return len;
 }
 
-void __stdcall
+void 
 fhandler_dev_zero::read (void *ptr, size_t& len)
 {
   memset (ptr, 0, len);
Index: winsup/cygwin/fork.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fork.cc,v
retrieving revision 1.236
diff -u -r1.236 fork.cc
--- winsup/cygwin/fork.cc	21 Mar 2012 15:54:49 -0000	1.236
+++ winsup/cygwin/fork.cc	29 Mar 2012 13:20:20 -0000
@@ -128,7 +128,7 @@
     }
 }
 
-int __stdcall
+int
 frok::child (volatile char * volatile here)
 {
   HANDLE& hParent = ch.parent;
@@ -250,7 +250,7 @@
 }
 #endif
 
-int __stdcall
+int
 frok::parent (volatile char * volatile stack_here)
 {
   HANDLE forker_finished;
Index: winsup/cygwin/miscfuncs.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/miscfuncs.cc,v
retrieving revision 1.81
diff -u -r1.81 miscfuncs.cc
--- winsup/cygwin/miscfuncs.cc	15 Feb 2012 21:34:06 -0000	1.81
+++ winsup/cygwin/miscfuncs.cc	29 Mar 2012 13:20:21 -0000
@@ -176,7 +176,7 @@
   return string;
 }
 
-int __stdcall
+int
 check_invalid_virtual_addr (const void *s, unsigned sz)
 {
   MEMORY_BASIC_INFORMATION mbuf;
Index: winsup/cygwin/ntea.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/ntea.cc,v
retrieving revision 1.26
diff -u -r1.26 ntea.cc
--- winsup/cygwin/ntea.cc	3 Dec 2011 21:43:26 -0000	1.26
+++ winsup/cygwin/ntea.cc	29 Mar 2012 13:20:24 -0000
@@ -29,7 +29,7 @@
 #define NEXT_FEA(p) ((PFILE_FULL_EA_INFORMATION) (p->NextEntryOffset \
 		     ? (char *) p + p->NextEntryOffset : NULL))
 
-ssize_t __stdcall
+ssize_t
 read_ea (HANDLE hdl, path_conv &pc, const char *name, char *value, size_t size)
 {
   OBJECT_ATTRIBUTES attr;
@@ -215,7 +215,7 @@
   return ret;
 }
 
-int __stdcall
+int
 write_ea (HANDLE hdl, path_conv &pc, const char *name, const char *value,
 	  size_t size, int flags)
 {
Index: winsup/cygwin/path.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/path.cc,v
retrieving revision 1.651
diff -u -r1.651 path.cc
--- winsup/cygwin/path.cc	8 Mar 2012 14:56:18 -0000	1.651
+++ winsup/cygwin/path.cc	29 Mar 2012 13:20:27 -0000
@@ -340,10 +340,7 @@
     }
 }
 
-static void __stdcall mkrelpath (char *dst, bool caseinsensitive)
-  __attribute__ ((regparm (2)));
-
-static void __stdcall
+static void __stdcall  __attribute__ ((regparm (2)))
 mkrelpath (char *path, bool caseinsensitive)
 {
   tmp_pathbuf tp;
@@ -1341,7 +1338,7 @@
 /* nofinalslash: Remove trailing / and \ from SRC (except for the
    first one).  It is ok for src == dst.  */
 
-void __stdcall
+void
 nofinalslash (const char *src, char *dst)
 {
   int len = strlen (src);
@@ -2798,7 +2792,7 @@
    done during the opendir call and the hash or the filename within
    the directory.  FIXME: Not bullet-proof. */
 /* Cygwin internal */
-__ino64_t __stdcall
+__ino64_t
 hash_path_name (__ino64_t hash, PUNICODE_STRING name)
 {
   if (name->Length == 0)
@@ -2812,7 +2806,7 @@
   return hash;
 }
 
-__ino64_t __stdcall
+__ino64_t
 hash_path_name (__ino64_t hash, PCWSTR name)
 {
   UNICODE_STRING uname;
@@ -2820,7 +2814,7 @@
   return hash_path_name (hash, &uname);
 }
 
-__ino64_t __stdcall
+__ino64_t
 hash_path_name (__ino64_t hash, const char *name)
 {
   UNICODE_STRING uname;
Index: winsup/cygwin/pinfo.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/pinfo.cc,v
retrieving revision 1.305
diff -u -r1.305 pinfo.cc
--- winsup/cygwin/pinfo.cc	21 Mar 2012 05:23:12 -0000	1.305
+++ winsup/cygwin/pinfo.cc	29 Mar 2012 13:20:28 -0000
@@ -483,7 +482,7 @@
 
 /* Test to determine if a process really exists and is processing signals.
  */
-bool __stdcall
+bool
 _pinfo::exists ()
 {
   return this && !(process_state & (PID_EXITED | PID_REAPED));
Index: winsup/cygwin/pipe.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/pipe.cc,v
retrieving revision 1.142
diff -u -r1.142 pipe.cc
--- winsup/cygwin/pipe.cc	14 Feb 2012 11:27:43 -0000	1.142
+++ winsup/cygwin/pipe.cc	29 Mar 2012 13:20:28 -0000
@@ -379,7 +379,7 @@
   return 0;
 }
 
-int __stdcall
+int
 fhandler_pipe::fstatvfs (struct statvfs *sfs)
 {
   set_errno (EBADF);
Index: winsup/cygwin/sec_helper.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/sec_helper.cc,v
retrieving revision 1.96
diff -u -r1.96 sec_helper.cc
--- winsup/cygwin/sec_helper.cc	17 Dec 2011 23:39:47 -0000	1.96
+++ winsup/cygwin/sec_helper.cc	29 Mar 2012 13:20:29 -0000
@@ -551,7 +551,7 @@
   return true;
 }
 
-PSECURITY_ATTRIBUTES __stdcall
+PSECURITY_ATTRIBUTES
 __sec_user (PVOID sa_buf, PSID sid1, PSID sid2, DWORD access2, BOOL inherit)
 {
   PSECURITY_ATTRIBUTES psa = (PSECURITY_ATTRIBUTES) sa_buf;
Index: winsup/cygwin/signal.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/signal.cc,v
retrieving revision 1.106
diff -u -r1.106 signal.cc
--- winsup/cygwin/signal.cc	17 Dec 2011 23:39:47 -0000	1.106
+++ winsup/cygwin/signal.cc	29 Mar 2012 13:20:29 -0000
@@ -190,7 +190,7 @@
   return res;
 }
 
-int __stdcall
+int
 handle_sigprocmask (int how, const sigset_t *set, sigset_t *oldset, sigset_t& opmask)
 {
   /* check that how is in right range */
@@ -230,7 +230,7 @@
   return 0;
 }
 
-int __stdcall
+int
 _pinfo::kill (siginfo_t& si)
 {
   int res;
Index: winsup/cygwin/sigproc.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/sigproc.cc,v
retrieving revision 1.381
diff -u -r1.381 sigproc.cc
--- winsup/cygwin/sigproc.cc	28 Mar 2012 17:28:27 -0000	1.381
+++ winsup/cygwin/sigproc.cc	29 Mar 2012 13:20:31 -0000
@@ -162,7 +162,7 @@
   return false;
 }
 
-bool __stdcall
+bool
 pid_exists (pid_t pid)
 {
   return pinfo (pid)->exists ();
@@ -180,7 +180,7 @@
 
 /* Handle all subprocess requests
  */
-int __stdcall
+int
 proc_subproc (DWORD what, DWORD val)
 {
   int rc = 1;
@@ -458,7 +457,7 @@
 }
 
 /* Clear pending signal */
-void __stdcall
+void
 sig_clear (int target_sig)
 {
   if (&_my_tls != _sig_tls)
@@ -562,7 +561,7 @@
     }
 }
 
-int __stdcall
+int
 sig_send (_pinfo *p, int sig)
 {
   if (sig == __SIGHOLD)
@@ -594,7 +593,7 @@
    If pinfo *p == NULL, send to the current process.
    If sending to this process, wait for notification that a signal has
    completed before returning.  */
-int __stdcall
+int
 sig_send (_pinfo *p, siginfo_t& si, _cygtls *tls)
 {
   int rc = 1;
@@ -1155,7 +1154,7 @@
 /* Check the state of all of our children to see if any are stopped or
  * terminated.
  */
-static int __stdcall
+static int __stdcall  __attribute__ ((regparm (1)))
 checkstate (waitq *parent_w)
 {
   int potential_match = 0;
Index: winsup/cygwin/spawn.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/spawn.cc,v
retrieving revision 1.329
diff -u -r1.329 spawn.cc
--- winsup/cygwin/spawn.cc	21 Mar 2012 15:54:50 -0000	1.329
+++ winsup/cygwin/spawn.cc	29 Mar 2012 13:20:31 -0000
@@ -99,7 +99,7 @@
    of name is placed in buf and returned.  Otherwise the contents of buf
    is undefined and NULL is returned.  */
 
-const char * __stdcall
+const char *
 find_exec (const char *name, path_conv& buf, const char *mywinenv,
 	   unsigned opt, const char **known_suffix)
 {
Index: winsup/cygwin/strfuncs.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/strfuncs.cc,v
retrieving revision 1.48
diff -u -r1.48 strfuncs.cc
--- winsup/cygwin/strfuncs.cc	8 Mar 2012 09:36:11 -0000	1.48
+++ winsup/cygwin/strfuncs.cc	29 Mar 2012 13:20:31 -0000
@@ -396,7 +396,7 @@
    - The functions always create 0-terminated results, no matter what.
      If the result is truncated due to buffer size, it's a bug in Cygwin
      and the buffer in the calling function should be raised. */
-size_t __stdcall
+size_t
 sys_cp_wcstombs (wctomb_p f_wctomb, const char *charset, char *dst, size_t len,
 		 const wchar_t *src, size_t nwc)
 {
@@ -482,7 +482,7 @@
   return n;
 }
 
-size_t __stdcall
+size_t
 sys_wcstombs (char *dst, size_t len, const wchar_t * src, size_t nwc)
 {
   return sys_cp_wcstombs (cygheap->locale.wctomb, cygheap->locale.charset,
@@ -499,7 +499,7 @@
    Note that this code is shared by cygserver (which requires it via
    __small_vsprintf) and so when built there plain calloc is the
    only choice.  */
-size_t __stdcall
+size_t
 sys_wcstombs_alloc (char **dst_p, int type, const wchar_t *src, size_t nwc)
 {
   size_t ret;
@@ -525,7 +525,7 @@
    conversion.  This is so that fhandler_console can switch to an alternate
    charset, which is the charset returned by GetConsoleCP ().  Most of the
    time this is used for box and line drawing characters. */
-size_t __stdcall
+size_t
 sys_cp_mbstowcs (mbtowc_p f_mbtowc, const char *charset, wchar_t *dst,
 		 size_t dlen, const char *src, size_t nms)
 {
@@ -634,7 +634,7 @@
   return count;
 }
 
-size_t __stdcall
+size_t
 sys_mbstowcs (wchar_t * dst, size_t dlen, const char *src, size_t nms)
 {
   return sys_cp_mbstowcs (cygheap->locale.mbtowc, cygheap->locale.charset,
@@ -642,7 +642,7 @@
 }
 
 /* Same as sys_wcstombs_alloc, just backwards. */
-size_t __stdcall
+size_t
 sys_mbstowcs_alloc (wchar_t **dst_p, int type, const char *src, size_t nms)
 {
   size_t ret;
Index: winsup/cygwin/syscalls.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/syscalls.cc,v
retrieving revision 1.624
diff -u -r1.624 syscalls.cc
--- winsup/cygwin/syscalls.cc	20 Mar 2012 20:39:32 -0000	1.624
+++ winsup/cygwin/syscalls.cc	29 Mar 2012 13:20:34 -0000
@@ -1718,7 +1718,7 @@
 }
 
 /* Cygwin internal */
-int __stdcall
+int
 stat_worker (path_conv &pc, struct __stat64 *buf)
 {
   int res = -1;
Index: winsup/cygwin/tty.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/tty.cc,v
retrieving revision 1.93
diff -u -r1.93 tty.cc
--- winsup/cygwin/tty.cc	30 Dec 2011 20:22:27 -0000	1.93
+++ winsup/cygwin/tty.cc	29 Mar 2012 13:20:34 -0000
@@ -85,7 +85,7 @@
     cygheap->fdtab.get_debugger_info ();
 }
 
-int __stdcall
+int
 tty_list::attach (int n)
 {
   int res;
Index: winsup/cygwin/window.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/window.cc,v
retrieving revision 1.40
diff -u -r1.40 window.cc
--- winsup/cygwin/window.cc	1 May 2011 14:35:12 -0000	1.40
+++ winsup/cygwin/window.cc	29 Mar 2012 13:20:34 -0000
@@ -26,7 +26,7 @@
 
 muto NO_COPY wininfo::_lock;
 
-int __stdcall
+int
 wininfo::process (HWND hwnd, UINT uMsg, WPARAM wParam, LPARAM lParam)
 {
 #ifndef NOSTRACE
@@ -57,7 +57,7 @@
 }
 
 /* Handle windows events.  Inherits ownership of the wininfo lock */
-DWORD WINAPI
+DWORD
 wininfo::winthread ()
 {
   MSG msg;

--------------050906080603020108030107--
