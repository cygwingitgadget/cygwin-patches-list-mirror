From: Earnie Boyd <earnie_boyd@yahoo.com>
To: Cygwin Patches <cygwin-patches@cygwin.com>
Subject: Re: Fix up cinstall to build properly with the new _ANONYMOUS_* defines.
Date: Wed, 18 Apr 2001 17:09:00 -0000
Message-id: <3ADE2CC2.6F05BA2@yahoo.com>
References: <3ADE26E0.5A51BAF8@yahoo.com>
X-SW-Source: 2001-q2/msg00115.html

 
2001-04-18  Earnie Boyd  <earnie@users.sourceforge.net>

	* win32.h: Remove the definitions for _UNION_NAME and _STRUCT_NAME.
	Must now include <windows.h> and not the pieces.
	* choose.cc (create_listview): Clean up type mismatch problems.
	* dialog.h (NEXT(id)): Ditto.
	* geturl.cc (dialog): Ditto.
	* install.cc (dialog): Ditto.
	* splash.cc (load_dialog): Ditto.

Index: choose.cc
===================================================================
RCS file: /cvs/src/src/winsup/cinstall/choose.cc,v
retrieving revision 2.14
diff -u -p -r2.14 choose.cc
--- choose.cc	2001/04/18 20:11:58	2.14
+++ choose.cc	2001/04/18 23:38:15
@@ -571,7 +571,7 @@ create_listview (HWND dlg, RECT *r)
 		       r->left, r->top,
 		       r->right-r->left+1, r->bottom-r->top+1,
 		       dlg,
-		       MAKEINTRESOURCE(IDC_CHOOSE_LIST),
+		       (HMENU) MAKEINTRESOURCE(IDC_CHOOSE_LIST),
 		       hinstance,
 		       0);
   ShowWindow (lv, SW_SHOW);
Index: dialog.h
===================================================================
RCS file: /cvs/src/src/winsup/cinstall/dialog.h,v
retrieving revision 2.1
diff -u -p -r2.1 dialog.h
--- dialog.h	2000/09/07 03:09:30	2.1
+++ dialog.h	2001/04/18 23:38:15
@@ -44,7 +44,7 @@ D(do_splash);
 #undef D
 
 /* end this dialog and select the next.  Pass 0 to exit the program */
-#define NEXT(id) EndDialog(h, 0), next_dialog = id
+#define NEXT(id) EndDialog((HWND)h, 0), next_dialog = id
 
 /* Get the value of an EditText control.  Pass the previously stored
    value and it will free the memory if needed. */
Index: geturl.cc
===================================================================
RCS file: /cvs/src/src/winsup/cinstall/geturl.cc,v
retrieving revision 2.3
diff -u -p -r2.3 geturl.cc
--- geturl.cc	2001/02/27 12:27:58	2.3
+++ geturl.cc	2001/04/18 23:38:15
@@ -91,7 +91,7 @@ dialog (void *)
 {
   int rv = 0;
   MSG m;
-  HANDLE gw_dialog = CreateDialog (hinstance, MAKEINTRESOURCE (IDD_DLSTATUS),
+  HWND gw_dialog = CreateDialog (hinstance, MAKEINTRESOURCE (IDD_DLSTATUS),
 				   0, dialog_proc);
   ShowWindow (gw_dialog, SW_SHOWNORMAL);
   UpdateWindow (gw_dialog);
Index: install.cc
===================================================================
RCS file: /cvs/src/src/winsup/cinstall/install.cc,v
retrieving revision 2.11
diff -u -p -r2.11 install.cc
--- install.cc	2001/04/18 20:11:58	2.11
+++ install.cc	2001/04/18 23:38:15
@@ -99,7 +99,7 @@ dialog (void *)
 {
   int rv = 0;
   MSG m;
-  HANDLE ins_dialog = CreateDialog (hinstance, MAKEINTRESOURCE (IDD_INSTATUS),
+  HWND ins_dialog = CreateDialog (hinstance, MAKEINTRESOURCE (IDD_INSTATUS),
 				   0, dialog_proc);
   if (ins_dialog == 0)
     fatal ("create dialog");
Index: splash.cc
===================================================================
RCS file: /cvs/src/src/winsup/cinstall/splash.cc,v
retrieving revision 2.3
diff -u -p -r2.3 splash.cc
--- splash.cc	2000/11/17 22:45:09	2.3
+++ splash.cc	2001/04/18 23:38:15
@@ -29,7 +29,7 @@ static void
 load_dialog (HWND h)
 {
   char buffer[100];
-  HANDLE v = GetDlgItem (h, IDC_VERSION);
+  HWND v = GetDlgItem (h, IDC_VERSION);
   sprintf (buffer, "Setup.exe version %s",
 	   version[0] ? version : "[unknown]");
   SetWindowText (v, buffer);
Index: win32.h
===================================================================
RCS file: /cvs/src/src/winsup/cinstall/win32.h,v
retrieving revision 2.0
diff -u -p -r2.0 win32.h
--- win32.h	2000/08/08 01:00:30	2.0
+++ win32.h	2001/04/18 23:38:15
@@ -18,16 +18,12 @@
    so there's no point in parsing them all (even lean-n-mean).  Doing
    this cuts compile time in half. */
 
-#define _UNION_NAME(x)
-#define _STRUCT_NAME(x)
 #define NOCOMATTRIBUTE
 
 #include <stdarg.h>
-#include <windef.h>
-#include <basetyps.h>
-#include <winbase.h>
-#include <wingdi.h>
-#include <winuser.h>
-#include <wininet.h>
 
+#define WIN32_LEAN_AND_MEAN
+#include <windows.h>
+
+#include <wininet.h>
 #include <windowsx.h>
