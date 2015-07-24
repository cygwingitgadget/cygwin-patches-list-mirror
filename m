Return-Path: <cygwin-patches-return-8226-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15326 invoked by alias); 24 Jul 2015 15:43:34 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 15315 invoked by uid 89); 24 Jul 2015 15:43:34 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=0.5 required=5.0 tests=AWL,BAYES_50,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2
X-HELO: smtp.salomon.at
Received: from smtp.salomon.at (HELO smtp.salomon.at) (193.186.16.13) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Fri, 24 Jul 2015 15:43:22 +0000
Received: from samail03.wamas.com ([172.28.2.2] helo=mailhost.salomon.at)	by smtp.salomon.at with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)	(Exim 4.80.1)	(envelope-from <michael.haubenwallner@ssi-schaefer.com>)	id 1ZIf7z-0002JE-8O; Fri, 24 Jul 2015 17:43:18 +0200
Received: from [172.28.41.34]	by mailhost.salomon.at with esmtp (Exim 4.77)	(envelope-from <michael.haubenwallner@ssi-schaefer.com>)	id 1ZIf7z-0006Nr-2Y; Fri, 24 Jul 2015 17:43:15 +0200
Message-ID: <55B25D13.8040007@ssi-schaefer.com>
Date: Fri, 24 Jul 2015 15:43:00 -0000
From: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [PATCH] winsup/cygwin: Protect fork() against dll- and exe-updates.
Content-Type: multipart/mixed; boundary="------------000104050501020109090205"
X-SW-Source: 2015-q3/txt/msg00008.txt.bz2

This is a multi-part message in MIME format.
--------------000104050501020109090205
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-length: 2178

Hi!

When starting to port Gentoo Prefix to Cygwin, the first real problem
discovered is that fork() does use the original executable's location
to Create the child's Process, probably finding linked dlls that just
have emerged in the current directory (sth. like /my/prefix/usr/bin),
causing "Loaded different DLL with same basename in forked child" errors.

Diving into the details, I'm coming up with (a patch-draft based on) the
idea to create hardlinks for the binaries-in-use into some cygwin-specific
directory, like \proc\<ntpid>\object\ ('ve seen this name on AIX),
and use these hardlinks instead to create the new child's process.

Thoughts so far?

For now, when <cygroot>\proc\ directory does exist, the patch (roughly) does:

For /bin/bash.exe, cygwin1.dll creates these hardlinks at process startup:
  \proc\<ntpid>\object\bash.exe         -> /bin/bash.exe
  \proc\<ntpid>\object\bash.exe.local      (empty file for dll redirection)
  \proc\<ntpid>\object\cygwin1.dll      -> /bin/cygwin1.dll
  \proc\<ntpid>\object\cygreadline7.dll -> /bin/cygreadline7.dll

And frok::parent then does:

  CreateProcess("\proc\<ntpid>\object\bash.exe", "/bin/bash.exe", ...)

Resulting in another \proc\<ntpid>\object\ directory with same hardlinks.

While attached patch does work so far already, there's a few issues:

*) dll-redirection for LoadLibrary using "app.exe.local" file does operate on
   the dll's basename only, breaking perl's Hash::Util and List::Util at least.
   So creating hardlinks for dynamically loaded dlls is disabled for now.
   Eventually, manifests and/or app.exe.config could help here, but I'm still
   failing to really grok them...

*) Who can clean up \proc\<ntpid>\ directory after power-loss or similar?
   For now, if stale \proc\<ntpid>\ is found, it is removed beforehand.
   But when this was from a different user, cleanup will fail. However,
   using \proc\S-<current-user-id>\<ntpid>\ instead could help here...

*) Is it really necessary to create these hardlinks in the real filesystem?
   I could imagine to create them directly in $Recycle.bin instead, or some
   (other) memory-only thing...

Thoughts welcome!

Thank you!
/haubi/

--------------000104050501020109090205
Content-Type: text/x-patch;
 name="0001-Protect-fork-against-dll-and-exe-updates.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-Protect-fork-against-dll-and-exe-updates.patch"
Content-length: 29788

From 7bcae68c5b8c3b55e9abeafcd7493e2c50243474 Mon Sep 17 00:00:00 2001
From: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
Date: Tue, 21 Jul 2015 16:15:05 +0200
Subject: [PATCH] Protect fork() against dll- and exe-updates.

To support in-cygwin package managers, fork() implementation must not
use .exe and .dll files from the original directories, as the package
managers' job is to update these files. Instead, keep a hardlink to the
originally binaries in <cygroot>\\proc\\<ntpid>\\object\\ and use them
during fork.

Creating an app.exe.local file also redirects LoadLibrary calls with
absolute file names to this directory, using the loaded dll's basename.

However, as there may be multiple dlls with identical basenames (perl:
Hash::Util and List::Util), I have not found a way yet for LoadLibrary
with absolute file names to redirect using something more significant
than just the dll's basename.
So we do not create hardlinks for dynamically loaded dlls for now.

