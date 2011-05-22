Return-Path: <cygwin-patches-return-7383-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10495 invoked by alias); 22 May 2011 01:41:54 -0000
Received: (qmail 10480 invoked by uid 22791); 22 May 2011 01:41:53 -0000
X-SWARE-Spam-Status: No, hits=-1.0 required=5.0	tests=AWL,BAYES_05,RCVD_IN_DNSWL_NONE,TW_GJ,UNPARSEABLE_RELAY
X-Spam-Check-By: sourceware.org
Received: from nm9.bullet.mail.bf1.yahoo.com (HELO nm9.bullet.mail.bf1.yahoo.com) (98.139.212.168)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Sun, 22 May 2011 01:41:37 +0000
Received: from [98.139.212.151] by nm9.bullet.mail.bf1.yahoo.com with NNFMP; 22 May 2011 01:41:36 -0000
Received: from [98.139.213.9] by tm8.bullet.mail.bf1.yahoo.com with NNFMP; 22 May 2011 01:41:36 -0000
Received: from [127.0.0.1] by smtp109.mail.bf1.yahoo.com with NNFMP; 22 May 2011 01:41:36 -0000
Received: from cgf.cx (cgf@173.48.46.160 with login)        by smtp109.mail.bf1.yahoo.com with SMTP; 21 May 2011 18:41:36 -0700 PDT
X-Yahoo-SMTP: jenXL62swBAWhMTL3wnej93oaS0ClBQOAKs8jbEbx_o-
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id A500D42804C	for <cygwin-patches@cygwin.com>; Sat, 21 May 2011 21:41:35 -0400 (EDT)
Date: Sun, 22 May 2011 01:41:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Improvements to fork handling (1/5)
Message-ID: <20110522014135.GA18936@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4DCAD5FB.9050508@cs.utoronto.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4DCAD5FB.9050508@cs.utoronto.ca>
User-Agent: Mutt/1.5.20 (2009-06-14)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q2/txt/msg00149.txt.bz2

On Wed, May 11, 2011 at 02:31:23PM -0400, Ryan Johnson wrote:
>Hi all,
>
>This is the first of a series of patches, sent in separate emails as 
>requested.
>
>The first patch allows a child which failed due to address space 
>clobbers to report cleanly back to the parent. As a result, DLL_LINK 
>which land wrong, DLL_LOAD whose space gets clobbered, and failure to 
>replicate the cygheap, generate retries and dispense with the terminal 
>spam. Handling of unexpected errors should not have changed. Further, 
>the patch fixes several sources of access violations and crashes, 
>including:
>- accessing invalid state after failing to notice that a 
>statically-linked dll loaded at the wrong location
>- accessing invalid state while running dtors on a failed forkee. I 
>follow cgf's approach of simply not running any dtors, based on the 
>observation that dlls in the parent (gcc_s!) can store state about other 
>dlls and crash trying to access that state in the child, even if they 
>appeared to map properly in both processes.
>- attempting to generate a stack trace when somebody in the call chain 
>used alloca(). This one is only sidestepped here, because we eliminate 
>the access violations and api_fatal calls which would have triggered the 
>problematic stack traces. I have a separate patch which allows offending 
>functions to disable stack traces, if folks are interested, but it was 
>kind of noisy so I left it out for now (cygwin uses alloca pretty 
>liberally!).
>
>Ryan

