Return-Path: <cygwin-patches-return-7327-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10779 invoked by alias); 11 May 2011 05:28:15 -0000
Received: (qmail 10767 invoked by uid 22791); 11 May 2011 05:28:13 -0000
X-SWARE-Spam-Status: No, hits=-0.7 required=5.0	tests=AWL,BAYES_00,SPF_NEUTRAL,TW_CP
X-Spam-Check-By: sourceware.org
Received: from smtp3.epfl.ch (HELO smtp3.epfl.ch) (128.178.224.226)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Wed, 11 May 2011 05:27:58 +0000
Received: (qmail 8406 invoked by uid 107); 11 May 2011 05:27:55 -0000
Received: from 206-248-130-97.dsl.teksavvy.com (HELO discarded) (206.248.130.97) (authenticated)  by smtp3.epfl.ch (AngelmatoPhylax SMTP proxy) with ESMTPA; Wed, 11 May 2011 07:27:55 +0200
Message-ID: <4DCA1E59.4070800@cs.utoronto.ca>
Date: Wed, 11 May 2011 05:28:00 -0000
From: Ryan Johnson <ryan.johnson@cs.utoronto.ca>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.17) Gecko/20110414 Lightning/1.0b2 Thunderbird/3.1.10
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Extending /proc/*/maps
Content-Type: multipart/mixed; boundary="------------050208010204050103050400"
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
X-SW-Source: 2011-q2/txt/msg00093.txt.bz2

This is a multi-part message in MIME format.
--------------050208010204050103050400
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 1534

Hi all,

Please find attached three patches which extend the functionality of 
/proc/*/maps.

The first (proc-maps-files) makes format_process_maps report all 
reserved or committed address space, rather than just the parts occupied 
by dlls in the dll_list. It splits allocations when they have multiple 
sets of permissions (with proper file offsets when appropriate), 
displays the file name of all mapped images and files, and identifies 
shared memory segments.

The second (proc-maps-heaps) adds reporting of Windows heaps (or their 
bases, at least). Unfortunately there doesn't seem to be any efficient 
way to identify all virtual allocations which a heap owns.

The third (proc-maps-safe) adds a "safe" mode and helper function which 
allows to print the process map at early stages of process startup when 
cygwin1.dll is not initialized yet. It is provided in case anyone finds 
it helpful; I don't expect it to migrate upstream.

Changelog entries also attached...

NOTE 1: I do not attempt to identify PEB, TEB, or thread stacks. The 
first could be done easily enough, but the second and third require 
venturing into undocumented/private Windows APIs.

NOTE 2: If desired, we could easily extend format_process_maps further 
to report section names of mapped images (linux does this for .so 
files), using the pe/coff file introspection class that accompanies my 
fork patches (separate email). I did not implement it because I don't 
know if people want that functionality. I haven't needed it yet.

Thoughts?
Ryan



--------------050208010204050103050400
Content-Type: text/plain;
 name="proc-maps-files.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="proc-maps-files.patch"
Content-length: 9154

# HG changeset patch
# Parent 1420f18fd5c5647e475df8339486020b456fb9d8
diff --git a/ChangeLog b/ChangeLog
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,3 +1,12 @@
+2011-05-10  Ryan Johnson  <ryan.johnson@cs.utoronto.ca>
+
+	* fhandler_process.cc (dos_drive_mappings, heap_info): New helper classes.
+	(format_process_maps): Reworked to report all mapped address space
+	in a process (committed or reserved), identifying the nature of
+	the mapping (mapped file/image, heap, shared memory) when
+	possible.
+	* autoload.cc: Register GetMappedFileNameW (psapi.dll)
+
 2011-04-15  Yaakov Selkowitz  <yselkowitz@users.sourceforge.net>
 
 	* thread.cc (pthread_setschedprio): New function.