As only a few users probably need an update-safe fork, the hardlink
creation is enabled only when <cygroot>\\proc\\<ntpid>\\ can be created.
That is, when <cygroot>\\proc\\ does not exist, nothing happends - users
have to create that directory manually for now.

	* dll_init.h (enum dll_type): Define DLL_SELF.
	(struct dll): Declare member procfs_name. Declare methods
	delete_procfs_hardlink, create_procfs_hardlink,
	nominate_procfs_hardlink. Implement method forkedname, returning
	procfs_name when available, or original name otherwise.
	(struct dll_list): Declare members proc_ntpid_object__name,
	proc_ntpid_object__size, procfs_creation_ntpid, main_executable.
	Declare methods nominate_proc_ntpid_object_dir,
	create_proc_ntpid_object_dir, delete_proc_ntpid_object_dir,
	cleanup_procfs, find_by_forkedname.
	Declare static method fixup_path.
	* dll_init.cc (in_load_after_fork): Define earlier in file.
	(nt_max_path_buf): New, local to file.
	(struct dll): Implement delete_procfs_hardlink,
	create_procfs_hardlink, nominate_procfs_hardlink.
	(struct dll_list): Implement find_by_forkedname, fixup_path,
	nominate_proc_ntpid_object_dir, create_proc_ntpid_object_dir,
	delete_proc_ntpid_object_dir, cleanup_procfs,
	(dll_list::alloc): Move path-fixups into fixup_path. Use
	nt_max_path_buf. On first call, calculate
	proc_ntpid_object__size, allocate proc_ntpid_object__name.
	Search for registered dll using find_by_forkedname when
	in_load_after_fork. For new dll entry, reserve space for
	dll::procfs_name and call dll::nominate_procfs_hardlink.
	Do not indicate has_dtors for DLL_SELF.
	(dll_list::init): Alloc cygwin_hmodule and main_executable as
	DLL_SELF, create proc_ntpid_object_dir and procfs_hardlinks.
	(dll_list::load_after_fork): Do reload dll's parent handle only.
	Re-nominate and create proc_ntpid_object_dir, procfs_hardlinks.
	(dll_list::load_after_fork_impl): Load dlls using
	dll::forkedname.
	(dll_dllcrt0_1): Split up result-calculation, to execute
	dll::create_procfs_hardlink for the dynamically loaded dll
	before dll::init.
	* fork.cc (frok::child): Without dynamically loaded dll's, run
	dll_list::load_after_fork with null-parent handle, to get the
	procfs_hardlinks created.
	(frok::parent): Use dll_list::main_executable's forkedname for
	new CreateProcess.
	* pinfo.cc (pinfo::exit): Run dll_info::cleanup_procfs.
	* syscalls.cc (_unlink_nt): New, static, renamed from unlink_nt,
	with shareable as additional argument.
	(unlink_nt): New, wrap _unlink_nt for original behaviour.
	(unlink_nt_shareable): New, wrap _unlink_nt to keep hardlinked
	files still useable as binaries while removing their hardlinks.
---
 winsup/cygwin/dll_init.cc | 435 +++++++++++++++++++++++++++++++++++++++++-----
 winsup/cygwin/dll_init.h  |  19 ++
 winsup/cygwin/fork.cc     |  10 +-
 winsup/cygwin/pinfo.cc    |   3 +
 winsup/cygwin/syscalls.cc |  24 ++-
 5 files changed, 444 insertions(+), 47 deletions(-)

diff --git a/winsup/cygwin/dll_init.cc b/winsup/cygwin/dll_init.cc
index 313b0ff..02df6fc 100644
--- a/winsup/cygwin/dll_init.cc
+++ b/winsup/cygwin/dll_init.cc
@@ -22,6 +22,7 @@ details. */
 #include "child_info.h"
 #include "cygtls.h"
 #include "exception.h"
+#include "ntdll.h"
 #include <wchar.h>
 #include <sys/reent.h>
 #include <assert.h>
@@ -37,6 +38,12 @@ muto dll_list::protect;
 
 static bool dll_global_dtors_recorded;
 
+/* We need the in_load_after_fork flag so dll_dllcrt0_1 can decide at fork
+   time if this is a linked DLL or a dynamically loaded DLL.  In either case,
+   both, cygwin_finished_initializing and in_forkee are true, so they are not
+   sufficient to discern the situation. */
+static bool NO_COPY in_load_after_fork;
+
 /* Run destructors for all DLLs on exit. */
 void
 dll_global_dtors ()
@@ -81,6 +88,119 @@ per_module::run_dtors ()
     (*pfunc) ();
 }
 
