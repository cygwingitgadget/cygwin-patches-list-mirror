From: Jan Nieuwenhuizen <janneke@gnu.org>
To: "Robert Collins" <robert.collins@itdomain.com.au>
Cc: <cygwin-patches@cygwin.com>
Subject: Re: setup.exe remove scripts [Was: Re: experimental texmf packages]
Date: Thu, 13 Dec 2001 13:35:00 -0000
Message-ID: <m3667ax540.fsf@appel.lilypond.org>
References: <m3bshtmxhb.fsf@appel.lilypond.org> <878764062.20011128173421@nyckelpiga.de> <m37ks9lgxi.fsf@appel.lilypond.org> <4434079433.20011129221637@familiehaase.de> <m3oflgy98n.fsf@appel.lilypond.org> <9517228633.20011203135833@familiehaase.de> <m3lmgkwgeu.fsf@appel.lilypond.org> <3C0D8535.D67735D1@ece.gatech.edu> <m33d2pam3l.fsf@appel.lilypond.org> <00d501c17d93$1936c990$0200a8c0@lifelesswks> <m3zo4x7obb.fsf@appel.lilypond.org> <m38zcdssxd.fsf@appel.lilypond.org> <01a801c18036$3d447350$0200a8c0@lifelesswks> <m3itbhqowz.fsf@appel.lilypond.org> <027001c18040$c91651f0$0200a8c0@lifelesswks> <m3wuzth3l1.fsf@appel.lilypond.org> <04db01c18302$e66cae60$0200a8c0@lifelesswks>
X-SW-Source: 2001-q4/msg00308.html
Message-ID: <20011213133500.r1Ej9HF4lIXATrVBdGI3L87YKzhpsKHvK25gxnkm70o@z>

"Robert Collins" <robert.collins@itdomain.com.au> writes:

> I suspect that that is actually by design.Look at revision 1.2 of
> desktop.cc and it has the same ,'s causing separate lines.

So maybe it was very late when the code was designed :-)  Removing
/etc/profile and running (the non-fixed) setup.exe, yields this
snippet (as you can predict from looking at the code):

