From: Brian Keener <bkeener@thesoftwaresource.com>
To: cygwin-patches <cygwin-patches@cygwin.com>
Subject: [patch] setup.exe changes for Redownload/Reinstall Current version or Sources only - Part 2
Date: Thu, 03 May 2001 14:06:00 -0000
Message-id: <VA.00000757.0015edd1@thesoftwaresource.com>
X-SW-Source: 2001-q2/msg00187.html

And now here is the actual diff for the change.

Index: choose.cc
===================================================================
RCS file: /cvs/src/src/winsup/cinstall/choose.cc,v
retrieving revision 2.15
diff -u -p -r2.15 choose.cc
--- choose.cc  2001/04/19 00:40:39 2.15
+++ choose.cc  2001/05/03 15:53:14
@@ -54,6 +54,8 @@ static char *cvsid = "\n%%% $Id: choose.
 #define TRUST_KEEP    101
 #define TRUST_UNINSTALL   102
 #define TRUST_NONE    103
+#define TRUST_REDO    104
+#define TRUST_SRC_ONLY    105
 
 static int initialized = 0;
 
@@ -62,7 +64,7 @@ static int which_trust = TRUST_CURR;
 
 static int scroll_ulc_x, scroll_ulc_y;
 
-static HWND lv, nextbutton;
+static HWND lv, nextbutton, choose_inst_text;
 static TEXTMETRIC tm;
 static int header_height;
 static HANDLE sysfont;
@@ -169,9 +171,11 @@ paint (HWND hwnd)
       HANDLE check_bm = bm_checkna;
       if (extra[i].chooser[extra[i].pick].src_avail)
   {
-    if (package[i].srcaction == SRCACTION_NO)
+    if (package[i].srcaction == SRCACTION_NO &&
+        extra[i].chooser[extra[i].pick].trust != TRUST_SRC_ONLY)
       check_bm = bm_checkno;
-    else if (package[i].srcaction == SRCACTION_YES)
+    else if (package[i].srcaction == SRCACTION_YES || 
+             extra[i].chooser[extra[i].pick].trust == TRUST_SRC_ONLY)
       check_bm = bm_checkyes;
   }
       SelectObject (bitmap_dc, check_bm);
@@ -523,6 +527,21 @@ build_labels ()
     c++;
   }
 
+      if (extra[i].installed_ver && 
+    package[i].info[extra[i].which_is_installed].source && 
+    ((package[i].info[extra[i].which_is_installed].source_exists && 
+    source==IDC_SOURCE_CWD) ||
+    source==IDC_SOURCE_DOWNLOAD || source==IDC_SOURCE_NETINST ))
+  {
+    C.caption = "Sources";
+    if (package[i].info[extra[i].which_is_installed].source_exists == 1 
&&
+       source == IDC_SOURCE_DOWNLOAD)
+      C.caption = "Redo Sources";
+    C.trust = TRUST_SRC_ONLY;
+    C.src_avail = 1; 
+    c++;
+  }
+
       for (t = TRUST_PREV; t < NTRUST; t++)
   if (package[i].info[t].install)
     if (t != extra[i].which_is_installed)
@@ -539,6 +558,25 @@ build_labels ()
       C.src_avail = 1;
         c++;
       }
+    else
+      {
+        if (source == IDC_SOURCE_DOWNLOAD)
+      {
+        C.caption = "ReDownload";
+      }
+        else
+      {
+        C.caption = "ReInstall";
+      }
+        if (package[i].info[t].source && 
+        ((package[i].info[t].source_exists && 
+        source==IDC_SOURCE_CWD) || 
+        source == IDC_SOURCE_DOWNLOAD || source==IDC_SOURCE_NETINST))
+      C.src_avail = 1;
+        C.trust = TRUST_REDO;
+        c++;
+            }
+
 
       if (c == 0)
   {
@@ -690,6 +728,11 @@ dialog_proc (HWND h, UINT message, WPARA
     case WM_INITDIALOG:
       nextbutton = GetDlgItem (h, IDOK);
       frame = GetDlgItem (h, IDC_LISTVIEW_POS);
+      choose_inst_text = GetDlgItem(h,IDC_CHOOSE_INST_TEXT);
+      if (source == IDC_SOURCE_DOWNLOAD)
+        SetWindowText (choose_inst_text, "Select packages to download 
");
+      else 
+        SetWindowText (choose_inst_text, "Select packages to install ");
       GetParentRect (h, frame, &r);
       r.top += 2;
       r.bottom -= 2;
@@ -815,9 +858,9 @@ scan2 (char *path, unsigned int size)
             break;
           }
       }
-        break;
+      break;
       }