+void
+dll::delete_procfs_hardlink ()
+{
+  if (!*procfs_name)
+    return; /* disabled */
+
+  UNICODE_STRING fn;
+  RtlInitUnicodeString (&fn, procfs_name);
+
+  /* Allow concurrent processes to use the same dll or exe
+   * via their hardlink while we delete our hardlink. */
+  extern NTSTATUS unlink_nt_shareable (path_conv &pc);
+
+  path_conv pc (&fn);
+  NTSTATUS ret = unlink_nt_shareable (pc);
+  debug_printf ("%y = unlink_nt_shareable (%W)", ret, procfs_name);
+}
+
+/* create hardlink to an individual DLL into /proc/<pid>/object/ */
+void
+dll::create_procfs_hardlink (PCWCHAR origin)
+{
+  if (!*procfs_name)
+    return; /* disabled */
+
+  if (!origin || !*origin)
+    origin = name;
+
+  int ret = CreateHardLinkW (procfs_name, origin, NULL);
+  if (ret)
+    {
+      debug_printf ("%d = CreateHardLinkW (%W -> %W)%s",
+	  ret, procfs_name, origin,
+	  in_load_after_fork ? " in load after fork" : "");
+      return;
+    }
+  debug_printf ("%d = CreateHardLinkW (%W -> %W)%s %E",
+      ret, procfs_name, origin,
+      in_load_after_fork ? " in load after fork" : "");
+  if (GetLastError () == ERROR_ALREADY_EXISTS)
+    {
+      delete_procfs_hardlink (); /* an orphaned one */
+      ret = CreateHardLinkW (procfs_name, origin, NULL);
+      if (ret)
+	debug_printf ("%d = CreateHardLinkW (%W -> %W)%s",
+	    ret, procfs_name, origin,
+	    in_load_after_fork ? " in load after fork" : "");
+      else
+	debug_printf ("%d = CreateHardLinkW (%W -> %W)%s %E",
+	    ret, procfs_name, origin,
+	    in_load_after_fork ? " in load after fork" : "");
+    }
+  if (!ret)
+    *procfs_name = L'\0'; /* disabling */
+}
+
+void
+dll::nominate_procfs_hardlink (PCWCHAR objdir_)
+{
+  if (!objdir_ || !*objdir_)
+    {
+      /* disabling */
+      procfs_name[0] = L'\0';
+      return;
+    }
+
+  PCWCHAR src;
+  PWCHAR tgt;
+  switch (type)
+    {
+      case DLL_SELF:
+      case DLL_LINK:
+	wcscpy (procfs_name, objdir_);
+	wcscat (procfs_name, modname);
+	break;
+      case DLL_LOAD:
+	/* Disabled: app.exe.local does DLL redirection based on their
+	 * modname only, but LoadLibrary with absolute paths may load
+	 * multiple modules having identical modname. Also, loading a
+	 * dll in forkee with different modname gives different handle.
+	 * Eventually, manifests could help here instead. */
+	procfs_name[0] = L'\0';
+	break;
+
+	wcscpy (procfs_name, objdir_);
+	/* Avoid extra directories for loaded dll's:
+	 * mangle full path into single filename instead. */
+	src = name;
+        tgt = procfs_name + wcslen (procfs_name);
+	while (*src)
+	  {
+	    switch (*src)
+	      {
+		case L'\\':
+		  *(tgt++) = L',';
+		  break;
+		case L'?':
+		case L':':
+		  *(tgt++) = L'_';
+		  break;
+		default:
+		  *(tgt++) = *src;
+		  break;
+	      }
+	    src++;
+	  }
+	*tgt = L'\0';
+	break;
+      default:
+	break;
+    }
+}
+
 /* Initialize an individual DLL */
 int
 dll::init ()
@@ -173,17 +293,26 @@ dll_list::find_by_modname (const PWCHAR modname)
   return NULL;
 }
 
-#define RETRIES 1000
-
-/* Allocate space for a dll struct. */
+/* Look for a dll based on the name used
+ * to dynamically reload in forked child. */
 dll *
-dll_list::alloc (HINSTANCE h, per_process *p, dll_type type)
+dll_list::find_by_forkedname (PCWCHAR name)
+{
+  dll *d = &start;
+  while ((d = d->next) != NULL)
+    if (!wcscasecmp (name, d->forkedname ()))
+      return d;
+
+  return NULL;
+}
+
+/* Remove some path specification starters.
+ * As the result never is longer than the input,
+ * returns the pointer into the argument buffer
+ * behind these starters. */
+PWCHAR
+dll_list::fixup_path (PWCHAR name)
 {
-  /* Called under loader lock conditions so this function can't be called
-     multiple times in parallel.  A static buffer is safe. */
-  static WCHAR buf[NT_MAX_PATH];
-  GetModuleFileNameW (h, buf, NT_MAX_PATH);
-  PWCHAR name = buf;
   if (!wcsncmp (name, L"\\\\?\\", 4))
     {
       name += 4;
@@ -193,14 +322,45 @@ dll_list::alloc (HINSTANCE h, per_process *p, dll_type type)
 	  *name = L'\\';
 	}
     }
