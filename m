From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: [janneke@gnu.org: Re: Install and Uninstall Scripts]
Date: Wed, 11 Jul 2001 19:57:00 -0000
Message-id: <20010711225756.C1501@redhat.com>
X-SW-Source: 2001-q3/msg00011.html

----- Forwarded message from Jan Nieuwenhuizen <janneke@gnu.org> -----

From: Jan Nieuwenhuizen <janneke@gnu.org>
To: "Michael A. Chase" <mchase@ix.netcom.com>
Cc: <cygwin-developers@cygwin.com>, cygwin@cygwin.com
Subject: Re: Install and Uninstall Scripts
Date: 11 Jul 2001 20:13:06 +0200
Organization: Jan at Appel
In-Reply-To: <010c01c1097e$1a417030$6464648a@ca.boeing.com> ("Michael A. Chase"'s message of "Tue, 10 Jul 2001 13:09:12 -0700")

"Michael A. Chase" <mchase@ix.netcom.com> writes:

> The main problem I see with the way you had /etc/postremove/... is that if
> the script is part of the package, it will be removed by setup.exe before it
> has a chance to get executed.

Ok, I've added both for now.  Maybe we should just not remove any file
named /etc/postremove/<pgk>.*.  Anyway, here's a new, much more
contrib.html compliant, even somewhat tested version.

Greetings,
Jan.

winsup/cinstall/ChangeLog:
Thu Jun 21 15:47:22 CEST 2001  Jan Nieuwenhuizen  <janneke@gnu.org>

	* postinstall.h: New file.
	* postinstall.cc (init_run_script): New function, share shell init.
	(run_script):  New function, more generic run-script functionality.
	Add logging.
	* install.cc (uninstall_one): Add handling of /etc/preremove and 
	/etc/postremove scripts.

diff -urpN --exclude=*~ --exclude=ChangeLog ../cinstall.orig/install.cc ./install.cc
--- ../cinstall.orig/install.cc	Tue Jul 10 20:45:41 2001
+++ ./install.cc	Wed Jul 11 19:50:43 2001
@@ -47,6 +47,7 @@ static char *cvsid = "\n%%% $Id: install
 #include "hash.h"
 #include "mount.h"
 #include "filemanip.h"
+#include "postinstall.h"
 
 #include "port.h"
 
@@ -218,6 +219,15 @@ exists (const char *file)
   return 0;
 }
 
+static void
+try_run_script (char *dir, char *fname)
+{
+  if (exists (cygpath (dir, fname, ".sh", 0)))
+    run_script (dir, concat (fname, ".sh", 0));
+  if (exists (cygpath (dir, fname, ".bat", 0)))
+    run_script (dir, concat (fname, ".bat", 0));
+}
+
 static int num_installs, num_uninstalls;
 
 static void
@@ -237,6 +247,8 @@ uninstall_one (Package *pkg, bool src)
       else
 	log (0, "Uninstalling old %s", pkg->name);
 
