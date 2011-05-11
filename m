Return-Path: <cygwin-patches-return-7340-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18744 invoked by alias); 11 May 2011 18:33:11 -0000
Received: (qmail 18716 invoked by uid 22791); 11 May 2011 18:33:08 -0000
X-SWARE-Spam-Status: No, hits=-1.1 required=5.0	tests=AWL,BAYES_00,SPF_NEUTRAL
X-Spam-Check-By: sourceware.org
Received: from smtp0.epfl.ch (HELO smtp0.epfl.ch) (128.178.224.219)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Wed, 11 May 2011 18:32:53 +0000
Received: (qmail 30480 invoked by uid 107); 11 May 2011 18:32:51 -0000
Received: from sb-gw15.cs.toronto.edu (HELO discarded) (128.100.3.15) (authenticated)  by smtp0.epfl.ch (AngelmatoPhylax SMTP proxy) with ESMTPA; Wed, 11 May 2011 20:32:51 +0200
Message-ID: <4DCAD653.1090207@cs.utoronto.ca>
Date: Wed, 11 May 2011 18:33:00 -0000
From: Ryan Johnson <ryan.johnson@cs.utoronto.ca>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.17) Gecko/20110414 Lightning/1.0b2 Thunderbird/3.1.10
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Improvements to fork handling (4/5)
Content-Type: multipart/mixed; boundary="------------020304070101080502060900"
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
X-SW-Source: 2011-q2/txt/msg00106.txt.bz2

This is a multi-part message in MIME format.
--------------020304070101080502060900
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 954

Hi all,

This patch rewrites dll_list::load_after fork. The new version 
eliminates reserve_upto() and release_upto(), which were expensive (the 
process repeats for each dll) and buggy (release_upto could free 
allocations reserve_upto did not make). Instead, the effect of 
reserve_upto is achieved by recursively attempting to load each dll in 
its proper place and calling reserve_at before retrying; each 
reservation's location is kept on the stack throughout and release_at 
calls are made only when the recursion unwinds after all dlls have 
loaded. Further, the code (again exploiting image introspection from 
patch #2) pre-reserves all space needed by each DLL_LOAD before starting 
the normal load process. This allows us to detect early whether Windows 
clobbered something from the start (allowing retry) and also ensures 
that the needed address space is not clobbered by later calls to 
reserve_at or by dlls allocating resources.

Ryan


--------------020304070101080502060900
Content-Type: text/plain;
 name="fork-dll-load.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="fork-dll-load.patch"
Content-length: 11203

diff --git a/dll_init.cc b/dll_init.cc
--- a/dll_init.cc
+++ b/dll_init.cc
@@ -165,6 +165,7 @@ dll_list::alloc (HINSTANCE h, per_proces
       d->has_dtors = true;
       d->p = p;
       d->image_size = ((pefile*)h)->optional_hdr ()->SizeOfImage;
+      d->preferred_base = (void*) ((pefile*)h)->optional_hdr()->ImageBase;
       d->ndeps = 0;
       d->deps = NULL;
       d->modname = wcsrchr (d->name, L'\\');
@@ -357,56 +358,6 @@ dll_list::init ()
 
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
@@ -450,72 +401,130 @@ release_at (const PWCHAR name, DWORD her
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
@@ -53,6 +53,7 @@ struct dll
   bool has_dtors;
   dll_type type;
   DWORD image_size;
+  void* preferred_base;
   long ndeps;
   dll** deps;
   PWCHAR modname;
@@ -88,6 +89,8 @@ public:
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
 

--------------020304070101080502060900
Content-Type: text/plain;
 name="fork-dll-load.changes"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="fork-dll-load.changes"
Content-length: 820

        * dll_init.cc (reserve_upto): removed (buggy, no longer needed)
        (release_upto): ditto.
        (dll_list::reserve_space): new function to reserve space needed by
        DLL_LOAD dlls early in the fork process. Exit cleanly and report
        to parent if fork failed due to clobbered address space.
        (dll_list::load_after_fork): rewritten. New version uses recursion
        to track reservations it makes while trying to make dlls land
        where they belong.
        (dll_list::load_after_fork_impl): see above.
        (dll_list::alloc): initialize image base field.
        * dll_init.h (struct dll_list): declare new functions.
        (struct dll): add member to track image base.
        * fork.cc (frok::child): call dll_list::reserve_space early, so we
        can retry if it fails.

--------------020304070101080502060900--