-  }
+    }  
       if (strcmp (pkginfo, mainpkg) == 0)
   {
     for (t = 0; t < NTRUST; t++)
@@ -985,7 +1028,7 @@ do_choose (HINSTANCE h)
     }
 
   register_windows (h);
-
+  
   if (source == IDC_SOURCE_DOWNLOAD || source == IDC_SOURCE_CWD)
     scan_downloaded_files ();
 
@@ -1011,14 +1054,29 @@ do_choose (HINSTANCE h)
     package[i].trust = extra[i].chooser[extra[i].pick].trust;
     break;
 
+  case TRUST_REDO:
+    package[i].action = ACTION_REDO;
+    package[i].trust = which_trust;
+    break;
+
   case TRUST_UNINSTALL:
     package[i].action = ACTION_UNINSTALL;
+    if (package[i].srcaction == SRCACTION_YES)
+      package[i].action = ACTION_SRC_ONLY;
+    break;
+  
+  case TRUST_SRC_ONLY:
+    package[i].action = ACTION_SRC_ONLY;
+    package[i].trust = which_trust;
+    package[i].srcaction = SRCACTION_YES;
     break;
 
   case TRUST_KEEP:
   case TRUST_NONE:
   default:
-    package[i].action = ACTION_SAME;
+          package[i].action = ACTION_SAME;
+    if (package[i].srcaction == SRCACTION_YES)
+      package[i].action = ACTION_SRC_ONLY;
     break;
   }
     }
@@ -1036,6 +1094,11 @@ do_choose (HINSTANCE h)
               : (package[i].action == ACTION_NEW) ? "new"
               : (package[i].action == ACTION_UPGRADE) ? "upgrade"
               : (package[i].action == ACTION_UNINSTALL) ? "uninstall"