>diff --git a/child_info.h b/child_info.h
>--- a/child_info.h
>+++ b/child_info.h
>@@ -92,6 +92,18 @@ public:
>   void alloc_stack_hard_way (volatile char *);
> };
> 
>+/* Several well-known problems can prevent us from patching up a
>+   forkee; when such errors arise the child should exit cleanly (with
>+   a failure code for the parent) rather than dumping stack.  */
>+#define fork_api_fatal(fmt, args...)					\
>+  do									\
>+    {									\
>+      sigproc_printf (fmt,## args);					\
>+      fork_info->handle_failure (-1);					\
>+    }									\
>+  while(0)
>+    
>+
> class fhandler_base;
> 
> class cygheap_exec_info
>diff --git a/dll_init.cc b/dll_init.cc
>--- a/dll_init.cc
>+++ b/dll_init.cc
>@@ -19,6 +19,7 @@ details. */
> #include "dtable.h"
> #include "cygheap.h"
> #include "pinfo.h"
>+#include "child_info.h"
> #include "cygtls.h"
> #include "exception.h"
> #include <wchar.h>
>@@ -131,10 +132,16 @@ dll_list::alloc (HINSTANCE h, per_proces
>     {
>       if (!in_forkee)
> 	d->count++;	/* Yes.  Bump the usage count. */
>+      else if (d->handle != h)
>+	fork_api_fatal ("Location of %W changed from %p (parent) to %p (child)",
>+			d->name, d->handle, h);

You seem to be guranteeing a failure in a condition which could conceivably work
ok for simple applications, i.e., if a dll loads in a different location that
is not necessarily going to cause a problem.

>       d->p = p;
>     }
>   else
>     {
>+      if (in_forkee)
>+	system_printf ("Unexpected dll loaded during fork: %W", name);
>+      
>       /* FIXME: Change this to new at some point. */
>       d = (dll *) cmalloc (HEAP_2_DLL, sizeof (*d) + (namelen * sizeof (*name)));
> 
>@@ -371,7 +378,6 @@ dll_list::load_after_fork (HANDLE parent
>             preferred_block = reserve_at (d->name, (DWORD) h);
> 
> 	}
>-  in_forkee = false;
> }
> 
> struct dllcrt0_info
>diff --git a/dll_init.h b/dll_init.h
>--- a/dll_init.h
>+++ b/dll_init.h
>@@ -57,7 +57,7 @@ struct dll
>   int init ();
>   void run_dtors ()
>   {
>-    if (has_dtors)
>+    if (has_dtors && !in_forkee)
>       {
> 	has_dtors = 0;
> 	p.run_dtors ();

Isn't this already handled in dll_init.cc?

>diff --git a/fork.cc b/fork.cc
>--- a/fork.cc
>+++ b/fork.cc
>@@ -233,6 +233,7 @@ frok::child (volatile char * volatile he
>       sync_with_parent ("loaded dlls", true);
>     }
> 
>+  in_forkee = false;
>   init_console_handler (myself->ctty >= 0);
>   ForceCloseHandle1 (fork_info->forker_finished, forker_finished);
> 
>@@ -393,10 +394,13 @@ frok::parent (volatile char * volatile s
> 	  if (!exit_code)
> 	    continue;
> 	  this_errno = EAGAIN;
>-	  /* Not thread safe, but do we care? */
>-	  __small_sprintf (errbuf, "died waiting for longjmp before initialization, "
>-			   "retry %d, exit code %p", ch.retry, exit_code);
>-	  error = errbuf;
>+	  if (exit_code != EXITCODE_FORK_FAILED)
>+	    {
>+	      /* Not thread safe, but do we care? */
>+	      __small_sprintf (errbuf, "died waiting for longjmp before initialization, "
>+			       "retry %d, exit code %p", ch.retry, exit_code);
>+	      error = errbuf;
>+	    }
> 	  goto cleanup;
> 	}
>       break;
>@@ -515,7 +519,8 @@ frok::parent (volatile char * volatile s
>   if (!ch.sync (child->pid, pi.hProcess, FORK_WAIT_TIMEOUT))
>     {
>       this_errno = EAGAIN;
>-      error = "died waiting for dll loading";
>+      if (ch.exit_code != EXITCODE_FORK_FAILED)
>+	  error = "died waiting for dll loading";
>       goto cleanup;
>     }
> 
>diff --git a/heap.cc b/heap.cc
>--- a/heap.cc
>+++ b/heap.cc
>@@ -88,11 +88,11 @@ heap_init ()
> 	  if ((reserve_size -= page_const) < allocsize)
> 	    break;
> 	}
>-      if (!p && in_forkee && !fork_info->handle_failure (GetLastError ()))
>-	api_fatal ("couldn't allocate heap, %E, base %p, top %p, "
>-		   "reserve_size %d, allocsize %d, page_const %d",
>-		   cygheap->user_heap.base, cygheap->user_heap.top,
>-		   reserve_size, allocsize, page_const);
>+      if (!p)
>+	fork_api_fatal ("couldn't allocate heap, %E, base %p, top %p, "
>+			"reserve_size %d, allocsize %d, page_const %d",
>+			cygheap->user_heap.base, cygheap->user_heap.top,
>+			reserve_size, allocsize, page_const);

Why is the "in_forkee" dropped here?

cgf