export PS1='\[\033]0;\w\007
\033[32m\]\u@\h \[\033[33m\w\033[0m\]
$ '

> I don't really have an opinion on whats right here,

Ok.  I like having just a one-line prompt.

> but FWIW my prompt always appears on one line

Mine too: I never use cygwin :-) Seriously, you probably never remove
/etc/profile, and probably have your own ~/.bashrc that sets your own
prompt?

> - are you running textmode or tcsh or seomthing non-default?

Nope.  Not really relevant, though, just paste the PS1 above into your
shell and see what happens.

Remaining nits fixed in patch below.  Btw, some nits are so small,
imo, that you're free to just say: Removed/fixed than going throught
the mail/reply dance, if that's more convenient for you.

Greetings,
Jan.


> Please put all changes related to a single file in one place.

Ah, ok.  That was because I see it as separate patches, and kept
chronicity.

  * install.cc:  Typo fix.
    (do_install): Run script...

> > * Makefile.in (CFLAGS): Remove -Werror to allow build of w32api
> > headers
> 
> This will not be accepted. if w32api is broken, revert it to an older
> date

Removed [, but I don't quite understand.  That is, I understand this
is the wrong fix, but I can't go and submit patches with global
impact; or hold my patch up and go diving into w32api first?  Where I
come from, it's: Thou shalt not check in something that doesn't
compile.]

> > (realclean): more clean.
> 
> *.d is cleaned by the clean target. Why are you adding it here as well?

Probably a leftover or oversight.

> > * desktop.cc (etc_profile): Remove commas between lines (and thus
> > line breaks) from PS1.
> 
> See above, I'm not for or against this - I just want to understand _why_
> it is breaking for you, and not globally.

Confident you'll see this fix is grand, kept it in.


2001-12-13  Jan Nieuwenhuizen  <janneke@gnu.org>

	* Makefile.in (realclean): more clean.
	(OBJS): Add script.o.

	* desktop.cc (etc_profile): Remove commas between lines (and thus
	line breaks) from PS1.

	* postinstall.cc (run_script_in_etc_postinstall): New function.
	 (do_postinstall): Split off new funtion init_run_script ().
	 (init_run_script):
	 (run):
	 (run_script): Move to script.cc.  Replace some deprecated remove
	 and move calls.

	* script.h:
	* script.cc: New file.
	
	* Forward port cygwin-20010707.jcn3.patch.
	
	* package_meta.cc (uninstall): Run pre- and postremove scripts.

	* install.cc (do_install): Run script initialisation.  Typo fix.



diff -purN --exclude=*~ --exclude=configure --exclude=setup_version.c --exclude=inilex.l --exclude=zlib --exclude=ChangeLog ../cinstall.orig/Makefile.in ./Makefile.in
--- ../cinstall.orig/Makefile.in	Mon Dec  3 23:22:08 2001
+++ ./Makefile.in	Thu Dec 13 20:56:52 2001
@@ -131,6 +131,7 @@ OBJS = \
 	res.o \
 	rfc1738.o \
 	root.o \
+	script.o \
 	setup_version.o \
 	simpsock.o \
 	site.o \
@@ -169,7 +170,8 @@ clean:
 	$(MAKE) -C zlib clean
 
 realclean: clean
-	rm -f  Makefile config.cache
+	rm -f Makefile
+	rm -f config.cache config.log config.status 
 
 install: all
 	$(SHELL) $(updir1)/mkinstalldirs $(bindir) $(etcdir)
diff -purN --exclude=*~ --exclude=configure --exclude=setup_version.c --exclude=inilex.l --exclude=zlib --exclude=ChangeLog ../cinstall.orig/desktop.cc ./desktop.cc
--- ../cinstall.orig/desktop.cc	Thu Nov 29 10:52:32 2001
+++ ./desktop.cc	Sun Dec  9 23:02:49 2001
@@ -81,8 +81,8 @@ static const char *etc_profile[] = {
   "done",
   "",
   "export MAKE_MODE=unix",
-  "export PS1='\\[\\033]0;\\w\\007",
-  "\\033[32m\\]\\u@\\h \\[\\033[33m\\w\\033[0m\\]",
+  "export PS1='\\[\\033]0;\\w\\007"
+  "\\033[32m\\]\\u@\\h \\[\\033[33m\\w\\033[0m\\]"
   "$ '",
   "",
   "cd \"$HOME\"",
diff -purN --exclude=*~ --exclude=configure --exclude=setup_version.c --exclude=inilex.l --exclude=zlib --exclude=ChangeLog ../cinstall.orig/install.cc ./install.cc
--- ../cinstall.orig/install.cc	Thu Nov 29 10:52:33 2001
+++ ./install.cc	Sun Dec  9 23:56:53 2001
@@ -13,7 +13,7 @@
  *
  */
 
-/* The purpose of this file is to intall all the packages selected in
+/* The purpose of this file is to install all the packages selected in
    the install list (in ini.h).  Note that we use a separate thread to
    maintain the progress dialog, so we avoid the complexity of
    handling two tasks in one thread.  We also create or update all the
@@ -53,6 +53,7 @@ static const char *cvsid =
 #include "compress_gz.h"
 #include "archive.h"
 #include "archive_tar.h"
+#include "script.h"
 
 #include "package_db.h"
 #include "package_meta.h"
@@ -418,6 +419,9 @@ do_install (HINSTANCE h)
   create_mount ("/usr/bin", cygpath ("/bin", 0), istext, issystem);
   create_mount ("/usr/lib", cygpath ("/lib", 0), istext, issystem);
   set_cygdrive_flags (istext, issystem);
+
+  /* Let's hope people won't uninstall packages before installing [b]ash */
+  init_run_script ();
 
   packagedb db;
   for (packagemeta * pkg = db.getfirstpackage (); pkg;
diff -purN --exclude=*~ --exclude=configure --exclude=setup_version.c --exclude=inilex.l --exclude=zlib --exclude=ChangeLog ../cinstall.orig/package_meta.cc ./package_meta.cc
--- ../cinstall.orig/package_meta.cc	Sun Dec  2 04:25:11 2001
+++ ./package_meta.cc	Sun Dec  9 23:15:46 2001
@@ -37,6 +37,7 @@ static const char *cvsid =
 
 
 #include "category.h"
+#include "script.h"
 
 #include "package_version.h"
 #include "cygpackage.h"
@@ -112,6 +113,8 @@ packagemeta::uninstall ()
        */
       hash dirs;
       const char *line = installed->getfirstfile ();
+
+      try_run_script ("/etc/preremove/", name);
       while (line)
 	{
 	  dirs.add_subdirs (line);
@@ -135,6 +138,7 @@ packagemeta::uninstall ()
 	  if (RemoveDirectory (d))
 	    log (LOG_BABBLE, "rmdir %s", d);
 	}
+      try_run_script ("/etc/postremove/", name);
     }
   installed = 0;
 }
diff -purN --exclude=*~ --exclude=configure --exclude=setup_version.c --exclude=inilex.l --exclude=zlib --exclude=ChangeLog ../cinstall.orig/postinstall.cc ./postinstall.cc
--- ../cinstall.orig/postinstall.cc	Tue Nov 13 02:49:32 2001
+++ ./postinstall.cc	Sun Dec  9 23:53:33 2001
@@ -22,120 +22,24 @@ static const char *cvsid =
 #endif
 
 #include "win32.h"
-
 #include <stdlib.h>
-#include <unistd.h>
-
 #include "state.h"
 #include "dialog.h"
 #include "find.h"
-#include "concat.h"
 #include "mount.h"
-
-#include "port.h"
-
-static char *sh = 0;
-static const char *cmd = 0;
-static OSVERSIONINFO verinfo;
-
-static void
-run (const char *sh, const char *args, const char *file)
-{
-  BOOL b;
-  char cmdline[_MAX_PATH];
-  STARTUPINFO si;
-  PROCESS_INFORMATION pi;
-
-  sprintf (cmdline, "%s %s %s", sh, args, file);
-  memset (&pi, 0, sizeof (pi));
-  memset (&si, 0, sizeof (si));
-  si.cb = sizeof (si);
-  si.lpTitle = (char *) "Cygwin Setup Post-Install Script";
-  si.dwFlags = STARTF_USEPOSITION;
-
-  b = CreateProcess (0, cmdline, 0, 0, 0,
-		     CREATE_NEW_CONSOLE, 0, get_root_dir (), &si, &pi);
-
-  if (b)
-    WaitForSingleObject (pi.hProcess, INFINITE);
-}
+#include "script.h"
 
 static void
-each (char *fname, unsigned int size)
+run_script_in_etc_postinstall (char *fname, unsigned int size)
 {
-  char *ext = strrchr (fname, '.');
-  if (!ext)
-    return;
-
-  if (sh && strcmp (ext, ".sh") == 0)
-    {
-      char *f2 = concat ("/etc/postinstall/", fname, 0);
-      run (sh, "-c", f2);
-      free (f2);
-    }
-  else if (cmd && strcmp (ext, ".bat") == 0)
-    {
-      char *f2 = backslash (cygpath ("/etc/postinstall/", fname, 0));
-      run (cmd, "/c", f2);
-      free (f2);
-    }
-  else
-    return;
-
-  /* if file exists then delete it otherwise just ignore no file error */
-  remove (cygpath ("/etc/postinstall/", fname, ".done", 0));
-
-  rename (cygpath ("/etc/postinstall/", fname, 0),
-	  cygpath ("/etc/postinstall/", fname, ".done", 0));
+   run_script ("/etc/postinstall/", fname);
 }
 
-static const char *shells[] = {
-  "/bin/sh.exe",
-  "/usr/bin/sh.exe",
-  "/bin/bash.exe",
-  "/usr/bin/bash.exe",
-  0
-};
-
 void
 do_postinstall (HINSTANCE h)
 {
   next_dialog = 0;
-  int i;
-  for (i = 0; shells[i]; i++)
-    {
-      sh = backslash (cygpath (shells[i], 0));
-      if (_access (sh, 0) == 0)
-	break;
-      free (sh);
-      sh = 0;
-    }
-
-  char old_path[_MAX_PATH];
-  GetEnvironmentVariable ("PATH", old_path, sizeof (old_path));
-  SetEnvironmentVariable ("PATH",
-			  backslash (cygpath ("/bin;",
-					      get_root_dir (), "/usr/bin;",
-					      old_path, 0)));
-
-  SetEnvironmentVariable ("CYGWINROOT", get_root_dir ());
+  init_run_script ();
   SetCurrentDirectory (get_root_dir ());
-
-  verinfo.dwOSVersionInfoSize = sizeof (verinfo);
-  GetVersionEx (&verinfo);
-
-  switch (verinfo.dwPlatformId)
-    {
-    case VER_PLATFORM_WIN32_NT:
-      cmd = "cmd.exe";
-      break;
-    case VER_PLATFORM_WIN32_WINDOWS:
-      cmd = "command.com";
-      break;
-    default:
-      cmd = "command.com";
-      break;
-    }
-
-  find (cygpath ("/etc/postinstall", 0), each);
+  find (cygpath ("/etc/postinstall", 0), run_script_in_etc_postinstall);
 }
diff -purN --exclude=*~ --exclude=configure --exclude=setup_version.c --exclude=inilex.l --exclude=zlib --exclude=ChangeLog ../cinstall.orig/script.cc ./script.cc
--- ../cinstall.orig/script.cc	Thu Jan  1 01:00:00 1970
+++ ./script.cc	Mon Dec 10 10:03:45 2001
@@ -0,0 +1,145 @@
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
+ * Written by DJ Delorie <dj@cygnus.com>
+ *            Jan Nieuwenhuizen <janneke@gnu.org>
+ *
+ */
+
+/* The purpose of this file is to provide functions for the invocation
+   of install scripts. */
+
+#if 0
+static const char *cvsid =
+  "\n%%% $Id: $\n";
+#endif
+
+#include "win32.h"
+#include <stdlib.h>
+#include <unistd.h>
+#include <stdio.h>
+#include "log.h"
+#include "concat.h"
+#include "mount.h"
+#include "io_stream.h"
+
+static char *sh = 0;
+static const char *cmd = 0;
+static OSVERSIONINFO verinfo;
+
+static const char *shells[] = {
+  "/bin/sh.exe",
+  "/usr/bin/sh.exe",
+  "/bin/bash.exe",
+  "/usr/bin/bash.exe",
+  0
+};
+
+void
+init_run_script ()
+{
+  for (int i = 0; shells[i]; i++)
+    {
+      sh = backslash (cygpath (shells[i], 0));
+      if (_access (sh, 0) == 0)
+	break;
+      free (sh);
+      sh = 0;
+    }
+  
+  char old_path[_MAX_PATH];
+  GetEnvironmentVariable ("PATH", old_path, sizeof (old_path));
+  SetEnvironmentVariable ("PATH",
+			  backslash (cygpath ("/bin;",
+					      get_root_dir (), "/usr/bin;",
+					      old_path, 0)));
+
+  SetEnvironmentVariable ("CYGWINROOT", get_root_dir ());
+
+  verinfo.dwOSVersionInfoSize = sizeof (verinfo);
+  GetVersionEx (&verinfo);
+
+  switch (verinfo.dwPlatformId)
+    {
+    case VER_PLATFORM_WIN32_NT:
+      cmd = "cmd.exe";
+      break;
+    case VER_PLATFORM_WIN32_WINDOWS:
+      cmd = "command.com";
+      break;
+    default:
+      cmd = "command.com";
+      break;
+    }
+}
+
+static void
+run (const char *sh, const char *args, const char *file)
+{
+  BOOL b;
+  char cmdline[_MAX_PATH];
+  STARTUPINFO si;
+  PROCESS_INFORMATION pi;
+
+  sprintf (cmdline, "%s %s %s", sh, args, file);
+  memset (&pi, 0, sizeof (pi));
+  memset (&si, 0, sizeof (si));
+  si.cb = sizeof (si);
+  si.lpTitle = (char *) "Cygwin Setup Post-Install Script";
+  si.dwFlags = STARTF_USEPOSITION;
+
+  b = CreateProcess (0, cmdline, 0, 0, 0,
+		     CREATE_NEW_CONSOLE, 0, get_root_dir (), &si, &pi);
+
+  if (b)
+    WaitForSingleObject (pi.hProcess, INFINITE);
+}
+
+void
+run_script (char const *dir, char const *fname)
+{
+  char *ext = strrchr (fname, '.');
+  if (!ext)
+    return;
+
+  if (sh && strcmp (ext, ".sh") == 0)
+    {
+      char *f2 = concat (dir, fname, 0);
+      log (0, "running: %s -c %s", sh, f2);
+      run (sh, "-c", f2);
+      free (f2);
+    }
+  else if (cmd && strcmp (ext, ".bat") == 0)
+    {
+      char *f2 = backslash (cygpath (dir, fname, 0));
+      log (0, "running: %s /c %s", cmd, f2);
+      run (cmd, "/c", f2);
+      free (f2);
+    }
+  else
+    return;
+
+  /* if file exists then delete it otherwise just ignore no file error */
+  io_stream::remove (concat ("cygpath://", dir, fname, ".done", 0));
+
+  io_stream::move (concat ("cygpath://", dir, fname, 0),
+		   concat ("cygpath://", dir, fname, ".done", 0));
+}
+
+void
+try_run_script (char const *dir, char const *fname)
+{
+  if (io_stream::exists (concat ("cygfile://", dir, fname, ".sh", 0)))
+    run_script (dir, concat (fname, ".sh", 0));
+  if (io_stream::exists (concat ("cygfile://", dir, fname, ".bat", 0)))
+    run_script (dir, concat (fname, ".bat", 0));
+}
+
diff -purN --exclude=*~ --exclude=configure --exclude=setup_version.c --exclude=inilex.l --exclude=zlib --exclude=ChangeLog ../cinstall.orig/script.h ./script.h
--- ../cinstall.orig/script.h	Thu Jan  1 01:00:00 1970
+++ ./script.h	Thu Dec 13 20:58:32 2001
@@ -0,0 +1,30 @@
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
+#ifndef SCRIPT_H
+#define SCRIPT_H
+
+/* Run the script fname, found in dir.  If fname has suffix .sh, and
+   we have a Bourne shell, execute it using sh.  Otherwise, if fname
+   has suffix .bat, execute using cmd */
+   
+void run_script (char const *dir, char const *fname);
+
+/* Initialisation stuff for run_script: sh, cmd, CYGWINROOT and PATH */
+void init_run_script ();
+
+/* Run the scripts fname.sh and fname.bat, found in dir. */
+void try_run_script (char const *dir, char const *fname);
+
+#endif /* SCRIPT_H */




-- 
Jan Nieuwenhuizen <janneke@gnu.org> | GNU LilyPond - The music typesetter
http://www.xs4all.nl/~jantien       | http://www.lilypond.org
