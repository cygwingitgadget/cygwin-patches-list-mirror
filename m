Return-Path: <cygwin-patches-return-6289-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 677 invoked by alias); 14 Mar 2008 01:46:11 -0000
Received: (qmail 663 invoked by uid 22791); 14 Mar 2008 01:46:10 -0000
X-Spam-Check-By: sourceware.org
Received: from dessent.net (HELO dessent.net) (69.60.119.225)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 14 Mar 2008 01:45:54 +0000
Received: from localhost ([127.0.0.1] helo=dessent.net) 	by dessent.net with esmtp (Exim 4.50) 	id 1JZyzY-00008a-Gs 	for cygwin-patches@cygwin.com; Fri, 14 Mar 2008 01:45:52 +0000
Message-ID: <47D9D8D3.17BC1E3B@dessent.net>
Date: Fri, 14 Mar 2008 01:46:00 -0000
From: Brian Dessent <brian@dessent.net>
Reply-To: cygwin-patches@cygwin.com
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [patch] recognise when an exec()d process terminates due to unhandled   exception
Content-Type: multipart/mixed;  boundary="------------09161E66BD4840ED8EF7F72F"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q1/txt/msg00063.txt.bz2

This is a multi-part message in MIME format.
--------------09161E66BD4840ED8EF7F72F
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-length: 4530


As we all know, Cygwin calls SetErrorMode (SEM_FAILCRITICALERRORS) to
suppress those pop up GUI messageboxes from the operating system when a
process encounters an unhandled exception.  This has the advantage of
making things more POSIX-like, and I'm sure people that run long
testsuites or unattended headless servers appreciate not coming in after
a long weeked to find that their server has been wedged for days waiting
for someone to click on "OK".

But of course if you follow the user list you also know that this is a
double edged sword, in that currently if a required DLL is missing there
is zero indication other than an curiously arbitrary exit status code of
53 decimal, or 0x35 hex which is the low byte of 0xC0000135,
STATUS_DLL_NOT_FOUND.

Anyway, the attached patch fixes all that by adding logic to let the
actual NTSTATUS logic percolate up to the waiting parent, so that it can
recognise these kinds of common(ish) faults and print a friendly message
-- or at least something other than silently dieing with no output.

After printing the message, the NTSTATUS is discarded and the exit
status code is replaced with a synthetic exit status corresponding to
"killed by SIGKILL" as read by the wait()ing parent, which means the
shell will also append "Killed" to that message.  I tried "0x80 |
SIGSEGV", corresponding to "segmentation fault and core dumped" but
since we aren't actually generating a core file, it seemed a little
weird to see the shell say that there was one generated.  The point here
is that the exit status that the parent (in most cases the shell) sees
is totally arbitrary, so we can put whatever makes the most sense
there.  I just figured that the shell printing "Killed" most closely
corresponds to the actual situation of the OS terminating the process
due to an unhandled exception.

There are three specific cases that I had in mind to handle with a
graceful message:

1. the user is missing a DLL
2. the DLL that is found is missing symbols
3. relocs in the .rdata section

In addition to catching and hopefully explaining those, it also prints a
generic default case for any other exception code.

Also, I'm attaching a Makefile that will create a test executable for
each of the three cases above.  It's totally standalone, you can type
"make check" and it will build and run the checks.  This is what the
current output looks like:

$ ./dll_not_found
dll_not_found.exe: one or more DLLs that this program requires cannot be
located by the system.  Make sure the PATH is correct and re-run the
setup program to install any packages indicated as necessary to satisfy
library dependencies.
Killed

$ ./missing_import
missing_import.exe: an entry point for one of more symbols could not be
found during program initialization.  Usually this means an incorrect
or out of date version of one or more DLLs is being erroniously found
on the PATH.
Killed

$ ./rdata_relocs     
rdata_relocs.exe: the process encountered an unhandled access violation
fault.
If this happens immediately and consistently at process startup,
one likely cause is relocs in the .rdata section as a result of
the runtime pseudo-reloc feature being applied to data imports
in 'const' structures.  Relinking with a linker script that marks
the .rdata section writeable can solve this problem.
Killed