diff --git a/autoload.cc b/autoload.cc
--- a/autoload.cc
+++ b/autoload.cc
@@ -422,6 +422,7 @@
 LoadDLLfunc (CoTaskMemFree, 4, ole32)
 
 LoadDLLfunc (EnumProcessModules, 16, psapi)
+LoadDLLfunc (GetMappedFileNameW, 16, psapi)
 LoadDLLfunc (GetModuleFileNameExW, 16, psapi)
 LoadDLLfunc (GetModuleInformation, 16, psapi)
 LoadDLLfunc (GetProcessMemoryInfo, 12, psapi)
diff --git a/fhandler_process.cc b/fhandler_process.cc
--- a/fhandler_process.cc
+++ b/fhandler_process.cc
@@ -527,6 +527,81 @@
   return len + 1;
 }
 
+struct dos_drive_mappings {
+  struct mapping {
+    mapping* next;
+    int len;
+    wchar_t drive_letter;
+    wchar_t mapping[1];
+  };
+  mapping* mappings;
+  
+  dos_drive_mappings ()
+    : mappings(0)
+  {
+    /* The logical drive strings buffer holds a list of (at most 26)
+       drive names separated by nulls and terminated by a double-null:
+
+       "a:\\\0b:\\\0...z:\\\0"
+
+       The annoying part is, QueryDosDeviceW wants only "x:" rather
+       than the "x:\" we get back from GetLogicalDriveStringsW, so
+       we'll have to strip out the trailing slash for each mapping.
+       
+       The returned mapping a native NT pathname (\Device\...) which
+       we can use to fix up the output of GetMappedFileNameW
+    */
+    static unsigned const DBUFLEN = 26*4;
+    wchar_t dbuf[DBUFLEN+1];
+    wchar_t pbuf[NT_MAX_PATH+1];
+    wchar_t drive[] = {L'x', L':', 0};
+    unsigned result = GetLogicalDriveStringsW (DBUFLEN*sizeof (wchar_t), dbuf);
+    if (!result)
+      debug_printf ("Failed to get logical DOS drive names: %lu", GetLastError ());
+    else if (result > DBUFLEN)
+      debug_printf ("Too many mapped drive letters: %u", result);
+    else
+      for (wchar_t* cur = dbuf; (*drive=*cur); cur = wcschr (cur, L'\0')+1)
+	if (QueryDosDeviceW (drive, pbuf, NT_MAX_PATH))
+	  {
+	    size_t plen = wcslen (pbuf);
+	    size_t psize = plen*sizeof (wchar_t);
+	    debug_printf ("DOS drive %ls maps to %ls", drive, pbuf);
+	    mapping* m = (mapping*) cmalloc (HEAP_FHANDLER, sizeof (mapping) + psize);
+	    m->next = mappings;
+	    m->len = plen;
+	    m->drive_letter = *drive;
+	    memcpy (m->mapping, pbuf, psize + sizeof (wchar_t));
+	    mappings = m;
+	  }
+	else
+	  debug_printf ("Unable to determine the native mapping for %ls (error %lu)",
+			drive,
+			GetLastError ());
+  }
+  
+  wchar_t* fixup_if_match (wchar_t* path) {
+    for (mapping* m = mappings; m; m = m->next)
+      if (!wcsncmp (m->mapping, path, m->len))
+	{
+	  path += m->len-2;
+	  path[0] = m->drive_letter;
+	  path[1] = L':';
+	  break;
+	}
+    return path;
+  }
+  
+  ~dos_drive_mappings () {
+    mapping* n = 0;
+    for (mapping* m = mappings; m; m = n)
+      {
+	n = m->next;
+	cfree (m);
+      }
+  }
+};
+
 static _off64_t
 format_process_maps (void *data, char *&destbuf)
 {
@@ -538,11 +613,23 @@
     return 0;
 
   _off64_t len = 0;
-  HMODULE *modules;
-  DWORD needed, i;
-  DWORD_PTR wset_size;
-  DWORD_PTR *workingset = NULL;
-  MODULEINFO info;
+  
+  union access {
+    char flags[8];
+    _off64_t word;
+  } a;
+
+  struct region {
+    access a;
+    char* abase;
+    char* rbase;
+    char* rend;
+  } cur = {{{'\0'}}, (char*)1, 0, 0};
+  
+  MEMORY_BASIC_INFORMATION mb;
+  dos_drive_mappings drive_maps;
+  struct __stat64 st;
+  long last_pass = 0;
 
   tmp_pathbuf tp;
   PWCHAR modname = tp.w_get ();
@@ -554,75 +641,86 @@
       cfree (destbuf);
       destbuf = NULL;
     }
