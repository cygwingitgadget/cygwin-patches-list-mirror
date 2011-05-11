Return-Path: <cygwin-patches-return-7337-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17046 invoked by alias); 11 May 2011 18:31:46 -0000
Received: (qmail 16882 invoked by uid 22791); 11 May 2011 18:31:43 -0000
X-SWARE-Spam-Status: No, hits=-1.0 required=5.0	tests=AWL,BAYES_00,SPF_NEUTRAL,TW_GJ
X-Spam-Check-By: sourceware.org
Received: from smtp3.epfl.ch (HELO smtp3.epfl.ch) (128.178.224.226)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Wed, 11 May 2011 18:31:26 +0000
Received: (qmail 495 invoked by uid 107); 11 May 2011 18:31:24 -0000
Received: from sb-gw15.cs.toronto.edu (HELO discarded) (128.100.3.15) (authenticated)  by smtp3.epfl.ch (AngelmatoPhylax SMTP proxy) with ESMTPA; Wed, 11 May 2011 20:31:24 +0200
Message-ID: <4DCAD5FB.9050508@cs.utoronto.ca>
Date: Wed, 11 May 2011 18:31:00 -0000
From: Ryan Johnson <ryan.johnson@cs.utoronto.ca>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.17) Gecko/20110414 Lightning/1.0b2 Thunderbird/3.1.10
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Improvements to fork handling (1/5)
Content-Type: multipart/mixed; boundary="------------060105000306040409030701"
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
X-SW-Source: 2011-q2/txt/msg00103.txt.bz2

This is a multi-part message in MIME format.
--------------060105000306040409030701
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 1405

Hi all,

This is the first of a series of patches, sent in separate emails as 
requested.

The first patch allows a child which failed due to address space 
clobbers to report cleanly back to the parent. As a result, DLL_LINK 
which land wrong, DLL_LOAD whose space gets clobbered, and failure to 
replicate the cygheap, generate retries and dispense with the terminal 
spam. Handling of unexpected errors should not have changed. Further, 
the patch fixes several sources of access violations and crashes, 
including:
- accessing invalid state after failing to notice that a 
statically-linked dll loaded at the wrong location
- accessing invalid state while running dtors on a failed forkee. I 
follow cgf's approach of simply not running any dtors, based on the 
observation that dlls in the parent (gcc_s!) can store state about other 
dlls and crash trying to access that state in the child, even if they 
appeared to map properly in both processes.
- attempting to generate a stack trace when somebody in the call chain 
used alloca(). This one is only sidestepped here, because we eliminate 
the access violations and api_fatal calls which would have triggered the 
problematic stack traces. I have a separate patch which allows offending 
functions to disable stack traces, if folks are interested, but it was 
kind of noisy so I left it out for now (cygwin uses alloca pretty 
liberally!).

Ryan

--------------060105000306040409030701
Content-Type: text/plain;
 name="fork-clean-exit.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="fork-clean-exit.patch"
Content-length: 5013

diff --git a/child_info.h b/child_info.h
--- a/child_info.h
+++ b/child_info.h
@@ -92,6 +92,18 @@ public:
   void alloc_stack_hard_way (volatile char *);
 };
 