+  return name;
+}
+
+#define RETRIES 1000
+
+/* Use this buffer under loader lock conditions only. */
+static WCHAR nt_max_path_buf[NT_MAX_PATH];
+
+/* Allocate space for a dll struct. */
+dll *
+dll_list::alloc (HINSTANCE h, per_process *p, dll_type type)
+{
+  /* Called under loader lock conditions so this function can't be called
+     multiple times in parallel.  The static buffer is safe. */
+  GetModuleFileNameW (h, nt_max_path_buf, NT_MAX_PATH);
+  PWCHAR name = fixup_path (nt_max_path_buf);
   DWORD namelen = wcslen (name);
   PWCHAR modname = wcsrchr (name, L'\\') + 1;
 
   guard (true);
+
+  if (!proc_ntpid_object__size)
+    {
+      proc_ntpid_object__size = wcslen (cygheap->installation_root);
+      /* max string length is "/proc/<maxpid>/object/",
+       * sync format with nominate_proc_ntpid_object_dir () */
+      proc_ntpid_object__size += sizeof (L"\\proc\\2147483647\\object\\");
+      proc_ntpid_object__name = (PWCHAR) cmalloc (HEAP_2_DLL, proc_ntpid_object__size * sizeof (*proc_ntpid_object__name));
+      nominate_proc_ntpid_object_dir ();
+    }
+
   /* Already loaded?  For linked DLLs, only compare the basenames.  Linked
      DLLs are loaded using just the basename and the default DLL search path.
-     The Windows loader picks up the first one it finds.  */
-  dll *d = (type == DLL_LINK) ? dlls.find_by_modname (modname) : dlls[name];
+     The Windows loader picks up the first one it finds.
+     This also applies to cygwin1.dll and the main executable (DLL_SELF).
+     When in_load_after_fork, dynamically loaded dll's are reloaded
+     using their parent's procfs_name, if available. */
+  dll *d = (type <= DLL_LINK) ? dlls.find_by_modname (modname) :
+	   in_load_after_fork ? dlls.find_by_forkedname (name) : dlls[name];
   if (d)
     {
       if (!in_forkee)
@@ -228,7 +388,7 @@ dll_list::alloc (HINSTANCE h, per_process *p, dll_type type)
   else
     {
       /* FIXME: Change this to new at some point. */
-      d = (dll *) cmalloc (HEAP_2_DLL, sizeof (*d) + (namelen * sizeof (*name)));
+      d = (dll *) cmalloc (HEAP_2_DLL, sizeof (*d) + ((namelen + proc_ntpid_object__size + namelen) * sizeof (*name)));
 
       /* Now we've allocated a block of information.  Fill it in with the
 	 supplied info about this DLL. */
@@ -236,13 +396,15 @@ dll_list::alloc (HINSTANCE h, per_process *p, dll_type type)
       wcscpy (d->name, name);
       d->modname = d->name + (modname - name);
       d->handle = h;
-      d->has_dtors = true;
+      d->has_dtors = type > DLL_SELF;
       d->p = p;
       d->ndeps = 0;
       d->deps = NULL;
       d->image_size = ((pefile*)h)->optional_hdr ()->SizeOfImage;
       d->preferred_base = (void*) ((pefile*)h)->optional_hdr()->ImageBase;
       d->type = type;
+      d->procfs_name = d->name + namelen + 1;
+      d->nominate_procfs_hardlink (proc_ntpid_object__name);
       append (d);
       if (type == DLL_LOAD)
 	loaded_dlls++;
@@ -396,7 +558,7 @@ dll_list::detach (void *retaddr)
   if (!myself || in_forkee)
     return;
   guard (true);
-  if ((d = find (retaddr)))
+  if ((d = find (retaddr)) && d->type != DLL_SELF)
     {
       if (d->count <= 0)
 	system_printf ("WARNING: trying to detach an already detached dll ...");
@@ -408,6 +570,7 @@ dll_list::detach (void *retaddr)
 	  if (!exit_state)
 	    __cxa_finalize (d->handle);
 	  d->run_dtors ();
+	  d->delete_procfs_hardlink ();
 	  d->prev->next = d->next;
 	  if (d->next)
 	    d->next->prev = d->prev;
@@ -425,11 +588,30 @@ dll_list::detach (void *retaddr)
 void
 dll_list::init ()
 {
+  /* for cygwin1.dll and main executable: maintain hardlinks only */
+  alloc (cygwin_hmodule, user_data, DLL_SELF);
+  main_executable = alloc (GetModuleHandle (NULL), user_data, DLL_SELF);
+
+  bool created = create_proc_ntpid_object_dir ();
+  if (!created)
+    {
+      /* nt_max_path_buf contains last directory tried to create */
+      debug_printf ("%W not created, fork is not protected against dll-updates",
+		    nt_max_path_buf);
+      *proc_ntpid_object__name = L'\0';
+    }
+
   /* Walk the dll chain, initializing each dll */
   dll *d = &start;
   dll_global_dtors_recorded = d->next != NULL;
   while ((d = d->next))
-    d->init ();
+    {
+      if (!created) /* de-nominate */
+	d->nominate_procfs_hardlink (proc_ntpid_object__name);
+      d->create_procfs_hardlink ();
+      if (d->type > DLL_SELF) /* linked and early loaded dlls */
+	d->init ();
+    }
 }
 
 #define A64K (64 * 1024)
@@ -494,12 +676,6 @@ dll_list::reserve_space ()
 	      d->modname, d->handle);
 }
 
-/* We need the in_load_after_fork flag so dll_dllcrt0_1 can decide at fork
-   time if this is a linked DLL or a dynamically loaded DLL.  In either case,
-   both, cygwin_finished_initializing and in_forkee are true, so they are not
-   sufficient to discern the situation. */
-static bool NO_COPY in_load_after_fork;
-
 /* Reload DLLs after a fork.  Iterates over the list of dynamically loaded
    DLLs and attempts to load them in the same place as they were loaded in the
    parent. */
@@ -509,9 +685,27 @@ dll_list::load_after_fork (HANDLE parent)
   // moved to frok::child for performance reasons:
   // dll_list::reserve_space();
 
-  in_load_after_fork = true;
-  load_after_fork_impl (parent, dlls.istart (DLL_LOAD), 0);
-  in_load_after_fork = false;
+  if (parent)
+    {
+      in_load_after_fork = true;
+      load_after_fork_impl (parent, dlls.istart (DLL_LOAD), 0);
+      in_load_after_fork = false;
+    }
+
+  nominate_proc_ntpid_object_dir ();
+  if (!create_proc_ntpid_object_dir ())
+    *proc_ntpid_object__name = L'\0';
+
+  dll *d = &start;
+  while ((d = d->next))
+    {
+      /* Called under loader lock conditions so this function can't be called
+	 multiple times in parallel.  The static buffer is safe. */
+      wcsncpy (nt_max_path_buf, d->forkedname (), NT_MAX_PATH);
+      d->nominate_procfs_hardlink (proc_ntpid_object__name);
+      /* hardlink to parent's procfs_name rather than original name */
+      d->create_procfs_hardlink (nt_max_path_buf);
+    }
 }
 
 static int const DLL_RETRY_MAX = 6;
@@ -544,18 +738,19 @@ void dll_list::load_after_fork_impl (HANDLE parent, dll* d, int retries)
 	   dll's protective reservation from step 1
 	 */
 	if (!retries && !VirtualFree (d->handle, 0, MEM_RELEASE))
-	  fabort ("unable to release protective reservation for %W (%p), %E",
-		  d->modname, d->handle);
+	  fabort ("unable to release protective reservation (%p) for %W (using %W), %E",
+		  d->handle, d->name, d->forkedname ());
 
-	HMODULE h = LoadLibraryExW (d->name, NULL, DONT_RESOLVE_DLL_REFERENCES);
+	HMODULE h = LoadLibraryExW (d->forkedname (), NULL, DONT_RESOLVE_DLL_REFERENCES);
 	if (!h)
-	  fabort ("unable to create interim mapping for %W, %E", d->name);
+	  fabort ("unable to create interim mapping for %W (using %W), %E",
+		  d->name, d->forkedname ());
 	if (h != d->handle)
 	  {
-	    sigproc_printf ("%W loaded in wrong place: %p != %p",
-			    d->modname, h, d->handle);
+	    sigproc_printf ("%W (using %W) loaded in wrong place: %p != %p",
+			    d->name, d->forkedname (), h, d->handle);
 	    FreeLibrary (h);
-	    PVOID reservation = reserve_at (d->modname, h,
+	    PVOID reservation = reserve_at (d->forkedname (), h,
 					    d->handle, d->image_size);
 	    if (!reservation)
 	      fabort ("unable to block off %p to prevent %W from loading there",
@@ -565,12 +760,12 @@ void dll_list::load_after_fork_impl (HANDLE parent, dll* d, int retries)
 	      load_after_fork_impl (parent, d, retries+1);
 	    else
 	       fabort ("unable to remap %W to same address as parent (%p) - try running rebaseall",
-		       d->modname, d->handle);
+		       d->forkedname (), d->handle);
 
 	    /* once the above returns all the dlls are mapped; release
 	       the reservation and continue unwinding */
 	    sigproc_printf ("releasing blocked space at %p", reservation);
-	    release_at (d->modname, reservation);
+	    release_at (d->forkedname (), reservation);
 	    return;
 	  }
       }
@@ -586,23 +781,172 @@ void dll_list::load_after_fork_impl (HANDLE parent, dll* d, int retries)
 	{
 	  if (!VirtualFree (d->handle, 0, MEM_RELEASE))
 	    fabort ("unable to release protective reservation for %W (%p), %E",
-		    d->modname, d->handle);
+		    d->forkedname (), d->handle);
 	}
       else
 	{
 	  /* Free the library using our parent's handle: it's identical
 	     to ours or we wouldn't have gotten this far */
 	  if (!FreeLibrary (d->handle))
-	    fabort ("unable to unload interim mapping of %W, %E",
-		    d->modname);
+	    fabort ("unable to unload interim mapping of %W (using %W), %E",
+		    d->name, d->forkedname ());
 	}
