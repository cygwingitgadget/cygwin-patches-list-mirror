Return-Path: <cygwin-patches-return-8698-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 76320 invoked by alias); 25 Feb 2017 16:27:36 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 76259 invoked by uid 89); 25 Feb 2017 16:27:34 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-26.6 required=5.0 tests=BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW autolearn=ham version=3.3.2 spammy=H*UA:Outlook, H*x:Outlook, H*UA:Microsoft, H*x:Microsoft
X-HELO: mtaout01-winn.ispmail.ntl.com
Received: from mtaout01-winn.ispmail.ntl.com (HELO mtaout01-winn.ispmail.ntl.com) (81.103.221.47) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 25 Feb 2017 16:27:32 +0000
Received: from aamtaout03-winn.ispmail.ntl.com ([81.103.221.35])          by mtaout01-winn.ispmail.ntl.com          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP          id <20170225162730.ZYVD20876.mtaout01-winn.ispmail.ntl.com@aamtaout03-winn.ispmail.ntl.com>          for <cygwin-patches@cygwin.com>; Sat, 25 Feb 2017 16:27:30 +0000
Received: from Altus ([213.105.212.114]) by aamtaout03-winn.ispmail.ntl.com          (InterMail vG.3.00.04.00 201-2196-133-20080908) with ESMTP          id <20170225162730.PEFR2660.aamtaout03-winn.ispmail.ntl.com@Altus>          for <cygwin-patches@cygwin.com>; Sat, 25 Feb 2017 16:27:30 +0000
From: "David Allsopp" <David.Allsopp@cl.cam.ac.uk>
To: <cygwin-patches@cygwin.com>
Subject: [PATCH] Preserve order of dlopen'd modules in dll_list::topsort
Date: Sat, 25 Feb 2017 16:27:00 -0000
Message-ID: <000001d28f84$0fce9ea0$2f6bdbe0$@cl.cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain;	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2017-q1/txt/msg00039.txt.bz2

This patch (below - I hope I have managed to format this email correctly)
alters the behaviour of dll_list::topsort to preserve the order of dlopen'd
units.

The load order of unrelated DLLs is reversed every time fork is called,
since dll_list::topsort finds the tail of the list and then unwinds to
reinsert items. My change takes advantage of what should be undefined
behaviour in dll_list::populate_deps (ndeps non-zero and ndeps and deps not
initialised) to allow the deps field to be initialised prior to the call and
appended to, rather than overwritten.

All DLLs which have been dlopen'd have their deps list initialised with the
list of all previously dlopen'd units. These extra dependencies mean that
the unwind preserves the order of dlopen'd units.

The motivation for this is the FlexDLL linker used in OCaml. The FlexDLL
linker allows a dlopen'd unit to refer to symbols in previously dlopen'd
units and it resolves these symbols in DllMain before anything else has
initialised (including the Cygwin DLL). This means that dependencies may
exist between dlopen'd units (which the OCaml runtime system understands)
but which Windows is unaware of. During fork, the process-level table which
FlexDLL uses to get the symbol table of each DLL is copied over but because
the load order of dlopen'd DLLs is reversed, it is possible for FlexDLL to
attempt to access memory in the DLL before it has been loaded and hence it
fails with an access violation. Because the list is reversed on each call to
fork, it means that a subsequent call to fork puts the DLLs back into the
correct order, hence "even" invocations of fork work!

An interesting side-effect is that this only occurs if the DLLs load at
their preferred base address - if they have to be rebased, then FlexDLL
works because at the time that the dependent unit is loaded out of order,
there is still in memory the "dummy" DONT_RESOLVE_DLL_REFERENCES version of
the dependency which, as it happens, will contain the correct symbol table
in the data section. For my tests, this initially appeared to be an x86-only
problem, but that was only because the two DLLs on x64 should have been
rebased.

I'm very happy to include the complete detail for this and, for the
extremely keen, the relevant Git branch in OCaml which demonstrates this
problem. Given the way in which FlexDLL operates, I would contend that this
is a sensible change of behaviour for the Cygwin DLL, though not a bug fix.
I'd be extremely happy to see this patch integrated, as the workaround
necessary in FlexDLL to support Cygwin's fork is horrible (and
non-transparent to the library user).

