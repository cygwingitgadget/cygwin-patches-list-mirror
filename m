Return-Path: <cygwin-patches-return-1615-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 1506 invoked by alias); 20 Dec 2001 12:38:48 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1393 invoked from network); 20 Dec 2001 12:38:43 -0000
Message-ID: <023b01c18953$25d03ee0$0200a8c0@lifelesswks>
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Gary R. Van Sickle" <g.r.vansickle@worldnet.att.net>,
	<cygwin-patches@sourceware.cygnus.com>
References: <NCBBIHCHBLCMLBLOBONKIEAFCIAA.g.r.vansickle@worldnet.att.net>
Subject: Re: [PATCH] Update 2 - Setup.exe property sheet patch
Date: Thu, 08 Nov 2001 08:37:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0238_01C189AF.58229CB0"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-OriginalArrivalTime: 20 Dec 2001 12:38:26.0060 (UTC) FILETIME=[382934C0:01C18953]
X-SW-Source: 2001-q4/txt/msg00147.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_0238_01C189AF.58229CB0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 309

Hmm, houston we have a problem. Local installs are busted.

I've attached the actual patch against CVS head (i've run indent on
everything, so even with the new files in it's only 120Kb now.

Don't worry about fixing local installs just yet - lets get the thing
committed. But As soon as it's in ... :}.

Rob

------=_NextPart_000_0238_01C189AF.58229CB0
Content-Type: application/octet-stream;
	name="Property.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="Property.patch"
Content-length: 150456

? ar=0A=
? copyandspawn.cc=0A=
? foo.patch=0A=
? Guidelines.txt=0A=
? io_stream-net_latest.diff=0A=
? io_stream-net_latest_Makefile.in.diff=0A=
? pavel20011206.patch=0A=
? Proprety.patch=0A=
? replaceself.patch=0A=
? setupfix.patch=0A=
? URLParser.cc=0A=
? URLParser.h=0A=
Index: Makefile.in=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/Makefile.in,v=0A=
retrieving revision 2.39=0A=
diff -u -p -r2.39 Makefile.in=0A=
--- Makefile.in	2001/12/20 11:49:53	2.39=0A=
+++ Makefile.in	2001/12/20 12:35:57=0A=
@@ -87,6 +87,7 @@ OBJS =3D \=0A=
 	autoload.o \=0A=
 	category.o \=0A=
 	choose.o \=0A=
+	cistring.o \=0A=
 	compress.o \=0A=
 	compress_bz.o \=0A=
 	compress_gz.o \=0A=
@@ -129,6 +130,8 @@ OBJS =3D \=0A=
 	package_source.o \=0A=
 	package_version.o \=0A=
 	postinstall.o \=0A=
+	proppage.o \=0A=
+	propsheet.o \=0A=
 	res.o \=0A=
 	rfc1738.o \=0A=
 	root.o \=0A=
@@ -138,7 +141,9 @@ OBJS =3D \=0A=
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
retrieving revision 2.79=0A=
diff -u -p -r2.79 choose.cc=0A=
--- choose.cc	2001/12/20 11:49:53	2.79=0A=
+++ choose.cc	2001/12/20 12:35:59=0A=
@@ -36,6 +36,7 @@ static const char *cvsid =3D=0A=
 #include <stdlib.h>=0A=
 #include <io.h>=0A=
 #include <ctype.h>=0A=
+#include <process.h>=0A=
=20=0A=
 #include "dialog.h"=0A=
 #include "resource.h"=0A=
@@ -47,6 +48,7 @@ static const char *cvsid =3D=0A=
 #include "find.h"=0A=
 #include "filemanip.h"=0A=
 #include "io_stream.h"=0A=
+#include "propsheet.h"=0A=
 #include "choose.h"=0A=
 #include "category.h"=0A=
=20=0A=
@@ -55,6 +57,8 @@ static const char *cvsid =3D=0A=
 #include "package_version.h"=0A=
=20=0A=
 #include "port.h"=0A=
+#include "threebar.h"=0A=
+extern ThreeBarProgressPage Progress;=0A=
=20=0A=
 #define alloca __builtin_alloca=0A=
=20=0A=
@@ -1089,6 +1093,7 @@ dialog_proc (HWND h, UINT message, WPARA=0A=
       r.top +=3D 2;=0A=
       r.bottom -=3D 2;=0A=
       create_listview (h, &r);=0A=
+=0A=
 #if 0=0A=
       load_dialog (h);=0A=
 #endif=0A=
@@ -1193,7 +1198,7 @@ scan_downloaded_files ()=0A=
 }=0A=
=20=0A=
 void=0A=
-do_choose (HINSTANCE h)=0A=
+do_choose (HINSTANCE h, HWND owner)=0A=
 {=0A=
   int rv;=0A=
=20=0A=
@@ -1217,9 +1222,9 @@ do_choose (HINSTANCE h)=0A=
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
@@ -1302,4 +1307,63 @@ do_choose (HINSTANCE h)=0A=
 	}=0A=
 #endif=0A=
     }=0A=
+}=0A=
+=0A=
+#define WM_APP_START_CHOOSE        WM_APP+0=0A=
+#define WM_APP_CHOOSE_IS_FINISHED  WM_APP+1=0A=
+=0A=
+extern void=0A=
+do_choose (HINSTANCE h, HWND owner);=0A=
+=0A=
+void do_choose_thread(void *p)=0A=
+{=0A=
+	ChooserPage *cp;=0A=
+=0A=
+	cp =3D static_cast<ChooserPage*>(p);=0A=
+=0A=
+	do_choose(cp->GetInstance(), cp->GetHWND());=0A=
+=0A=
+	cp->PostMessage(WM_APP_CHOOSE_IS_FINISHED);=0A=
+=0A=
+	_endthread();=0A=
+}=0A=
+=0A=
+bool ChooserPage::Create()=0A=
+{=0A=
+  return PropertyPage::Create(IDD_CHOOSER);=0A=
+}=0A=
+=0A=
+void ChooserPage::OnActivate()=0A=
+{=0A=
+  GetOwner()->SetButtons(0);=0A=
+  PostMessage(WM_APP_START_CHOOSE);=0A=
+}=0A=
+=0A=
+bool ChooserPage::OnMessageApp(UINT uMsg, WPARAM wParam, LPARAM lParam)=0A=
+{=0A=
+	switch(uMsg)=0A=
+	{=0A=
+	case WM_APP_START_CHOOSE:=0A=
+		{=0A=
+			// Start the chooser thread.=0A=
+			_beginthread(do_choose_thread, 0, this);=0A=
+			break;=0A=
+		}=0A=
+	case WM_APP_CHOOSE_IS_FINISHED:=0A=
+		{=0A=
+			if(next_dialog =3D=3D 0)=0A=
+			{=0A=
+				// Cancel=0A=
+				GetOwner()->PressButton(PSBTN_CANCEL);=0A=
+				break;=0A=
+			}=0A=
+			Progress.SetActivateTask(WM_APP_START_DOWNLOAD);=0A=
+			GetOwner()->SetActivePageByID(IDD_INSTATUS);=0A=
+			break;=0A=
+		}=0A=
+	default:=0A=
+		return false;=0A=
+		break;=0A=
+	}=0A=
+	return true;=0A=
 }=0A=
Index: choose.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/choose.h,v=0A=
retrieving revision 2.9=0A=
diff -u -p -r2.9 choose.h=0A=
--- choose.h	2001/12/20 11:49:53	2.9=0A=
+++ choose.h	2001/12/20 12:35:59=0A=
@@ -16,6 +16,8 @@=0A=
 #ifndef _CHOOSE_H_=0A=
 #define _CHOOSE_H_=0A=
=20=0A=
+#include "proppage.h"=0A=
+=0A=
 class Category;=0A=
 class packagemeta;=0A=
=20=0A=
@@ -195,5 +197,18 @@ private:=0A=
   void set_headers ();=0A=
   void init_headers (HDC dc);=0A=
 };=0A=
+=0A=
+class ChooserPage : public PropertyPage=0A=
+{=0A=
+public:=0A=
+	ChooserPage() {};=0A=
+	virtual ~ChooserPage() {};=0A=
+=09=0A=
+	virtual bool OnMessageApp(UINT uMsg, WPARAM wParam, LPARAM lParam);=0A=
+=09=0A=
+	bool Create();=0A=
+	virtual void OnActivate();=0A=
+};=0A=
+=0A=
 #endif /* __cplusplus */=0A=
 #endif /* _CHOOSE_H_ */=0A=
Index: cistring.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: cistring.cc=0A=
diff -N cistring.cc=0A=
--- /dev/null	Tue May  5 13:32:27 1998=0A=
+++ cistring.cc	Thu Dec 20 04:35:59 2001=0A=
@@ -0,0 +1,52 @@=0A=
+/*=0A=
+ * Copyright (c) 2001, Gary R. Van Sickle.=0A=
+ *=0A=
+ *     This program is free software; you can redistribute it and/or modif=
y=0A=
+ *     it under the terms of the GNU General Public License as published b=
y=0A=
+ *     the Free Software Foundation; either version 2 of the License, or=
=0A=
+ *     (at your option) any later version.=0A=
+ *=0A=
+ *     A copy of the GNU General Public License can be found at=0A=
+ *     http://www.gnu.org/=0A=
+ *=0A=
+ * Written by Gary R. Van Sickle <g.r.vansickle@worldnet.att.net>=0A=
+ *=0A=
+ */=0A=
+=0A=
+// Yep, another string class=0A=
+=0A=
+#include "cistring.h"=0A=
+#include <stdlib.h>=0A=
+=0A=
+DWORD=0A=
+cistring::Format (UINT i, ...)=0A=
+{=0A=
+  TCHAR FormatStringBuffer[256];=0A=
+  TCHAR *Buff;=0A=
+  va_list arglist;=0A=
+  DWORD numchars;=0A=
+=0A=
+  // Get the string from the stringtable (FormatMessage() can only work wi=
th=0A=
+  // literal strings or *message*table entries, which are different for so=
me=0A=
+  // inexplicable reason).=0A=
+  LoadString (GetModuleHandle (NULL), i, FormatStringBuffer, 256);=0A=
+=0A=
+  va_start (arglist, i);=0A=
+  numchars =3D::=0A=
+    FormatMessage (FORMAT_MESSAGE_ALLOCATE_BUFFER |=0A=
+		   FORMAT_MESSAGE_FROM_STRING, FormatStringBuffer, i, 0,=0A=
+		   (LPTSTR) & Buff, 0, &arglist);=0A=
+  va_end (arglist);=0A=
+=0A=
+  if (numchars =3D=3D 0)=0A=
+    {=0A=
+      // Something went wrong.=0A=
+      return 0;=0A=
+    }=0A=
+=0A=
+  buffer =3D new TCHAR[(numchars + 1) * sizeof (TCHAR)];=0A=
+  memcpy (buffer, Buff, (numchars + 1) * sizeof (TCHAR));=0A=
+  LocalFree (Buff);=0A=
+=0A=
+  return numchars;=0A=
+}=0A=
Index: cistring.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: cistring.h=0A=
diff -N cistring.h=0A=
--- /dev/null	Tue May  5 13:32:27 1998=0A=
+++ cistring.h	Thu Dec 20 04:35:59 2001=0A=
@@ -0,0 +1,41 @@=0A=
+/*=0A=
+ * Copyright (c) 2001, Gary R. Van Sickle.=0A=
+ *=0A=
+ *     This program is free software; you can redistribute it and/or modif=
y=0A=
+ *     it under the terms of the GNU General Public License as published b=
y=0A=
+ *     the Free Software Foundation; either version 2 of the License, or=
=0A=
+ *     (at your option) any later version.=0A=
+ *=0A=
+ *     A copy of the GNU General Public License can be found at=0A=
+ *     http://www.gnu.org/=0A=
+ *=0A=
+ * Written by Gary R. Van Sickle <g.r.vansickle@worldnet.att.net>=0A=
+ *=0A=
+ */=0A=
+=0A=
+// Yep, another string class=0A=
+=0A=
+#include <windows.h>=0A=
+=0A=
+class cistring=0A=
+{=0A=
+  TCHAR *buffer;=0A=
+public:=0A=
+    cistring ()=0A=
+  {=0A=
+    buffer =3D NULL;=0A=
+  };=0A=
+  cistring (const TCHAR * s);=0A=
+  ~cistring ()=0A=
+  {=0A=
+    if (buffer !=3D NULL)=0A=
+      delete[]buffer;=0A=
+  };=0A=
+=0A=
+  const TCHAR *c_str ()=0A=
+  {=0A=
+    return buffer;=0A=
+  };=0A=
+=0A=
+  DWORD Format (UINT i, ...);=0A=
+};=0A=
Index: desktop.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/desktop.cc,v=0A=
retrieving revision 2.19=0A=
diff -u -p -r2.19 desktop.cc=0A=
--- desktop.cc	2001/12/20 11:49:53	2.19=0A=
+++ desktop.cc	2001/12/20 12:35:59=0A=
@@ -48,6 +48,8 @@ static const char *cvsid =3D=0A=
 #include "package_meta.h"=0A=
 #include "package_version.h"=0A=
=20=0A=
+#include "desktop.h"=0A=
+=0A=
 static OSVERSIONINFO verinfo;=0A=
=20=0A=
 /* Lines starting with '@' are conditionals - include 'N' for NT,=0A=
@@ -444,56 +446,48 @@ dialog_cmd (HWND h, int id, HWND hwndctl=0A=
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
+bool=0A=
+DesktopSetupPage::Create ()=0A=
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
+  return PropertyPage::Create (NULL, dialog_cmd, IDD_DESKTOP);=0A=
 }=0A=
=20=0A=
 void=0A=
-do_desktop (HINSTANCE h)=0A=
+DesktopSetupPage::OnInit ()=0A=
 {=0A=
+  // FIXME: This CoInitialize() feels like it could be moved to startup in=
 main.cc.=0A=
   CoInitialize (NULL);=0A=
-=0A=
   verinfo.dwOSVersionInfoSize =3D sizeof (verinfo);=0A=
   GetVersionEx (&verinfo);=0A=
-=0A=
   root_desktop =3D=0A=
     check_desktop ("Cygwin", backslash (cygpath ("/cygwin.bat", 0)));=0A=
   root_menu =3D=0A=
     check_startmenu ("Cygwin Bash Shell",=0A=
 		     backslash (cygpath ("/cygwin.bat", 0)));=0A=
+  load_dialog (GetHWND ());=0A=
+}=0A=
=20=0A=
-  int rv =3D 0;=0A=
+long=0A=
+DesktopSetupPage::OnBack ()=0A=
+{=0A=
+  HWND h =3D GetHWND ();=0A=
+  save_dialog (h);=0A=
+  NEXT (IDD_CHOOSE);=0A=
+  return IDD_CHOOSER;=0A=
+}=0A=
+=0A=
+bool=0A=
+DesktopSetupPage::OnFinish ()=0A=
+{=0A=
+  HWND h =3D GetHWND ();=0A=
+  save_dialog (h);=0A=
+  do_desktop_setup ();=0A=
+  NEXT (IDD_S_POSTINSTALL);=0A=
+  do_postinstall (GetInstance (), h);=0A=
=20=0A=
-  rv =3D DialogBox (h, MAKEINTRESOURCE (IDD_DESKTOP), 0, dialog_proc);=0A=
-  if (rv =3D=3D -1)=0A=
-    fatal (IDS_DIALOG_FAILED);=0A=
+  return true;=0A=
 }=0A=
Index: desktop.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: desktop.h=0A=
diff -N desktop.h=0A=
--- /dev/null	Tue May  5 13:32:27 1998=0A=
+++ desktop.h	Thu Dec 20 04:35:59 2001=0A=
@@ -0,0 +1,41 @@=0A=
+#ifndef CINSTALL_DESKTOP_H=0A=
+#define CINSTALL_DESKTOP_H=0A=
+=0A=
+/*=0A=
+ * Copyright (c) 2001, Gary R. Van Sickle.=0A=
+ *=0A=
+ *     This program is free software; you can redistribute it and/or modif=
y=0A=
+ *     it under the terms of the GNU General Public License as published b=
y=0A=
+ *     the Free Software Foundation; either version 2 of the License, or=
=0A=
+ *     (at your option) any later version.=0A=
+ *=0A=
+ *     A copy of the GNU General Public License can be found at=0A=
+ *     http://www.gnu.org/=0A=
+ *=0A=
+ * Written by Gary R. Van Sickle <g.r.vansickle@worldnet.att.net>=0A=
+ *=0A=
+ */=0A=
+=0A=
+// This is the header for the DesktopSetupPage class.  Allows selection=0A=
+// of "create desktop icon" and "add to start menu".=0A=
+=0A=
+#include "proppage.h"=0A=
+=0A=
+class DesktopSetupPage:public PropertyPage=0A=
+{=0A=
+public:=0A=
+  DesktopSetupPage ()=0A=
+  {=0A=
+  };=0A=
+  virtual ~ DesktopSetupPage ()=0A=
+  {=0A=
+  };=0A=
+=0A=
+  bool Create ();=0A=
+=0A=
+  virtual void OnInit ();=0A=
+  virtual bool OnFinish ();=0A=
+  virtual long OnBack ();=0A=
+};=0A=
+=0A=
+#endif // CINSTALL_DESKTOP_H=0A=
Index: dialog.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/dialog.h,v=0A=
retrieving revision 2.4=0A=
diff -u -p -r2.4 dialog.h=0A=
--- dialog.h	2001/11/13 01:49:31	2.4=0A=
+++ dialog.h	2001/12/20 12:35:59=0A=
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
retrieving revision 2.18=0A=
diff -u -p -r2.18 download.cc=0A=
--- download.cc	2001/12/20 11:49:53	2.18=0A=
+++ download.cc	2001/12/20 12:35:59=0A=
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
@@ -106,14 +110,15 @@ download_one (packagesource & pkgsource)=0A=
   for (size_t n =3D 1; n <=3D pkgsource.sites.number () && !success; n++)=