-      HMODULE h = LoadLibraryW (d->name);
+      HMODULE h = LoadLibraryW (d->forkedname ());
       if (!h)
-	fabort ("unable to map %W, %E", d->name);
+	fabort ("unable to map %W (using %W), %E", d->name, d->forkedname ());
       if (h != d->handle)
-	fabort ("unable to map %W to same address as parent: %p != %p",
-		d->modname, d->handle, h);
+	fabort ("unable to map %W (using %W) to same address as parent: %p != %p",
+		d->name, d->forkedname (), d->handle, h);
+    }
+}
+
+void
+dll_list::nominate_proc_ntpid_object_dir ()
+{
+  if (!proc_ntpid_object__name)
+    return;
+
+  /* sync format with max string length in alloc () */
+  __small_swprintf (proc_ntpid_object__name, L"%W\\proc\\%d\\object\\",
+      cygheap->installation_root, GetCurrentProcessId ());
+
+  /* FIXME: WTF, cygheap->installation_root starts with "\??\", not "\\?\" */
+  if (!wcsncmp (proc_ntpid_object__name, L"\\??\\", 4))
+    proc_ntpid_object__name[1] = L'\\';
+
+  PWCHAR fixed = fixup_path (proc_ntpid_object__name);
+  if (fixed != proc_ntpid_object__name)
+    memmove (proc_ntpid_object__name, fixed, (wcslen (fixed) + 1) * sizeof (*fixed));
+}
+
+bool
+dll_list::create_proc_ntpid_object_dir ()
+{
+  bool valid = true;
+
+  if (!proc_ntpid_object__name || !*proc_ntpid_object__name)
+    return false; /* disabled */
+
+  /* Called under loader lock conditions so this function can't be called
+     multiple times in parallel.  The static buffer is safe. */
+  wcsncpy (nt_max_path_buf, proc_ntpid_object__name, NT_MAX_PATH);
+
+#define ABSENT_PROC_DIR_DISABLES_HARDLINKS
+#ifdef ABSENT_PROC_DIR_DISABLES_HARDLINKS
+  /* do not create "<cygroot>\\proc" if missing, disable hardlinks instead */
+  PWCHAR separators[2]; /* separators in "<ntpid>\\objects\\" */
+#else
+  /* do create "<cygroot>\\proc" if missing */
+  PWCHAR separators[3]; /* separators in "proc\\<ntpid>\\objects\\" */
+#endif
+
+  int i = sizeof (separators) / sizeof (separators[0]);
+  while (i--)
+    {
+      separators[i] = wcsrchr (nt_max_path_buf, L'\\');
+      if (!separators[i])
+	{
+	  system_printf ("missing 'proc\\<ntpid>\\object\\' in '%W'",
+	      proc_ntpid_object__name);
+	  valid = false;
+	  break;
+	}
+      *separators[i] = L'\0';
+    }
+
+  procfs_creation_ntpid = GetCurrentProcessId ();
+
+  while (++i < (int)(sizeof (separators) / sizeof (separators[0])))
+    {
+      if (valid)
+	{
+	  BOOL ret = CreateDirectoryW (nt_max_path_buf, &sec_none_nih);
+	  if (ret)
+	    debug_printf ("%d = CreateDirectoryW (%W)%s",
+	      ret, nt_max_path_buf, in_load_after_fork ? " in load after fork" : "");
+	  else
+	  if (GetLastError () != ERROR_ALREADY_EXISTS)
+	    {
+	      debug_printf ("%d = CreateDirectoryW (%W [%d])%s %E",
+		ret, nt_max_path_buf, i, in_load_after_fork ? " in load after fork" : "");
+	      valid = false;
+	      break; /* leave last tried directory in nt_max_path_buf */
+	    }
+	}
+      *separators[i] = L'\\';
+    }
+
+  if (valid && main_executable)
+    {
+      wcsncat (nt_max_path_buf, main_executable->modname, NT_MAX_PATH);
+      wcsncat (nt_max_path_buf, L".local", NT_MAX_PATH);
+      HANDLE hlocal = CreateFileW (
+		nt_max_path_buf,          // lpFileName
+		GENERIC_WRITE,            // dwResiredAccess
+		FILE_SHARE_READ,          // dwShareMode
+		&sec_none_nih,            // lpSecurityAttributes
+		CREATE_ALWAYS,            // dwCreationDisposition
+		0,                        // dwFlagsAndAttributes
+		NULL);                    // hTemplateFile
+      if (hlocal != INVALID_HANDLE_VALUE)
+	{
+	  debug_printf ("%p = CreateFileW (%W)", hlocal, nt_max_path_buf);
+	  CloseHandle (hlocal);
+	}
+      else
+	debug_printf ("%p = CreateFileW (%W) %E", hlocal, nt_max_path_buf);
+    }
+
+  return valid;
+}
+
+void
+dll_list::delete_proc_ntpid_object_dir ()
+{
+  if (!proc_ntpid_object__name || !*proc_ntpid_object__name)
+    return; /* disabled */
+
+  /* Called under loader lock conditions so this function can't be called
+     multiple times in parallel.  The static buffer is safe. */
+  wcsncpy (nt_max_path_buf, proc_ntpid_object__name, NT_MAX_PATH);
+  wcsncat (nt_max_path_buf, main_executable->modname, NT_MAX_PATH);
+  wcsncat (nt_max_path_buf, L".local", NT_MAX_PATH);
+
+  PWCHAR p;
+  for (int i = 3; i && (p = wcsrchr (nt_max_path_buf, L'\\')); i--)
+    {
+      UNICODE_STRING dn;
+      RtlInitUnicodeString (&dn, nt_max_path_buf);
+
+      extern NTSTATUS unlink_nt (path_conv &pc);
+
+      path_conv pc (&dn);
+      NTSTATUS ret = unlink_nt (pc);
+      debug_printf ("%y = unlink_nt %W", ret, nt_max_path_buf);
+      *p = L'\0';
+    }
+}
+
+void
+dll_list::cleanup_procfs ()
+{
+  if (!proc_ntpid_object__name || !*proc_ntpid_object__name)
+    return; /* disabled */
+
+  if (procfs_creation_ntpid != GetCurrentProcessId ())
+    {
+      /* Some child cygwin-process failed to call load_after_fork ();
+       * Do not cleanup the parent's one, just yell a little. */
+      system_printf ("skip for winpid %d, created by %d",
+	  GetCurrentProcessId (), procfs_creation_ntpid);
+      return;
     }
+
+  dll *d = &start;
+  while ((d = d->next))
+    d->delete_procfs_hardlink ();
+
+  delete_proc_ntpid_object_dir ();
 }
 
 struct dllcrt0_info