+/* Several well-known problems can prevent us from patching up a
+   forkee; when such errors arise the child should exit cleanly (with
+   a failure code for the parent) rather than dumping stack.  */
+#define fork_api_fatal(fmt, args...)					\
+  do									\
+    {									\
+      sigproc_printf (fmt,## args);					\
+      fork_info->handle_failure (-1);					\
+    }									\
+  while(0)
+    
+
 class fhandler_base;
 
 class cygheap_exec_info
diff --git a/dll_init.cc b/dll_init.cc
--- a/dll_init.cc
+++ b/dll_init.cc
@@ -19,6 +19,7 @@ details. */
 #include "dtable.h"
 #include "cygheap.h"
 #include "pinfo.h"
+#include "child_info.h"
 #include "cygtls.h"
 #include "exception.h"
 #include <wchar.h>
@@ -131,10 +132,16 @@ dll_list::alloc (HINSTANCE h, per_proces
     {
       if (!in_forkee)
 	d->count++;	/* Yes.  Bump the usage count. */
+      else if (d->handle != h)
+	fork_api_fatal ("Location of %W changed from %p (parent) to %p (child)",
+			d->name, d->handle, h);
       d->p = p;
     }
   else
     {
+      if (in_forkee)
+	system_printf ("Unexpected dll loaded during fork: %W", name);
+      
       /* FIXME: Change this to new at some point. */
       d = (dll *) cmalloc (HEAP_2_DLL, sizeof (*d) + (namelen * sizeof (*name)));
 
@@ -371,7 +378,6 @@ dll_list::load_after_fork (HANDLE parent
             preferred_block = reserve_at (d->name, (DWORD) h);
 
 	}
-  in_forkee = false;
 }
 
 struct dllcrt0_info
diff --git a/dll_init.h b/dll_init.h
--- a/dll_init.h
+++ b/dll_init.h
@@ -57,7 +57,7 @@ struct dll
   int init ();
   void run_dtors ()
   {
-    if (has_dtors)
+    if (has_dtors && !in_forkee)
       {
 	has_dtors = 0;
 	p.run_dtors ();
diff --git a/fork.cc b/fork.cc
--- a/fork.cc
+++ b/fork.cc
@@ -233,6 +233,7 @@ frok::child (volatile char * volatile he
       sync_with_parent ("loaded dlls", true);
     }
 
+  in_forkee = false;
   init_console_handler (myself->ctty >= 0);
   ForceCloseHandle1 (fork_info->forker_finished, forker_finished);
 
@@ -393,10 +394,13 @@ frok::parent (volatile char * volatile s
 	  if (!exit_code)
 	    continue;
 	  this_errno = EAGAIN;
-	  /* Not thread safe, but do we care? */
-	  __small_sprintf (errbuf, "died waiting for longjmp before initialization, "
-			   "retry %d, exit code %p", ch.retry, exit_code);
-	  error = errbuf;
+	  if (exit_code != EXITCODE_FORK_FAILED)
+	    {
+	      /* Not thread safe, but do we care? */
+	      __small_sprintf (errbuf, "died waiting for longjmp before initialization, "
+			       "retry %d, exit code %p", ch.retry, exit_code);
+	      error = errbuf;
+	    }
 	  goto cleanup;
 	}
       break;
@@ -515,7 +519,8 @@ frok::parent (volatile char * volatile s
   if (!ch.sync (child->pid, pi.hProcess, FORK_WAIT_TIMEOUT))
     {
       this_errno = EAGAIN;
-      error = "died waiting for dll loading";
+      if (ch.exit_code != EXITCODE_FORK_FAILED)
+	  error = "died waiting for dll loading";
       goto cleanup;
     }
 
diff --git a/heap.cc b/heap.cc
--- a/heap.cc
+++ b/heap.cc
@@ -88,11 +88,11 @@ heap_init ()
 	  if ((reserve_size -= page_const) < allocsize)
 	    break;
 	}
-      if (!p && in_forkee && !fork_info->handle_failure (GetLastError ()))
-	api_fatal ("couldn't allocate heap, %E, base %p, top %p, "
-		   "reserve_size %d, allocsize %d, page_const %d",
-		   cygheap->user_heap.base, cygheap->user_heap.top,
-		   reserve_size, allocsize, page_const);
+      if (!p)
+	fork_api_fatal ("couldn't allocate heap, %E, base %p, top %p, "
+			"reserve_size %d, allocsize %d, page_const %d",
+			cygheap->user_heap.base, cygheap->user_heap.top,
+			reserve_size, allocsize, page_const);
       if (p != cygheap->user_heap.base)
 	api_fatal ("heap allocated at wrong address %p (mapped) != %p (expected)", p, cygheap->user_heap.base);
       if (allocsize && !VirtualAlloc (cygheap->user_heap.base, allocsize, MEM_COMMIT, PAGE_READWRITE))
diff --git a/pinfo.h b/pinfo.h
--- a/pinfo.h
+++ b/pinfo.h
@@ -36,6 +36,7 @@ enum picom
 #define EXITCODE_NOSET	0x4000000
 #define EXITCODE_RETRY	0x2000000
 #define EXITCODE_OK	0x1000000
+#define EXITCODE_FORK_FAILED 0x2200000
 
 class fhandler_pipe;
 
diff --git a/sigproc.cc b/sigproc.cc
--- a/sigproc.cc
+++ b/sigproc.cc
@@ -914,6 +914,9 @@ child_info::proc_retry (HANDLE h)
       if (retry-- > 0)
 	exit_code = 0;
       break;
+    case EXITCODE_FORK_FAILED: /* windows prevented us from forking */
+      break;
+      
     /* Count down non-recognized exit codes more quickly since they aren't
        due to known conditions.  */
     default:
@@ -932,8 +935,13 @@ child_info::proc_retry (HANDLE h)
 bool
 child_info_fork::handle_failure (DWORD err)
 {
-  if (retry > 0)
+  if (in_forkee && retry > 0)
     ExitProcess (EXITCODE_RETRY);
+  else
+    {
+      sigproc_printf ("Unable to fork.");
+      ExitProcess (EXITCODE_FORK_FAILED);
+    }
   return 0;
 }
 

--------------060105000306040409030701
Content-Type: text/plain;
 name="fork-clean-exit.changes"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="fork-clean-exit.changes"
Content-length: 1120

        * child_info.h (fork_api_fatal): new macro for reporting to the
        parent of a forked child that the fork cannot continue.
        * dll_init.cc (dll_list::alloc): added code which aborts a fork
        attempt if DLL_LINK dlls landed at the wrong base address in the
        child.
        (dll_list::load_after_fork): no longer set in_forkee=false
        * dll_init.h (dll::run_dtors): don't do anything if
        in_forkee=true. Prevents access violations during process teardown
        when a fork attempt fails because of address space clobbers.
        * fork.cc (frok::child): Set in_forkee=false at end of fork even
        if no DLL_LOAD are present.
        (frok::parent): Detect when forkee exited due to address space
        clobbers and retry.
        * heap.cc (heap_init): use fork_api_fatal for clean exit/retry of
        failed fork.
        * pinfo.h: define new EXITCODE_FORK_FAILED to aid clean exit/retry
        of failed forks.
        * sigproc.cc (child_info::proc_retry): Deal with clean exit/retry
        of failed forkee.
        (child_info_fork::handle_failure): ditto.

--------------060105000306040409030701--
