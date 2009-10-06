Return-Path: <cygwin-patches-return-6732-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11605 invoked by alias); 6 Oct 2009 21:58:37 -0000
Received: (qmail 11574 invoked by uid 22791); 6 Oct 2009 21:58:35 -0000
X-SWARE-Spam-Status: No, hits=-3.2 required=5.0 	tests=AWL,BAYES_00,HK_OBFDOM,RCVD_IN_DNSWL_LOW,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from out2.smtp.messagingengine.com (HELO out2.smtp.messagingengine.com) (66.111.4.26)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 06 Oct 2009 21:58:30 +0000
Received: from compute1.internal (compute1.internal [10.202.2.41]) 	by gateway1.messagingengine.com (Postfix) with ESMTP id 91D5588C36 	for <cygwin-patches@cygwin.com>; Tue,  6 Oct 2009 17:58:28 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])   by compute1.internal (MEProxy); Tue, 06 Oct 2009 17:58:28 -0400
Received: from [192.168.1.3] (user-0c6sbc4.cable.mindspring.com [24.110.45.132]) 	by mail.messagingengine.com (Postfix) with ESMTPSA id 0F58C256B; 	Tue,  6 Oct 2009 17:58:27 -0400 (EDT)
Message-ID: <4ACBBD7C.4000604@cwilson.fastmail.fm>
Date: Tue, 06 Oct 2009 21:58:00 -0000
From: Charles Wilson <cygwin@cwilson.fastmail.fm>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Add wrappers for ExitProcess, TerminateProcess
References: <4ACB670F.2070209@cwilson.fastmail.fm>  <20091006182221.GD18135@ednor.casa.cgf.cx>  <4ACB9042.3070104@cwilson.fastmail.fm>  <20091006193502.GA18384@ednor.casa.cgf.cx>  <4ACB9FBE.5080700@cwilson.fastmail.fm>  <20091006202915.GA18969@ednor.casa.cgf.cx>  <4ACBB03A.6030009@cwilson.fastmail.fm>  <20091006210906.GB18969@ednor.casa.cgf.cx>  <4ACBB350.1090302@cwilson.fastmail.fm>  <4ACBB447.5070908@cwilson.fastmail.fm> <20091006212414.GA12340@ednor.casa.cgf.cx>
In-Reply-To: <20091006212414.GA12340@ednor.casa.cgf.cx>
Content-Type: multipart/mixed;  boundary="------------030502080500090102040401"
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q4/txt/msg00063.txt.bz2

This is a multi-part message in MIME format.
--------------030502080500090102040401
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 2031

Christopher Faylor wrote:
> On Tue, Oct 06, 2009 at 05:19:03PM -0400, Charles Wilson wrote:
>> Do I need to increment the minor version when adding a new
>> cygwin_internal call?  It seems so:
> 
> Yes.  Thanks for catching that.

As committed (and tested):

2009-10-05  Charles Wilson  <cygwin@cwilson.fastmail.fm>

	Add cygwin wrapper for ExitProcess and TerminateProcess.
	* include/sys/cygwin.h: Declare new cygwin_getinfo_type
	CW_EXIT_PROCESS.
	* external.cc (exit_process): New function.
	(cygwin_internal): Handle CW_EXIT_PROCESS.
	* pinfo.h (pinfo::set_exit_code): New method.
	* pinfo.cc (pinfo::set_exit_code): New, refactored from...
	(pinfo::maybe_set_exit_code_from_windows): here. Call it.
	* include/cygwin/version.h: Bump CYGWIN_VERSION_API_MINOR
	to 215 to reflect the above change.


Test proggie:
========================================================
#include <stdio.h>
#include <windows.h>
#include <ntdef.h>
#include <sys/cygwin.h>

#define STATUS_ILLEGAL_DLL_RELOCATION ((NTSTATUS) 0xc0000269)
#define STATUS_ILLEGAL_DLL_PSEUDO_RELOCATION ((NTSTATUS) 0xe0000269)
#define STATUS_DLL_NOT_FOUND          ((NTSTATUS) 0xc0000135)