-  if (!EnumProcessModules (proc, NULL, 0, &needed))
+  
+  /* Iterate over each VM region in the address space, coalescing
+     memory regions with the same permissions. Once we run out, do one
+     last_pass to trigger output of the last accumulated region. */
+  for(char* i = 0;
+      VirtualQueryEx (proc, i, &mb, sizeof(mb)) || (1 == ++last_pass);
+      i = cur.rend)
     {
-      __seterrno ();
-      len = -1;
-      goto out;
+      if (mb.State == MEM_FREE)
+	a.word = 0;
+      else
+	{
+	  static DWORD const RW = (PAGE_EXECUTE_READWRITE | PAGE_READWRITE
+				   | PAGE_EXECUTE_WRITECOPY | PAGE_WRITECOPY);
+	  DWORD p = mb.Protect;
+	  a = (access) {{
+	      (p & (RW | PAGE_EXECUTE_READ | PAGE_READONLY))?	'r' : '-',
+	      (p & (RW))?					'w' : '-',
+	      (p & (PAGE_EXECUTE_READWRITE | PAGE_EXECUTE_READ
+		    | PAGE_EXECUTE_WRITECOPY | PAGE_EXECUTE))?	'x' : '-',
+	      (p & (PAGE_GUARD))? 				's' : 'p',
+	      '\0', // zero-fill the remaining bytes
+	    }};
+	}
+
+      region next = {a,
+		     (char*) mb.AllocationBase,
+		     (char*) mb.BaseAddress,
+		     (char*) mb.BaseAddress+mb.RegionSize
+      };
+      
+      /* Windows permissions are more fine-grained than the unix rwxp,
+	 so we reduce clutter by manually coalescing regions sharing
+	 the same allocation base and effective permissions. */
+      bool newbase = (next.abase != cur.abase);
+      if (!last_pass && !newbase && next.a.word == cur.a.word)
+	  cur.rend = next.rend; // merge with previous
+      else
+	{
+	  // output the current region if it's "interesting"
+	  if (cur.a.word)
+	    {
+	      size_t newlen = strlen (posix_modname) + 62;
+	      if (len + newlen >= maxsize)
+		destbuf = (char *) crealloc_abort (destbuf,
+						   maxsize += roundup2 (newlen, 2048));
+	      int written = __small_sprintf (destbuf + len,
+					     "%08lx-%08lx %s %08lx %04x:%04x %U   ",
+					     cur.rbase, cur.rend, cur.a.flags,
+					     cur.rbase - cur.abase,
+					     st.st_dev >> 16,
+					     st.st_dev & 0xffff,
+					     st.st_ino);
+	      while (written < 62)
+		destbuf[len + written++] = ' ';
+	      len += written;
+	      len += __small_sprintf (destbuf + len, "%s\n", posix_modname);
+	    }
+	  // start of a new region (but possibly still the same allocation)
+	  cur = next;
+	  // if a new allocation, figure out what kind it is 
+	  if (newbase && !last_pass)
+	    {
+	      st.st_dev = 0;
+	      st.st_ino = 0;
+	      if ((mb.Type & (MEM_MAPPED | MEM_IMAGE)
+		   && GetMappedFileNameW (proc, cur.abase, modname, NT_MAX_PATH)))
+		{
+		  PWCHAR dosname = drive_maps.fixup_if_match (modname);
+		  if (mount_table->conv_to_posix_path (dosname, posix_modname, 0))
+		    wcstombs (posix_modname, dosname, NT_MAX_PATH);
+		  stat64 (posix_modname, &st);
+		}
+	      else if (mb.Type & MEM_MAPPED)
+		strcpy (posix_modname, "[shareable]");
+	      else
+		posix_modname[0] = 0;
+	    }
+	}
     }
