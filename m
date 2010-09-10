Return-Path: <cygwin-patches-return-7092-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26224 invoked by alias); 10 Sep 2010 20:31:27 -0000
Received: (qmail 26208 invoked by uid 22791); 10 Sep 2010 20:31:23 -0000
X-SWARE-Spam-Status: No, hits=-0.9 required=5.0	tests=AWL,BAYES_05,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,TW_CP,TW_MX,TW_NW,TW_XC,T_TO_NO_BRKTS_FREEMAIL
X-Spam-Check-By: sourceware.org
Received: from mail-wy0-f171.google.com (HELO mail-wy0-f171.google.com) (74.125.82.171)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 10 Sep 2010 20:31:12 +0000
Received: by wyb29 with SMTP id 29so3495436wyb.2        for <cygwin-patches@cygwin.com>; Fri, 10 Sep 2010 13:31:09 -0700 (PDT)
Received: by 10.227.39.199 with SMTP id h7mr239912wbe.174.1284150669264;        Fri, 10 Sep 2010 13:31:09 -0700 (PDT)
Received: from [192.168.2.99] (cpc2-cmbg8-0-0-cust61.5-4.cable.virginmedia.com [82.6.108.62])        by mx.google.com with ESMTPS id b10sm1274910wer.41.2010.09.10.13.31.07        (version=SSLv3 cipher=RC4-MD5);        Fri, 10 Sep 2010 13:31:08 -0700 (PDT)
Message-ID: <4C8A9AC8.7070904@gmail.com>
Date: Fri, 10 Sep 2010 20:31:00 -0000
From: Dave Korn <dave.korn.cygwin@gmail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [PATCH] Add fenv.h and support.
Content-Type: multipart/mixed; boundary="------------030000040905090208040507"
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
X-SW-Source: 2010-q3/txt/msg00052.txt.bz2

This is a multi-part message in MIME format.
--------------030000040905090208040507
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 1842



    Hi folks,

  This patch adds fenv.h and the related support routines in the Cygwin DLL.
It's an entirely unencumbered implementation that I wrote from scratch using
only the public docs for reference.  We've been missing this for a while, what
with PR323 and all, and if we add it in we'll be able to switch on the new
decimal-floating-point features in the compiler.  (Amongst I'm sure many other
uses).

winsup/cygwin/ChangeLog:

	* Makefile.in (DLL_OFILES): Add new fenv.o module.
	(fenv_CFLAGS): New flags definition for fenv.o compile.
	* autoload.cc (std_dll_init): Use fenv.h functions instead of direct
	manipulation of x87 FPU registers.
	* crt0.c (mainCRTStartup): Likewise.
	* cygwin.din (feclearexcept, fegetexceptflag, feraiseexcept,
	fesetexceptflag, fetestexcept, fegetround, fesetround, fegetenv,
	feholdexcept, fesetenv, feupdateenv, fegetprec, fesetprec,
	feenableexcept, fedisableexcept, fegetexcept, _feinitialise,
	_fe_dfl_env, _fe_nomask_env): Export new functions and data items.
	* fenv.cc: New file.
	* posix.sgml: Update status of newly-implemented APIs.
	* include/fenv.h: Likewise related header.
	* include/cygwin/version.h (CYGWIN_VERSION_API_MINOR): Bump.

  Testing: well, I'm running the GCC testsuite against it to verify it builds