=0A=
     {=0A=
       const char *local =3D concat (local_dir, "/",=0A=
-				  rfc1738_escape_part (pkgsource.sites[n]->key), "/",=0A=
+				  rfc1738_escape_part (pkgsource.sites[n]->=0A=
+						       key), "/",=0A=
 				  pkgsource.Canonical (), 0);=0A=
       io_stream::mkpath_p (PATH_TO_FILE, concat ("file://", local, 0));=0A=
=20=0A=
       if (get_url_to_file=0A=
 	  (concat=0A=
 	   (pkgsource.sites[n]->key, "/", pkgsource.Canonical (), 0),=0A=
-	   concat (local, ".tmp", 0), pkgsource.size))=0A=
+	   concat (local, ".tmp", 0), pkgsource.size, owner))=0A=
 	{=0A=
 	  /* FIXME: note new source ? */=0A=
 	  continue;=0A=
@@ -146,8 +151,8 @@ download_one (packagesource & pkgsource)=0A=
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
@@ -157,19 +162,19 @@ do_download (HINSTANCE h)=0A=
   /* calculate the amount needed */=0A=
   for (size_t n =3D 1; n < db.packages.number (); n++)=0A=
     {=0A=
-      packagemeta &pkg =3D * db.packages[n];=0A=
+      packagemeta & pkg =3D *db.packages[n];=0A=
       if (pkg.desired && (pkg.desired->srcpicked || pkg.desired->binpicked=
))=0A=
-      {=0A=
-	packageversion *version =3D pkg.desired;=0A=
-	if (!=0A=
-	    (check_for_cached (version->bin)=0A=
-	     && source !=3D IDC_SOURCE_DOWNLOAD))=0A=
-	  total_download_bytes +=3D version->bin.size;=0A=
-	if (!=0A=
-	    (check_for_cached (version->src)=0A=
-	     && source !=3D IDC_SOURCE_DOWNLOAD))=0A=
-	  total_download_bytes +=3D version->src.size;=0A=
-      }=0A=
+	{=0A=
+	  packageversion *version =3D pkg.desired;=0A=
+	  if (!=0A=
+	      (check_for_cached (version->bin)=0A=
+	       && source !=3D IDC_SOURCE_DOWNLOAD) && pkg.desired->binpicked)=0A=
+	    total_download_bytes +=3D version->bin.size;=0A=
+	  if (!=0A=
+	      (check_for_cached (version->src)=0A=
+	       && source !=3D IDC_SOURCE_DOWNLOAD) && pkg.desired->srcpicked)=0A=
+	    total_download_bytes +=3D version->src.size;=0A=
+	}=0A=
     }=0A=
=20=0A=
   /* and do the download. FIXME: This here we assign a new name for the ca=
ched version=0A=
@@ -177,28 +182,28 @@ do_download (HINSTANCE h)=0A=
    */=0A=
   for (size_t n =3D 1; n < db.packages.number (); n++)=0A=
     {=0A=
-      packagemeta &pkg =3D * db.packages[n];=0A=
-    if (pkg.desired && (pkg.desired->srcpicked || pkg.desired->binpicked))=
=0A=
-      {=0A=
-	int e =3D 0;=0A=
-	packageversion *version =3D pkg.desired;=0A=
-	if (version->binpicked)=0A=
-	  e +=3D download_one (version->bin);=0A=
-	if (version->srcpicked)=0A=
-	  e +=3D download_one (version->src);=0A=
-	errors +=3D e;=0A=
+      packagemeta & pkg =3D *db.packages[n];=0A=
+      if (pkg.desired && (pkg.desired->srcpicked || pkg.desired->binpicked=
))=0A=
+	{=0A=
+	  int e =3D 0;=0A=
+	  packageversion *version =3D pkg.desired;=0A=
+	  if (version->binpicked)=0A=
+	    e +=3D download_one (version->bin, owner);=0A=
+	  if (version->srcpicked)=0A=
+	    e +=3D download_one (version->src, owner);=0A=
+	  errors +=3D e;=0A=
 #if 0=0A=
-	if (e)=0A=
-	  pkg->action =3D ACTION_ERROR;=0A=
+	  if (e)=0A=
+	    pkg->action =3D ACTION_ERROR;=0A=
 #endif=0A=
-      }=0A=
+	}=0A=
     }=0A=
=20=0A=
   dismiss_url_status_dialog ();=0A=
=20=0A=
   if (errors)=0A=
     {=0A=
-      if (yesno (IDS_DOWNLOAD_INCOMPLETE) =3D=3D IDYES)=0A=
+      if (yesno (owner, IDS_DOWNLOAD_INCOMPLETE) =3D=3D IDYES)=0A=
 	{=0A=
 	  next_dialog =3D IDD_SITE;=0A=
 	  return;=0A=
@@ -215,4 +220,29 @@ do_download (HINSTANCE h)=0A=
     }=0A=
   else=0A=
     next_dialog =3D IDD_S_INSTALL;=0A=
+}=0A=
+=0A=
+static void=0A=
+do_download_reflector (void *p)=0A=
+{=0A=
+  HANDLE *context;=0A=
+  context =3D (HANDLE *) p;=0A=
+=0A=
+  do_download_thread ((HINSTANCE) context[0], (HWND) context[1]);=0A=
+=0A=
+  // Tell the progress page that we're done downloading=0A=
+  Progress.PostMessage (WM_APP_DOWNLOAD_THREAD_COMPLETE, 0, next_dialog);=
=0A=
+=0A=
+  _endthread ();=0A=
+}=0A=
+=0A=
+static HANDLE context[2];=0A=
+=0A=
+void=0A=
+do_download (HINSTANCE h, HWND owner)=0A=
+{=0A=
+  context[0] =3D h;=0A=
+  context[1] =3D owner;=0A=
+=0A=
+  _beginthread (do_download_reflector, 0, context);=0A=
 }=0A=
Index: fromcwd.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/fromcwd.cc,v=0A=
retrieving revision 2.16=0A=
diff -u -p -r2.16 fromcwd.cc=0A=
--- fromcwd.cc	2001/12/20 11:49:53	2.16=0A=
+++ fromcwd.cc	2001/12/20 12:36:00=0A=
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
diff -u -p -r2.15 geturl.cc=0A=
--- geturl.cc	2001/12/02 03:25:11	2.15=0A=
+++ geturl.cc	2001/12/20 12:36:00=0A=
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
+  Progress.SetText1 ("Downloading...");=0A=
+  Progress.SetText2 (sl);=0A=
+  Progress.SetText3 ("Connecting...");=0A=
+  Progress.SetBar1 (0);=0A=
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
@@ -175,36 +89,31 @@ progress (int bytes)=0A=
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
+  kbps =3D ((double) bytes) / (double) (tics - start_tics);=0A=
+  if (max_bytes > 0)=0A=
+    {=0A=
+      int perc =3D (int) (100.0 * ((double) bytes) / (double) max_bytes);=
=0A=
+      Progress.SetBar1 (bytes, max_bytes);=0A=
+      sprintf (buf, "%3d %%  (%dk/%dk)  %2.1f kb/s\n",=0A=
 	       perc, bytes / 1000, max_bytes / 1000, kbps);=0A=
       if (total_download_bytes > 0)=0A=
 	{=0A=
-	  int totalperc =3D=0A=
-	    (total_download_bytes_sofar +=0A=
-	     bytes) / (total_download_bytes / 100);=0A=
-	  SendMessage (gw_pprogress, PBM_SETPOS, (WPARAM) totalperc, 0);=0A=
+	  Progress.SetBar2 (total_download_bytes_sofar + bytes,=0A=
+			    total_download_bytes);=0A=
 	}=0A=
     }=0A=
   else=0A=
-    sprintf (buf, "%d  %d kb/s\n", bytes, kbps);=0A=
+    sprintf (buf, "%d  %2.1f kb/s\n", bytes, kbps);=0A=
=20=0A=
-  SetWindowText (gw_rate, buf);=0A=
+  Progress.SetText3 (buf);=0A=
 }=0A=
=20=0A=
 io_stream *=0A=