-  modules = (HMODULE*) alloca (needed);
-  if (!EnumProcessModules (proc, modules, needed, &needed))
-    {
-      __seterrno ();
-      len = -1;
-      goto out;
-    }
-
-  QueryWorkingSet (proc, (void *) &wset_size, sizeof wset_size);
-  if (GetLastError () == ERROR_BAD_LENGTH)
-    {
-      workingset = (DWORD_PTR *) alloca (sizeof (DWORD_PTR) * ++wset_size);
-      if (!QueryWorkingSet (proc, (void *) workingset,
-			    sizeof (DWORD_PTR) * wset_size))
-	workingset = NULL;
-    }
-  for (i = 0; i < needed / sizeof (HMODULE); i++)
-    if (GetModuleInformation (proc, modules[i], &info, sizeof info)
-	&& GetModuleFileNameExW (proc, modules[i], modname, NT_MAX_PATH))
-      {
-	char access[5];
-	strcpy (access, "r--p");
-	struct __stat64 st;
-	if (mount_table->conv_to_posix_path (modname, posix_modname, 0))
-	  sys_wcstombs (posix_modname, NT_MAX_PATH, modname);
-	if (stat64 (posix_modname, &st))
-	  {
-	    st.st_dev = 0;
-	    st.st_ino = 0;
-	  }
-	size_t newlen = strlen (posix_modname) + 62;
-	if (len + newlen >= maxsize)
-	  destbuf = (char *) crealloc_abort (destbuf,
-					   maxsize += roundup2 (newlen, 2048));
-	if (workingset)
-	  for (unsigned i = 1; i <= wset_size; ++i)
-	    {
-	      DWORD_PTR addr = workingset[i] & 0xfffff000UL;
-	      if ((char *)addr >= info.lpBaseOfDll
-		  && (char *)addr < (char *)info.lpBaseOfDll + info.SizeOfImage)
-		{
-		  access[0] = (workingset[i] & 0x5) ? 'r' : '-';
-		  access[1] = (workingset[i] & 0x4) ? 'w' : '-';
-		  access[2] = (workingset[i] & 0x2) ? 'x' : '-';
-		  access[3] = (workingset[i] & 0x100) ? 's' : 'p';
-		}
-	    }
-	int written = __small_sprintf (destbuf + len,
-				"%08lx-%08lx %s %08lx %04x:%04x %U   ",
-				info.lpBaseOfDll,
-				(unsigned long)info.lpBaseOfDll
-				+ info.SizeOfImage,
-				access,
-				info.EntryPoint,
-				st.st_dev >> 16,
-				st.st_dev & 0xffff,
-				st.st_ino);
-	while (written < 62)
-	  destbuf[len + written++] = ' ';
-	len += written;
-	len += __small_sprintf (destbuf + len, "%s\n", posix_modname);
-      }
-out:
   CloseHandle (proc);
   return len;
 }

--------------050208010204050103050400
Content-Type: text/plain;
 name="proc-maps-heaps.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="proc-maps-heaps.patch"
Content-length: 1817

# HG changeset patch
# Parent 830a4452f008bf467a58c4838a10840c16d34d2d
diff --git a/fhandler_process.cc b/fhandler_process.cc
--- a/fhandler_process.cc
+++ b/fhandler_process.cc
@@ -29,6 +29,7 @@
 #include <sys/param.h>
 #include <ctype.h>
 #include <psapi.h>
