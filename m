Return-Path: <cygwin-patches-return-8511-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 80795 invoked by alias); 30 Mar 2016 18:54:28 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 80647 invoked by uid 89); 30 Mar 2016 18:54:27 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=0.4 required=5.0 tests=AWL,BAYES_50,RCVD_IN_DNSWL_NONE,SPF_PASS autolearn=ham version=3.3.2 spammy=namelen, unc, UNC, 6111
X-HELO: smtp.salomon.at
Received: from smtp.salomon.at (HELO smtp.salomon.at) (193.186.16.13) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Wed, 30 Mar 2016 18:54:09 +0000
Received: from samail03.wamas.com ([172.28.33.235] helo=mailhost.salomon.at)	by smtp.salomon.at with esmtps (UNKNOWN:DHE-RSA-AES256-SHA:256)	(Exim 4.80.1)	(envelope-from <michael.haubenwallner@ssi-schaefer.com>)	id 1alLFf-0002FZ-PQ; Wed, 30 Mar 2016 20:54:05 +0200
Received: from [172.28.41.34] (helo=s01en24)	by mailhost.salomon.at with smtp (Exim 4.77)	(envelope-from <michael.haubenwallner@ssi-schaefer.com>)	id 1alLFe-000258-FB; Wed, 30 Mar 2016 20:53:59 +0200
Received: by s01en24 (sSMTP sendmail emulation); Wed, 30 Mar 2016 20:53:58 +0200
From: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
To: cygwin-patches@cygwin.com
Cc: michael.haubenwallner@ssi-schaefer.com
Subject: [PATCH 1/6] forkables: Store dll file name as full NT path.
Date: Wed, 30 Mar 2016 18:54:00 -0000
Message-Id: <1459364024-24891-2-git-send-email-michael.haubenwallner@ssi-schaefer.com>
In-Reply-To: <1459364024-24891-1-git-send-email-michael.haubenwallner@ssi-schaefer.com>
References: <1459364024-24891-1-git-send-email-michael.haubenwallner@ssi-schaefer.com>
X-SW-Source: 2016-q1/txt/msg00217.txt.bz2

In preparation to protect fork() against dll- and exe-updates, store
any dll file name as full NT path.  Additionally, keep a file handle
open for each loaded dll file for subsequent hardlink creation.  The
earlier we open a handle to the dll file, the lower is the chance the
dll file has been renamed since first loading.  To lower that chance
even more, the dll file handle is inherited by child processes rather
than opened again.

	* Makefile.in (DLL_OFILES): Add forkable.o.
	* dll_init.h (struct dll): Declare member fhandle.
	Rename member variable name to ntname.
	(struct dll_list): Declare private method
	set_forkables_inheritance.  Declare public methods
	request_forkables, release_forkables.  Declare public static
	methods ntopenfile, form_ntname, form_shortname, nt_max_path_buf,
	buffered_ntname, buffered_shortname.
	(dll_list::operator []): Use PCWCHAR rather than const PWCHAR.
	(dll_list::find_by_modname): Ditto.
	* dll_init.cc (in_load_after_fork): Define earlier in file.
	(struct dll_list): Rename member variable name to ntname.
	Define nt_max_path_buffer variable.
	Implement static methods form_ntname, form_shortname, ntopenfile.
	(dll_list::operator []): Use PCWCHAR rather than const PWCHAR.
	(dll_list::find_by_modname): Ditto.
	(reserve_at): Ditto.
	(release_at): Ditto.
	(dll_list::alloc): Use nt_max_path_buf method instead of local
	buffer.  Store module file name as full NT path, convert using
	the form_ntname static method.  Open file handle as fhandle for
	the loaded dll.
	(dll_list::detach): Close the fhandle.
	(dll_list::load_after_fork): Call release_forkables method.
	Call load_after_fork_impl only when reload_on_fork is set.
	* fork.cc (frok::child): Call dlls.load_after_fork even without
	need to dynamically load dlls, to release_forkables at least.
	(frok::parent): Call dlls.request_forkables before
	CreateProcessW, dlls.release_forkables afterwards.
	* forkable.cc: New file.
	(struct dll_list): Implement methods set_forkables_inheritance,
	request_forkables, release_forkables.
