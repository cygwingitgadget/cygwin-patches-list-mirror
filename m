Return-Path: <cygwin-patches-return-7170-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30409 invoked by alias); 9 Feb 2011 20:43:39 -0000
Received: (qmail 30391 invoked by uid 22791); 9 Feb 2011 20:43:35 -0000
X-SWARE-Spam-Status: No, hits=-0.5 required=5.0	tests=AWL,BAYES_40,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,TW_MK,TW_RV,TW_TV,TW_VP,TW_YG,T_TO_NO_BRKTS_FREEMAIL
X-Spam-Check-By: sourceware.org
Received: from mail-vw0-f43.google.com (HELO mail-vw0-f43.google.com) (209.85.212.43)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 09 Feb 2011 20:43:25 +0000
Received: by vws17 with SMTP id 17so372977vws.2        for <cygwin-patches@cygwin.com>; Wed, 09 Feb 2011 12:43:24 -0800 (PST)
MIME-Version: 1.0
Received: by 10.220.99.68 with SMTP id t4mr723947vcn.85.1297284203798; Wed, 09 Feb 2011 12:43:23 -0800 (PST)
Received: by 10.220.162.68 with HTTP; Wed, 9 Feb 2011 12:43:23 -0800 (PST)
Reply-To: jojelino@gmail.com
Date: Wed, 09 Feb 2011 20:43:00 -0000
Message-ID: <AANLkTinBrYcRrRBztY5eKWzon02GtB4t3S5BcLVoA_+D@mail.gmail.com>
Subject: [PATCH] for SIGSEGV, compilation error in gcc 4.6
From: jojelino <jojelino@gmail.com>
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset=UTF-8
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q1/txt/msg00025.txt.bz2

2011-02-10    <?@?>

    * environ.cc (getwinenv,getwinenveq,build_env):Add __attribute__
((regparm (x))) in function definition.
    (pfnenv):Define.
    (findenv_func):Use it.
    (environ_init):Ditto.

    * syscalls.cc (stat_worker):Add __attribute__ ((regparm (x))) in
function definition.

    * window.cc
(wininfo::process,process_window_events,wininfo::winthread):Ditto.

    * strfuncs.cc
(sys_cp_wcstombs,sys_wcstombs,sys_wcstombs_alloc,sys_cp_mbstowcs,sys_mbstowcs,sys_mbstowcs_alloc):Ditto.

    * spawn.cc (find_exec):Ditto.

    * sigproc.cc (pid_exists,proc_subproc,sig_clear,sig_send,checkstate):Ditto.

    * signal.cc (handle_sigprocmask,_pinfo::kill):Ditto.

    * sec_helper.cc (__sec_user):Ditto.

    * pipe.cc (fhandler_pipe::fstatvfs):Ditto.

    * pinfo.cc (_pinfo::exists):Ditto.

    * path.cc (mkrelpath,nofinalslash,hash_path_name):Ditto.

    * ntea.cc (read_ea,write_ea):Ditto.

    * miscfuncs.cc (check_invalid_virtual_addr):Ditto.

    * fhandler_zero.cc (fhandler_dev_zero::read):Ditto.

    * fhandler_windows.cc (fhandler_windows::read):Ditto.

    * fhandler_virtual.cc (fhandler_virtual::(read,fstatvfs)):Ditto.

    * fhandler_tty.cc
(fhandler_tty_slave::(read,fstat,fchmod,fchown),fhandler_pty_master::read):Ditto.

    * fhandler_socket.cc (fhandler_socket::(fstat,fstatvfs)):Ditto.

    * fhandler_raw.cc (fhandler_dev_raw::fstat):Ditto.

    * fhandler_random.cc (fhandler_dev_random::read):Ditto.

    * fhandler_procsys.cc (fhandler_procsys::read):Ditto.

    * fhandler_mem.cc (fhandler_dev_mem::read):Ditto.

    * fhandler_mailslot.cc (fhandler_mailslot::fstat):Ditto.

    * fhandler_fifo.cc (fhandler_fifo::fstatvfs):Ditto.

    * fhandler_dsp.cc (fhandler_dev_dsp::read):Ditto.

    * fhandler_disk_file.cc
(fhandler_base::(fstat_by_nfs_ea,fstat_by_handle,fstat_by_name,fstat_fs,fstat_helper),fhandler_disk_file::(fstat,fstatvfs,fchmod,fchown,facl,pread,pwrite),readdir_get_ino):Ditto.

    * fhandler_console.cc (fhandler_console::read):Ditto.

    * fhandler_clipboard.cc (fhandler_dev_clipboard::read):Ditto.

    * fhandler.cc
(fhandler_base::(read,pread,pwrite,fstat,fstatvfs),fhandler_base_overlapped::read_overlapped):Ditto.

    * exceptions.cc
(rtl_unwind,_cygtls::interrupt_setup,sigpacket::process):Ditto.

    * errno.cc (geterrno_from_win_error,seterrno_from_win_error,seterrno_from_nt_status,seterrno):Ditto.

    * debug.cc (modify_handle,add_handle,close_handle):Ditto.

    * dcrt0.cc (do_exit,cygbench):Ditto.

    * cygheap.cc
(_cmalloc,_crealloc,_cfree,crealloc,crealloc_abort,cfree,cfree_and_set,ccalloc,ccalloc_abort,cwcsdup,cwcsdup1,cstrdup,cstrdup1):Ditto.




Index: winsup/cygwin/cygheap.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/cygheap.cc,v
retrieving revision 1.155
diff -u -r1.155 cygheap.cc
--- winsup/cygwin/cygheap.cc    31 May 2010 18:52:02 -0000    1.155
+++ winsup/cygwin/cygheap.cc    9 Feb 2011 20:19:16 -0000
@@ -178,10 +178,10 @@

 /* Copyright (C) 1997, 2000 DJ Delorie */