int main(int argc, char* argv[])
{
  cygwin_internal (CW_EXIT_PROCESS,
                   STATUS_ILLEGAL_DLL_PSEUDO_RELOCATION,
                   1);
//                   0);
  exit (1);
}
========================================================

Note that neither cygwin nor ExitProcess/TerminateProcess care that they
have no idea what the '0xe0000269' status code means -- for this test I
stripped out all of the new pseudo-reloc support code from my repo.
However, cygwin just says: "this value is > 0xc00000000, and I don't
have a special case to handle it, so default: exit_code = 127;"

Which is what we want, for now.

$ gcc -o foo.exe foo.c
$ ./foo.exe
$ echo $?
127

P.S. Thanks for all the reviews, folks!  Public interface changes should
always be subject to "strict scrutiny", even more so than purely
internal implementation details, so this was good...

--
Chuck

--------------030502080500090102040401
Content-Type: text/plain;
 name="01-cygwin-terminate-process.patch-final"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="01-cygwin-terminate-process.patch-final"
Content-length: 5636

Index: winsup/cygwin/external.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/external.cc,v
retrieving revision 1.107
diff -u -p -r1.107 external.cc
--- winsup/cygwin/external.cc	21 Sep 2009 02:19:31 -0000	1.107
+++ winsup/cygwin/external.cc	6 Oct 2009 21:50:41 -0000
@@ -32,6 +32,7 @@ details. */
 #include <iptypes.h>
 
 child_info *get_cygwin_startup_info ();
+static void exit_process (UINT, bool) __attribute__((noreturn));
 
 static winpids pids;
 
@@ -161,6 +162,37 @@ sync_winenv ()
   free (envblock);
 }
 
+/*
+ * Cygwin-specific wrapper for win32 ExitProcess and TerminateProcess.
+ * It ensures that the correct exit code, derived from the specified
+ * status value, will be made available to this process's parent (if
+ * that parent is also a cygwin process). If useTerminateProcess is
+ * true, then TerminateProcess(GetCurrentProcess(),...) will be used;
+ * otherwise, ExitProcess(...) is called.
+ *
+ * Used by startup code for cygwin processes which is linked statically
+ * into applications, and is not part of the cygwin DLL -- which is why
+ * this interface is exposed. "Normal" programs should use ANSI exit(),
+ * ANSI abort(), or POSIX _exit(), rather than this function -- because
+ * calling ExitProcess or TerminateProcess, even through this wrapper,
+ * skips much of the cygwin process cleanup code.
+ */
+static void
+exit_process (UINT status, bool useTerminateProcess)
+{
+  pid_t pid = getpid ();
+  external_pinfo * ep = fillout_pinfo (pid, 1);
+  DWORD dwpid = ep ? ep->dwProcessId : pid;
+  pinfo p (pid, PID_MAP_RW);
+  if ((dwpid == GetCurrentProcessId()) && (p->pid == ep->pid))
+    p.set_exit_code ((DWORD)status);
+  if (useTerminateProcess)
+    TerminateProcess (GetCurrentProcess(), status);
+  /* avoid 'else' clause to silence warning */
+  ExitProcess (status);
+}
+
+
 extern "C" unsigned long
 cygwin_internal (cygwin_getinfo_types t, ...)
 {
@@ -375,6 +407,12 @@ cygwin_internal (cygwin_getinfo_types t,
 	  seterrno(file, line);
 	}
 	break;
+      case CW_EXIT_PROCESS:
+	{
+	  UINT status = va_arg (arg, UINT);
+	  int useTerminateProcess = va_arg (arg, int);
+	  exit_process (status, !!useTerminateProcess); /* no return */
+	}
 
       default:
 	break;
Index: winsup/cygwin/pinfo.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/pinfo.cc,v
retrieving revision 1.254
diff -u -p -r1.254 pinfo.cc
--- winsup/cygwin/pinfo.cc	6 Oct 2009 03:39:38 -0000	1.254
+++ winsup/cygwin/pinfo.cc	6 Oct 2009 21:50:41 -0000
@@ -136,6 +136,14 @@ status_exit (DWORD x)
 
 # define self (*this)
 void
+pinfo::set_exit_code (DWORD x)
+{
+  if (x >= 0xc0000000UL)
+    x = status_exit (x);
+  self->exitcode = EXITCODE_SET | (sigExeced ?: (x & 0xff) << 8);
+}
+
+void
 pinfo::maybe_set_exit_code_from_windows ()
 {
   DWORD x = 0xdeadbeef;
@@ -147,9 +155,7 @@ pinfo::maybe_set_exit_code_from_windows 
 						   process hasn't quite exited
 						   after closing pipe */
       GetExitCodeProcess (hProcess, &x);
-      if (x >= 0xc0000000UL)
-	x = status_exit (x);
-      self->exitcode = EXITCODE_SET | (sigExeced ?: (x & 0xff) << 8);
+      set_exit_code (x);
     }
   sigproc_printf ("pid %d, exit value - old %p, windows %p, cygwin %p",
 		  self->pid, oexitcode, x, self->exitcode);
Index: winsup/cygwin/pinfo.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/pinfo.h,v
retrieving revision 1.108
diff -u -p -r1.108 pinfo.h
--- winsup/cygwin/pinfo.h	20 Dec 2008 17:32:31 -0000	1.108
+++ winsup/cygwin/pinfo.h	6 Oct 2009 21:50:41 -0000
@@ -155,6 +155,7 @@ public:
   }
   void exit (DWORD n) __attribute__ ((noreturn, regparm(2)));
   void maybe_set_exit_code_from_windows () __attribute__ ((regparm(1)));