functioning decimal floating point code, and I've manually tested some of the
simple functionality like setting the exceptions on and off.  That's all so
far, but I think it's close enough (and given that it's new functionality) to
check in and fix any bugs that crop up on HEAD.  (I'd like to also see if I
can run some of the LSB or Posix verification testsuites against it, but I
don't know what's involved in that yet; if anyone has any experience with any
of that stuff, I'd appreciate being dropped a note off-list with a few pointers.)

    cheers,
      DaveK



--------------030000040905090208040507
Content-Type: text/x-c;
 name="fenv-support.diff"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
 filename="fenv-support.diff"
Content-length: 28130

Index: winsup/cygwin/Makefile.in
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/Makefile.in,v
retrieving revision 1.238
diff -p -u -r1.238 Makefile.in
--- winsup/cygwin/Makefile.in	6 Sep 2010 09:47:00 -0000	1.238
+++ winsup/cygwin/Makefile.in	10 Sep 2010 07:07:03 -0000
@@ -137,7 +137,7 @@ MT_SAFE_OBJECTS:=
 #
 DLL_OFILES:=assert.o autoload.o bsdlib.o ctype.o cxx.o cygheap.o cygthread.o \
 	cygtls.o cygxdr.o dcrt0.o debug.o devices.o dir.o dlfcn.o dll_init.o \
-	dtable.o environ.o errno.o exceptions.o exec.o external.o fcntl.o \
+	dtable.o environ.o errno.o exceptions.o exec.o external.o fcntl.o fenv.o \
 	fhandler.o fhandler_clipboard.o fhandler_console.o fhandler_disk_file.o \
 	fhandler_dsp.o fhandler_fifo.o fhandler_floppy.o fhandler_mailslot.o \
 	fhandler_mem.o fhandler_netdrive.o fhandler_nodevice.o fhandler_proc.o \
@@ -244,6 +244,7 @@ dlfcn_CFLAGS:=-fomit-frame-pointer
 dll_init_CFLAGS:=-fomit-frame-pointer
 dtable_CFLAGS:=-fomit-frame-pointer -fcheck-new
 fcntl_CFLAGS:=-fomit-frame-pointer
+fenv_CFLAGS:=-fomit-frame-pointer
 fhandler_CFLAGS:=-fomit-frame-pointer
 fhandler_clipboard_CFLAGS:=-fomit-frame-pointer
 fhandler_console_CFLAGS:=-fomit-frame-pointer
Index: winsup/cygwin/autoload.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/autoload.cc,v
retrieving revision 1.172
diff -p -u -r1.172 autoload.cc
--- winsup/cygwin/autoload.cc	30 Aug 2010 10:39:43 -0000	1.172
+++ winsup/cygwin/autoload.cc	10 Sep 2010 07:07:03 -0000
@@ -11,6 +11,7 @@ details. */
 
 #include "winsup.h"
 #include "miscfuncs.h"
+#include "fenv.h"
 #define USE_SYS_TYPES_FD_SET
 #include <winsock2.h>
 
@@ -222,13 +223,13 @@ std_dll_init ()
     while (InterlockedIncrement (&dll->here));
   else if (!dll->handle)
     {
-      unsigned fpu_control = 0;
-      __asm__ __volatile__ ("fnstcw %0": "=m" (fpu_control));
+      fenv_t fpuenv;
+      fegetenv (&fpuenv);
       /* http://www.microsoft.com/technet/security/advisory/2269637.mspx */
       wcpcpy (wcpcpy (dll_path, windows_system_directory), dll->name);
       if ((h = LoadLibraryW (dll_path)) != NULL)
 	{
-	  __asm__ __volatile__ ("fldcw %0": : "m" (fpu_control));
+	  fesetenv (&fpuenv);
 	  dll->handle = h;
 	}
       else if (!(func->decoration & 1))
Index: winsup/cygwin/crt0.c
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/crt0.c,v
retrieving revision 1.5
diff -p -u -r1.5 crt0.c
--- winsup/cygwin/crt0.c	30 Aug 2010 01:57:36 -0000	1.5
+++ winsup/cygwin/crt0.c	10 Sep 2010 07:07:03 -0000
@@ -13,11 +13,7 @@ details. */
 
 #include "winlean.h"
 #include <sys/cygwin.h>
-#ifdef __i386__
-#define FPU_RESERVED 0xF0C0
-#define FPU_DEFAULT  0x033f
-
-#endif
+#include "fenv.h"
 
 extern int main (int argc, char **argv);
 
@@ -29,19 +25,7 @@ mainCRTStartup ()
 #ifdef __i386__
   (void)__builtin_return_address(1);
   asm volatile ("andl $-16,%%esp" ::: "%esp");
-  {
-    volatile unsigned short cw;
-
-    /* Get Control Word */
-    __asm__ volatile ("fnstcw %0" : "=m" (cw) : );
-
-    /* mask in */
-    cw &= FPU_RESERVED;
-    cw |= FPU_DEFAULT;
-
-    /* set cw */
-    __asm__ volatile ("fldcw %0" :: "m" (cw));
-  }
+  _feinitialise ();
 #endif
 
   cygwin_crt0 (main);
Index: winsup/cygwin/cygwin.din
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/cygwin.din,v
retrieving revision 1.224
diff -p -u -r1.224 cygwin.din
--- winsup/cygwin/cygwin.din	19 Jul 2010 18:22:40 -0000	1.224
+++ winsup/cygwin/cygwin.din	10 Sep 2010 07:07:03 -0000
@@ -1881,3 +1881,22 @@ __wrap__Znaj NOSIGFE                # vo
 __wrap__ZnajRKSt9nothrow_t NOSIGFE  # void *operator new[](std::size_t sz, const std::nothrow_t &nt) throw()
 __wrap__Znwj NOSIGFE                # void *operator new(std::size_t sz) throw (std::bad_alloc)
 __wrap__ZnwjRKSt9nothrow_t NOSIGFE  # void *operator new(std::size_t sz, const std::nothrow_t &nt) throw()
+feclearexcept NOSIGFE
+fegetexceptflag NOSIGFE
+feraiseexcept SIGFE
+fesetexceptflag SIGFE
+fetestexcept NOSIGFE
+fegetround NOSIGFE
+fesetround NOSIGFE
+fegetenv NOSIGFE
+feholdexcept SIGFE
+fesetenv SIGFE
+feupdateenv SIGFE
+fegetprec NOSIGFE
+fesetprec NOSIGFE
+feenableexcept SIGFE
+fedisableexcept NOSIGFE
+fegetexcept NOSIGFE
+_feinitialise NOSIGFE
+_fe_dfl_env DATA
+_fe_nomask_env DATA
Index: winsup/cygwin/fenv.cc
===================================================================
RCS file: winsup/cygwin/fenv.cc
diff -N winsup/cygwin/fenv.cc
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ winsup/cygwin/fenv.cc	10 Sep 2010 07:07:03 -0000
@@ -0,0 +1,445 @@
+/* fenv.cc
+
+   Copyright 2010 Red Hat, Inc.
+
+This file is part of Cygwin.
+
+This software is a copyrighted work licensed under the terms of the
+Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
+details. */
+
+#include <string.h>
+#include "fenv.h"
+#include "errno.h"
+
+/*  Mask and shift amount for rounding bits.  */
+#define FE_CW_ROUND_MASK	(0x0c00)
+#define FE_CW_ROUND_SHIFT	(10)
+/*  Same, for SSE MXCSR.  */
+#define FE_MXCSR_ROUND_MASK	(0x6000)
+#define FE_MXCSR_ROUND_SHIFT	(13)
+
+/*  Mask and shift amount for precision bits.  */
+#define FE_CW_PREC_MASK		(0x0300)
+#define FE_CW_PREC_SHIFT	(8)
+
+/*  In x87, exception status bits and mask bits occupy
+   corresponding bit positions in the status and control
+   registers, respectively.  In SSE, they are both located
+   in the control-and-status register, with the status bits
+   corresponding to the x87 positions, and the mask bits
+   shifted by this amount to the left.  */
+#define FE_SSE_EXCEPT_MASK_SHIFT (7)
+
+/* These are writable so we can initialise them at startup.  */
+static fenv_t fe_dfl_env;
+static fenv_t fe_nomask_env;
+
+/* These pointers provide the outside world with read-only access to them.  */
+const fenv_t *_fe_dfl_env = &fe_dfl_env;
+const fenv_t *_fe_nomask_env = &fe_nomask_env;
+
+/*  Although Cygwin assumes i686 or above (hence SSE available) these
+   days, and the compiler feels free to use it (depending on compile-
+   time flags of course), we should avoid needlessly breaking any
+   purely integer mode apps (or apps compiled with -mno-sse), so we
+   only manage SSE state in this fenv module if we detect that SSE
+   instructions are available at runtime.  If we didn't do this, all
+   applications run on older machines would bomb out with an invalid
+   instruction exception right at startup; let's not be *that* WJM!  */
+static bool use_sse = false;
+
+/*  This function enables traps for each of the exceptions as indicated
+   by the parameter except. The individual exceptions are described in
+   [ ... glibc manual xref elided ...]. Only the specified exceptions are
+   enabled, the status of the other exceptions is not changed.
+    The function returns the previous enabled exceptions in case the
+   operation was successful, -1 otherwise.  */
+int
+feenableexcept (int excepts)
+{
+  unsigned short cw, old_cw;
+  unsigned int mxcsr = 0;
+
+  if (excepts & ~FE_ALL_EXCEPT)
+    return -1;
+
+  /* Get control words.  */
+  __asm__ volatile ("fnstcw %0" : "=m" (old_cw) : );
+  if (use_sse)
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr) : );
+
+  /* Enable exceptions by clearing mask bits.  */
+  cw = old_cw & ~excepts;
+  mxcsr &= ~(excepts << FE_SSE_EXCEPT_MASK_SHIFT);
+
+  /* Store updated control words.  */
+  __asm__ volatile ("fldcw %0" :: "m" (cw));
+  if (use_sse)
+    __asm__ volatile ("ldmxcsr %0" :: "m" (mxcsr));
+
+  /* Return old value.  We assume SSE and x87 stay in sync.  Note that
+     we are returning a mask of enabled exceptions, which is the opposite
+     of the flags in the register, which are set to disable (mask) their
+     related exceptions.  */
+  return (~old_cw) & FE_ALL_EXCEPT;
+}
+
+/*  This function disables traps for each of the exceptions as indicated
+   by the parameter except. The individual exceptions are described in
+   [ ... glibc manual xref elided ...]. Only the specified exceptions are
+   disabled, the status of the other exceptions is not changed.
+    The function returns the previous enabled exceptions in case the
+   operation was successful, -1 otherwise.  */
+int
+fedisableexcept (int excepts)
+{
+  unsigned short cw, old_cw;
+  unsigned int mxcsr = 0;
+
+  if (excepts & ~FE_ALL_EXCEPT)
+    return -1;
+
+  /* Get control words.  */
+  __asm__ volatile ("fnstcw %0" : "=m" (old_cw) : );
+  if (use_sse)
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr) : );
+
+  /* Disable exceptions by setting mask bits.  */
+  cw = old_cw | excepts;
+  mxcsr |= (excepts << FE_SSE_EXCEPT_MASK_SHIFT);
+
+  /* Store updated control words.  */
+  __asm__ volatile ("fldcw %0" :: "m" (cw));
+  if (use_sse)
+    __asm__ volatile ("ldmxcsr %0" :: "m" (mxcsr));
+
+  /* Return old value.  We assume SSE and x87 stay in sync.  Note that
+     we are returning a mask of enabled exceptions, which is the opposite
+     of the flags in the register, which are set to disable (mask) their
+     related exceptions.  */
+  return (~old_cw) & FE_ALL_EXCEPT;
+}
+
+/*  This function returns a bitmask of all currently enabled exceptions. It
+   returns -1 in case of failure.  */
+int
+fegetexcept (void)
+{
+  unsigned short cw;
+
+  /* Get control word.  We assume SSE and x87 stay in sync.  */
+  __asm__ volatile ("fnstcw %0" : "=m" (cw) : );
+
+  /* Exception is *dis*abled when mask bit is set.  */
+  return (~cw) & FE_ALL_EXCEPT;
+}
+
+/*  Store the floating-point environment in the variable pointed to by envp.
+   The function returns zero in case the operation was successful, a non-zero
+   value otherwise.  */
+int
+fegetenv (fenv_t *envp)
+{
+  __asm__ volatile ("fnstenv %0" : "=m" (envp->_fpu) : );
+  if (use_sse)
+    __asm__ volatile ("stmxcsr %0" : "=m" (envp->_sse_mxcsr) : );
+  return 0;
+}
+
+/*  Store the current floating-point environment in the object pointed to
+   by envp. Then clear all exception flags, and set the FPU to trap no
+   exceptions.  Not all FPUs support trapping no exceptions; if feholdexcept
+   cannot set this mode, it returns nonzero value.  If it succeeds, it
+   returns zero.  */
+int
+feholdexcept (fenv_t *envp)
+{
+  unsigned int mxcsr;
+  fegetenv (envp);
+  mxcsr = envp->_sse_mxcsr & ~FE_ALL_EXCEPT;
+  if (use_sse)
+    __asm__ volatile ("ldmxcsr %0" :: "m" (mxcsr));
+  __asm__ volatile ("fnclex");
+  fedisableexcept (FE_ALL_EXCEPT);
+  return 0;
+}
+
+/*  Set the floating-point environment to that described by envp.  The
+   function returns zero in case the operation was successful, a non-zero
+   value otherwise.  */
+int
+fesetenv (const fenv_t *envp)
+{
+  __asm__ volatile ("fldenv %0" :: "m" (envp->_fpu) );
+  if (use_sse)
+    __asm__ volatile ("ldmxcsr %0" :: "m" (envp->_sse_mxcsr));
+  return 0;
+}
+
+/*  Like fesetenv, this function sets the floating-point environment to
+   that described by envp. However, if any exceptions were flagged in the
+   status word before feupdateenv was called, they remain flagged after
+   the call.  In other words, after feupdateenv is called, the status
+   word is the bitwise OR of the previous status word and the one saved
+   in envp.  The function returns zero in case the operation was successful,
+   a non-zero value otherwise.  */
+int
+feupdateenv (const fenv_t *envp)
+{
+  fenv_t envcopy;
+  unsigned int mxcsr = 0;
+  unsigned short sw;
+
+  /* Don't want to modify *envp, but want to update environment atomically,
+     so take a copy and merge the existing exceptions into it.  */
+  memcpy (&envcopy, envp, sizeof *envp);
+  __asm__ volatile ("fnstsw %0" : "=m" (sw) : );
+  if (use_sse)
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr) : );
+  envcopy._fpu._fpu_sw |= (sw & FE_ALL_EXCEPT);
+  envcopy._sse_mxcsr |= (mxcsr & FE_ALL_EXCEPT);
+
+  return fesetenv (&envcopy);
+}
+
+/*  This function clears all of the supported exception flags indicated by
+   excepts.  The function returns zero in case the operation was successful,
+   a non-zero value otherwise.  */
+int
+feclearexcept (int excepts)
+{
+  fenv_t fenv;
+
+  if (excepts & ~FE_ALL_EXCEPT)
+    return EINVAL;
+
+  /* Need to save/restore whole environment to modify status word.  */
+  fegetenv (&fenv);
+
+  /* Mask undesired bits out.  */
+  fenv._fpu._fpu_sw &= ~excepts;
+  fenv._sse_mxcsr &= ~excepts;
+
+  /* Set back into FPU state.  */
+  return fesetenv (&fenv);
+}
+
+/*  This function raises the supported exceptions indicated by 
+   excepts.  If more than one exception bit in excepts is set the order
+   in which the exceptions are raised is undefined except that overflow
+   (FE_OVERFLOW) or underflow (FE_UNDERFLOW) are raised before inexact
+   (FE_INEXACT). Whether for overflow or underflow the inexact exception
+   is also raised is also implementation dependent.  The function returns
+   zero in case the operation was successful, a non-zero value otherwise.  */
+int
+feraiseexcept (int excepts)
+{
+  fenv_t fenv;
+
+  if (excepts & ~FE_ALL_EXCEPT)
+    return EINVAL;
+
+  /* Need to save/restore whole environment to modify status word.  */
+  __asm__ volatile ("fnstenv %0" : "=m" (fenv) : );
+
+  /* Set desired exception bits.  */
+  fenv._fpu._fpu_sw |= excepts;
+
+  /* Set back into FPU state.  */
+  __asm__ volatile ("fldenv %0" :: "m" (fenv));
+
+  /* And trigger them - whichever are unmasked.  */
+  __asm__ volatile ("fwait");
+
+  return 0;
+}
+
+/*  Test whether the exception flags indicated by the parameter except
+   are currently set. If any of them are, a nonzero value is returned
+   which specifies which exceptions are set. Otherwise the result is zero.  */
+int
+fetestexcept (int excepts)
+{
+  unsigned short sw;
+  unsigned int mxcsr = 0;
+
+  if (excepts & ~FE_ALL_EXCEPT)
+    return EINVAL;
+
+  /* Get status registers.  */
+  __asm__ volatile ("fnstsw %0" : "=m" (sw) : );
+  if (use_sse)
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr) : );
+
+  /* Mask undesired bits out and return result.  */
+  return (sw | mxcsr) & excepts;
+}
+/*  This function stores in the variable pointed to by flagp an
+   implementation-defined value representing the current setting of the
+   exception flags indicated by excepts.  The function returns zero in
+   case the operation was successful, a non-zero value otherwise.  */
+int
+fegetexceptflag (fexcept_t *flagp, int excepts)
+{
+  unsigned short sw;
+  unsigned int mxcsr = 0;
+
+  if (excepts & ~FE_ALL_EXCEPT)
+    return EINVAL;
+
+  /* Get status registers.  */
+  __asm__ volatile ("fnstsw %0" : "=m" (sw) : );
+  if (use_sse)
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr) : );
+
+  /* Mask undesired bits out and set result struct.  */
+  flagp->_fpu_exceptions = (sw & excepts);
+  flagp->_sse_exceptions = (mxcsr & excepts);
+
+  return 0;
+}
+
+/*  This function restores the flags for the exceptions indicated by
+   excepts to the values stored in the variable pointed to by flagp.  */
+int
+fesetexceptflag (const fexcept_t *flagp, int excepts)
+{
+  fenv_t fenv;
+
+  if (excepts & ~FE_ALL_EXCEPT)
+    return EINVAL;
+
+  /* Need to save/restore whole environment to modify status word.  */
+  fegetenv (&fenv);
+
+  /* Set/Clear desired exception bits.  */
+  fenv._fpu._fpu_sw &= ~excepts;
+  fenv._fpu._fpu_sw |= (excepts & flagp->_fpu_exceptions);
+  fenv._sse_mxcsr &= ~excepts;
+  fenv._sse_mxcsr |= (excepts & flagp->_sse_exceptions);
+
+  /* Set back into FPU state.  */
+  return fesetenv (&fenv);
+}
+
+/*  Returns the currently selected rounding mode, represented by one of the
+   values of the defined rounding mode macros.  */
+int
+fegetround (void)
+{
+  unsigned short cw;
+
+  /* Get control word.  We assume SSE and x87 stay in sync.  */
+  __asm__ volatile ("fnstcw %0" : "=m" (cw) : );
+
+  return (cw & FE_CW_ROUND_MASK) >> FE_CW_ROUND_SHIFT;
+}
+
+/*  Changes the currently selected rounding mode to round. If round does
+   not correspond to one of the supported rounding modes nothing is changed.
+   fesetround returns zero if it changed the rounding mode, a nonzero value
+   if the mode is not supported.  */
+int
+fesetround (int round)
+{
+  unsigned short cw;
+  unsigned int mxcsr = 0;
+
+  /* Will succeed for any valid value of the input parameter.  */
+  if (round & ~(FE_CW_ROUND_MASK >> FE_CW_PREC_SHIFT))
+    return EINVAL;
+
+  /* Get control words.  */
+  __asm__ volatile ("fnstcw %0" : "=m" (cw) : );
+  if (use_sse)
+    __asm__ volatile ("stmxcsr %0" : "=m" (mxcsr) : );
+
+  /* Twiddle bits.  */
+  cw &= ~FE_CW_ROUND_MASK;
+  cw |= (round << FE_CW_ROUND_SHIFT);
+  mxcsr &= ~FE_MXCSR_ROUND_MASK;
+  mxcsr |= (round << FE_MXCSR_ROUND_SHIFT);
+
+  /* Set back into FPU state.  */
+  __asm__ volatile ("fldcw %0" :: "m" (cw));
+  if (use_sse)
+    __asm__ volatile ("ldmxcsr %0" :: "m" (mxcsr));
+
+  /* Indicate success.  */
+  return 0;
+}
+
+/*  Returns the currently selected precision, represented by one of the
+   values of the defined precision macros.  */
+int
+fegetprec (void)
+{
+  unsigned short cw;
+
+  /* Get control word.  */
+  __asm__ volatile ("fnstcw %0" : "=m" (cw) : );
+
+  return (cw & FE_CW_PREC_MASK) >> FE_CW_PREC_SHIFT;
+}
+
+/*  Changes the currently selected precision to prec. If prec does not
+   correspond to one of the supported rounding modes nothing is changed.
+   fesetprec returns zero if it changed the precision, or a nonzero value
+   if the mode is not supported.  */
+int
+fesetprec (int prec)
+{
+  unsigned short cw;
+
+  /* Will succeed for any valid value of the input parameter.  */
+  if (prec & ~(FE_CW_PREC_MASK >> FE_CW_PREC_SHIFT) || prec == FE_RESERVEDPREC)
+    return EINVAL;
+
+  /* Get control word.  */
+  __asm__ volatile ("fnstcw %0" : "=m" (cw) : );
+
+  /* Twiddle bits.  */
+  cw &= ~FE_CW_PREC_MASK;
+  cw |= (prec << FE_CW_PREC_SHIFT);
+
+  /* Set back into FPU state.  */
+  __asm__ volatile ("fldcw %0" :: "m" (cw));
+
+  /* Indicate success.  */
+  return 0;
+}
+
+/*  Set up the FPU and SSE environment at the start of execution.  */
+void
+_feinitialise (void)
+{
+  unsigned int edx, eax, mxcsr;
+
+  /* Check for presence of SSE: invoke CPUID #1, check EDX bit 25.  */
+  eax = 1;
+  __asm__ volatile ("cpuid" : "=d" (edx), "+a" (eax) :: "%ecx", "%ebx");
+  /* If this flag isn't set, we'll avoid trying to execute any SSE.  */
+  if (edx & (1 << 25))
+    use_sse = true;
+
+  /* Reset FPU: extended prec, all exceptions cleared and masked off.  */
+  __asm__ volatile ("fninit");
+  /* The default cw value, 0x37f, is rounding mode zero.  The MXCSR has
+     no precision control, so the only thing to do is set the exception
+     mask bits.  */
+  mxcsr = FE_ALL_EXCEPT << FE_SSE_EXCEPT_MASK_SHIFT;
+  if (use_sse)
+    __asm__ volatile ("ldmxcsr %0" :: "m" (mxcsr));
+
+  /* Setup unmasked environment.  */
+  feenableexcept (FE_ALL_EXCEPT);
+  fegetenv (&fe_nomask_env);
+
+  /* Restore default exception masking (all masked).  */
+  fedisableexcept (FE_ALL_EXCEPT);
+
+  /* Finally cache state as default environment. */
+  fegetenv (&fe_dfl_env);
+}
+
Index: winsup/cygwin/posix.sgml
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/posix.sgml,v
retrieving revision 1.48
diff -p -u -r1.48 posix.sgml
--- winsup/cygwin/posix.sgml	30 Aug 2010 14:16:01 -0000	1.48
+++ winsup/cygwin/posix.sgml	10 Sep 2010 07:07:03 -0000
@@ -150,8 +150,19 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008)
     fdimf
     fdopen
     fdopendir
