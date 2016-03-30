Return-Path: <cygwin-patches-return-8509-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 80696 invoked by alias); 30 Mar 2016 18:54:28 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 80577 invoked by uid 89); 30 Mar 2016 18:54:27 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=0.2 required=5.0 tests=AWL,BAYES_50,RCVD_IN_DNSWL_NONE,SPF_PASS autolearn=ham version=3.3.2 spammy=parents, UD:local, UD:cygwin1.dll, cygwin1.dll
X-HELO: smtp.salomon.at
Received: from smtp.salomon.at (HELO smtp.salomon.at) (193.186.16.13) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Wed, 30 Mar 2016 18:54:20 +0000
Received: from samail03.wamas.com ([172.28.33.235] helo=mailhost.salomon.at)	by smtp.salomon.at with esmtps (UNKNOWN:DHE-RSA-AES256-SHA:256)	(Exim 4.80.1)	(envelope-from <michael.haubenwallner@ssi-schaefer.com>)	id 1alLFw-0002Fu-Hz; Wed, 30 Mar 2016 20:54:17 +0200
Received: from [172.28.41.34] (helo=s01en24)	by mailhost.salomon.at with smtp (Exim 4.77)	(envelope-from <michael.haubenwallner@ssi-schaefer.com>)	id 1alLFv-00025L-Cz; Wed, 30 Mar 2016 20:54:16 +0200
Received: by s01en24 (sSMTP sendmail emulation); Wed, 30 Mar 2016 20:54:15 +0200
From: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
To: cygwin-patches@cygwin.com
Cc: michael.haubenwallner@ssi-schaefer.com
Subject: [PATCH 4/6] forkables: Protect fork against dll-, exe-updates.
Date: Wed, 30 Mar 2016 18:54:00 -0000
Message-Id: <1459364024-24891-5-git-send-email-michael.haubenwallner@ssi-schaefer.com>
In-Reply-To: <1459364024-24891-1-git-send-email-michael.haubenwallner@ssi-schaefer.com>
References: <1459364024-24891-1-git-send-email-michael.haubenwallner@ssi-schaefer.com>
X-SW-Source: 2016-q1/txt/msg00215.txt.bz2

To support in-cygwin package managers, the fork() implementation must
not rely on .exe and .dll files to stay in their original location, as
the package manager's job is to replace these files.  Instead, we use
the hardlinks to the original binaries in /var/run/cygfork/ to create
the child process during fork, and let the main.exe.local file enable
the "DotLocal Dll Redirection" feature for dlls.

The (probably few) users that need an update-safe fork manually have to
create the /var/run/cygfork/ directory for now, using:
mkdir --mode=a=rwxt /var/run/cygfork

	* dll_init.h (struct dll_list): Declare find_by_forkedntname.
	* dll_init.cc (struct dll_list): Implement find_by_forkedntname.
	(dll_list::alloc): Use find_by_forkedntname when in load after fork.
	(dll_list::load_after_fork_impl): Use dll::forkedntname to load dlls.
	* fork.cc (frok::parent): Use forkedntname of dlls.main_executable.
---
 winsup/cygwin/dll_init.cc | 47 +++++++++++++++++++++++++++++++++--------------
 winsup/cygwin/dll_init.h  |  1 +
 winsup/cygwin/fork.cc     |  2 +-
 3 files changed, 35 insertions(+), 15 deletions(-)

diff --git a/winsup/cygwin/dll_init.cc b/winsup/cygwin/dll_init.cc
index e44ee84..71a7456 100644
--- a/winsup/cygwin/dll_init.cc
+++ b/winsup/cygwin/dll_init.cc
@@ -325,6 +325,19 @@ dll_list::find_by_modname (PCWCHAR modname)
   return NULL;
 }
 
+/* Look for a dll based on the ntname used
+   to dynamically reload in forked child. */
+dll *
+dll_list::find_by_forkedntname (PCWCHAR ntname)
+{
+  dll *d = &start;
+  while ((d = d->next) != NULL)
+    if (!wcscasecmp (ntname, d->forkedntname ()))
+      return d;
+
+  return NULL;
+}
+
 #define RETRIES 1000
 
 /* Allocate space for a dll struct. */