-static void *_cmalloc (unsigned size) __attribute ((regparm(1)));
-static void *__stdcall _crealloc (void *ptr, unsigned size)
__attribute ((regparm(2)));
+static void *__stdcall _cmalloc (unsigned size) __attribute__ ((regparm(1)));
+static void *__stdcall _crealloc (void *ptr, unsigned size)
__attribute__ ((regparm(2)));

-static void *__stdcall
+static void *__stdcall __attribute__ ((regparm(1)))
 _cmalloc (unsigned size)
 {
   _cmalloc_entry *rvc;
@@ -215,7 +215,7 @@
   return rvc->data;
 }

-static void __stdcall
+static void __stdcall __attribute__((regparm(1)))
 _cfree (void *ptr)
 {
   cygheap_protect.acquire ();
@@ -226,7 +226,7 @@
   cygheap_protect.release ();
 }

-static void *__stdcall
+static void *__stdcall __attribute__ ((regparm(2)))
 _crealloc (void *ptr, unsigned size)
 {
   void *newptr;
@@ -295,7 +295,7 @@
   return cmalloc (x, n, "cmalloc");
 }

-inline static void *
+inline static void * __stdcall __attribute__ ((regparm(2)))
 crealloc (void *s, DWORD n, const char *fn)
 {
   MALLOC_CHECK;
@@ -309,19 +309,19 @@
   return creturn (t, c, n, fn);
 }

-extern "C" void *__stdcall
+extern "C" void *__stdcall __attribute__ ((regparm(2)))
 crealloc (void *s, DWORD n)
 {
   return crealloc (s, n, NULL);
 }

-extern "C" void *__stdcall
+extern "C" void *__stdcall __attribute__ ((regparm(2)))
 crealloc_abort (void *s, DWORD n)
 {
   return crealloc (s, n, "crealloc");
 }

-extern "C" void __stdcall
+extern "C" void __stdcall __attribute__ ((regparm(1)))
 cfree (void *s)
 {
   assert (!inheap (s));
@@ -329,7 +329,7 @@
   MALLOC_CHECK;
 }

-extern "C" void __stdcall
+extern "C" void __stdcall  __attribute__ ((regparm(2)))
 cfree_and_set (char *&s, char *what)
 {
   if (s && s != almost_null)
@@ -349,19 +349,19 @@
   return creturn (x, c, n, fn);
 }

-extern "C" void *__stdcall
+extern "C" void *__stdcall  __attribute__ ((regparm(3)))
 ccalloc (cygheap_types x, DWORD n, DWORD size)
 {
   return ccalloc (x, n, size, NULL);
 }

-extern "C" void *__stdcall
+extern "C" void *__stdcall  __attribute__ ((regparm(3)))
 ccalloc_abort (cygheap_types x, DWORD n, DWORD size)
 {
   return ccalloc (x, n, size, "ccalloc");
 }

-extern "C" PWCHAR __stdcall
+extern "C" PWCHAR __stdcall __attribute__ ((regparm(1)))
 cwcsdup (const PWCHAR s)
 {
   MALLOC_CHECK;
@@ -373,7 +373,7 @@
   return p;
 }

-extern "C" PWCHAR __stdcall
+extern "C" PWCHAR __stdcall __attribute__ ((regparm(1)))
 cwcsdup1 (const PWCHAR s)
 {
   MALLOC_CHECK;
@@ -385,7 +385,7 @@
   return p;
 }

-extern "C" char *__stdcall
+extern "C" char *__stdcall __attribute__ ((regparm(1)))
 cstrdup (const char *s)
 {
   MALLOC_CHECK;
@@ -397,7 +397,7 @@
   return p;
 }

-extern "C" char *__stdcall
+extern "C" char *__stdcall __attribute__ ((regparm(1)))
 cstrdup1 (const char *s)
 {
   MALLOC_CHECK;
Index: winsup/cygwin/dcrt0.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/dcrt0.cc,v
retrieving revision 1.390
diff -u -r1.390 dcrt0.cc
--- winsup/cygwin/dcrt0.cc    26 Dec 2010 21:11:37 -0000    1.390
+++ winsup/cygwin/dcrt0.cc    9 Feb 2011 20:19:16 -0000
@@ -1034,7 +1034,7 @@
   sig_dispatch_pending (true);
 }

-void __stdcall
+void __stdcall __attribute__ ((regparm (1), noreturn))
 do_exit (int status)
 {
   syscall_printf ("do_exit (%d), exit_state %d", status, exit_state);
@@ -1198,7 +1198,7 @@
 }

 #ifdef DEBUGGING
-void __stdcall
+void __stdcall __attribute__((regparm (1)))
 cygbench (const char *s)
 {
   if (GetEnvironmentVariableA ("CYGWIN_BENCH", NULL, 0))
Index: winsup/cygwin/debug.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/debug.cc,v
retrieving revision 1.63
diff -u -r1.63 debug.cc
--- winsup/cygwin/debug.cc    5 Aug 2009 04:44:27 -0000    1.63
+++ winsup/cygwin/debug.cc    9 Feb 2011 20:19:16 -0000
@@ -103,7 +103,7 @@
   return NULL;
 }

-void __stdcall
+void __stdcall __attribute__ ((regparm (3)))
 modify_handle (const char *func, int ln, HANDLE h, const char *name, bool inh)
 {
   lock_debug here;
@@ -119,7 +119,7 @@
 }

 /* Add a handle to the linked list of known handles. */