-get_url_to_membuf (char const *_url)=0A=
+get_url_to_membuf (char const *_url, HWND owner)=0A=
 {=0A=
   log (LOG_BABBLE, "get_url_to_membuf %s", _url);=0A=
   is_local_install =3D (source =3D=3D IDC_SOURCE_CWD);=0A=
-  init_dialog (_url, 0);=0A=
+  init_dialog (_url, 0, owner);=0A=
   NetIO *n =3D NetIO::open (_url);=0A=
   if (!n || !n->ok ())=0A=
     {=0A=
@@ -254,9 +163,9 @@ get_url_to_membuf (char const *_url)=0A=
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
@@ -264,10 +173,11 @@ get_url_to_string (char const *_url)=0A=
     {=0A=
       /* zero length, or error retrieving length */=0A=
       delete stream;=0A=
-      log (LOG_BABBLE, "get_url_to_string(): couldn't retrieve buffer size=
, or zero length buffer");=0A=
+      log (LOG_BABBLE,=0A=
+	   "get_url_to_string(): couldn't retrieve buffer size, or zero length bu=
ffer");=0A=
       return 0;=0A=
     }=0A=
-  char *rv =3D new char [bytes + 1];=0A=
+  char *rv =3D new char[bytes + 1];=0A=
   if (!rv)=0A=
     {=0A=
       delete stream;=0A=
@@ -276,22 +186,22 @@ get_url_to_string (char const *_url)=0A=
     }=0A=
   /* membufs are quite safe */=0A=
   stream->read (rv, bytes);=0A=
-  rv [bytes] =3D '\0';=0A=
+  rv[bytes] =3D '\0';=0A=
   delete stream;=0A=
   return rv;=0A=
 }=0A=
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
+      Progress.SetBar3 (df);=0A=
     }=0A=
-  init_dialog (_url, expected_length);=0A=
+  init_dialog (_url, expected_length, owner);=0A=
=20=0A=
   remove (_filename);		/* but ignore errors */=0A=
=20=0A=
@@ -309,7 +219,7 @@ get_url_to_file (char *_url, char *_file=0A=
       const char *err =3D strerror (errno);=0A=
       if (!err)=0A=
 	err =3D "(unknown error)";=0A=
-      fatal (IDS_ERR_OPEN_WRITE, _filename, err);=0A=
+      fatal (owner, IDS_ERR_OPEN_WRITE, _filename, err);=0A=
     }=0A=
=20=0A=
   if (n->file_size)=0A=
@@ -338,15 +248,16 @@ get_url_to_file (char *_url, char *_file=0A=
   if (total_download_bytes > 0)=0A=
     {=0A=
       int df =3D diskfull (get_root_dir ());=0A=
-      SendMessage (gw_iprogress, PBM_SETPOS, (WPARAM) df, 0);=0A=
+      Progress.SetBar3 (df);=0A=
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
+  //ShowWindow (gw_dialog, SW_HIDE);=0A=
 }=0A=
Index: geturl.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/geturl.h,v=0A=
retrieving revision 2.4=0A=
diff -u -p -r2.4 geturl.h=0A=
--- geturl.h	2001/12/02 03:25:11	2.4=0A=
+++ geturl.h	2001/12/20 12:36:00=0A=
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
diff -u -p -r2.15 ini.cc=0A=
--- ini.cc	2001/12/03 22:22:09	2.15=0A=
+++ ini.cc	2001/12/20 12:36:00=0A=
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
@@ -59,50 +63,54 @@ static int local_ini;=0A=
 static void=0A=
 find_routine (char *path, unsigned int fsize)=0A=
 {=0A=
-  if (!strstr (path, "/setup.ini") )=0A=
+  if (!strstr (path, "/setup.ini"))=0A=
     return;=0A=
-  io_stream *ini_file =3D io_stream::open (concat ("file://", local_dir,"/=
", path, 0), "rb");=0A=
+  io_stream *ini_file =3D=0A=
+    io_stream::open (concat ("file://", local_dir, "/", path, 0), "rb");=
=0A=
   if (!ini_file)=0A=
     {=0A=
-    note (IDS_SETUPINI_MISSING, path);=0A=
-    return;=0A=
+      note (NULL, IDS_SETUPINI_MISSING, path);=0A=
+      return;=0A=
     }=0A=
=20=0A=
   /* FIXME: only use most recent copy */=0A=
   setup_timestamp =3D 0;=0A=
   setup_version =3D 0;=0A=
=20=0A=
-  ini_init (ini_file, concat ("file://", local_dir,"/", path, 0));=0A=
+  ini_init (ini_file, concat ("file://", local_dir, "/", path, 0));=0A=
=20=0A=
   /*yydebug =3D 1; */=0A=
=20=0A=
   if (yyparse () || error_count > 0)=0A=
-    MessageBox (0, error_buf, error_count =3D=3D 1 ? "Parse Error" : "Pars=
e Errors", 0);=0A=
+    MessageBox (0, error_buf,=0A=
+		error_count =3D=3D 1 ? "Parse Error" : "Parse Errors", 0);=0A=
   else=0A=
     local_ini++;=0A=
 }=0A=
=20=0A=
 static int=0A=
-do_local_ini ()=0A=
+do_local_ini (HWND owner)=0A=
 {=0A=
   local_ini =3D 0;=0A=
   find (local_dir, find_routine);=0A=
-  return local_ini;=20=0A=
+  return local_ini;=0A=
 }=0A=
=20=0A=
 static int=0A=
-do_remote_ini ()=0A=
+do_remote_ini (HWND owner)=0A=
 {=0A=
   size_t ini_count =3D 0;=0A=
+=0A=
   for (size_t n =3D 1; n <=3D site_list.number (); n++)=0A=
     {=0A=
       io_stream *ini_file =3D=0A=
-	get_url_to_membuf (concat (site_list[n]->url, "/setup.ini", 0));=0A=
+	get_url_to_membuf (concat (site_list[n]->url, "/setup.ini", 0),=0A=
+			   owner);=0A=
       dismiss_url_status_dialog ();=0A=
=20=0A=
       if (!ini_file)=0A=
 	{=0A=
-	  note (IDS_SETUPINI_MISSING, site_list[n]->url);=0A=
+	  note (owner, IDS_SETUPINI_MISSING, site_list[n]->url);=0A=
 	  continue;=0A=
 	}=0A=
=20=0A=
@@ -139,14 +147,14 @@ do_remote_ini ()=0A=
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
@@ -171,7 +179,7 @@ do_ini (HINSTANCE h)=0A=
 	  if (old_timestamp && setup_timestamp=0A=
 	      && (old_timestamp > setup_timestamp))=0A=
 	    {=0A=
-	      int yn =3D yesno (IDS_OLD_SETUPINI);=0A=
+	      int yn =3D yesno (owner, IDS_OLD_SETUPINI);=0A=
 	      if (yn =3D=3D IDNO)=0A=
 		exit_setup (1);=0A=
 	    }=0A=
@@ -197,11 +205,37 @@ do_ini (HINSTANCE h)=0A=
       char *ini_version =3D canonicalize_version (setup_version);=0A=
       char *our_version =3D canonicalize_version (version);=0A=
       if (strcmp (our_version, ini_version) < 0)=0A=
-	note (IDS_OLD_SETUP_VERSION, version, setup_version);=0A=
+	note (owner, IDS_OLD_SETUP_VERSION, version, setup_version);=0A=
     }=0A=
+=0A=
+  next_dialog =3D IDD_CHOOSER;=0A=
+}=0A=
+=0A=
+static void=0A=
+do_ini_thread_reflector (void *p)=0A=
+{=0A=
+  HANDLE *context;=0A=
+  context =3D (HANDLE *) p;=0A=
+=0A=
+  do_ini_thread ((HINSTANCE) context[0], (HWND) context[1]);=0A=
+=0A=
+  // Tell the progress page that we're done downloading=0A=
+  Progress.PostMessage (WM_APP_SETUP_INI_DOWNLOAD_COMPLETE, 0, next_dialog=
);=0A=
+=0A=
+  _endthread ();=0A=
+}=0A=
=20=0A=
-  next_dialog =3D IDD_CHOOSE;=0A=
+static HANDLE context[2];=0A=
+=0A=
+void=0A=
+do_ini (HINSTANCE h, HWND owner)=0A=
+{=0A=
+  context[0] =3D h;=0A=
+  context[1] =3D owner;=0A=
+=0A=
+  _beginthread (do_ini_thread_reflector, 0, context);=0A=
 }=0A=
+=0A=
=20=0A=
 extern int yylineno;=0A=
=20=0A=
Index: install.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/install.cc,v=0A=
retrieving revision 2.31=0A=
diff -u -p -r2.31 install.cc=0A=
--- install.cc	2001/12/20 11:49:53	2.31=0A=
+++ install.cc	2001/12/20 12:36:00=0A=
@@ -33,6 +33,8 @@ static const char *cvsid =3D=0A=
 #include <sys/types.h>=0A=
 #include <sys/stat.h>=0A=
 #include <errno.h>=0A=
+#include <process.h>=0A=
+=0A=
 #include "zlib/zlib.h"=0A=
=20=0A=
 #include "resource.h"=0A=
@@ -61,109 +63,31 @@ static const char *cvsid =3D=0A=
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
+  Progress.SetText2 ("");=0A=
+  Progress.SetText3 ("");=0A=
 }=0A=
=20=0A=
 static void=0A=
 progress (int bytes)=0A=
 {=0A=
-  int perc;=0A=
-=0A=
-  if (package_bytes > 100)=0A=
+  if (package_bytes > 0)=0A=
     {=0A=
-      perc =3D bytes / (package_bytes / 100);=0A=
-      SendMessage (ins_pprogress, PBM_SETPOS, (WPARAM) perc, 0);=0A=
+      Progress.SetBar1 (bytes, package_bytes);=0A=
     }=0A=
=20=0A=
-  if (total_bytes > 100)=0A=
+  if (total_bytes > 0)=0A=
     {=0A=
-      perc =3D (total_bytes_sofar + bytes) / (total_bytes / 100);=0A=
-      SendMessage (ins_iprogress, PBM_SETPOS, (WPARAM) perc, 0);=0A=
+      Progress.SetBar2 (total_bytes_sofar + bytes, total_bytes);=0A=
     }=0A=
 }=0A=
=20=0A=
@@ -192,11 +116,11 @@ static int num_installs, num_uninstalls;=0A=
 static void=0A=
 uninstall_one (packagemeta & pkgm)=0A=
 {=0A=
-      SetWindowText (ins_pkgname, pkgm.name);=0A=
-      SetWindowText (ins_action, "Uninstalling...");=0A=
-      log (0, "Uninstalling %s", pkgm.name);=0A=
-      pkgm.uninstall ();=0A=
-      num_uninstalls++;=0A=
+  Progress.SetText1 ("Uninstalling...");=0A=
+  Progress.SetText2 (pkgm.name);=0A=
+  log (0, "Uninstalling %s", pkgm.name);=0A=
+  pkgm.uninstall ();=0A=
+  num_uninstalls++;=0A=
 }=0A=
=20=0A=
=20=0A=
@@ -207,10 +131,10 @@ install_one_source (packagemeta & pkgm,=20=0A=
 		    char const *prefix, package_type_t type)=0A=
 {=0A=
   int errors =3D 0;=0A=
-  SetWindowText (ins_pkgname, source.Base ());=0A=
+  Progress.SetText2 (source.Base ());=0A=
   if (!io_stream::exists (source.Cached ()))=0A=
     {=0A=
-      note (IDS_ERR_OPEN_READ, source.Cached (), "No such file");=0A=
+      note (NULL, IDS_ERR_OPEN_READ, source.Cached (), "No such file");=0A=
       return 1;=0A=
     }=0A=
   io_stream *lst =3D 0;=0A=
@@ -232,7 +156,7 @@ install_one_source (packagemeta & pkgm,=20=0A=
=20=0A=
   char msg[64];=0A=
   strcpy (msg, "Installing");=0A=
-  SetWindowText (ins_action, msg);=0A=
+  Progress.SetText1 (msg);=0A=
   log (0, "%s%s", msg, source.Cached ());=0A=
   io_stream *tmp =3D io_stream::open (source.Cached (), "rb");=0A=
   archive *thefile =3D 0;=0A=
@@ -254,7 +178,7 @@ install_one_source (packagemeta & pkgm,=20=0A=
 	    lst->write (concat (fn, "\n", 0), strlen (fn) + 1);=0A=
=20=0A=
 	  /* FIXME: concat leaks memory */=0A=
-	  SetWindowText (ins_filename, concat (prefix, fn, 0));=0A=
+	  Progress.SetText3 (concat (prefix, fn, 0));=0A=
 	  log (LOG_BABBLE, "Installing file %s%s", prefix, fn);=0A=
 	  if (archive::extract_file (thefile, prefix) !=3D 0)=0A=
 	    {=0A=
@@ -274,7 +198,7 @@ install_one_source (packagemeta & pkgm,=20=0A=
   progress (0);=0A=
=20=0A=
   int df =3D diskfull (get_root_dir ());=0A=
-  SendMessage (ins_diskfull, PBM_SETPOS, (WPARAM) df, 0);=0A=
+  Progress.SetBar3 (df);=0A=
=20=0A=
   if (lst)=0A=
     delete lst;=0A=
@@ -289,17 +213,17 @@ install_one (packagemeta & pkg)=0A=
   int errors =3D 0;=0A=
=20=0A=
   if (pkg.desired->binpicked)=0A=
-  {=0A=
-    errors +=3D=0A=
-      install_one_source (pkg, pkg.desired->bin, "cygfile:///",=0A=
-			  package_binary);=0A=
-    if (!errors)=0A=
-      pkg.installed =3D pkg.desired;=0A=
-  }=0A=
-  if (pkg.desired->srcpicked)=0A=
+    {=0A=
       errors +=3D=0A=
-	    install_one_source (pkg, pkg.desired->src, "cygfile:///usr/src",=0A=
-		                        package_source);=0A=
+	install_one_source (pkg, pkg.desired->bin, "cygfile:///",=0A=
+			    package_binary);=0A=
+      if (!errors)=0A=
+	pkg.installed =3D pkg.desired;=0A=
+    }=0A=
+  if (pkg.desired->srcpicked)=0A=
+    errors +=3D=0A=
+      install_one_source (pkg, pkg.desired->src, "cygfile:///usr/src",=0A=
+			  package_source);=0A=
=20=0A=
   /* FIXME: make a upgrade method and reinstate this */=0A=
 #if 0=0A=
@@ -375,8 +299,8 @@ check_for_old_cygwin ()=0A=
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
@@ -398,15 +322,13 @@ do_install (HINSTANCE h)=0A=
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
+  Progress.SetBar3 (df);=0A=
=20=0A=
   int istext =3D (root_text =3D=3D IDC_ROOT_TEXT) ? 1 : 0;=0A=
   int issystem =3D (root_scope =3D=3D IDC_ROOT_SYSTEM) ? 1 : 0;=0A=
@@ -419,27 +341,26 @@ do_install (HINSTANCE h)=0A=
   packagedb db;=0A=
   for (size_t n =3D 1; n < db.packages.number (); n++)=0A=
     {=0A=
-      packagemeta &pkg =3D * db.packages[n];=0A=
+      packagemeta & pkg =3D *db.packages[n];=0A=
=20=0A=
-    if (pkg.desired && (pkg.desired->srcpicked || pkg.desired->binpicked))=
=0A=
-      {=0A=
-	if (pkg.desired->srcpicked)=0A=
-	  total_bytes +=3D pkg.desired->src.size;=0A=
-	if (pkg.desired->binpicked)=0A=
-	  total_bytes +=3D pkg.desired->bin.size;=0A=
-      }=0A=
+      if (pkg.desired && (pkg.desired->srcpicked || pkg.desired->binpicked=
))=0A=
+	{=0A=
+	  if (pkg.desired->srcpicked)=0A=
+	    total_bytes +=3D pkg.desired->src.size;=0A=
+	  if (pkg.desired->binpicked)=0A=
+	    total_bytes +=3D pkg.desired->bin.size;=0A=
+	}=0A=
     }=0A=
=20=0A=
   for (size_t n =3D 1; n < db.packages.number (); n++)=0A=
     {=0A=
-      packagemeta &pkg =3D * db.packages[n];=0A=
+      packagemeta & pkg =3D *db.packages[n];=0A=
       if (pkg.installed && (!pkg.desired || pkg.desired !=3D pkg.installed=
))=0A=
 	{=0A=
 	  uninstall_one (pkg);=0A=
 	}=0A=
=20=0A=
-      if (pkg.desired=0A=
-	  && (pkg.desired->srcpicked || pkg.desired->binpicked))=0A=
+      if (pkg.desired && (pkg.desired->srcpicked || pkg.desired->binpicked=
))=0A=
 	{=0A=
 	  int e =3D 0;=0A=
 	  e +=3D install_one (pkg);=0A=
@@ -450,15 +371,13 @@ do_install (HINSTANCE h)=0A=
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
@@ -478,4 +397,29 @@ do_install (HINSTANCE h)=0A=
     exit_msg =3D IDS_INSTALL_INCOMPLETE;=0A=
   else=0A=
     exit_msg =3D IDS_INSTALL_COMPLETE;=0A=
+}=0A=
+=0A=
+static void=0A=
+do_install_reflector (void *p)=0A=
+{=0A=
+  HANDLE *context;=0A=
+  context =3D (HANDLE *) p;=0A=
+=0A=
+  do_install_thread ((HINSTANCE) context[0], (HWND) context[1]);=0A=
+=0A=
+  // Tell the progress page that we're done downloading=0A=
+  Progress.PostMessage (WM_APP_INSTALL_THREAD_COMPLETE, next_dialog);=0A=
+=0A=
+  _endthread ();=0A=
+}=0A=
+=0A=
+static HANDLE context[2];=0A=
+=0A=
+void=0A=
+do_install (HINSTANCE h, HWND owner)=0A=
+{=0A=
+  context[0] =3D h;=0A=
+  context[1] =3D owner;=0A=
+=0A=
+  _beginthread (do_install_reflector, 0, context);=0A=
 }=0A=
Index: localdir.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/localdir.cc,v=0A=
retrieving revision 2.5=0A=
diff -u -p -r2.5 localdir.cc=0A=
--- localdir.cc	2001/11/14 00:11:35	2.5=0A=
+++ localdir.cc	2001/12/20 12:36:00=0A=
@@ -39,6 +39,8 @@ static const char *cvsid =3D=0A=
 #include "mkdir.h"=0A=
 #include "io_stream.h"=0A=
=20=0A=
+#include "localdir.h"=0A=
+=0A=
 void=0A=
 save_local_dir ()=0A=
 {=0A=
@@ -128,74 +130,20 @@ dialog_cmd (HWND h, int id, HWND hwndctl=0A=
     case IDC_LOCAL_DIR_BROWSE:=0A=
       browse (h);=0A=
       break;=0A=
-=0A=
-    case IDOK:=0A=
-      save_dialog (h);=0A=
-      save_local_dir ();=0A=
-      if (SetCurrentDirectoryA (local_dir))=0A=
-	{=0A=
-	  switch (source)=0A=
-	    {=0A=
-	    case IDC_SOURCE_DOWNLOAD:=0A=
-	    case IDC_SOURCE_NETINST:=0A=
-	      NEXT (IDD_NET);=0A=
-	      break;=0A=
-	    case IDC_SOURCE_CWD:=0A=
-	      NEXT (IDD_S_FROM_CWD);=0A=
-	      break;=0A=
-	    default:=0A=
-	      msg ("source is default? %d\n", source);=0A=
-	      NEXT (0);=0A=
-	      break;=0A=
-	    }=0A=
-	}=0A=
-      else=0A=
-	note (IDS_ERR_CHDIR, local_dir);=0A=
-=0A=
-      break;=0A=
-=0A=
-    case IDC_BACK:=0A=
-      save_dialog (h);=0A=
-      switch (source)=0A=
-	{=0A=
-	case IDC_SOURCE_DOWNLOAD:=0A=
-	  NEXT (IDD_SOURCE);=0A=
-	  break;=0A=
-	case IDC_SOURCE_NETINST:=0A=
-	case IDC_SOURCE_CWD:=0A=
-	  NEXT (IDD_ROOT);=0A=
-	  break;=0A=
-	default:=0A=
-	  msg ("source is default? %d\n", source);=0A=
-	  NEXT (0);=0A=
-	}=0A=
-      break;=0A=
-=0A=
-    case IDCANCEL:=0A=
-      NEXT (0);=0A=
-      break;=0A=
     }=0A=
   return 0;=0A=
 }=0A=
+=0A=
+//extern char cwd[_MAX_PATH];=0A=
=20=0A=
-static BOOL CALLBACK=0A=
-dialog_proc (HWND h, UINT message, WPARAM wParam, LPARAM lParam)=0A=
+bool=0A=
+LocalDirPage::Create ()=0A=
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
+  return PropertyPage::Create (NULL, dialog_cmd, IDD_LOCAL_DIR);=0A=
 }=0A=
=20=0A=
-extern char cwd[_MAX_PATH];=0A=
-=0A=
 void=0A=
-do_local_dir (HINSTANCE h)=0A=
+LocalDirPage::OnInit ()=0A=
 {=0A=
   static int inited =3D 0;=0A=
   if (!inited)=0A=
@@ -217,11 +165,43 @@ do_local_dir (HINSTANCE h)=0A=
 	}=0A=
       inited =3D 1;=0A=
     }=0A=
+}=0A=
+=0A=
+void=0A=
+LocalDirPage::OnActivate ()=0A=
+{=0A=
+  load_dialog (GetHWND ());=0A=
+}=0A=
=20=0A=
-  int rv =3D 0;=0A=
-  rv =3D DialogBox (h, MAKEINTRESOURCE (IDD_LOCAL_DIR), 0, dialog_proc);=
=0A=
-  if (rv =3D=3D -1)=0A=
-    fatal (IDS_DIALOG_FAILED);=0A=
+long=0A=
+LocalDirPage::OnNext ()=0A=
+{=0A=
+  HWND h =3D GetHWND ();=0A=
=20=0A=
+  save_dialog (h);=0A=
+  save_local_dir ();=0A=
   log (0, "Selected local directory: %s", local_dir);=0A=
+  if (SetCurrentDirectoryA (local_dir))=0A=
+    {=0A=
+      if (source =3D=3D IDC_SOURCE_CWD)=0A=
+	{=0A=
+	  return IDD_S_FROM_CWD;=0A=
+	}=0A=
+    }=0A=
+  else=0A=
+    note (h, IDS_ERR_CHDIR, local_dir);=0A=
+=0A=
+  return 0;=0A=
+}=0A=
+=0A=
+long=0A=
+LocalDirPage::OnBack ()=0A=
+{=0A=
+  save_dialog (GetHWND ());=0A=
+  if (source =3D=3D IDC_SOURCE_DOWNLOAD)=0A=
+    {=0A=
+      // Downloading only, skip the unix root page=0A=
+      return IDD_SOURCE;=0A=
+    }=0A=
+  return 0;=0A=
 }=0A=
Index: localdir.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: localdir.h=0A=
diff -N localdir.h=0A=
--- /dev/null	Tue May  5 13:32:27 1998=0A=
+++ localdir.h	Thu Dec 20 04:36:00 2001=0A=
@@ -0,0 +1,44 @@=0A=
+#ifndef CINSTALL_LOCALDIR_H=0A=
+#define CINSTALL_LOCALDIR_H=0A=
+=0A=
+/*=0A=
+ * Copyright (c) 2001, Gary R. Van Sickle.=0A=
+ *=0A=
+ *     This program is free software; you can redistribute it and/or modif=
y=0A=
+ *     it under the terms of the GNU General Public License as published b=
y=0A=
+ *     the Free Software Foundation; either version 2 of the License, or=
=0A=
+ *     (at your option) any later version.=0A=
+ *=0A=
+ *     A copy of the GNU General Public License can be found at=0A=
+ *     http://www.gnu.org/=0A=
+ *=0A=
+ * Written by Gary R. Van Sickle <g.r.vansickle@worldnet.att.net>=0A=
+ *=0A=
+ */=0A=
+=0A=
+// This is the header for the LocalDirPage class.  Allows the user to sele=
ct=0A=
+// the local package directory (i.e. where downloaded packages are stored)=
.=0A=
+=0A=
+=0A=
+#include "proppage.h"=0A=
+=0A=
+class LocalDirPage:public PropertyPage=0A=
+{=0A=
+public:=0A=
+  LocalDirPage ()=0A=
+  {=0A=
+  };=0A=
+  virtual ~ LocalDirPage ()=0A=
+  {=0A=
+  };=0A=
+=0A=
+  bool Create ();=0A=
+=0A=
+  void OnActivate ();=0A=
+  void OnInit ();=0A=
+  long OnNext ();=0A=
+  long OnBack ();=0A=
+};=0A=
+=0A=
+=0A=
+#endif=0A=
Index: log.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/log.cc,v=0A=
retrieving revision 2.5=0A=
diff -u -p -r2.5 log.cc=0A=
--- log.cc	2001/11/13 01:49:32	2.5=0A=
+++ log.cc	2001/12/20 12:36:00=0A=
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
diff -u -p -r2.9 main.cc=0A=
--- main.cc	2001/11/13 01:49:32	2.9=0A=
+++ main.cc	2001/12/20 12:36:00=0A=
@@ -29,6 +29,7 @@ static const char *cvsid =3D=0A=
 #endif=0A=
=20=0A=
 #include "win32.h"=0A=
+#include <commctrl.h>=0A=
=20=0A=
 #include <stdio.h>=0A=
 #include <stdlib.h>=0A=
@@ -42,7 +43,20 @@ static const char *cvsid =3D=0A=
 #include "version.h"=0A=
=20=0A=
 #include "port.h"=0A=
+#include "proppage.h"=0A=
+#include "propsheet.h"=0A=
=20=0A=
+// Page class headers=0A=
+#include "splash.h"=0A=
+#include "source.h"=0A=
+#include "root.h"=0A=
+#include "localdir.h"=0A=
+#include "net.h"=0A=
+#include "site.h"=0A=
+#include "choose.h"=0A=
+#include "threebar.h"=0A=
+#include "desktop.h"=0A=
+=0A=
 int next_dialog;=0A=
 int exit_msg =3D 0;=0A=
=20=0A=
@@ -123,6 +137,12 @@ out:=0A=
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
@@ -133,6 +153,16 @@ WinMain (HINSTANCE h,=0A=
=20=0A=
   log (LOG_TIMESTAMP, "Starting cygwin install, version %s", version);=0A=
=20=0A=
+  SplashPage Splash;=0A=
+  SourcePage Source;=0A=
+  RootPage Root;=0A=
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
@@ -150,58 +180,36 @@ WinMain (HINSTANCE h,=0A=
   if (iswinnt)=0A=
     set_default_dacl ();=0A=
=20=0A=
-  while (next_dialog)=0A=
-    {=0A=
-      switch (next_dialog)=0A=
-	{=0A=
-	case IDD_SPLASH:=0A=
-	  do_splash (h);=0A=
-	  break;=0A=
-	case IDD_SOURCE:=0A=
-	  do_source (h);=0A=
-	  break;=0A=
-	case IDD_LOCAL_DIR:=0A=
-	  do_local_dir (h);=0A=
-	  break;=0A=
-	case IDD_ROOT:=0A=
-	  do_root (h);=0A=
-	  break;=0A=
-	case IDD_NET:=0A=
-	  do_net (h);=0A=
-	  break;=0A=
-	case IDD_SITE:=0A=
-	  do_site (h);=0A=
-	  break;=0A=
-	case IDD_OTHER_URL:=0A=
-	  do_other (h);=0A=
-	  break;=0A=
-	case IDD_S_LOAD_INI:=0A=
-	  do_ini (h);=0A=
-	  break;=0A=
-	case IDD_S_FROM_CWD:=0A=
-	  do_fromcwd (h);=0A=
-	  break;=0A=
-	case IDD_CHOOSE:=0A=
-	  do_choose (h);=0A=
-	  break;=0A=
-	case IDD_S_DOWNLOAD:=0A=
-	  do_download (h);=0A=
-	  break;=0A=
-	case IDD_S_INSTALL:=0A=
-	  do_install (h);=0A=
-	  break;=0A=
-	case IDD_DESKTOP:=0A=
-	  do_desktop (h);=0A=
-	  break;=0A=
-	case IDD_S_POSTINSTALL:=0A=
-	  do_postinstall (h);=0A=
-	  break;=0A=
-=0A=
-	default:=0A=
-	  next_dialog =3D 0;=0A=
-	  break;=0A=
-	}=0A=
-    }=0A=
+  // Initialize common controls=0A=
+  InitCommonControls ();=0A=
+=0A=
+  // Init window class lib=0A=
+  Window::SetAppInstance (h);=0A=
+=0A=
+  // Create pages=0A=
+  Splash.Create ();=0A=
+  Source.Create ();=0A=
+  Root.Create ();=0A=
+  LocalDir.Create ();=0A=
+  Net.Create ();=0A=
+  Site.Create ();=0A=
+  Chooser.Create ();=0A=
+  Progress.Create ();=0A=
+  Desktop.Create ();=0A=
+=0A=
+  // Add pages to sheet=0A=
+  MainWindow.AddPage (&Splash);=0A=
+  MainWindow.AddPage (&Source);=0A=
+  MainWindow.AddPage (&Root);=0A=
+  MainWindow.AddPage (&LocalDir);=0A=
+  MainWindow.AddPage (&Net);=0A=
+  MainWindow.AddPage (&Site);=0A=
+  MainWindow.AddPage (&Chooser);=0A=
+  MainWindow.AddPage (&Progress);=0A=
+  MainWindow.AddPage (&Desktop);=0A=
+=0A=
+  // Create the PropSheet main window=0A=
+  MainWindow.Create ();=0A=
=20=0A=
   exit_setup (0);=0A=
   /* Keep gcc happy :} */=0A=
Index: msg.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/msg.cc,v=0A=
retrieving revision 2.2=0A=
diff -u -p -r2.2 msg.cc=0A=
--- msg.cc	2001/11/13 01:49:32	2.2=0A=
+++ msg.cc	2001/12/20 12:36:00=0A=
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
+  return MessageBox (owner, buf, "Cygwin Setup", type /*| MB_TOPMOST */ );=
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
diff -u -p -r2.1 msg.h=0A=
--- msg.h	2001/11/13 01:49:32	2.1=0A=
+++ msg.h	2001/12/20 12:36:00=0A=
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
diff -u -p -r2.7 net.cc=0A=
--- net.cc	2001/11/13 01:49:32	2.7=0A=
+++ net.cc	2001/12/20 12:36:00=0A=
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
@@ -84,71 +89,50 @@ dialog_cmd (HWND h, int id, HWND hwndctl=0A=
       save_dialog (h);=0A=
       check_if_enable_next (h);=0A=
       break;=0A=
-=0A=
-    case IDOK:=0A=
-      save_dialog (h);=0A=
-      switch (source)=0A=
-	{=0A=
-	case IDC_SOURCE_NETINST:=0A=
-	case IDC_SOURCE_DOWNLOAD:=0A=
-	  NEXT (IDD_SITE);=0A=
-	  break;=0A=
-	case IDC_SOURCE_CWD:=0A=
-	  NEXT (0);=0A=
-	  break;=0A=
-	default:=0A=
-	  msg ("source is default? %d\n", source);=0A=
-	  NEXT (0);=0A=
-	}=0A=
-      break;=0A=
-=0A=
-    case IDC_BACK:=0A=
-      save_dialog (h);=0A=
-      NEXT (IDD_LOCAL_DIR);=0A=
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
+bool=0A=
+NetPage::Create ()=0A=
 {=0A=
-  switch (message)=0A=
-    {=0A=
-    case WM_INITDIALOG:=0A=
-      load_dialog (h);=0A=
-=0A=
-      // Check to see if any radio buttons are selected. If not, select a =
default.=0A=
-      if (=0A=
-	  (!SendMessage (GetDlgItem (h, IDC_NET_IE5), BM_GETCHECK, 0, 0) =3D=3D=
=0A=
-	   BST_CHECKED)=0A=
-	  && (!SendMessage (GetDlgItem (h, IDC_NET_PROXY), BM_GETCHECK, 0, 0)=0A=
-	      =3D=3D BST_CHECKED))=0A=
-	{=0A=
-	  SendMessage (GetDlgItem (h, IDC_NET_DIRECT), BM_CLICK, 0, 0);=0A=
-	}=0A=
-      return FALSE;=0A=
-    case WM_COMMAND:=0A=
-      return HANDLE_WM_COMMAND (h, wParam, lParam, dialog_cmd);=0A=
-    }=0A=
-  return FALSE;=0A=
+  return PropertyPage::Create (NULL, dialog_cmd, IDD_NET);=0A=
 }=0A=
=20=0A=
 void=0A=
-do_net (HINSTANCE h)=0A=
+NetPage::OnInit ()=0A=
 {=0A=
-  int rv =3D 0;=0A=
+  HWND h =3D GetHWND ();=0A=
=20=0A=
   net_method =3D IDC_NET_DIRECT;=0A=
-  rv =3D DialogBox (h, MAKEINTRESOURCE (IDD_NET), 0, dialog_proc);=0A=
-  if (rv =3D=3D -1)=0A=
-    fatal (IDS_DIALOG_FAILED);=0A=
+  load_dialog (h);=0A=
+=0A=
+  // Check to see if any radio buttons are selected. If not, select a defa=
ult.=0A=
+  if ((!SendMessage (GetDlgItem (IDC_NET_IE5), BM_GETCHECK, 0, 0) =3D=3D=
=0A=
+       BST_CHECKED)=0A=
+      && (!SendMessage (GetDlgItem (IDC_NET_PROXY), BM_GETCHECK, 0, 0)=0A=
+	  =3D=3D BST_CHECKED))=0A=
+    {=0A=
+      SendMessage (GetDlgItem (IDC_NET_DIRECT), BM_CLICK, 0, 0);=0A=
+    }=0A=
+}=0A=
+=0A=
+long=0A=
+NetPage::OnNext ()=0A=
+{=0A=
+  save_dialog (GetHWND ());=0A=
=20=0A=
   log (0, "net: %s",=0A=
        (net_method =3D=3D IDC_NET_IE5) ? "IE5" :=0A=
        (net_method =3D=3D IDC_NET_DIRECT) ? "Direct" : "Proxy");=0A=
+=0A=
+  Progress.SetActivateTask (WM_APP_START_SITE_INFO_DOWNLOAD);=0A=
+  return IDD_INSTATUS;=0A=
+}=0A=
+=0A=
+long=0A=
+NetPage::OnBack ()=0A=
+{=0A=
+  save_dialog (GetHWND ());=0A=
+  return 0;=0A=
 }=0A=
Index: net.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: net.h=0A=
diff -N net.h=0A=
--- /dev/null	Tue May  5 13:32:27 1998=0A=
+++ net.h	Thu Dec 20 04:36:00 2001=0A=
@@ -0,0 +1,42 @@=0A=
+#ifndef CINSTALL_NET_H=0A=
+#define CINSTALL_NET_H=0A=
+=0A=
+/*=0A=
+ * Copyright (c) 2001, Gary R. Van Sickle.=0A=
+ *=0A=
+ *     This program is free software; you can redistribute it and/or modif=
y=0A=
+ *     it under the terms of the GNU General Public License as published b=
y=0A=
+ *     the Free Software Foundation; either version 2 of the License, or=
=0A=
+ *     (at your option) any later version.=0A=
+ *=0A=
+ *     A copy of the GNU General Public License can be found at=0A=
+ *     http://www.gnu.org/=0A=
+ *=0A=
+ * Written by Gary R. Van Sickle <g.r.vansickle@worldnet.att.net>=0A=
+ *=0A=
+ */=0A=
+=0A=
+// This is the header for the NetPage class.  It allows the user to select=
=0A=
+// a proxy etc.=0A=
+=0A=
+=0A=
+#include "proppage.h"=0A=
+=0A=
+class NetPage:public PropertyPage=0A=
+{=0A=
+public:=0A=
+  NetPage ()=0A=
+  {=0A=
+  };=0A=
+  virtual ~ NetPage ()=0A=
+  {=0A=
+  };=0A=
+=0A=
+  bool Create ();=0A=
+=0A=
+  virtual void OnInit ();=0A=
+  virtual long OnNext ();=0A=
+  virtual long OnBack ();=0A=
+};=0A=
+=0A=
+#endif // CINSTALL_NET_H=0A=
Index: netio.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/netio.cc,v=0A=
retrieving revision 2.5=0A=
diff -u -p -r2.5 netio.cc=0A=
--- netio.cc	2001/12/02 03:25:11	2.5=0A=
+++ netio.cc	2001/12/20 12:36:00=0A=
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
diff -u -p -r2.4 netio.h=0A=
--- netio.h	2001/12/02 03:25:11	2.4=0A=
+++ netio.h	2001/12/20 12:36:00=0A=
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
diff -u -p -r2.4 nio-file.cc=0A=
--- nio-file.cc	2001/12/02 03:25:11	2.4=0A=
+++ nio-file.cc	2001/12/20 12:36:00=0A=
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
diff -u -p -r2.8 nio-ftp.cc=0A=
--- nio-ftp.cc	2001/12/02 03:25:11	2.8=0A=
+++ nio-ftp.cc	2001/12/20 12:36:02=0A=
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
diff -u -p -r2.9 nio-http.cc=0A=
--- nio-http.cc	2001/12/02 03:25:11	2.9=0A=
+++ nio-http.cc	2001/12/20 12:36:02=0A=
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
diff -u -p -r2.4 nio-ie5.cc=0A=
--- nio-ie5.cc	2001/12/02 03:25:11	2.4=0A=
+++ nio-ie5.cc	2001/12/20 12:36:02=0A=
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
diff -u -p -r2.3 other.cc=0A=
--- other.cc	2001/12/03 22:22:09	2.3=0A=
+++ other.cc	2001/12/20 12:36:02=0A=
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
Index: postinstall.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/postinstall.cc,v=0A=
retrieving revision 2.4=0A=
diff -u -p -r2.4 postinstall.cc=0A=
--- postinstall.cc	2001/11/13 01:49:32	2.4=0A=
+++ postinstall.cc	2001/12/20 12:36:02=0A=
@@ -98,7 +98,7 @@ static const char *shells[] =3D {=0A=
 };=0A=
=20=0A=
 void=0A=
-do_postinstall (HINSTANCE h)=0A=
+do_postinstall (HINSTANCE h, HWND owner)=0A=
 {=0A=
   next_dialog =3D 0;=0A=
   int i;=0A=
Index: proppage.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: proppage.cc=0A=
diff -N proppage.cc=0A=
--- /dev/null	Tue May  5 13:32:27 1998=0A=
+++ proppage.cc	Thu Dec 20 04:36:02 2001=0A=
@@ -0,0 +1,226 @@=0A=
+/*=0A=
+ * Copyright (c) 2001, Gary R. Van Sickle.=0A=
+ *=0A=
+ *     This program is free software; you can redistribute it and/or modif=
y=0A=
+ *     it under the terms of the GNU General Public License as published b=
y=0A=
+ *     the Free Software Foundation; either version 2 of the License, or=
=0A=
+ *     (at your option) any later version.=0A=
+ *=0A=
+ *     A copy of the GNU General Public License can be found at=0A=
+ *     http://www.gnu.org/=0A=
+ *=0A=
+ * Written by Gary R. Van Sickle <g.r.vansickle@worldnet.att.net>=0A=
+ *=0A=
+ */=0A=
+=0A=
+// This is the implementation of the PropertyPage class.  It works closely=
 with the=0A=
+// PropSheet class to implement a single page of the property sheet.=0A=
+=0A=
+#include "proppage.h"=0A=
+#include "propsheet.h"=0A=
+#include "win32.h"=0A=
+=0A=
+bool=0A=
+  PropertyPage::DoOnceForSheet =3D=0A=
+  true;=0A=
+=0A=
+PropertyPage::PropertyPage ()=0A=
+{=0A=
+  proc =3D NULL;=0A=
+  cmdproc =3D NULL;=0A=
+  IsFirst =3D false;=0A=
+  IsLast =3D false;=0A=
+}=0A=
+=0A=
+PropertyPage::~PropertyPage ()=0A=
+{=0A=
+}=0A=
+=0A=
+bool=0A=
+PropertyPage::Create (int TemplateID)=0A=
+{=0A=
+  return Create (NULL, NULL, TemplateID);=0A=
+}=0A=
+=0A=
+bool=0A=
+PropertyPage::Create (DLGPROC dlgproc, int TemplateID)=0A=
+{=0A=
+  return Create (dlgproc, NULL, TemplateID);=0A=
+}=0A=
+=0A=
+bool=0A=
+PropertyPage::Create (DLGPROC dlgproc,=0A=
+		      BOOL (*cproc) (HWND h, int id, HWND hwndctl, UINT code),=0A=
+		      int TemplateID)=0A=
+{=0A=
+  psp.dwSize =3D sizeof (PROPSHEETPAGE);=0A=
+  psp.dwFlags =3D 0;=0A=
+  psp.hInstance =3D GetInstance ();=0A=
+  psp.pfnDlgProc =3D FirstDialogProcReflector;=0A=
+  psp.pszTemplate =3D (LPCSTR) TemplateID;=0A=
+  psp.lParam =3D (LPARAM) this;=0A=
+  psp.pfnCallback =3D NULL;=0A=
+=0A=
+  proc =3D dlgproc;=0A=
+  cmdproc =3D cproc;=0A=
+=0A=
+  return true;=0A=
+}=0A=
+=0A=
+BOOL CALLBACK=0A=
+PropertyPage::FirstDialogProcReflector (HWND hwnd, UINT message,=0A=
+					WPARAM wParam, LPARAM lParam)=0A=
+{=0A=
+  PropertyPage *This;=0A=
+=0A=
+  if (message !=3D WM_INITDIALOG)=0A=
+    {=0A=
+      // Don't handle anything until we get a WM_INITDIALOG message, which=
=0A=
+      // will have our this pointer with it.=0A=
+      return FALSE;=0A=
+    }=0A=
+=0A=
+  This =3D (PropertyPage *) (((PROPSHEETPAGE *) lParam)->lParam);=0A=
+=0A=
+  SetWindowLong (hwnd, DWL_USER, (DWORD) This);=0A=
+  SetWindowLong (hwnd, DWL_DLGPROC, (DWORD) DialogProcReflector);=0A=
+=0A=
+  This->SetHWND (hwnd);=0A=
+  return This->DialogProc (message, wParam, lParam);=0A=
+}=0A=
+=0A=
+BOOL CALLBACK=0A=
+PropertyPage::DialogProcReflector (HWND hwnd, UINT message, WPARAM wParam,=
=0A=
+				   LPARAM lParam)=0A=
+{=0A=
+  PropertyPage *This;=0A=
+=0A=
+  This =3D (PropertyPage *) GetWindowLong (hwnd, DWL_USER);=0A=
+=0A=
+  return This->DialogProc (message, wParam, lParam);=0A=
+}=0A=
+=0A=
+BOOL CALLBACK=0A=
+PropertyPage::DialogProc (UINT message, WPARAM wParam, LPARAM lParam)=0A=
+{=0A=
+  if (proc !=3D NULL)=0A=
+    {=0A=
+      proc (GetHWND (), message, wParam, lParam);=0A=
+    }=0A=
+=0A=
+  bool retval;=0A=
+=0A=
+  switch (message)=0A=
+    {=0A=
+    case WM_INITDIALOG:=0A=
+      {=0A=
+	OnInit ();=0A=
+	// TRUE =3D Set focus to default control (in wParam).=0A=
+	return TRUE;=0A=
+	break;=0A=
+      }=0A=
+    case WM_NOTIFY:=0A=
+      switch (((NMHDR FAR *) lParam)->code)=0A=
+	{=0A=
+	case PSN_APPLY:=0A=
+	  SetWindowLong (GetHWND (), DWL_MSGRESULT, PSNRET_NOERROR);=0A=
+	  return TRUE;=0A=
+	  break;=0A=
+	case PSN_SETACTIVE:=0A=
+	  {=0A=
+	    if (DoOnceForSheet)=0A=
+	      {=0A=
+		// Tell our parent PropSheet what its own HWND is.=0A=
+		GetOwner ()->SetHWNDFromPage (((NMHDR FAR *) lParam)->=0A=
+					      hwndFrom);=0A=
+		GetOwner ()->CenterWindow ();=0A=
+		// Add a minimize box to the parent property sheet.  We do this here=0A=
+		// instead of in the sheet class mainly because it will work with either=
=0A=
+		// modal or modeless sheets.=0A=
+		LONG style =3D::GetWindowLong (((NMHDR FAR *) lParam)->hwndFrom,=0A=
+					     GWL_STYLE);=0A=
+		::SetWindowLong (((NMHDR FAR *) lParam)->hwndFrom, GWL_STYLE,=0A=
+				 style | WS_MINIMIZEBOX);=0A=
+		DoOnceForSheet =3D false;=0A=
+	      }=0A=
+=0A=
+	    // Set the wizard buttons apropriately=0A=
+	    if (IsFirst)=0A=
+	      {=0A=
+		// Disable "Back" on first page.=0A=
+		GetOwner ()->SetButtons (PSWIZB_NEXT);=0A=
+		//::PropSheet_SetWizButtons(((NMHDR FAR *) lParam)->hwndFrom, PSWIZB_NEX=
T);=0A=
+	      }=0A=
+	    else if (IsLast)=0A=
+	      {=0A=
+		// Disable "Next", enable "Finish" on last page=0A=
+		GetOwner ()->SetButtons (PSWIZB_BACK | PSWIZB_FINISH);=0A=
+		//::PropSheet_SetWizButtons(((NMHDR FAR *) lParam)->hwndFrom, PSWIZB_BAC=
K | PSWIZB_FINISH);=0A=
+	      }=0A=
+	    else=0A=
+	      {=0A=
+		// Middle page, enable both "Next" and "Back" buttons=0A=
+		GetOwner ()->SetButtons (PSWIZB_BACK | PSWIZB_NEXT);=0A=
+		//::PropSheet_SetWizButtons(((NMHDR FAR *) lParam)->hwndFrom, PSWIZB_BAC=
K | PSWIZB_NEXT);=0A=
+	      }=0A=
+=0A=
+	    OnActivate ();=0A=
+=0A=
+	    // 0 =3D=3D Accept activation, -1 =3D Don't accept=0A=
+	    ::SetWindowLong (GetHWND (), DWL_MSGRESULT, 0);=0A=
+	    return TRUE;=0A=
+	  }=0A=
+	  break;=0A=
+	case PSN_KILLACTIVE:=0A=
+	  OnDeactivate ();=0A=
+	  // FALSE =3D Allow deactivation=0A=
+	  SetWindowLong (GetHWND (), DWL_MSGRESULT, FALSE);=0A=
+	  return TRUE;=0A=
+	  break;=0A=
+	case PSN_WIZNEXT:=0A=
+	  {=0A=
+	    LONG retval;=0A=
+	    retval =3D OnNext ();=0A=
+	    SetWindowLong (GetHWND (), DWL_MSGRESULT, retval);=0A=
+	    return TRUE;=0A=
+	  }=0A=
+	  break;=0A=
+	case PSN_WIZBACK:=0A=
+	  {=0A=
+	    LONG retval;=0A=
+	    retval =3D OnBack ();=0A=
+	    SetWindowLong (GetHWND (), DWL_MSGRESULT, retval);=0A=
+	    return TRUE;=0A=
+	  }=0A=
+	  break;=0A=
+	case PSN_WIZFINISH:=0A=
+	  retval =3D OnFinish ();=0A=
+	  // False =3D Allow the wizard to finish=0A=
+	  SetWindowLong (GetHWND (), DWL_MSGRESULT, FALSE);=0A=
+	  return TRUE;=0A=
+	  break;=0A=
+	default:=0A=
+	  // Unrecognized notification=0A=
+	  return FALSE;=0A=
+	  break;=0A=
+	}=0A=
+      break;=0A=
+    case WM_COMMAND:=0A=
+      if (cmdproc !=3D NULL)=0A=
+	{=0A=
+	  return HANDLE_WM_COMMAND (GetHWND (), wParam, lParam, cmdproc);=0A=
+	}=0A=
+      break;=0A=
+    default:=0A=
+      break;=0A=
+    }=0A=
+=0A=
+  if ((message >=3D WM_APP) && (message < 0xC000))=0A=
+    {=0A=
+      // It's a private app message=0A=
+      return OnMessageApp (message, wParam, lParam);=0A=
+    }=0A=
+=0A=
+  // Wasn't handled=0A=
+  return FALSE;=0A=
+}=0A=
Index: proppage.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: proppage.h=0A=
diff -N proppage.h=0A=
--- /dev/null	Tue May  5 13:32:27 1998=0A=
+++ proppage.h	Thu Dec 20 04:36:02 2001=0A=
@@ -0,0 +1,117 @@=0A=
+#ifndef CINSTALL_PROPPAGE_H=0A=
+#define CINSTALL_PROPPAGE_H=0A=
+=0A=
+/*=0A=
+ * Copyright (c) 2001, Gary R. Van Sickle.=0A=
+ *=0A=
+ *     This program is free software; you can redistribute it and/or modif=
y=0A=
+ *     it under the terms of the GNU General Public License as published b=
y=0A=
+ *     the Free Software Foundation; either version 2 of the License, or=
=0A=
+ *     (at your option) any later version.=0A=
+ *=0A=
+ *     A copy of the GNU General Public License can be found at=0A=
+ *     http://www.gnu.org/=0A=
+ *=0A=
+ * Written by Gary R. Van Sickle <g.r.vansickle@worldnet.att.net>=0A=
+ *=0A=
+ */=0A=
+=0A=
+// This is the header for the PropertyPage class.  It works closely with t=
he=0A=
+// PropSheet class to implement a single page of the property sheet.=0A=
+=0A=
+=0A=
+#include <windows.h>=0A=
+#include <prsht.h>=0A=
+=0A=
+#include "window.h"=0A=
+=0A=
+class PropSheet;=0A=
+=0A=
+class PropertyPage:public Window=0A=
+{=0A=
+  static bool DoOnceForSheet;=0A=
+  PROPSHEETPAGE psp;=0A=
+  DLGPROC proc;=0A=
+    BOOL (*cmdproc) (HWND h, int id, HWND hwndctl, UINT code);=0A=
+=0A=
+  // The sheet that owns this page.=0A=
+  PropSheet *OurSheet;=0A=
+=0A=
+  // For setting the back/finish buttons properly.=0A=
+  bool IsFirst, IsLast;=0A=
+=0A=
+  static BOOL CALLBACK FirstDialogProcReflector (HWND hwnd, UINT message,=
=0A=
+						 WPARAM wParam,=0A=
+						 LPARAM lParam);=0A=
+  static BOOL CALLBACK DialogProcReflector (HWND hwnd, UINT message,=0A=
+					    WPARAM wParam, LPARAM lParam);=0A=
+=0A=
+protected:=0A=
+    virtual BOOL CALLBACK DialogProc (UINT message, WPARAM wParam,=0A=
+				      LPARAM lParam);=0A=
+=0A=
+public:=0A=
+    PropertyPage ();=0A=
+    virtual ~ PropertyPage ();=0A=
+=0A=
+  PROPSHEETPAGE *GetPROPSHEETPAGEPtr ()=0A=
+  {=0A=
+    return &psp;=0A=
+  };=0A=
+=0A=
+  // FIXME: These should be private and friended to PropSheet.=0A=
+  void YouAreBeingAddedToASheet (PropSheet * ps)=0A=
+  {=0A=
+    OurSheet =3D ps;=0A=
+  };=0A=
+  void YouAreFirst ()=0A=
+  {=0A=
+    IsFirst =3D true;=0A=
+    IsLast =3D false;=0A=
+  };=0A=
+  void YouAreLast ()=0A=
+  {=0A=
+    IsFirst =3D false;=0A=
+    IsLast =3D true;=0A=
+  };=0A=
+  void YouAreMiddle ()=0A=
+  {=0A=
+    IsFirst =3D false;=0A=
+    IsLast =3D false;=0A=
+  };=0A=
+=0A=
+  virtual bool Create (int TemplateID);=0A=
+  virtual bool Create (DLGPROC dlgproc, int TemplateID);=0A=
+  virtual bool Create (DLGPROC dlgproc,=0A=
+		       BOOL (*cmdproc) (HWND h, int id, HWND hwndctl,=0A=
+					UINT code), int TemplateID);=0A=
+=0A=
+  virtual void OnInit ()=0A=
+  {=0A=
+  };=0A=
+  virtual void OnActivate ()=0A=
+  {=0A=
+  };=0A=
+  virtual void OnDeactivate ()=0A=
+  {=0A=
+  };=0A=
+  virtual long OnNext ()=0A=
+  {=0A=
+    return 0;=0A=
+  };=0A=
+  virtual long OnBack ()=0A=
+  {=0A=
+    return 0;=0A=
+  };=0A=
+  virtual bool OnFinish ()=0A=
+  {=0A=
+    return true;=0A=
+  };=0A=
+=0A=
+  PropSheet *GetOwner () const=0A=
+  {=0A=
+    return OurSheet;=0A=
+  };=0A=
+};=0A=
+=0A=
+#endif // CINSTALL_PROPPAGE_H=0A=
Index: propsheet.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: propsheet.cc=0A=
diff -N propsheet.cc=0A=
--- /dev/null	Tue May  5 13:32:27 1998=0A=
+++ propsheet.cc	Thu Dec 20 04:36:03 2001=0A=
@@ -0,0 +1,217 @@=0A=
+/*=0A=
+ * Copyright (c) 2001, Gary R. Van Sickle.=0A=
+ *=0A=
+ *     This program is free software; you can redistribute it and/or modif=
y=0A=
+ *     it under the terms of the GNU General Public License as published b=
y=0A=
+ *     the Free Software Foundation; either version 2 of the License, or=
=0A=
+ *     (at your option) any later version.=0A=
+ *=0A=
+ *     A copy of the GNU General Public License can be found at=0A=
+ *     http://www.gnu.org/=0A=
+ *=0A=
+ * Written by Gary R. Van Sickle <g.r.vansickle@worldnet.att.net>=0A=
+ *=0A=
+ */=0A=
+=0A=
+// This is the implementation of the PropSheet class.  This class encapsul=
ates=0A=
+// a Windows property sheet / wizard and interfaces with the PropertyPage =
class.=0A=
+// It's named PropSheet instead of PropertySheet because the latter confli=
cts with=0A=
+// the Windows function of the same name.=0A=
+=0A=
+#include "propsheet.h"=0A=
+#include "proppage.h"=0A=
+=0A=
+//#include <shlwapi.h>=0A=
+// ...but since there is no shlwapi.h in mingw yet:=0A=
+typedef struct _DllVersionInfo=0A=
+{=0A=
+  DWORD cbSize;=0A=
+  DWORD dwMajorVersion;=0A=
+  DWORD dwMinorVersion;=0A=
+  DWORD dwBuildNumber;=0A=
+  DWORD dwPlatformID;=0A=
+}=0A=
+DLLVERSIONINFO;=0A=
+typedef HRESULT CALLBACK (*DLLGETVERSIONPROC) (DLLVERSIONINFO * pdvi);=0A=
+#define PROPSHEETHEADER_V1_SIZE 40=0A=
+=0A=
+=0A=
+=0A=
+PropSheet::PropSheet ()=0A=
+{=0A=
+  NumPropPages =3D 0;=0A=
+}=0A=
+=0A=
+PropSheet::~PropSheet ()=0A=
+{=0A=
+}=0A=
+=0A=
+HPROPSHEETPAGE *=0A=
+PropSheet::CreatePages ()=0A=
+{=0A=
+  HPROPSHEETPAGE *retarray;=0A=
+=0A=
+  // Create the return array=0A=
+  retarray =3D new HPROPSHEETPAGE[NumPropPages];=0A=
+=0A=
+  // Create the pages with CreatePropertySheetPage().=0A=
+  // We do it here rather than in the PropertyPages themselves=0A=
+  // because, for reasons known only to Microsoft, these handles will be=
=0A=
+  // destroyed by the property sheet before the PropertySheet() call retur=
ns,=0A=
+  // at least if it's modal (don't know about modeless).=0A=
+  int i;=0A=
+  for (i =3D 0; i < NumPropPages; i++)=0A=
+    {=0A=
+      retarray[i] =3D=0A=
+	CreatePropertySheetPage (PropertyPages[i]->GetPROPSHEETPAGEPtr ());=0A=
+=0A=
+      // Set position info=0A=
+      if (i =3D=3D 0)=0A=
+	{=0A=
+	  PropertyPages[i]->YouAreFirst ();=0A=
+	}=0A=
+      else if (i =3D=3D NumPropPages - 1)=0A=
+	{=0A=
+	  PropertyPages[i]->YouAreLast ();=0A=
+	}=0A=
+      else=0A=
+	{=0A=
+	  PropertyPages[i]->YouAreMiddle ();=0A=
+	}=0A=
+    }=0A=
+=0A=
+  return retarray;=0A=
+}=0A=
+=0A=
+static DWORD=0A=
+GetPROPSHEETHEADERSize ()=0A=
+{=0A=
+  // For compatibility with all versions of comctl32.dll, we have to do th=
is.=0A=
+=0A=
+  DLLVERSIONINFO vi;=0A=
+  HMODULE mod;=0A=
+  DLLGETVERSIONPROC DllGetVersion;=0A=
+  DWORD retval =3D 0;=0A=
+=0A=
+=0A=
+  // This 'isn't safe' in a DLL, according to MSDN=0A=
+  mod =3D LoadLibrary ("comctl32.dll");=0A=
+=0A=
+  DllGetVersion =3D (DLLGETVERSIONPROC) GetProcAddress (mod, "DllGetVersio=
n");=0A=
+  if (DllGetVersion =3D=3D NULL)=0A=
+    {=0A=
+      // Something's wildly broken, punt.=0A=
+      retval =3D PROPSHEETHEADER_V1_SIZE;=0A=
+    }=0A=
+  else=0A=
+    {=0A=
+      vi.cbSize =3D sizeof (DLLVERSIONINFO);=0A=
+      DllGetVersion (&vi);=0A=
+=0A=
+      if ((vi.dwMajorVersion < 4) ||=0A=
+	  ((vi.dwMajorVersion =3D=3D 4) && (vi.dwMinorVersion < 71)))=0A=
+	{=0A=
+	  // Recent.=0A=
+	  retval =3D sizeof (PROPSHEETHEADER);=0A=
+	}=0A=
+      else=0A=
+	{=0A=
+	  // Old (=3D=3D Win95/NT4 w/o IE 4 or better)=0A=
+	  retval =3D PROPSHEETHEADER_V1_SIZE;=0A=
+	}=0A=
+    }=0A=
+=0A=
+  FreeLibrary (mod);=0A=
+=0A=
+  return retval;=0A=
+}=0A=
+=0A=
+bool=0A=
+PropSheet::Create (const Window * Parent, DWORD Style)=0A=
+{=0A=
+  PROPSHEETHEADER p;=0A=
+=0A=
+  PageHandles =3D CreatePages ();=0A=
+=0A=
+  p.dwSize =3D GetPROPSHEETHEADERSize ();=0A=
+  p.dwFlags =3D PSH_NOAPPLYNOW | PSH_WIZARD /*| PSH_MODELESS */ ;=0A=
+  if (Parent !=3D NULL)=0A=
+    {=0A=
+      p.hwndParent =3D Parent->GetHWND ();=0A=
+    }=0A=
+  else=0A=
+    {=0A=
+      p.hwndParent =3D NULL;=0A=
+    }=0A=
+  p.hInstance =3D GetInstance ();=0A=
+  p.nPages =3D NumPropPages;=0A=
+  p.nStartPage =3D 0;=0A=
+  p.phpage =3D PageHandles;=0A=
+  p.pfnCallback =3D NULL;=0A=
+=0A=
+=0A=
+  PropertySheet (&p);=0A=
+=0A=
+  // Do a modeless property sheet...=0A=
+  //SetHWND((HWND)PropertySheet(&p));=0A=
+  /*Show(SW_SHOWNORMAL);=0A=
+=0A=
+     // ...but pretend it's modal=0A=
+     MessageLoop();=0A=
+     MessageBox(NULL, "DONE", NULL, MB_OK);=0A=
+=0A=
+     // FIXME: Enable the parent before destroying this window to prevent =
another window=0A=
+     // from becoming the foreground window=0A=
+     // ala: EnableWindow(<parent_hwnd>, TRUE);=0A=
+     //DestroyWindow(WindowHandle);=0A=
+   */=0A=
+  SetHWND (NULL);=0A=
+=0A=
+=0A=
+  return true;=0A=
+}=0A=
+=0A=
+void=0A=
+PropSheet::SetHWNDFromPage (HWND h)=0A=
+{=0A=
+  // If we're a modal dialog, there's no way for us to know our window han=
dle unless=0A=
+  // one of our pages tells us through this function.=0A=
+  SetHWND (h);=0A=
+}=0A=
+=0A=
+void=0A=
+PropSheet::AddPage (PropertyPage * p)=0A=
+{=0A=
+  // Add a page to the property sheet.=0A=
+  p->YouAreBeingAddedToASheet (this);=0A=
+  PropertyPages[NumPropPages] =3D p;=0A=
+  NumPropPages++;=0A=
+}=0A=
+=0A=
+bool=0A=
+PropSheet::SetActivePage (int i)=0A=
+{=0A=
+  // Posts a message to the message queue, so this won't block=0A=
+  return static_cast < bool > (::PropSheet_SetCurSel (GetHWND (), NULL, i)=
);=0A=
+}=0A=
+=0A=
+bool=0A=
+PropSheet::SetActivePageByID (int resource_id)=0A=
+{=0A=
+  // Posts a message to the message queue, so this won't block=0A=
+  return static_cast < bool >=0A=
+    (::PropSheet_SetCurSelByID (GetHWND (), resource_id));=0A=
+}=0A=
+=0A=
+void=0A=
+PropSheet::SetButtons (DWORD flags)=0A=
+{=0A=
+  // Posts a message to the message queue, so this won't block=0A=
+  ::PropSheet_SetWizButtons (GetHWND (), flags);=0A=
+}=0A=
+=0A=
+void=0A=
+PropSheet::PressButton (int button)=0A=
+{=0A=
+  ::PropSheet_PressButton (GetHWND (), button);=0A=
+}=0A=
Index: propsheet.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: propsheet.h=0A=
diff -N propsheet.h=0A=
--- /dev/null	Tue May  5 13:32:27 1998=0A=
+++ propsheet.h	Thu Dec 20 04:36:03 2001=0A=
@@ -0,0 +1,59 @@=0A=
+#ifndef CINSTALL_PROPSHEET_H=0A=
+#define CINSTALL_PROPSHEET_H=0A=
+=0A=
+/*=0A=
+ * Copyright (c) 2001, Gary R. Van Sickle.=0A=
+ *=0A=
+ *     This program is free software; you can redistribute it and/or modif=
y=0A=
+ *     it under the terms of the GNU General Public License as published b=
y=0A=
+ *     the Free Software Foundation; either version 2 of the License, or=
=0A=
+ *     (at your option) any later version.=0A=
+ *=0A=
+ *     A copy of the GNU General Public License can be found at=0A=
+ *     http://www.gnu.org/=0A=
+ *=0A=
+ * Written by Gary R. Van Sickle <g.r.vansickle@worldnet.att.net>=0A=
+ *=0A=
+ */=0A=
+=0A=
+// This is the header for the PropSheet class.  This class encapsulates=0A=
+// a Windows property sheet / wizard and interfaces with the PropertyPage =
class.=0A=
+// It's named PropSheet instead of PropertySheet because the latter confli=
cts with=0A=
+// the Windows function of the same name.=0A=
+=0A=
+=0A=
+#include <windows.h>=0A=
+#include <prsht.h>=0A=
+=0A=
+#include "window.h"=0A=
+=0A=
+class PropertyPage;=0A=
+=0A=
+class PropSheet:public Window=0A=
+{=0A=
+  PropertyPage *PropertyPages[MAXPROPPAGES];=0A=
+  int NumPropPages;=0A=
+=0A=
+  HPROPSHEETPAGE *PageHandles;=0A=
+  HPROPSHEETPAGE *CreatePages ();=0A=
+=0A=
+public:=0A=
+    PropSheet ();=0A=
+    virtual ~ PropSheet ();=0A=
+=0A=
+  // Should be private and friended to PropertyPage=0A=
+  void SetHWNDFromPage (HWND h);=0A=
+=0A=
+  virtual bool Create (const Window * Parent =3D NULL,=0A=
+		       DWORD Style =3D=0A=
+		       WS_OVERLAPPEDWINDOW | WS_VISIBLE | WS_CLIPCHILDREN);=0A=
+=0A=
+  void AddPage (PropertyPage * p);=0A=
+=0A=
+  bool SetActivePage (int i);=0A=
+  bool SetActivePageByID (int resource_id);=0A=
+  void SetButtons (DWORD flags);=0A=
+  void PressButton (int button);=0A=
+};=0A=
+=0A=
+#endif // CINSTALL_PROPSHEET_H=0A=
Index: res.rc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/res.rc,v=0A=
retrieving revision 2.31=0A=
diff -u -p -r2.31 res.rc=0A=
--- res.rc	2001/12/03 22:22:09	2.31=0A=
+++ res.rc	2001/12/20 12:36:03=0A=
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
@@ -223,17 +211,26 @@ BEGIN=0A=
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
-    WS_SYSMENU=0A=
+IDD_CHOOSE DIALOGEX 0, 0, 430, 266=0A=
+STYLE DS_MODALFRAME | DS_3DLOOK | DS_CENTER | WS_CHILD | WS_VISIBLE |=20=
=0A=
+    WS_CAPTION | WS_SYSMENU=0A=
+EXSTYLE WS_EX_CONTROLPARENT=0A=
 CAPTION "Cygwin Setup"=0A=
 FONT 8, "MS Sans Serif"=0A=
 BEGIN=0A=
-    ICON            IDI_CYGWIN,IDC_STATIC,0,2,21,20=0A=
+    DEFPUSHBUTTON   "&Next -->",IDOK,311,242,45,15,WS_GROUP=0A=
+    PUSHBUTTON      "Cancel",IDCANCEL,375,242,45,15=0A=
+    PUSHBUTTON      "<-- &Back",IDC_BACK,266,242,45,15=0A=
+    CONTROL         "&Prev",IDC_CHOOSE_PREV,"Button",BS_AUTORADIOBUTTON |=
=20=0A=
+                    WS_GROUP | WS_TABSTOP,265,5,27,10=0A=
+    CONTROL         "&Curr",IDC_CHOOSE_CURR,"Button",BS_AUTORADIOBUTTON,29=
7,=0A=
+                    5,25,10=0A=
+    CONTROL         "E&xp",IDC_CHOOSE_EXP,"Button",BS_AUTORADIOBUTTON,323,=
5,=0A=
+                    25,10=0A=
+    PUSHBUTTON      "&View",IDC_CHOOSE_VIEW,353,5,20,10,WS_GROUP=0A=
+    ICON            IDI_CYGWIN,IDC_STATIC,0,2,20,20=0A=
     LTEXT           "Select packages to install",IDC_CHOOSE_INST_TEXT,125,=
5,=0A=
                     99,8=0A=
     CONTROL         "",IDC_LISTVIEW_POS,"Static",SS_BLACKFRAME | NOT=20=0A=
@@ -241,21 +238,12 @@ BEGIN=0A=
     CONTROL         "SPIN",IDC_STATIC,"Static",SS_BITMAP,22,235,15,13=0A=
     LTEXT           "=3D click to choose action, (p) =3D previous version,=
 (x) =3D experimental",=0A=
                     IDC_STATIC,35,234,220,8=0A=
-    PUSHBUTTON      "&View",IDC_CHOOSE_VIEW,353,5,20,10=0A=
     LTEXT           "",IDC_CHOOSE_VIEWCAPTION,390,5,30,10=0A=
-    CONTROL         "E&xp",IDC_CHOOSE_EXP,"Button",BS_AUTORADIOBUTTON |=20=
=0A=
-                    WS_GROUP,323,5,25,10=0A=
-    CONTROL         "&Prev",IDC_CHOOSE_PREV,"Button",BS_AUTORADIOBUTTON,26=
5,=0A=
-                    5,27,10=0A=
-    CONTROL         "&Curr",IDC_CHOOSE_CURR,"Button",BS_AUTORADIOBUTTON,29=
7,=0A=
-                    5,25,10=0A=
-    DEFPUSHBUTTON   "&Next -->",IDOK,311,242,45,15=0A=
-    PUSHBUTTON      "Cancel",IDCANCEL,375,242,45,15=0A=
-    PUSHBUTTON      "<-- &Back",IDC_BACK,266,242,45,15=0A=
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
@@ -264,12 +252,9 @@ BEGIN=0A=
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
@@ -286,7 +271,16 @@ BEGIN=0A=
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
=20=0A=
+=0A=
 #ifdef APSTUDIO_INVOKED=0A=
 //////////////////////////////////////////////////////////////////////////=
///=0A=
 //=0A=
@@ -339,9 +333,21 @@ CYGWIN.ICON             FILE    DISCARDA=0A=
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
@@ -354,10 +360,23 @@ BEGIN=0A=
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
@@ -409,6 +428,7 @@ BEGIN=0A=
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
retrieving revision 2.13=0A=
diff -u -p -r2.13 resource.h=0A=
--- resource.h	2001/12/20 11:49:54	2.13=0A=
+++ resource.h	2001/12/20 12:36:03=0A=
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
@@ -99,9 +101,12 @@=0A=
 #define IDC_DLS_PROGRESS_TEXT           1047=0A=
 #define IDC_DLS_PPROGRESS_TEXT          1048=0A=
 #define IDC_DLS_IPROGRESS_TEXT          1049=0A=
-#define IDC_CHOOSE_INST_TEXT      1050=0A=
+#define IDC_CHOOSE_INST_TEXT            1050=0A=
 #define IDC_CHOOSE_VIEWCAPTION          1051=0A=
 #define IDC_CHOOSE_LISTHEADER		1052=0A=
+#define IDC_INS_BL_PACKAGE              1053=0A=
+#define IDC_INS_BL_TOTAL                1054=0A=
+#define IDC_INS_BL_DISK                 1055=0A=
 #define IDC_STATIC                      -1=0A=
=20=0A=
 // Next default values for new objects=0A=
@@ -110,9 +115,9 @@=0A=
 #ifndef APSTUDIO_READONLY_SYMBOLS=0A=
 #define _APS_NO_MFC                     1=0A=
 #define _APS_3D_CONTROLS                     1=0A=
-#define _APS_NEXT_RESOURCE_VALUE        127=0A=
+#define _APS_NEXT_RESOURCE_VALUE        128=0A=
 #define _APS_NEXT_COMMAND_VALUE         40003=0A=
-#define _APS_NEXT_CONTROL_VALUE         1053=0A=
+#define _APS_NEXT_CONTROL_VALUE         1056=0A=
 #define _APS_NEXT_SYMED_VALUE           101=0A=
 #endif=0A=
 #endif=0A=
Index: root.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/root.cc,v=0A=
retrieving revision 2.7=0A=
diff -u -p -r2.7 root.cc=0A=
--- root.cc	2001/11/13 01:49:32	2.7=0A=
+++ root.cc	2001/12/20 12:36:03=0A=
@@ -35,6 +35,7 @@ static const char *cvsid =3D=0A=
 #include "mount.h"=0A=
 #include "concat.h"=0A=
 #include "log.h"=0A=
+#include "root.h"=0A=
=20=0A=
 static int rb[] =3D { IDC_ROOT_TEXT, IDC_ROOT_BINARY, 0 };=0A=
 static int su[] =3D { IDC_ROOT_SYSTEM, IDC_ROOT_USER, 0 };=0A=
@@ -143,64 +144,56 @@ dialog_cmd (HWND h, int id, HWND hwndctl=0A=
     case IDC_ROOT_BROWSE:=0A=
       browse (h);=0A=
       break;=0A=
-=0A=
-    case IDOK:=0A=
-      save_dialog (h);=0A=
-=0A=
-      if (!directory_is_absolute ())=0A=
-	{=0A=
-	  note (IDS_ROOT_ABSOLUTE);=0A=
-	  break;=0A=
-	}=0A=
-=0A=
-      if (directory_is_rootdir ())=0A=
-	if (IDNO =3D=3D yesno (IDS_ROOT_SLASH))=0A=
-	  break;=0A=
-=0A=
-      if (directory_has_spaces ())=0A=
-	if (IDNO =3D=3D yesno (IDS_ROOT_SPACE))=0A=
-	  break;=0A=
-=0A=
-      NEXT (IDD_LOCAL_DIR);=0A=
-      break;=0A=
-=0A=
-    case IDC_BACK:=0A=
-      save_dialog (h);=0A=
-      NEXT (IDD_SOURCE);=0A=
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
+bool=0A=
+RootPage::Create ()=0A=
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
+  return PropertyPage::Create (NULL, dialog_cmd, IDD_ROOT);=0A=
 }=0A=
=20=0A=
 void=0A=
-do_root (HINSTANCE h)=0A=
+RootPage::OnInit ()=0A=
 {=0A=
-  int rv =3D 0;=0A=
   if (!get_root_dir ())=0A=
     read_mounts ();=0A=
-  rv =3D DialogBox (h, MAKEINTRESOURCE (IDD_ROOT), 0, dialog_proc);=0A=
-  if (rv =3D=3D -1)=0A=
-    fatal (IDS_DIALOG_FAILED);=0A=
+  load_dialog (GetHWND ());=0A=
+}=0A=
=20=0A=
+long=0A=
+RootPage::OnNext ()=0A=
+{=0A=
+  HWND h =3D GetHWND ();=0A=
+=0A=
+  save_dialog (h);=0A=
+=0A=
+  if (!directory_is_absolute ())=0A=
+    {=0A=
+      note (h, IDS_ROOT_ABSOLUTE);=0A=
+      return -1;=0A=
+    }=0A=
+  else if (directory_is_rootdir () && (IDNO =3D=3D yesno (h, IDS_ROOT_SLAS=
H)))=0A=
+    return -1;=0A=
+  else if (directory_has_spaces () && (IDNO =3D=3D yesno (h, IDS_ROOT_SPAC=
E)))=0A=
+    return -1;=0A=
+=0A=
+  NEXT (IDD_LOCAL_DIR);=0A=
+=0A=
   log (0, "root: %s %s %s", get_root_dir (),=0A=
        (root_text =3D=3D IDC_ROOT_TEXT) ? "text" : "binary",=0A=
        (root_scope =3D=3D IDC_ROOT_USER) ? "user" : "system");=0A=
+=0A=
+  return 0;=0A=
+}=0A=
+=0A=
+long=0A=
+RootPage::OnBack ()=0A=
+{=0A=
+  HWND h =3D GetHWND ();=0A=
+=0A=
+  save_dialog (h);=0A=
+  NEXT (IDD_SOURCE);=0A=
+  return 0;=0A=
 }=0A=
Index: root.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: root.h=0A=
diff -N root.h=0A=
--- /dev/null	Tue May  5 13:32:27 1998=0A=
+++ root.h	Thu Dec 20 04:36:03 2001=0A=
@@ -0,0 +1,23 @@=0A=
+#ifndef CINSTALL_ROOT_H=0A=
+#define CINSTALL_ROOT_H=0A=
+=0A=
+#include "proppage.h"=0A=
+=0A=
+class RootPage:public PropertyPage=0A=
+{=0A=
+public:=0A=
+  RootPage ()=0A=
+  {=0A=
+  };=0A=
+  virtual ~ RootPage ()=0A=
+  {=0A=
+  };=0A=
+=0A=
+  bool Create ();=0A=
+=0A=
+  void OnInit ();=0A=
+  virtual long OnNext ();=0A=
+  virtual long OnBack ();=0A=
+};=0A=
+=0A=
+#endif // CINSTALL_ROOT_H=0A=
Index: site.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/site.cc,v=0A=
retrieving revision 2.10=0A=
diff -u -p -r2.10 site.cc=0A=
--- site.cc	2001/12/03 22:22:09	2.10=0A=
+++ site.cc	2001/12/20 12:36:03=0A=
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
+	{=0A=
+	  // Highlight the selected item=0A=
+	  SendMessage (listbox, LB_SELITEMRANGE, TRUE, (index << 16) | index);=0A=
+	  // Make sure it's fully visible=0A=
+	  SendMessage (listbox, LB_SETCARETINDEX, index, FALSE);=0A=
+	}=0A=
     }=0A=
   check_if_enable_next (h);=0A=
 }=0A=
@@ -167,63 +179,18 @@ dialog_cmd (HWND h, int id, HWND hwndctl=0A=
     case IDC_URL_LIST:=0A=
       check_if_enable_next (h);=0A=
       break;=0A=
-=0A=
-    case IDOK:=0A=
-      save_dialog (h);=0A=
-      if (mirror_idx =3D=3D OTHER_IDX)=0A=
-	NEXT (IDD_OTHER_URL);=0A=
-      else=0A=
-	{=0A=
-	  save_site_url ();=0A=
-	  NEXT (IDD_S_LOAD_INI);=0A=
-	}=0A=
-      break;=0A=
-=0A=
-    case IDC_BACK:=0A=
-      save_dialog (h);=0A=
-      NEXT (IDD_NET);=0A=
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
-{=0A=
-  int j;=0A=
-  HWND listbox;=0A=
-  switch (message)=0A=
-    {=0A=
-    case WM_INITDIALOG:=0A=
-      listbox =3D GetDlgItem (h, IDC_URL_LIST);=0A=
-      for (size_t i =3D 1; i <=3D all_site_list.number (); i++)=0A=
-	{=0A=
-	  j =3D=0A=
-	    SendMessage (listbox, LB_ADDSTRING, 0,=0A=
-			 (LPARAM) all_site_list[i]->displayed_url);=0A=
-	  SendMessage (listbox, LB_SETITEMDATA, j, i);=0A=
-	}=0A=
-      j =3D SendMessage (listbox, LB_ADDSTRING, 0, (LPARAM) "Other URL");=
=0A=
-      SendMessage (listbox, LB_SETITEMDATA, j, OTHER_IDX);=0A=
-      load_dialog (h);=0A=
-      return FALSE;=0A=
-    case WM_COMMAND:=0A=
-      return HANDLE_WM_COMMAND (h, wParam, lParam, dialog_cmd);=0A=
-    }=0A=
-  return FALSE;=0A=
-}=0A=
-=0A=
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
@@ -320,24 +287,106 @@ get_saved_sites ()=0A=
=20=0A=
 }=0A=
=20=0A=
-void=0A=
-do_site (HINSTANCE h)=0A=
+static void=0A=
+do_download_site_info_thread (void *p)=0A=
 {=0A=
-  int rv =3D 0;=0A=
+  HANDLE *context;=0A=
+  HINSTANCE hinst;=0A=
+  HWND h;=0A=
+  context =3D (HANDLE *) p;=0A=
+=0A=
+  hinst =3D (HINSTANCE) (context[0]);=0A=
+  h =3D (HWND) (context[1]);=0A=
=20=0A=
   if (all_site_list.number () =3D=3D 0)=0A=
-    if (get_site_list (h))=0A=
-      {=0A=
-	NEXT (IDD_NET);=0A=
-	return;=0A=
-      }=0A=
+    {=0A=
+      if (get_site_list (hinst, h))=0A=
+	{=0A=
+	  // Error: Couldn't download the site info.  Go back to the Net setup pa=
ge.=0A=
+	  NEXT (IDD_NET);=0A=
+	  return;=0A=
+	}=0A=
+    }=0A=
+=0A=
+  // Everything worked, go to the site select page=0A=
+  NEXT (IDD_SITE);=0A=
+=0A=
+  // Tell the progress page that we're done downloading=0A=
+  Progress.PostMessage (WM_APP_SITE_INFO_DOWNLOAD_COMPLETE, 0, next_dialog=
);=0A=
+=0A=
+  _endthread ();=0A=
+}=0A=
=20=0A=
+static HANDLE context[2];=0A=
+=0A=
+void=0A=
+do_download_site_info (HINSTANCE hinst, HWND owner)=0A=
+{=0A=
+=0A=
+  context[0] =3D hinst;=0A=
+  context[1] =3D owner;=0A=
+=0A=
+  _beginthread (do_download_site_info_thread, 0, context);=0A=
+=0A=
+}=0A=
+=0A=
+bool=0A=
+SitePage::Create ()=0A=
+{=0A=
+  return PropertyPage::Create (NULL, dialog_cmd, IDD_SITE);=0A=
+}=0A=
+=0A=
+void=0A=
+SitePage::OnInit ()=0A=
+{=0A=
+  HWND h =3D GetHWND ();=0A=
+  int j;=0A=
+  HWND listbox;=0A=
+=0A=
   get_saved_sites ();=0A=
+=0A=
+  listbox =3D GetDlgItem (IDC_URL_LIST);=0A=
+  for (size_t i =3D 1; i <=3D all_site_list.number (); i++)=0A=
+    {=0A=
+      j =3D=0A=
+	SendMessage (listbox, LB_ADDSTRING, 0,=0A=
+		     (LPARAM) all_site_list[i]->displayed_url);=0A=
+      SendMessage (listbox, LB_SETITEMDATA, j, i);=0A=
+    }=0A=
+  j =3D SendMessage (listbox, LB_ADDSTRING, 0, (LPARAM) "Other URL");=0A=
+  SendMessage (listbox, LB_SETITEMDATA, j, OTHER_IDX);=0A=
+  load_dialog (h);=0A=
+}=0A=
=20=0A=
-  rv =3D DialogBox (h, MAKEINTRESOURCE (IDD_SITE), 0, dialog_proc);=0A=
-  if (rv =3D=3D -1)=0A=
-    fatal (IDS_DIALOG_FAILED);=0A=
+long=0A=
+SitePage::OnNext ()=0A=
+{=0A=
+  HWND h =3D GetHWND ();=0A=
=20=0A=
-  for (size_t n =3D 1; n <=3D site_list.number (); n++)=0A=
-    log (0, "site: %s", site_list[n]->url);=0A=
+  save_dialog (h);=0A=
+  if (mirror_idx =3D=3D OTHER_IDX)=0A=
+    NEXT (IDD_OTHER_URL);=0A=
+  else=0A=
+    {=0A=
+      save_site_url ();=0A=
+      NEXT (IDD_S_LOAD_INI);=0A=
+=0A=
+      for (size_t n =3D 1; n <=3D site_list.number (); n++)=0A=
+	log (0, "site: %s", site_list[n]->url);=0A=
+=0A=
+      Progress.SetActivateTask (WM_APP_START_SETUP_INI_DOWNLOAD);=0A=
+      return IDD_INSTATUS;=0A=
+    }=0A=
+=0A=
+  return 0;=0A=
+}=0A=
+=0A=
+long=0A=
+SitePage::OnBack ()=0A=
+{=0A=
+  HWND h =3D GetHWND ();=0A=
+=0A=
+  save_dialog (h);=0A=
+  NEXT (IDD_NET);=0A=
+  return 0;=0A=
 }=0A=
Index: site.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/site.h,v=0A=
retrieving revision 2.1=0A=
diff -u -p -r2.1 site.h=0A=
--- site.h	2001/12/03 22:22:09	2.1=0A=
+++ site.h	2001/12/20 12:36:03=0A=
@@ -17,17 +17,41 @@=0A=
 #define _SITE_H_=0A=
=20=0A=
 /* required to parse this file */=0A=
-#include <strings.h>=0A=
+#include <string.h>=0A=
+#include <stdlib.h>=0A=
 #include "list.h"=0A=
=20=0A=
+#include "proppage.h"=0A=
+=0A=
+class SitePage:public PropertyPage=0A=
+{=0A=
+public:=0A=
+  SitePage ()=0A=
+  {=0A=
+  };=0A=
+  virtual ~ SitePage ()=0A=
+  {=0A=
+  };=0A=
+=0A=
+  bool Create ();=0A=
+=0A=
+  void OnInit ();=0A=
+  long OnNext ();=0A=
+  long OnBack ();=0A=
+};=0A=
+=0A=
+void do_download_site_info (HINSTANCE h, HWND owner);=0A=
+=0A=
 class site_list_type=0A=
 {=0A=
 public:=0A=
-  site_list_type () : url(0), displayed_url (0), key (0) {};=0A=
+  site_list_type ():url (0), displayed_url (0), key (0)=0A=
+  {=0A=
+  };=0A=
   site_list_type (char const *);=0A=
   /* workaround for missing placement new in gcc 2.95 */=0A=
   void init (char const *);=0A=
-  ~site_list_type ()=20=0A=
+  ~site_list_type ()=0A=
   {=0A=
     if (url)=0A=
       free (url);=0A=
@@ -42,9 +66,9 @@ public:=0A=
 };=0A=
=20=0A=
 /* user chosen sites */=0A=
-extern list <site_list_type, const char *, strcasecmp> site_list;=0A=
+extern list < site_list_type, const char *, strcasecmp > site_list;=0A=
 /* potential sites */=0A=
-extern list <site_list_type, const char *, strcasecmp> all_site_list;=0A=
+extern list < site_list_type, const char *, strcasecmp > all_site_list;=0A=
=20=0A=
 void save_site_url ();=0A=
=20=0A=
Index: source.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/source.cc,v=0A=
retrieving revision 2.9=0A=
diff -u -p -r2.9 source.cc=0A=
--- source.cc	2001/12/20 11:49:54	2.9=0A=
+++ source.cc	2001/12/20 12:36:03=0A=
@@ -31,6 +31,8 @@ static const char *cvsid =3D=0A=
 #include "log.h"=0A=
 #include "package_db.h"=0A=
=20=0A=
+#include "source.h"=0A=
+=0A=
 static int rb[] =3D=0A=
   { IDC_SOURCE_NETINST, IDC_SOURCE_DOWNLOAD, IDC_SOURCE_CWD, 0 };=0A=
=20=0A=
@@ -45,7 +47,8 @@ save_dialog (HWND h)=0A=
 {=0A=
   source =3D rbget (h, rb);=0A=
   packagedb db;=0A=
-  db.task =3D source =3D=3D IDC_SOURCE_DOWNLOAD ? PackageDB_Download : Pac=
kageDB_Install;=0A=
+  db.task =3D=0A=
+    source =3D=3D IDC_SOURCE_DOWNLOAD ? PackageDB_Download : PackageDB_Ins=
tall;=0A=
 }=0A=
=20=0A=
 static BOOL=0A=
@@ -60,65 +63,61 @@ dialog_cmd (HWND h, int id, HWND hwndctl=0A=
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
+bool=0A=
+SourcePage::Create ()=0A=
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
-	    0) =3D=3D BST_CHECKED)=0A=
-	  && (!SendMessage (GetDlgItem (h, IDC_SOURCE_CWD), BM_GETCHECK, 0, 0)=0A=
-	      =3D=3D BST_CHECKED))=0A=
-	{=0A=
-	  SendMessage (GetDlgItem (h, IDC_SOURCE_NETINST), BM_SETCHECK,=0A=
-		       BST_CHECKED, 0);=0A=
-	}=0A=
-      return FALSE;=0A=
-    case WM_COMMAND:=0A=
-      return HANDLE_WM_COMMAND (h, wParam, lParam, dialog_cmd);=0A=
-    }=0A=
-  return FALSE;=0A=
+  return PropertyPage::Create (NULL, dialog_cmd, IDD_SOURCE);=0A=
 }=0A=
=20=0A=
 void=0A=
-do_source (HINSTANCE h)=0A=
+SourcePage::OnActivate ()=0A=
 {=0A=
-  int rv =3D 0;=0A=
-  /* source =3D IDC_SOURCE_CWD; */=0A=
   if (!source)=0A=
     source =3D IDC_SOURCE_NETINST;=0A=
-  rv =3D DialogBox (h, MAKEINTRESOURCE (IDD_SOURCE), 0, dialog_proc);=0A=
-  if (rv =3D=3D -1)=0A=
-    fatal (IDS_DIALOG_FAILED);=0A=
+  load_dialog (GetHWND ());=0A=
+  // Check to see if any radio buttons are selected. If not, select a defa=
ult.=0A=
+  if ((!SendMessage=0A=
+       (GetDlgItem (IDC_SOURCE_DOWNLOAD), BM_GETCHECK, 0,=0A=
+	0) =3D=3D BST_CHECKED)=0A=
+      && (!SendMessage (GetDlgItem (IDC_SOURCE_CWD), BM_GETCHECK, 0, 0)=0A=
+	  =3D=3D BST_CHECKED))=0A=
+    {=0A=
+      SendMessage (GetDlgItem (IDC_SOURCE_NETINST), BM_SETCHECK,=0A=
+		   BST_CHECKED, 0);=0A=
+    }=0A=
+}=0A=
=20=0A=
+long=0A=
+SourcePage::OnNext ()=0A=
+{=0A=
+  HWND h =3D GetHWND ();=0A=
+=0A=
+  save_dialog (h);=0A=
+  if (source =3D=3D IDC_SOURCE_DOWNLOAD)=0A=
+    {=0A=
+      // If all we're doing is downloading,skip the root directory page=0A=
+      return IDD_LOCAL_DIR;=0A=
+    }=0A=
+=0A=
+  return 0;=0A=
+}=0A=
+=0A=
+long=0A=
+SourcePage::OnBack ()=0A=
+{=0A=
+  save_dialog (GetHWND ());=0A=
+  return 0;=0A=
+}=0A=
+=0A=
+void=0A=
+SourcePage::OnDeactivate ()=0A=
+{=0A=
   log (0, "source: %s",=0A=
        (source =3D=3D IDC_SOURCE_DOWNLOAD) ? "download" :=0A=
        (source =3D=3D IDC_SOURCE_NETINST) ? "network install" : "from cwd"=
);=0A=
Index: source.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: source.h=0A=
diff -N source.h=0A=
--- /dev/null	Tue May  5 13:32:27 1998=0A=
+++ source.h	Thu Dec 20 04:36:03 2001=0A=
@@ -0,0 +1,43 @@=0A=
+#ifndef CINSTALL_SOURCE_H=0A=
+#define CINSTALL_SOURCE_H=0A=
+=0A=
+/*=0A=
+ * Copyright (c) 2001, Gary R. Van Sickle.=0A=
+ *=0A=
+ *     This program is free software; you can redistribute it and/or modif=
y=0A=
+ *     it under the terms of the GNU General Public License as published b=
y=0A=
+ *     the Free Software Foundation; either version 2 of the License, or=
=0A=
+ *     (at your option) any later version.=0A=
+ *=0A=
+ *     A copy of the GNU General Public License can be found at=0A=
+ *     http://www.gnu.org/=0A=
+ *=0A=
+ * Written by Gary R. Van Sickle <g.r.vansickle@worldnet.att.net>=0A=
+ *=0A=
+ */=0A=
+=0A=
+// This is the header for the SourcePage class, which lets the user=0A=
+// select Download+Install, Download, or Install From Local Directory.=0A=
+=0A=
+=0A=
+#include "proppage.h"=0A=
+=0A=
+class SourcePage:public PropertyPage=0A=
+{=0A=
+public:=0A=
+  SourcePage ()=0A=
+  {=0A=
+  };=0A=
+  virtual ~ SourcePage ()=0A=
+  {=0A=
+  };=0A=
+=0A=
+  bool Create ();=0A=
+=0A=
+  void OnActivate ();=0A=
+  void OnDeactivate ();=0A=
+  long OnNext ();=0A=
+  long OnBack ();=0A=
+};=0A=
+=0A=
+#endif=0A=
Index: splash.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/splash.cc,v=0A=
retrieving revision 2.6=0A=
diff -u -p -r2.6 splash.cc=0A=
--- splash.cc	2001/11/13 01:49:32	2.6=0A=
+++ splash.cc	2001/12/20 12:36:03=0A=
@@ -1,5 +1,5 @@=0A=
 /*=0A=
- * Copyright (c) 2000, Red Hat, Inc.=0A=
+ * Copyright (c) 2001, Gary R. Van Sickle.=0A=
  *=0A=
  *     This program is free software; you can redistribute it and/or modif=
y=0A=
  *     it under the terms of the GNU General Public License as published b=
y=0A=
@@ -9,71 +9,31 @@=0A=
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
+bool=0A=
+SplashPage::Create ()=0A=
 {=0A=
-  char buffer[100];=0A=
-  HWND v =3D GetDlgItem (h, IDC_VERSION);=0A=
-  sprintf (buffer, "Setup.exe version %s",=0A=
-	   version[0] ? version : "[unknown]");=0A=
-  SetWindowText (v, buffer);=0A=
+  return PropertyPage::Create (IDD_SPLASH);=0A=
 }=0A=
=20=0A=
-static BOOL=0A=
-dialog_cmd (HWND h, int id, HWND hwndctl, UINT code)=0A=
+void=0A=
+SplashPage::OnInit ()=0A=
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
+  ver.Format (IDS_VERSION_INFO, version[0] ? version : "[unknown]");=0A=
=20=0A=
-void=0A=
-do_splash (HINSTANCE h)=0A=
-{=0A=
-  int rv =3D 0;=0A=
-  rv =3D DialogBox (h, MAKEINTRESOURCE (IDD_SPLASH), 0, dialog_proc);=0A=
-  if (rv =3D=3D -1)=0A=
-    fatal (IDS_DIALOG_FAILED);=0A=
+  SetWindowText (GetDlgItem (IDC_VERSION), ver.c_str ());=0A=
 }=0A=
Index: splash.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: splash.h=0A=
diff -N splash.h=0A=
--- /dev/null	Tue May  5 13:32:27 1998=0A=
+++ splash.h	Thu Dec 20 04:36:03 2001=0A=
@@ -0,0 +1,38 @@=0A=
+#ifndef CINSTALL_SPLASH_H=0A=
+#define CINSTALL_SPLASH_H=0A=
+=0A=
+/*=0A=
+ * Copyright (c) 2001, Gary R. Van Sickle.=0A=
+ *=0A=
+ *     This program is free software; you can redistribute it and/or modif=
y=0A=
+ *     it under the terms of the GNU General Public License as published b=
y=0A=
+ *     the Free Software Foundation; either version 2 of the License, or=
=0A=
+ *     (at your option) any later version.=0A=
+ *=0A=
+ *     A copy of the GNU General Public License can be found at=0A=
+ *     http://www.gnu.org/=0A=
+ *=0A=
+ * Written by Gary R. Van Sickle <g.r.vansickle@worldnet.att.net>=0A=
+ *=0A=
+ */=0A=
+=0A=
+// This is the header for the SplashPage class.  Since the splash page=0A=
+// has little to do, there's not much here.=0A=
+=0A=
+#include "proppage.h"=0A=
+=0A=
+class SplashPage:public PropertyPage=0A=
+{=0A=
+public:=0A=
+  SplashPage ()=0A=
+  {=0A=
+  };=0A=
+  virtual ~ SplashPage ()=0A=
+  {=0A=
+  };=0A=
+=0A=
+  bool Create ();=0A=
+  void OnInit ();=0A=
+};=0A=
+=0A=
+#endif // CINSTALL_SPLASH_H=0A=
Index: threebar.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: threebar.cc=0A=
diff -N threebar.cc=0A=
--- /dev/null	Tue May  5 13:32:27 1998=0A=
+++ threebar.cc	Thu Dec 20 04:36:03 2001=0A=
@@ -0,0 +1,199 @@=0A=
+/*=0A=
+ * Copyright (c) 2001, Gary R. Van Sickle.=0A=
+ *=0A=
+ *     This program is free software; you can redistribute it and/or modif=
y=0A=
+ *     it under the terms of the GNU General Public License as published b=
y=0A=
+ *     the Free Software Foundation; either version 2 of the License, or=
=0A=
+ *     (at your option) any later version.=0A=
+ *=0A=
+ *     A copy of the GNU General Public License can be found at=0A=
+ *     http://www.gnu.org/=0A=
+ *=0A=
+ * Written by Gary R. Van Sickle <g.r.vansickle@worldnet.att.net>=0A=
+ *=0A=
+ */=0A=
+=0A=
+// This is the implementation of the ThreeBarProgressPage class.  It is a =
fairly generic=0A=
+// progress indicator property page with three progress bars.=0A=
+=0A=
+#include "win32.h"=0A=
+#include "commctrl.h"=0A=
+#include "resource.h"=0A=
+=0A=
+#include "dialog.h"=0A=
+#include "site.h"=0A=
+=0A=
+#include "propsheet.h"=0A=
+#include "threebar.h"=0A=
+=0A=
+bool=0A=
+ThreeBarProgressPage::Create ()=0A=
+{=0A=
+  return PropertyPage::Create (IDD_INSTATUS);=0A=
+}=0A=
+=0A=
+void=0A=
+ThreeBarProgressPage::OnInit ()=0A=
+{=0A=
+  // Get HWNDs to the dialog controls=0A=
+  ins_action =3D GetDlgItem (IDC_INS_ACTION);=0A=
+  ins_pkgname =3D GetDlgItem (IDC_INS_PKG);=0A=
+  ins_filename =3D GetDlgItem (IDC_INS_FILE);=0A=
+  // Bars=0A=
+  ins_pprogress =3D GetDlgItem (IDC_INS_PPROGRESS);=0A=
+  ins_iprogress =3D GetDlgItem (IDC_INS_IPROGRESS);=0A=
+  ins_diskfull =3D GetDlgItem (IDC_INS_DISKFULL);=0A=
+  // Bar labels=0A=
+  ins_bl_package =3D GetDlgItem (IDC_INS_BL_PACKAGE);=0A=
+  ins_bl_total =3D GetDlgItem (IDC_INS_BL_TOTAL);=0A=
+  ins_bl_disk =3D GetDlgItem (IDC_INS_BL_DISK);=0A=
+}=0A=
+=0A=
+void=0A=
+ThreeBarProgressPage::SetText1 (const TCHAR * t)=0A=
+{=0A=
+  SetWindowText (ins_action, t);=0A=
+}=0A=
+=0A=
+void=0A=
+ThreeBarProgressPage::SetText2 (const TCHAR * t)=0A=
+{=0A=
+  SetWindowText (ins_pkgname, t);=0A=
+}=0A=
+=0A=
+void=0A=
+ThreeBarProgressPage::SetText3 (const TCHAR * t)=0A=
+{=0A=
+  SetWindowText (ins_filename, t);=0A=
+}=0A=
+=0A=
+void=0A=
+ThreeBarProgressPage::SetBar1 (long progress, long max)=0A=
+{=0A=
+  int percent =3D (int) (100.0 * ((double) progress) / (double) max);=0A=
+  SendMessage (ins_pprogress, PBM_SETPOS, (WPARAM) percent, 0);=0A=
+}=0A=
+=0A=
+void=0A=
+ThreeBarProgressPage::SetBar2 (long progress, long max)=0A=
+{=0A=
+  int percent =3D (int) (100.0 * ((double) progress) / (double) max);=0A=
+  SendMessage (ins_iprogress, PBM_SETPOS, (WPARAM) percent, 0);=0A=
+}=0A=
+=0A=
+void=0A=
+ThreeBarProgressPage::SetBar3 (long progress, long max)=0A=
+{=0A=
+  int percent =3D (int) (100.0 * ((double) progress) / (double) max);=0A=
+  SendMessage (ins_diskfull, PBM_SETPOS, (WPARAM) percent, 0);=0A=
+}=0A=
+=0A=
+void=0A=
+ThreeBarProgressPage::EnableSingleBar (bool enable)=0A=
+{=0A=
+  // Switch to/from single bar mode=0A=
+  ShowWindow (ins_bl_total, enable ? SW_HIDE : SW_SHOW);=0A=
+  ShowWindow (ins_bl_disk, enable ? SW_HIDE : SW_SHOW);=0A=
+  ShowWindow (ins_iprogress, enable ? SW_HIDE : SW_SHOW);=0A=
+  ShowWindow (ins_diskfull, enable ? SW_HIDE : SW_SHOW);=0A=
+}=0A=
+=0A=
+void=0A=
+ThreeBarProgressPage::OnActivate ()=0A=
+{=0A=
+  // Disable back and next buttons=0A=
+  GetOwner ()->SetButtons (0);=0A=
+=0A=
+  // Set all bars to 0=0A=
+  SetBar1 (0);=0A=
+  SetBar2 (0);=0A=
+  SetBar3 (0);=0A=
+=0A=
+  switch (task)=0A=
+    {=0A=
+    case WM_APP_START_SITE_INFO_DOWNLOAD:=0A=
+    case WM_APP_START_SETUP_INI_DOWNLOAD:=0A=
+      // For these tasks, show only a single progress bar.=0A=
+      EnableSingleBar ();=0A=
+      break;=0A=
+    default:=0A=
+      // Show the normal 3-bar view by default=0A=
+      EnableSingleBar (false);=0A=
+      break;=0A=
+    }=0A=
+=0A=
+  Window::PostMessage (task);=0A=
+}=0A=
+=0A=
+bool=0A=
+ThreeBarProgressPage::OnMessageApp (UINT uMsg, WPARAM wParam, LPARAM lPara=
m)=0A=
+{=0A=
+  switch (uMsg)=0A=
+    {=0A=
+    case WM_APP_START_DOWNLOAD:=0A=
+      {=0A=
+	// Start the package download thread.=0A=
+	do_download (GetInstance (), GetHWND ());=0A=
+	break;=0A=
+      }=0A=
+    case WM_APP_DOWNLOAD_THREAD_COMPLETE:=0A=
+      {=0A=
+	if (lParam =3D=3D IDD_S_INSTALL)=0A=
+	  {=0A=
+	    // Download is complete and we want to go on to the install.=0A=
+	    Window::PostMessage (WM_APP_START_INSTALL);=0A=
+	  }=0A=
+	else if (lParam !=3D 0)=0A=
+	  {=0A=
+	    // Download failed for some reason, go back to site selection page=0A=
+	    GetOwner ()->SetActivePageByID (lParam);=0A=
+	  }=0A=
+	else=0A=
+	  {=0A=
+	    // Was a download-only, and is complete or failed.=0A=
+	    GetOwner ()->PressButton (PSBTN_CANCEL);=0A=
+	  }=0A=
+	break;=0A=
+      }=0A=
+    case WM_APP_START_INSTALL:=0A=
+      {=0A=
+	// Start the install thread.=0A=
+	do_install (GetInstance (), GetHWND ());=0A=
+	break;=0A=
+      }=0A=
+    case WM_APP_INSTALL_THREAD_COMPLETE:=0A=
+      {=0A=
+	// Re-enable and "Push" the Next button=0A=
+	GetOwner ()->SetButtons (PSWIZB_NEXT);=0A=
+	GetOwner ()->PressButton (PSBTN_NEXT);=0A=
+	break;=0A=
+      }=0A=
+    case WM_APP_START_SITE_INFO_DOWNLOAD:=0A=
+      {=0A=
+	do_download_site_info (GetInstance (), GetHWND ());=0A=
+	break;=0A=
+      }=0A=
+    case WM_APP_SITE_INFO_DOWNLOAD_COMPLETE:=0A=
+      {=0A=
+	GetOwner ()->SetActivePageByID (lParam);=0A=
+	break;=0A=
+      }=0A=
+    case WM_APP_START_SETUP_INI_DOWNLOAD:=0A=
+      {=0A=
+	do_ini (GetInstance (), GetHWND ());=0A=
+	break;=0A=
+      }=0A=
+    case WM_APP_SETUP_INI_DOWNLOAD_COMPLETE:=0A=
+      {=0A=
+	GetOwner ()->SetActivePageByID (lParam);=0A=
+	break;=0A=
+      }=0A=
+    default:=0A=
+      {=0A=
+	// Not handled=0A=
+	return false;=0A=
+      }=0A=
+    }=0A=
+=0A=
+  return true;=0A=
+}=0A=
Index: threebar.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: threebar.h=0A=
diff -N threebar.h=0A=
--- /dev/null	Tue May  5 13:32:27 1998=0A=
+++ threebar.h	Thu Dec 20 04:36:03 2001=0A=
@@ -0,0 +1,81 @@=0A=
+#ifndef CINSTALL_THREEBAR_H=0A=
+#define CINSTALL_THREEBAR_H=0A=
+=0A=
+/*=0A=
+ * Copyright (c) 2001, Gary R. Van Sickle.=0A=
+ *=0A=
+ *     This program is free software; you can redistribute it and/or modif=
y=0A=
+ *     it under the terms of the GNU General Public License as published b=
y=0A=
+ *     the Free Software Foundation; either version 2 of the License, or=
=0A=
+ *     (at your option) any later version.=0A=
+ *=0A=
+ *     A copy of the GNU General Public License can be found at=0A=
+ *     http://www.gnu.org/=0A=
+ *=0A=
+ * Written by Gary R. Van Sickle <g.r.vansickle@worldnet.att.net>=0A=
+ *=0A=
+ */=0A=
+=0A=
+// This is the header for the ThreeBarProgressPage class.  It is a fairly =
generic=0A=
+// progress indicator property page with three progress bars.=0A=
+=0A=
+=0A=
+#include "win32.h"=0A=
+#include "proppage.h"=0A=
+=0A=
+#define WM_APP_START_DOWNLOAD              WM_APP+0=0A=
+#define WM_APP_DOWNLOAD_THREAD_COMPLETE    WM_APP+1=0A=
+#define WM_APP_START_INSTALL               WM_APP+2=0A=
+#define WM_APP_INSTALL_THREAD_COMPLETE     WM_APP+3=0A=
+#define WM_APP_START_SITE_INFO_DOWNLOAD    WM_APP+4=0A=
+#define WM_APP_SITE_INFO_DOWNLOAD_COMPLETE WM_APP+5=0A=
+#define WM_APP_START_SETUP_INI_DOWNLOAD    WM_APP+6=0A=
+#define WM_APP_SETUP_INI_DOWNLOAD_COMPLETE WM_APP+7=0A=
+=0A=
+class ThreeBarProgressPage:public PropertyPage=0A=
+{=0A=
+  HWND ins_dialog;=0A=
+  HWND ins_action;=0A=
+  HWND ins_pkgname;=0A=
+  HWND ins_filename;=0A=
+  HWND ins_pprogress;=0A=
+  HWND ins_iprogress;=0A=
+  HWND ins_diskfull;=0A=
+  HWND ins_bl_package;=0A=
+  HWND ins_bl_total;=0A=
+  HWND ins_bl_disk;=0A=
+=0A=
+  int task;=0A=
+=0A=
+  void EnableSingleBar (bool enable =3D true);=0A=
+=0A=
+public:=0A=
+    ThreeBarProgressPage ()=0A=
+  {=0A=
+  };=0A=
+  virtual ~ ThreeBarProgressPage ()=0A=
+  {=0A=
+  };=0A=
+=0A=
+  bool Create ();=0A=
+=0A=
+  virtual void OnInit ();=0A=
+  virtual void OnActivate ();=0A=
+  virtual bool OnMessageApp (UINT uMsg, WPARAM wParam, LPARAM lParam);=0A=
+=0A=
+  void SetText1 (const TCHAR * t);=0A=
+  void SetText2 (const TCHAR * t);=0A=
+  void SetText3 (const TCHAR * t);=0A=
+=0A=
+  void SetBar1 (long progress, long max =3D 100);=0A=
+  void SetBar2 (long progress, long max =3D 100);=0A=
+  void SetBar3 (long progress, long max =3D 100);=0A=
+=0A=
+  void SetActivateTask (int t)=0A=
+  {=0A=
+    task =3D t;=0A=
+  };=0A=
+};=0A=
+=0A=
+=0A=
+#endif // CINSTALL_THREEBAR_H=0A=
Index: window.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: window.cc=0A=
diff -N window.cc=0A=
--- /dev/null	Tue May  5 13:32:27 1998=0A=
+++ window.cc	Thu Dec 20 04:36:03 2001=0A=
@@ -0,0 +1,269 @@=0A=
+/*=0A=
+ * Copyright (c) 2001, Gary R. Van Sickle.=0A=
+ *=0A=
+ *     This program is free software; you can redistribute it and/or modif=
y=0A=
+ *     it under the terms of the GNU General Public License as published b=
y=0A=
+ *     the Free Software Foundation; either version 2 of the License, or=
=0A=
+ *     (at your option) any later version.=0A=
+ *=0A=
+ *     A copy of the GNU General Public License can be found at=0A=
+ *     http://www.gnu.org/=0A=
+ *=0A=
+ * Written by Gary R. Van Sickle <g.r.vansickle@worldnet.att.net>=0A=
+ *=0A=
+ */=0A=
+=0A=
+// This is the implementation of the Window class.  It serves both as a wi=
ndow class=0A=
+// in its own right and as a base class for other window-like classes (e.g=
. PropertyPage,=0A=
+// PropSheet).=0A=
+=0A=
+#include <windows.h>=0A=
+#include "window.h"=0A=
+=0A=
+ATOM=0A=
+  Window::WindowClassAtom =3D=0A=
+  0;=0A=
+HINSTANCE=0A=
+  Window::AppInstance =3D=0A=
+  NULL;=0A=
+=0A=
+// FIXME: I know, this is brutal.  Mutexing should at least make window cr=
eation threadsafe,=0A=
+// but if somebody has any ideas as to how to get rid of it entirely, plea=
se tell me / do so.=0A=
+struct REFLECTION_INFO=0A=
+{=0A=
+  Window *=0A=
+    This;=0A=
+  bool=0A=
+    FirstCall;=0A=
+};=0A=
+REFLECTION_INFO=0A=
+  ReflectionInfo;=0A=
+=0A=
+Window::Window ()=0A=
+{=0A=
+  WindowHandle =3D NULL;=0A=
+  Parent =3D NULL;=0A=
+}=0A=
+=0A=
+Window::~Window ()=0A=
+{=0A=
+  // FIXME: Maybe do some reference counting and do this Unregister=0A=
+  // when there are no more of us left.  Not real critical unless=0A=
+  // we're in a DLL which we're not right now.=0A=
+  //UnregisterClass(WindowClassAtom, InstanceHandle);=0A=
+}=0A=
+=0A=
+LRESULT CALLBACK=0A=
+Window::FirstWindowProcReflector (HWND hwnd, UINT uMsg, WPARAM wParam,=0A=
+				  LPARAM lParam)=0A=
+{=0A=
+  // Get our this pointer=0A=
+  REFLECTION_INFO *rip =3D &ReflectionInfo;=0A=
+=0A=
+  if (rip->FirstCall)=0A=
+    {=0A=
+      rip->FirstCall =3D false;=0A=
+=0A=
+      // Set the Window handle so the real WindowProc has one to work with=
.=0A=
+      rip->This->WindowHandle =3D hwnd;=0A=
+=0A=
+      // Set a backreference to this class instance in the HWND.=0A=
+      // FIXME: Should really be SetWindowLongPtr(), but it appears to=0A=
+      // not be defined yet.=0A=
+      SetWindowLong (hwnd, GWL_USERDATA, (LONG) rip->This);=0A=
+=0A=
+      // Set a new WindowProc now that we have the peliminaries done.=0A=
+      // Like subclassing, only not.=0A=
+      SetWindowLong (hwnd, GWL_WNDPROC, (LONG) & Window::WindowProcReflect=
or);=0A=
+    }=0A=
+=0A=
+  return rip->This->WindowProc (uMsg, wParam, lParam);=0A=
+}=0A=
+=0A=
+LRESULT CALLBACK=0A=
+Window::WindowProcReflector (HWND hwnd, UINT uMsg, WPARAM wParam,=0A=
+			     LPARAM lParam)=0A=
+{=0A=
+  Window *This;=0A=
+=0A=
+  // Get our this pointer=0A=
+  // FIXME: Should really be GetWindowLongPtr(), but it appears to=0A=
+  // not be defined yet.=0A=
+  This =3D (Window *) GetWindowLong (hwnd, GWL_USERDATA);=0A=
+=0A=
+  return This->WindowProc (uMsg, wParam, lParam);=0A=
+}=0A=
+=0A=
+bool=0A=
+Window::Create (Window * parent, DWORD Style)=0A=
+{=0A=
+  // First register the window class, if we haven't already=0A=
+  if (RegisterWindowClass () =3D=3D false)=0A=
+    {=0A=
+      // Registration failed=0A=
+      return false;=0A=
+    }=0A=
+=0A=
+  // Set up the reflection info, so that the Windows window can find us.=
=0A=
+  ReflectionInfo.This =3D this;=0A=
+  ReflectionInfo.FirstCall =3D true;=0A=
+=0A=
+  Parent =3D parent;=0A=
+=0A=
+  // Create the window instance=0A=
+  WindowHandle =3D CreateWindow ("MainWindowClass",	//MAKEINTATOM(WindowCl=
assAtom),     // window class atom (name)=0A=
+			       "Hello",	// no title-bar string yet=0A=
+			       // Style bits=0A=
+			       Style,=0A=
+			       // Default positions and size=0A=
+			       CW_USEDEFAULT,=0A=
+			       CW_USEDEFAULT, CW_USEDEFAULT, CW_USEDEFAULT,=0A=
+			       // Parent Window=20=0A=
+			       parent =3D=3D=0A=
+			       NULL ? (HWND) NULL : parent->GetHWND (),=0A=
+			       // use class menu=20=0A=
+			       (HMENU) NULL,=0A=
+			       // The application instance=20=0A=
+			       GetInstance (), (LPVOID) NULL);=0A=
+=0A=
+  if (WindowHandle =3D=3D NULL)=0A=
+    {=0A=
+      // Failed=0A=
+      return false;=0A=
+    }=0A=
+=0A=
+  return true;=0A=
+}=0A=
+=0A=
+bool=0A=
+Window::RegisterWindowClass ()=0A=
+{=0A=
+  if (WindowClassAtom =3D=3D 0)=0A=
+    {=0A=
+      // We're not registered yet=0A=
+      WNDCLASSEX wc;=0A=
+=0A=
+      wc.cbSize =3D sizeof (wc);=0A=
+      // Some sensible style defaults=0A=
+      wc.style =3D CS_DBLCLKS | CS_HREDRAW | CS_VREDRAW;=0A=
+      // Our default window procedure.  This replaces itself=0A=
+      // on the first call with the simpler Window::WindowProcReflector().=
=0A=
+      wc.lpfnWndProc =3D Window::FirstWindowProcReflector;=0A=
+      // No class bytes=0A=
+      wc.cbClsExtra =3D 0;=0A=
+      // One pointer to REFLECTION_INFO in the extra window instance bytes=
=0A=
+      wc.cbWndExtra =3D 4;=0A=
+      // The app instance=0A=
+      wc.hInstance =3D GetInstance ();=0A=
+      // Use a bunch of system defaults for the GUI elements=0A=
+      wc.hIcon =3D NULL;=0A=
+      wc.hIconSm =3D NULL;=0A=
+      wc.hCursor =3D NULL;=0A=
+      wc.hbrBackground =3D (HBRUSH) (COLOR_BACKGROUND + 1);=0A=
+      // No menu=0A=
+      wc.lpszMenuName =3D NULL;=0A=
+      // We'll get a little crazy here with the class name=0A=
+      wc.lpszClassName =3D "MainWindowClass";=0A=
+=0A=
+      // All set, try to register=0A=
+      WindowClassAtom =3D RegisterClassEx (&wc);=0A=
+=0A=
+      if (WindowClassAtom =3D=3D 0)=0A=
+	{=0A=
+	  // Failed=0A=
+	  return false;=0A=
+	}=0A=
+    }=0A=
+=0A=
+  // We're registered, or already were before the call,=0A=
+  // return success in either case.=0A=
+  return true;=0A=
+}=0A=
+=0A=
+void=0A=
+Window::Show (int State)=0A=
+{=0A=
+  ::ShowWindow (WindowHandle, State);=0A=
+}=0A=
+=0A=
+void=0A=
+Window::CenterWindow ()=0A=
+{=0A=
+  RECT WindowRect, ParentRect;=0A=
+  int WindowWidth, WindowHeight;=0A=
+  POINT p;=0A=
+=0A=
+  // Get the window rectangle=0A=
+  GetWindowRect (GetHWND (), &WindowRect);=0A=
+=0A=
+  if (GetParent () =3D=3D NULL)=0A=
+    {=0A=
+      // Center on desktop window=0A=
+      GetWindowRect (GetDesktopWindow (), &ParentRect);=0A=
+    }=0A=
+  else=0A=
+    {=0A=
+      // Center on client area of parent=0A=
+      GetClientRect (GetParent ()->GetHWND (), &ParentRect);=0A=
+    }=0A=
+=0A=
+  WindowWidth =3D WindowRect.right - WindowRect.left;=0A=
+  WindowHeight =3D WindowRect.bottom - WindowRect.top;=0A=
+=0A=
+  // Find center of area we're centering on=0A=
+  p.x =3D (ParentRect.right - ParentRect.left) / 2;=0A=
+  p.y =3D (ParentRect.bottom - ParentRect.top) / 2;=0A=
+=0A=
+  // Convert that to screen coords=0A=
+  if (GetParent () =3D=3D NULL)=0A=
+    {=0A=
+      ClientToScreen (GetDesktopWindow (), &p);=0A=
+    }=0A=
+  else=0A=
+    {=0A=
+      ClientToScreen (GetParent ()->GetHWND (), &p);=0A=
+    }=0A=
+=0A=
+  // Calculate new top left corner for window=0A=
+  p.x -=3D WindowWidth / 2;=0A=
+  p.y -=3D WindowHeight / 2;=0A=
+=0A=
+  // And finally move the window=0A=
+  MoveWindow (GetHWND (), p.x, p.y, WindowWidth, WindowHeight, TRUE);=0A=
+}=0A=
+=0A=
+LRESULT=0A=
+Window::WindowProc (UINT uMsg, WPARAM wParam, LPARAM lParam)=0A=
+{=0A=
+  switch (uMsg)=0A=
+    {=0A=
+    default:=0A=
+      return DefWindowProc (WindowHandle, uMsg, wParam, lParam);=0A=
+    }=0A=
+=0A=
+  return 0;=0A=
+}=0A=
+=0A=
+bool=0A=
+Window::MessageLoop ()=0A=
+{=0A=
+  MSG msg;=0A=
+=0A=
+  while (GetMessage (&msg, NULL, 0, 0) !=3D 0=0A=
+	 && GetMessage (&msg, (HWND) NULL, 0, 0) !=3D -1)=0A=
+    {=0A=
+      if (!IsWindow (WindowHandle) || !IsDialogMessage (WindowHandle, &msg=
))=0A=
+	{=0A=
+	  TranslateMessage (&msg);=0A=
+	  DispatchMessage (&msg);=0A=
+	}=0A=
+    }=0A=
+=0A=
+  return true;=0A=
+}=0A=
+=0A=
+void=0A=
+Window::PostMessage (UINT uMsg, WPARAM wParam, LPARAM lParam)=0A=
+{=0A=
+  ::PostMessage (GetHWND (), uMsg, wParam, lParam);=0A=
+}=0A=
Index: window.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: window.h=0A=
diff -N window.h=0A=
--- /dev/null	Tue May  5 13:32:27 1998=0A=
+++ window.h	Thu Dec 20 04:36:03 2001=0A=
@@ -0,0 +1,95 @@=0A=
+#ifndef CINSTALL_WINDOW_H=0A=
+#define CINSTALL_WINDOW_H=0A=
+=0A=
+/*=0A=
+ * Copyright (c) 2001, Gary R. Van Sickle.=0A=
+ *=0A=
+ *     This program is free software; you can redistribute it and/or modif=
y=0A=
+ *     it under the terms of the GNU General Public License as published b=
y=0A=
+ *     the Free Software Foundation; either version 2 of the License, or=
=0A=
+ *     (at your option) any later version.=0A=
+ *=0A=
+ *     A copy of the GNU General Public License can be found at=0A=
+ *     http://www.gnu.org/=0A=
+ *=0A=
+ * Written by Gary R. Van Sickle <g.r.vansickle@worldnet.att.net>=0A=
+ *=0A=
+ */=0A=
+=0A=
+// This is the header for the Window class.  It serves both as a window cl=
ass=0A=
+// in its own right and as a base class for other window-like classes (e.g=
. PropertyPage,=0A=
+// PropSheet).=0A=
+=0A=
+#include <windows.h>=0A=
+=0A=
+class Window=0A=
+{=0A=
+  static ATOM WindowClassAtom;=0A=
+  static HINSTANCE AppInstance;=0A=
+=0A=
+=0A=
+  bool RegisterWindowClass ();=0A=
+  static LRESULT CALLBACK FirstWindowProcReflector (HWND hwnd, UINT uMsg,=
=0A=
+						    WPARAM wParam,=0A=
+						    LPARAM lParam);=0A=
+  static LRESULT CALLBACK WindowProcReflector (HWND hwnd, UINT uMsg,=0A=
+					       WPARAM wParam, LPARAM lParam);=0A=
+=0A=
+  HWND WindowHandle;=0A=
+=0A=
+  Window *Parent;=0A=
+=0A=
+protected:=0A=
+  void SetHWND (HWND h)=0A=
+  {=0A=
+    WindowHandle =3D h;=0A=
+  };=0A=
+=0A=
+public:=0A=
+  Window ();=0A=
+  virtual ~ Window ();=0A=
+=0A=
+  static void SetAppInstance (HINSTANCE h)=0A=
+  {=0A=
+    AppInstance =3D h;=0A=
+  };=0A=
+=0A=
+  virtual LRESULT WindowProc (UINT uMsg, WPARAM wParam, LPARAM lParam);=0A=
+  virtual bool MessageLoop ();=0A=
+=0A=
+  virtual bool Create (Window * Parent =3D NULL,=0A=
+		       DWORD Style =3D=0A=
+		       WS_OVERLAPPEDWINDOW | WS_VISIBLE | WS_CLIPCHILDREN);=0A=
+  void Show (int State);=0A=
+=0A=
+  HWND GetHWND () const=0A=
+  {=0A=
+    return WindowHandle;=0A=
+  };=0A=
+  HINSTANCE GetInstance () const=0A=
+  {=0A=
+    return AppInstance;=0A=
+  };=0A=
+=0A=
+  Window *GetParent () const=0A=
+  {=0A=
+    return Parent;=0A=
+  };=0A=
+  HWND GetDlgItem (int id) const=0A=
+  {=0A=
+    return::GetDlgItem (GetHWND (), id);=0A=
+  };=0A=
+=0A=
+  void PostMessage (UINT uMsg, WPARAM wParam =3D 0, LPARAM lParam =3D 0);=
=0A=
+=0A=
+  virtual bool OnMessageApp (UINT uMsg, WPARAM wParam, LPARAM lParam)=0A=
+  {=0A=
+    return false;=0A=
+  };=0A=
+=0A=
+  // Center the window on the parent, or on screen if no parent.=0A=
+  void CenterWindow ();=0A=
+=0A=
+};=0A=
+=0A=
+#endif // CINSTALL_WINDOW_H=0A=

------=_NextPart_000_0238_01C189AF.58229CB0--
