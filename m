Return-Path: <cygwin-patches-return-1608-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 1212 invoked by alias); 19 Dec 2001 11:19:08 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1142 invoked from network); 19 Dec 2001 11:19:03 -0000
From: "Gary R. Van Sickle" <g.r.vansickle@worldnet.att.net>
To: <cygwin-patches@sourceware.cygnus.com>
Subject: [PATCH] Update - Setup.exe property sheet patch, properly diffed.
Date: Wed, 07 Nov 2001 07:02:00 -0000
Message-ID: <NCBBIHCHBLCMLBLOBONKOEPMCHAA.g.r.vansickle@worldnet.att.net>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_000E_01C1884B.B7340910"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
X-SW-Source: 2001-q4/txt/msg00140.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_000E_01C1884B.B7340910
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 177

Ok, this should do it.  Was way less manual work than I expected - that cvs is
*smart*.  Diff, New files, and ChangeLog entry attached.

--
Gary R. Van Sickle
Brewer.  Patriot.

------=_NextPart_000_000E_01C1884B.B7340910
Content-Type: application/octet-stream;
	name="setup-newfiles.tar.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="setup-newfiles.tar.bz2"
Content-length: 12843

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
SGDSlRQf5VBW+AAP3i7kinChIEjE8q4=

------=_NextPart_000_000E_01C1884B.B7340910
Content-Type: application/octet-stream;
	name="setup.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="setup.diff"
Content-length: 90417

? chooser.cc=0A=
? chooser.h=0A=
? cistring.cc=0A=
? cistring.h=0A=
? desktop.h=0A=
? localdir.h=0A=
? net.h=0A=
? proppage.cc=0A=
? proppage.h=0A=
? propsheet.cc=0A=
? propsheet.h=0A=
? res.aps=0A=
? source.h=0A=
? splash.h=0A=
? threebar.cc=0A=
? threebar.h=0A=
? window.cc=0A=
? window.h=0A=
Index: Makefile.in=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/Makefile.in,v=0A=
retrieving revision 2.38=0A=
diff -p -u -r2.38 Makefile.in=0A=
--- Makefile.in	2001/12/03 22:22:08	2.38=0A=
+++ Makefile.in	2001/12/19 10:59:47=0A=
@@ -65,7 +65,7 @@ libkernel32	:=3D $(w32api_lib)/libkernel32=0A=
 ALL_DEP_LDLIBS	:=3D $(ZLIB) $(BZ2LIB) $(w32api_lib)/libole32.a $(w32api_li=
b)/libwsock32.a \=0A=
 		$(w32api_lib)/libnetapi32.a $(w32api_lib)/libadvapi32.a \=0A=
 		$(w32api_lib)/libuuid.a $(libkernel32) $(w32api_lib)/libuser32.a \=0A=
-		$(libmingw32)=0A=
+		$(w32api_lib)/libcomctl32.a $(libmingw32)=0A=
=20=0A=
 ALL_LDLIBS	:=3D ${patsubst $(mingw_build)/lib%.a,-l%,\=0A=
 	      ${patsubst $(w32api_lib)/lib%.a,-l%,\=0A=
@@ -86,6 +86,8 @@ OBJS =3D \=0A=
 	autoload.o \=0A=
 	category.o \=0A=
 	choose.o \=0A=
+	chooser.o \=0A=
+	cistring.o \=0A=
 	compress.o \=0A=
 	compress_bz.o \=0A=
 	compress_gz.o \=0A=
@@ -128,6 +130,8 @@ OBJS =3D \=0A=
 	package_source.o \=0A=
 	package_version.o \=0A=
 	postinstall.o \=0A=
+	proppage.o \=0A=
+	propsheet.o \=0A=
 	res.o \=0A=
 	rfc1738.o \=0A=
 	root.o \=0A=
@@ -137,7 +141,9 @@ OBJS =3D \=0A=
 	source.o \=0A=
 	splash.o \=0A=
 	state.o \=0A=
+	threebar.o \=0A=
 	version.o \=0A=
+	window.o \=0A=
 	$E=0A=
=20=0A=
 .SUFFIXES:=0A=
Index: choose.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/choose.cc,v=0A=
retrieving revision 2.78=0A=
diff -p -u -r2.78 choose.cc=0A=
--- choose.cc	2001/12/03 22:22:08	2.78=0A=
+++ choose.cc	2001/12/19 10:59:50=0A=
@@ -1132,6 +1132,7 @@ create_listview (HWND dlg, RECT * r)=0A=
 		       (HMENU) MAKEINTRESOURCE (IDC_CHOOSE_LIST),=0A=
 		       hinstance, 0);=0A=
   ShowWindow (lv, SW_SHOW);=0A=
+=0A=
   HDC dc =3D GetDC (lv);=0A=
   sysfont =3D GetStockObject (DEFAULT_GUI_FONT);=0A=
   SelectObject (dc, sysfont);=0A=
@@ -1256,6 +1257,7 @@ dialog_proc (HWND h, UINT message, WPARA=0A=
       r.top +=3D 2;=0A=
       r.bottom -=3D 2;=0A=
       create_listview (h, &r);=0A=
+=0A=
 #if 0=0A=
       load_dialog (h);=0A=
 #endif=0A=
@@ -1360,7 +1362,7 @@ scan_downloaded_files ()=0A=
 }=0A=
=20=0A=
 void=0A=
-do_choose (HINSTANCE h)=0A=
+do_choose (HINSTANCE h, HWND owner)=0A=
 {=0A=
   int rv;=0A=
=20=0A=
@@ -1384,9 +1386,9 @@ do_choose (HINSTANCE h)=0A=
   set_existence ();=0A=
   fill_missing_category ();=0A=
=20=0A=
-  rv =3D DialogBox (h, MAKEINTRESOURCE (IDD_CHOOSE), 0, dialog_proc);=0A=
+  rv =3D DialogBox (h, MAKEINTRESOURCE (IDD_CHOOSE), owner, dialog_proc);=
=0A=
   if (rv =3D=3D -1)=0A=
-    fatal (IDS_DIALOG_FAILED);=0A=
+    fatal (owner, IDS_DIALOG_FAILED);=0A=
=20=0A=
   log (LOG_BABBLE, "Chooser results...");=0A=
   packagedb db;=0A=
@@ -1471,3 +1473,4 @@ do_choose (HINSTANCE h)=0A=
 #endif=0A=
     }=0A=
 }=0A=
+=0A=
Index: desktop.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/desktop.cc,v=0A=
retrieving revision 2.18=0A=
diff -p -u -r2.18 desktop.cc=0A=
--- desktop.cc	2001/11/29 09:52:32	2.18=0A=
+++ desktop.cc	2001/12/19 10:59:51=0A=
@@ -48,6 +48,8 @@ static const char *cvsid =3D=0A=
 #include "package_meta.h"=0A=
 #include "package_version.h"=0A=
=20=0A=
+#include "desktop.h"=0A=
+=0A=
 static OSVERSIONINFO verinfo;=0A=
=20=0A=
 /* Lines starting with '@' are conditionals - include 'N' for NT,=0A=
@@ -444,56 +446,44 @@ dialog_cmd (HWND h, int id, HWND hwndctl=0A=
       save_dialog (h);=0A=
       check_if_enable_next (h);=0A=
       break;=0A=
-=0A=
-    case IDOK:=0A=
-      save_dialog (h);=0A=
-      do_desktop_setup ();=0A=
-      NEXT (IDD_S_POSTINSTALL);=0A=
-      break;=0A=
-=0A=
-    case IDC_BACK:=0A=
-      save_dialog (h);=0A=
-      NEXT (IDD_CHOOSE);=0A=
-      break;=0A=
-=0A=
-    case IDCANCEL:=0A=
-      NEXT (0);=0A=
-      break;=0A=
     }=0A=
   return 0;=0A=
 }=0A=
=20=0A=
-static BOOL CALLBACK=0A=
-dialog_proc (HWND h, UINT message, WPARAM wParam, LPARAM lParam)=0A=
+bool DesktopSetupPage::Create()=0A=
 {=0A=
-  switch (message)=0A=
-    {=0A=
-    case WM_INITDIALOG:=0A=
-      load_dialog (h);=0A=
-      return FALSE;=0A=
-    case WM_COMMAND:=0A=
-      return HANDLE_WM_COMMAND (h, wParam, lParam, dialog_cmd);=0A=
-    }=0A=
-  return FALSE;=0A=
+	return PropertyPage::Create(NULL, dialog_cmd, IDD_DESKTOP);=0A=
 }=0A=
=20=0A=
-void=0A=
-do_desktop (HINSTANCE h)=0A=
+void DesktopSetupPage::OnInit()=0A=
 {=0A=
-  CoInitialize (NULL);=0A=
-=0A=
-  verinfo.dwOSVersionInfoSize =3D sizeof (verinfo);=0A=
-  GetVersionEx (&verinfo);=0A=
+	// FIXME: This CoInitialize() feels like it could be moved to startup in =
main.cc.=0A=
+	CoInitialize (NULL);=0A=
+	verinfo.dwOSVersionInfoSize =3D sizeof (verinfo);=0A=
+	GetVersionEx (&verinfo);=0A=
+	root_desktop =3D=0A=
+		check_desktop ("Cygwin", backslash (cygpath ("/cygwin.bat", 0)));=0A=
+	root_menu =3D=0A=
+		check_startmenu ("Cygwin Bash Shell",=0A=
+			 backslash (cygpath ("/cygwin.bat", 0)));=0A=
+	load_dialog (GetHWND());=0A=
+}=0A=
=20=0A=
-  root_desktop =3D=0A=
-    check_desktop ("Cygwin", backslash (cygpath ("/cygwin.bat", 0)));=0A=
-  root_menu =3D=0A=
-    check_startmenu ("Cygwin Bash Shell",=0A=
-		     backslash (cygpath ("/cygwin.bat", 0)));=0A=
+long DesktopSetupPage::OnBack()=0A=
+{=0A=
+	HWND h =3D GetHWND();=0A=
+    save_dialog (h);=0A=
+    NEXT (IDD_CHOOSE);=0A=
+	return IDD_CHOOSER;=0A=
+}=0A=
=20=0A=
-  int rv =3D 0;=0A=
+bool DesktopSetupPage::OnFinish()=0A=
+{=0A=
+	HWND h =3D GetHWND();=0A=
+	save_dialog (h);=0A=
+	do_desktop_setup ();=0A=
+	NEXT (IDD_S_POSTINSTALL);=0A=
+	do_postinstall(GetInstance(), h);=0A=
=20=0A=
-  rv =3D DialogBox (h, MAKEINTRESOURCE (IDD_DESKTOP), 0, dialog_proc);=0A=
-  if (rv =3D=3D -1)=0A=
-    fatal (IDS_DIALOG_FAILED);=0A=
+	return true;=0A=
 }=0A=
Index: dialog.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/dialog.h,v=0A=
retrieving revision 2.4=0A=
diff -p -u -r2.4 dialog.h=0A=
--- dialog.h	2001/11/13 01:49:31	2.4=0A=
+++ dialog.h	2001/12/19 10:59:52=0A=
@@ -22,7 +22,7 @@ extern int next_dialog;=0A=
 /* either "nothing to do" or "setup complete" or something like that */=0A=
 extern int exit_msg;=0A=
=20=0A=
-#define D(x) void x(HINSTANCE _h)=0A=
+#define D(x) void x(HINSTANCE _h, HWND owner)=0A=
=20=0A=
 /* prototypes for all the do_* functions (most called by main.cc) */=0A=
=20=0A=
Index: download.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/download.cc,v=0A=
retrieving revision 2.17=0A=
diff -p -u -r2.17 download.cc=0A=
--- download.cc	2001/12/02 03:25:11	2.17=0A=
+++ download.cc	2001/12/19 10:59:52=0A=
@@ -25,6 +25,7 @@ static const char *cvsid =3D=0A=
=20=0A=
 #include <stdio.h>=0A=
 #include <unistd.h>=0A=
+#include <process.h>=0A=
=20=0A=
 #include "resource.h"=0A=
 #include "msg.h"=0A=
@@ -47,6 +48,9 @@ static const char *cvsid =3D=0A=
=20=0A=
 #include "rfc1738.h"=0A=
=20=0A=
+#include "threebar.h"=0A=
+extern ThreeBarProgressPage Progress;=0A=
+=0A=
 /* 0 on failure=0A=
  */=0A=
 static int=0A=
@@ -95,7 +99,7 @@ check_for_cached (packagesource & pkgsou=0A=
=20=0A=
 /* download a file from a mirror site to the local cache. */=0A=
 static int=0A=
-download_one (packagesource & pkgsource)=0A=
+download_one (packagesource & pkgsource, HWND owner)=0A=
 {=0A=
   if (check_for_cached (pkgsource) && source !=3D IDC_SOURCE_DOWNLOAD)=0A=
     return 0;=0A=
@@ -113,7 +117,7 @@ download_one (packagesource & pkgsource)=0A=
       if (get_url_to_file=0A=
 	  (concat=0A=
 	   (pkgsource.sites[n]->key, "/", pkgsource.Canonical (), 0),=0A=
-	   concat (local, ".tmp", 0), pkgsource.size))=0A=
+	   concat (local, ".tmp", 0), pkgsource.size, owner))=0A=
 	{=0A=
 	  /* FIXME: note new source ? */=0A=
 	  continue;=0A=
@@ -146,8 +150,8 @@ download_one (packagesource & pkgsource)=0A=
   return 1;=0A=
 }=0A=
=20=0A=
-void=0A=
-do_download (HINSTANCE h)=0A=
+static void=0A=
+do_download_thread (HINSTANCE h, HWND owner)=0A=
 {=0A=
   int errors =3D 0;=0A=
   total_download_bytes =3D 0;=0A=
@@ -162,11 +166,11 @@ do_download (HINSTANCE h)=0A=
 	packageversion *version =3D pkg->desired;=0A=
 	if (!=0A=
 	    (check_for_cached (version->bin)=0A=
-	     && source !=3D IDC_SOURCE_DOWNLOAD))=0A=
+	     && source !=3D IDC_SOURCE_DOWNLOAD) && pkg->desired->binpicked)=0A=
 	  total_download_bytes +=3D version->bin.size;=0A=
 	if (!=0A=
 	    (check_for_cached (version->src)=0A=
-	     && source !=3D IDC_SOURCE_DOWNLOAD))=0A=
+	     && source !=3D IDC_SOURCE_DOWNLOAD) && pkg->desired->srcpicked)=0A=
 	  total_download_bytes +=3D version->src.size;=0A=
       }=0A=
=20=0A=
@@ -180,9 +184,9 @@ do_download (HINSTANCE h)=0A=
 	int e =3D 0;=0A=
 	packageversion *version =3D pkg->desired;=0A=
 	if (version->binpicked)=0A=
-	  e +=3D download_one (version->bin);=0A=
+	  e +=3D download_one (version->bin, owner);=0A=
 	if (version->srcpicked)=0A=
-	  e +=3D download_one (version->src);=0A=
+	  e +=3D download_one (version->src, owner);=0A=
 	errors +=3D e;=0A=
 #if 0=0A=
 	if (e)=0A=
@@ -190,11 +194,9 @@ do_download (HINSTANCE h)=0A=
 #endif=0A=
       }=0A=
=20=0A=
-  dismiss_url_status_dialog ();=0A=
-=0A=
   if (errors)=0A=
     {=0A=
-      if (yesno (IDS_DOWNLOAD_INCOMPLETE) =3D=3D IDYES)=0A=
+      if (yesno (owner, IDS_DOWNLOAD_INCOMPLETE) =3D=3D IDYES)=0A=
 	{=0A=
 	  next_dialog =3D IDD_SITE;=0A=
 	  return;=0A=
@@ -211,4 +213,29 @@ do_download (HINSTANCE h)=0A=
     }=0A=
   else=0A=
     next_dialog =3D IDD_S_INSTALL;=0A=
+}=0A=
+=0A=
+static void=0A=
+do_download_reflector(void* p)=0A=
+{=0A=
+	HANDLE *context;=0A=
+	context =3D (HANDLE*)p;=0A=
+=0A=
+	do_download_thread((HINSTANCE)context[0], (HWND)context[1]);=0A=
+=0A=
+	// Tell the progress page that we're done downloading=0A=
+	Progress.PostMessage(WM_APP_DOWNLOAD_THREAD_COMPLETE, 0, next_dialog);=0A=
+=0A=
+	_endthread();=0A=
+}=0A=
+=0A=
+static HANDLE context[2];=0A=
+=0A=
+void=0A=
+do_download (HINSTANCE h, HWND owner)=0A=
+{=0A=
+	context[0] =3D h;=0A=
+	context[1] =3D owner;=0A=
+=0A=
+	_beginthread(do_download_reflector, 0, context);=0A=
 }=0A=
Index: fromcwd.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/fromcwd.cc,v=0A=
retrieving revision 2.15=0A=
diff -p -u -r2.15 fromcwd.cc=0A=
--- fromcwd.cc	2001/12/03 22:22:09	2.15=0A=
+++ fromcwd.cc	2001/12/19 10:59:52=0A=
@@ -118,7 +118,7 @@ check_ini (char *path, unsigned int fsiz=0A=
 }=0A=
=20=0A=
 void=0A=