+      try_run_script ("/etc/preremove/", pkg->name);
+
       while (gzgets (lst, line, sizeof (line)))
 	{
 	  if (line[strlen(line)-1] == '\n')
@@ -256,6 +268,8 @@ uninstall_one (Package *pkg, bool src)
 
       remove (cygpath ("/etc/setup/", pkg->name, ".lst.gz", 0));
 
+      try_run_script ("/etc/postremove/", pkg->name);
+
       dirs.reverse_sort ();
       char *subdir = 0;
       while ((subdir = dirs.enumerate (subdir)) != 0)
@@ -470,6 +484,9 @@ do_install (HINSTANCE h)
   create_mount ("/usr/lib", cygpath ("/lib", 0), istext, issystem);
   set_cygdrive_flags (istext, issystem);
 
+  /* Let's hope people won't uninstall packages before installing [b]ash */
+  init_run_script ();
+  
   for (Package *pkg = package; pkg->name; pkg++)
     {
       Info *pi = pkg->info + pkg->trust;
diff -urpN --exclude=*~ --exclude=ChangeLog ../cinstall.orig/postinstall.cc ./postinstall.cc
--- ../cinstall.orig/postinstall.cc	Tue May 29 05:55:41 2001
+++ ./postinstall.cc	Wed Jul 11 19:45:38 2001
@@ -28,6 +28,7 @@ static char *cvsid = "\n%%% $Id: postins
 #include "find.h"
 #include "concat.h"
 #include "mount.h"
+#include "log.h"
 
 #include "port.h"
 
@@ -57,8 +58,8 @@ run (char *sh, char *args, char *file)
     WaitForSingleObject (pi.hProcess, INFINITE);
 }
 
-static void
-each (char *fname, unsigned int size)
+void
+run_script (char *dir, char *fname)
 {
   char *ext = strrchr (fname, '.');
   if (!ext)
@@ -66,21 +67,28 @@ each (char *fname, unsigned int size)
 
   if (sh && strcmp (ext, ".sh") == 0)
     {
-      char *f2 = concat ("/etc/postinstall/", fname, 0);
+      char *f2 = concat (dir, fname, 0);
+      log (0, "running: %s -c %s", sh, f2);
       run (sh, "-c", f2);
       free (f2);
     }
   else if (cmd && strcmp (ext, ".bat") == 0)
     {
-      char *f2 = backslash (cygpath ("/etc/postinstall/", fname, 0));
+      char *f2 = backslash (cygpath (dir, fname, 0));
+      log (0, "running: %s /c %s", cmd, f2);
       run (cmd, "/c", f2);
       free (f2);
     }
   else
     return;
 
-  rename (cygpath ("/etc/postinstall/", fname, 0),
-	  cygpath ("/etc/postinstall/", fname, ".done", 0));
+  rename (cygpath (dir, fname, 0), cygpath (dir, fname, ".done", 0));
+}
+
+static void
+run_script_in_etc_postinstall (char *fname, unsigned int size)
+{
+  run_script ("/etc/postinstall/", fname);
 }
 
 static char *shells [] = {
@@ -92,11 +100,9 @@ static char *shells [] = {
 };
 
 void
-do_postinstall (HINSTANCE h)
+init_run_script ()
 {
-  next_dialog = 0;
-  int i;
-  for (i=0; shells[i]; i++)
+  for (int i=0; shells[i]; i++)
     {
       sh = backslash (cygpath (shells[i], 0));
       if (_access (sh, 0) == 0)
@@ -104,7 +110,7 @@ do_postinstall (HINSTANCE h)
       free (sh);
       sh = 0;
     }
-
+  
   char old_path[_MAX_PATH];
   GetEnvironmentVariable ("PATH", old_path, sizeof (old_path));
   SetEnvironmentVariable ("PATH",
@@ -113,7 +119,6 @@ do_postinstall (HINSTANCE h)
 					     old_path, 0)));
 
   SetEnvironmentVariable ("CYGWINROOT", get_root_dir ());
-  SetCurrentDirectory (get_root_dir ());
 
   verinfo.dwOSVersionInfoSize = sizeof (verinfo);
   GetVersionEx (&verinfo);
@@ -130,6 +135,13 @@ do_postinstall (HINSTANCE h)
       cmd = "command.com";
       break;
     }
+}
 
-  find (cygpath ("/etc/postinstall", 0), each);
+void
+do_postinstall (HINSTANCE h)
+{
+  next_dialog = 0;
+  init_run_script ();
+  SetCurrentDirectory (get_root_dir ());
+  find (cygpath ("/etc/postinstall", 0), run_script_in_etc_postinstall);
 }
diff -urpN --exclude=*~ --exclude=ChangeLog ../cinstall.orig/postinstall.h ./postinstall.h
--- ../cinstall.orig/postinstall.h	Thu Jan  1 01:00:00 1970
+++ ./postinstall.h	Wed Jul 11 19:20:12 2001
@@ -0,0 +1,28 @@
+/*
+ * Copyright (c) 2001, Jan Nieuwenhuizen.
+ *
+ *     This program is free software; you can redistribute it and/or modify
+ *     it under the terms of the GNU General Public License as published by
+ *     the Free Software Foundation; either version 2 of the License, or
+ *     (at your option) any later version.
+ *
+ *     A copy of the GNU General Public License can be found at
+ *     http://www.gnu.org/
+ *
+ * Written by Jan Nieuwenhuizen <janneke@gnu.org>
+ *
+ */
+#ifndef POSTINSTALL_H
+#define POSTINSTALL_H
+
+/* Run the script fname, found in dir.  If fname has suffix .sh, and
+   we have a Bourne shell, execute it using sh.  Otherwise, if fname
+   has suffix .bat, execute using cmd */
+   
+void run_script (char *dir, char *fname);
+
+/* Initialisation stuff for run_script: sh, cmd, CYGWINROOT and PATH */
+void init_run_script ();
+
+#endif /* POSTINSTALL_H */
+
diff -urpN --exclude=*~ --exclude=ChangeLog ../cinstall.orig/version.c ./version.c
--- ../cinstall.orig/version.c	Thu Jan  1 01:00:00 1970
+++ ./version.c	Wed Jul 11 19:24:05 2001
@@ -0,0 +1,2 @@
+char *version = "2.90";
+static char *id = "\n%%% setup-version 2.90\n";


-- 
Jan Nieuwenhuizen <janneke@gnu.org> | GNU LilyPond - The music typesetter
http://www.xs4all.nl/~jantien       | http://www.lilypond.org


--
Unsubscribe info:      http://cygwin.com/ml/#unsubscribe-simple
Bug reporting:         http://cygwin.com/bugs.html
Documentation:         http://cygwin.com/docs.html
FAQ:                   http://cygwin.com/faq/

----- End forwarded message -----

-- 
cgf@cygnus.com                        Red Hat, Inc.
http://sources.redhat.com/            http://www.redhat.com/