-void __stdcall
+void __stdcall __attribute__ ((regparm (3)))
 add_handle (const char *func, int ln, HANDLE h, const char *name, bool inh)
 {
   handle_list *hl;
@@ -213,7 +213,7 @@

 /* Close a known handle.  Complain if !force and closing a known handle or
    if the name of the handle being closed does not match the
registered name. */
-bool __stdcall
+bool __stdcall __attribute__ ((regparm (3)))
 close_handle (const char *func, int ln, HANDLE h, const char *name, bool force)
 {
   bool ret;
Index: winsup/cygwin/environ.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/environ.cc,v
retrieving revision 1.183
diff -u -r1.183 environ.cc
--- winsup/cygwin/environ.cc    18 May 2010 14:30:50 -0000    1.183
+++ winsup/cygwin/environ.cc    9 Feb 2011 20:19:16 -0000
@@ -156,7 +156,7 @@
   to the beginning of the environment variable name.  *in_posix is any
   known posix value for the environment variable. Returns a pointer to
   the appropriate conversion structure.  */
-win_env * __stdcall
+win_env * __stdcall __attribute__ ((regparm (3)))
 getwinenv (const char *env, const char *in_posix, win_env *temp)
 {
   if (!conv_start_chars[(unsigned char)*env])
@@ -219,7 +219,7 @@
   free (src);
   MALLOC_CHECK;
 }
-
+typedef char* (__stdcall *pfnenv)(const char*,int*);
 /* Returns pointer to value associated with name, if any, else NULL.
   Sets offset to be the offset of the name/value combination in the
   environment array, for use by setenv(3) and unsetenv(3).
@@ -253,7 +253,7 @@

 /* Primitive getenv before the environment is built.  */

-static char __stdcall *
+static char* __stdcall
 getearly (const char * name, int *)
 {
   char *ret;
@@ -275,7 +275,7 @@
   return NULL;
 }

-static char * (*findenv_func)(const char *, int *) = (char *
(*)(const char *, int *)) getearly;
+static pfnenv findenv_func = &getearly;

 /* Returns ptr to value associated with name, if any, else NULL.  */

@@ -830,7 +830,7 @@
   FreeEnvironmentStringsW (rawenv);

 out:
-  findenv_func = (char * (*)(const char*, int*)) my_findenv;
+  findenv_func = my_findenv;
   __cygwin_environ = envp;
   update_envptrs ();
   if (envp_passed_in)
@@ -856,7 +856,7 @@
   return strcmp (*p, *q);
 }

-char * __stdcall
+char * __stdcall __attribute__ ((regparm (3)))
 getwinenveq (const char *name, size_t namelen, int x)
 {
   WCHAR name0[namelen - 1];
@@ -956,7 +956,7 @@
    filled with null terminated strings, terminated by double null characters.
    Converts environment variables noted in conv_envvars into win32 form
    prior to placing them in the string.  */
-char ** __stdcall
+char ** __stdcall __attribute__ ((regparm (3)))
 build_env (const char * const *envp, PWCHAR &envblock, int &envc,
        bool no_envblock)
 {
Index: winsup/cygwin/errno.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/errno.cc,v
retrieving revision 1.75
diff -u -r1.75 errno.cc
--- winsup/cygwin/errno.cc    19 Jan 2011 09:15:17 -0000    1.75
+++ winsup/cygwin/errno.cc    9 Feb 2011 20:19:16 -0000
@@ -301,7 +301,7 @@
 int NO_COPY_INIT _sys_nerr = sizeof (_sys_errlist) / sizeof (_sys_errlist[0]);
 };

-int __stdcall
+int __stdcall __attribute__ ((regparm(2)))
 geterrno_from_win_error (DWORD code, int deferrno)
 {
   for (int i = 0; errmap[i].w != 0; ++i)
@@ -318,7 +318,7 @@

 /* seterrno_from_win_error: Given a Windows error code, set errno
    as appropriate. */
-void __stdcall
+void __stdcall __attribute__ ((regparm(3)))
 seterrno_from_win_error (const char *file, int line, DWORD code)
 {
   syscall_printf ("%s:%d windows error %d", file, line, code);
@@ -327,7 +327,7 @@

 /* seterrno_from_nt_status: Given a NT status code, set errno
    as appropriate. */
-void __stdcall
+void __stdcall __attribute__ ((regparm(3)))
 seterrno_from_nt_status (const char *file, int line, NTSTATUS status)
 {
   DWORD code = RtlNtStatusToDosError (status);
@@ -338,7 +338,7 @@
 }

 /* seterrno: Set `errno' based on GetLastError (). */
-void __stdcall
+void __stdcall __attribute__ ((regparm(2)))
 seterrno (const char *file, int line)
 {
   seterrno_from_win_error (file, line, GetLastError ());
Index: winsup/cygwin/exceptions.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/exceptions.cc,v
retrieving revision 1.351
diff -u -r1.351 exceptions.cc
--- winsup/cygwin/exceptions.cc    24 Oct 2010 15:26:05 -0000    1.351
+++ winsup/cygwin/exceptions.cc    9 Feb 2011 20:19:16 -0000
@@ -450,7 +450,7 @@

 extern "C" DWORD __stdcall RtlUnwind (void *, void *, void *, DWORD);
 static void __stdcall rtl_unwind (exception_list *,
PEXCEPTION_RECORD) __attribute__ ((noinline, regparm (3)));
-void __stdcall
+void __stdcall __attribute__ ((noinline, regparm (3)))
 rtl_unwind (exception_list *frame, PEXCEPTION_RECORD e)
 {
   __asm__ ("\n\
@@ -797,7 +797,7 @@
   return interrupted;
 }

-void __stdcall
+void __stdcall __attribute__((regparm(3)))
 _cygtls::interrupt_setup (int sig, void *handler, struct sigaction& siga)
 {
   push ((__stack_t) sigdelayed);
@@ -1154,7 +1154,7 @@
   mask_sync.release ();
 }

-int __stdcall
+int __stdcall __attribute__ ((regparm (1)))
 sigpacket::process ()
 {
   DWORD continue_now;
Index: winsup/cygwin/fhandler.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler.cc,v
retrieving revision 1.373
diff -u -r1.373 fhandler.cc
--- winsup/cygwin/fhandler.cc    1 Feb 2011 08:46:48 -0000    1.373
+++ winsup/cygwin/fhandler.cc    9 Feb 2011 20:19:16 -0000
@@ -644,7 +644,7 @@
    an \n.  If last char is an \r, look ahead one more char, if \n then
    modify \r, if not, remember char.
 */
-void __stdcall
+void __stdcall __attribute__ ((regparm (3)))
 fhandler_base::read (void *in_ptr, size_t& len)
 {
   char *ptr = (char *) in_ptr;
@@ -1006,14 +1006,14 @@
   return res;
 }

-ssize_t __stdcall
+ssize_t __stdcall __attribute__ ((regparm (3)))
 fhandler_base::pread (void *, size_t, _off64_t)
 {
   set_errno (ESPIPE);
   return -1;
 }

-ssize_t __stdcall
+ssize_t __stdcall __attribute__ ((regparm (3)))
 fhandler_base::pwrite (void *, size_t, _off64_t)
 {
   set_errno (ESPIPE);
@@ -1078,7 +1078,7 @@
   return -1;
 }

-int __stdcall
+int __stdcall __attribute__ ((regparm (2)))
 fhandler_base::fstat (struct __stat64 *buf)
 {
   debug_printf ("here");
@@ -1121,7 +1121,7 @@
   return 0;
 }

-int __stdcall
+int __stdcall __attribute__ ((regparm (2)))
 fhandler_base::fstatvfs (struct statvfs *sfs)
 {
   /* If we hit this base implementation, it's some device in /dev.
@@ -1794,7 +1794,7 @@
   return res;
 }

-void __stdcall
+void __stdcall __attribute__ ((regparm (3)))
 fhandler_base_overlapped::read_overlapped (void *ptr, size_t& len)
 {
   DWORD nbytes;
Index: winsup/cygwin/fhandler_clipboard.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_clipboard.cc,v
retrieving revision 1.44
diff -u -r1.44 fhandler_clipboard.cc
--- winsup/cygwin/fhandler_clipboard.cc    24 Jul 2009 20:54:33 -0000    1.44
+++ winsup/cygwin/fhandler_clipboard.cc    9 Feb 2011 20:19:16 -0000
@@ -180,7 +180,7 @@
     }
 }

-void __stdcall
+void __stdcall __attribute__ ((regparm (3)))
 fhandler_dev_clipboard::read (void *ptr, size_t& len)
 {
   HGLOBAL hglb;
Index: winsup/cygwin/fhandler_console.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_console.cc,v
retrieving revision 1.222
diff -u -r1.222 fhandler_console.cc
--- winsup/cygwin/fhandler_console.cc    7 Feb 2011 11:18:19 -0000    1.222
+++ winsup/cygwin/fhandler_console.cc    9 Feb 2011 20:19:16 -0000
@@ -249,7 +249,7 @@
              || dev_state->use_mouse >= 3));
 }

-void __stdcall
+void __stdcall __attribute__ ((regparm (3)))
 fhandler_console::read (void *pv, size_t& buflen)
 {
   HANDLE h = get_io_handle ();
Index: winsup/cygwin/fhandler_disk_file.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_disk_file.cc,v
retrieving revision 1.348
diff -u -r1.348 fhandler_disk_file.cc
--- winsup/cygwin/fhandler_disk_file.cc    26 Jan 2011 10:55:13 -0000    1.348
+++ winsup/cygwin/fhandler_disk_file.cc    9 Feb 2011 20:19:17 -0000
@@ -290,7 +290,7 @@
    This returns the content of a struct fattr3 as defined in RFC 1813.
    The content is the NFS equivalent of struct stat. so there's not much
    to do here except for copying. */
-int __stdcall
+int __stdcall __attribute__ ((regparm (2)))
 fhandler_base::fstat_by_nfs_ea (struct __stat64 *buf)
 {
   fattr3 *nfs_attr = pc.nfsattr ();
@@ -330,7 +330,7 @@
   return 0;
 }

-int __stdcall
+int __stdcall __attribute__ ((regparm (2)))
 fhandler_base::fstat_by_handle (struct __stat64 *buf)
 {
   /* Don't use FileAllInformation info class.  It returns a pathname rather
@@ -389,7 +389,7 @@
   return fstat_helper (buf, fsi.NumberOfLinks);
 }

-int __stdcall
+int __stdcall __attribute__ ((regparm (2)))
 fhandler_base::fstat_by_name (struct __stat64 *buf)
 {
   NTSTATUS status;
@@ -434,7 +434,7 @@
   return fstat_helper (buf, 1);
 }

-int __stdcall
+int __stdcall __attribute__ ((regparm (2)))
 fhandler_base::fstat_fs (struct __stat64 *buf)
 {
   int res = -1;
@@ -478,7 +478,7 @@
   return res;
 }

-int __stdcall
+int __stdcall __attribute__ ((regparm (3)))
 fhandler_base::fstat_helper (struct __stat64 *buf,
                  DWORD nNumberOfLinks)
 {
@@ -667,13 +667,13 @@
   return 0;
 }

-int __stdcall
+int __stdcall __attribute__ ((regparm (2)))
 fhandler_disk_file::fstat (struct __stat64 *buf)
 {
   return fstat_fs (buf);
 }

-int __stdcall
+int __stdcall __attribute__ ((regparm (2)))
 fhandler_disk_file::fstatvfs (struct statvfs *sfs)
 {
   int ret = -1, opened = 0;
@@ -765,7 +765,7 @@
   return ret;
 }

-int __stdcall
+int __stdcall __attribute__ ((regparm (1)))
 fhandler_disk_file::fchmod (mode_t mode)
 {
   extern int chmod_device (path_conv& pc, mode_t mode);
@@ -873,7 +873,7 @@
   return res;
 }

-int __stdcall
+int __stdcall __attribute__ ((regparm (2)))
 fhandler_disk_file::fchown (__uid32_t uid, __gid32_t gid)
 {
   int oret = 0;
@@ -940,7 +940,7 @@
   return res;
 }

-int _stdcall
+int _stdcall __attribute__ ((regparm (3)))
 fhandler_disk_file::facl (int cmd, int nentries, __aclent32_t *aclbufp)
 {
   int res = -1;
@@ -1412,7 +1412,7 @@
   return res;
 }

-ssize_t __stdcall
+ssize_t __stdcall __attribute__ ((regparm (3)))
 fhandler_disk_file::pread (void *buf, size_t count, _off64_t offset)
 {
   ssize_t res;
@@ -1432,7 +1432,7 @@
   return res;
 }

-ssize_t __stdcall
+ssize_t __stdcall __attribute__ ((regparm (3)))
 fhandler_disk_file::pwrite (void *buf, size_t count, _off64_t offset)
 {
   int res;
@@ -1710,7 +1710,7 @@
   return res;
 }

-__ino64_t __stdcall
+__ino64_t __stdcall __attribute__ ((regparm (2)))
 readdir_get_ino (const char *path, bool dot_dot)
 {
   char *fname;
Index: winsup/cygwin/fhandler_dsp.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_dsp.cc,v
retrieving revision 1.52
diff -u -r1.52 fhandler_dsp.cc
--- winsup/cygwin/fhandler_dsp.cc    24 Jul 2009 20:54:33 -0000    1.52
+++ winsup/cygwin/fhandler_dsp.cc    9 Feb 2011 20:19:17 -0000
@@ -1040,7 +1040,7 @@
   return len;
 }

-void __stdcall
+void __stdcall __attribute__ ((regparm (3)))
 fhandler_dev_dsp::read (void *ptr, size_t& len)
 {
   debug_printf ("ptr=%08x len=%d", ptr, len);
Index: winsup/cygwin/fhandler_fifo.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_fifo.cc,v
retrieving revision 1.43
diff -u -r1.43 fhandler_fifo.cc
--- winsup/cygwin/fhandler_fifo.cc    6 Apr 2010 15:09:44 -0000    1.43
+++ winsup/cygwin/fhandler_fifo.cc    9 Feb 2011 20:19:17 -0000
@@ -281,7 +281,7 @@
   return wait (true) ? write_overlapped (ptr, len) : -1;
 }

-int __stdcall
+int __stdcall __attribute__ ((regparm (2)))
 fhandler_fifo::fstatvfs (struct statvfs *sfs)
 {
   fhandler_disk_file fh (pc);
Index: winsup/cygwin/fhandler_mailslot.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_mailslot.cc,v
retrieving revision 1.12
diff -u -r1.12 fhandler_mailslot.cc
--- winsup/cygwin/fhandler_mailslot.cc    14 Jan 2010 18:46:01 -0000    1.12
+++ winsup/cygwin/fhandler_mailslot.cc    9 Feb 2011 20:19:17 -0000
@@ -25,7 +25,7 @@
 {
 }

-int __stdcall
+int __stdcall __attribute__ ((regparm (2)))
 fhandler_mailslot::fstat (struct __stat64 *buf)
 {
   debug_printf ("here");
Index: winsup/cygwin/fhandler_mem.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_mem.cc,v
retrieving revision 1.56
diff -u -r1.56 fhandler_mem.cc
--- winsup/cygwin/fhandler_mem.cc    14 Jan 2010 18:46:01 -0000    1.56
+++ winsup/cygwin/fhandler_mem.cc    9 Feb 2011 20:19:17 -0000
@@ -162,7 +162,7 @@
   return ulen;
 }

-void __stdcall
+void __stdcall __attribute__ ((regparm (3)))
 fhandler_dev_mem::read (void *ptr, size_t& ulen)
 {
   if (!ulen || pos >= mem_size)
Index: winsup/cygwin/fhandler_procsys.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_procsys.cc,v
retrieving revision 1.4
diff -u -r1.4 fhandler_procsys.cc
--- winsup/cygwin/fhandler_procsys.cc    2 Oct 2010 08:44:08 -0000    1.4
+++ winsup/cygwin/fhandler_procsys.cc    9 Feb 2011 20:19:17 -0000
@@ -315,7 +315,7 @@
   return fhandler_virtual::closedir (dir);
 }

-void __stdcall
+void __stdcall __attribute__ ((regparm (3)))
 fhandler_procsys::read (void *ptr, size_t& len)
 {
   NTSTATUS status;
Index: winsup/cygwin/fhandler_random.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_random.cc,v
retrieving revision 1.40
diff -u -r1.40 fhandler_random.cc
--- winsup/cygwin/fhandler_random.cc    30 Oct 2009 10:53:54 -0000    1.40
+++ winsup/cygwin/fhandler_random.cc    9 Feb 2011 20:19:17 -0000
@@ -111,7 +111,7 @@
   return len;
 }

-void __stdcall
+void __stdcall __attribute__ ((regparm (3)))
 fhandler_dev_random::read (void *ptr, size_t& len)
 {
   if (!len)
Index: winsup/cygwin/fhandler_raw.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_raw.cc,v
retrieving revision 1.70
diff -u -r1.70 fhandler_raw.cc
--- winsup/cygwin/fhandler_raw.cc    3 Jan 2009 05:12:20 -0000    1.70
+++ winsup/cygwin/fhandler_raw.cc    9 Feb 2011 20:19:17 -0000
@@ -32,7 +32,7 @@
     delete [] devbuf;
 }

-int __stdcall
+int __stdcall __attribute__ ((regparm (2)))
 fhandler_dev_raw::fstat (struct __stat64 *buf)
 {
   debug_printf ("here");
Index: winsup/cygwin/fhandler_socket.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_socket.cc,v
retrieving revision 1.266
diff -u -r1.266 fhandler_socket.cc
--- winsup/cygwin/fhandler_socket.cc    31 Jan 2011 08:53:57 -0000    1.266
+++ winsup/cygwin/fhandler_socket.cc    9 Feb 2011 20:19:17 -0000
@@ -783,7 +783,7 @@
   return -1;
 }

-int __stdcall
+int __stdcall __attribute__ ((regparm (2)))
 fhandler_socket::fstat (struct __stat64 *buf)
 {
   int res;
@@ -810,7 +810,7 @@
   return res;
 }

-int __stdcall
+int __stdcall __attribute__ ((regparm (2)))
 fhandler_socket::fstatvfs (struct statvfs *sfs)
 {
   if (get_device () == FH_UNIX)
Index: winsup/cygwin/fhandler_tty.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_tty.cc,v
retrieving revision 1.216
diff -u -r1.216 fhandler_tty.cc
--- winsup/cygwin/fhandler_tty.cc    29 Nov 2010 20:51:38 -0000    1.216
+++ winsup/cygwin/fhandler_tty.cc    9 Feb 2011 20:19:17 -0000
@@ -790,7 +790,7 @@
   return towrite;
 }

-void __stdcall
+void __stdcall __attribute__ ((regparm (3)))
 fhandler_tty_slave::read (void *ptr, size_t& len)
 {
   int totalread = 0;
@@ -1183,7 +1183,7 @@
   return retval;
 }

-int __stdcall
+int __stdcall __attribute__ ((regparm (2)))
 fhandler_tty_slave::fstat (struct __stat64 *st)
 {
   fhandler_base::fstat (st);
@@ -1289,7 +1289,7 @@
   close_maybe (inuse);
 }

-int __stdcall
+int __stdcall __attribute__ ((regparm (1)))
 fhandler_tty_slave::fchmod (mode_t mode)
 {
   int ret = -1;
@@ -1315,7 +1315,7 @@
   return ret;
 }

-int __stdcall
+int __stdcall __attribute__ ((regparm (2)))
 fhandler_tty_slave::fchown (__uid32_t uid, __gid32_t gid)
 {
   int ret = -1;
@@ -1496,7 +1496,7 @@
   return i;
 }

-void __stdcall
+void __stdcall __attribute__ ((regparm (3)))
 fhandler_pty_master::read (void *ptr, size_t& len)
 {
   len = (size_t) process_slave_output ((char *) ptr, len, pktmode);
Index: winsup/cygwin/fhandler_virtual.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_virtual.cc,v
retrieving revision 1.53
diff -u -r1.53 fhandler_virtual.cc
--- winsup/cygwin/fhandler_virtual.cc    6 Sep 2010 09:47:01 -0000    1.53
+++ winsup/cygwin/fhandler_virtual.cc    9 Feb 2011 20:19:17 -0000
@@ -181,7 +181,7 @@
   return 0;
 }

-void __stdcall
+void __stdcall __attribute__ ((regparm (3)))
 fhandler_virtual::read (void *ptr, size_t& len)
 {
   if (len == 0)
@@ -266,7 +266,7 @@
   return res;
 }

-int __stdcall
+int __stdcall __attribute__ ((regparm (2)))
 fhandler_virtual::fstatvfs (struct statvfs *sfs)
 {
   /* Virtual file system.  Just return an empty buffer with a few values
Index: winsup/cygwin/fhandler_windows.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_windows.cc,v
retrieving revision 1.30
diff -u -r1.30 fhandler_windows.cc
--- winsup/cygwin/fhandler_windows.cc    24 Jul 2009 20:54:33 -0000    1.30
+++ winsup/cygwin/fhandler_windows.cc    9 Feb 2011 20:19:17 -0000
@@ -79,7 +79,7 @@
     return SendMessage (ptr->hwnd, ptr->message, ptr->wParam, ptr->lParam);
 }

-void __stdcall
+void __stdcall __attribute__ ((regparm (3)))
 fhandler_windows::read (void *buf, size_t& len)
 {
   MSG *ptr = (MSG *) buf;
Index: winsup/cygwin/fhandler_zero.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_zero.cc,v
retrieving revision 1.31
diff -u -r1.31 fhandler_zero.cc
--- winsup/cygwin/fhandler_zero.cc    24 Jul 2009 20:54:33 -0000    1.31
+++ winsup/cygwin/fhandler_zero.cc    9 Feb 2011 20:19:17 -0000
@@ -41,7 +41,7 @@
   return len;
 }

-void __stdcall
+void __stdcall __attribute__ ((regparm (3)))
 fhandler_dev_zero::read (void *ptr, size_t& len)
 {
   memset (ptr, 0, len);
Index: winsup/cygwin/miscfuncs.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/miscfuncs.cc,v
retrieving revision 1.58
diff -u -r1.58 miscfuncs.cc
--- winsup/cygwin/miscfuncs.cc    12 Mar 2010 23:13:47 -0000    1.58
+++ winsup/cygwin/miscfuncs.cc    9 Feb 2011 20:19:17 -0000
@@ -169,7 +169,7 @@
   return string;
 }

-int __stdcall
+int __stdcall __attribute__ ((regparm (2)))
 check_invalid_virtual_addr (const void *s, unsigned sz)
 {
   MEMORY_BASIC_INFORMATION mbuf;
Index: winsup/cygwin/ntea.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/ntea.cc,v
retrieving revision 1.23
diff -u -r1.23 ntea.cc
--- winsup/cygwin/ntea.cc    12 Jan 2010 10:14:59 -0000    1.23
+++ winsup/cygwin/ntea.cc    9 Feb 2011 20:19:17 -0000
@@ -29,7 +29,7 @@
 #define NEXT_FEA(p) ((PFILE_FULL_EA_INFORMATION) (p->NextEntryOffset \
              ? (char *) p + p->NextEntryOffset : NULL))

-ssize_t __stdcall
+ssize_t __stdcall __attribute__ ((regparm (3)))
 read_ea (HANDLE hdl, path_conv &pc, const char *name, char *value, size_t size)
 {
   OBJECT_ATTRIBUTES attr;
@@ -197,7 +197,7 @@
   return ret;
 }

-int __stdcall
+int __stdcall __attribute__ ((regparm (3)))
 write_ea (HANDLE hdl, path_conv &pc, const char *name, const char *value,
       size_t size, int flags)
 {
Index: winsup/cygwin/path.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/path.cc,v
retrieving revision 1.622
diff -u -r1.622 path.cc
--- winsup/cygwin/path.cc    2 Feb 2011 09:59:10 -0000    1.622
+++ winsup/cygwin/path.cc    9 Feb 2011 20:19:17 -0000
@@ -351,7 +351,7 @@
 static void __stdcall mkrelpath (char *dst, bool caseinsensitive)
   __attribute__ ((regparm (2)));

-static void __stdcall
+static void __stdcall __attribute__ ((regparm (2)))
 mkrelpath (char *path, bool caseinsensitive)
 {
   tmp_pathbuf tp;
@@ -1306,7 +1306,7 @@
 /* nofinalslash: Remove trailing / and \ from SRC (except for the
    first one).  It is ok for src == dst.  */

-void __stdcall
+void __stdcall __attribute__ ((regparm (2)))
 nofinalslash (const char *src, char *dst)
 {
   int len = strlen (src);
@@ -2774,7 +2774,7 @@
    done during the opendir call and the hash or the filename within
    the directory.  FIXME: Not bullet-proof. */
 /* Cygwin internal */
-__ino64_t __stdcall
+__ino64_t __stdcall __attribute__ ((regparm (2)))
 hash_path_name (__ino64_t hash, PUNICODE_STRING name)
 {
   if (name->Length == 0)
@@ -2788,7 +2788,7 @@
   return hash;
 }

-__ino64_t __stdcall
+__ino64_t __stdcall __attribute__ ((regparm (2)))
 hash_path_name (__ino64_t hash, PCWSTR name)
 {
   UNICODE_STRING uname;
@@ -2796,7 +2796,7 @@
   return hash_path_name (hash, &uname);
 }

-__ino64_t __stdcall
+__ino64_t __stdcall __attribute__ ((regparm (2)))
 hash_path_name (__ino64_t hash, const char *name)
 {
   UNICODE_STRING uname;
Index: winsup/cygwin/pinfo.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/pinfo.cc,v
retrieving revision 1.266
diff -u -r1.266 pinfo.cc
--- winsup/cygwin/pinfo.cc    12 Dec 2010 05:48:29 -0000    1.266
+++ winsup/cygwin/pinfo.cc    9 Feb 2011 20:19:17 -0000
@@ -424,7 +424,7 @@

 /* Test to determine if a process really exists and is processing signals.
  */
-bool __stdcall
+bool __stdcall __attribute__ ((regparm (1)))
 _pinfo::exists ()
 {
   return this && !(process_state & PID_EXITED);
Index: winsup/cygwin/pipe.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/pipe.cc,v
retrieving revision 1.125
diff -u -r1.125 pipe.cc
--- winsup/cygwin/pipe.cc    14 Aug 2010 11:16:09 -0000    1.125
+++ winsup/cygwin/pipe.cc    9 Feb 2011 20:19:17 -0000
@@ -366,7 +366,7 @@
   return 0;
 }

-int __stdcall
+int __stdcall __attribute__ ((regparm (2)))
 fhandler_pipe::fstatvfs (struct statvfs *sfs)
 {
   set_errno (EBADF);
Index: winsup/cygwin/sec_helper.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/sec_helper.cc,v
retrieving revision 1.88
diff -u -r1.88 sec_helper.cc
--- winsup/cygwin/sec_helper.cc    17 Apr 2010 15:51:09 -0000    1.88
+++ winsup/cygwin/sec_helper.cc    9 Feb 2011 20:19:18 -0000
@@ -519,7 +519,7 @@
   return true;
 }

-PSECURITY_ATTRIBUTES __stdcall
+PSECURITY_ATTRIBUTES __stdcall __attribute__ ((regparm (3)))
 __sec_user (PVOID sa_buf, PSID sid1, PSID sid2, DWORD access2, BOOL inherit)
 {
   PSECURITY_ATTRIBUTES psa = (PSECURITY_ATTRIBUTES) sa_buf;
Index: winsup/cygwin/signal.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/signal.cc,v
retrieving revision 1.91
diff -u -r1.91 signal.cc
--- winsup/cygwin/signal.cc    20 Sep 2010 22:28:57 -0000    1.91
+++ winsup/cygwin/signal.cc    9 Feb 2011 20:19:18 -0000
@@ -177,7 +177,7 @@
   return handle_sigprocmask (how, set, oldset, _my_tls.sigmask);
 }

-int __stdcall
+int __stdcall __attribute__ ((regparm (3)))
 handle_sigprocmask (int how, const sigset_t *set, sigset_t *oldset,
sigset_t& opmask)
 {
   /* check that how is in right range */
@@ -218,7 +218,7 @@
   return 0;
 }

-int __stdcall
+int __stdcall __attribute__ ((regparm (2)))
 _pinfo::kill (siginfo_t& si)
 {
   sig_dispatch_pending ();
Index: winsup/cygwin/sigproc.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/sigproc.cc,v
retrieving revision 1.331
diff -u -r1.331 sigproc.cc
--- winsup/cygwin/sigproc.cc    12 Sep 2010 19:13:09 -0000    1.331
+++ winsup/cygwin/sigproc.cc    9 Feb 2011 20:19:18 -0000
@@ -168,7 +168,7 @@
   return false;
 }

-bool __stdcall
+bool __stdcall __attribute__ ((regparm (1)))
 pid_exists (pid_t pid)
 {
   return pinfo (pid)->exists ();
@@ -186,7 +186,7 @@

 /* Handle all subprocess requests
  */
-int __stdcall
+int __stdcall __attribute__ ((regparm (2)))
 proc_subproc (DWORD what, DWORD val)
 {
   int rc = 1;
@@ -390,7 +390,7 @@
 }

 /* Clear pending signal */
-void __stdcall
+void __stdcall __attribute__ ((regparm (1)))
 sig_clear (int target_sig)
 {
   if (&_my_tls != _sig_tls)
@@ -486,7 +486,7 @@
     }
 }

-int __stdcall
+int __stdcall __attribute__ ((regparm (2)))
 sig_send (_pinfo *p, int sig)
 {
   if (sig == __SIGHOLD)
@@ -518,7 +518,7 @@
    If pinfo *p == NULL, send to the current process.
    If sending to this process, wait for notification that a signal has
    completed before returning.  */
-int __stdcall
+int __stdcall __attribute__ ((regparm (3)))
 sig_send (_pinfo *p, siginfo_t& si, _cygtls *tls)
 {
   int rc = 1;
@@ -940,7 +940,7 @@
 /* Check the state of all of our children to see if any are stopped or
  * terminated.
  */
-static int __stdcall
+static int __stdcall __attribute__ ((regparm (1)))
 checkstate (waitq *parent_w)
 {
   int potential_match = 0;
Index: winsup/cygwin/spawn.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/spawn.cc,v
retrieving revision 1.299
diff -u -r1.299 spawn.cc
--- winsup/cygwin/spawn.cc    20 Jan 2011 11:09:21 -0000    1.299
+++ winsup/cygwin/spawn.cc    9 Feb 2011 20:19:18 -0000
@@ -101,7 +101,7 @@
    of name is placed in buf and returned.  Otherwise the contents of buf
    is undefined and NULL is returned.  */

-const char * __stdcall
+const char * __stdcall __attribute__ ((regparm (3)))
 find_exec (const char *name, path_conv& buf, const char *mywinenv,
        unsigned opt, const char **known_suffix)
 {
Index: winsup/cygwin/strfuncs.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/strfuncs.cc,v
retrieving revision 1.45
diff -u -r1.45 strfuncs.cc
--- winsup/cygwin/strfuncs.cc    19 Jan 2011 09:41:54 -0000    1.45
+++ winsup/cygwin/strfuncs.cc    9 Feb 2011 20:19:18 -0000
@@ -395,7 +395,7 @@
    - The functions always create 0-terminated results, no matter what.
      If the result is truncated due to buffer size, it's a bug in Cygwin
      and the buffer in the calling function should be raised. */
-size_t __stdcall
+size_t __stdcall __attribute__ ((regparm (3)))
 sys_cp_wcstombs (wctomb_p f_wctomb, const char *charset, char *dst, size_t len,
          const wchar_t *src, size_t nwc)
 {
@@ -481,7 +481,7 @@
   return n;
 }

-size_t __stdcall
+size_t __stdcall __attribute__ ((regparm (3)))
 sys_wcstombs (char *dst, size_t len, const wchar_t * src, size_t nwc)
 {
   return sys_cp_wcstombs (cygheap->locale.wctomb, cygheap->locale.charset,
@@ -498,7 +498,7 @@
    Note that this code is shared by cygserver (which requires it via
    __small_vsprintf) and so when built there plain calloc is the
    only choice.  */
-size_t __stdcall
+size_t __stdcall __attribute__ ((regparm (3)))
 sys_wcstombs_alloc (char **dst_p, int type, const wchar_t *src, size_t nwc)
 {
   size_t ret;
@@ -524,7 +524,7 @@
    conversion.  This is so that fhandler_console can switch to an alternate
    charset, which is the charset returned by GetConsoleCP ().  Most of the
    time this is used for box and line drawing characters. */
-size_t __stdcall
+size_t __stdcall __attribute__ ((regparm (3)))
 sys_cp_mbstowcs (mbtowc_p f_mbtowc, const char *charset, wchar_t *dst,
          size_t dlen, const char *src, size_t nms)
 {
@@ -633,7 +633,7 @@
   return count;
 }

-size_t __stdcall
+size_t __stdcall __attribute__ ((regparm (3)))
 sys_mbstowcs (wchar_t * dst, size_t dlen, const char *src, size_t nms)
 {
   return sys_cp_mbstowcs (cygheap->locale.mbtowc, cygheap->locale.charset,
@@ -641,7 +641,7 @@
 }

 /* Same as sys_wcstombs_alloc, just backwards. */
-size_t __stdcall
+size_t __stdcall __attribute__ ((regparm (3)))
 sys_mbstowcs_alloc (wchar_t **dst_p, int type, const char *src, size_t nms)
 {
   size_t ret;
Index: winsup/cygwin/syscalls.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/syscalls.cc,v
retrieving revision 1.573
diff -u -r1.573 syscalls.cc
--- winsup/cygwin/syscalls.cc    31 Jan 2011 13:58:59 -0000    1.573
+++ winsup/cygwin/syscalls.cc    9 Feb 2011 20:19:18 -0000
@@ -1569,7 +1569,7 @@
 }

 /* Cygwin internal */
-int __stdcall
+int __stdcall __attribute__ ((regparm (2)))
 stat_worker (path_conv &pc, struct __stat64 *buf)
 {
   int res = -1;
Index: winsup/cygwin/window.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/window.cc,v
retrieving revision 1.39
diff -u -r1.39 window.cc
--- winsup/cygwin/window.cc    1 Sep 2010 18:24:11 -0000    1.39
+++ winsup/cygwin/window.cc    9 Feb 2011 20:19:18 -0000
@@ -25,7 +25,7 @@

 muto NO_COPY wininfo::_lock;

-int __stdcall
+int __stdcall __attribute__ ((regparm (3)))
 wininfo::process (HWND hwnd, UINT uMsg, WPARAM wParam, LPARAM lParam)
 {
 #ifndef NOSTRACE
@@ -49,14 +49,14 @@
     }
 }

-static LRESULT CALLBACK
+static LRESULT CALLBACK __attribute__ ((regparm (3)))
 process_window_events (HWND hwnd, UINT uMsg, WPARAM wParam, LPARAM lParam)
 {
   return winmsg.process (hwnd, uMsg, wParam, lParam);
 }

 /* Handle windows events.  Inherits ownership of the wininfo lock */
-DWORD WINAPI
+DWORD WINAPI __attribute__ ((regparm (1)))
 wininfo::winthread ()
 {
   MSG msg;
