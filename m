Return-Path: <cygwin-patches-return-6710-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16029 invoked by alias); 5 Oct 2009 23:27:23 -0000
Received: (qmail 16010 invoked by uid 22791); 5 Oct 2009 23:27:20 -0000
X-SWARE-Spam-Status: No, hits=-3.2 required=5.0 	tests=AWL,BAYES_00,HK_OBFDOM,RCVD_IN_DNSWL_LOW,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from out1.smtp.messagingengine.com (HELO out1.smtp.messagingengine.com) (66.111.4.25)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 05 Oct 2009 23:27:16 +0000
Received: from compute1.internal (compute1.internal [10.202.2.41]) 	by gateway1.messagingengine.com (Postfix) with ESMTP id A801E83A60 	for <cygwin-patches@cygwin.com>; Mon,  5 Oct 2009 19:27:14 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])   by compute1.internal (MEProxy); Mon, 05 Oct 2009 19:27:14 -0400
Received: from [192.168.1.3] (user-0c6sbc4.cable.mindspring.com [24.110.45.132]) 	by mail.messagingengine.com (Postfix) with ESMTPSA id 01B1839C0; 	Mon,  5 Oct 2009 19:27:13 -0400 (EDT)
Message-ID: <4ACA80CD.6090607@cwilson.fastmail.fm>
Date: Mon, 05 Oct 2009 23:27:00 -0000
From: Charles Wilson <cygwin@cwilson.fastmail.fm>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Add wrappers for ExitProcess, TerminateProcess
References: <4ACA4323.5080103@cwilson.fastmail.fm>  <4ACA47AF.7070703@gmail.com>  <4ACA4B76.5050209@gmail.com>  <4ACA4ADF.6000205@cwilson.fastmail.fm>  <4ACA4EE6.5000303@gmail.com>  <4ACA4EE6.1020803@cwilson.fastmail.fm>  <4ACA52EC.2070409@gmail.com>  <4ACA56F2.30303@cwilson.fastmail.fm> <20091005205102.GA9378@ednor.casa.cgf.cx>
In-Reply-To: <20091005205102.GA9378@ednor.casa.cgf.cx>
Content-Type: multipart/mixed;  boundary="------------010401050605010204050907"
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q4/txt/msg00041.txt.bz2

This is a multi-part message in MIME format.
--------------010401050605010204050907
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 1826

Christopher Faylor wrote:
> I've checked in the sigExeced part of this patch.  Thanks.

The checkin does not yet appear to have taken effect, because
  $ cvs update && cvs diff
still shows the sigExeced stuff -- so, it's still in the patch/changelog
below.

> For the other part, if you're willing, I think you should just do what
> Corinna suggested.

Attached. The implementation of terminate_process and exit_process may
be somewhat paranoid, but I really don't want to let anybody
accidentally kill the wrong process, or clobber their own exit value
when terminating some other process.


Tested with:
==============================================
#include <stdio.h>
#include <windows.h>
#include <ntdef.h>
#include <sys/cygwin.h>

#define STATUS_ILLEGAL_DLL_RELOCATION ((NTSTATUS) 0xc0000269)
#define STATUS_ILLEGAL_DLL_PSEUDO_RELOCATION ((NTSTATUS) 0xe0000269)
#define STATUS_DLL_NOT_FOUND          ((NTSTATUS) 0xc0000135)

int main(int argc, char* argv[])
{
  cygwin_internal (CW_TERMINATE_PROCESS,
                   GetCurrentProcess(),
                   STATUS_ILLEGAL_DLL_RELOCATION);
//  cygwin_internal (CW_EXIT_PROCESS, STATUS_ILLEGAL_DLL_RELOCATION);
  exit (1);
}
==============================================