---
 winsup/cygwin/Makefile.in |   1 +
 winsup/cygwin/dll_init.cc | 250 +++++++++++++++++++++++++++++++++++++---------
 winsup/cygwin/dll_init.h  |  37 ++++++-
 winsup/cygwin/fork.cc     |  33 +++---
 winsup/cygwin/forkable.cc |  55 ++++++++++
 5 files changed, 310 insertions(+), 66 deletions(-)
 create mode 100644 winsup/cygwin/forkable.cc

diff --git a/winsup/cygwin/Makefile.in b/winsup/cygwin/Makefile.in
index 43919bd..15ddce8 100644
--- a/winsup/cygwin/Makefile.in
+++ b/winsup/cygwin/Makefile.in
@@ -307,6 +307,7 @@ DLL_OFILES:= \
 	flock.o \
 	fnmatch.o \
 	fork.o \
+	forkable.o \
 	fts.o \
 	ftw.o \
 	getopt.o \
diff --git a/winsup/cygwin/dll_init.cc b/winsup/cygwin/dll_init.cc
index 8deceb9..0494297 100644
--- a/winsup/cygwin/dll_init.cc
+++ b/winsup/cygwin/dll_init.cc
@@ -33,10 +33,162 @@ extern void __stdcall check_sanity_and_sync (per_process *);
 
 dll_list dlls;
 
+WCHAR NO_COPY dll_list::nt_max_path_buffer[NT_MAX_PATH];
+
 muto dll_list::protect;
 
 static bool dll_global_dtors_recorded;
 
