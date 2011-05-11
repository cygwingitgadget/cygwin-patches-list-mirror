Return-Path: <cygwin-patches-return-7333-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 942 invoked by alias); 11 May 2011 14:21:49 -0000
Received: (qmail 918 invoked by uid 22791); 11 May 2011 14:21:45 -0000
X-SWARE-Spam-Status: No, hits=0.7 required=5.0	tests=AWL,BAYES_50,SPF_NEUTRAL,TW_GJ
X-Spam-Check-By: sourceware.org
Received: from smtp3.epfl.ch (HELO smtp3.epfl.ch) (128.178.224.226)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Wed, 11 May 2011 14:21:21 +0000
Received: (qmail 28092 invoked by uid 107); 11 May 2011 14:21:16 -0000
Received: from 206-248-130-97.dsl.teksavvy.com (HELO discarded) (206.248.130.97) (authenticated)  by smtp3.epfl.ch (AngelmatoPhylax SMTP proxy) with ESMTPA; Wed, 11 May 2011 16:21:17 +0200
Message-ID: <4DCA9B5A.4090606@cs.utoronto.ca>
Date: Wed, 11 May 2011 14:21:00 -0000
From: Ryan Johnson <ryan.johnson@cs.utoronto.ca>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.17) Gecko/20110414 Lightning/1.0b2 Thunderbird/3.1.10
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Improvements to fork handling
References: <4DCA2A48.6020208@cs.utoronto.ca> <20110511075953.GG28594@calimero.vinschen.de> <20110511141350.GA19557@ednor.casa.cgf.cx>
In-Reply-To: <20110511141350.GA19557@ednor.casa.cgf.cx>
Content-Type: multipart/mixed; boundary="------------040009080601090006060205"
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
X-SW-Source: 2011-q2/txt/msg00099.txt.bz2

This is a multi-part message in MIME format.
--------------040009080601090006060205
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 6126

On 11/05/2011 10:13 AM, Christopher Faylor wrote:
> On Wed, May 11, 2011 at 09:59:53AM +0200, Corinna Vinschen wrote:
>> On May 11 02:18, Ryan Johnson wrote:
>>> Please find attached five patches [...]
>> Oops, wrong mailing list...
>>
>> Btw., it would be nice if you could create patches with the diff -p flag
>> as well.  It's not exactly essential, but IMHO it's quite a help when
>> trying to review patches.
>>
>> Another problem is this:  While you provide separate patches, you don't
>> provide separate ChangeLogs.  That makes it kind of hard to apply them
>> separately.  Would you mind to create one ChangeLog per change?
> Ditto.  This really needs to be broken down into easier to review chunks.
All right. Let's try this again with the correct mailing list.

The patches have been generated with diff -p, and each includes 
appropriate changelog entries. Hopefully the changes are split up finely 
enough because I don't know a good way to break them down any further.

For posterity's sake I'm including the original message body below.

Ryan

Please find attached five patches which improve the behavior of forking 
when Windows isn't cooperating as well we'd like. The results are not as 
good as I'd originally hoped for, in that it's still entirely possible 
(even common) for fork attempts to fail, but at least now they are clean 
failures. Most sources of access violations should be gone, address 
space clobbers lead to clean child exit, and retries are applied 
consistently. It will still be important both to rebase and to 
ASLR-enable dlls, however, because there are too many sources of address 
space clobbers which we really can't control.

One open issue remains: windows dlls, thread stacks, and heaps can and 
do end up at different locations in the child. This technically breaks 
fork semantics but I don't know whether we care.  Since we currently 
have no real way to track this or compensate for it in the absence of 
obvious address space clobbers, the question is probably moot in any case.

The first patch (fork-clean-exit) allows a child which failed due to 
address space clobbers to report cleanly back to the parent. As a 
result, DLL_LINK which land wrong, DLL_LOAD whose space gets clobbered, 
and failure to replicate the cygheap, generate retries and dispense with 
the terminal spam. Handling of unexpected errors should not have 
changed. Further, the patch fixes several sources of access violations 
and crashes, including:
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

The second (fork-topsort) has the parent sort its dll list topologically 
by dependencies. Previously, attempts to load a DLL_LOAD dll risked 
pulling in dependencies automatically, and the latter would then not 
benefit from the code which "encourages" them to land in the right 
places. The dependency tracking is achieved using a simple class which 
allows to introspect a mapped dll image and pull out the dependencies it 
lists. The code currently rebuilds the dependency list at every fork 
rather than attempt to update it properly as modules are loaded and 
unloaded. Note that the topsort optimization affects only cygwin dlls, 
so any windows dlls which are pulled in dynamically (directly or 
indirectly) will still impose the usual risk of address space clobbers.