-do_fromcwd (HINSTANCE h)=0A=
+do_fromcwd (HINSTANCE h, HWND owner)=0A=
 {=0A=
   found_ini =3D true;=0A=
   find (".", check_ini);=0A=
Index: geturl.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/geturl.cc,v=0A=
retrieving revision 2.15=0A=
diff -p -u -r2.15 geturl.cc=0A=
--- geturl.cc	2001/12/02 03:25:11	2.15=0A=
+++ geturl.cc	2001/12/19 10:59:53=0A=
@@ -43,119 +43,33 @@ static const char *cvsid =3D=0A=
 #include "diskfull.h"=0A=
 #include "mount.h"=0A=
=20=0A=
-static HWND gw_dialog =3D 0;=0A=
-static HWND gw_url =3D 0;=0A=
-static HWND gw_rate =3D 0;=0A=
-static HWND gw_progress =3D 0;=0A=
-static HWND gw_pprogress =3D 0;=0A=
-static HWND gw_iprogress =3D 0;=0A=
-static HWND gw_progress_text =3D 0;=0A=
-static HWND gw_pprogress_text =3D 0;=0A=
-static HWND gw_iprogress_text =3D 0;=0A=
-static HANDLE init_event;=0A=
+#include "threebar.h"=0A=
+extern ThreeBarProgressPage Progress;=0A=
+=0A=
 static int max_bytes =3D 0;=0A=
 static int is_local_install =3D 0;=0A=
=20=0A=
 int total_download_bytes =3D 0;=0A=
 int total_download_bytes_sofar =3D 0;=0A=
=20=0A=
-static BOOL=0A=
-dialog_cmd (HWND h, int id, HWND hwndctl, UINT code)=0A=
-{=0A=
-  switch (id)=0A=
-    {=0A=
-    case IDCANCEL:=0A=
-      exit_setup (0);=0A=
-    }=0A=
-  return 0;=0A=
-}=0A=
-=0A=
-static BOOL CALLBACK=0A=
-dialog_proc (HWND h, UINT message, WPARAM wParam, LPARAM lParam)=0A=
-{=0A=
-  switch (message)=0A=
-    {=0A=
-    case WM_INITDIALOG:=0A=
-      gw_dialog =3D h;=0A=
-      gw_url =3D GetDlgItem (h, IDC_DLS_URL);=0A=
-      gw_rate =3D GetDlgItem (h, IDC_DLS_RATE);=0A=
-      gw_progress =3D GetDlgItem (h, IDC_DLS_PROGRESS);=0A=
-      gw_pprogress =3D GetDlgItem (h, IDC_DLS_PPROGRESS);=0A=
-      gw_iprogress =3D GetDlgItem (h, IDC_DLS_IPROGRESS);=0A=
-      gw_progress_text =3D GetDlgItem (h, IDC_DLS_PROGRESS_TEXT);=0A=
-      gw_pprogress_text =3D GetDlgItem (h, IDC_DLS_PPROGRESS_TEXT);=0A=
-      gw_iprogress_text =3D GetDlgItem (h, IDC_DLS_IPROGRESS_TEXT);=0A=
-      SetEvent (init_event);=0A=
-      return TRUE;=0A=
-    case WM_COMMAND:=0A=
-      return HANDLE_WM_COMMAND (h, wParam, lParam, dialog_cmd);=0A=
-    }=0A=
-  return FALSE;=0A=
-}=0A=
-=0A=
-static WINAPI DWORD=0A=
-dialog (void *)=0A=
-{=0A=
-  MSG m;=0A=
-  HWND local_gw_dialog =3D=0A=
-    CreateDialog (hinstance, MAKEINTRESOURCE (IDD_DLSTATUS),=0A=
-		  0, dialog_proc);=0A=
-  ShowWindow (local_gw_dialog, SW_SHOWNORMAL);=0A=
-  UpdateWindow (local_gw_dialog);=0A=
-  while (GetMessage (&m, 0, 0, 0) > 0)=0A=
-    {=0A=
-      TranslateMessage (&m);=0A=
-      DispatchMessage (&m);=0A=
-    }=0A=
-  return 0;=0A=
-}=0A=
-=0A=
 static DWORD start_tics;=0A=
=20=0A=
 static void=0A=
-init_dialog (char const *url, int length)=0A=
+init_dialog (char const *url, int length, HWND owner)=0A=
 {=0A=
   if (is_local_install)=0A=
     return;=0A=
-  if (gw_dialog =3D=3D 0)=0A=
-    {=0A=
-      DWORD tid;=0A=
-      HANDLE thread;=0A=
-      init_event =3D CreateEvent (0, 0, 0, 0);=0A=
-      thread =3D CreateThread (0, 0, dialog, 0, 0, &tid);=0A=
-      WaitForSingleObject (init_event, 1000);=0A=
-      CloseHandle (init_event);=0A=
-      SendMessage (gw_progress, PBM_SETRANGE, 0, MAKELPARAM (0, 100));=0A=
-      SendMessage (gw_pprogress, PBM_SETRANGE, 0, MAKELPARAM (0, 100));=0A=
-      SendMessage (gw_iprogress, PBM_SETRANGE, 0, MAKELPARAM (0, 100));=0A=
-    }=0A=
+=0A=
   char const *sl =3D url;=0A=
   char const *cp;=0A=
   for (cp =3D url; *cp; cp++)=0A=
     if (*cp =3D=3D '/' || *cp =3D=3D '\\' || *cp =3D=3D ':')=0A=
       sl =3D cp + 1;=0A=
   max_bytes =3D length;=0A=
-  SetWindowText (gw_url, sl);=0A=
-  SetWindowText (gw_rate, "Connecting...");=0A=
-  SendMessage (gw_progress, PBM_SETPOS, (WPARAM) 0, 0);=0A=
-  ShowWindow (gw_progress, (length > 0) ? SW_SHOW : SW_HIDE);=0A=
-  if (length > 0)=0A=
-    SetWindowText (gw_progress_text, "Package");=0A=
-  else=0A=
-    SetWindowText (gw_progress_text, "       ");=0A=
-  ShowWindow (gw_pprogress, (total_download_bytes > 0) ? SW_SHOW : SW_HIDE=
);=0A=
-  if (total_download_bytes > 0)=0A=
-    {=0A=
-      SetWindowText (gw_pprogress_text, "Total");=0A=
-      SetWindowText (gw_iprogress_text, "Disk");=0A=
-    }=0A=
-  else=0A=
-    {=0A=
-      SetWindowText (gw_pprogress_text, "     ");=0A=
-      SetWindowText (gw_iprogress_text, "    ");=0A=
-    }=0A=
-  ShowWindow (gw_iprogress, (total_download_bytes > 0) ? SW_SHOW : SW_HIDE=
);=0A=
-  ShowWindow (gw_dialog, SW_SHOWNORMAL);=0A=
+  Progress.SetText1("Downloading...");=0A=
+  Progress.SetText2(sl);=0A=
+  Progress.SetText3("Connecting...");=0A=
+  Progress.SetBar1(0);=0A=
   start_tics =3D GetTickCount ();=0A=
 }=0A=
=20=0A=
@@ -166,7 +80,7 @@ progress (int bytes)=0A=
   if (is_local_install)=0A=
     return;=0A=
   static char buf[100];=0A=
-  int kbps;=0A=
+  double kbps;=0A=
   static unsigned int last_tics =3D 0;=0A=
   DWORD tics =3D GetTickCount ();=0A=
   if (tics =3D=3D start_tics)	// to prevent division by zero=0A=
@@ -175,36 +89,30 @@ progress (int bytes)=0A=
     return;=0A=
   last_tics =3D tics;=0A=
=20=0A=
-  kbps =3D bytes / (tics - start_tics);=0A=
-  ShowWindow (gw_progress, (max_bytes > 0) ? SW_SHOW : SW_HIDE);=0A=
-  ShowWindow (gw_pprogress, (total_download_bytes > 0) ? SW_SHOW : SW_HIDE=
);=0A=
-  ShowWindow (gw_iprogress, (total_download_bytes > 0) ? SW_SHOW : SW_HIDE=
);=0A=
-  if (max_bytes > 100)=0A=
-    {=0A=
-      int perc =3D bytes / (max_bytes / 100);=0A=
-      SendMessage (gw_progress, PBM_SETPOS, (WPARAM) perc, 0);=0A=
-      sprintf (buf, "%3d %%  (%dk/%dk)  %d kb/s\n",=0A=
+  kbps =3D ((double)bytes) / (double)(tics - start_tics);=0A=
+  if (max_bytes > 0)=0A=
+    {=0A=
+      int perc =3D (int)(100.0 * ((double)bytes) / (double)max_bytes);=0A=
+      Progress.SetBar1(bytes, max_bytes);=0A=
+      sprintf (buf, "%3d %%  (%dk/%dk)  %2.1f kb/s\n",=0A=
 	       perc, bytes / 1000, max_bytes / 1000, kbps);=0A=
       if (total_download_bytes > 0)=0A=
 	{=0A=
-	  int totalperc =3D=0A=
-	    (total_download_bytes_sofar +=0A=
-	     bytes) / (total_download_bytes / 100);=0A=
-	  SendMessage (gw_pprogress, PBM_SETPOS, (WPARAM) totalperc, 0);=0A=
+      Progress.SetBar2(total_download_bytes_sofar + bytes, total_download_=
bytes);=0A=
 	}=0A=
     }=0A=
   else=0A=
-    sprintf (buf, "%d  %d kb/s\n", bytes, kbps);=0A=
+    sprintf (buf, "%d  %2.1f kb/s\n", bytes, kbps);=0A=
=20=0A=
-  SetWindowText (gw_rate, buf);=0A=
+  Progress.SetText3(buf);=0A=
 }=0A=
=20=0A=
 io_stream *=0A=
-get_url_to_membuf (char const *_url)=0A=
+get_url_to_membuf (char const *_url, HWND owner)=0A=
 {=0A=
-  log (LOG_BABBLE, "get_url_to_membuf %s", _url);=0A=
+	log (LOG_BABBLE, "get_url_to_membuf %s", _url);=0A=
   is_local_install =3D (source =3D=3D IDC_SOURCE_CWD);=0A=
-  init_dialog (_url, 0);=0A=
+  init_dialog (_url, 0, owner);=0A=
   NetIO *n =3D NetIO::open (_url);=0A=
   if (!n || !n->ok ())=0A=
     {=0A=
@@ -254,9 +162,9 @@ get_url_to_membuf (char const *_url)=0A=
 }=0A=
=20=0A=
 char *=0A=
-get_url_to_string (char const *_url)=0A=
+get_url_to_string (char const *_url, HWND owner)=0A=
 {=0A=
-  io_stream *stream =3D get_url_to_membuf (_url);=0A=
+  io_stream *stream =3D get_url_to_membuf (_url, owner);=0A=
   if (!stream)=0A=
     return 0;=0A=
   size_t bytes =3D stream->get_size ();=0A=
@@ -283,15 +191,15 @@ get_url_to_string (char const *_url)=0A=
=20=0A=
 int=0A=
 get_url_to_file (char *_url, char *_filename, int expected_length,=0A=
-		 BOOL allow_ftp_auth)=0A=
+		 HWND owner, BOOL allow_ftp_auth)=0A=
 {=0A=
   log (LOG_BABBLE, "get_url_to_file %s %s", _url, _filename);=0A=
   if (total_download_bytes > 0)=0A=
     {=0A=
       int df =3D diskfull (get_root_dir ());=0A=
-      SendMessage (gw_iprogress, PBM_SETPOS, (WPARAM) df, 0);=0A=
+	  Progress.SetBar3(df);=0A=
     }=0A=
-  init_dialog (_url, expected_length);=0A=
+  init_dialog (_url, expected_length, owner);=0A=
=20=0A=
   remove (_filename);		/* but ignore errors */=0A=
=20=0A=
@@ -309,7 +217,7 @@ get_url_to_file (char *_url, char *_file=0A=
       const char *err =3D strerror (errno);=0A=
       if (!err)=0A=
 	err =3D "(unknown error)";=0A=
-      fatal (IDS_ERR_OPEN_WRITE, _filename, err);=0A=
+      fatal (owner, IDS_ERR_OPEN_WRITE, _filename, err);=0A=
     }=0A=
=20=0A=
   if (n->file_size)=0A=
@@ -338,15 +246,16 @@ get_url_to_file (char *_url, char *_file=0A=
   if (total_download_bytes > 0)=0A=
     {=0A=
       int df =3D diskfull (get_root_dir ());=0A=
-      SendMessage (gw_iprogress, PBM_SETPOS, (WPARAM) df, 0);=0A=
+	  Progress.SetBar3(df);=0A=
     }=0A=
=20=0A=
   return 0;=0A=
 }=0A=
=20=0A=
+// FIXME: I think this can go now, I don't think anything calls it.=0A=
 void=0A=
 dismiss_url_status_dialog ()=0A=
 {=0A=
-  if (!is_local_install)=0A=
-    ShowWindow (gw_dialog, SW_HIDE);=0A=
+  //if (!is_local_install)=0A=
+    //ShowWindow (gw_dialog, SW_HIDE);=0A=
 }=0A=
Index: geturl.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/geturl.h,v=0A=
retrieving revision 2.4=0A=
diff -p -u -r2.4 geturl.h=0A=
--- geturl.h	2001/12/02 03:25:11	2.4=0A=
+++ geturl.h	2001/12/19 10:59:53=0A=
@@ -21,8 +21,8 @@ extern int total_download_bytes_sofar;=0A=
=20=0A=
 class io_stream;=0A=
=20=0A=
-io_stream *get_url_to_membuf (char const *);=0A=
-char *get_url_to_string (char const *);=0A=
+io_stream *get_url_to_membuf (char const *, HWND owner);=0A=
+char *get_url_to_string (char const *, HWND owner);=0A=
 int get_url_to_file (char *_url, char *_filename, int expected_size,=0A=
-		     BOOL allow_ftp_auth =3D FALSE);=0A=
+		     HWND owner, BOOL allow_ftp_auth =3D FALSE);=0A=
 void dismiss_url_status_dialog ();=0A=
Index: ini.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/ini.cc,v=0A=
retrieving revision 2.15=0A=
diff -p -u -r2.15 ini.cc=0A=
--- ini.cc	2001/12/03 22:22:09	2.15=0A=
+++ ini.cc	2001/12/19 10:59:53=0A=
@@ -28,6 +28,7 @@ static const char *cvsid =3D=0A=
 #include <stdio.h>=0A=
 #include <stdlib.h>=0A=
 #include <stdarg.h>=0A=
+#include <process.h>=0A=
=20=0A=
 #include "ini.h"=0A=
 #include "resource.h"=0A=
@@ -45,6 +46,9 @@ static const char *cvsid =3D=0A=
=20=0A=
 #include "io_stream.h"=0A=
=20=0A=
+#include "threebar.h"=0A=
+extern ThreeBarProgressPage Progress;=0A=
+=0A=
 unsigned int setup_timestamp =3D 0;=0A=
 char *setup_version =3D 0;=0A=
=20=0A=
@@ -64,7 +68,7 @@ find_routine (char *path, unsigned int f=0A=
   io_stream *ini_file =3D io_stream::open (concat ("file://", local_dir,"/=
", path, 0), "rb");=0A=
   if (!ini_file)=0A=
     {=0A=
-    note (IDS_SETUPINI_MISSING, path);=0A=
+    note (NULL, IDS_SETUPINI_MISSING, path);=0A=
     return;=0A=
     }=0A=
=20=0A=
@@ -83,7 +87,7 @@ find_routine (char *path, unsigned int f=0A=
 }=0A=
=20=0A=
 static int=0A=
-do_local_ini ()=0A=
+do_local_ini (HWND owner)=0A=
 {=0A=
   local_ini =3D 0;=0A=
   find (local_dir, find_routine);=0A=
@@ -91,18 +95,19 @@ do_local_ini ()=0A=
 }=0A=
=20=0A=
 static int=0A=
-do_remote_ini ()=0A=
+do_remote_ini (HWND owner)=0A=
 {=0A=
   size_t ini_count =3D 0;=0A=
+=20=20=0A=
   for (size_t n =3D 1; n <=3D site_list.number (); n++)=0A=
     {=0A=
       io_stream *ini_file =3D=0A=
-	get_url_to_membuf (concat (site_list[n]->url, "/setup.ini", 0));=0A=
+	get_url_to_membuf (concat (site_list[n]->url, "/setup.ini", 0), owner);=
=0A=
       dismiss_url_status_dialog ();=0A=
=20=0A=
       if (!ini_file)=0A=
 	{=0A=
-	  note (IDS_SETUPINI_MISSING, site_list[n]->url);=0A=
+	  note (owner, IDS_SETUPINI_MISSING, site_list[n]->url);=0A=
 	  continue;=0A=
 	}=0A=
=20=0A=
@@ -139,14 +144,14 @@ do_remote_ini ()=0A=
   return ini_count;=0A=
 }=0A=
=20=0A=
-void=0A=
-do_ini (HINSTANCE h)=0A=
+static void=0A=
+do_ini_thread (HINSTANCE h, HWND owner)=0A=
 {=0A=
   size_t ini_count =3D 0;=0A=
   if (source =3D=3D IDC_SOURCE_CWD)=0A=
-    ini_count =3D do_local_ini ();=0A=
+    ini_count =3D do_local_ini (owner);=0A=
   else=0A=
-    ini_count =3D do_remote_ini ();=0A=
+    ini_count =3D do_remote_ini (owner);=0A=
=20=0A=
   if (ini_count =3D=3D 0)=0A=
     {=0A=
@@ -171,7 +176,7 @@ do_ini (HINSTANCE h)=0A=
 	  if (old_timestamp && setup_timestamp=0A=
 	      && (old_timestamp > setup_timestamp))=0A=
 	    {=0A=
-	      int yn =3D yesno (IDS_OLD_SETUPINI);=0A=
+	      int yn =3D yesno (owner, IDS_OLD_SETUPINI);=0A=
 	      if (yn =3D=3D IDNO)=0A=
 		exit_setup (1);=0A=
 	    }=0A=
@@ -197,11 +202,37 @@ do_ini (HINSTANCE h)=0A=
       char *ini_version =3D canonicalize_version (setup_version);=0A=
       char *our_version =3D canonicalize_version (version);=0A=
       if (strcmp (our_version, ini_version) < 0)=0A=
-	note (IDS_OLD_SETUP_VERSION, version, setup_version);=0A=
+	note (owner, IDS_OLD_SETUP_VERSION, version, setup_version);=0A=
     }=0A=
=20=0A=
-  next_dialog =3D IDD_CHOOSE;=0A=
+  next_dialog =3D IDD_CHOOSER;=0A=
 }=0A=
+=0A=
+static void=0A=
+do_ini_thread_reflector(void* p)=0A=
+{=0A=
+	HANDLE *context;=0A=
+	context =3D (HANDLE*)p;=0A=
+=0A=
+	do_ini_thread((HINSTANCE)context[0], (HWND)context[1]);=0A=
+=0A=
+	// Tell the progress page that we're done downloading=0A=
+	Progress.PostMessage(WM_APP_SETUP_INI_DOWNLOAD_COMPLETE, 0, next_dialog);=
=0A=
+=0A=
+	_endthread();=0A=
+}=0A=
+=0A=
+static HANDLE context[2];=0A=
+=0A=
+void=0A=
+do_ini (HINSTANCE h, HWND owner)=0A=
+{=0A=
+	context[0] =3D h;=0A=
+	context[1] =3D owner;=0A=
+=0A=
+	_beginthread(do_ini_thread_reflector, 0, context);=0A=
+}=0A=
+=0A=
=20=0A=
 extern int yylineno;=0A=
=20=0A=
Index: iniparse.y=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/iniparse.y,v=0A=
retrieving revision 2.20=0A=
diff -p -u -r2.20 iniparse.y=0A=
--- iniparse.y	2001/12/02 03:25:11	2.20=0A=
+++ iniparse.y	2001/12/19 10:59:53=0A=
@@ -94,7 +94,7 @@ lines=0A=
 simple_line=0A=
  : VERSION STRING		{ cpv->set_canonical_version ($2);=20=0A=
    				  add_correct_version ();}=0A=
- | SDESC STRING			{ cpv->set_sdesc ($2); }=0A=
+ | SDESC STRING			{ cp->sdesc =3D $2; cpv->set_sdesc ($2); }=0A=
  | LDESC STRING			{ cpv->set_ldesc ($2); }=0A=
  | CATEGORY categories=0A=
  | REQUIRES requires=0A=
@@ -148,7 +148,7 @@ categories=0A=
 void=0A=
 add_correct_version()=0A=
 {=0A=
-    int merged =3D 0;=0A=
+	int merged =3D 0;=0A=
     for (size_t n =3D 1; !merged && n <=3D cp->versions.number (); n++)=0A=
       if (!strcasecmp(cp->versions[n]->Canonical_version(), cpv->Canonical=
_version()))=0A=
       {=0A=
Index: install.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/install.cc,v=0A=
retrieving revision 2.30=0A=
diff -p -u -r2.30 install.cc=0A=
--- install.cc	2001/11/29 09:52:33	2.30=0A=
+++ install.cc	2001/12/19 10:59:55=0A=
@@ -33,6 +33,8 @@ static const char *cvsid =3D=0A=
 #include <sys/types.h>=0A=
 #include <sys/stat.h>=0A=
 #include <errno.h>=0A=
+#include <process.h>=0A=
+=0A=
 #include "zlib/zlib.h"=0A=
=20=0A=
 #include "resource.h"=0A=
@@ -61,110 +63,32 @@ static const char *cvsid =3D=0A=
=20=0A=
 #include "port.h"=0A=
=20=0A=
-static HWND ins_dialog =3D 0;=0A=
-static HWND ins_action =3D 0;=0A=
-static HWND ins_pkgname =3D 0;=0A=
-static HWND ins_filename =3D 0;=0A=
-static HWND ins_pprogress =3D 0;=0A=
-static HWND ins_iprogress =3D 0;=0A=
-static HWND ins_diskfull =3D 0;=0A=
-static HANDLE init_event;=0A=
+#include "threebar.h"=0A=
+extern ThreeBarProgressPage Progress;=0A=
=20=0A=
 static int total_bytes =3D 0;=0A=
 static int total_bytes_sofar =3D 0;=0A=
 static int package_bytes =3D 0;=0A=
=20=0A=
-static bool=0A=
-dialog_cmd (HWND h, int id, HWND hwndctl, UINT code)=0A=
-{=0A=
-  switch (id)=0A=
-    {=0A=
-    case IDCANCEL:=0A=
-      exit_setup (1);=0A=
-    }=0A=
-  return 0;=0A=
-}=0A=
-=0A=
-static BOOL CALLBACK=0A=
-dialog_proc (HWND h, UINT message, WPARAM wParam, LPARAM lParam)=0A=
-{=0A=
-  switch (message)=0A=
-    {=0A=
-    case WM_INITDIALOG:=0A=
-      ins_dialog =3D h;=0A=
-      ins_action =3D GetDlgItem (h, IDC_INS_ACTION);=0A=
-      ins_pkgname =3D GetDlgItem (h, IDC_INS_PKG);=0A=
-      ins_filename =3D GetDlgItem (h, IDC_INS_FILE);=0A=
-      ins_pprogress =3D GetDlgItem (h, IDC_INS_PPROGRESS);=0A=
-      ins_iprogress =3D GetDlgItem (h, IDC_INS_IPROGRESS);=0A=
-      ins_diskfull =3D GetDlgItem (h, IDC_INS_DISKFULL);=0A=
-      SetEvent (init_event);=0A=
-      return TRUE;=0A=
-    case WM_COMMAND:=0A=
-      return HANDLE_WM_COMMAND (h, wParam, lParam, dialog_cmd);=0A=
-    }=0A=
-  return FALSE;=0A=
-}=0A=
-=0A=
-static WINAPI DWORD=0A=
-dialog (void *)=0A=
-{=0A=
-  int rv =3D 0;=0A=
-  MSG m;=0A=
-  HWND ins_dialog =3D CreateDialog (hinstance, MAKEINTRESOURCE (IDD_INSTAT=
US),=0A=
-				  0, dialog_proc);=0A=
-  if (ins_dialog =3D=3D 0)=0A=
-    fatal ("create dialog");=0A=
-  ShowWindow (ins_dialog, SW_SHOWNORMAL);=0A=
-  UpdateWindow (ins_dialog);=0A=
-  while (GetMessage (&m, 0, 0, 0) > 0)=0A=
-    {=0A=
-      TranslateMessage (&m);=0A=
-      DispatchMessage (&m);=0A=
-    }=0A=
-  return rv;=0A=
-}=0A=
-=0A=
 static void=0A=
 init_dialog ()=0A=
 {=0A=
-  if (ins_dialog =3D=3D 0)=0A=
-    {=0A=
-      DWORD tid;=0A=
-      HANDLE thread;=0A=
-      init_event =3D CreateEvent (0, 0, 0, 0);=0A=
-      thread =3D CreateThread (0, 0, dialog, 0, 0, &tid);=0A=
-      WaitForSingleObject (init_event, 10000);=0A=
-      CloseHandle (init_event);=0A=
-      SendMessage (ins_pprogress, PBM_SETRANGE, 0, MAKELPARAM (0, 100));=
=0A=
-      SendMessage (ins_iprogress, PBM_SETRANGE, 0, MAKELPARAM (0, 100));=
=0A=
-      SendMessage (ins_diskfull, PBM_SETRANGE, 0, MAKELPARAM (0, 100));=0A=
-    }=0A=
-=0A=
-  SetWindowText (ins_pkgname, "");=0A=
-  SetWindowText (ins_filename, "");=0A=
-  SendMessage (ins_pprogress, PBM_SETPOS, (WPARAM) 0, 0);=0A=
-  SendMessage (ins_iprogress, PBM_SETPOS, (WPARAM) 0, 0);=0A=
-  SendMessage (ins_diskfull, PBM_SETPOS, (WPARAM) 0, 0);=0A=
-  ShowWindow (ins_dialog, SW_SHOWNORMAL);=0A=
+  Progress.SetText2("");=0A=
+  Progress.SetText3("");=0A=
 }=0A=
=20=0A=
 static void=0A=
 progress (int bytes)=0A=
 {=0A=
-  int perc;=0A=
-=0A=
-  if (package_bytes > 100)=0A=
-    {=0A=
-      perc =3D bytes / (package_bytes / 100);=0A=
-      SendMessage (ins_pprogress, PBM_SETPOS, (WPARAM) perc, 0);=0A=
-    }=0A=
+  if(package_bytes > 0)=0A=
+  {=0A=
+	Progress.SetBar1(bytes, package_bytes);=0A=
+  }=0A=
=20=0A=
-  if (total_bytes > 100)=0A=
-    {=0A=
-      perc =3D (total_bytes_sofar + bytes) / (total_bytes / 100);=0A=
-      SendMessage (ins_iprogress, PBM_SETPOS, (WPARAM) perc, 0);=0A=
-    }=0A=
+  if(total_bytes > 0)=0A=
+  {=0A=
+    Progress.SetBar2(total_bytes_sofar + bytes, total_bytes);=0A=
+  }=0A=
 }=0A=
=20=0A=
 static const char *standard_dirs[] =3D {=0A=
@@ -194,9 +118,9 @@ uninstall_one (packagemeta * pkgm)=0A=
 {=0A=
   if (pkgm)=0A=
     {=0A=
-      SetWindowText (ins_pkgname, pkgm->name);=0A=
-      SetWindowText (ins_action, "Uninstalling...");=0A=
-      log (0, "Uninstalling %s", pkgm->name);=0A=
+	  Progress.SetText1("Uninstalling...");=0A=
+	  Progress.SetText2(pkgm->name);=0A=
+     log (0, "Uninstalling %s", pkgm->name);=0A=
       pkgm->uninstall ();=0A=
       num_uninstalls++;=0A=
     }=0A=
@@ -210,10 +134,10 @@ install_one_source (packagemeta & pkgm,=20=0A=
 		    char const *prefix, package_type_t type)=0A=
 {=0A=
   int errors =3D 0;=0A=
-  SetWindowText (ins_pkgname, source.Base ());=0A=
+  Progress.SetText2(source.Base ());=0A=
   if (!io_stream::exists (source.Cached ()))=0A=
     {=0A=
-      note (IDS_ERR_OPEN_READ, source.Cached (), "No such file");=0A=
+      note (NULL, IDS_ERR_OPEN_READ, source.Cached (), "No such file");=0A=
       return 1;=0A=
     }=0A=
   io_stream *lst =3D 0;=0A=
@@ -235,7 +159,7 @@ install_one_source (packagemeta & pkgm,=20=0A=
=20=0A=
   char msg[64];=0A=
   strcpy (msg, "Installing");=0A=
-  SetWindowText (ins_action, msg);=0A=
+  Progress.SetText1(msg);=0A=
   log (0, "%s%s", msg, source.Cached ());=0A=
   io_stream *tmp =3D io_stream::open (source.Cached (), "rb");=0A=
   archive *thefile =3D 0;=0A=
@@ -257,7 +181,7 @@ install_one_source (packagemeta & pkgm,=20=0A=
 	    lst->write (concat (fn, "\n", 0), strlen (fn) + 1);=0A=
=20=0A=
 	  /* FIXME: concat leaks memory */=0A=
-	  SetWindowText (ins_filename, concat (prefix, fn, 0));=0A=
+	  Progress.SetText3(concat (prefix, fn, 0));=0A=
 	  log (LOG_BABBLE, "Installing file %s%s", prefix, fn);=0A=
 	  if (archive::extract_file (thefile, prefix) !=3D 0)=0A=
 	    {=0A=
@@ -277,7 +201,7 @@ install_one_source (packagemeta & pkgm,=20=0A=
   progress (0);=0A=
=20=0A=
   int df =3D diskfull (get_root_dir ());=0A=
-  SendMessage (ins_diskfull, PBM_SETPOS, (WPARAM) df, 0);=0A=
+  Progress.SetBar3(df);=0A=
=20=0A=
   if (lst)=0A=
     delete lst;=0A=
@@ -378,8 +302,8 @@ check_for_old_cygwin ()=0A=
   return;=0A=
 }=0A=
=20=0A=
-void=0A=
-do_install (HINSTANCE h)=0A=
+static void=0A=
+do_install_thread (HINSTANCE h, HWND owner)=0A=
 {=0A=
   int i;=0A=
   int errors =3D 0;=0A=
@@ -401,15 +325,13 @@ do_install (HINSTANCE h)=0A=
   io_stream *utmp =3D io_stream::open ("cygfile:///var/run/utmp", "wb");=
=0A=
   delete utmp;=0A=
=20=0A=
-  dismiss_url_status_dialog ();=0A=
-=0A=
   init_dialog ();=0A=
=20=0A=
   total_bytes =3D 0;=0A=
   total_bytes_sofar =3D 0;=0A=
=20=0A=
   int df =3D diskfull (get_root_dir ());=0A=
-  SendMessage (ins_diskfull, PBM_SETPOS, (WPARAM) df, 0);=0A=
+  Progress.SetBar3(df);=0A=
=20=0A=
   int istext =3D (root_text =3D=3D IDC_ROOT_TEXT) ? 1 : 0;=0A=
   int issystem =3D (root_scope =3D=3D IDC_ROOT_SYSTEM) ? 1 : 0;=0A=
@@ -451,15 +373,13 @@ do_install (HINSTANCE h)=0A=
 	}=0A=
     }				// end of big package loop=0A=
=20=0A=
-  ShowWindow (ins_dialog, SW_HIDE);=0A=
-=0A=
   int temperr;=0A=
   if ((temperr =3D db.flush ()))=0A=
     {=0A=
       const char *err =3D strerror (temperr);=0A=
       if (!err)=0A=
 	err =3D "(unknown error)";=0A=
-      fatal (IDS_ERR_OPEN_WRITE, err);=0A=
+      fatal (owner, IDS_ERR_OPEN_WRITE, err);=0A=
     }=0A=
=20=0A=
   if (!errors)=0A=
@@ -479,4 +399,29 @@ do_install (HINSTANCE h)=0A=
     exit_msg =3D IDS_INSTALL_INCOMPLETE;=0A=
   else=0A=
     exit_msg =3D IDS_INSTALL_COMPLETE;=0A=
+}=0A=
+=0A=
+static void=0A=
+do_install_reflector(void* p)=0A=
+{=0A=
+	HANDLE *context;=0A=
+	context =3D (HANDLE*)p;=0A=
+=0A=
+	do_install_thread((HINSTANCE)context[0], (HWND)context[1]);=0A=
+=0A=
+	// Tell the progress page that we're done downloading=0A=
+	Progress.PostMessage(WM_APP_INSTALL_THREAD_COMPLETE, next_dialog);=0A=
+=0A=
+	_endthread();=0A=
+}=0A=
+=0A=
+static HANDLE context[2];=0A=
+=0A=
+void=0A=
+do_install (HINSTANCE h, HWND owner)=0A=
+{=0A=
+	context[0] =3D h;=0A=
+	context[1] =3D owner;=0A=
+=0A=
+	_beginthread(do_install_reflector, 0, context);=0A=
 }=0A=
Index: localdir.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/localdir.cc,v=0A=
retrieving revision 2.5=0A=
diff -p -u -r2.5 localdir.cc=0A=
--- localdir.cc	2001/11/14 00:11:35	2.5=0A=
+++ localdir.cc	2001/12/19 10:59:55=0A=
@@ -39,6 +39,8 @@ static const char *cvsid =3D=0A=
 #include "mkdir.h"=0A=
 #include "io_stream.h"=0A=
=20=0A=
+#include "localdir.h"=0A=
+=0A=
 void=0A=
 save_local_dir ()=0A=
 {=0A=
@@ -129,6 +131,7 @@ dialog_cmd (HWND h, int id, HWND hwndctl=0A=
       browse (h);=0A=
       break;=0A=
=20=0A=
+#if 0=0A=
     case IDOK:=0A=
       save_dialog (h);=0A=
       save_local_dir ();=0A=
@@ -150,7 +153,7 @@ dialog_cmd (HWND h, int id, HWND hwndctl=0A=
 	    }=0A=
 	}=0A=
       else=0A=
-	note (IDS_ERR_CHDIR, local_dir);=0A=
+	note (h, IDS_ERR_CHDIR, local_dir);=0A=
=20=0A=
       break;=0A=
=20=0A=
@@ -174,10 +177,12 @@ dialog_cmd (HWND h, int id, HWND hwndctl=0A=
     case IDCANCEL:=0A=
       NEXT (0);=0A=
       break;=0A=
+#endif=0A=
     }=0A=
   return 0;=0A=
 }=0A=
=20=0A=
+#if 0=0A=
 static BOOL CALLBACK=0A=
 dialog_proc (HWND h, UINT message, WPARAM wParam, LPARAM lParam)=0A=
 {=0A=
@@ -191,11 +196,13 @@ dialog_proc (HWND h, UINT message, WPARA=0A=
     }=0A=
   return FALSE;=0A=
 }=0A=
+#endif=0A=
=20=0A=
 extern char cwd[_MAX_PATH];=0A=
=20=0A=
+#if 0=0A=
 void=0A=
-do_local_dir (HINSTANCE h)=0A=
+do_local_dir (HINSTANCE h, HWND owner)=0A=
 {=0A=
   static int inited =3D 0;=0A=
   if (!inited)=0A=
@@ -219,9 +226,76 @@ do_local_dir (HINSTANCE h)=0A=
     }=0A=
=20=0A=
   int rv =3D 0;=0A=
-  rv =3D DialogBox (h, MAKEINTRESOURCE (IDD_LOCAL_DIR), 0, dialog_proc);=
=0A=
+  rv =3D DialogBox (h, MAKEINTRESOURCE (IDD_LOCAL_DIR), owner, dialog_proc=
);=0A=
   if (rv =3D=3D -1)=0A=
-    fatal (IDS_DIALOG_FAILED);=0A=
+    fatal (owner, IDS_DIALOG_FAILED);=0A=
=20=0A=
   log (0, "Selected local directory: %s", local_dir);=0A=
+}=0A=
+#endif=0A=
+=0A=
+////=0A=
+=0A=
+bool LocalDirPage::Create()=0A=
+{=0A=
+	return PropertyPage::Create(NULL, dialog_cmd, IDD_LOCAL_DIR);=0A=
+}=0A=
+=0A=
+void LocalDirPage::OnInit()=0A=
+{=0A=
+  static int inited =3D 0;=0A=
+	  if (!inited)=0A=
+		{=0A=
+		  io_stream *f =3D=0A=
+		io_stream::open ("cygfile:///etc/setup/last-cache", "rt");=0A=
+		  if (!f)=0A=
+		f =3D io_stream::open ("file://last-cache", "rt");=0A=
+		  if (f)=0A=
+		{=0A=
+		  char localdir[1000];=0A=
+		  char *fg_ret =3D f->gets (localdir, 1000);=0A=
+		  delete f;=0A=
+		  if (fg_ret)=0A=
+			{=0A=
+			  free (local_dir);=0A=
+			  local_dir =3D strdup (localdir);=0A=
+			}=0A=
+		}=0A=
+		  inited =3D 1;=0A=
+		}=0A=
+}=0A=
+=0A=
+void LocalDirPage::OnActivate()=0A=
+{=0A=
+  load_dialog (GetHWND());=0A=
+}=0A=
+=0A=
+long LocalDirPage::OnNext()=0A=
+{=0A=
+  HWND h =3D GetHWND();=0A=
+=0A=
+  save_dialog (h);=0A=
+  save_local_dir ();=0A=
+  if (SetCurrentDirectoryA (local_dir))=0A=
+  {=0A=
+	if (source =3D=3D IDC_SOURCE_CWD)=0A=
+	{=0A=
+	  return IDD_S_FROM_CWD;=0A=
+	}=0A=
+  }=0A=
+  else=0A=
+  note (h, IDS_ERR_CHDIR, local_dir);=0A=
+=0A=
+  return 0;=0A=
+}=0A=
+=0A=
+long LocalDirPage::OnBack()=0A=
+{=0A=
+	save_dialog (GetHWND());=0A=
+    if(source =3D=3D IDC_SOURCE_DOWNLOAD)=0A=
+	{=0A=
+		// Downloading only, skip the unix root page=0A=
+		return IDD_SOURCE;=0A=
+	}=0A=
+	return 0;=0A=
 }=0A=
Index: log.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/log.cc,v=0A=
retrieving revision 2.5=0A=
diff -p -u -r2.5 log.cc=0A=
--- log.cc	2001/11/13 01:49:32	2.5=0A=
+++ log.cc	2001/12/19 10:59:55=0A=
@@ -86,7 +86,7 @@ log_save (int babble, const char *filena=0A=
   FILE *f =3D fopen (filename, append ? "at" : "wt");=0A=
   if (!f)=0A=
     {=0A=
-      fatal (IDS_NOLOGFILE, filename);=0A=
+      fatal (NULL, IDS_NOLOGFILE, filename);=0A=
       return;=0A=
     }=0A=
=20=0A=
@@ -115,7 +115,7 @@ exit_setup (int exit_code)=0A=
   been_here =3D 1;=0A=
=20=0A=
   if (exit_msg)=0A=
-    note (exit_msg);=0A=
+    note (NULL, exit_msg);=0A=
=20=0A=
   log (LOG_TIMESTAMP, "Ending cygwin install");=0A=
=20=0A=
Index: main.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/main.cc,v=0A=
retrieving revision 2.9=0A=
diff -p -u -r2.9 main.cc=0A=
--- main.cc	2001/11/13 01:49:32	2.9=0A=
+++ main.cc	2001/12/19 10:59:56=0A=
@@ -29,6 +29,7 @@ static const char *cvsid =3D=0A=
 #endif=0A=
=20=0A=
 #include "win32.h"=0A=
+#include <commctrl.h>=0A=
=20=0A=
 #include <stdio.h>=0A=
 #include <stdlib.h>=0A=
@@ -42,7 +43,19 @@ static const char *cvsid =3D=0A=
 #include "version.h"=0A=
=20=0A=
 #include "port.h"=0A=
+#include "proppage.h"=0A=
+#include "propsheet.h"=0A=
=20=0A=
+// Page class headers=0A=
+#include "splash.h"=0A=
+#include "source.h"=0A=
+#include "localdir.h"=0A=
+#include "net.h"=0A=
+#include "site.h"=0A=
+#include "chooser.h"=0A=
+#include "threebar.h"=0A=
+#include "desktop.h"=0A=
+=0A=
 int next_dialog;=0A=
 int exit_msg =3D 0;=0A=
=20=0A=
@@ -123,6 +136,12 @@ out:=0A=
   FreeSid (sid);=0A=
 }=0A=
=20=0A=
+extern BOOL CALLBACK=0A=
+root_dialog_proc (HWND h, UINT message, WPARAM wParam, LPARAM lParam);=0A=
+=0A=
+// Other threads talk to this page, so we need to have it externable.=0A=
+ThreeBarProgressPage Progress;=0A=
+=0A=
 int WINAPI=0A=
 WinMain (HINSTANCE h,=0A=
 	 HINSTANCE hPrevInstance, LPSTR command_line, int cmd_show)=0A=
@@ -133,6 +152,16 @@ WinMain (HINSTANCE h,=0A=
=20=0A=
   log (LOG_TIMESTAMP, "Starting cygwin install, version %s", version);=0A=
=20=0A=
+  SplashPage Splash;=0A=
+  SourcePage Source;=0A=
+  PropertyPage Root;=0A=
+  LocalDirPage LocalDir;=0A=
+  NetPage Net;=0A=
+  SitePage Site;=0A=
+  ChooserPage Chooser;=0A=
+  DesktopSetupPage Desktop;=0A=
+  PropSheet MainWindow;=0A=
+=0A=
   char cwd[_MAX_PATH];=0A=
   GetCurrentDirectory (sizeof (cwd), cwd);=0A=
   local_dir =3D strdup (cwd);=0A=
@@ -150,58 +179,95 @@ WinMain (HINSTANCE h,=0A=
   if (iswinnt)=0A=
     set_default_dacl ();=0A=
=20=0A=
+  // Initialize common controls=0A=
+  InitCommonControls();=0A=
+=0A=
+  // Init window class lib=0A=
+  Window::SetAppInstance(h);=0A=
+=0A=
+  // Create pages=0A=
+  Splash.Create();=0A=
+  Source.Create();=0A=
+  Root.Create(root_dialog_proc, IDD_ROOT);=0A=
+  LocalDir.Create();=0A=
+  Net.Create();=0A=
+  Site.Create();=0A=
+  Chooser.Create();=0A=
+  Progress.Create();=0A=
+  Desktop.Create();=0A=
+=0A=
+  // Add pages to sheet=0A=
+  MainWindow.AddPage(&Splash);=0A=
+  MainWindow.AddPage(&Source);=0A=
+  MainWindow.AddPage(&Root);=0A=
+  MainWindow.AddPage(&LocalDir);=0A=
+  MainWindow.AddPage(&Net);=0A=
+  MainWindow.AddPage(&Site);=0A=
+  MainWindow.AddPage(&Chooser);=0A=
+  MainWindow.AddPage(&Progress);=0A=
+  MainWindow.AddPage(&Desktop);=0A=
+=0A=
+  // Create the PropSheet main window=0A=
+  MainWindow.Create();=0A=
+  //MainWindow.Show(SW_SHOWNORMAL);=0A=
+=0A=
+#if 0=0A=
+  HWND owner =3D NULL;=0A=
+=0A=
   while (next_dialog)=0A=
     {=0A=
       switch (next_dialog)=0A=
 	{=0A=
 	case IDD_SPLASH:=0A=
-	  do_splash (h);=0A=
+	  do_splash (h, owner);=0A=
 	  break;=0A=
 	case IDD_SOURCE:=0A=
-	  do_source (h);=0A=
+	  do_source (h, owner);=0A=
 	  break;=0A=
 	case IDD_LOCAL_DIR:=0A=
-	  do_local_dir (h);=0A=
+	  do_local_dir (h, owner);=0A=
 	  break;=0A=
 	case IDD_ROOT:=0A=
-	  do_root (h);=0A=
+	  do_root (h, owner);=0A=
 	  break;=0A=
 	case IDD_NET:=0A=
-	  do_net (h);=0A=
+	  do_net (h, owner);=0A=
 	  break;=0A=
 	case IDD_SITE:=0A=
-	  do_site (h);=0A=
+	  do_site (h, owner);=0A=
 	  break;=0A=
 	case IDD_OTHER_URL:=0A=
-	  do_other (h);=0A=
+	  do_other (h, owner);=0A=
 	  break;=0A=
 	case IDD_S_LOAD_INI:=0A=
-	  do_ini (h);=0A=
+	  do_ini (h, owner);=0A=
 	  break;=0A=
 	case IDD_S_FROM_CWD:=0A=
-	  do_fromcwd (h);=0A=
+	  do_fromcwd (h, owner);=0A=
 	  break;=0A=
 	case IDD_CHOOSE:=0A=
-	  do_choose (h);=0A=
+	  do_choose (h, owner);=0A=
 	  break;=0A=
 	case IDD_S_DOWNLOAD:=0A=
-	  do_download (h);=0A=
+	  do_download (h, owner);=0A=
 	  break;=0A=
 	case IDD_S_INSTALL:=0A=
-	  do_install (h);=0A=
+	  do_install (h, owner);=0A=
 	  break;=0A=
 	case IDD_DESKTOP:=0A=
-	  do_desktop (h);=0A=
+	  do_desktop (h, owner);=0A=
 	  break;=0A=
 	case IDD_S_POSTINSTALL:=0A=
-	  do_postinstall (h);=0A=
+	  do_postinstall (h, owner);=0A=
 	  break;=0A=
=20=0A=
 	default:=0A=
 	  next_dialog =3D 0;=0A=
 	  break;=0A=
 	}=0A=
+=0A=
     }=0A=
+#endif=0A=
=20=0A=
   exit_setup (0);=0A=
   /* Keep gcc happy :} */=0A=
Index: msg.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/msg.cc,v=0A=
retrieving revision 2.2=0A=
diff -p -u -r2.2 msg.cc=0A=
--- msg.cc	2001/11/13 01:49:32	2.2=0A=
+++ msg.cc	2001/12/19 10:59:56=0A=
@@ -38,7 +38,7 @@ msg (const char *fmt, ...)=0A=
 }=0A=
=20=0A=
 static int=0A=
-mbox (const char *name, int type, int id, va_list args)=0A=
+mbox (HWND owner, const char *name, int type, int id, va_list args)=0A=
 {=0A=
   char buf[1000], fmt[1000];=0A=
=20=0A=
@@ -47,30 +47,30 @@ mbox (const char *name, int type, int id=0A=
=20=0A=
   vsprintf (buf, fmt, args);=0A=
   log (0, "mbox %s: %s", name, buf);=0A=
-  return MessageBox (0, buf, "Cygwin Setup", type | MB_TOPMOST);=0A=
+  return MessageBox (owner, buf, "Cygwin Setup", type /*| MB_TOPMOST*/);=
=0A=
 }=0A=
=20=0A=
 void=0A=
-note (int id, ...)=0A=
+note (HWND owner, int id, ...)=0A=
 {=0A=
   va_list args;=0A=
   va_start (args, id);=0A=
-  mbox ("note", 0, id, args);=0A=
+  mbox (owner, "note", 0, id, args);=0A=
 }=0A=
=20=0A=
 void=0A=
-fatal (int id, ...)=0A=
+fatal (HWND owner, int id, ...)=0A=
 {=0A=
   va_list args;=0A=
   va_start (args, id);=0A=
-  mbox ("fatal", 0, id, args);=0A=
+  mbox (owner, "fatal", 0, id, args);=0A=
   exit_setup (1);=0A=
 }=0A=
=20=0A=
 int=0A=
-yesno (int id, ...)=0A=
+yesno (HWND owner, int id, ...)=0A=
 {=0A=
   va_list args;=0A=
   va_start (args, id);=0A=
-  return mbox ("yesno", MB_YESNO, id, args);=0A=
+  return mbox (owner, "yesno", MB_YESNO, id, args);=0A=
 }=0A=
Index: msg.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/msg.h,v=0A=
retrieving revision 2.1=0A=
diff -p -u -r2.1 msg.h=0A=
--- msg.h	2001/11/13 01:49:32	2.1=0A=
+++ msg.h	2001/12/19 10:59:56=0A=
@@ -23,11 +23,11 @@ void msg (const char *fmt, ...);=0A=
    is interpreted like printf.  The program exits when the user=0A=
    presses OK. */=0A=
=20=0A=
-void fatal (int id, ...);=0A=
+void fatal (HWND owner, int id, ...);=0A=
=20=0A=
 /* Similar, but the program continues when the user presses OK */=0A=
=20=0A=
-void note (int id, ...);=0A=
+void note (HWND owner, int id, ...);=0A=
=20=0A=
 /* returns IDYES or IDNO, otherwise same as note() */=0A=
-int yesno (int id, ...);=0A=
+int yesno (HWND owner, int id, ...);=0A=
Index: net.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/net.cc,v=0A=
retrieving revision 2.7=0A=
diff -p -u -r2.7 net.cc=0A=
--- net.cc	2001/11/13 01:49:32	2.7=0A=
+++ net.cc	2001/12/19 10:59:56=0A=
@@ -30,6 +30,11 @@ static const char *cvsid =3D=0A=
 #include "msg.h"=0A=
 #include "log.h"=0A=
=20=0A=
+#include "net.h"=0A=
+=0A=
+#include "threebar.h"=0A=
+extern ThreeBarProgressPage Progress;=0A=
+=0A=
 static int rb[] =3D { IDC_NET_IE5, IDC_NET_DIRECT, IDC_NET_PROXY, 0 };=0A=
=20=0A=
 static void=0A=
@@ -85,6 +90,7 @@ dialog_cmd (HWND h, int id, HWND hwndctl=0A=
       check_if_enable_next (h);=0A=
       break;=0A=
=20=0A=
+#if 0=0A=
     case IDOK:=0A=
       save_dialog (h);=0A=
       switch (source)=0A=
@@ -110,16 +116,19 @@ dialog_cmd (HWND h, int id, HWND hwndctl=0A=
     case IDCANCEL:=0A=
       NEXT (0);=0A=
       break;=0A=
+#endif=0A=
     }=0A=
   return 0;=0A=
 }=0A=
=20=0A=
+#if 0=0A=
 static BOOL CALLBACK=0A=
 dialog_proc (HWND h, UINT message, WPARAM wParam, LPARAM lParam)=0A=
 {=0A=
   switch (message)=0A=
     {=0A=
     case WM_INITDIALOG:=0A=
+  net_method =3D IDC_NET_DIRECT;=0A=
       load_dialog (h);=0A=
=20=0A=
       // Check to see if any radio buttons are selected. If not, select a =
default.=0A=
@@ -139,16 +148,60 @@ dialog_proc (HWND h, UINT message, WPARA=0A=
 }=0A=
=20=0A=
 void=0A=
-do_net (HINSTANCE h)=0A=
+do_net (HINSTANCE h, HWND owner)=0A=
 {=0A=
   int rv =3D 0;=0A=
=20=0A=
-  net_method =3D IDC_NET_DIRECT;=0A=
-  rv =3D DialogBox (h, MAKEINTRESOURCE (IDD_NET), 0, dialog_proc);=0A=
+  rv =3D DialogBox (h, MAKEINTRESOURCE (IDD_NET), owner, dialog_proc);=0A=
   if (rv =3D=3D -1)=0A=
-    fatal (IDS_DIALOG_FAILED);=0A=
+    fatal (owner, IDS_DIALOG_FAILED);=0A=
=20=0A=
   log (0, "net: %s",=0A=
        (net_method =3D=3D IDC_NET_IE5) ? "IE5" :=0A=
        (net_method =3D=3D IDC_NET_DIRECT) ? "Direct" : "Proxy");=0A=
+}=0A=
+#endif=0A=
+=0A=
+/////////////////////////////////=0A=
+=0A=
+bool NetPage::Create()=0A=
+{=0A=
+	return PropertyPage::Create(NULL, dialog_cmd, IDD_NET);=0A=
+}=0A=
+=0A=
+void NetPage::OnInit()=0A=
+{=0A=
+	HWND h =3D GetHWND();=0A=
+=09=0A=
+	net_method =3D IDC_NET_DIRECT;=0A=
+	load_dialog (h);=0A=
+=0A=
+	// Check to see if any radio buttons are selected. If not, select a defau=
lt.=0A=
+	if (=0A=
+	(!SendMessage (GetDlgItem (IDC_NET_IE5), BM_GETCHECK, 0, 0) =3D=3D=0A=
+		BST_CHECKED)=0A=
+	&& (!SendMessage (GetDlgItem (IDC_NET_PROXY), BM_GETCHECK, 0, 0)=0A=
+	  =3D=3D BST_CHECKED))=0A=
+	{=0A=
+		SendMessage (GetDlgItem (IDC_NET_DIRECT), BM_CLICK, 0, 0);=0A=
+	}=0A=
+}=0A=
+=0A=
+void NetPage::OnDeactivate()=0A=
+{=0A=
+	//save_dialog (h);=0A=
+}=0A=
+=0A=
+long NetPage::OnNext()=0A=
+{=0A=
+	save_dialog (GetHWND());=0A=
+=0A=
+	Progress.SetActivateTask(WM_APP_START_SITE_INFO_DOWNLOAD);=0A=
+	return IDD_INSTATUS;=0A=
+}=0A=
+=0A=
+long NetPage::OnBack()=0A=
+{=0A=
+	save_dialog (GetHWND());=0A=
+	return 0;=0A=
 }=0A=
Index: netio.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/netio.cc,v=0A=
retrieving revision 2.5=0A=
diff -p -u -r2.5 netio.cc=0A=
--- netio.cc	2001/12/02 03:25:11	2.5=0A=
+++ netio.cc	2001/12/19 10:59:57=0A=
@@ -229,29 +229,29 @@ auth_proc (HWND h, UINT message, WPARAM=20=0A=
 }=0A=
=20=0A=
 static int=0A=
-auth_common (HINSTANCE h, int id)=0A=
+auth_common (HINSTANCE h, int id, HWND owner)=0A=
 {=0A=
-  return DialogBox (h, MAKEINTRESOURCE (id), 0, auth_proc);=0A=
+  return DialogBox (h, MAKEINTRESOURCE (id), owner, auth_proc);=0A=
 }=0A=
=20=0A=
 int=0A=
-NetIO::get_auth ()=0A=
+NetIO::get_auth (HWND owner)=0A=
 {=0A=
   user =3D &net_user;=0A=
   passwd =3D &net_passwd;=0A=
-  return auth_common (hinstance, IDD_NET_AUTH);=0A=
+  return auth_common (hinstance, IDD_NET_AUTH, owner);=0A=
 }=0A=
=20=0A=
 int=0A=
-NetIO::get_proxy_auth ()=0A=
+NetIO::get_proxy_auth (HWND owner)=0A=
 {=0A=
   user =3D &net_proxy_user;=0A=
   passwd =3D &net_proxy_passwd;=0A=
-  return auth_common (hinstance, IDD_PROXY_AUTH);=0A=
+  return auth_common (hinstance, IDD_PROXY_AUTH, owner);=0A=
 }=0A=
=20=0A=
 int=0A=
-NetIO::get_ftp_auth ()=0A=
+NetIO::get_ftp_auth (HWND owner)=0A=
 {=0A=
   if (net_ftp_user)=0A=
     {=0A=
@@ -267,5 +267,5 @@ NetIO::get_ftp_auth ()=0A=
     return IDCANCEL;=0A=
   user =3D &net_ftp_user;=0A=
   passwd =3D &net_ftp_passwd;=0A=
-  return auth_common (hinstance, IDD_FTP_AUTH);=0A=
+  return auth_common (hinstance, IDD_FTP_AUTH, owner);=0A=
 }=0A=
Index: netio.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/netio.h,v=0A=
retrieving revision 2.4=0A=
diff -p -u -r2.4 netio.h=0A=
--- netio.h	2001/12/02 03:25:11	2.4=0A=
+++ netio.h	2001/12/19 10:59:57=0A=
@@ -50,7 +50,7 @@ public:=0A=
   /* Helper functions for http/ftp protocols.  Both return nonzero for=0A=
      "cancel", zero for "ok".  They set net_proxy_user, etc, in=0A=
      state.h */=0A=
-  int get_auth ();=0A=
-  int get_proxy_auth ();=0A=
-  int get_ftp_auth ();=0A=
+  int get_auth (HWND owner);=0A=
+  int get_proxy_auth (HWND owner);=0A=
+  int get_ftp_auth (HWND owner);=0A=
 };=0A=
Index: nio-file.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/nio-file.cc,v=0A=
retrieving revision 2.4=0A=
diff -p -u -r2.4 nio-file.cc=0A=
--- nio-file.cc	2001/12/02 03:25:11	2.4=0A=
+++ nio-file.cc	2001/12/19 10:59:57=0A=
@@ -45,7 +45,7 @@ NetIO (Purl)=0A=
       const char *err =3D strerror (errno);=0A=
       if (!err)=0A=
 	err =3D "(unknown error)";=0A=
-      note (IDS_ERR_OPEN_READ, path, err);=0A=
+      note (NULL, IDS_ERR_OPEN_READ, path, err);=0A=
     }=0A=
 }=0A=
=20=0A=
Index: nio-ftp.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/nio-ftp.cc,v=0A=
retrieving revision 2.8=0A=
diff -p -u -r2.8 nio-ftp.cc=0A=
--- nio-ftp.cc	2001/12/02 03:25:11	2.8=0A=
+++ nio-ftp.cc	2001/12/19 10:59:57=0A=
@@ -95,7 +95,7 @@ NetIO_FTP::NetIO_FTP (char const *Purl,=20=0A=
 	}=0A=
       if (code =3D=3D 530)		/* Authentication failed, retry */=0A=
 	{=0A=
-	  get_ftp_auth ();=0A=
+	  get_ftp_auth (NULL);=0A=
 	  if (net_ftp_user && net_ftp_passwd)=0A=
 	    goto auth_retry;=0A=
 	}=0A=
Index: nio-http.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/nio-http.cc,v=0A=
retrieving revision 2.9=0A=
diff -p -u -r2.9 nio-http.cc=0A=
--- nio-http.cc	2001/12/02 03:25:11	2.9=0A=
+++ nio-http.cc	2001/12/19 11:00:01=0A=
@@ -148,14 +148,14 @@ retry_get:=0A=
     }=0A=
   if (code =3D=3D 401)		/* authorization required */=0A=
     {=0A=
-      get_auth ();=0A=
+      get_auth (NULL);=0A=
       delete=0A=
 	s;=0A=
       goto retry_get;=0A=
     }=0A=
   if (code =3D=3D 407)		/* proxy authorization required */=0A=
     {=0A=
-      get_proxy_auth ();=0A=
+      get_proxy_auth (NULL);=0A=
       delete=0A=
 	s;=0A=
       goto retry_get;=0A=
@@ -163,7 +163,7 @@ retry_get:=0A=
   if (code =3D=3D 500		/* ftp authentication through proxy required */=0A=
       && net_method =3D=3D IDC_NET_PROXY && !strncmp (url, "ftp://", 6))=
=0A=
     {=0A=
-      get_ftp_auth ();=0A=
+      get_ftp_auth (NULL);=0A=
       if (net_ftp_user && net_ftp_passwd)=0A=
 	{=0A=
 	  delete=0A=
Index: nio-ie5.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/nio-ie5.cc,v=0A=
retrieving revision 2.4=0A=
diff -p -u -r2.4 nio-ie5.cc=0A=
--- nio-ie5.cc	2001/12/02 03:25:11	2.4=0A=
+++ nio-ie5.cc	2001/12/19 11:00:01=0A=
@@ -44,7 +44,7 @@ NetIO (_url)=0A=
       HINSTANCE h =3D LoadLibrary ("wininet.dll");=0A=
       if (!h)=0A=
 	{=0A=
-	  note (IDS_WININET);=0A=
+	  note (NULL, IDS_WININET);=0A=
 	  connection =3D 0;=0A=
 	  return;=0A=
 	}=0A=
@@ -112,14 +112,14 @@ try_again:=0A=
 	  if (type =3D=3D 401)	/* authorization required */=0A=
 	    {=0A=
 	      flush_io ();=0A=
-	      get_auth ();=0A=
+	      get_auth (NULL);=0A=
 	      resend =3D 1;=0A=
 	      goto try_again;=0A=
 	    }=0A=
 	  else if (type =3D=3D 407)	/* proxy authorization required */=0A=
 	    {=0A=
 	      flush_io ();=0A=
-	      get_proxy_auth ();=0A=
+	      get_proxy_auth (NULL);=0A=
 	      resend =3D 1;=0A=
 	      goto try_again;=0A=
 	    }=0A=
Index: other.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/other.cc,v=0A=
retrieving revision 2.3=0A=
diff -p -u -r2.3 other.cc=0A=
--- other.cc	2001/12/03 22:22:09	2.3=0A=
+++ other.cc	2001/12/19 11:00:01=0A=
@@ -103,12 +103,12 @@ dialog_proc (HWND h, UINT message, WPARA=0A=
 }=0A=
=20=0A=
 void=0A=
-do_other (HINSTANCE h)=0A=
+do_other (HINSTANCE h, HWND owner)=0A=
 {=0A=
   int rv =3D 0;=0A=
-  rv =3D DialogBox (h, MAKEINTRESOURCE (IDD_OTHER_URL), 0, dialog_proc);=
=0A=
+  rv =3D DialogBox (h, MAKEINTRESOURCE (IDD_OTHER_URL), owner, dialog_proc=
);=0A=
   if (rv =3D=3D -1)=0A=
-    fatal (IDS_DIALOG_FAILED);=0A=
+    fatal (owner, IDS_DIALOG_FAILED);=0A=
=20=0A=
   log (0, "site: %s", other_url);=0A=
 }=0A=
Index: package_db.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/package_db.cc,v=0A=
retrieving revision 2.11=0A=
diff -p -u -r2.11 package_db.cc=0A=
--- package_db.cc	2001/12/03 22:52:01	2.11=0A=
+++ package_db.cc	2001/12/19 11:00:02=0A=
@@ -22,7 +22,6 @@=0A=
 static const char *cvsid =3D=0A=
   "\n%%% $Id: package_db.cc,v 2.11 2001/12/03 22:52:01 rbcollins Exp $\n";=
=0A=
 #endif=0A=
-=0A=
 #include <stdio.h>=0A=
 #include <stdlib.h>=0A=
 #include <unistd.h>=0A=
Index: package_meta.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/package_meta.cc,v=0A=
retrieving revision 2.7=0A=
diff -p -u -r2.7 package_meta.cc=0A=
--- package_meta.cc	2001/12/02 03:25:11	2.7=0A=
+++ package_meta.cc	2001/12/19 11:00:02=0A=
@@ -151,5 +151,6 @@ packagemeta::add_category (Category & ca=0A=
 char const *=0A=
 packagemeta::SDesc ()=0A=
 {=0A=
-  return versions[1]->SDesc ();=0A=
+  //return versions[1]->SDesc ();=0A=
+	return sdesc;=0A=
 };=0A=
Index: package_meta.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/package_meta.h,v=0A=
retrieving revision 2.7=0A=
diff -p -u -r2.7 package_meta.h=0A=
--- package_meta.h	2001/12/02 03:25:11	2.7=0A=
+++ package_meta.h	2001/12/19 11:00:03=0A=
@@ -85,6 +85,7 @@ public:=0A=
   char *installed_from;=0A=
   /* SDesc is global in theory, across all package versions.=20=0A=
      LDesc is not: it can be different per version */=0A=
+  char *sdesc;=0A=
   char const *SDesc ();=0A=
   /* what categories does this package belong in. Note that if multiple ve=
rsions=0A=
    * of a package disagree.... the first one read in will take precedence.=
=0A=
Index: postinstall.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/postinstall.cc,v=0A=
retrieving revision 2.4=0A=
diff -p -u -r2.4 postinstall.cc=0A=
--- postinstall.cc	2001/11/13 01:49:32	2.4=0A=
+++ postinstall.cc	2001/12/19 11:00:03=0A=
@@ -98,7 +98,7 @@ static const char *shells[] =3D {=0A=
 };=0A=
=20=0A=
 void=0A=
-do_postinstall (HINSTANCE h)=0A=
+do_postinstall (HINSTANCE h, HWND owner)=0A=
 {=0A=
   next_dialog =3D 0;=0A=
   int i;=0A=
Index: res.rc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/res.rc,v=0A=
retrieving revision 2.31=0A=
diff -p -u -r2.31 res.rc=0A=
--- res.rc	2001/12/03 22:22:09	2.31=0A=
+++ res.rc	2001/12/19 11:00:04=0A=
@@ -29,7 +29,7 @@ LANGUAGE LANG_ENGLISH, SUBLANG_ENGLISH_U=0A=
 //=0A=
=20=0A=
 IDD_SOURCE DIALOG DISCARDABLE  0, 0, 215, 95=0A=
-STYLE DS_MODALFRAME | DS_CENTER | WS_POPUP | WS_CAPTION | WS_SYSMENU=0A=
+STYLE DS_MODALFRAME | DS_CENTER | WS_CHILD | WS_CAPTION | WS_SYSMENU=0A=
 CAPTION "Cygwin Setup"=0A=
 FONT 8, "MS Sans Serif"=0A=
 BEGIN=0A=
@@ -40,26 +40,21 @@ BEGIN=0A=
                     BS_AUTORADIOBUTTON,55,30,89,10=0A=
     CONTROL         "Install from &Local Directory",IDC_SOURCE_CWD,"Button=
",=0A=
                     BS_AUTORADIOBUTTON,55,45,99,10=0A=
-    DEFPUSHBUTTON   "&Next -->",IDOK,100,75,45,15=0A=
-    PUSHBUTTON      "Cancel",IDCANCEL,165,75,45,15=0A=
 END=0A=
=20=0A=
-IDD_LOCAL_DIR DIALOG DISCARDABLE  0, 0, 215, 95=0A=
-STYLE DS_MODALFRAME | DS_CENTER | WS_POPUP | WS_CAPTION | WS_SYSMENU=0A=
+IDD_LOCAL_DIR DIALOG DISCARDABLE  0, 0, 227, 94=0A=
+STYLE DS_MODALFRAME | DS_CENTER | WS_CHILD | WS_CAPTION | WS_SYSMENU=0A=
 CAPTION "Cygwin Setup"=0A=
 FONT 8, "MS Sans Serif"=0A=
 BEGIN=0A=
     ICON            IDI_CYGWIN,IDC_STATIC,5,5,20,20=0A=
-    PUSHBUTTON      "B&rowse...",IDC_LOCAL_DIR_BROWSE,150,10,34,14=0A=
+    PUSHBUTTON      "B&rowse...",IDC_LOCAL_DIR_BROWSE,185,30,34,14=0A=
     LTEXT           "Local Package &Directory",IDC_STATIC,55,15,85,11=0A=
-    EDITTEXT        IDC_LOCAL_DIR,55,25,127,12,ES_AUTOHSCROLL=0A=
-    DEFPUSHBUTTON   "&Next -->",IDOK,100,75,45,15=0A=
-    PUSHBUTTON      "Cancel",IDCANCEL,165,75,45,15=0A=
-    PUSHBUTTON      "<-- &Back",IDC_BACK,55,75,45,15=0A=
+    EDITTEXT        IDC_LOCAL_DIR,55,30,127,15,ES_AUTOHSCROLL=0A=
 END=0A=
=20=0A=
 IDD_ROOT DIALOG DISCARDABLE  0, 0, 215, 95=0A=
-STYLE DS_MODALFRAME | DS_CENTER | WS_POPUP | WS_CAPTION | WS_SYSMENU=0A=
+STYLE DS_MODALFRAME | DS_CENTER | WS_CHILD | WS_CAPTION | WS_SYSMENU=0A=
 CAPTION "Cygwin Setup"=0A=
 FONT 8, "MS Sans Serif"=0A=
 BEGIN=0A=
@@ -77,23 +72,17 @@ BEGIN=0A=
                     WS_GROUP,125,60,25,8=0A=
     CONTROL         "Just &Me",IDC_ROOT_USER,"Button",BS_AUTORADIOBUTTON,1=
60,=0A=
                     60,50,8=0A=
-    DEFPUSHBUTTON   "&Next -->",IDOK,100,75,45,15=0A=
-    PUSHBUTTON      "Cancel",IDCANCEL,165,75,45,15=0A=
-    PUSHBUTTON      "<-- &Back",IDC_BACK,55,75,45,15=0A=
 END=0A=
=20=0A=
-IDD_SITE DIALOG DISCARDABLE  0, 0, 222, 206=0A=
-STYLE DS_MODALFRAME | DS_CENTER | WS_POPUP | WS_CAPTION | WS_SYSMENU=0A=
+IDD_SITE DIALOG DISCARDABLE  0, 0, 247, 94=0A=
+STYLE DS_MODALFRAME | DS_CENTER | WS_CHILD | WS_CAPTION | WS_SYSMENU=0A=
 CAPTION "Cygwin Setup"=0A=
 FONT 8, "MS Sans Serif"=0A=
 BEGIN=0A=
     ICON            IDI_CYGWIN,IDC_STATIC,5,5,20,20=0A=
-    LTEXT           "Select Download &Sites",IDC_STATIC,55,5,135,11=0A=
-    LISTBOX         IDC_URL_LIST,55,20,160,155,LBS_NOINTEGRALHEIGHT |=20=
=0A=
-    		    LBS_EXTENDEDSEL | WS_VSCROLL | WS_HSCROLL | WS_TABSTOP=0A=
-    DEFPUSHBUTTON   "&Next -->",IDOK,105,185,45,15=0A=
-    PUSHBUTTON      "Cancel",IDCANCEL,170,185,45,15=0A=
-    PUSHBUTTON      "<-- &Back",IDC_BACK,60,185,45,15=0A=
+    LTEXT           "Select Download &Site",IDC_STATIC,55,5,135,11=0A=
+    LISTBOX         IDC_URL_LIST,55,20,185,65,LBS_NOINTEGRALHEIGHT |=20=0A=
+                    LBS_EXTENDEDSEL | WS_VSCROLL | WS_HSCROLL | WS_TABSTOP=
=0A=
 END=0A=
=20=0A=
 IDD_OTHER_URL DIALOG DISCARDABLE  0, 0, 215, 95=0A=
@@ -109,32 +98,31 @@ BEGIN=0A=
     PUSHBUTTON      "<-- &Back",IDC_BACK,55,75,45,15=0A=
 END=0A=
=20=0A=
-IDD_NET DIALOGEX 0, 0, 215, 95=0A=
-STYLE DS_MODALFRAME | DS_CENTER | WS_POPUP | WS_CAPTION | WS_SYSMENU=0A=
+IDD_NET DIALOG DISCARDABLE  0, 0, 247, 106=0A=
+STYLE DS_MODALFRAME | DS_CENTER | WS_CHILD | WS_CAPTION | WS_SYSMENU=0A=
 CAPTION "Cygwin Setup"=0A=
 FONT 8, "MS Sans Serif"=0A=
 BEGIN=0A=
-    ICON            IDI_CYGWIN,IDC_STATIC,5,5,20,20=0A=
     CONTROL         "&Direct Connection",IDC_NET_DIRECT,"Button",=0A=
-                    BS_AUTORADIOBUTTON,55,10,73,10=0A=
+                    BS_AUTORADIOBUTTON | WS_GROUP | WS_TABSTOP,55,10,73,10=
=0A=
     CONTROL         "Use &IE5 Settings",IDC_NET_IE5,"Button",=0A=
-                    BS_AUTORADIOBUTTON,55,25,69,10=0A=
+                    BS_AUTORADIOBUTTON | WS_TABSTOP,55,25,69,10=0A=
     CONTROL         "Use HTTP/FTP &Proxy:",IDC_NET_PROXY,"Button",=0A=
-                    BS_AUTORADIOBUTTON,55,40,88,10=0A=
-    LTEXT           "Proxy &Host",IDC_STATIC,10,55,50,15,SS_CENTERIMAGE,=
=0A=
-                    WS_EX_RIGHT=0A=
-    EDITTEXT        IDC_PROXY_HOST,65,55,80,12,ES_AUTOHSCROLL | WS_DISABLE=
D=0A=
-    LTEXT           "Por&t",IDC_STATIC,155,55,20,15,SS_CENTERIMAGE,=0A=
-                    WS_EX_RIGHT=0A=
-    EDITTEXT        IDC_PROXY_PORT,180,55,30,12,ES_AUTOHSCROLL | WS_DISABL=
ED=0A=
-    DEFPUSHBUTTON   "&Next -->",IDOK,100,75,45,15=0A=
-    PUSHBUTTON      "Cancel",IDCANCEL,165,75,45,15=0A=
-    PUSHBUTTON      "<-- &Back",IDC_BACK,55,75,45,15=0A=
+                    BS_AUTORADIOBUTTON | WS_TABSTOP,55,40,88,10=0A=
+    EDITTEXT        IDC_PROXY_HOST,115,60,120,12,ES_AUTOHSCROLL |=20=0A=
+                    WS_DISABLED | WS_GROUP=0A=
+    EDITTEXT        IDC_PROXY_PORT,115,80,30,12,ES_AUTOHSCROLL | WS_DISABL=
ED=0A=
+    GROUPBOX        "",IDC_STATIC,55,50,185,50=0A=
+    ICON            IDI_CYGWIN,IDC_STATIC,5,5,21,20=0A=
+    RTEXT           "Proxy &Host",IDC_STATIC,60,60,50,12,SS_CENTERIMAGE |=
=20=0A=
+                    NOT WS_GROUP=0A=
+    RTEXT           "Por&t",IDC_STATIC,80,80,30,12,SS_CENTERIMAGE | NOT=20=
=0A=
+                    WS_GROUP=0A=
 END=0A=
=20=0A=
 IDD_DLSTATUS DIALOG DISCARDABLE  0, 0, 215, 95=0A=
-STYLE DS_MODALFRAME | DS_SETFOREGROUND | DS_CENTER | WS_POPUP | WS_VISIBLE=
 |=20=0A=
-    WS_CAPTION | WS_SYSMENU=0A=
+STYLE DS_MODALFRAME | DS_CENTER | WS_CHILD | WS_VISIBLE | WS_CAPTION |=20=
=0A=
+    WS_SYSMENU=0A=
 CAPTION "Cygwin Setup"=0A=
 FONT 8, "MS Sans Serif"=0A=
 BEGIN=0A=
@@ -154,26 +142,25 @@ BEGIN=0A=
     RTEXT           "Disk",IDC_DLS_IPROGRESS_TEXT,5,60,45,8=0A=
 END=0A=
=20=0A=
-IDD_INSTATUS DIALOG DISCARDABLE  0, 0, 215, 95=0A=
-STYLE DS_MODALFRAME | DS_SETFOREGROUND | DS_CENTER | WS_POPUP | WS_VISIBLE=
 |=20=0A=
-    WS_CAPTION | WS_SYSMENU=0A=
+IDD_INSTATUS DIALOG DISCARDABLE  0, 0, 252, 94=0A=
+STYLE DS_MODALFRAME | DS_CENTER | WS_CHILD | WS_VISIBLE | WS_CAPTION |=20=
=0A=
+    WS_SYSMENU=0A=
 CAPTION "Cygwin Setup"=0A=
 FONT 8, "MS Sans Serif"=0A=
 BEGIN=0A=
-    ICON            IDI_CYGWIN,IDC_STATIC,5,5,20,20=0A=
-    PUSHBUTTON      "Cancel",IDCANCEL,165,75,45,15=0A=
+    ICON            IDI_CYGWIN,IDC_STATIC,5,5,21,20=0A=
     LTEXT           "Installing...",IDC_INS_ACTION,55,5,135,8=0A=
     LTEXT           "(PKG)",IDC_INS_PKG,55,15,150,8=0A=
     LTEXT           "(FILE)",IDC_INS_FILE,55,25,155,8=0A=
     CONTROL         "Progress1",IDC_INS_DISKFULL,"msctls_progress32",=0A=
-                    PBS_SMOOTH | WS_BORDER,55,60,155,10=0A=
+                    PBS_SMOOTH | WS_BORDER,90,60,155,10=0A=
     CONTROL         "Progress1",IDC_INS_IPROGRESS,"msctls_progress32",=0A=
-                    PBS_SMOOTH | WS_BORDER,55,50,155,10=0A=
+                    PBS_SMOOTH | WS_BORDER,90,50,155,10=0A=
     CONTROL         "Progress1",IDC_INS_PPROGRESS,"msctls_progress32",=0A=
-                    PBS_SMOOTH | WS_BORDER,55,40,155,10=0A=
-    RTEXT           "Package",IDC_STATIC,5,40,45,8=0A=
-    RTEXT           "Total",IDC_STATIC,10,50,40,8=0A=
-    RTEXT           "Disk",IDC_STATIC,5,60,45,8=0A=
+                    PBS_SMOOTH | WS_BORDER,90,40,155,10=0A=
+    RTEXT           "Package",IDC_INS_BL_PACKAGE,40,40,45,8=0A=
+    RTEXT           "Total",IDC_INS_BL_TOTAL,45,50,40,8=0A=
+    RTEXT           "Disk",IDC_INS_BL_DISK,40,60,45,8=0A=
 END=0A=
=20=0A=
 IDD_PROXY_AUTH DIALOG DISCARDABLE  0, 0, 215, 95=0A=
@@ -210,8 +197,9 @@ BEGIN=0A=
     PUSHBUTTON      "Cancel",IDCANCEL,165,75,45,15=0A=
 END=0A=
=20=0A=
-IDD_SPLASH DIALOG DISCARDABLE  0, 0, 215, 95=0A=
-STYLE DS_MODALFRAME | DS_CENTER | WS_POPUP | WS_CAPTION | WS_SYSMENU=0A=
+IDD_SPLASH DIALOG DISCARDABLE  0, 0, 216, 94=0A=
+STYLE DS_MODALFRAME | DS_3DLOOK | DS_CENTER | WS_CHILD | WS_VISIBLE |=20=
=0A=
+    WS_CAPTION | WS_SYSMENU=0A=
 CAPTION "Cygwin Setup"=0A=
 FONT 8, "MS Sans Serif"=0A=
 BEGIN=0A=
@@ -223,17 +211,15 @@ BEGIN=0A=
                     8=0A=
     LTEXT           "http://sources.redhat.com/cygwin/",IDC_STATIC,55,50,1=
12,=0A=
                     8=0A=
-    DEFPUSHBUTTON   "&Next -->",IDOK,100,75,45,15=0A=
-    PUSHBUTTON      "Cancel",IDCANCEL,165,75,45,15=0A=
 END=0A=
=20=0A=
-IDD_CHOOSE DIALOG DISCARDABLE  0, 0, 429, 266=0A=
-STYLE DS_MODALFRAME | DS_3DLOOK | DS_CENTER | WS_POPUP | WS_CAPTION |=20=
=0A=
+IDD_CHOOSE DIALOG DISCARDABLE  0, 0, 430, 266=0A=
+STYLE DS_MODALFRAME | DS_3DLOOK | DS_CENTER | WS_CHILD | WS_CAPTION |=20=
=0A=
     WS_SYSMENU=0A=
 CAPTION "Cygwin Setup"=0A=
 FONT 8, "MS Sans Serif"=0A=
 BEGIN=0A=
-    ICON            IDI_CYGWIN,IDC_STATIC,0,2,21,20=0A=
+    ICON            IDI_CYGWIN,IDC_STATIC,0,2,20,20=0A=
     LTEXT           "Select packages to install",IDC_CHOOSE_INST_TEXT,125,=
5,=0A=
                     99,8=0A=
     CONTROL         "",IDC_LISTVIEW_POS,"Static",SS_BLACKFRAME | NOT=20=0A=
@@ -255,7 +241,8 @@ BEGIN=0A=
 END=0A=
=20=0A=
 IDD_DESKTOP DIALOG DISCARDABLE  0, 0, 215, 95=0A=
-STYLE DS_MODALFRAME | DS_CENTER | WS_POPUP | WS_CAPTION | WS_SYSMENU=0A=
+STYLE DS_MODALFRAME | DS_3DLOOK | DS_CENTER | WS_CHILD | WS_VISIBLE |=20=
=0A=
+    WS_CAPTION | WS_SYSMENU=0A=
 CAPTION "Cygwin Setup"=0A=
 FONT 8, "MS Sans Serif"=0A=
 BEGIN=0A=
@@ -264,12 +251,9 @@ BEGIN=0A=
                     BS_AUTOCHECKBOX,55,25,100,8=0A=
     CONTROL         "Add to &Start Menu",IDC_ROOT_MENU,"Button",=0A=
                     BS_AUTOCHECKBOX,55,40,100,8=0A=
-    DEFPUSHBUTTON   "&Next -->",IDOK,100,75,45,15=0A=
-    PUSHBUTTON      "Cancel",IDCANCEL,165,75,45,15=0A=
-    PUSHBUTTON      "<-- &Back",IDC_BACK,55,75,45,15=0A=
 END=0A=
=20=0A=
-IDD_FTP_AUTH DIALOGEX 0, 0, 215, 95=0A=
+IDD_FTP_AUTH DIALOG DISCARDABLE  0, 0, 215, 95=0A=
 STYLE DS_MODALFRAME | DS_CENTER | WS_POPUP | WS_CAPTION | WS_SYSMENU=0A=
 CAPTION "Cygwin Setup"=0A=
 FONT 8, "MS Sans Serif"=0A=
@@ -286,6 +270,15 @@ BEGIN=0A=
     PUSHBUTTON      "Cancel",IDCANCEL,165,75,45,15=0A=
 END=0A=
=20=0A=
+IDD_CHOOSER DIALOG DISCARDABLE  0, 0, 186, 90=0A=
+STYLE DS_MODALFRAME | DS_3DLOOK | WS_CHILD | WS_VISIBLE | WS_CAPTION |=20=
=0A=
+    WS_SYSMENU=0A=
+CAPTION "Cygwin Setup"=0A=
+FONT 8, "MS Sans Serif"=0A=
+BEGIN=0A=
+    LTEXT           "Don't look here",IDC_STATIC,25,38,134,8=0A=
+END=0A=
+=0A=
=20=0A=
 #ifdef APSTUDIO_INVOKED=0A=
 //////////////////////////////////////////////////////////////////////////=
///=0A=
@@ -339,9 +332,21 @@ CYGWIN.ICON             FILE    DISCARDA=0A=
 #ifdef APSTUDIO_INVOKED=0A=
 GUIDELINES DESIGNINFO DISCARDABLE=20=0A=
 BEGIN=0A=
+    IDD_LOCAL_DIR, DIALOG=0A=
+    BEGIN=0A=
+        RIGHTMARGIN, 215=0A=
+    END=0A=
+=0A=
+    IDD_SITE, DIALOG=0A=
+    BEGIN=0A=
+        RIGHTMARGIN, 215=0A=
+        BOTTOMMARGIN, 93=0A=
+    END=0A=
+=0A=
     IDD_NET, DIALOG=0A=
     BEGIN=0A=
-        BOTTOMMARGIN, 49=0A=
+        RIGHTMARGIN, 215=0A=
+        BOTTOMMARGIN, 60=0A=
     END=0A=
=20=0A=
     IDD_PROXY_AUTH, DIALOG=0A=
@@ -354,10 +359,23 @@ BEGIN=0A=
         BOTTOMMARGIN, 49=0A=
     END=0A=
=20=0A=
+    IDD_CHOOSE, DIALOG=0A=
+    BEGIN=0A=
+        RIGHTMARGIN, 429=0A=
+    END=0A=
+=0A=
     IDD_FTP_AUTH, DIALOG=0A=
     BEGIN=0A=
         BOTTOMMARGIN, 49=0A=
     END=0A=
+=0A=
+    IDD_CHOOSER, DIALOG=0A=
+    BEGIN=0A=
+        LEFTMARGIN, 7=0A=
+        RIGHTMARGIN, 179=0A=
+        TOPMARGIN, 7=0A=
+        BOTTOMMARGIN, 83=0A=
+    END=0A=
 END=0A=
 #endif    // APSTUDIO_INVOKED=0A=
=20=0A=
@@ -409,6 +427,7 @@ BEGIN=0A=
     IDS_DOWNLOAD_FAILED     "Unable to download %s"=0A=
     IDS_DOWNLOAD_INCOMPLETE "Download Incomplete.  Try again?"=0A=
     IDS_INSTALL_INCOMPLETE  "Installation incomplete.  Check /setup.log.fu=
ll for details"=0A=
+    IDS_VERSION_INFO        "Setup.exe version %1"=0A=
 END=0A=
=20=0A=
 #endif    // English (U.S.) resources=0A=
Index: resource.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/resource.h,v=0A=
retrieving revision 2.12=0A=
diff -p -u -r2.12 resource.h=0A=
--- resource.h	2001/06/30 01:37:55	2.12=0A=
+++ resource.h	2001/12/19 11:00:04=0A=
@@ -27,6 +27,7 @@=0A=
 #define IDS_DOWNLOAD_FAILED             25=0A=
 #define IDS_DOWNLOAD_INCOMPLETE         26=0A=
 #define IDS_INSTALL_INCOMPLETE          27=0A=
+#define IDS_VERSION_INFO                28=0A=
 #define IDD_ROOT                        101=0A=
 #define IDD_SOURCE                      102=0A=
 #define IDD_OTHER_URL                   103=0A=
@@ -53,6 +54,7 @@=0A=
 #define IDB_CHECK_NO                    124=0A=
 #define IDB_CHECK_NA                    125=0A=
 #define IDD_FTP_AUTH                    126=0A=
+#define IDD_CHOOSER                     127=0A=
 #define IDC_SOURCE_DOWNLOAD             1000=0A=
 #define IDC_SOURCE_NETINST              1001=0A=
 #define IDC_SOURCE_CWD                  1002=0A=
@@ -99,8 +101,11 @@=0A=
 #define IDC_DLS_PROGRESS_TEXT           1047=0A=
 #define IDC_DLS_PPROGRESS_TEXT          1048=0A=
 #define IDC_DLS_IPROGRESS_TEXT          1049=0A=
-#define IDC_CHOOSE_INST_TEXT      1050=0A=
+#define IDC_CHOOSE_INST_TEXT            1050=0A=
 #define IDC_CHOOSE_VIEWCAPTION          1051=0A=
+#define IDC_INS_BL_PACKAGE              1052=0A=
+#define IDC_INS_BL_TOTAL                1053=0A=
+#define IDC_INS_BL_DISK                 1054=0A=
 #define IDC_STATIC                      -1=0A=
=20=0A=
 // Next default values for new objects=0A=
@@ -109,9 +114,9 @@=0A=
 #ifndef APSTUDIO_READONLY_SYMBOLS=0A=
 #define _APS_NO_MFC                     1=0A=
 #define _APS_3D_CONTROLS                     1=0A=
-#define _APS_NEXT_RESOURCE_VALUE        127=0A=
+#define _APS_NEXT_RESOURCE_VALUE        128=0A=
 #define _APS_NEXT_COMMAND_VALUE         40003=0A=
-#define _APS_NEXT_CONTROL_VALUE         1052=0A=
+#define _APS_NEXT_CONTROL_VALUE         1055=0A=
 #define _APS_NEXT_SYMED_VALUE           101=0A=
 #endif=0A=
 #endif=0A=
Index: root.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/root.cc,v=0A=
retrieving revision 2.7=0A=
diff -p -u -r2.7 root.cc=0A=
--- root.cc	2001/11/13 01:49:32	2.7=0A=
+++ root.cc	2001/12/19 11:00:05=0A=
@@ -149,16 +149,16 @@ dialog_cmd (HWND h, int id, HWND hwndctl=0A=
=20=0A=
       if (!directory_is_absolute ())=0A=
 	{=0A=
-	  note (IDS_ROOT_ABSOLUTE);=0A=
+	  note (h, IDS_ROOT_ABSOLUTE);=0A=
 	  break;=0A=
 	}=0A=
=20=0A=
       if (directory_is_rootdir ())=0A=
-	if (IDNO =3D=3D yesno (IDS_ROOT_SLASH))=0A=
+	if (IDNO =3D=3D yesno (h, IDS_ROOT_SLASH))=0A=
 	  break;=0A=
=20=0A=
       if (directory_has_spaces ())=0A=
-	if (IDNO =3D=3D yesno (IDS_ROOT_SPACE))=0A=
+	if (IDNO =3D=3D yesno (h, IDS_ROOT_SPACE))=0A=
 	  break;=0A=
=20=0A=
       NEXT (IDD_LOCAL_DIR);=0A=
@@ -176,8 +176,8 @@ dialog_cmd (HWND h, int id, HWND hwndctl=0A=
   return 0;=0A=
 }=0A=
=20=0A=
-static BOOL CALLBACK=0A=
-dialog_proc (HWND h, UINT message, WPARAM wParam, LPARAM lParam)=0A=
+BOOL CALLBACK=0A=
+root_dialog_proc (HWND h, UINT message, WPARAM wParam, LPARAM lParam)=0A=
 {=0A=
   switch (message)=0A=
     {=0A=
@@ -190,17 +190,19 @@ dialog_proc (HWND h, UINT message, WPARA=0A=
   return FALSE;=0A=
 }=0A=
=20=0A=
+#if 0=0A=
 void=0A=
-do_root (HINSTANCE h)=0A=
+do_root (HINSTANCE h, HWND owner)=0A=
 {=0A=
   int rv =3D 0;=0A=
   if (!get_root_dir ())=0A=
     read_mounts ();=0A=
-  rv =3D DialogBox (h, MAKEINTRESOURCE (IDD_ROOT), 0, dialog_proc);=0A=
+  rv =3D DialogBox (h, MAKEINTRESOURCE (IDD_ROOT), owner, root_dialog_proc=
);=0A=
   if (rv =3D=3D -1)=0A=
-    fatal (IDS_DIALOG_FAILED);=0A=
+    fatal (owner, IDS_DIALOG_FAILED);=0A=
=20=0A=
   log (0, "root: %s %s %s", get_root_dir (),=0A=
        (root_text =3D=3D IDC_ROOT_TEXT) ? "text" : "binary",=0A=
        (root_scope =3D=3D IDC_ROOT_USER) ? "user" : "system");=0A=
 }=0A=
+#endif=0A=
Index: site.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/site.cc,v=0A=
retrieving revision 2.10=0A=
diff -p -u -r2.10 site.cc=0A=
--- site.cc	2001/12/03 22:22:09	2.10=0A=
+++ site.cc	2001/12/19 11:00:06=0A=
@@ -25,6 +25,7 @@ static const char *cvsid =3D=0A=
 #include <stdio.h>=0A=
 #include <stdlib.h>=0A=
 #include <string.h>=0A=
+#include <process.h>=0A=
=20=0A=
 #include "dialog.h"=0A=
 #include "resource.h"=0A=
@@ -38,6 +39,12 @@ static const char *cvsid =3D=0A=
=20=0A=
 #include "port.h"=0A=
=20=0A=
+#include "site.h"=0A=
+#include "propsheet.h"=0A=
+=0A=
+#include "threebar.h"=0A=
+extern ThreeBarProgressPage Progress;=0A=
+=0A=
 #define NO_IDX (-1)=0A=
 #define OTHER_IDX (-2)=0A=
=20=0A=
@@ -101,7 +108,12 @@ load_dialog (HWND h)=0A=
       int index =3D SendMessage (listbox, LB_FINDSTRING, (WPARAM) - 1,=0A=
 			       (LPARAM) site_list[n]->displayed_url);=0A=
       if (index !=3D LB_ERR)=0A=
-	SendMessage (listbox, LB_SELITEMRANGE, TRUE, (index << 16) | index);=0A=
+	  {=0A=
+        // Highlight the selected item=0A=
+	    SendMessage (listbox, LB_SELITEMRANGE, TRUE, (index << 16) | index);=
=0A=
+        // Make sure it's fully visible=0A=
+		SendMessage (listbox, LB_SETCARETINDEX, index, FALSE);=0A=
+	  }=0A=
     }=0A=
   check_if_enable_next (h);=0A=
 }=0A=
@@ -168,15 +180,16 @@ dialog_cmd (HWND h, int id, HWND hwndctl=0A=
       check_if_enable_next (h);=0A=
       break;=0A=
=20=0A=
+#if 0=0A=
     case IDOK:=0A=
       save_dialog (h);=0A=
       if (mirror_idx =3D=3D OTHER_IDX)=0A=
-	NEXT (IDD_OTHER_URL);=0A=
+	    NEXT (IDD_OTHER_URL);=0A=
       else=0A=
-	{=0A=
-	  save_site_url ();=0A=
-	  NEXT (IDD_S_LOAD_INI);=0A=
-	}=0A=
+	    {=0A=
+	      save_site_url ();=0A=
+	      NEXT (IDD_S_LOAD_INI);=0A=
+	    }=0A=
       break;=0A=
=20=0A=
     case IDC_BACK:=0A=
@@ -186,11 +199,13 @@ dialog_cmd (HWND h, int id, HWND hwndctl=0A=
=20=0A=
     case IDCANCEL:=0A=
       NEXT (0);=0A=
-      break;=0A=
-    }=0A=
+	break;=0A=
+#endif=0A=
+  }=0A=
   return 0;=0A=
 }=0A=
=20=0A=
+#if 0=0A=
 static BOOL CALLBACK=0A=
 dialog_proc (HWND h, UINT message, WPARAM wParam, LPARAM lParam)=0A=
 {=0A=
@@ -216,14 +231,16 @@ dialog_proc (HWND h, UINT message, WPARA=0A=
     }=0A=
   return FALSE;=0A=
 }=0A=
+#endif=0A=
=20=0A=
 static int=0A=
-get_site_list (HINSTANCE h)=0A=
+get_site_list (HINSTANCE h, HWND owner)=0A=
 {=0A=
   char mirror_url[1000];=0A=
+=0A=
   if (LoadString (h, IDS_MIRROR_LST, mirror_url, sizeof (mirror_url)) <=3D=
 0)=0A=
     return 1;=0A=
-  char *mirrors =3D get_url_to_string (mirror_url);=0A=
+  char *mirrors =3D get_url_to_string (mirror_url, owner);=0A=
   dismiss_url_status_dialog ();=0A=
   if (!mirrors)=0A=
     return 1;=0A=
@@ -320,13 +337,14 @@ get_saved_sites ()=0A=
=20=0A=
 }=0A=
=20=0A=
+#if 0=0A=
 void=0A=
-do_site (HINSTANCE h)=0A=
+do_site (HINSTANCE h, HWND owner)=0A=
 {=0A=
   int rv =3D 0;=0A=
=20=0A=
   if (all_site_list.number () =3D=3D 0)=0A=
-    if (get_site_list (h))=0A=
+    if (get_site_list (h, owner))=0A=
       {=0A=
 	NEXT (IDD_NET);=0A=
 	return;=0A=
@@ -334,10 +352,105 @@ do_site (HINSTANCE h)=0A=
=20=0A=
   get_saved_sites ();=0A=
=20=0A=
-  rv =3D DialogBox (h, MAKEINTRESOURCE (IDD_SITE), 0, dialog_proc);=0A=
+  rv =3D DialogBox (h, MAKEINTRESOURCE (IDD_SITE), owner, dialog_proc);=0A=
   if (rv =3D=3D -1)=0A=
-    fatal (IDS_DIALOG_FAILED);=0A=
+    fatal (owner, IDS_DIALOG_FAILED);=0A=
=20=0A=
   for (size_t n =3D 1; n <=3D site_list.number (); n++)=0A=
     log (0, "site: %s", site_list[n]->url);=0A=
+}=0A=
+#endif=0A=
+=0A=
+/////////////////////=0A=
+=0A=
+static void do_download_site_info_thread(void *p)=0A=
+{=0A=
+	HANDLE *context;=0A=
+	HINSTANCE hinst;=0A=
+	HWND h;=0A=
+	context =3D (HANDLE*)p;=0A=
+=09=0A=
+	hinst =3D (HINSTANCE)(context[0]);=0A=
+	h =3D (HWND)(context[1]);=0A=
+=0A=
+	if (all_site_list.number () =3D=3D 0)=0A=
+	{=0A=
+		if (get_site_list (hinst, h))=0A=
+		{=0A=
+			// Error: Couldn't download the site info.  Go back to the Net setup pa=
ge.=0A=
+			NEXT (IDD_NET);=0A=
+			return;=0A=
+		}=0A=
+	}=0A=
+=0A=
+	// Everything worked, go to the site select page=0A=
+	NEXT(IDD_SITE);=0A=
+=0A=
+	// Tell the progress page that we're done downloading=0A=
+	Progress.PostMessage(WM_APP_SITE_INFO_DOWNLOAD_COMPLETE, 0, next_dialog);=
=0A=
+=0A=
+	_endthread();=0A=
+}=0A=
+=0A=
+static HANDLE context[2];=0A=
+=0A=
+void=0A=
+do_download_site_info (HINSTANCE hinst, HWND owner)=0A=
+{=0A=
+=0A=
+	context[0] =3D hinst;=0A=
+	context[1] =3D owner;=0A=
+=0A=
+	_beginthread(do_download_site_info_thread, 0, context);=0A=
+=0A=
+}=0A=
+=0A=
+bool SitePage::Create()=0A=
+{=0A=
+	return PropertyPage::Create(NULL, dialog_cmd, IDD_SITE);=0A=
+}=0A=
+=0A=
+void SitePage::OnInit()=0A=
+{=0A=
+  HWND h =3D GetHWND();=0A=
+  int j;=0A=
+  HWND listbox;=0A=
+=0A=
+  get_saved_sites ();=0A=
+=0A=
+  listbox =3D GetDlgItem (IDC_URL_LIST);=0A=
+  for (size_t i =3D 1; i <=3D all_site_list.number (); i++)=0A=
+	{=0A=
+	  j =3D=0A=
+	    SendMessage (listbox, LB_ADDSTRING, 0,=0A=
+			 (LPARAM) all_site_list[i]->displayed_url);=0A=
+	  SendMessage (listbox, LB_SETITEMDATA, j, i);=0A=
+	}=0A=
+  j =3D SendMessage (listbox, LB_ADDSTRING, 0, (LPARAM) "Other URL");=0A=
+  SendMessage (listbox, LB_SETITEMDATA, j, OTHER_IDX);=0A=
+  load_dialog (h);=0A=
+}=0A=
+=0A=
+long SitePage::OnNext()=0A=
+{=0A=
+  HWND h =3D GetHWND();=0A=
+=20=20=0A=
+  save_dialog (h);=0A=
+  if (mirror_idx =3D=3D OTHER_IDX)=0A=
+	NEXT (IDD_OTHER_URL);=0A=
+  else=0A=
+	{=0A=
+	  save_site_url ();=0A=
+	  NEXT (IDD_S_LOAD_INI);=0A=
+=0A=
+    for (size_t n =3D 1; n <=3D site_list.number (); n++)=0A=
+      log (0, "site: %s", site_list[n]->url);=0A=
+=20=20=20=20=20=20=0A=
+    Progress.SetActivateTask(WM_APP_START_SETUP_INI_DOWNLOAD);=0A=
+	return IDD_INSTATUS;=0A=
+=0A=
+do_choose(GetInstance(), h);=0A=
+	}=0A=
+=0A=
+  return 0;=0A=
 }=0A=
Index: site.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/site.h,v=0A=
retrieving revision 2.1=0A=
diff -p -u -r2.1 site.h=0A=
--- site.h	2001/12/03 22:22:09	2.1=0A=
+++ site.h	2001/12/19 11:00:06=0A=
@@ -17,8 +17,25 @@=0A=
 #define _SITE_H_=0A=
=20=0A=
 /* required to parse this file */=0A=
-#include <strings.h>=0A=
+#include <string.h>=0A=
+#include <stdlib.h>=0A=
 #include "list.h"=0A=
+=0A=
+#include "proppage.h"=0A=
+=0A=
+class SitePage : public PropertyPage=0A=
+{=0A=
+public:=0A=
+	SitePage() {};=0A=
+	virtual ~SitePage() {};=0A=
+=0A=
+	bool Create();=0A=
+=09=0A=
+	void OnInit();=0A=
+	long OnNext();=0A=
+};=0A=
+=0A=
+void do_download_site_info (HINSTANCE h, HWND owner);=0A=
=20=0A=
 class site_list_type=0A=
 {=0A=
Index: source.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/source.cc,v=0A=
retrieving revision 2.8=0A=
diff -p -u -r2.8 source.cc=0A=
--- source.cc	2001/11/14 00:11:35	2.8=0A=
+++ source.cc	2001/12/19 11:00:06=0A=
@@ -30,6 +30,8 @@ static const char *cvsid =3D=0A=
 #include "msg.h"=0A=
 #include "log.h"=0A=
=20=0A=
+#include "source.h"=0A=
+=0A=
 static int rb[] =3D=0A=
   { IDC_SOURCE_NETINST, IDC_SOURCE_DOWNLOAD, IDC_SOURCE_CWD, 0 };=0A=
=20=0A=
@@ -57,65 +59,57 @@ dialog_cmd (HWND h, int id, HWND hwndctl=0A=
       save_dialog (h);=0A=
       break;=0A=
=20=0A=
-    case IDOK:=0A=
-      save_dialog (h);=0A=
-      if (source =3D=3D IDC_SOURCE_DOWNLOAD)=0A=
-	NEXT (IDD_LOCAL_DIR);=0A=
-      else=0A=
-	NEXT (IDD_ROOT);=0A=
-      break;=0A=
-=0A=
-    case IDC_BACK:=0A=
-      save_dialog (h);=0A=
-      NEXT (0);=0A=
-      break;=0A=
-=0A=
-    case IDCANCEL:=0A=
-      NEXT (0);=0A=
-      break;=0A=
-=0A=
     default:=0A=
       break;=0A=
     }=0A=
   return 0;=0A=
 }=0A=
=20=0A=
-static BOOL CALLBACK=0A=
-dialog_proc (HWND h, UINT message, WPARAM wParam, LPARAM lParam)=0A=
+bool SourcePage::Create()=0A=
 {=0A=
-  switch (message)=0A=
-    {=0A=
-    case WM_INITDIALOG:=0A=
-      load_dialog (h);=0A=
-      // Check to see if any radio buttons are selected. If not, select a =
default.=0A=
-      if (=0A=
-	  (!SendMessage=0A=
-	   (GetDlgItem (h, IDC_SOURCE_DOWNLOAD), BM_GETCHECK, 0,=0A=
+	return PropertyPage::Create(NULL, dialog_cmd, IDD_SOURCE);=0A=
+}=0A=
+=0A=
+void SourcePage::OnActivate()=0A=
+{=0A=
+  if (!source)=0A=
+    source =3D IDC_SOURCE_NETINST;=0A=
+  load_dialog (GetHWND());=0A=
+  // Check to see if any radio buttons are selected. If not, select a defa=
ult.=0A=
+  if (=0A=
+    (!SendMessage=0A=
+	(GetDlgItem (IDC_SOURCE_DOWNLOAD), BM_GETCHECK, 0,=0A=
 	    0) =3D=3D BST_CHECKED)=0A=
-	  && (!SendMessage (GetDlgItem (h, IDC_SOURCE_CWD), BM_GETCHECK, 0, 0)=0A=
+	  && (!SendMessage (GetDlgItem (IDC_SOURCE_CWD), BM_GETCHECK, 0, 0)=0A=
 	      =3D=3D BST_CHECKED))=0A=
 	{=0A=
-	  SendMessage (GetDlgItem (h, IDC_SOURCE_NETINST), BM_SETCHECK,=0A=
+	  SendMessage (GetDlgItem (IDC_SOURCE_NETINST), BM_SETCHECK,=0A=
 		       BST_CHECKED, 0);=0A=
 	}=0A=
-      return FALSE;=0A=
-    case WM_COMMAND:=0A=
-      return HANDLE_WM_COMMAND (h, wParam, lParam, dialog_cmd);=0A=
-    }=0A=
-  return FALSE;=0A=
 }=0A=
=20=0A=
-void=0A=
-do_source (HINSTANCE h)=0A=
+long SourcePage::OnNext()=0A=
 {=0A=
-  int rv =3D 0;=0A=
-  /* source =3D IDC_SOURCE_CWD; */=0A=
-  if (!source)=0A=
-    source =3D IDC_SOURCE_NETINST;=0A=
-  rv =3D DialogBox (h, MAKEINTRESOURCE (IDD_SOURCE), 0, dialog_proc);=0A=
-  if (rv =3D=3D -1)=0A=
-    fatal (IDS_DIALOG_FAILED);=0A=
+  HWND h =3D GetHWND();=0A=
=20=0A=
+  save_dialog (h);=0A=
+  if (source =3D=3D IDC_SOURCE_DOWNLOAD)=0A=
+  {=0A=
+	  // If all we're doing is downloading,skip the root directory page=0A=
+    return IDD_LOCAL_DIR;=0A=
+  }=0A=
+=0A=
+  return 0;=0A=
+}=0A=
+=0A=
+long SourcePage::OnBack()=0A=
+{=0A=
+  save_dialog (GetHWND());=0A=
+  return 0;=0A=
+}=0A=
+=0A=
+void SourcePage::OnDeactivate()=0A=
+{=0A=
   log (0, "source: %s",=0A=
        (source =3D=3D IDC_SOURCE_DOWNLOAD) ? "download" :=0A=
        (source =3D=3D IDC_SOURCE_NETINST) ? "network install" : "from cwd"=
);=0A=
Index: splash.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/splash.cc,v=0A=
retrieving revision 2.6=0A=
diff -p -u -r2.6 splash.cc=0A=
--- splash.cc	2001/11/13 01:49:32	2.6=0A=
+++ splash.cc	2001/12/19 11:00:06=0A=
@@ -1,5 +1,5 @@=0A=
 /*=0A=
- * Copyright (c) 2000, Red Hat, Inc.=0A=
+ * Copyright (c) 2001, Gary R. Van Sickle.=0A=
  *=0A=
  *     This program is free software; you can redistribute it and/or modif=
y=0A=
  *     it under the terms of the GNU General Public License as published b=
y=0A=
@@ -9,71 +9,29 @@=0A=
  *     A copy of the GNU General Public License can be found at=0A=
  *     http://www.gnu.org/=0A=
  *=0A=
- * Written by DJ Delorie <dj@cygnus.com>=0A=
+ * Written by Gary R. Van Sickle <g.r.vansickle@worldnet.att.net>=0A=
  *=0A=
  */=0A=
=20=0A=
-/* The purpose of this file is to display the program name, version,=0A=
-   copyright notice, and project URL. */=0A=
+// This is the implementation of the SplashPage class.  Since the splash p=
age=0A=
+// has little to do, there's not much here.=0A=
=20=0A=
-#if 0=0A=
-static const char *cvsid =3D=0A=
-  "\n%%% $Id: splash.cc,v 2.6 2001/11/13 01:49:32 rbcollins Exp $\n";=0A=
-#endif=0A=
-=0A=
-#include "win32.h"=0A=
 #include <stdio.h>=0A=
-#include "dialog.h"=0A=
-#include "resource.h"=0A=
-#include "msg.h"=0A=
 #include "version.h"=0A=
+#include "resource.h"=0A=
+#include "cistring.h"=0A=
+#include "splash.h"=0A=
=20=0A=
-static void=0A=
-load_dialog (HWND h)=0A=
+bool SplashPage::Create()=0A=
 {=0A=
-  char buffer[100];=0A=
-  HWND v =3D GetDlgItem (h, IDC_VERSION);=0A=
-  sprintf (buffer, "Setup.exe version %s",=0A=
-	   version[0] ? version : "[unknown]");=0A=
-  SetWindowText (v, buffer);=0A=
+  return PropertyPage::Create(IDD_SPLASH);=0A=
 }=0A=
=20=0A=
-static BOOL=0A=
-dialog_cmd (HWND h, int id, HWND hwndctl, UINT code)=0A=
+void SplashPage::OnInit()=0A=
 {=0A=
-  switch (id)=0A=
-    {=0A=
-=0A=
-    case IDOK:=0A=
-      NEXT (IDD_SOURCE);=0A=
-      break;=0A=
-=0A=
-    case IDCANCEL:=0A=
-      NEXT (0);=0A=
-      break;=0A=
-    }=0A=
-  return 0;=0A=
-}=0A=
+  cistring ver;=0A=
=20=0A=
-static BOOL CALLBACK=0A=
-dialog_proc (HWND h, UINT message, WPARAM wParam, LPARAM lParam)=0A=
-{=0A=
-  switch (message)=0A=
-    {=0A=
-    case WM_INITDIALOG:=0A=
-      load_dialog (h);=0A=
-      return TRUE;=0A=
-    case WM_COMMAND:=0A=
-      return HANDLE_WM_COMMAND (h, wParam, lParam, dialog_cmd);=0A=
-    }=0A=
-  return FALSE;=0A=
-}=0A=
+  ver.Format(IDS_VERSION_INFO, version[0] ? version : "[unknown]");=0A=
=20=0A=
-void=0A=
-do_splash (HINSTANCE h)=0A=
-{=0A=
-  int rv =3D 0;=0A=
-  rv =3D DialogBox (h, MAKEINTRESOURCE (IDD_SPLASH), 0, dialog_proc);=0A=
-  if (rv =3D=3D -1)=0A=
-    fatal (IDS_DIALOG_FAILED);=0A=
+  SetWindowText (GetDlgItem(IDC_VERSION), ver.c_str());=0A=
 }=0A=

------=_NextPart_000_000E_01C1884B.B7340910
Content-Type: application/octet-stream;
	name="setup.ChangeLog"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="setup.ChangeLog"
Content-length: 10702

2001-12-18  Gary R. Van Sickle  <g.r.vansickle@worldnet.att.net>=0A=
=0A=
	* window.h (Window): New file, new class.=0A=
	* window.cc (Window): New file, new class.=0A=
=0A=
	* threebar.h (ThreeBarProgressPage): New file, new class.=0A=
	* threebar.cc (ThreeBarProgressPage): New file, new class.=0A=
=0A=
	* splash.h (SplashPage): New file, new class.=0A=
	* splash.cc (SplashPage): Replace file with implementation of new class.=
=0A=
=0A=
	* source.h (SourcePage): New file, new class.=0A=
	* source.cc (SourcePage): Add class implementation to this file.=0A=
	(do_source): Removed, functionality subsumed by SourcePage::Create() and=
=0A=
	SourcePage::OnDeactivate().=0A=
	(dialog_proc): Removed, functionality subsumed by SourcePage::OnActivate()=
.=0A=
=0A=
	* site.h (SitePage): Add class declaration.=0A=
	* site.cc (SitePage): Add class implementation.=0A=
	(do_download_site_info_thread): New function.=0A=
	(context): Context info for do_download_site_info_thread().=0A=
	(do_download_site_info): New function.=0A=
	(SitePage::Create): New member function.=0A=
	(SitePage::OnInit): New member function.=0A=
	(SitePage::OnNext): New member function.=0A=
	(dialog_cmd): #if 0'd out OK, BACK, and CANCEL cases, now handled by SiteP=
age=0A=
	members.  Saved temporarily for reference.=0A=
	(dialog_proc): #if 0'd out, now handled by SitePage::OnInit and base class=
=0A=
	functionality.  Saved temporarily for reference.=0A=
	(do_site): #if 0'd out, now handled by do_download_site_info_thread() and=
=0A=
	SitePage::OnNext functionality.  Saved temporarily for reference.=0A=
=0A=
	* root.cc (dialog_cmd): Pass parent HWND parameter to note(), yesno().=0A=
	(dialog_proc): renamed to root_dialog_proc to allow it to be exported to=
=0A=
	main.cc without collisions.=0A=
	(do_root): Add parent HWND parameter.  Then #if 0'ed out since it's no=0A=
	longer used, saved temporarily for reference.=0A=
	(do_root): Pass parent HWND parameter to DialogBox(), fatal().=0A=
=0A=
	* propsheet.h (PropSheet): New file, new class.=0A=
	* propsheet.cc (PropSheet): New file, new class.=0A=
=0A=
	* proppage.h (PropertyPage): New file, new class.=0A=
	* proppage.cc (PropertyPage): New file, new class.=0A=
=0A=
	* postinstall.cc (do_postinstall): Add owner parameter.=0A=
=0A=
	* package_meta.h (sdesc): New member.=0A=
	* package_meta.cc (packagemeta::SDesc): Return sdesc instead of versions[1=
]->SDesc().=0A=
	Prevents malformed setup.inis with no version info from crashing the progr=
am.=0A=
=0A=
	* other.cc (do_other): Add owner parameter.=0A=
=0A=
	* nio-file.cc (NetIO::Purl): Pass NULL parent param to note().=0A=
	* nio-ftp.cc (NetIO_FTP::NetIO_FTP): Pass NULL parent param to get_ftp_aut=
h().=0A=
	* nio-http.cc (retry_get): Pass NULL parent param to get_auth(), get_proxy=
_auth(),=0A=
	and get_ftp_auth().=0A=
	* nio-ie5.cc (NetIO::_url): Pass NULL parent param to note(), get_auth(), =
get_proxy_auth().=0A=
=0A=
	* netio.h (get_auth, get_proxy_auth, get_ftp_auth): Add owner param.=0A=
	* netio.cc (auth_common, NetIO::get_auth, NetIO::get_proxy_auth, NetIO::ge=
t_ftp_auth)=0A=
	(auth_common): Add owner param.  Pass owner param to DialogBox.=0A=
	(NetIO::get_auth, NetIO::get_proxy_auth, NetIO::get_ftp_auth): Pass owner =
param to=0A=
	auth_common().=0A=
=0A=
	* net.h (NetPage): New file, new class.=0A=
	* net.cc (net.h, threebar.h): Add includes.=0A=
	(Progress): Add extern.=0A=
	(dialog_cmd): #if 0'd out IDOK, IDC_BACK, and IDCANCEL cases, now handled =
by property=0A=
	sheet logic.  Saved temporarily for reference.=0A=
	(dialog_proc, do_net): #if 0'd out, saved temporarily for reference.=0A=
	(NetPage::Create, NetPage::OnInit, NetPage::OnDeactivate, NetPage::OnNext,=
 NetPage::OnBack):=0A=
	New implementation of NetPage class members.=0A=
=0A=
	* msg.h (fatal, note, yesno): Add owner param.=0A=
	* msg.c (fatal, note, yesno, mbox): Add owner param.=0A=
	(mbox): Comment out MB_TOPMOST from MessageBox call.  Unnecessary and wron=
g now that we=0A=
	have a parent.=0A=
=0A=
	* main.cc (commctrl.h, proppage.h, propsheet.h, splash.h, source.h, locald=
ir.h)=0A=
	(net.h, site.h, chooser.h, threebar.h, desktop.h): Add headers.=0A=
	(root_dialog_proc): extern this into here.=0A=
	(Progress): Progress dialog defined here, used in several other files.=0A=
	(main): Instantiate	and Create Splash, Source, Root, LocalDir, Net, Site,=
=0A=
	Chooser, Desktop pages and MainWindow sheet.  Call InitCommonControls()=0A=
	to make sure Windows is	set up for our use of property sheets. Add pages t=
o sheet.=0A=
	Call MainWindow.Create() to "DoModal".  #if 0'd out main loop, that logic =
is=0A=
	now handled by the PropSheet class.=0A=
=0A=
	* log.cc (log_save): Pass NULL parent to fatal().=0A=
	(exit_setup): Pass NULL parent to note().=0A=
=0A=
	* localdir.h (LocalDirPage): New file, new class.=0A=
	* localdir.cc (localdir.h): New include.=0A=
	(dialog_cmd): #if 0'd out IDOK, IDC_BACK, and IDCANCEL cases, now handled =
by property=0A=
	sheet logic.  Saved temporarily for reference.=0A=
	(dialog_proc): #if 0'd out, now handled by LocalDirPage::OnInit().=0A=
	Saved temporarily for reference.=0A=
	(do_local_dir): #if 0'd out, now handled by property sheet logic.=0A=
	Saved temporarily for reference.=0A=
	(LocalDirPage::Create, LocalDirPage::OnInit, LocalDirPage::OnActivate)=0A=
	(LocalDirPage::OnNext, LocalDirPage::OnBack): Implementation of LocalDirPa=
ge.=0A=
=0A=
	* install.cc (process.h, threebar.h): New includes.=0A=
	(Progress): externed into this file.=0A=
	(ins_dialog, ins_action, ins_pkgname, ins_filename, ins_pprogress, ins_ipr=
ogress)=0A=
	(ins_diskfull, init_event): Removed, now handled by ThreeBarProgressPage.=
=0A=
	(dialog_cmd, dialog_proc, dialog): Removed, handled in ThreeBarProgressPag=
e.=0A=
	(init_dialog): Removed all mention of the above ins_* handles.  Now handle=
d=0A=
	in ThreeBarProgressPage.  Altered SetWindowText()s to call ThreeBarProgres=
sPage=0A=
	instance Progress directly.=0A=
	(progress): Altered bar update logic to call ThreeBarProgressPage instance=
=0A=
	Progress directly.=0A=
	(uninstall_one): Altered SetWindowText()s to call ThreeBarProgressPage=0A=
	instance Progress directly.=0A=
	(install_one_source): Altered SetWindowText()s to call ThreeBarProgressPag=
e=0A=
	instance Progress directly. Pass NULL parent to note().=0A=
	(do_install_thread): Renamed from do_install(), added owner param.  Altere=
d=20=0A=
	SetWindowText()s to call ThreeBarProgressPage instance Progress directly.=
=0A=
	Removed dismiss_url_status_dialog() call, no longer necessary.  Removed=0A=
	ShowWindow(<hide>) call, also unnecessary now.  Pass owner handle to fatal=
().=0A=
	(do_install_reflector): New function.=0A=
	(do_install): New function.=0A=
=0A=
	* iniparse.y (simple_line): Set new sdesc member of package_meta.=0A=
=0A=
	* ini.cc (process.h, threebar.h): New includes.=0A=
	(Progress): externed into this file.=0A=
	(find_routine): Pass NULL parent to note().=0A=
	(do_local_ini): Add owner param.=0A=
	(do_remote_ini): Add owner param.  Pass owner to get_url_to_membuf() and n=
ote().=0A=
	(do_ini_thread): Renamed from do_ini().  Add owner param.  Pass owner to=
=0A=
	do_local_ini(), do_remote_ini(), yesno(), and note().  Set next_dialog to=
=0A=
	IDD_CHOOSER on exit.=0A=
	(do_ini_thread_reflector): New function.=0A=
	(context): Context for do_ini_thread.=0A=
	(do_ini): New function.=0A=
=0A=
	* geturl.h (get_url_to_membuf, get_url_to_string, get_url_to_file): Add ow=
ner param.=0A=
	* geturl.cc (gw_dialog, gw_url, gw_rate, gw_progress, gw_pprogress, gw_ipr=
ogress)=0A=
	(gw_progress_text, gw_pprogress_text, gw_iprogress_text, init_event): Remo=
ved.=0A=
	(threebar.h): New include.=0A=
	(Progress): externed into this file.=0A=
	(dialog_cmd, dialog_proc, dialog): Removed, handled by ThreeBarProgressPag=
e now.=0A=
	(init_dialog): Removed "if (gw_dialog =3D=3D 0)" clause.  Altered SetWindo=
wText()s=0A=
	and bar setting SendMessage()s to call ThreeBarProgressPage instance Progr=
ess=0A=
	directly.  Removed "one bar only" logic, this is now handled explicitly in=
=0A=
	the ThreeBarProgressPage class.=0A=
	(progress): Altered bar and text update logic to call ThreeBarProgressPage=
 instance=0A=
	Progress directly.  Changed kbps calculation to floating point and now pri=
nt out a=0A=
	single decimal place.=0A=
	(get_url_to_membuf): Add owner param.  Pass it to init_dialog.=0A=
	(get_url_to_string): Add owner param.  Pass it to get_url_to_membuf.=0A=
	(get_url_to_file): Add owner param.  Pass it to init_dialog. Altered bar u=
pdate=0A=
	logic to call ThreeBarProgressPage instance Progress directly.=0A=
	(dismiss_url_status_dialog):  Gutted.  Probably can be deleted.=0A=
=09=0A=
	* fromcwd.cc (do_fromcwd): Add owner param.=0A=
=0A=
	* download.cc (process.h, threebar.h): New includes.=0A=
	(Progress): externed into this file.=0A=
	(download_one): Add owner param.  Pass it to get_url_to_file().=0A=
	(do_download_thread): Renamed from do_download.  Add owner param.  When ca=
lculating=0A=
	total_download_bytes, take binpicked and srcpicked into account.  Remove c=
all to=0A=
	dismiss_url_status_dialog(), no longer needed.  Pass owner handle to=0A=
	download_one() and yesno().=0A=
	(do_download_reflector, do_download): New functions.=0A=
	(context): Context for do_download_thread().=0A=
=0A=
	* dialog.h (D(x)): Add owner param.=0A=
=0A=
	* desktop.h (DesktopSetupPage): New file, new class.=0A=
	* desktop.cc (desktop.h): Add include.=0A=
	(dialog_proc, do_desktop): Remove, now handled in DesktopSetupPage::OnInit=
().=0A=
	(dialog_cmd): Remove IDOK, IDC_BACK, and IDCANCEL cases, handled in=0A=
	DesktopSetupPage::OnFinish(), DesktopSetupPage::OnBack(), and PropSheet re=
sp.=0A=
	(DesktopSetupPage::Create, DesktopSetupPage::OnInit, DesktopSetupPage::OnB=
ack)=0A=
	(DesktopSetupPage::OnFinish): Implementation of DesktopSetupPage.=0A=
=0A=
	* cistring.h: New file, new class.=0A=
	* cistring.cc: New file, new class.=0A=
=0A=
	* chooser.h: New file, new class.=0A=
	* chooser.cc: New file, new class.=0A=
=0A=
	* choose.cc (do_choose): Add owner param.  Pass it to DialogBox() and fata=
l().=0A=
=0A=
	* res.rc (IDS_VERSION_INFO): New string.=0A=
	(IDD_CHOOSER): New, bare template for the almost-functionless chooser page=
 which=0A=
	launches the real chooser.=0A=
	(IDD_SOURCE, IDD_LOCAL_DIR, IDD_ROOT, IDD_SITE, IDD_OTHER_URL, IDD_DLSTATU=
S)=0A=
	(IDD_INSTATUS, IDD_SPLASH, IDD_CHOOSE, IDD_DESKTOP): Changed WS_POPUP to W=
S_CHILD.=0A=
	Numerous positioning/size changes throughout.=0A=
=0A=
	* Makefile.in (ALL_DEP_LDLIBS): Add linkage to $(w32api_lib)/libcomctl32.a=
.=0A=
	(OBJS): Add chooser.o, cistring.o, proppage.o, propsheet.o, threebar.o,=0A=
	and window.o.=0A=
=0A=

------=_NextPart_000_000E_01C1884B.B7340910--