@@ -684,10 +1028,19 @@ dll_dllcrt0_1 (VOID *x)
      initialize the DLL.  If we haven't finished initializing,
      it may not be safe to call the dll's "main" since not
      all of cygwin's internal structures may have been set up. */
-  if (!d || (!linked && !d->init ()))
+  if (!d)
     res = (PVOID) -1;
   else
+  if (linked)
     res = (PVOID) d;
+  else
+    {
+      d->create_procfs_hardlink ();
+      if (!d->init ())
+	res = (PVOID) -1;
+      else
+	res = (PVOID) d;
+    }
 }
 
 #ifndef __x86_64__
diff --git a/winsup/cygwin/dll_init.h b/winsup/cygwin/dll_init.h
index 8127d0b..bbfb51b 100644
--- a/winsup/cygwin/dll_init.h
+++ b/winsup/cygwin/dll_init.h
@@ -43,6 +43,7 @@ struct per_module
 typedef enum
 {
   DLL_NONE,
+  DLL_SELF, /* anyprogram.exe, cygwin1.dll */
   DLL_LINK,
   DLL_LOAD,
   DLL_ANY
@@ -61,8 +62,12 @@ struct dll
   DWORD image_size;
   void* preferred_base;
   PWCHAR modname;
+  PWCHAR procfs_name; /* "<cygroot>\\proc\\<ntpid>\\object\\*.dll" */
   WCHAR name[1];
   void detach ();
+  void delete_procfs_hardlink ();
+  void create_procfs_hardlink (PCWCHAR origin = NULL);
+  void nominate_procfs_hardlink (PCWCHAR);
   int init ();
   void run_dtors ()
   {
@@ -72,6 +77,10 @@ struct dll
 	p.run_dtors ();
       }
   }