The third (fork-reserve-at) fixes a bug in the reserve_at function which 
caused it to sometimes reserve space needed by the dll it was supposed 
to help land. This happens when the dll tries to land in a free region 
which overlaps the desired location. The new code exploits the image 
introspection to get the dll's image size and avoids the corner cases.

The fourth (fork-dll-load) provides a rewrite to dll_list::load_after 
fork. The new version eliminates reserve_upto() and release_upto(), 
which were expensive (the process repeats for each dll) and buggy 
(release_upto could free allocations reserve_upto did not make). 
Instead, the effect of reserve_upto is achieved by recursively 
attempting to load each dll in its proper place and calling reserve_at 
before retrying; each reservation's location is kept on the stack 
throughout and release_at calls are made only when the recursion unwinds 
after all dlls have loaded. Further, the code (exploiting image 
introspection again) pre-reserves all space needed by each DLL_LOAD 
before starting the normal load process. This allows us to detect early 
whether Windows clobbered something from the start (allowing retry) and 
also ensures that the needed address space is not clobbered by later 
calls to reserve_at or by dlls allocating resources.

The fifth and final patch (fork-badd-addr) adds a small optimization 
which reserves the lower 4MB of address space early in the process's 
lifetime (even if it's not a forkee). This was motivated by the 
observation that Windows tends to move things around a lot in that area, 
increasing the probability of future fork failures if the parent allows 
cygwin dlls to land there.  The patch does not fully address the 
problem, however, because ASLR can move things around even in higher 
addresses. This patch is optional: it should be harmless but may or may 
not improve fork success rates: most fork failures for me involve 
DLL_LINK dlls which landed badly in the child.

--------------040009080601090006060205
Content-Type: text/plain;
 name="fork-clean-exit.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="fork-clean-exit.patch"
Content-length: 6269

diff --git a/ChangeLog b/ChangeLog
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,3 +1,26 @@
+2011-05-11  Ryan Johnson  <ryan.johnson@cs.utoronto.ca>
+
+	* child_info.h (fork_api_fatal): new macro for reporting to the
+	parent of a forked child that the fork cannot continue.
+	* dll_init.cc (dll_list::alloc): added code which aborts a fork
+	attempt if DLL_LINK dlls landed at the wrong base address in the
+	child.
+	(dll_list::load_after_fork): no longer set in_forkee=false
+	* dll_init.h (dll::run_dtors): don't do anything if
+	in_forkee=true. Prevents access violations during process teardown
+	when a fork attempt fails because of address space clobbers.
+	* fork.cc (frok::child): Set in_forkee=false at end of fork even
+	if no DLL_LOAD are present.
+	(frok::parent): Detect when forkee exited due to address space
+	clobbers and retry.
+	* heap.cc (heap_init): use fork_api_fatal for clean exit/retry of
+	failed fork.
+	* pinfo.h: define new EXITCODE_FORK_FAILED to aid clean exit/retry
+	of failed forks.
+	* sigproc.cc (child_info::proc_retry): Deal with clean exit/retry
+	of failed forkee.
+	(child_info_fork::handle_failure): ditto.
+
 2011-05-10  Christian Franke  <franke@computer.org>
 
 	* security.cc (check_registry_access): Handle missing
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
 

--------------040009080601090006060205
Content-Type: text/plain;
 name="fork-topsort.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="fork-topsort.patch"
Content-length: 7419

diff --git a/ChangeLog b/ChangeLog
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,3 +1,21 @@
+2011-05-11  Ryan Johnson  <ryan.johnson@cs.utoronto.ca>
+
+	* dll_init.cc (dll_list::find_by_modname): new function to search
+	the dll list for a module name only (no path).
+	(dll_list::alloc): Initialize newly-added members of struct dll.
+	(dll_list::append): new function to factor out the append
+	operation (used by dll_list::topsort).
+	(dll_list::populate_deps): new function to identify dll dependencies.
+	(dll_list::topsort): new function to sort the dll list
+	topologically by dependencies.
+	(dll_list::topsort_visit): new helper function for the above.
+	* dll_init.h (struct dll): added new class members for topsort.
+	(struct dll_list): declare topsort-related functions.
+	(struct pefile): allows simple introspection of dll images.
+	* fork.cc (fork): topsort the dll list before forking. When the
+	child loads each dll, all dependencies are already loaded and will
+	no longer risk being pulled in unexpectedly.
+
 2011-05-11  Ryan Johnson  <ryan.johnson@cs.utoronto.ca>
 
 	* child_info.h (fork_api_fatal): new macro for reporting to the
diff --git a/dll_init.cc b/dll_init.cc
--- a/dll_init.cc
+++ b/dll_init.cc
@@ -116,6 +116,18 @@ dll_list::operator[] (const PWCHAR name)
   return NULL;
 }
 