+/* We need the in_load_after_fork flag so dll_dllcrt0_1 can decide at fork
+   time if this is a linked DLL or a dynamically loaded DLL.  In either case,
+   both, cygwin_finished_initializing and in_forkee are true, so they are not
+   sufficient to discern the situation. */
+static bool NO_COPY in_load_after_fork;
+
+/* Into ntbuf with ntbufsize, prints name prefixed with "\\??\\"
+   or "\\??\\UNC" as necessary to form the native NT path name.
+   Returns the end of the resulting string in ntbuf.
+   Supports using (a substring of) ntbuf as name argument. */
+PWCHAR dll_list::form_ntname (PWCHAR ntbuf, size_t ntbufsize, PCWCHAR name)
+{
+  while (true)
+    {
+      /* avoid using path_conv here: cygheap might not be
+	 initialized when started from non-cygwin process,
+	 or still might be frozen in_forkee */
+      if (name[0] == L'\0' || ntbufsize < 8)
+	break;
+      if (name[1] == L':') /* short Win32 drive letter path name */
+	{
+	  int winlen = min (ntbufsize - 5, wcslen (name));
+	  if (ntbuf + 4 != name)
+	    memmove (ntbuf + 4, name, sizeof (*ntbuf) * winlen);
+	  wcsncpy (ntbuf, L"\\??\\", 4);
+	  ntbuf += 4 + winlen;
+	  break;
+	}
+      if (!wcsncmp (name, L"\\\\?\\", 4)) /* long Win32 path name */
+	{
+	  int winlen = min (ntbufsize - 1, wcslen (name));
+	  if (ntbuf != name)
+	    memmove (ntbuf, name, sizeof (*ntbuf) * winlen);
+	  ntbuf[1] = L'?';
+	  ntbuf += winlen;
+	  break;
+	}
+      if (!wcsncmp (name, L"\\\\", 2)) /* short Win32 UNC path name */
+	{
+	  name += 1; /* skip first backslash */
+	  int winlen = min (ntbufsize - 8, wcslen (name));
+	  if (ntbuf + 7 != name)
+	    memmove (ntbuf + 7, name, sizeof (*ntbuf) * winlen);
+	  wcsncpy (ntbuf, L"\\??\\UNC", 7);
+	  ntbuf += 7 + winlen;
+	  break;
+	}
+      if (!wcsncmp (name, L"\\??\\", 4)) /* already a long NT path name */
+	{
+	  int winlen = min (ntbufsize - 1, wcslen (name));
+	  if (ntbuf != name)
+	    memmove (ntbuf, name, sizeof (*ntbuf) * winlen);
+	  ntbuf += winlen;
+	  break;
+	}
+      system_printf ("WARNING: invalid path name '%W'", name);
+      break;
+    }
+  if (ntbufsize)
+    *ntbuf = L'\0';
+  return ntbuf;
+}
+
+/* Into shortbuf with shortbufsize, prints name with "\\??\\"
+   or "\\??\\UNC" prefix removed/modified as necessary to form
+   the short Win32 path name.
+   Returns the end of the resulting string in shortbuf.
+   Supports using (a substring of) shortbuf as name argument. */
+PWCHAR
+dll_list::form_shortname (PWCHAR shortbuf, size_t shortbufsize, PCWCHAR name)
+{
+  while (true)
+    {
+      /* avoid using path_conv here: cygheap might not be
+	 initialized when started from non-cygwin process,
+	 or still might be frozen in_forkee */
+      if (name[0] == L'\0' || shortbufsize < 2)
+	break;
+      if (name[0] == L'\\' &&
+	  (name[1] == L'\\' || name[1] == L'?') &&
+	  name[2] == L'?' &&
+	  name[3] == L'\\') /* long Win32 or NT path name */
+	 name += 4;
+      if (name[1] == L':') /* short Win32 drive letter path name */
+	{
+	  int ntlen = min (shortbufsize - 1, wcslen (name));
+	  if (shortbuf != name)
+	    memmove (shortbuf, name, sizeof (*shortbuf) * ntlen);
+	  shortbuf += ntlen;
+	  break;
+	}
+      if (!wcsncmp (name, L"UNC\\", 4)) /* UNC path name */
+	{
+	  name += 3; /* skip "UNC" */
+	  int winlen = min (shortbufsize - 2, wcslen (name));
+	  if (shortbuf + 1 != name)
+	    memmove (shortbuf + 1, name, sizeof (*shortbuf) * winlen);
+	  shortbuf[0] = L'\\';
+	  shortbuf += 1 + winlen;
+	  break;
+	}
+      if (!wcsncmp (name, L"\\\\", 2)) /* already a short Win32 UNC path name */
+	{
+	  int winlen = min (shortbufsize - 1, wcslen (name));
+	  if (shortbuf != name)
+	    memmove (shortbuf, name, sizeof (*shortbuf) * winlen);
+	  shortbuf += winlen;
+	  break;
+	}
+      system_printf ("WARNING: invalid path name '%W'", name);
+      break;
+    }
+  if (shortbufsize)
+    *shortbuf = L'\0';
+  return shortbuf;
+}
+
+/* easy use of NtOpenFile */
+HANDLE
+dll_list::ntopenfile (PCWCHAR ntname, NTSTATUS *pstatus, ULONG openopts)
+{
+  NTSTATUS status;
+  if (!pstatus)
+    pstatus = &status;
+
+  UNICODE_STRING fn;
+  RtlInitUnicodeString (&fn, ntname);
+
+  OBJECT_ATTRIBUTES oa;
+  InitializeObjectAttributes (&oa, &fn, 0, NULL, NULL);
+
+  ACCESS_MASK access = FILE_READ_ATTRIBUTES;
+  if (openopts & FILE_DELETE_ON_CLOSE)
+    access |= DELETE;
+  if (openopts & FILE_DIRECTORY_FILE)
+    access |= FILE_LIST_DIRECTORY;
+
+  access |= SYNCHRONIZE;
+  openopts |= FILE_SYNCHRONOUS_IO_NONALERT;
+
+  HANDLE fh = NULL;
+  ULONG share = FILE_SHARE_VALID_FLAGS;
+  IO_STATUS_BLOCK iosb;
+  *pstatus = NtOpenFile (&fh, access, &oa, &iosb, share, openopts);
+  debug_printf ("%y = NtOpenFile (%p, a %xh, sh %xh, o %xh, io %y, '%W')",
+      *pstatus, fh, access, share, openopts, iosb.Status, fn.Buffer);
+
+  return NT_SUCCESS(*pstatus) ? fh : NULL;
+}
+
 /* Run destructors for all DLLs on exit. */
 void
 dll_global_dtors ()
@@ -151,11 +303,11 @@ dll::init ()
    of dll_list::alloc, as well as the comment preceeding the definition of
    the in_load_after_fork bool later in the file. */
 dll *