+  PWCHAR forkedname ()
+  {
+    return procfs_name && *procfs_name ? procfs_name : name;
+  }
 };
 
 #define MAX_DLL_BEFORE_INIT     100
@@ -82,10 +91,15 @@ class dll_list
   dll *hold;
   dll_type hold_type;
   static muto protect;
+  PWCHAR proc_ntpid_object__name; /* "<cygroot>\\proc\\<ntpid>\\object\\" */
+  DWORD proc_ntpid_object__size;
+  DWORD procfs_creation_ntpid;
 public:
+  static PWCHAR fixup_path (PWCHAR);
   dll start;
   int loaded_dlls;
   int reload_on_fork;
+  dll *main_executable;
   dll *operator [] (const PWCHAR name);
   dll *alloc (HINSTANCE, per_process *, dll_type);
   dll *find (void *);
@@ -94,7 +108,12 @@ public:
   void load_after_fork (HANDLE);
   void reserve_space ();
   void load_after_fork_impl (HANDLE, dll* which, int retries);
+  void nominate_proc_ntpid_object_dir ();
+  bool create_proc_ntpid_object_dir ();
+  void delete_proc_ntpid_object_dir ();
+  void cleanup_procfs ();
   dll *find_by_modname (const PWCHAR name);
+  dll *find_by_forkedname (PCWCHAR name);
   void populate_deps (dll* d);
   void topsort ();
   void topsort_visit (dll* d, bool goto_tail);
diff --git a/winsup/cygwin/fork.cc b/winsup/cygwin/fork.cc
index 317aec7..e6a555b 100644
--- a/winsup/cygwin/fork.cc
+++ b/winsup/cygwin/fork.cc
@@ -194,6 +194,7 @@ frok::child (volatile char * volatile here)
       loaded dlls' data/bss. */
   if (!load_dlls)
     {
+      dlls.load_after_fork (0); /* create child's dll hardlinks */
       cygheap->fdtab.fixup_after_fork (hParent);
       sync_with_parent ("performed fork fixup", false);
     }
@@ -337,6 +338,9 @@ frok::parent (volatile char * volatile stack_here)
 
   PROCESS_INFORMATION pi;
   STARTUPINFOW si;