+/* Look for a dll based on is short name only (no path) */
+dll *
+dll_list::find_by_modname (const PWCHAR name)
+{
+  dll *d = &start;
+  while ((d = d->next) != NULL)
+    if (!wcscasecmp (name, d->modname))
+      return d;
+
+  return NULL;
+}
+
 #define RETRIES 1000
 
 /* Allocate space for a dll struct. */
@@ -152,14 +164,13 @@ dll_list::alloc (HINSTANCE h, per_proces
       d->handle = h;
       d->has_dtors = true;
       d->p = p;
+      d->ndeps = 0;
+      d->deps = NULL;
+      d->modname = wcsrchr (d->name, L'\\');
+      if (d->modname)
+	d->modname++;
       d->type = type;
-      if (end == NULL)
-	end = &start;	/* Point to "end" of dll chain. */
-      end->next = d;	/* Standard linked list stuff. */
-      d->next = NULL;
-      d->prev = end;
-      end = d;
-      tot++;
+      append (d);
       if (type == DLL_LOAD)
 	loaded_dlls++;
     }
@@ -168,6 +179,119 @@ dll_list::alloc (HINSTANCE h, per_proces
   return d;
 }
 
+void
+dll_list::append (dll* d)
+{
+  if (end == NULL)
+    end = &start;	/* Point to "end" of dll chain. */
+  end->next = d;	/* Standard linked list stuff. */
+  d->next = NULL;
+  d->prev = end;
+  end = d;
+  tot++;
+}
+
+void dll_list::populate_deps (dll* d)
+{
+  WCHAR wmodname[NT_MAX_PATH];
+  pefile* pef = (pefile*) d->handle;
+  PIMAGE_DATA_DIRECTORY dd = pef->idata_dir (IMAGE_DIRECTORY_ENTRY_IMPORT);
+  /* Annoyance: calling crealloc with a NULL pointer will use the
+     wrong heap and crash, so we have to replicate some code */
+  long maxdeps = 4;
+  d->deps = (dll**) cmalloc (HEAP_2_DLL, maxdeps*sizeof (dll*));
+  d->ndeps = 0;
+  for (PIMAGE_IMPORT_DESCRIPTOR id=
+	(PIMAGE_IMPORT_DESCRIPTOR) pef->rva (dd->VirtualAddress);
+      dd->Size && id->Name;
+      id++)
+    {
+      char* modname = pef->rva (id->Name);
+      sys_mbstowcs (wmodname, NT_MAX_PATH, modname);
+      if (dll* dep = find_by_modname (wmodname))
+	{
+	  if (d->ndeps >= maxdeps)
+	    {
+	      maxdeps = 2*(1+maxdeps);
+	      d->deps = (dll**) crealloc (d->deps, maxdeps*sizeof (dll*));
+	    }
+	  d->deps[d->ndeps++] = dep;
+	}
+    }
+  
+  /* add one to differentiate no deps from unknown */
+  d->ndeps++;
+}
+
+
+void
+dll_list::topsort ()
+{
+  /* Anything to do? */
+  if (!end)
+    return;
+  
+  /* make sure we have all the deps available */
+  dll* d = &start;
+  while ((d = d->next))
+    if (!d->ndeps)
+      populate_deps (d);
+  
+  /* unlink head and tail pointers so the sort can rebuild the list */
+  d = start.next;
+  start.next = end = NULL;
+  topsort_visit (d, true);
+
+  /* clear node markings made by the sort */
+  d = &start;
+  while ((d = d->next))
+    {
+      debug_printf ("%W", d->modname);
+      for (int i=1; i < -d->ndeps; i++)
+	debug_printf ("-> %W", d->deps[i-1]->modname);
+
+      /* It would be really nice to be able to keep this information
+	 around for next time, but we don't have an easy way to
+	 invalidate cached dependencies when a module unloads. */
+      d->ndeps = 0;
+      cfree (d->deps);
+      d->deps = NULL;
+    }
+}
+
+/* A recursive in-place topological sort. The result is ordered so that
+   dependencies of a dll appear before it in the list.
+
+   NOTE: this algorithm is guaranteed to terminate with a "partial
+   order" of dlls but does not do anything smart about cycles: an
+   arbitrary dependent dll will necessarily appear first. Perhaps not
+   surprisingly, Windows ships several dlls containing dependency
+   cycles, including SspiCli/RPCRT4.dll and a lovely tangle involving
+   USP10/LPK/GDI32/USER32.dll). Fortunately, we don't care about
+   Windows DLLs here, and cygwin dlls should behave better */
+void
+dll_list::topsort_visit (dll* d, bool seek_tail)
+{
+  /* Recurse to the end of the dll chain, then visit nodes as we
+     unwind. We do this because once we start visiting nodes we can no
+     longer trust any _next_ pointers.
+
+     We "mark" visited nodes (to avoid revisiting them) by negating
+     ndeps (undone once the sort completes). */
+  if (seek_tail && d->next)
+    topsort_visit (d->next, true);
+  
+  if (d->ndeps > 0)
+    {
+      d->ndeps = -d->ndeps;
+      for (long i=1; i < -d->ndeps; i++)
+	topsort_visit (d->deps[i-1], false);
+
+      append (d);
+    }
+}
+
+
 dll *
 dll_list::find (void *retaddr)
 {
diff --git a/dll_init.h b/dll_init.h
--- a/dll_init.h
+++ b/dll_init.h
@@ -52,6 +52,9 @@ struct dll
   int count;
   bool has_dtors;
   dll_type type;
+  long ndeps;
+  dll** deps;
+  PWCHAR modname;
   WCHAR name[1];
   void detach ();
   int init ();
@@ -84,6 +87,13 @@ public:
   void detach (void *);
   void init ();
   void load_after_fork (HANDLE);
+  dll *find_by_modname (const PWCHAR name);
+  void populate_all_deps ();
+  void populate_deps (dll* d);
+  void topsort ();
+  void topsort_visit (dll* d, bool goto_tail);
+  void append (dll* d);
+  
   dll *inext ()
   {
     while ((hold = hold->next))
@@ -109,6 +119,23 @@ public:
   dll_list () { protect.init ("dll_list"); }
 };
 
+/* References:
+   http://msdn.microsoft.com/en-us/windows/hardware/gg463125
+   http://msdn.microsoft.com/en-us/library/ms809762.aspx
+*/
+struct pefile {
+  IMAGE_DOS_HEADER dos_hdr;
+
+  char* rva (long offset) { return (char*) this + offset; }
+  PIMAGE_NT_HEADERS32 pe_hdr () { return (PIMAGE_NT_HEADERS32) rva (dos_hdr.e_lfanew); }
+  PIMAGE_OPTIONAL_HEADER32 optional_hdr () { return &pe_hdr ()->OptionalHeader; }
+  PIMAGE_DATA_DIRECTORY idata_dir (DWORD which)
+  {
+    PIMAGE_OPTIONAL_HEADER32 oh = optional_hdr ();
+    return (which < oh->NumberOfRvaAndSizes)? oh->DataDirectory + which : 0;
+  }
+};
+
 extern dll_list dlls;
 void dll_global_dtors ();
 
diff --git a/fork.cc b/fork.cc
--- a/fork.cc
+++ b/fork.cc
@@ -600,6 +600,12 @@ fork ()
        the problem to be out of temporary TLS path buffers. */
     tmp_pathbuf tp;
 
+    /* Put the dll list in topological dependency ordering, in
+       hopes that the child will have a better shot at loading dlls
+       properly if it only has to deal with one at a time.
+    */
+    dlls.topsort ();
+  
     if (!held_everything)
       {
 	if (exit_state)

--------------040009080601090006060205
Content-Type: text/plain;
 name="fork-reserve-at.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="fork-reserve-at.patch"
Content-length: 2989

diff --git a/ChangeLog b/ChangeLog
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,3 +1,11 @@
+2011-05-11  Ryan Johnson  <ryan.johnson@cs.utoronto.ca>
+
+	* dll_init.cc (dll_list::alloc): initialize dll::image_size.
+	(reserve_at): no longer reserves space needed by the target dll if
+	the latter overlaps the free region to be blocked.
+	(dll_list::load_after_fork): use new version of reserve_at.
+	* dll_init.h (struct dll): add new members to track dll size.
+
 2011-05-11  Ryan Johnson  <ryan.johnson@cs.utoronto.ca>
 
 	* dll_init.cc (dll_list::find_by_modname): new function to search
diff --git a/dll_init.cc b/dll_init.cc
--- a/dll_init.cc
+++ b/dll_init.cc
@@ -164,6 +164,7 @@ dll_list::alloc (HINSTANCE h, per_proces
       d->handle = h;
       d->has_dtors = true;
       d->p = p;
+      d->image_size = ((pefile*)h)->optional_hdr ()->SizeOfImage;
       d->ndeps = 0;
       d->deps = NULL;
       d->modname = wcsrchr (d->name, L'\\');
@@ -407,21 +408,33 @@ release_upto (const PWCHAR name, DWORD h
       }
 }
 
-/* Mark one page at "here" as reserved.  This may force
-   Windows NT to load a DLL elsewhere. */
+/* Reserve the chunk of free address space starting _here_ and (usually)
+   covering at least _dll_size_ bytes. However, we must take care not
+   to clobber the dll's target address range because it often overlaps.
+ */
 static DWORD
-reserve_at (const PWCHAR name, DWORD here)
+reserve_at (const PWCHAR name, DWORD here, DWORD dll_base, DWORD dll_size)
 {
   DWORD size;
   MEMORY_BASIC_INFORMATION mb;
 
   if (!VirtualQuery ((void *) here, &mb, sizeof (mb)))
-    size = 64 * 1024;
-
+    api_fatal ("couldn't examine memory at %08lx while mapping %W, %E",
+	       here, name);
   if (mb.State != MEM_FREE)
     return 0;
 
   size = mb.RegionSize;
+  
+  // don't clobber the space where we want the dll to land
+  DWORD end = here + size;
+  DWORD dll_end = dll_base + dll_size;
+  if (dll_base < here && dll_end > here)
+      here = dll_end; // the dll straddles our left edge
+  else if (dll_base >= here && dll_base < here)
+      end = dll_base; // the dll overlaps partly or fully to our right
+  
+  size = end - here;
   if (!VirtualAlloc ((void *) here, size, MEM_RESERVE, PAGE_NOACCESS))
     api_fatal ("couldn't allocate memory %p(%d) for '%W' alignment, %E\n",
                here, size, name);
@@ -499,7 +512,8 @@ dll_list::load_after_fork (HANDLE parent
              can in the child, due to differences in the load ordering.
              Block memory at it's preferred address and try again. */
           if ((DWORD) h > (DWORD) d->handle)
-            preferred_block = reserve_at (d->name, (DWORD) h);
+            preferred_block = reserve_at (d->name, (DWORD) h,
+					  (DWORD) d->handle, d->image_size);
 
 	}
 }
diff --git a/dll_init.h b/dll_init.h
--- a/dll_init.h
+++ b/dll_init.h
@@ -52,6 +52,7 @@ struct dll
   int count;
   bool has_dtors;
   dll_type type;
+  DWORD image_size;
   long ndeps;
   dll** deps;
   PWCHAR modname;

--------------040009080601090006060205
Content-Type: text/plain;
 name="fork-dll-load.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="fork-dll-load.patch"
Content-length: 11608

diff --git a/ChangeLog b/ChangeLog
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,3 +1,18 @@
+2011-05-11  Ryan Johnson  <ryan.johnson@cs.utoronto.ca>
+
+	* dll_init.cc (reserve_upto): removed (buggy, no longer needed)
+	(release_upto): ditto.
+	(dll_list::reserve_space): new function to reserve space needed by
+	DLL_LOAD dlls early in the fork process. Exit cleanly and report
+	to parent if fork failed due to clobbered address space.
+	(dll_list::load_after_fork): rewritten. New version uses recursion
+	to track reservations it makes while trying to make dlls land
+	where they belong.
+	(dll_list::load_after_fork_impl): see above.
+	* dll_init.h (struct dll_list): declare new functions.
+	* fork.cc (frok::child): call dll_list::reserve_space early, so we
+	can retry if it fails.
+
 2011-05-11  Ryan Johnson  <ryan.johnson@cs.utoronto.ca>
 
 	* dll_init.cc (dll_list::alloc): initialize dll::image_size.
diff --git a/dll_init.cc b/dll_init.cc
--- a/dll_init.cc
+++ b/dll_init.cc
@@ -357,56 +357,6 @@ dll_list::init ()
 
 #define A64K (64 * 1024)
 
-/* Mark every memory address up to "here" as reserved.  This may force
-   Windows NT to load a DLL in the next available, lowest slot. */
-static void
-reserve_upto (const PWCHAR name, DWORD here)
-{
-  DWORD size;
-  MEMORY_BASIC_INFORMATION mb;
-  for (DWORD start = 0x10000; start < here; start += size)
-    if (!VirtualQuery ((void *) start, &mb, sizeof (mb)))
-      size = A64K;
-    else
-      {
-	size = A64K * ((mb.RegionSize + A64K - 1) / A64K);
-	start = A64K * (((DWORD) mb.BaseAddress + A64K - 1) / A64K);
-
-	if (start + size > here)
-	  size = here - start;
-	if (mb.State == MEM_FREE &&
-	    !VirtualAlloc ((void *) start, size, MEM_RESERVE, PAGE_NOACCESS))
-	  api_fatal ("couldn't allocate memory %p(%d) for '%W' alignment, %E\n",
-		     start, size, name);
-      }
-}
-
-/* Release all of the memory previously allocated by "upto" above.
-   Note that this may also free otherwise reserved memory.  If that becomes
-   a problem, we'll have to keep track of the memory that we reserve above. */
-static void
-release_upto (const PWCHAR name, DWORD here)
-{
-  DWORD size;
-  MEMORY_BASIC_INFORMATION mb;
-  for (DWORD start = 0x10000; start < here; start += size)
-    if (!VirtualQuery ((void *) start, &mb, sizeof (mb)))
-      size = 64 * 1024;
-    else
-      {
-	size = mb.RegionSize;
-	if (!(mb.State == MEM_RESERVE && mb.AllocationProtect == PAGE_NOACCESS
-	    && (((void *) start < cygheap->user_heap.base
-		 || (void *) start > cygheap->user_heap.top)
-		 && ((void *) start < (void *) cygheap
-		     || (void *) start
-			> (void *) ((char *) cygheap + CYGHEAPSIZE)))))
-	  continue;
-	if (!VirtualFree ((void *) start, 0, MEM_RELEASE))
-	  api_fatal ("couldn't release memory %p(%d) for '%W' alignment, %E\n",
-		     start, size, name);
-      }
-}
 
 /* Reserve the chunk of free address space starting _here_ and (usually)
    covering at least _dll_size_ bytes. However, we must take care not
@@ -450,72 +400,130 @@ release_at (const PWCHAR name, DWORD her
                here, name);
 }
 
+/* Step 1: Reserve memory for all DLL_LOAD dlls. This is to prevent
+   anything else from taking their spot as we compensate for Windows
+   randomly relocating things.
+
+   NOTE: because we can't depend on LoadLibraryExW to do the right
+   thing, we have to do a vanilla VirtualAlloc instead. One possible
+   optimization might attempt a LoadLibraryExW first, in case it lands
+   in the right place, but then we have to find a way of tracking
+   which dlls ended up needing VirtualAlloc after all.  */
+void
+dll_list::reserve_space ()
+{
+  for (dll* d = dlls.istart (DLL_LOAD); d; d = dlls.inext ())
+    if (!VirtualAlloc (d->handle, d->image_size, MEM_RESERVE, PAGE_NOACCESS))
+      fork_api_fatal ("Address space needed by '%W' (%08lx) is already occupied",
+		      d->modname, d->handle);
+}
+
 /* Reload DLLs after a fork.  Iterates over the list of dynamically loaded
    DLLs and attempts to load them in the same place as they were loaded in the
    parent. */
 void
 dll_list::load_after_fork (HANDLE parent)
 {
-  DWORD preferred_block = 0;
+  // moved to frok::child for performance reasons:
+  // dll_list::reserve_space();
+  
+  load_after_fork_impl (parent, dlls.istart (DLL_LOAD), 0);
+}
 
-  for (dll *d = &dlls.start; (d = d->next) != NULL; )
-    if (d->type == DLL_LOAD)
-      for (int i = 0; i < 2; i++)
+static int const DLL_RETRY_MAX = 6;
+void dll_list::load_after_fork_impl (HANDLE parent, dll* d, int retries)
+{
+  /* Step 2: For each dll which did not map at its preferred base
+     address in the parent, try to coerce it to land at the same spot
+     as before. If not, unload it, reserve the memory around it, and
+     try again. Use recursion to remember blocked regions address
+     space so we can release them later.
+
+     We DONT_RESOLVE_DLL_REFERENCES at first in case the DLL lands in
+     the wrong spot;
+
+     NOTE: This step skips DLLs which loaded at their preferred
+     address in the parent because they should behave (we already
+     verified that their preferred address in the child is
+     available). However, this may fail on a Vista/Win7 machine with
+     ASLR active, because the ASLR base address will usually not equal
+     the preferred base recorded in the dll. In this case, we should
+     make the LoadLibraryExW call unconditional.
+   */
+  for ( ; d; d = dlls.inext ())
+    if (d->handle != d->preferred_base)
+      {
+	/* See if the DLL will load in proper place. If not, unload it,
+	   reserve the memory around it, and try again.
+
+	   If this is the first attempt, we need to release the
+	   dll's protective reservation from step 1
+	 */
+	if (!retries && !VirtualFree (d->handle, 0, MEM_RELEASE))
+	  api_fatal ("Unable to release protective reservation for %W (%08lx), %E",
+		     d->modname, d->handle);
+	
+	HMODULE h = LoadLibraryExW (d->name, NULL, DONT_RESOLVE_DLL_REFERENCES);
+	if (!h)
+	  api_fatal ("Unable to create interim mapping for %W, %E", d->name);
+	if (h != d->handle)
+	  {
+	    sigproc_printf ("%W loaded in wrong place: %08lx != %08lx",
+			    d->modname, h, d->handle);
+	    FreeLibrary (h);
+	    DWORD reservation = reserve_at (d->modname, (DWORD) h,
+					    (DWORD) d->handle, d->image_size);
+	    if (!reservation)
+	      api_fatal ("-> unable to block off %p to prevent %W from loading there",
+			 h, d->modname);
+
+	    if (retries < DLL_RETRY_MAX)
+	      load_after_fork_impl (parent, d, retries+1);
+	    else
+	      fork_api_fatal ("unable to remap %W to same address as parent (%08lx)",
+			      d->modname, d->handle);
+	      
+	    /* once the above returns all the dlls are mapped; release
+	       the reservation and continue unwinding */
+	    sigproc_printf ("Releasing blocked space at %08lx", reservation);
+	    release_at (d->modname, reservation);
+	    return;
+	  }
+      }
+
+  /* Step 3: try to load each dll for real after either releasing the
+     protective reservation (for well-behaved dlls) or unloading the
+     interim mapping (for rebased dlls) . The dll list is sorted in
+     dependency order, so we shouldn't pull in any additional dlls
+     outside our control.
+     
+     It stinks that we can't invert the order of the initial LoadLibrary
+     and FreeLibrary since Microsoft documentation seems to imply that
+     should do what we want.  However, once a library is loaded as
+     above, the second LoadLibrary will not execute its startup code
+     unless it is first unloaded. */
+  for (dll *d = dlls.istart (DLL_LOAD); d; d = dlls.inext ())
+    {
+      if (d->handle == d->preferred_base)
 	{
-	  /* See if DLL will load in proper place.  If so, free it and reload
-	     it the right way.
-	     It stinks that we can't invert the order of the initial LoadLibrary
-	     and FreeLibrary since Microsoft documentation seems to imply that
-	     should do what we want.  However, once a library is loaded as
-	     above, the second LoadLibrary will not execute its startup code
-	     unless it is first unloaded. */
-	  HMODULE h = LoadLibraryExW (d->name, NULL, DONT_RESOLVE_DLL_REFERENCES);
-
-	  if (!h)
-	    system_printf ("can't reload %W, %E", d->name);
-	  else
-	    {
-	      FreeLibrary (h);
-	      if (h == d->handle)
-		h = LoadLibraryW (d->name);
-	    }
-
-	  /* If we reached here on the second iteration of the for loop
-	     then there is a lot of memory to release. */
-	  if (i > 0)
-            {
-              release_upto (d->name, (DWORD) d->handle);
-
-              if (preferred_block)
-                release_at (d->name, preferred_block);
-              preferred_block = 0;
-            }
-
-	  if (h == d->handle)
-	    break;		/* Success */
-
-	  if (i > 0)
-	    /* We tried once to relocate the dll and it failed. */
-	    api_fatal ("unable to remap %W to same address as parent: %p != %p",
-		       d->name, d->handle, h);
-
-	  /* Dll loaded in the wrong place.  Dunno why this happens but it
-             always seems to happen when there are multiple DLLs with the
-             same base address.  In the "forked" process, the relocated DLL
-             may load at a different address. So, block all of the memory up
-             to the relocated load address and try again. */
-	  reserve_upto (d->name, (DWORD) d->handle);
-
-          /* Also, if the DLL loaded at a higher address than wanted (probably
-             it's base address), reserve the memory at that address. This can
-             happen if it couldn't load at the preferred base in the parent, but
-             can in the child, due to differences in the load ordering.
-             Block memory at it's preferred address and try again. */
-          if ((DWORD) h > (DWORD) d->handle)
-            preferred_block = reserve_at (d->name, (DWORD) h,
-					  (DWORD) d->handle, d->image_size);
-
+	  if (!VirtualFree (d->handle, 0, MEM_RELEASE))
+	    api_fatal ("Unable to release protective reservation for %W (%08lx), %E",
+		       d->modname, d->handle);
 	}
+      else
+	{
+	  /* Free the library using our parent's handle: it's identical
+	     to ours our we wouldn't have gotten this far */
+	  if (!FreeLibrary (d->handle))
+	    api_fatal ("unable to unload interim mapping of %W, %E", d->modname);
+	}
+      HMODULE h = LoadLibraryW (d->name);
+      if (!h)
+	api_fatal ("unable to map %W, %E", d->name);
+      if (h != d->handle)
+	api_fatal ("unable to map %W to same address as parent: %p != %p",
+		   d->modname, d->handle, h);
+    }
 }
 
 struct dllcrt0_info
diff --git a/dll_init.h b/dll_init.h
--- a/dll_init.h
+++ b/dll_init.h
@@ -88,6 +88,8 @@ public:
   void detach (void *);
   void init ();
   void load_after_fork (HANDLE);
+  void reserve_space ();
+  void load_after_fork_impl (HANDLE, dll* which, int retries);
   dll *find_by_modname (const PWCHAR name);
   void populate_all_deps ();
   void populate_deps (dll* d);
diff --git a/fork.cc b/fork.cc
--- a/fork.cc
+++ b/fork.cc
@@ -172,6 +172,12 @@ frok::child (volatile char * volatile he
   debug_printf ("child is running.  pid %d, ppid %d, stack here %p",
 		myself->pid, myself->ppid, __builtin_frame_address (0));
 
+  /* NOTE: Logically this belongs in dll_list::load_after_fork, but by
+     doing it here, before the first sync_with_parent, we can exploit
+     the existing retry mechanism in hopes of getting a more favorable
+     address space layout next time. */
+  dlls.reserve_space ();
+  
   sync_with_parent ("after longjmp", true);
   sigproc_printf ("hParent %p, load_dlls %d", hParent, load_dlls);
 

--------------040009080601090006060205
Content-Type: text/plain;
 name="fork-bad-addr.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="fork-bad-addr.patch"
Content-length: 3217

diff --git a/ChangeLog b/ChangeLog
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,3 +1,12 @@
+2011-05-11  Ryan Johnson  <ryan.johnson@cs.utoronto.ca>
+
+	* dcrt0.cc (dll_crt0_1): call dll_list::block_bad_address_space
+	* dll_init.cc (dll_list::block_bad_address_space): new function to
+	reserve all free space in the low 4MB. Reduces somewhat the
+	probability of a dynamic dll clashing with windows heaps or thread
+	stacks.
+	* dll_init.h (struct dll_list): declaration for above.
+
 2011-05-11  Ryan Johnson  <ryan.johnson@cs.utoronto.ca>
 
 	* dll_init.cc (reserve_upto): removed (buggy, no longer needed)
diff --git a/dcrt0.cc b/dcrt0.cc
--- a/dcrt0.cc
+++ b/dcrt0.cc
@@ -792,6 +792,13 @@ dll_crt0_1 (void *)
   main_vfork = vfork_storage.create ();
 #endif
 
+  /* Windows doesn't use the lower 4MB of address space consistently,
+     and those uses arise before cygwin1.dll loads. If a dll loads
+     there we risk being unable to fork later. To avoid the problem,
+     we just reserve everything that's left in that space -- windows
+     can still do what it wants since it got there first. */
+  dlls.block_bad_address_space ();
+  
   cygbench ("pre-forkee");
   if (in_forkee)
     {
diff --git a/dll_init.cc b/dll_init.cc
--- a/dll_init.cc
+++ b/dll_init.cc
@@ -358,6 +358,44 @@ dll_list::init ()
 #define A64K (64 * 1024)
 
 
+void
+dll_list::block_bad_address_space ()
+{
+  /* For some reason VirtualQuery doesn't return consistent values of
+     RegionSize for free space, so we have to compute it manually by
+     looking for MEM_FREE followed by a not-free region. We ensure not
+     to leave a danging free region by allowing the loop to examine
+     0x00400000, which is always the address of the application's
+     executable image.
+   */
+  MEMORY_BASIC_INFORMATION mb;
+  DWORD here;
+  for (DWORD i=A64K; i <= 64*A64K; i += mb.RegionSize)
+    {
+      if ( !VirtualQuery ((void*)i, &mb, sizeof(mb)))
+	api_fatal ("-> unable to examine address space at %08lx, %E", i);
+      here = (DWORD) mb.BaseAddress;
+      
+      /* this should never happen. If it does we'll need to write some
+	 code to compensate for it */
+      if (here != i)
+	api_fatal ("VirtualQuery returned info for %lx instead of %lx",
+		   here, i);
+      if (mb.State == MEM_FREE)
+	{
+	  DWORD size = mb.RegionSize, end = here + size;
+	  if (!VirtualAlloc ((void*) here, size, MEM_RESERVE, PAGE_NOACCESS))
+	    system_printf ("-> couldn't block out %08lx, %E", here);
+	}
+      else if (mb.RegionSize & (A64K-1))
+	{
+	  /* skip free space at the end of mapped slices -- they can't
+	     be used by anything else */
+	  mb.RegionSize = (mb.RegionSize + A64K - 1) & -A64K;
+	}
+    }
+}
+
 /* Reserve the chunk of free address space starting _here_ and (usually)
    covering at least _dll_size_ bytes. However, we must take care not
    to clobber the dll's target address range because it often overlaps.
diff --git a/dll_init.h b/dll_init.h
--- a/dll_init.h
+++ b/dll_init.h
@@ -82,6 +82,7 @@ public:
   int tot;
   int loaded_dlls;
   int reload_on_fork;
+  void block_bad_address_space ();
   dll *operator [] (const PWCHAR name);
   dll *alloc (HINSTANCE, per_process *, dll_type);
   dll *find (void *);

--------------040009080601090006060205--
