From: Michael Hoffman <grouse@mail.utexas.edu>
To: cygwin-patches@cygwin.com
Subject: winsup/cinstall/desktop.cc: link to rxvt instead of cygwin.bat
Date: Sun, 23 Sep 2001 17:52:00 -0000
Message-id: <Pine.WNT.4.40.0109231820080.800-100000@barbecueworld>
X-SW-Source: 2001-q3/msg00186.html

This is a patch to change setup so desktop and Start Menu shortcuts will
link to rxvt instead of cygwin.bat, only if rxvt is installed.
Otherwise, it will link to bash --login -i. It still creates cygwin.bat
and doesn't rewrite existing shortcuts, in case people still want to use
the batch file. Changing from cygwin.bat to bash --login -i was
suggested more than a year ago and DJ said "Patches welcome," so here is
the patch. :-)

http://sources.redhat.com/ml/cygwin/2000-08/msg00514.html

Since the shortcuts no longer link to a batch file, I don't think the
code in make_link that constructs a command line for Win9X should be
necessary. But I don't have a Win9X system to test on, so I left it
alone.

Please let me know if you have any thoughts about this.

Respectfully submitted,
-- 
Michael Hoffman <grouse@mail.utexas.edu>
The University of Texas at Austin

2001-09-23  Michael Hoffman  <grouse@mail.utexas.edu>

* desktop.cc (do_desktop_setup): Link Start Menu and Desktop shortcuts
to rxvt if it is installed, '/bin/bash --login -i' if it is not, but not
cygwin.bat.
(make_link, start_menu, desktop_icon): New arg 'args' contains shortcut
arguments.
(check_desktop, check_startmenu): Remove unused arg 'target'.
All callers changed.
* choose.h (isinstalled): Export.
* choose.cc (isinstalled): Export.

--- desktop.cc-orig	Sun Aug 12 13:26:26 2001
+++ desktop.cc	Sun Sep 23 19:28:31 2001
@@ -28,6 +28,7 @@ static char *cvsid = "\n%%% $Id: desktop
 #include <unistd.h>

 #include "resource.h"
+#include "choose.h"
 #include "ini.h"
 #include "msg.h"
 #include "state.h"