This patch is licensed under 2-clause BSD as per winsup/CONTRIBUTORS,
Copyright (c) 2017, MetaStack Solutions Ltd.


--dra

Signed-off-by: David Allsopp <david.allsopp@metastack.com>
---
 winsup/cygwin/dll_init.cc   | 45
++++++++++++++++++++++++++++++++++++++++++---
 winsup/cygwin/release/2.7.1 |  2 ++
 2 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/winsup/cygwin/dll_init.cc b/winsup/cygwin/dll_init.cc index
0fe5714..d3c6114 100644
--- a/winsup/cygwin/dll_init.cc
+++ b/winsup/cygwin/dll_init.cc
@@ -271,9 +271,16 @@ void dll_list::populate_deps (dll* d)
   PIMAGE_DATA_DIRECTORY dd = pef->idata_dir (IMAGE_DIRECTORY_ENTRY_IMPORT);
   /* Annoyance: calling crealloc with a NULL pointer will use the
      wrong heap and crash, so we have to replicate some code */
-  long maxdeps = 4;
-  d->deps = (dll**) cmalloc (HEAP_2_DLL, maxdeps*sizeof (dll*));
-  d->ndeps = 0;
+  long maxdeps;
+  if (d->ndeps == 0)
+    {
+      maxdeps = 4;
+      d->deps = (dll**) cmalloc (HEAP_2_DLL, maxdeps*sizeof (dll*));
+    }
+  else
+    {
+      maxdeps = d->ndeps;
+    }
   for (PIMAGE_IMPORT_DESCRIPTOR id=
 	(PIMAGE_IMPORT_DESCRIPTOR) pef->rva (dd->VirtualAddress);
       dd->Size && id->Name;
@@ -304,6 +311,38 @@ dll_list::topsort ()
   if (!end || end == &start)
     return;
 
+  if (loaded_dlls > 0)
+    {
+      /* Ensure that all dlopen'd DLLs depend on previously dlopen'd DLLs.
This prevents topsort
+         from reversing the order of dlopen'd DLLs on calls to fork. */
+      dll* d = &start;
+      long maxdeps = 4;
+      long dlopen_ndeps = 0;
+      dll** dlopen_deps = (dll**) cmalloc (HEAP_2_DLL, maxdeps*sizeof
(dll*));
+      while ((d = d->next))
+        {
+          if (d->type == DLL_LOAD)
+            {
+              /* Initialise d->deps with all previously dlopen'd DLLs. */
+              if (dlopen_ndeps)
+                {
+                  d->ndeps = dlopen_ndeps;
+                  d->deps = (dll**) cmalloc (HEAP_2_DLL,
dlopen_ndeps*sizeof (dll*));
+                  memcpy (d->deps, dlopen_deps, dlopen_ndeps*sizeof
(dll*));
+                  populate_deps (d);
+                }
+              /* Add this DLL to the list of previously dlopen'd DLLs. */
+              if (dlopen_ndeps >= maxdeps)
+                {
+                  maxdeps = 2*(1+maxdeps);
+                  dlopen_deps = (dll**) crealloc(dlopen_deps,
maxdeps*sizeof (dll*));
+                }
+              dlopen_deps[dlopen_ndeps++] = d;
+            }
+        }
+      cfree(dlopen_deps);
+    }
+
   /* make sure we have all the deps available */
   dll* d = &start;
   while ((d = d->next))
diff --git a/winsup/cygwin/release/2.7.1 b/winsup/cygwin/release/2.7.1 index
54e1100..411a0ae 100644
--- a/winsup/cygwin/release/2.7.1
+++ b/winsup/cygwin/release/2.7.1
@@ -8,6 +8,8 @@ What changed:
 - cygcheck and strace now always generate output with Unix LF line endings,
   rather than with DOS/Windows CR LF line endings.
 
+- fork now preserves the load order of unrelated dlopen'd modules.
+
 
 Bug Fixes
 ---------
--
2.10.2.windows.1