@@ -344,8 +357,11 @@ dll_list::alloc (HINSTANCE h, per_process *p, dll_type type)
   /* Already loaded?  For linked DLLs, only compare the basenames.  Linked
      DLLs are loaded using just the basename and the default DLL search path.
      The Windows loader picks up the first one it finds.
-     This also applies to cygwin1.dll and the main-executable (DLL_SELF).  */
-  dll *d = (type != DLL_LOAD) ? dlls.find_by_modname (modname) : dlls[ntname];
+     This also applies to cygwin1.dll and the main-executable (DLL_SELF).
+     When in_load_after_fork, dynamically loaded dll's are reloaded
+     using their parent's forkable_ntname, if available.  */
+  dll *d = (type != DLL_LOAD) ? dlls.find_by_modname (modname) :
+	   in_load_after_fork ? dlls.find_by_forkedntname (ntname) : dlls[ntname];
   if (d)
     {
       if (!in_forkee)
@@ -728,14 +744,16 @@ void dll_list::load_after_fork_impl (HANDLE parent, dll* d, int retries)
 	  fabort ("unable to release protective reservation (%p) for %W, %E",
 		  d->handle, d->ntname);
 
-	HMODULE h = LoadLibraryExW (buffered_shortname (d->ntname),
+	HMODULE h = LoadLibraryExW (buffered_shortname (d->forkedntname ()),
 				    NULL, DONT_RESOLVE_DLL_REFERENCES);
 	if (!h)
-	  fabort ("unable to create interim mapping for %W, %E", d->ntname);
+	  fabort ("unable to create interim mapping for %W (using %W), %E",
+		  d->ntname, buffered_shortname (d->forkedntname ()));
 	if (h != d->handle)
 	  {
-	    sigproc_printf ("%W loaded in wrong place: %p != %p",
-			    d->ntname, h, d->handle);
+	    sigproc_printf ("%W (using %W) loaded in wrong place: %p != %p",
+			    d->ntname, buffered_shortname (d->forkedntname ()),
+			    h, d->handle);
 	    FreeLibrary (h);
 	    PVOID reservation = reserve_at (d->ntname, h,
 					    d->handle, d->image_size);
@@ -746,8 +764,8 @@ void dll_list::load_after_fork_impl (HANDLE parent, dll* d, int retries)
 	    if (retries < DLL_RETRY_MAX)
 	      load_after_fork_impl (parent, d, retries+1);
 	    else
-	       fabort ("unable to remap %W to same address as parent (%p) - try running rebaseall",
-		       d->ntname, d->handle);
+	       fabort ("unable to remap %W (using %W) to same address as parent (%p) - try running rebaseall",
+		       d->ntname, buffered_shortname (d->forkedntname ()), d->handle);
 
 	    /* once the above returns all the dlls are mapped; release
 	       the reservation and continue unwinding */
@@ -775,17 +793,18 @@ void dll_list::load_after_fork_impl (HANDLE parent, dll* d, int retries)
 	  /* Free the library using our parent's handle: it's identical
 	     to ours or we wouldn't have gotten this far */
 	  if (!FreeLibrary (d->handle))
-	    fabort ("unable to unload interim mapping of %W, %E",
-		    d->ntname);
+	    fabort ("unable to unload interim mapping of %W (using %W), %E",
+		    d->ntname, buffered_shortname (d->forkedntname ()));
 	}
       /* cygwin1.dll - as linked dependency - may reuse the shortname
 	 buffer, even in case of failure: don't reuse shortname later */
-      HMODULE h = LoadLibraryW (buffered_shortname (d->ntname));
+      HMODULE h = LoadLibraryW (buffered_shortname (d->forkedntname ()));
       if (!h)
-	fabort ("unable to map %W, %E", d->ntname);
+	fabort ("unable to map %W (using %W), %E",
+		d->ntname, buffered_shortname (d->forkedntname ()));
       if (h != d->handle)
-	fabort ("unable to map %W to same address as parent: %p != %p",
-		d->ntname, d->handle, h);
+	fabort ("unable to map %W (using %W) to same address as parent: %p != %p",
+		d->ntname, buffered_shortname (d->forkedntname ()), d->handle, h);
     }
 }
 
diff --git a/winsup/cygwin/dll_init.h b/winsup/cygwin/dll_init.h
index 554435d..d75cbb4 100644
--- a/winsup/cygwin/dll_init.h
+++ b/winsup/cygwin/dll_init.h
@@ -108,6 +108,7 @@ class dll_list
   PWCHAR forkables_mutex_name;
   HANDLE forkables_mutex;
   void track_self ();
+  dll *find_by_forkedntname (PCWCHAR ntname);
   size_t forkable_ntnamesize (dll_type, PCWCHAR fullntname, PCWCHAR modname);
   void prepare_forkables_nomination ();
   void update_forkables_needs ();
diff --git a/winsup/cygwin/fork.cc b/winsup/cygwin/fork.cc
index 7bc3dec..52ceeb3 100644
--- a/winsup/cygwin/fork.cc
+++ b/winsup/cygwin/fork.cc
@@ -357,7 +357,7 @@ frok::parent (volatile char * volatile stack_here)
       PCWCHAR forking_progname = NULL;
       if (dlls.main_executable)
         forking_progname = dll_list::buffered_shortname
-			   (dlls.main_executable->ntname);
+			   (dlls.main_executable->forkedntname ());
       if (!forking_progname || !*forking_progname)
 	forking_progname = myself->progname;
 
-- 
2.7.3