@@ -89,11 +90,16 @@ static char *etc_profile[] = {
 #define COMMAND9XARGS "/E:4096 /c"
 #define COMMAND9XEXE  "\\command.com"

+static char *bash_path_cygwin = "/bin/bash";
+static char *bash_args = "--login -i";
+static char *rxvt_path_cygwin = "/bin/rxvt";
+static char *rxvt_args = "-bg black -fg white -sr -sl 1000 -fn 'Fixedsys' -e /bin/bash --login -i";
+
 static char *batname;
 static char *iconname;

 static void
-make_link (char *linkpath, char *title, char *target)
+make_link (char *linkpath, char *title, char *target, char *args)
 {
   char argbuf[_MAX_PATH];
   char *fname = concat (linkpath, "/", title, ".lnk", 0);
@@ -101,17 +107,16 @@ make_link (char *linkpath, char *title,
   if (_access (fname, 0) == 0)
     return; /* already exists */

-  msg ("make_link %s, %s, %s\n", fname, title, target);
+  msg ("make_link %s, %s, %s, %s\n", fname, title, target, args);

   mkdir_p (0, fname);

-  char *exepath, *args;
+  char *exepath;

   /* If we are running Win9x, build a command line. */
   if (verinfo.dwPlatformId == VER_PLATFORM_WIN32_NT)
     {
       exepath = target;
-      args = "";
     }
   else
     {
@@ -120,7 +125,7 @@ make_link (char *linkpath, char *title,

       GetWindowsDirectory (windir, sizeof (windir));
       exepath = concat (windir, COMMAND9XEXE, 0);
-      sprintf (argbuf, "%s %s", COMMAND9XARGS, target);
+      sprintf (argbuf, "%s %s %s", COMMAND9XARGS, target, args);
       args = argbuf;
     }

@@ -129,7 +134,7 @@ make_link (char *linkpath, char *title,
 }

 static void
-start_menu (char *title, char *target)
+start_menu (char *title, char *target, char *args)
 {
   char path[_MAX_PATH];
   LPITEMIDLIST id;
@@ -146,11 +151,11 @@ start_menu (char *title, char *target)
   }
 // end of Win95 addition
   strcat (path, "/Cygnus Solutions");
-  make_link (path, title, target);
+  make_link (path, title, target, args);
 }

 static void
-desktop_icon (char *title, char *target)
+desktop_icon (char *title, char *target, char *args)
 {
   char path[_MAX_PATH];
   LPITEMIDLIST id;
@@ -167,7 +172,7 @@ desktop_icon (char *title, char *target)
      msg("Desktop directory for deskop link changed to: %s",path);
   }
 // end of Win95 addition
-  make_link (path, title, target);
+  make_link (path, title, target, args);
 }

 static void
@@ -314,18 +319,36 @@ save_icon ()
 static void
 do_desktop_setup()
 {
+  char *shortcut_path_win, *shortcut_args;
+  Package *rxvt_pkg;
+
+  rxvt_pkg = getpkgbyname("rxvt");
+
   save_icon ();

   make_cygwin_bat ();
   make_etc_profile ();
   make_passwd_group ();

+  if ( isinstalled(rxvt_pkg, TRUST_UNKNOWN)
+      || isinstalled(rxvt_pkg, TRUST_PREV)
+      || isinstalled(rxvt_pkg, TRUST_CURR) )
+    {
+      shortcut_path_win = backslash (cygpath (rxvt_path_cygwin, 0));
+      shortcut_args = rxvt_args;
+    }
+  else
+    {
+      shortcut_path_win = backslash (cygpath (bash_path_cygwin, 0));
+      shortcut_args = bash_args;
+    }
+
   if (root_menu) {
-    start_menu ("Cygwin Bash Shell", batname);
+    start_menu ("Cygwin Bash Shell", shortcut_path_win, shortcut_args);
   }

   if (root_desktop) {
-    desktop_icon ("Cygwin", batname);
+    desktop_icon ("Cygwin", shortcut_path_win, shortcut_args);
   }
 }

@@ -346,7 +369,7 @@ load_dialog (HWND h)
   check_if_enable_next (h);
 }

-static int check_desktop (char *title, char *target)
+static int check_desktop (char *title)
 {
   char path[_MAX_PATH];
   LPITEMIDLIST id;
@@ -375,7 +398,7 @@ static int check_desktop (char *title, c
   return IDC_ROOT_DESKTOP;
 }

-static int check_startmenu (char *title, char *target)
+static int check_startmenu (char *title)
 {
   char path[_MAX_PATH];
   LPITEMIDLIST id;
@@ -463,8 +486,8 @@ do_desktop (HINSTANCE h)
   verinfo.dwOSVersionInfoSize = sizeof (verinfo);
   GetVersionEx (&verinfo);

-  root_desktop = check_desktop("Cygwin",backslash (cygpath ("/cygwin.bat", 0)));
-  root_menu = check_startmenu("Cygwin Bash Shell",backslash (cygpath ("/cygwin.bat", 0)));
+  root_desktop = check_desktop("Cygwin");
+  root_menu = check_startmenu("Cygwin Bash Shell");

   int rv = 0;

--- choose.cc-orig	Sun Sep 23 19:49:05 2001
+++ choose.cc	Sun Sep 23 19:23:22 2001
@@ -89,7 +89,7 @@ static struct _header cat_headers[] = {
 static int add_required(Package *pkg);
 static void set_view_mode (HWND h, views mode);

-static bool
+extern bool
 isinstalled (Package *pkg, int trust)
 {
   if (source == IDC_SOURCE_DOWNLOAD)

--- choose.h-orig	Sun Sep 23 19:48:58 2001
+++ choose.h	Sun Sep 23 19:23:18 2001
@@ -77,4 +77,6 @@ class _view

 };

+extern bool isinstalled (Package *, int);
+
 #endif /* _CHOOSE_H_ */