2009-10-05  Charles Wilson  <...>

	Add cygwin wrappers for ExitProcess and TerminateProcess.
	* include/sys/cygwin.h: Declare new cygwin_getinfo_types
	CW_TERMINATE_PROCESS and CW_EXIT_PROCESS.
	* external.cc (terminate_process): New function.
	(exit_process): New function.
	(cygwin_internal): Handle CW_TERMINATE_PROCESS and
	CW_EXIT_PROCESS.
	* pinfo.h (pinfo::set_exit_code): New method.
	* pinfo.cc (pinfo::set_exit_code): New, refactored from...
	(pinfo::maybe_set_exit_code_from_windows): here. Call it.
	* exceptions.cc: Move global variable sigExeced...
	* globals.cc: here.

--
Chuck

--------------010401050605010204050907
Content-Type: text/plain;
 name="01-cygwin-terminate-process.patch-3"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="01-cygwin-terminate-process.patch-3"
Content-length: 6972

Index: winsup/cygwin/exceptions.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/exceptions.cc,v
retrieving revision 1.335
diff -u -p -r1.335 exceptions.cc
--- winsup/cygwin/exceptions.cc	19 Sep 2009 15:34:19 -0000	1.335
+++ winsup/cygwin/exceptions.cc	5 Oct 2009 23:14:27 -0000
@@ -40,7 +40,6 @@ extern void sigdelayed ();
 };
 
 extern child_info_spawn *chExeced;
-int NO_COPY sigExeced;
 
 static BOOL WINAPI ctrl_c_handler (DWORD);
 static WCHAR windows_system_directory[1024];
Index: winsup/cygwin/external.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/external.cc,v
retrieving revision 1.107
diff -u -p -r1.107 external.cc
--- winsup/cygwin/external.cc	21 Sep 2009 02:19:31 -0000	1.107
+++ winsup/cygwin/external.cc	5 Oct 2009 23:14:27 -0000
@@ -32,6 +32,7 @@ details. */
 #include <iptypes.h>
 
 child_info *get_cygwin_startup_info ();
+static void exit_process (UINT) __attribute__ ((noreturn));
 
 static winpids pids;
 
@@ -161,6 +162,60 @@ sync_winenv ()
   free (envblock);
 }
 
