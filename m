Return-Path: <cygwin-patches-return-6715-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30920 invoked by alias); 6 Oct 2009 14:40:36 -0000
Received: (qmail 30907 invoked by uid 22791); 6 Oct 2009 14:40:34 -0000
X-SWARE-Spam-Status: No, hits=-3.2 required=5.0 	tests=AWL,BAYES_00,HK_OBFDOM,RCVD_IN_DNSWL_LOW,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from out2.smtp.messagingengine.com (HELO out2.smtp.messagingengine.com) (66.111.4.26)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 06 Oct 2009 14:40:30 +0000
Received: from compute1.internal (compute1.internal [10.202.2.41]) 	by gateway1.messagingengine.com (Postfix) with ESMTP id 666A8887F8 	for <cygwin-patches@cygwin.com>; Tue,  6 Oct 2009 10:40:28 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])   by compute1.internal (MEProxy); Tue, 06 Oct 2009 10:40:28 -0400
Received: from [192.168.1.3] (user-0c6sbc4.cable.mindspring.com [24.110.45.132]) 	by mail.messagingengine.com (Postfix) with ESMTPSA id 9EBD51F333; 	Tue,  6 Oct 2009 10:40:27 -0400 (EDT)
Message-ID: <4ACB56D5.4060606@cwilson.fastmail.fm>
Date: Tue, 06 Oct 2009 14:40:00 -0000
From: Charles Wilson <cygwin@cwilson.fastmail.fm>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Add wrappers for ExitProcess, TerminateProcess
References: <4ACA4323.5080103@cwilson.fastmail.fm> <20091005202722.GG12789@calimero.vinschen.de> <4ACA5BC7.6090908@cwilson.fastmail.fm> <20091006034229.GA12172@ednor.casa.cgf.cx> <4ACAC079.2020105@cwilson.fastmail.fm> <20091006074620.GA13712@calimero.vinschen.de>
In-Reply-To: <20091006074620.GA13712@calimero.vinschen.de>
Content-Type: multipart/mixed;  boundary="------------080106080909030400000607"
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q4/txt/msg00046.txt.bz2

This is a multi-part message in MIME format.
--------------080106080909030400000607
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 1376

Corinna Vinschen wrote:

> I can live with both variations, though I like the one entry point idea
> as in `cygwin_internal (CW_EXIT_PROCESS, UINT, bool)'  more.

As re-implemented, attached. (I used the windows BOOL type, rather than
the C99/C++ bool type).  Test case:


===================================
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
                   STATUS_ILLEGAL_DLL_RELOCATION,
                   TRUE);
//                   FALSE);
  exit (1);
}
===================================

$ gcc -o foo.exe foo.c
$ ./foo.exe
$ echo $?
127


2009-10-05  Charles Wilson  <...>

	Add cygwin wrapper for ExitProcess and TerminateProcess.
	* include/sys/cygwin.h: Declare new cygwin_getinfo_type
	CW_EXIT_PROCESS.
	* external.cc (exit_process): New function.
	(cygwin_internal): Handle CW_EXIT_PROCESS.
	* pinfo.h (pinfo::set_exit_code): New method.
	* pinfo.cc (pinfo::set_exit_code): New, refactored from...
	(pinfo::maybe_set_exit_code_from_windows): here. Call it.
	* exceptions.cc: Move global variable sigExeced...
	* globals.cc: here.

OK?

--
Chuck

--------------080106080909030400000607
Content-Type: text/plain;
 name="01-cygwin-terminate-process.patch-4"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="01-cygwin-terminate-process.patch-4"
Content-length: 6037

Index: winsup/cygwin/exceptions.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/exceptions.cc,v
retrieving revision 1.335
diff -u -p -r1.335 exceptions.cc
--- winsup/cygwin/exceptions.cc	19 Sep 2009 15:34:19 -0000	1.335
+++ winsup/cygwin/exceptions.cc	6 Oct 2009 13:47:35 -0000
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
+++ winsup/cygwin/external.cc	6 Oct 2009 13:47:36 -0000
@@ -32,6 +32,7 @@ details. */
 #include <iptypes.h>
 
 child_info *get_cygwin_startup_info ();
+static void exit_process (UINT, BOOL) __attribute__((noreturn));
 
 static winpids pids;
 
@@ -161,6 +162,37 @@ sync_winenv ()
   free (envblock);
 }
 
+/*
+ * Cygwin-specific wrapper for win32 ExitProcess and TerminateProcess.
+ * It ensures that the correct exit code, derived from the specified
+ * status value, will be made available to this process's parent (if
+ * that parent is also a cygwin process). If useTerminateProcess is
+ * TRUE, then TerminateProcess(GetCurrentProcess(),...) will be used;
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
+exit_process (UINT status, BOOL useTerminateProcess)
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
+	  BOOL useTerminateProcess = va_arg (arg, BOOL);
+	  exit_process (status, useTerminateProcess); /* no return */
+	}
 
       default:
 	break;
Index: winsup/cygwin/globals.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/globals.cc,v
retrieving revision 1.9
diff -u -p -r1.9 globals.cc
--- winsup/cygwin/globals.cc	24 Aug 2009 11:14:30 -0000	1.9
+++ winsup/cygwin/globals.cc	6 Oct 2009 13:47:36 -0000
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
+++ winsup/cygwin/pinfo.cc	6 Oct 2009 13:47:36 -0000
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
+++ winsup/cygwin/pinfo.h	6 Oct 2009 13:47:36 -0000
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
+++ winsup/cygwin/include/sys/cygwin.h	6 Oct 2009 13:47:36 -0000
@@ -142,7 +142,8 @@ typedef enum
     CW_CYGTLS_PADSIZE,
     CW_SET_DOS_FILE_WARNING,
     CW_SET_PRIV_KEY,
-    CW_SETERRNO
+    CW_SETERRNO,
+    CW_EXIT_PROCESS
   } cygwin_getinfo_types;
 
 #define CW_NEXTPID	0x80000000	/* or with pid to get next one */

--------------080106080909030400000607--