+    feclearexcept
+    fegetenv
+    fegetexceptflag
+    fegetround
+    feholdexcept
     feof
+    feraiseexcept
     ferror
+    fesetenv
+    fesetexceptflag
+    fesetround
+    fetestexcept
+    feupdateenv
     fexecve
     fflush
     ffs
@@ -1024,6 +1035,11 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008)
     exp10f
     fcloseall
     fcloseall_r
+    fegetprec
+    fesetprec
+    feenableexcept
+    fedisableexcept
+    fegetexcept
     fgetxattr
     flistxattr
     fopencookie
@@ -1277,17 +1293,6 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008)
     fabsl
     fattach
     fdiml
-    feclearexcept
-    fegetenv
-    fegetexceptflag
-    fegetround
-    feholdexcept
-    feraiseexcept
-    fesetenv
-    fesetexceptflag
-    fesetround
-    fetestexcept
-    feupdateenv
     floorl
     fmal
     fmaxl
Index: winsup/cygwin/include/fenv.h
===================================================================
RCS file: winsup/cygwin/include/fenv.h
diff -N winsup/cygwin/include/fenv.h
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ winsup/cygwin/include/fenv.h	10 Sep 2010 07:07:03 -0000
@@ -0,0 +1,176 @@
+/* fenv.h
+
+   Copyright 2010 Red Hat, Inc.
+
+This file is part of Cygwin.
+
+This software is a copyrighted work licensed under the terms of the
+Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
+details. */
+
+#ifndef _FENV_H_
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+
+/* Primary sources:
+
+     The Open Group Base Specifications Issue 6:
+   http://www.opengroup.org/onlinepubs/000095399/basedefs/fenv.h.html
+
+     C99 Language spec (draft n1256):
+   <url unknown>
+
+     Intel® 64 and IA-32 Architectures Software Developers Manuals:
+   http://www.intel.com/products/processor/manuals/
+
+     GNU C library manual pages:
+   http://www.gnu.org/software/libc/manual/html_node/Control-Functions.html
+   http://www.gnu.org/software/libc/manual/html_node/Rounding.html
+   http://www.gnu.org/software/libc/manual/html_node/FP-Exceptions.html
+   http://www.gnu.org/software/libc/manual/html_node/Status-bit-operations.html
+
+     Linux online man page(s):
+   http://linux.die.net/man/3/fegetexcept
+
+    The documentation quotes these sources for reference.  All definitions and
+   code have been developed solely based on the information from these specs.
+
+*/
+
+/*  Represents the entire floating-point environment. The floating-point
+   environment refers collectively to any floating-point status flags and
+   control modes supported by the implementation.
+    In this implementation, the struct contains the state information from
+   the fstenv/fnstenv instructions and a copy of the SSE MXCSR, since GCC
+   uses SSE for a lot of floating-point operations.  (Cygwin assumes i686
+   or above these days, as does the compiler.)  */
+
+typedef struct _fenv_t
+{
+  struct _fpu_env_info {
+    unsigned int _fpu_cw;	/* low 16 bits only. */
+    unsigned int _fpu_sw;	/* low 16 bits only. */
+    unsigned int _fpu_tagw;	/* low 16 bits only. */
+    unsigned int _fpu_ipoff;
+    unsigned int _fpu_ipsel;
+    unsigned int _fpu_opoff;
+    unsigned int _fpu_opsel;	/* low 16 bits only. */
+  } _fpu;
+  unsigned int _sse_mxcsr;
+} fenv_t;
+
+/*  Represents the floating-point status flags collectively, including
+   any status the implementation associates with the flags. A floating-point
+   status flag is a system variable whose value is set (but never cleared)
+   when a floating-point exception is raised, which occurs as a side effect
+   of exceptional floating-point arithmetic to provide auxiliary information.
+    A floating-point control mode is a system variable whose value may be
+   set by the user to affect the subsequent behavior of floating-point
+   arithmetic.  */
+
+typedef struct _fexcept_t
+{
+  unsigned short _fpu_exceptions;
+  unsigned short _sse_exceptions;
+} fexcept_t;
+
+/*  The <fenv.h> header shall define the following constants if and only
+   if the implementation supports the floating-point exception by means
+   of the floating-point functions feclearexcept(), fegetexceptflag(),
+   feraiseexcept(), fesetexceptflag(), and fetestexcept(). Each expands to
+   an integer constant expression with values such that bitwise-inclusive
+   ORs of all combinations of the constants result in distinct values.  */
+
+#define FE_DIVBYZERO	(1 << 2)
+#define FE_INEXACT	(1 << 5)
+#define FE_INVALID	(1 << 0)
+#define FE_OVERFLOW	(1 << 3)
+#define FE_UNDERFLOW	(1 << 4)
+
+/*  This is not defined by Posix, but since x87 supports it we provide
+   a definition according to the same naming scheme used above.  */
+#define FE_DENORMAL	(1 << 1)
+
+/*  The <fenv.h> header shall define the following constant, which is
+   simply the bitwise-inclusive OR of all floating-point exception
+   constants defined above:  */
+
+#define FE_ALL_EXCEPT (FE_DIVBYZERO | FE_INEXACT | FE_INVALID \
+			| FE_OVERFLOW | FE_UNDERFLOW | FE_DENORMAL)
+
+/*  The <fenv.h> header shall define the following constants if and only
+   if the implementation supports getting and setting the represented
+   rounding direction by means of the fegetround() and fesetround()
+   functions. Each expands to an integer constant expression whose values
+   are distinct non-negative vales.  */
+
+#define FE_DOWNWARD	(1)
+#define FE_TONEAREST	(0)
+#define FE_TOWARDZERO	(3)
+#define FE_UPWARD	(2)
+
+/*  Precision bit values.  Not defined by Posix, but follow logically.  */
+#define FE_SINGLEPREC	(0)
+#define FE_RESERVEDPREC	(1)
+#define FE_DOUBLEPREC	(2)
+#define FE_EXTENDEDPREC	(3)
+
+/*  The <fenv.h> header shall define the following constant, which
+   represents the default floating-point environment (that is, the one
+   installed at program startup) and has type pointer to const-qualified
+   fenv_t. It can be used as an argument to the functions within the
+   <fenv.h> header that manage the floating-point environment.  */
+
+extern const fenv_t *_fe_dfl_env;
+#define FE_DFL_ENV (_fe_dfl_env)
+
+/*  Additional implementation-defined environments, with macro 
+   definitions beginning with FE_ and an uppercase letter,and having
+   type "pointer to const-qualified fenv_t",may also be specified by
+   the implementation.  */
+
+#ifdef _GNU_SOURCE
+/*  If possible, the GNU C Library defines a macro FE_NOMASK_ENV which
+   represents an environment where every exception raised causes a trap
+   to occur. You can test for this macro using #ifdef. It is only defined
+   if _GNU_SOURCE is defined.  */
+extern const fenv_t *_fe_nomask_env;
+#define FE_NOMASK_ENV (_fe_nomask_env)
+#endif /* _GNU_SOURCE */
+
+
+/*  The following shall be declared as functions and may also be
+   defined as macros. Function prototypes shall be provided.  */
+extern int feclearexcept (int excepts);
+extern int fegetexceptflag (fexcept_t *flagp, int excepts);
+extern int feraiseexcept (int excepts);
+extern int fesetexceptflag (const fexcept_t *flagp, int excepts);
+extern int fetestexcept (int excepts);
+extern int fegetround (void);
+extern int fesetround (int round);
+extern int fegetenv (fenv_t *envp);
+extern int feholdexcept (fenv_t *envp);
+extern int fesetenv (const fenv_t *envp);
+extern int feupdateenv (const fenv_t *envp);
+
+/* These are not defined in Posix, but make sense by obvious extension.  */
+extern int fegetprec (void);
+extern int fesetprec (int prec);
+
+/* This is Cygwin-custom, not from the standard, for use in the Cygwin CRT.  */
+extern void _feinitialise (void);
+
+/* These are GNU extensions defined in glibc.  */
+extern int feenableexcept (int excepts);
+extern int fedisableexcept (int excepts);
+extern int fegetexcept (void);
+
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* _FENV_H_ */
Index: winsup/cygwin/include/cygwin/version.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/cygwin/version.h,v
retrieving revision 1.326
diff -p -u -r1.326 version.h
--- winsup/cygwin/include/cygwin/version.h	1 Sep 2010 07:16:49 -0000	1.326
+++ winsup/cygwin/include/cygwin/version.h	10 Sep 2010 07:07:03 -0000
@@ -390,12 +390,13 @@ details. */
       228: CW_STRERROR added.
       229: Add mkostemp, mkostemps.
       230: Add CLOCK_MONOTONIC.
+      231: Add fenv.h functions.
      */
 
      /* Note that we forgot to bump the api for ualarm, strtoll, strtoull */
 
 #define CYGWIN_VERSION_API_MAJOR 0
-#define CYGWIN_VERSION_API_MINOR 230
+#define CYGWIN_VERSION_API_MINOR 231
 
      /* There is also a compatibity version number associated with the
 	shared memory regions.  It is incremented when incompatible


--------------030000040905090208040507--