+              : (package[i].action == ACTION_REDO && 
+                source == IDC_SOURCE_DOWNLOAD) ? "redownload"
+              : (package[i].action == ACTION_REDO && 
+                source != IDC_SOURCE_DOWNLOAD) ? "reinstall"
+              : (package[i].action == ACTION_SRC_ONLY) ? "sources"
               : (package[i].action == ACTION_ERROR) ? "error"
               : "unknown");
       const char *installed = ((extra[i].which_is_installed == -1) ? 
"none"
Index: desktop.cc
===================================================================
RCS file: /cvs/src/src/winsup/cinstall/desktop.cc,v
retrieving revision 2.6
diff -u -p -r2.6 desktop.cc
--- desktop.cc 2000/11/09 01:40:15 2.6
+++ desktop.cc 2001/05/03 15:53:14
@@ -266,7 +266,8 @@ make_passwd_group ()
 
       LOOP_PACKAGES
   {
-    if (!strcmp (package[i].name, "cygwin"))
+    if (!strcmp (package[i].name, "cygwin") && 
+       package[i].action != ACTION_SRC_ONLY)
       {
         /* mkpasswd and mkgroup are not working on 9x/ME up to 1.1.5-4 
*/
         char *border_version = canonicalize_version ("1.1.5-4");
Index: download.cc
===================================================================
RCS file: /cvs/src/src/winsup/cinstall/download.cc,v
retrieving revision 2.10
diff -u -p -r2.10 download.cc
--- download.cc    2001/03/15 19:06:23 2.10
+++ download.cc    2001/05/03 15:53:14
@@ -21,6 +21,7 @@ static char *cvsid = "\n%%% $Id: downloa
 #include "win32.h"
 
 #include <stdio.h>
+#include <unistd.h>
 
 #include "resource.h"
 #include "msg.h"
@@ -31,6 +32,7 @@ static char *cvsid = "\n%%% $Id: downloa
 #include "state.h"
 #include "mkdir.h"
 #include "log.h"
+#include "port.h"
 
 #define pi (package[i].info[package[i].trust])
 
@@ -52,14 +54,15 @@ get_file_size (char *name)
 }
 
 static int
-download_one (char *name, int expected_size)
+download_one (char *name, int expected_size, int action)
 {
   char *local = name;
   int errors = 0;
 
   DWORD size;
   if ((size = get_file_size (local)) > 0)
-    if (size == expected_size)
+    if (size == expected_size && action != ACTION_SRC_ONLY 
+  && action != ACTION_REDO )
       return 0;
 
   mkdir_p (0, local);
@@ -77,6 +80,8 @@ download_one (char *name, int expected_s
       if (size == expected_size)
   {
     log (0, "Downloaded %s", local);
+    if ( _access (local , 0) == 0)
+       remove ( local );
     rename (concat (local, ".tmp", 0), local);
   }
       else
@@ -100,19 +105,34 @@ do_download (HINSTANCE h)
   total_download_bytes_sofar = 0;
 
   for (i=0; i<npackages; i++)
-    if (package[i].action == ACTION_NEW || package[i].action == 
ACTION_UPGRADE)
+    if (package[i].action == ACTION_NEW || package[i].action == 
ACTION_UPGRADE
+  || package[i].action == ACTION_REDO 
+  || package[i].action == ACTION_SRC_ONLY)
       {
-        total_download_bytes += pi.install_size;
-        if (package[i].srcaction == SRCACTION_YES)
+        DWORD size = get_file_size (pi.install);
+  char *local = pi.install;
+        if (package[i].action != ACTION_SRC_ONLY && 
+     (package[i].action == ACTION_REDO || 
+     size != pi.install_size))
+    total_download_bytes += pi.install_size;
+  local = pi.source;
+  size = get_file_size (pi.source);
+        if (package[i].srcaction == SRCACTION_YES &&
+     (package[i].action == ACTION_SRC_ONLY || 
+     size != pi.source_size))
           total_download_bytes += pi.source_size;
       }
 
   for (i=0; i<npackages; i++)
-    if (package[i].action == ACTION_NEW || package[i].action == 
ACTION_UPGRADE)
+    if (package[i].action == ACTION_NEW || package[i].action == 
ACTION_UPGRADE
+  || package[i].action == ACTION_REDO 
+  || package[i].action == ACTION_SRC_ONLY)
       {
-  int e = download_one (pi.install, pi.install_size);
+  int e = 0;
+        if (package[i].action != ACTION_SRC_ONLY)
+    e += download_one (pi.install, pi.install_size, package[i].action);
   if (package[i].srcaction == SRCACTION_YES && pi.source)
-    e += download_one (pi.source, pi.source_size);
+    e += download_one (pi.source, pi.source_size, package[i].action);
   errors += e;
   if (e)
     package[i].action = ACTION_ERROR;
Index: ini.h
===================================================================
RCS file: /cvs/src/src/winsup/cinstall/ini.h,v
retrieving revision 2.5
diff -u -p -r2.5 ini.h
--- ini.h  2001/03/06 13:21:58 2.5
+++ ini.h  2001/05/03 15:53:14
@@ -35,6 +35,8 @@
 #define ACTION_UPGRADE        3
 #define ACTION_UNINSTALL  4
 #define ACTION_ERROR      5
+#define ACTION_REDO       6
+#define ACTION_SRC_ONLY       7
 
 #define SRCACTION_NO      0
 #define SRCACTION_YES     1
@@ -74,7 +76,9 @@ void ini_init (char *string);
 #define LOOP_PACKAGES \
   for (i=0; i<npackages; i++) \
     if ((package[i].action == ACTION_NEW \
-   || package[i].action == ACTION_UPGRADE) \
+   || package[i].action == ACTION_UPGRADE \
+   || package[i].action == ACTION_REDO \
+   || package[i].action == ACTION_SRC_ONLY ) \
   && pi.install)
 
 #ifdef __cplusplus
Index: install.cc
===================================================================
RCS file: /cvs/src/src/winsup/cinstall/install.cc,v
retrieving revision 2.12
diff -u -p -r2.12 install.cc
--- install.cc 2001/04/19 00:40:39 2.12
+++ install.cc 2001/05/03 15:53:14
@@ -248,7 +248,7 @@ uninstall_one (char *name, int action)
     {
       SetWindowText (ins_pkgname, name);
       SetWindowText (ins_action, "Uninstalling...");
-      if (action == ACTION_UPGRADE)
+      if (action == ACTION_UPGRADE || action == ACTION_REDO)
   log (0, "Uninstalling old %s", name);
       else
   log (0, "Uninstalling %s", name);
@@ -319,6 +319,9 @@ install_one (char *name, char *file, int
     case ACTION_UPGRADE:
       SetWindowText (ins_action, "Upgrading...");
       break;
+    case ACTION_REDO:
+      SetWindowText (ins_action, "ReInstalling...");
+      break;
     }
 
   log (0, "Installing %s", local);
@@ -395,7 +398,8 @@ do_install (HINSTANCE h)
 
   LOOP_PACKAGES
     {
-      total_bytes += pi.install_size;
+      if (package[i].action != ACTION_SRC_ONLY)
+  total_bytes += pi.install_size;
       if (package[i].srcaction == SRCACTION_YES)
         total_bytes += pi.source_size;
     }
@@ -403,17 +407,22 @@ do_install (HINSTANCE h)
   for (i=0; i<npackages; i++)
     {
       if (package[i].action == ACTION_UNINSTALL
-    || (package[i].action == ACTION_UPGRADE && pi.install))
+    || ((package[i].action == ACTION_UPGRADE 
+    || package[i].action == ACTION_REDO) && pi.install))
   {
     uninstall_one (package[i].name, package[i].action);
     uninstall_one (concat (package[i].name, "-src", 0), 
package[i].action);
   }
 
       if ((package[i].action == ACTION_NEW
-     || package[i].action == ACTION_UPGRADE)
+     || package[i].action == ACTION_UPGRADE 
+     || package[i].action == ACTION_REDO
+     || package[i].action == ACTION_SRC_ONLY)
     && pi.install)
   {
-    int e = install_one (package[i].name, pi.install, pi.install_size, 
package[i].action, FALSE);
+    int e = 0;
+    if (package[i].action != ACTION_SRC_ONLY)
+      e += install_one (package[i].name, pi.install, pi.install_size, 
package[i].action, FALSE);
     if (package[i].srcaction == SRCACTION_YES && pi.source)
       e += install_one (concat (package[i].name, "-src", 0), pi.source, 
pi.source_size,
                 package[i].action, TRUE);
@@ -460,6 +469,8 @@ do_install (HINSTANCE h)
         case ACTION_NEW:
         case ACTION_UPGRADE:
         case ACTION_UNINSTALL:
+        case ACTION_REDO:
+        case ACTION_SRC_ONLY:
           printit = 0;
           break;
         }
Index: res.rc
===================================================================
RCS file: /cvs/src/src/winsup/cinstall/res.rc,v
retrieving revision 2.15
diff -u -p -r2.15 res.rc
--- res.rc 2001/04/25 03:44:08 2.15
+++ res.rc 2001/05/03 15:53:14
@@ -232,19 +232,16 @@ CAPTION "Cygwin Setup"
 FONT 8, "MS Sans Serif"
 BEGIN
     ICON            IDI_CYGWIN,IDC_STATIC,5,5,20,20
-    LTEXT           "Select packages to install",IDC_STATIC,55,5,85,8
+    LTEXT           "Select packages to install 
",IDC_CHOOSE_INST_TEXT,55,5,99,8
     CONTROL         "",IDC_LISTVIEW_POS,"Static",SS_BLACKFRAME | NOT 
                     WS_VISIBLE,55,15,230,155
     CONTROL         "SPIN",IDC_STATIC,"Static",SS_BITMAP,55,170,15,13
     LTEXT           "= click to choose action, (p) = previous version, 
(x) = experimental",
                     IDC_STATIC,65,170,220,8
     PUSHBUTTON      "Full/Part",IDC_CHOOSE_FULLPART,250,5,35,10
-    CONTROL         "Exp",IDC_CHOOSE_EXP,"Button",BS_AUTORADIOBUTTON | 
-                    WS_GROUP,215,5,25,10
-    CONTROL         
"Curr",IDC_CHOOSE_CURR,"Button",BS_AUTORADIOBUTTON,189,5,
-                    25,10
-    CONTROL         
"Prev",IDC_CHOOSE_PREV,"Button",BS_AUTORADIOBUTTON,161,5,
-                    27,10
+    CONTROL         "E&xp",IDC_CHOOSE_EXP,"Button",BS_AUTORADIOBUTTON | 
WS_GROUP,215,5,25,10
+    CONTROL         
"&Curr",IDC_CHOOSE_CURR,"Button",BS_AUTORADIOBUTTON,189,5,25,10
+    CONTROL         
"&Prev",IDC_CHOOSE_PREV,"Button",BS_AUTORADIOBUTTON,161,5,27,10
     DEFPUSHBUTTON   "&Next -->",IDOK,175,185,45,15
     PUSHBUTTON      "Cancel",IDCANCEL,240,185,45,15
     PUSHBUTTON      "<-- &Back",IDC_BACK,130,185,45,15
Index: resource.h
===================================================================
RCS file: /cvs/src/src/winsup/cinstall/resource.h,v
retrieving revision 2.9
diff -u -p -r2.9 resource.h
--- resource.h 2001/02/27 12:27:58 2.9
+++ resource.h 2001/05/03 15:53:14
@@ -98,6 +98,7 @@
 #define IDC_DLS_PROGRESS_TEXT           1047
 #define IDC_DLS_PPROGRESS_TEXT          1048
 #define IDC_DLS_IPROGRESS_TEXT          1049
+#define IDC_CHOOSE_INST_TEXT      1050
 #define IDC_STATIC                      -1
 
 // Next default values for new objects
@@ -108,7 +109,7 @@
 #define _APS_3D_CONTROLS                     1
 #define _APS_NEXT_RESOURCE_VALUE        126
 #define _APS_NEXT_COMMAND_VALUE         40003
-#define _APS_NEXT_CONTROL_VALUE         1050
+#define _APS_NEXT_CONTROL_VALUE         1051
 #define _APS_NEXT_SYMED_VALUE           101
 #endif
 #endif