+#include <tlhelp32.h>
 
 #define _COMPILING_NEWLIB
 #include <dirent.h>
@@ -602,6 +603,51 @@
   }
 };
 
+struct heap_info {
+  struct heap {
+    heap* next;
+    void* base;
+  };
+  heap* heaps;
+
+  heap_info (DWORD pid)
+    : heaps (0)
+  {
+    HANDLE hHeapSnap = CreateToolhelp32Snapshot (TH32CS_SNAPHEAPLIST, pid);
+    HEAPLIST32 hl;
+    hl.dwSize = sizeof(hl);
+
+    if (hHeapSnap != INVALID_HANDLE_VALUE && Heap32ListFirst (hHeapSnap, &hl))
+      do
+	{
+	  heap* h = (heap*) cmalloc (HEAP_FHANDLER, sizeof (heap));
+	  *h = (heap) {heaps, (void*)hl.th32HeapID};
+	  heaps = h;
+	} while (Heap32ListNext (hHeapSnap, &hl));
+    CloseHandle (hHeapSnap);
+  }
+  
+  char* fill_if_match (void* base, char* dest ) {
+    long count = 0;
+    for(heap* h = heaps; h && ++count; h = h->next)
+      if(base == h->base)
+	{
+	  __small_sprintf (dest, "[heap %ld]", count);
+	  return dest;
+	}
+    return 0;
+  }
+  
+  ~heap_info ()  {
+    heap* n = 0;
+    for (heap* m = heaps; m; m = n)
+      {
+	n = m->next;
+	cfree (m);
+      }
+  }
+};
+
 static _off64_t
 format_process_maps (void *data, char *&destbuf)
 {
@@ -628,6 +674,7 @@
   
   MEMORY_BASIC_INFORMATION mb;
   dos_drive_mappings drive_maps;
+  heap_info heaps(p->dwProcessId);
   struct __stat64 st;
   long last_pass = 0;
 
@@ -716,7 +763,8 @@
 		}
 	      else if (mb.Type & MEM_MAPPED)
 		strcpy (posix_modname, "[shareable]");
-	      else
+	      else if (!(mb.Type & MEM_PRIVATE
+			 && heaps.fill_if_match (cur.abase, posix_modname)))
 		posix_modname[0] = 0;
 	    }
 	}

--------------050208010204050103050400
Content-Type: text/plain;
 name="proc-maps-safe.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="proc-maps-safe.patch"
Content-length: 3726

# HG changeset patch
# Parent 989c2873d1a584bd26eb3cbb4be26d0d4aa8e691

diff --git a/fhandler_process.cc b/fhandler_process.cc
--- a/fhandler_process.cc
+++ b/fhandler_process.cc
@@ -528,6 +528,17 @@
   return len + 1;
 }
 