-dll_list::operator[] (const PWCHAR name)
+dll_list::operator[] (PCWCHAR ntname)
 {
   dll *d = &start;
   while ((d = d->next) != NULL)
-    if (!wcscasecmp (name, d->name))
+    if (!wcscasecmp (ntname, d->ntname))
       return d;
 
   return NULL;
@@ -163,7 +315,7 @@ dll_list::operator[] (const PWCHAR name)
 
 /* Look for a dll based on the basename. */
 dll *
-dll_list::find_by_modname (const PWCHAR modname)
+dll_list::find_by_modname (PCWCHAR modname)
 {
   dll *d = &start;
   while ((d = d->next) != NULL)
@@ -180,37 +332,29 @@ dll *
 dll_list::alloc (HINSTANCE h, per_process *p, dll_type type)
 {
   /* Called under loader lock conditions so this function can't be called
-     multiple times in parallel.  A static buffer is safe. */
-  static WCHAR buf[NT_MAX_PATH];
-  GetModuleFileNameW (h, buf, NT_MAX_PATH);
-  PWCHAR name = buf;
-  if (!wcsncmp (name, L"\\\\?\\", 4))
-    {
-      name += 4;
-      if (!wcsncmp (name, L"UNC\\", 4))
-	{
-	  name += 2;
-	  *name = L'\\';
-	}
-    }
-  DWORD namelen = wcslen (name);
-  PWCHAR modname = wcsrchr (name, L'\\') + 1;
+     multiple times in parallel.  The static buffer is safe. */
+  PWCHAR ntname = nt_max_path_buf ();
+  GetModuleFileNameW (h, ntname, NT_MAX_PATH);
+  PWCHAR modname = form_ntname (ntname, NT_MAX_PATH, ntname);
+  DWORD ntnamelen = modname - ntname;
+  while (modname > ntname && *(modname - 1) != L'\\')
+    --modname;
 
   guard (true);
   /* Already loaded?  For linked DLLs, only compare the basenames.  Linked
      DLLs are loaded using just the basename and the default DLL search path.
      The Windows loader picks up the first one it finds.  */
-  dll *d = (type == DLL_LINK) ? dlls.find_by_modname (modname) : dlls[name];
+  dll *d = (type == DLL_LINK) ? dlls.find_by_modname (modname) : dlls[ntname];
   if (d)
     {
       if (!in_forkee)
 	d->count++;	/* Yes.  Bump the usage count. */
       else if (d->handle != h)
 	fabort ("%W: Loaded to different address: parent(%p) != child(%p)",
-		name, d->handle, h);
+		ntname, d->handle, h);
       /* If this DLL has been linked against, and the full path differs, try
 	 to sanity check if this is the same DLL, just in another path. */
-      else if (type == DLL_LINK && wcscasecmp (name, d->name)
+      else if (type == DLL_LINK && wcscasecmp (ntname, d->ntname)
 	       && (d->p.data_start != p->data_start
 		   || d->p.data_start != p->data_start
 		   || d->p.bss_start != p->bss_start
@@ -222,19 +366,19 @@ dll_list::alloc (HINSTANCE h, per_process *p, dll_type type)
 		" child loaded: %W\n"
 		"The DLLs differ, so it's not safe to run the forked child.\n"
 		"Make sure to remove the offending DLL before trying again.",
-		d->name, name);
+		d->ntname, ntname);
       d->p = p;
     }
   else
     {
       /* FIXME: Change this to new at some point. */
-      d = (dll *) cmalloc (HEAP_2_DLL, sizeof (*d) + (namelen * sizeof (*name)));
+      d = (dll *) cmalloc (HEAP_2_DLL, sizeof (*d) + (ntnamelen * sizeof (*ntname)));
 
       /* Now we've allocated a block of information.  Fill it in with the
 	 supplied info about this DLL. */
       d->count = 1;
-      wcscpy (d->name, name);
-      d->modname = d->name + (modname - name);
+      wcscpy (d->ntname, ntname);
+      d->modname = d->ntname + (modname - ntname);
       d->handle = h;
       d->has_dtors = true;
       d->p = p;
@@ -243,6 +387,11 @@ dll_list::alloc (HINSTANCE h, per_process *p, dll_type type)
       d->image_size = ((pefile*)h)->optional_hdr ()->SizeOfImage;
       d->preferred_base = (void*) ((pefile*)h)->optional_hdr()->ImageBase;
       d->type = type;
+      NTSTATUS status;
+      d->fhandle = ntopenfile (d->ntname, &status);
+      if (!d->fhandle)
+	system_printf ("Unable (ntstatus %y) to open file %W",
+		       status, d->ntname);
       append (d);
       if (type == DLL_LOAD)
 	loaded_dlls++;
@@ -408,6 +557,11 @@ dll_list::detach (void *retaddr)
 	  if (!exit_state)
 	    __cxa_finalize (d->handle);
 	  d->run_dtors ();
+	  if (d->fhandle)
+	    {
+	      NtClose (d->fhandle);
+	      d->fhandle = NULL;
+	    }
 	  d->prev->next = d->next;
 	  if (d->next)
 	    d->next->prev = d->prev;
@@ -440,7 +594,7 @@ dll_list::init ()
    to clobber the dll's target address range because it often overlaps.
  */
 static PVOID
-reserve_at (const PWCHAR name, PVOID here, PVOID dll_base, DWORD dll_size)
+reserve_at (PCWCHAR name, PVOID here, PVOID dll_base, DWORD dll_size)
 {
   DWORD size;
   MEMORY_BASIC_INFORMATION mb;
@@ -469,7 +623,7 @@ reserve_at (const PWCHAR name, PVOID here, PVOID dll_base, DWORD dll_size)
 
 /* Release the memory previously allocated by "reserve_at" above. */
 static void
-release_at (const PWCHAR name, PVOID here)
+release_at (PCWCHAR name, PVOID here)
 {
   if (!VirtualFree (here, 0, MEM_RELEASE))
     fabort ("couldn't release memory %p for '%W' alignment, %E\n",
@@ -494,23 +648,20 @@ dll_list::reserve_space ()
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
 void
 dll_list::load_after_fork (HANDLE parent)
 {
+  release_forkables ();
+
   // moved to frok::child for performance reasons:
   // dll_list::reserve_space();
 
   in_load_after_fork = true;
-  load_after_fork_impl (parent, dlls.istart (DLL_LOAD), 0);
+  if (reload_on_fork)
+    load_after_fork_impl (parent, dlls.istart (DLL_LOAD), 0);
   in_load_after_fork = false;
 }
 
@@ -544,33 +695,34 @@ void dll_list::load_after_fork_impl (HANDLE parent, dll* d, int retries)
 	   dll's protective reservation from step 1
 	 */
 	if (!retries && !VirtualFree (d->handle, 0, MEM_RELEASE))
-	  fabort ("unable to release protective reservation for %W (%p), %E",
-		  d->modname, d->handle);
+	  fabort ("unable to release protective reservation (%p) for %W, %E",
+		  d->handle, d->ntname);
 
-	HMODULE h = LoadLibraryExW (d->name, NULL, DONT_RESOLVE_DLL_REFERENCES);
+	HMODULE h = LoadLibraryExW (buffered_shortname (d->ntname),
+				    NULL, DONT_RESOLVE_DLL_REFERENCES);
 	if (!h)
-	  fabort ("unable to create interim mapping for %W, %E", d->name);
+	  fabort ("unable to create interim mapping for %W, %E", d->ntname);
 	if (h != d->handle)
 	  {
 	    sigproc_printf ("%W loaded in wrong place: %p != %p",
-			    d->modname, h, d->handle);
+			    d->ntname, h, d->handle);
 	    FreeLibrary (h);
-	    PVOID reservation = reserve_at (d->modname, h,
+	    PVOID reservation = reserve_at (d->ntname, h,
 					    d->handle, d->image_size);
 	    if (!reservation)
 	      fabort ("unable to block off %p to prevent %W from loading there",
-		      h, d->modname);
+		      h, d->ntname);
 
 	    if (retries < DLL_RETRY_MAX)
 	      load_after_fork_impl (parent, d, retries+1);
 	    else
 	       fabort ("unable to remap %W to same address as parent (%p) - try running rebaseall",
-		       d->modname, d->handle);
+		       d->ntname, d->handle);
 
 	    /* once the above returns all the dlls are mapped; release
 	       the reservation and continue unwinding */
 	    sigproc_printf ("releasing blocked space at %p", reservation);
-	    release_at (d->modname, reservation);
+	    release_at (d->ntname, reservation);
 	    return;
 	  }
       }
@@ -586,7 +738,7 @@ void dll_list::load_after_fork_impl (HANDLE parent, dll* d, int retries)
 	{
 	  if (!VirtualFree (d->handle, 0, MEM_RELEASE))
 	    fabort ("unable to release protective reservation for %W (%p), %E",
-		    d->modname, d->handle);
+		    d->ntname, d->handle);
 	}
       else
 	{
@@ -594,14 +746,16 @@ void dll_list::load_after_fork_impl (HANDLE parent, dll* d, int retries)
 	     to ours or we wouldn't have gotten this far */
 	  if (!FreeLibrary (d->handle))
 	    fabort ("unable to unload interim mapping of %W, %E",
-		    d->modname);
+		    d->ntname);
 	}
-      HMODULE h = LoadLibraryW (d->name);
+      /* cygwin1.dll - as linked dependency - may reuse the shortname
+	 buffer, even in case of failure: don't reuse shortname later */
+      HMODULE h = LoadLibraryW (buffered_shortname (d->ntname));
       if (!h)
-	fabort ("unable to map %W, %E", d->name);
+	fabort ("unable to map %W, %E", d->ntname);
       if (h != d->handle)
 	fabort ("unable to map %W to same address as parent: %p != %p",
-		d->modname, d->handle, h);
+		d->ntname, d->handle, h);
     }
 }
 