In all three of these cases, the current behavior is that you would get
a GUI popup box from csrss.exe if you ran them from strace (since strace
does not call SetErrorMode() and that setting is inherited) but you get
absolutely no indication of an error if you run them from a Cygwin
process... other than $? if you know to check it.

I'm not 100% convinced that the change to the sigproc/pinfo stuff is
totally correct and safe, as it's pretty involved code and I had to
scatch my head for a while to figure out how everything interacts.  So
please do kick the tires.

BTW, when you *do* get the GUI popup messageboxes, they are helpful in
that the identify the precise DLL that's missing or the function that
isn't present, etc.  I was really hoping to figure out a cool way to get
that info, perhaps by poking around in the TEB or PEB somewhere, but I
haven't gotten that far.  If anyone has any general ideas where to look
for NTLDR's internal state, I'm all ears.  I have a hunch it would be
possible to get if we were running the exec'd process in a debugger loop
and pumping WaitForDebugEvent() messages, since those can have
parameters attached to exception codes.  But that's a little too
extreme.

Brian
--------------09161E66BD4840ED8EF7F72F
Content-Type: text/plain; charset=us-ascii;
 name="unhandled_exception.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="unhandled_exception.patch"
Content-length: 8537

2008-03-13  Brian Dessent  <brian@dessent.net>

	* ntdll.h: Add several missing NTSTATUS defines.
	* pinfo.cc (pinfo::maybe_set_exit_code_from_windows): Recognise
	and preserve the exit status of a child that terminated with
	an unhandled exception.
	(pinfo::exit): Make the whole NTSTATUS exit code available to
	the wait()ing parent when an exec()d process fails due to
	an unhandled exception.
	* pinfo.h (class _pinfo): Fix comment.  New bool member.
	* sigproc.cc (stopped_or_terminated): Recognise and explain
	several common causes of process creation failure based on
	NTSTATUS.

 ntdll.h    |    6 ++++++
 pinfo.cc   |   38 ++++++++++++++++++++++++++++++++++----
 pinfo.h    |    5 ++++-
 sigproc.cc |   55 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 98 insertions(+), 6 deletions(-)

Index: ntdll.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/ntdll.h,v
retrieving revision 1.79
diff -u -p -r1.79 ntdll.h
--- ntdll.h	15 Feb 2008 17:53:10 -0000	1.79
+++ ntdll.h	14 Mar 2008 01:10:09 -0000
@@ -37,6 +37,12 @@
 #define STATUS_INVALID_LEVEL          ((NTSTATUS) 0xc0000148)
 #define STATUS_BUFFER_OVERFLOW        ((NTSTATUS) 0x80000005)
 #define STATUS_NO_MORE_FILES          ((NTSTATUS) 0x80000006)
+#define STATUS_DLL_NOT_FOUND          ((NTSTATUS) 0xC0000135)
+#define STATUS_ENTRYPOINT_NOT_FOUND   ((NTSTATUS) 0xC0000139)
+#define STATUS_BAD_DLL_ENTRYPOINT     ((NTSTATUS) 0xC0000251)
+#define STATUS_ILLEGAL_DLL_RELOCATION ((NTSTATUS) 0xC0000269)
+
+
 #define PDI_MODULES 0x01
 #define PDI_HEAPS 0x04
 #define LDRP_IMAGE_DLL 0x00000004
Index: pinfo.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/pinfo.cc,v
retrieving revision 1.243
diff -u -p -r1.243 pinfo.cc
--- pinfo.cc	7 Mar 2008 11:24:51 -0000	1.243
+++ pinfo.cc	14 Mar 2008 01:10:09 -0000
@@ -118,7 +118,30 @@ pinfo::maybe_set_exit_code_from_windows 
 						// process hasn't quite exited
 						// after closing pipe
       GetExitCodeProcess (hProcess, &x);