+/* This function exists for debugging purposes: it can be called from
+   a debugger or calls to it embedded in cygwin code.
+
+   WARNING: if called early in process startup, be sure to set pass
+   make_safe=true or set use_safe_process_maps=true before making the
+   call. This tells format_process_maps to avoid using cygwin features
+   that may not be initialized yet, at the cost of a less detailed
+   process map.  */
+void print_process_maps (bool make_safe);
+static bool use_safe_process_maps = false;
+
 struct dos_drive_mappings {
   struct mapping {
     mapping* next;
@@ -540,6 +551,9 @@
   dos_drive_mappings ()
     : mappings(0)
   {
+    if (use_safe_process_maps)
+      return; // can't use psapi or heap yet...
+    
     /* The logical drive strings buffer holds a list of (at most 26)
        drive names separated by nulls and terminated by a double-null:
 
@@ -613,6 +627,9 @@
   heap_info (DWORD pid)
     : heaps (0)
   {
+    if (use_safe_process_maps)
+      return; // not safe to use the heap
+    
     HANDLE hHeapSnap = CreateToolhelp32Snapshot (TH32CS_SNAPHEAPLIST, pid);
     HEAPLIST32 hl;
     hl.dwSize = sizeof(hl);
@@ -648,6 +665,27 @@
   }
 };
 
+void
+print_process_maps (bool make_safe)
+{
+  bool saved = use_safe_process_maps;
+  use_safe_process_maps |= make_safe;
+  
+  _pinfo p;
+  p.dwProcessId = GetCurrentProcessId();
+  char* buf = 0;
+  DWORD done;
+  _off64_t len = format_process_maps(&p, buf);
+  WriteFile (GetStdHandle (STD_ERROR_HANDLE), buf, len, &done, 0);
+  FlushFileBuffers (GetStdHandle (STD_ERROR_HANDLE));
+  if (use_safe_process_maps)
+    VirtualFree (buf, 0, MEM_RELEASE);
+  else
+    cfree (buf);
+  
+  use_safe_process_maps = saved;
+}
+
 static _off64_t
 format_process_maps (void *data, char *&destbuf)
 {
@@ -688,6 +726,18 @@
       cfree (destbuf);
       destbuf = NULL;
     }
+
+  if (use_safe_process_maps)
+    {
+      maxsize = 256*1024;
+      destbuf = (char*) VirtualAlloc (NULL, maxsize, MEM_COMMIT, PAGE_READWRITE);
+      if (!destbuf)
+	{
+	  system_printf ("Error allocating virtual memory: %E");
+	  return 0;
+	}
+    }
+	
   
   /* Iterate over each VM region in the address space, coalescing
      memory regions with the same permissions. Once we run out, do one
@@ -732,8 +782,16 @@
 	    {
 	      size_t newlen = strlen (posix_modname) + 62;
 	      if (len + newlen >= maxsize)
-		destbuf = (char *) crealloc_abort (destbuf,
-						   maxsize += roundup2 (newlen, 2048));
+		{
+		  if (use_safe_process_maps)
+		    {
+		      system_printf ("truncating output of format_process_maps to fit available memory");
+		      return len;
+		    }
+		  else
+		    destbuf = (char *) crealloc_abort (destbuf,
+						       maxsize += roundup2 (newlen, 2048));
+		}
 	      int written = __small_sprintf (destbuf + len,
 					     "%08lx-%08lx %s %08lx %04x:%04x %U   ",
 					     cur.rbase, cur.rend, cur.a.flags,
@@ -753,7 +811,19 @@
 	    {
 	      st.st_dev = 0;
 	      st.st_ino = 0;
-	      if ((mb.Type & (MEM_MAPPED | MEM_IMAGE)
+	      if (use_safe_process_maps)
+		{
+		  char const* n;
+		  if (mb.Type & MEM_MAPPED)
+		    n = "[mapped file or shareable region]";
+		  else if (mb.Type & MEM_IMAGE)
+		    n = "[executable image]";
+		  else
+		    n = "";
+		  
+		  strcpy (posix_modname, n);
+		}
+	      else if ((mb.Type & (MEM_MAPPED | MEM_IMAGE)
 		   && GetMappedFileNameW (proc, cur.abase, modname, NT_MAX_PATH)))
 		{
 		  PWCHAR dosname = drive_maps.fixup_if_match (modname);

--------------050208010204050103050400
Content-Type: text/plain;
 name="proc-changes.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="proc-changes.txt"
Content-length: 428

2011-05-11  Ryan Johnson  <ryan.johnson@cs.utoronto.ca>

	* fhandler_process.cc (format_process_maps): Reworked to report
	all mapped address space in a process (committed or reserved),
	identifying the nature of the mapping (mapped file/image, heap,
	shared memory) when possible.
	(dos_drive_mappings, heap_info): New helper classes
	(print_process_maps): debugging aid
	* autoload.cc: Register GetMappedFileNameW (psapi.dll)

--------------050208010204050103050400--