+/*
+ * Cygwin-specific wrapper for win32 TerminateProcess. It ensures
+ * that if used to terminate the current process, then the correct
+ * exit code will be made available to this process's parent (if
+ * that parent is also a cygwin process). Otherwise, it simply
+ * delegates to the win32 TerminateProcess. Used by startup code
+ * for cygwin processes which is linked statically into
+ * applications, and is not part of the cygwin DLL -- which is why
+ * this interface is exposed.  "Normal" programs should use ANSI
+ * abort() or POSIX _exit(), because calling TerminateProcess even
+ * through this wrapper, skips much of the cygwin process cleanup
+ * code.
+ */
+static BOOL
+terminate_process (HANDLE process, UINT status)
+{
+  DWORD currPID = GetCurrentProcessId();
+  if (GetProcessId(process) == currPID)
+    {
+      pid_t pid = getpid ();
+      external_pinfo * ep = fillout_pinfo (pid, 1);
+      DWORD dwpid = ep ? ep->dwProcessId : pid;
+      pinfo p (pid, PID_MAP_RW);
+      if ((dwpid == currPID) && (p->pid == ep->pid))
+        p.set_exit_code ((DWORD)status);
+    }
+  return TerminateProcess (process, status);
+}
+
+/*
+ * Cygwin-specific wrapper for win32 ExitProcess. It ensures that if
+ * used to terminate the current process, then the correct exit code
+ * will be made available to this process's parent (if that parent
+ * is also a cygwin process). Otherwise, it simply delegates to the
+ * win32 ExitProcess. Used by startup code for cygwin processes
+ * which is linked statically into applications, and is not part of
+ * the cygwin DLL -- which is why this interface is exposed.
+ * "Normal" programs should use ANSI exit(), because calling
+ * ExitProcess, even through this wrapper, skips much of the cygwin
+ * process cleanup code.
+ */
+static void
+exit_process (UINT status)
+{
+  pid_t pid = getpid ();
+  external_pinfo * ep = fillout_pinfo (pid, 1);
+  DWORD dwpid = ep ? ep->dwProcessId : pid;
+  pinfo p (pid, PID_MAP_RW);
+  if ((dwpid == GetCurrentProcessId()) && (p->pid == ep->pid))
+    p.set_exit_code ((DWORD)status);
+  ExitProcess (status);
+}
+
+
 extern "C" unsigned long
 cygwin_internal (cygwin_getinfo_types t, ...)
 {
@@ -375,6 +430,18 @@ cygwin_internal (cygwin_getinfo_types t,
 	  seterrno(file, line);
 	}
 	break;
+      case CW_TERMINATE_PROCESS:
+	{
+	  HANDLE process = va_arg (arg, HANDLE);
+	  UINT status = va_arg (arg, UINT);
+	  terminate_process (process, status);
+	}
+	break;
+      case CW_EXIT_PROCESS:
+	{
+	  UINT status = va_arg (arg, UINT);
+	  exit_process (status); /* no return */
+	}
 
       default:
 	break;
Index: winsup/cygwin/globals.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/globals.cc,v
retrieving revision 1.9
diff -u -p -r1.9 globals.cc
--- winsup/cygwin/globals.cc	24 Aug 2009 11:14:30 -0000	1.9
+++ winsup/cygwin/globals.cc	5 Oct 2009 23:14:27 -0000
@@ -49,6 +49,10 @@ SYSTEM_INFO system_info;
 /* Set in init.cc.  Used to check if Cygwin DLL is dynamically loaded. */
 int NO_COPY dynamically_loaded;
 
+/* set in exceptions.cc.  Used to store the desired exit value when
+   a process is killed by a signal */
+int NO_COPY sigExeced;
+
 bool display_title;
 bool strip_title_path;
 bool allow_glob = true;
Index: winsup/cygwin/pinfo.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/pinfo.cc,v
retrieving revision 1.253
diff -u -p -r1.253 pinfo.cc
--- winsup/cygwin/pinfo.cc	12 Jul 2009 21:15:47 -0000	1.253
+++ winsup/cygwin/pinfo.cc	5 Oct 2009 23:14:28 -0000
@@ -136,11 +136,18 @@ status_exit (DWORD x)
 
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
   DWORD oexitcode = self->exitcode;
-  extern int sigExeced;
 
   if (hProcess && !(self->exitcode & EXITCODE_SET))
     {
@@ -148,9 +155,7 @@ pinfo::maybe_set_exit_code_from_windows 
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
+++ winsup/cygwin/pinfo.h	5 Oct 2009 23:14:28 -0000
@@ -155,6 +155,7 @@ public:
   }
   void exit (DWORD n) __attribute__ ((noreturn, regparm(2)));
   void maybe_set_exit_code_from_windows () __attribute__ ((regparm(1)));
+  void set_exit_code (DWORD n) __attribute__ ((regparm(2)));
   _pinfo *operator -> () const {return procinfo;}
   int operator == (pinfo *x) const {return x->procinfo == procinfo;}
   int operator == (pinfo &x) const {return x.procinfo == procinfo;}
Index: winsup/cygwin/include/sys/cygwin.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/sys/cygwin.h,v
retrieving revision 1.80
diff -u -p -r1.80 cygwin.h
--- winsup/cygwin/include/sys/cygwin.h	7 Jul 2009 20:12:44 -0000	1.80
+++ winsup/cygwin/include/sys/cygwin.h	5 Oct 2009 23:14:28 -0000
@@ -142,7 +142,9 @@ typedef enum
     CW_CYGTLS_PADSIZE,
     CW_SET_DOS_FILE_WARNING,
     CW_SET_PRIV_KEY,
-    CW_SETERRNO
+    CW_SETERRNO,
+    CW_TERMINATE_PROCESS,
+    CW_EXIT_PROCESS
   } cygwin_getinfo_types;
 
 #define CW_NEXTPID	0x80000000	/* or with pid to get next one */

--------------010401050605010204050907--