+      
+      /* If the process terminated due to an unhandled exception, the exit
+         code will contain the NTSTATUS code of that exception.  Unless we
+         have special handling for this situation, it will appear that the
+         child simply exited with some strange error code and no indication
+         of a fault.  For example, if a DLL is missing on the path, then
+         x will equal 0xC0000135 or STATUS_DLL_NOT_FOUND.  But the user
+         will simply see a $? of 0x35 and thier app will fail to start,
+         and it will be indistinguishable from the perfectly legitimate
+         program that wants to call exit(0x35).  So, make the assumption
+         that any exit code >= 0xc0000000 was due to an unhandled exception,
+         and keep the whole value of the code rather than truncating it
+         to fit in the POSIX semantics of an exit status.  */
+      if (x >= 0xc0000000UL)
+        {
+          self->exitcode = x;
+          self->terminated_unhandled = true;
+          sigproc_printf("pid %d died with unhandled exception %p",
+                         self->pid, x);
+          return;
+        }
+             
       self->exitcode = EXITCODE_SET | (sigExeced ?: (x & 0xff) << 8);
+      self->terminated_unhandled = false;
     }
   sigproc_printf ("pid %d, exit value - old %p, windows %p, cygwin %p",
 		  self->pid, oexitcode, x, self->exitcode);
@@ -127,7 +150,7 @@ pinfo::maybe_set_exit_code_from_windows 
 void
 pinfo::exit (DWORD n)
 {
-  minimal_printf ("winpid %d, exit %d", GetCurrentProcessId (), n);
+  minimal_printf ("winpid %d, exit %x", GetCurrentProcessId (), n);
   lock_process until_exit ();
   cygthread::terminate ();
 
@@ -146,8 +169,13 @@ pinfo::exit (DWORD n)
   struct rusage r;
   fill_rusage (&r, hMainProc);
   add_rusage (&self->rusage_self, &r);
-  int exitcode = self->exitcode & 0xffff;
-  if (!self->cygstarted)
+
+  int exitcode;
+  if (self->terminated_unhandled)
+    exitcode = self->exitcode;   // pass exception code whole
+  else if (!self->cygstarted)
+    exitcode = self->exitcode & 0xffff; // win32 parent no grok Posix
+  else
     exitcode = ((exitcode & 0xff) << 8) | ((exitcode >> 8) & 0xff);
   sigproc_printf ("Calling ExitProcess n %p, exitcode %p", n, exitcode);
   ExitProcess (exitcode);
@@ -817,7 +845,9 @@ proc_waiter (void *arg)
 	  CloseHandle (vchild.rd_proc_pipe);
 	  vchild.rd_proc_pipe = NULL;
 	  vchild.maybe_set_exit_code_from_windows ();
-	  if (WIFEXITED (vchild->exitcode))
+	  if (vchild->terminated_unhandled)
+            si.si_code = CLD_DUMPED;
+	  else if (WIFEXITED (vchild->exitcode))
 	    si.si_code = CLD_EXITED;
 	  else if (WCOREDUMP (vchild->exitcode))
 	    si.si_code = CLD_DUMPED;
Index: pinfo.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/pinfo.h,v
retrieving revision 1.105
diff -u -p -r1.105 pinfo.h
--- pinfo.h	15 Feb 2008 17:53:10 -0000	1.105
+++ pinfo.h	14 Mar 2008 01:10:09 -0000
@@ -45,11 +45,14 @@ public:
   pid_t pid;
 
   /* Various flags indicating the state of the process.  See PID_
-     constants below. */
+     constants in <sys/cygwin.h>. */
   DWORD process_state;
 
   DWORD exitcode;	/* set when process exits */
 
+  /* If process was terminated by an unhandled exception.  */
+  bool terminated_unhandled;
+  
 #define PINFO_REDIR_SIZE ((char *) &myself.procinfo->exitcode - (char *) myself.procinfo)
 
   /* > 0 if started by a cygwin process */
Index: sigproc.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/sigproc.cc,v
retrieving revision 1.308
diff -u -p -r1.308 sigproc.cc
--- sigproc.cc	1 Mar 2008 14:53:44 -0000	1.308
+++ sigproc.cc	14 Mar 2008 01:10:09 -0000
@@ -32,6 +32,7 @@ details. */
 #include "cygtls.h"
 #include "sigproc.h"
 #include "exceptions.h"
+#include "ntdll.h"
 
 /*
  * Convenience defines
@@ -1068,7 +1069,59 @@ stopped_or_terminated (waitq *parent_w, 
     }
   else
     {
-      w->status = (__uint16_t) child->exitcode;
+      if (child->terminated_unhandled)
+        {
+          /* Since this proc has been through exec'd, the progname field
+             contains a full absolute Win32 path.  */
+          char *exename = strrchr (child->progname, '\\');
+          if (exename == NULL)
+            exename = child->progname;
+          else
+            exename++;
+
+          /* exitcode is actually the NTSTATUS of the unhandled exception,
+             not a POSIX exit code.  Try to give the user some indication
+             that something is busted, rather than silently exiting.  */
+          switch (child->exitcode)
+            {
+              case STATUS_DLL_NOT_FOUND:
+                small_printf (
+"%s: one or more DLLs that this program requires cannot be\n"
+"located by the system.  Make sure the PATH is correct and re-run the\n"
+"setup program to install any packages indicated as necessary to satisfy\n"
+"library dependencies.\n", exename);
+                break;
+
+              case STATUS_ENTRYPOINT_NOT_FOUND:
+                small_printf (
+"%s: an entry point for one of more symbols could not be\n"
+"found during program initialization.  Usually this means an incorrect\n"
+"or out of date version of one or more DLLs is being erroniously found\n"
+"on the PATH.\n", exename);
+                break;
+
+              case STATUS_ACCESS_VIOLATION:
+                small_printf (
+"%s: the process encountered an unhandled access violation fault.\n"
+"If this happens immediately and consistently at process startup,\n"
+"one likely cause is relocs in the .rdata section as a result of\n"
+"the runtime pseudo-reloc feature being applied to data imports\n"
+"in 'const' structures.  Relinking with a linker script that marks\n"
+"the .rdata section writeable can solve this problem.\n", exename);
+                break;                              
+
+              default:
+                small_printf (
+                    "%s: terminated with unhandled exception %08x.\n",
+                    exename, child->exitcode);
+                break;
+            }
+
+          /* Synthesize something resembling an unhandled exception.  */
+          w->status = SIGKILL;
+        }
+      else
+        w->status = (__uint16_t) child->exitcode;
 
       add_rusage (&myself->rusage_children, &child->rusage_children);
       add_rusage (&myself->rusage_children, &child->rusage_self);

