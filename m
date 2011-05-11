Return-Path: <cygwin-patches-return-7338-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17313 invoked by alias); 11 May 2011 18:31:56 -0000
Received: (qmail 17286 invoked by uid 22791); 11 May 2011 18:31:54 -0000
X-SWARE-Spam-Status: No, hits=-1.1 required=5.0	tests=AWL,BAYES_00,SPF_NEUTRAL
X-Spam-Check-By: sourceware.org
Received: from smtp0.epfl.ch (HELO smtp0.epfl.ch) (128.178.224.219)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Wed, 11 May 2011 18:31:40 +0000
Received: (qmail 30048 invoked by uid 107); 11 May 2011 18:31:37 -0000
Received: from sb-gw15.cs.toronto.edu (HELO discarded) (128.100.3.15) (authenticated)  by smtp0.epfl.ch (AngelmatoPhylax SMTP proxy) with ESMTPA; Wed, 11 May 2011 20:31:37 +0200
Message-ID: <4DCAD609.70106@cs.utoronto.ca>
Date: Wed, 11 May 2011 18:31:00 -0000
From: Ryan Johnson <ryan.johnson@cs.utoronto.ca>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.17) Gecko/20110414 Lightning/1.0b2 Thunderbird/3.1.10
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Improvements to fork handling (2/5)
Content-Type: multipart/mixed; boundary="------------000605040906010805030401"
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
X-SW-Source: 2011-q2/txt/msg00104.txt.bz2

This is a multi-part message in MIME format.
--------------000605040906010805030401
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 776

Hi all,

This patch has the parent sort its dll list topologically by 
dependencies. Previously, attempts to load a DLL_LOAD dll risked pulling 
in dependencies automatically, and the latter would then not benefit 
from the code which "encourages" them to land in the right places. The 
dependency tracking is achieved using a simple class which allows to 
introspect a mapped dll image and pull out the dependencies it lists. 
The code currently rebuilds the dependency list at every fork rather 
than attempt to update it properly as modules are loaded and unloaded. 
Note that the topsort optimization affects only cygwin dlls, so any 
windows dlls which are pulled in dynamically (directly or indirectly) 
will still impose the usual risk of address space clobbers.

Ryan

--------------000605040906010805030401
Content-Type: text/plain;
 name="fork-topsort.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="fork-topsort.patch"
Content-length: 6272

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

--------------000605040906010805030401
Content-Type: text/plain;
 name="fork-topsort.changes"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="fork-topsort.changes"
Content-length: 967

        * dll_init.cc (dll_list::find_by_modname): new function to search
        the dll list for a module name only (no path).
        (dll_list::alloc): Initialize newly-added members of struct dll.
        (dll_list::append): new function to factor out the append
        operation (used by dll_list::topsort).
        (dll_list::populate_deps): new function to identify dll dependencies.
        (dll_list::topsort): new function to sort the dll list
        topologically by dependencies.
        (dll_list::topsort_visit): new helper function for the above.
        * dll_init.h (struct dll): added new class members for topsort.
        (struct dll_list): declare topsort-related functions.
        (struct pefile): allows simple introspection of dll images.
        * fork.cc (fork): topsort the dll list before forking. When the
        child loads each dll, all dependencies are already loaded and will
        no longer risk being pulled in unexpectedly.

--------------000605040906010805030401--