+  PWCHAR forking_progname = dlls.main_executable->forkedname();
+  if (!forking_progname || !*forking_progname)
+    forking_progname = myself->progname;
 
   memset (&si, 0, sizeof (si));
   si.cb = sizeof si;
@@ -345,7 +349,7 @@ frok::parent (volatile char * volatile stack_here)
   si.cbReserved2 = sizeof (ch);
 
   syscall_printf ("CreateProcessW (%W, %W, 0, 0, 1, %y, 0, 0, %p, %p)",
-		  myself->progname, myself->progname, c_flags, &si, &pi);
+		  forking_progname, myself->progname, c_flags, &si, &pi);
   bool locked = __malloc_lock ();
 
   /* Remove impersonation */
@@ -357,7 +361,7 @@ frok::parent (volatile char * volatile stack_here)
   while (1)
     {
       hchild = NULL;
-      rc = CreateProcessW (myself->progname,	/* image to run */
+      rc = CreateProcessW (forking_progname,	/* image to run */
 			   GetCommandLineW (),	/* Take same space for command
 						   line as in parent to make
 						   sure child stack is allocated
@@ -377,7 +381,7 @@ frok::parent (volatile char * volatile stack_here)
       else
 	{
 	  this_errno = geterrno_from_win_error ();
-	  error ("CreateProcessW failed for '%W'", myself->progname);
+	  error ("CreateProcessW failed for '%W' (using '%W')", myself->progname, forking_progname);
 	  memset (&pi, 0, sizeof (pi));
 	  goto cleanup;
 	}
diff --git a/winsup/cygwin/pinfo.cc b/winsup/cygwin/pinfo.cc
index d0b4cd9..6f86a7f 100644
--- a/winsup/cygwin/pinfo.cc
+++ b/winsup/cygwin/pinfo.cc
@@ -28,6 +28,7 @@ details. */
 #include "cygtls.h"
 #include "tls_pbuf.h"
 #include "child_info.h"
+#include "dll_init.h"
 
 class pinfo_basic: public _pinfo
 {
@@ -225,6 +226,8 @@ pinfo::exit (DWORD n)
   int exitcode = self->exitcode & 0xffff;
   if (!self->cygstarted)
     exitcode = ((exitcode & 0xff) << 8) | ((exitcode >> 8) & 0xff);
+  sigproc_printf ("Calling dlls.cleanup_procfs n %y, exitcode %y", n, exitcode);
+  dlls.cleanup_procfs ();
   sigproc_printf ("Calling ExitProcess n %y, exitcode %y", n, exitcode);
   if (!TerminateProcess (GetCurrentProcess (), exitcode))
     system_printf ("TerminateProcess failed, %E");
diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
index c08d12f..a2da7e3 100644
--- a/winsup/cygwin/syscalls.cc
+++ b/winsup/cygwin/syscalls.cc
@@ -689,8 +689,8 @@ check_dir_not_empty (HANDLE dir, path_conv &pc)
   return STATUS_SUCCESS;
 }
 
-NTSTATUS
-unlink_nt (path_conv &pc)
+static NTSTATUS
+_unlink_nt (path_conv &pc, bool shareable)
 {
   NTSTATUS status;
   HANDLE fh, fh_ro = NULL;
@@ -771,6 +771,9 @@ retry_open:
      bin so that it actually disappears from its directory even though its
      in use.  Otherwise, if opening doesn't fail, the file is not in use and
      we can go straight to setting the delete disposition flag.
+     However, while we have the file open with FILE_SHARE_DELETE, using
+     this file via another hardlink for anything other than DELETE by
+     concurrent processes fails. The 'shareable' argument is to prevent this.
 
      NOTE: The missing sharing modes FILE_SHARE_READ and FILE_SHARE_WRITE do
 	   NOT result in a STATUS_SHARING_VIOLATION, if another handle is
@@ -780,7 +783,10 @@ retry_open:
 	   will succeed.  So, apparently there is no reliable way to find out
 	   if a file is already open elsewhere for other purposes than
 	   reading and writing data.  */
-  status = NtOpenFile (&fh, access, &attr, &io, FILE_SHARE_DELETE, flags);
+  if (shareable)
+    status = STATUS_SHARING_VIOLATION;
+  else
+    status = NtOpenFile (&fh, access, &attr, &io, FILE_SHARE_DELETE, flags);
   /* STATUS_SHARING_VIOLATION is what we expect. STATUS_LOCK_NOT_GRANTED can
      be generated under not quite clear circumstances when trying to open a
      file on NFS with FILE_SHARE_DELETE only.  This has been observed with
@@ -1026,6 +1032,18 @@ out:
   return status;
 }
 
+NTSTATUS
+unlink_nt (path_conv &pc)
+{
+  return _unlink_nt (pc, false);
+}
+
+NTSTATUS
+unlink_nt_shareable (path_conv &pc)
+{
+  return _unlink_nt (pc, true);
+}
+
 extern "C" int
 unlink (const char *ourname)
 {
-- 
2.0.5


--------------000104050501020109090205--