+  void set_exit_code (DWORD n) __attribute__ ((regparm(2)));
   _pinfo *operator -> () const {return procinfo;}
   int operator == (pinfo *x) const {return x->procinfo == procinfo;}
   int operator == (pinfo &x) const {return x.procinfo == procinfo;}
Index: winsup/cygwin/include/cygwin/version.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/cygwin/version.h,v
retrieving revision 1.299
diff -u -p -r1.299 version.h
--- winsup/cygwin/include/cygwin/version.h	26 Sep 2009 21:01:10 -0000	1.299
+++ winsup/cygwin/include/cygwin/version.h	6 Oct 2009 21:50:42 -0000
@@ -368,12 +368,13 @@ details. */
       212: Add and export libstdc++ malloc wrappers.
       213: Export canonicalize_file_name, eaccess, euidaccess.
       214: Export execvpe, fexecve.
+      215: CW_EXIT_PROCESS added.
      */
 
      /* Note that we forgot to bump the api for ualarm, strtoll, strtoull */
 
 #define CYGWIN_VERSION_API_MAJOR 0
-#define CYGWIN_VERSION_API_MINOR 214
+#define CYGWIN_VERSION_API_MINOR 215
 
      /* There is also a compatibity version number associated with the
 	shared memory regions.  It is incremented when incompatible
Index: winsup/cygwin/include/sys/cygwin.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/sys/cygwin.h,v
retrieving revision 1.80
diff -u -p -r1.80 cygwin.h
--- winsup/cygwin/include/sys/cygwin.h	7 Jul 2009 20:12:44 -0000	1.80
+++ winsup/cygwin/include/sys/cygwin.h	6 Oct 2009 21:50:42 -0000
@@ -142,7 +142,8 @@ typedef enum
     CW_CYGTLS_PADSIZE,
     CW_SET_DOS_FILE_WARNING,
     CW_SET_PRIV_KEY,
-    CW_SETERRNO
+    CW_SETERRNO,
+    CW_EXIT_PROCESS
   } cygwin_getinfo_types;
 
 #define CW_NEXTPID	0x80000000	/* or with pid to get next one */

--------------030502080500090102040401--