--------------09161E66BD4840ED8EF7F72F
Content-Type: text/plain; charset=us-ascii;
 name="Makefile"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Makefile"
Content-length: 1151


.PHONY: all clean

TESTPROGS := dll_not_found.exe missing_import.exe rdata_relocs.exe

all: $(TESTPROGS)

check: $(TESTPROGS)
	for F in $(TESTPROGS); do ./$$F; echo; done

clean:
	-rm *.exe *.o *.dll *.dll.a *.c

%.o: %.c
	$(CC) -c $< -o $@

foo.c:
	echo -e 'int main (int argc, char **argv) { foo(); }' >$@

libnoexist.dll.a: 
	bash -c "dlltool --input-def <(echo -e 'EXPORTS\nfoo') \
	        --dllname noexist.dll --output-lib $@"

dll_not_found.exe: foo.o libnoexist.dll.a 
	$(CC) -o $@ $^
	@echo

nofoolib.c:
	echo "int not_foo() { }" >$@

nofoolib.dll: nofoolib.o
	$(CC) -shared -o $@ $^

libfoolib.dll.a:
	bash -c "dlltool --input-def <(echo -e 'EXPORTS\nfoo') \
	        --dllname nofoolib.dll --output-lib $@"

missing_import.exe: foo.o libfoolib.dll.a nofoolib.dll
	$(CC) -o $@ $^
	@echo

rdata_lib.c:
	echo -e '__declspec(dllexport) int dataimp;' >$@

rdata_lib.dll: rdata_lib.o
	$(CC) -shared -o $@ $^

rdata_main.c:
	echo -e 'extern int dataimp; \
	         const struct { int *p } var = { &dataimp }; \
	         int main (int argc, char **argv) { return 0; }' >$@

rdata_relocs.exe: rdata_main.o rdata_lib.dll
	$(CC) -o $@ $^
	@echo

	
--------------09161E66BD4840ED8EF7F72F--