diff --git a/winsup/cygwin/dll_init.h b/winsup/cygwin/dll_init.h
index 8127d0b..d4cbd3d 100644
--- a/winsup/cygwin/dll_init.h
+++ b/winsup/cygwin/dll_init.h
@@ -61,7 +61,11 @@ struct dll
   DWORD image_size;
   void* preferred_base;
   PWCHAR modname;
-  WCHAR name[1];
+
+  /* forkable */
+  HANDLE fhandle;
+
+  WCHAR ntname[1]; /* must be the last data member */
   void detach ();
   int init ();
   void run_dtors ()
@@ -78,15 +82,42 @@ struct dll
 
 class dll_list
 {
+  void set_forkables_inheritance (bool);
+
   dll *end;
   dll *hold;
   dll_type hold_type;
   static muto protect;
+  /* Use this buffer under loader lock conditions only. */
+  static WCHAR NO_COPY nt_max_path_buffer[NT_MAX_PATH];
 public:
+  /* forkables */
+  void request_forkables ();
+  void release_forkables ();
+
+  static HANDLE ntopenfile (PCWCHAR ntname, NTSTATUS *pstatus = NULL,
+			    ULONG openopts = FILE_NON_DIRECTORY_FILE);
+  static PWCHAR form_ntname (PWCHAR ntbuf, size_t bufsize, PCWCHAR name);
+  static PWCHAR form_shortname (PWCHAR shortbuf, size_t bufsize, PCWCHAR name);
+  static PWCHAR nt_max_path_buf ()
+  {
+    return nt_max_path_buffer;
+  }
+  static PCWCHAR buffered_ntname (PCWCHAR name)
+  {
+    form_ntname (nt_max_path_buffer, NT_MAX_PATH, name);
+    return nt_max_path_buffer;
+  }
+  static PCWCHAR buffered_shortname (PCWCHAR name)
+  {
+    form_shortname (nt_max_path_buffer, NT_MAX_PATH, name);
+    return nt_max_path_buffer;
+  }
+
   dll start;
   int loaded_dlls;
   int reload_on_fork;
-  dll *operator [] (const PWCHAR name);
+  dll *operator [] (PCWCHAR ntname);
   dll *alloc (HINSTANCE, per_process *, dll_type);
   dll *find (void *);
   void detach (void *);
@@ -94,7 +125,7 @@ public:
   void load_after_fork (HANDLE);
   void reserve_space ();
   void load_after_fork_impl (HANDLE, dll* which, int retries);
-  dll *find_by_modname (const PWCHAR name);
+  dll *find_by_modname (PCWCHAR modname);
   void populate_deps (dll* d);
   void topsort ();
   void topsort_visit (dll* d, bool goto_tail);
diff --git a/winsup/cygwin/fork.cc b/winsup/cygwin/fork.cc
index e7b9ea4..4361f58 100644
--- a/winsup/cygwin/fork.cc
+++ b/winsup/cygwin/fork.cc
@@ -188,21 +188,18 @@ frok::child (volatile char * volatile here)
 
   MALLOC_CHECK;
 
-  /* If we haven't dynamically loaded any dlls, just signal
-     the parent.  Otherwise, load all the dlls, tell the parent
-      that we're done, and wait for the parent to fill in the.
-      loaded dlls' data/bss. */
+  /* load dynamic dlls, if any */
+  dlls.load_after_fork (hParent);
+
+  cygheap->fdtab.fixup_after_fork (hParent);
+
+  /* If we haven't dynamically loaded any dlls, just signal the parent.
+     Otherwise, tell the parent that we've loaded all the dlls
+     and wait for the parent to fill in the loaded dlls' data/bss. */
   if (!load_dlls)
-    {
-      cygheap->fdtab.fixup_after_fork (hParent);
-      sync_with_parent ("performed fork fixup", false);
-    }
+    sync_with_parent ("performed fork fixup", false);
   else
-    {
-      dlls.load_after_fork (hParent);
-      cygheap->fdtab.fixup_after_fork (hParent);
-      sync_with_parent ("loaded dlls", true);
-    }
+    sync_with_parent ("loaded dlls", true);
 
   init_console_handler (myself->ctty > 0);
   ForceCloseHandle1 (fork_info->forker_finished, forker_finished);
@@ -345,8 +342,6 @@ frok::parent (volatile char * volatile stack_here)
   si.lpReserved2 = (LPBYTE) &ch;
   si.cbReserved2 = sizeof (ch);
 
-  syscall_printf ("CreateProcessW (%W, %W, 0, 0, 1, %y, 0, 0, %p, %p)",
-		  myself->progname, myself->progname, c_flags, &si, &pi);
   bool locked = __malloc_lock ();
 
   /* Remove impersonation */
@@ -357,6 +352,11 @@ frok::parent (volatile char * volatile stack_here)
 
   while (1)
     {
+      dlls.request_forkables ();
+
+      debug_printf ("CreateProcessW (%W, %W, 0, 0, 1, %y, 0, 0, %p, %p)",
+		    myself->progname, myself->progname, c_flags, &si, &pi);
+
       hchild = NULL;
       rc = CreateProcessW (myself->progname,	/* image to run */
 			   GetCommandLineW (),	/* Take same space for command
@@ -379,6 +379,7 @@ frok::parent (volatile char * volatile stack_here)
 	{
 	  this_errno = geterrno_from_win_error ();
 	  error ("CreateProcessW failed for '%W'", myself->progname);
+	  dlls.release_forkables ();
 	  memset (&pi, 0, sizeof (pi));
 	  goto cleanup;
 	}
@@ -392,6 +393,8 @@ frok::parent (volatile char * volatile stack_here)
       CloseHandle (pi.hThread);
       hchild = pi.hProcess;
 
+      dlls.release_forkables ();
+
       /* Protect the handle but name it similarly to the way it will
 	 be called in subproc handling. */
       ProtectHandle1 (hchild, childhProc);
diff --git a/winsup/cygwin/forkable.cc b/winsup/cygwin/forkable.cc
new file mode 100644
index 0000000..5592985
--- /dev/null
+++ b/winsup/cygwin/forkable.cc
@@ -0,0 +1,55 @@
+/* forkable.cc
+
+   Copyright 2015 Red Hat, Inc.
+
+This software is a copyrighted work licensed under the terms of the
+Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
+details. */
+
+#include "winsup.h"
+#include "cygerrno.h"
+#include "perprocess.h"
+#include "sync.h"
+#include "dll_init.h"
+#include "environ.h"
+#include "security.h"
+#include "path.h"
+#include "fhandler.h"
+#include "dtable.h"
+#include "cygheap.h"
+#include "pinfo.h"
+#include "shared_info.h"
+#include "child_info.h"
+#include "cygtls.h"
+#include "exception.h"
+#include <wchar.h>
+#include <sys/reent.h>
+#include <assert.h>
+#include <tls_pbuf.h>
+
+/* Set or clear HANDLE_FLAG_INHERIT for all handles necessary
+   to maintain forkables-hardlinks. */
+void
+dll_list::set_forkables_inheritance (bool inherit)
+{
+  DWORD mask = HANDLE_FLAG_INHERIT;
+  DWORD flags = inherit ? HANDLE_FLAG_INHERIT : 0;
+
+  dll *d = &start;
+  while ((d = d->next))
+    if (d->fhandle)
+      SetHandleInformation (d->fhandle, mask, flags);
+}
+
+/* create the forkable hardlinks, if necessary */
+void
+dll_list::request_forkables ()
+{
+  set_forkables_inheritance (true);
+}
+
+void
+dll_list::release_forkables ()
+{
+  set_forkables_inheritance (false);
+}
-- 
2.7.3
