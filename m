Return-Path: <cygwin-patches-return-1643-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 20702 invoked by alias); 1 Jan 2002 14:21:25 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 20688 invoked from network); 1 Jan 2002 14:21:23 -0000
From: "Gary R. Van Sickle" <g.r.vansickle@worldnet.att.net>
To: <cygwin-patches@sourceware.cygnus.com>
Subject: RE: [PATCH] Setup.exe "other URL" functionality
Date: Tue, 01 Jan 2002 06:21:00 -0000
Message-ID: <NCBBIHCHBLCMLBLOBONKMECJCIAA.g.r.vansickle@worldnet.att.net>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0000_01C1929D.4500DDD0"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
In-Reply-To: <003101c192c0$c169ff50$0200a8c0@lifelesswks>
Importance: Normal
X-SW-Source: 2002-q1/txt/msg00000.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_0000_01C1929D.4500DDD0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 2128

> -----Original Message-----
> From: cygwin-owner@cygwin.com [mailto:cygwin-owner@cygwin.com]On Behalf
> Of Robert Collins
>
> Gary, it may be that the new files you gave me were in dos mode, and
> that CVS is having trouble only with files that are in the repo in dos
> mode.
>
> I've run d2u on window.*, proppage.cc and propsheet.cc and checked them
> in. (The whole file showed as changed).
>
> Can you see if this has made life easier for you with cvs diff (only on
> those 4 files).

Yep, it looks like that combined with me now using binary mounts will work
around this.  For reasons I don't quite understand though, I couldn't simply do
a "cvs diff", but had to move my file (now with LFs-only), do a "cvs update" to
re-get the cvs version (which also has LFs-only now), replace that with the file
I just moved, and *then* it works.  I have no idea what to make of that.

But there's a few more files that need this treatment (it looks like they're
still CRLF in the repository database):

cistring.{cc,h}
desktop.h (but not .cc)
localdir.h
net.{cc,h} (it looks like .cc may be 'half and half', I s**t you not)
proppage.h
propsheet.h
root.h
source.h
splash.h (bot not .cc)
threebar.{cc,h}

So almost but not quite every new file I sent you (or maybe that is all of
them).  And these were all CRLFs.

Attached is a diff (the patch to date, LF-only) that may or may not be of use in
fixing this.  The changes have *not* been run through indent (with the exception
of two headers) - I did finally notice the

"void foo::bar()"

vs.

"void
foo:bar()"

issue you had mentioned, among others, and I have no explanation for why I
should see it and not you.  I have no .indent.pro, I'm on a binary mount like I
said, I'm using no options, and it's "GNU indent 2.2.7" as distributed by
Cygnus.  I have attempted to cleave to the GNU formatting as best as my own
sense of aesthetics and limited PITA IDE (VC6) allow, but I'm sure there's
plenty there that isn't RMS chapter and verse.

Also attached is my changelog for this patch to date in the hope that this will
put this patch to bed.

--
Gary R. Van Sickle
Brewer.  Patriot.

------=_NextPart_000_0000_01C1929D.4500DDD0
Content-Type: application/octet-stream;
	name="setup.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="setup.diff"
Content-length: 112843

Index: Makefile.in=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/Makefile.in,v=0A=
retrieving revision 2.41=0A=
diff -p -u -r2.41 Makefile.in=0A=
--- Makefile.in	2001/12/28 19:03:52	2.41=0A=
+++ Makefile.in	2002/01/01 14:02:08=0A=
@@ -124,7 +124,6 @@ OBJS =3D \=0A=
 	nio-file.o \=0A=
 	nio-ftp.o \=0A=
 	nio-http.o \=0A=
-	other.o \=0A=
 	package_db.o \=0A=
 	package_meta.o \=0A=
 	package_source.o \=0A=
@@ -250,7 +249,7 @@ endif=0A=
=20=0A=
 iniparse.cc iniparse.h : iniparse.y=0A=
 	bison -d -o iniparse.cc $(srcdir)/iniparse.y=0A=
-	@mv iniparse.cc.h iniparse.h 2>/dev/null || mv iniparse.hh iniparse.h=0A=
+	@mv iniparse.cc.h iniparse.h=0A=
=20=0A=
 inilex.cc : inilex.l iniparse.h=0A=
 	flex -8 $(srcdir)/inilex.l=0A=
Index: choose.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/choose.cc,v=0A=
retrieving revision 2.82=0A=
diff -p -u -r2.82 choose.cc=0A=
--- choose.cc	2002/01/01 12:32:36	2.82=0A=
+++ choose.cc	2002/01/01 14:02:13=0A=
@@ -27,7 +27,7 @@=0A=
=20=0A=
 #if 0=0A=
 static const char *cvsid =3D=0A=
-  "\n%%% $Id: choose.cc,v 2.82 2002/01/01 12:32:36 rbcollins Exp $\n";=0A=
+  "\n%%% $Id: choose.cc,v 2.81 2001/12/23 12:13:28 rbcollins Exp $\n";=0A=
 #endif=0A=
=20=0A=
 #include "win32.h"=0A=
@@ -469,37 +469,19 @@ note_width (struct _header *hdrs, HDC dc=0A=
 static void=0A=
 set_existence ()=0A=
 {=0A=
-  packagedb db;=0A=
-  /* Remove packages that are in the db, not installed, and have no=20=0A=
-     mirror info. */=0A=
-  size_t n =3D 1;=0A=
-  while (n <=3D db.packages.number ())=0A=
-    {=0A=
-      packagemeta & pkg =3D *db.packages[n];=0A=
-      bool mirrors =3D false;=0A=
-      size_t o =3D 1;=0A=
-      while (o <=3D pkg.versions.number () && !mirrors)=0A=
-	{=0A=
-	  packageversion & ver =3D *pkg.versions[o];=0A=
-	  if (ver.bin.sites.number () || ver.src.sites.number ())=0A=
-	    mirrors =3D true;=0A=
-	  ++o;=0A=
-	}=0A=
-      if (!pkg.installed && !mirrors)=0A=
-        {=0A=
-	  packagemeta * pkgm =3D db.packages.removebyindex (n);=0A=
-	  delete pkgm;=0A=
-	}=0A=
-      else=0A=
-	++n;=0A=
-    }=0A=
+  /* FIXME:=0A=
+     iterate through the package list, and delete packages that are=0A=
+     * Not installed=0A=
+     * have no mirror site=0A=
+     and then do the same for categories with no packages.=0A=
+   */=0A=
 }=0A=
=20=0A=
 static void=0A=
 fill_missing_category ()=0A=
 {=0A=
   packagedb db;=0A=
-  for (size_t n =3D 1; n <=3D db.packages.number (); n++)=0A=
+  for (size_t n =3D 1; n < db.packages.number (); n++)=0A=
     {=0A=
       packagemeta & pkg =3D *db.packages[n];=0A=
       if (!pkg.Categories.number ())=0A=
@@ -512,7 +494,7 @@ default_trust (HWND h, trusts trust)=0A=
 {=0A=
   deftrust =3D trust;=0A=
   packagedb db;=0A=
-  for (size_t n =3D 1; n <=3D db.packages.number (); n++)=0A=
+  for (size_t n =3D 1; n < db.packages.number (); n++)=0A=
     {=0A=
       packagemeta & pkg =3D *db.packages[n];=0A=
       if (pkg.installed=0A=
@@ -534,18 +516,6 @@ default_trust (HWND h, trusts trust)=0A=
   InvalidateRect (h, &r, TRUE);=0A=
   if (nextbutton)=0A=
     SetFocus (nextbutton);=0A=
-  // and then do the same for categories with no packages.=0A=
-  size_t n =3D 1;=0A=
-  while (n <=3D db.categories.number ())=0A=
-    {=0A=
-      if (!db.categories[n]->packages)=0A=
-        {=0A=
-           Category * cat =3D db.categories.removebyindex (n);=0A=
-           delete cat;=0A=
-        }=0A=
-      else=0A=
-	++n;=0A=
-    }=0A=
 }=0A=
=20=0A=
 void=0A=
@@ -879,7 +849,7 @@ view::init_headers (HDC dc)=0A=
   /* src checkbox */=0A=
   note_width (headers, dc, 0, HMARGIN + 11, src_col);=0A=
   packagedb db;=0A=
-  for (size_t n =3D 1; n <=3D db.packages.number (); n++)=0A=
+  for (size_t n =3D 1; n < db.packages.number (); n++)=0A=
     {=0A=
       packagemeta & pkg =3D *db.packages[n];=0A=
       if (pkg.installed)=0A=
@@ -987,7 +957,7 @@ set_view_mode (HWND h, views mode)=0A=
   switch (chooser->get_view_mode ())=0A=
     {=0A=
     case VIEW_PACKAGE:=0A=
-      for (size_t n =3D 1; n <=3D db.packages.number (); n++)=0A=
+      for (size_t n =3D 1; n < db.packages.number (); n++)=0A=
 	{=0A=
 	  packagemeta & pkg =3D *db.packages[n];=0A=
 	  if ((!pkg.desired && pkg.installed)=0A=
@@ -997,7 +967,7 @@ set_view_mode (HWND h, views mode)=0A=
 	}=0A=
       break;=0A=
     case VIEW_PACKAGE_FULL:=0A=
-      for (size_t n =3D 1; n <=3D db.packages.number (); n++)=0A=
+      for (size_t n =3D 1; n < db.packages.number (); n++)=0A=
 	{=0A=
 	  packagemeta & pkg =3D *db.packages[n];=0A=
 	  chooser->insert_pkg (pkg);=0A=
@@ -1082,7 +1052,7 @@ create_listview (HWND dlg, RECT * r)=0A=
     log (LOG_BABBLE, "Failed to set View button caption %ld",=0A=
 	 GetLastError ());=0A=
   packagedb db;=0A=
-  for (size_t n =3D 1; n <=3D db.packages.number (); n++)=0A=
+  for (size_t n =3D 1; n < db.packages.number (); n++)=0A=
     {=0A=
       packagemeta & pkg =3D *db.packages[n];=0A=
       add_required (pkg);=0A=
@@ -1101,7 +1071,7 @@ dialog_cmd (HWND h, int id, HWND hwndctl=0A=
     {=0A=
     case IDC_CHOOSE_PREV:=0A=
       default_trust (lv, TRUST_PREV);=0A=
-      for (size_t n =3D 1; n <=3D db.packages.number (); n++)=0A=
+      for (size_t n =3D 1; n < db.packages.number (); n++)=0A=
 	{=0A=
 	  packagemeta & pkg =3D *db.packages[n];=0A=
 	  add_required (pkg);=0A=
@@ -1110,7 +1080,7 @@ dialog_cmd (HWND h, int id, HWND hwndctl=0A=
       break;=0A=
     case IDC_CHOOSE_CURR:=0A=
       default_trust (lv, TRUST_CURR);=0A=
-      for (size_t n =3D 1; n <=3D db.packages.number (); n++)=0A=
+      for (size_t n =3D 1; n < db.packages.number (); n++)=0A=
 	{=0A=
 	  packagemeta & pkg =3D *db.packages[n];=0A=
 	  add_required (pkg);=0A=
@@ -1119,7 +1089,7 @@ dialog_cmd (HWND h, int id, HWND hwndctl=0A=
       break;=0A=
     case IDC_CHOOSE_EXP:=0A=
       default_trust (lv, TRUST_TEST);=0A=
-      for (size_t n =3D 1; n <=3D db.packages.number (); n++)=0A=
+      for (size_t n =3D 1; n < db.packages.number (); n++)=0A=
 	{=0A=
 	  packagemeta & pkg =3D *db.packages[n];=0A=
 	  add_required (pkg);=0A=
@@ -1327,7 +1297,7 @@ do_choose (HINSTANCE h, HWND owner)=0A=
=20=0A=
   log (LOG_BABBLE, "Chooser results...");=0A=
   packagedb db;=0A=
-  for (size_t n =3D 1; n <=3D db.packages.number (); n++)=0A=
+  for (size_t n =3D 1; n < db.packages.number (); n++)=0A=
     {=0A=
       packagemeta & pkg =3D *db.packages[n];=0A=
 //      static const char *infos[] =3D { "nada", "prev", "curr", "test" };=
=0A=
Index: cistring.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/cistring.cc,v=0A=
retrieving revision 2.1=0A=
diff -p -u -r2.1 cistring.cc=0A=
--- cistring.cc	2001/12/23 12:13:28	2.1=0A=
+++ cistring.cc	2002/01/01 14:02:14=0A=
@@ -1,52 +1,52 @@=0A=
-/*=0A=
- * Copyright (c) 2001, Gary R. Van Sickle.=0A=
- *=0A=
- *     This program is free software; you can redistribute it and/or modif=
y=0A=
- *     it under the terms of the GNU General Public License as published b=
y=0A=
- *     the Free Software Foundation; either version 2 of the License, or=
=0A=
- *     (at your option) any later version.=0A=
- *=0A=
- *     A copy of the GNU General Public License can be found at=0A=
- *     http://www.gnu.org/=0A=
- *=0A=
- * Written by Gary R. Van Sickle <g.r.vansickle@worldnet.att.net>=0A=
- *=0A=
- */=0A=
-=0A=
-// Yep, another string class=0A=
-=0A=
-#include "cistring.h"=0A=
-#include <stdlib.h>=0A=
-=0A=
-DWORD=0A=
-cistring::Format (UINT i, ...)=0A=
-{=0A=
-  TCHAR FormatStringBuffer[256];=0A=
-  TCHAR *Buff;=0A=
-  va_list arglist;=0A=
-  DWORD numchars;=0A=
-=0A=
-  // Get the string from the stringtable (FormatMessage() can only work wi=
th=0A=
-  // literal strings or *message*table entries, which are different for so=
me=0A=
-  // inexplicable reason).=0A=
-  LoadString (GetModuleHandle (NULL), i, FormatStringBuffer, 256);=0A=
-=0A=
-  va_start (arglist, i);=0A=
-  numchars =3D::=0A=
-    FormatMessage (FORMAT_MESSAGE_ALLOCATE_BUFFER |=0A=
-		   FORMAT_MESSAGE_FROM_STRING, FormatStringBuffer, i, 0,=0A=
-		   (LPTSTR) & Buff, 0, &arglist);=0A=
-  va_end (arglist);=0A=
-=0A=
-  if (numchars =3D=3D 0)=0A=
-    {=0A=
-      // Something went wrong.=0A=
-      return 0;=0A=
-    }=0A=
-=0A=
-  buffer =3D new TCHAR[(numchars + 1) * sizeof (TCHAR)];=0A=
-  memcpy (buffer, Buff, (numchars + 1) * sizeof (TCHAR));=0A=
-  LocalFree (Buff);=0A=
-=0A=
-  return numchars;=0A=
-}=0A=
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
RCS file: /cvs/src/src/winsup/cinstall/cistring.h,v=0A=
retrieving revision 2.1=0A=
diff -p -u -r2.1 cistring.h=0A=
--- cistring.h	2001/12/23 12:13:28	2.1=0A=
+++ cistring.h	2002/01/01 14:02:14=0A=
@@ -1,41 +1,41 @@=0A=
-/*=0A=
- * Copyright (c) 2001, Gary R. Van Sickle.=0A=
- *=0A=
- *     This program is free software; you can redistribute it and/or modif=
y=0A=
- *     it under the terms of the GNU General Public License as published b=
y=0A=
- *     the Free Software Foundation; either version 2 of the License, or=
=0A=
- *     (at your option) any later version.=0A=
- *=0A=
- *     A copy of the GNU General Public License can be found at=0A=
- *     http://www.gnu.org/=0A=
- *=0A=
- * Written by Gary R. Van Sickle <g.r.vansickle@worldnet.att.net>=0A=
- *=0A=
- */=0A=
-=0A=
-// Yep, another string class=0A=
-=0A=
-#include <windows.h>=0A=
-=0A=
-class cistring=0A=
-{=0A=
-  TCHAR *buffer;=0A=
-public:=0A=
-    cistring ()=0A=
-  {=0A=
-    buffer =3D NULL;=0A=
-  };=0A=
-  cistring (const TCHAR * s);=0A=
-  ~cistring ()=0A=
-  {=0A=
-    if (buffer !=3D NULL)=0A=
-      delete[]buffer;=0A=
-  };=0A=
-=0A=
-  const TCHAR *c_str ()=0A=
-  {=0A=
-    return buffer;=0A=
-  };=0A=
-=0A=
-  DWORD Format (UINT i, ...);=0A=
-};=0A=
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
retrieving revision 2.20=0A=
diff -p -u -r2.20 desktop.cc=0A=
--- desktop.cc	2001/12/23 12:13:28	2.20=0A=
+++ desktop.cc	2002/01/01 14:02:18=0A=
@@ -88,8 +88,6 @@ static const char *etc_profile[] =3D {=0A=
   "$ '",=0A=
   "",=0A=
   "cd \"$HOME\"",=0A=
-  "",=0A=
-  "test -f ./.bashrc && . ./.bashrc",=0A=
   0=0A=
 };=0A=
=20=0A=
Index: desktop.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/desktop.h,v=0A=
retrieving revision 2.1=0A=
diff -p -u -r2.1 desktop.h=0A=
--- desktop.h	2001/12/23 12:13:28	2.1=0A=
+++ desktop.h	2002/01/01 14:02:18=0A=
@@ -1,41 +1,41 @@=0A=
-#ifndef CINSTALL_DESKTOP_H=0A=
-#define CINSTALL_DESKTOP_H=0A=
-=0A=
-/*=0A=
- * Copyright (c) 2001, Gary R. Van Sickle.=0A=
- *=0A=
- *     This program is free software; you can redistribute it and/or modif=
y=0A=
- *     it under the terms of the GNU General Public License as published b=
y=0A=
- *     the Free Software Foundation; either version 2 of the License, or=
=0A=
- *     (at your option) any later version.=0A=
- *=0A=
- *     A copy of the GNU General Public License can be found at=0A=
- *     http://www.gnu.org/=0A=
- *=0A=
- * Written by Gary R. Van Sickle <g.r.vansickle@worldnet.att.net>=0A=
- *=0A=
- */=0A=
-=0A=
-// This is the header for the DesktopSetupPage class.  Allows selection=0A=
-// of "create desktop icon" and "add to start menu".=0A=
-=0A=
-#include "proppage.h"=0A=
-=0A=
-class DesktopSetupPage:public PropertyPage=0A=
-{=0A=
-public:=0A=
-  DesktopSetupPage ()=0A=
-  {=0A=
-  };=0A=
-  virtual ~ DesktopSetupPage ()=0A=
-  {=0A=
-  };=0A=
-=0A=
-  bool Create ();=0A=
-=0A=
-  virtual void OnInit ();=0A=
-  virtual bool OnFinish ();=0A=
-  virtual long OnBack ();=0A=
-};=0A=
-=0A=
-#endif // CINSTALL_DESKTOP_H=0A=
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
Index: geturl.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/geturl.cc,v=0A=
retrieving revision 2.16=0A=
diff -p -u -r2.16 geturl.cc=0A=
--- geturl.cc	2001/12/23 12:13:28	2.16=0A=
+++ geturl.cc	2002/01/01 14:02:20=0A=
@@ -94,7 +94,7 @@ progress (int bytes)=0A=
     {=0A=
       int perc =3D (int)(100.0 * ((double)bytes) / (double)max_bytes);=0A=
       Progress.SetBar1(bytes, max_bytes);=0A=
-      sprintf (buf, "%3d %%  (%dk/%dk)  %2.1f kb/s\n",=0A=
+      sprintf (buf, "%d %%  (%dk/%dk)  %03.1f kb/s\n",=0A=
 	       perc, bytes / 1000, max_bytes / 1000, kbps);=0A=
       if (total_download_bytes > 0)=0A=
 	{=0A=
Index: io_stream.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/io_stream.cc,v=0A=
retrieving revision 2.6=0A=
diff -p -u -r2.6 io_stream.cc=0A=
--- io_stream.cc	2002/01/01 12:32:36	2.6=0A=
+++ io_stream.cc	2002/01/01 14:02:22=0A=
@@ -21,7 +21,7 @@=0A=
=20=0A=
 #if 0=0A=
 static const char *cvsid =3D=0A=
-  "\n%%% $Id: io_stream.cc,v 2.6 2002/01/01 12:32:36 rbcollins Exp $\n";=
=0A=
+  "\n%%% $Id: io_stream.cc,v 2.5 2001/12/20 11:49:54 rbcollins Exp $\n";=
=0A=
 #endif=0A=
=20=0A=
 #include "win32.h"=0A=
@@ -170,24 +170,21 @@ io_stream::move_copy (const char *from,=20=0A=
   return 0;=0A=
 }=0A=
=20=0A=
-ssize_t io_stream::copy (io_stream * in, io_stream * out)=0A=
+ssize_t=0A=
+io_stream::copy (io_stream *in, io_stream *out)=0A=
 {=0A=
   if (!in || !out)=0A=
     return -1;=0A=
-  char=0A=
-    buffer[16384];=0A=
-  ssize_t=0A=
-    countin,=0A=
-    countout;=0A=
+  char buffer[16384];=0A=
+  ssize_t countin, countout;=0A=
   while ((countin =3D in->read (buffer, 16384)) > 0)=0A=
     {=0A=
       countout =3D out->write (buffer, countin);=0A=
       if (countout !=3D countin)=0A=
-	{=0A=
-	  log (LOG_TIMESTAMP, "io_stream::copy failed to write %ld bytes",=0A=
-	       countin);=0A=
-	  return countout ? countout : -1;=0A=
-	}=0A=
+        {=0A=
+          log (LOG_TIMESTAMP, "io_stream::copy failed to write %ld bytes",=
 countin);=0A=
+          return countout ? countout : -1;=0A=
+        }=0A=
     }=0A=
=20=0A=
   /* TODO:=0A=
@@ -275,3 +272,5 @@ io_stream::~io_stream ()=0A=
   log (LOG_TIMESTAMP, "io_stream::~io_stream called");=0A=
   return;=0A=
 }=0A=
+=0A=
+=0A=
Index: io_stream.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/io_stream.h,v=0A=
retrieving revision 2.6=0A=
diff -p -u -r2.6 io_stream.h=0A=
--- io_stream.h	2002/01/01 12:32:36	2.6=0A=
+++ io_stream.h	2002/01/01 14:02:23=0A=
@@ -152,11 +152,9 @@ public:=0A=
   /* if you are still needing these hints... give up now! */=0A=
     virtual ~ io_stream () =3D 0;=0A=
 protected:=0A=
-  void operator=3D (const io_stream &);=0A=
-    io_stream ()=0A=
-  {=0A=
-  };=0A=
-  io_stream (const io_stream &);=0A=
+    void operator=3D (const io_stream &);=0A=
+    io_stream () {};=0A=
+    io_stream (const io_stream &);=0A=
 private:=0A=
   static int move_copy (char const *, char const *);=0A=
 };=0A=
Index: localdir.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/localdir.h,v=0A=
retrieving revision 2.1=0A=
diff -p -u -r2.1 localdir.h=0A=
--- localdir.h	2001/12/23 12:13:29	2.1=0A=
+++ localdir.h	2002/01/01 14:02:24=0A=
@@ -1,44 +1,44 @@=0A=
-#ifndef CINSTALL_LOCALDIR_H=0A=
-#define CINSTALL_LOCALDIR_H=0A=
-=0A=
-/*=0A=
- * Copyright (c) 2001, Gary R. Van Sickle.=0A=
- *=0A=
- *     This program is free software; you can redistribute it and/or modif=
y=0A=
- *     it under the terms of the GNU General Public License as published b=
y=0A=
- *     the Free Software Foundation; either version 2 of the License, or=
=0A=
- *     (at your option) any later version.=0A=
- *=0A=
- *     A copy of the GNU General Public License can be found at=0A=
- *     http://www.gnu.org/=0A=
- *=0A=
- * Written by Gary R. Van Sickle <g.r.vansickle@worldnet.att.net>=0A=
- *=0A=
- */=0A=
-=0A=
-// This is the header for the LocalDirPage class.  Allows the user to sele=
ct=0A=
-// the local package directory (i.e. where downloaded packages are stored)=
.=0A=
-=0A=
-=0A=
-#include "proppage.h"=0A=
-=0A=
-class LocalDirPage:public PropertyPage=0A=
-{=0A=
-public:=0A=
-  LocalDirPage ()=0A=
-  {=0A=
-  };=0A=
-  virtual ~ LocalDirPage ()=0A=
-  {=0A=
-  };=0A=
-=0A=
-  bool Create ();=0A=
-=0A=
-  virtual void OnActivate ();=0A=
-  virtual void OnInit ();=0A=
-  virtual long OnNext ();=0A=
-  virtual long OnBack ();=0A=
-};=0A=
-=0A=
-=0A=
-#endif=0A=
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
+  virtual void OnActivate ();=0A=
+  virtual void OnInit ();=0A=
+  virtual long OnNext ();=0A=
+  virtual long OnBack ();=0A=
+};=0A=
+=0A=
+=0A=
+#endif=0A=
Index: net.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/net.cc,v=0A=
retrieving revision 2.8=0A=
diff -p -u -r2.8 net.cc=0A=
--- net.cc	2001/12/23 12:13:29	2.8=0A=
+++ net.cc	2002/01/01 14:02:27=0A=
@@ -31,16 +31,18 @@ static const char *cvsid =3D=0A=
 #include "log.h"=0A=
=20=0A=
 #include "net.h"=0A=
-=0A=
+#include "propsheet.h"=0A=
 #include "threebar.h"=0A=
 extern ThreeBarProgressPage Progress;=0A=
=20=0A=
 static int rb[] =3D { IDC_NET_IE5, IDC_NET_DIRECT, IDC_NET_PROXY, 0 };=0A=
=20=0A=
-static void=0A=
-check_if_enable_next (HWND h)=0A=
+void=0A=
+NetPage::CheckIfEnableNext ()=0A=
 {=0A=
   int e =3D 0, p =3D 0, pu =3D 0;=0A=
+  DWORD ButtonFlags =3D PSWIZB_BACK;=0A=
+=0A=
   if (net_method =3D=3D IDC_NET_IE5)=0A=
     pu =3D 1;=0A=
   if (net_method =3D=3D IDC_NET_IE5 || net_method =3D=3D IDC_NET_DIRECT)=
=0A=
@@ -51,9 +53,16 @@ check_if_enable_next (HWND h)=0A=
       if (net_proxy_host && net_proxy_port)=0A=
 	e =3D 1;=0A=
     }=0A=
-  EnableWindow (GetDlgItem (h, IDOK), e);=0A=
-  EnableWindow (GetDlgItem (h, IDC_PROXY_HOST), p);=0A=
-  EnableWindow (GetDlgItem (h, IDC_PROXY_PORT), p);=0A=
+	if (e)=0A=
+	{=0A=
+		// There's something in the proxy and port boxes, enable "Next".=0A=
+		ButtonFlags |=3D PSWIZB_NEXT;=0A=
+	}=0A=
+=0A=
+  GetOwner ()->SetButtons (ButtonFlags);=0A=
+=0A=
+  EnableWindow (GetDlgItem (IDC_PROXY_HOST), p);=0A=
+  EnableWindow (GetDlgItem (IDC_PROXY_PORT), p);=0A=
 }=0A=
=20=0A=
 static void=0A=
@@ -64,7 +73,6 @@ load_dialog (HWND h)=0A=
   if (net_proxy_port =3D=3D 0)=0A=
     net_proxy_port =3D 80;=0A=
   eset (h, IDC_PROXY_PORT, net_proxy_port);=0A=
-  check_if_enable_next (h);=0A=
 }=0A=
=20=0A=
 static void=0A=
@@ -75,28 +83,10 @@ save_dialog (HWND h)=0A=
   net_proxy_port =3D eget (h, IDC_PROXY_PORT);=0A=
 }=0A=
=20=0A=
-static BOOL=0A=
-dialog_cmd (HWND h, int id, HWND hwndctl, UINT code)=0A=
-{=0A=
-  switch (id)=0A=
-    {=0A=
-=0A=
-    case IDC_NET_IE5:=0A=
-    case IDC_NET_DIRECT:=0A=
-    case IDC_NET_PROXY:=0A=
-    case IDC_PROXY_HOST:=0A=
-    case IDC_PROXY_PORT:=0A=
-      save_dialog (h);=0A=
-      check_if_enable_next (h);=0A=
-      break;=0A=
-    }=0A=
-  return 0;=0A=
-}=0A=
-=0A=
 bool=0A=
 NetPage::Create ()=0A=
 {=0A=
-  return PropertyPage::Create (NULL, dialog_cmd, IDD_NET);=0A=
+  return PropertyPage::Create (IDD_NET);=0A=
 }=0A=
=20=0A=
 void=0A=
@@ -106,6 +96,7 @@ NetPage::OnInit ()=0A=
=20=0A=
   net_method =3D IDC_NET_DIRECT;=0A=
   load_dialog (h);=0A=
+  CheckIfEnableNext();=0A=
=20=0A=
   // Check to see if any radio buttons are selected. If not, select a defa=
ult.=0A=
   if ((!SendMessage (GetDlgItem (IDC_NET_IE5), BM_GETCHECK, 0, 0) =3D=3D=
=0A=
@@ -135,4 +126,27 @@ NetPage::OnBack ()=0A=
 {=0A=
   save_dialog (GetHWND ());=0A=
   return 0;=0A=
+}=0A=
+=0A=
+bool=0A=
+NetPage::OnMessageCmd (int id, HWND hwndctl, UINT code)=0A=
+{=0A=
+  switch (id)=0A=
+    {=0A=
+    case IDC_NET_IE5:=0A=
+    case IDC_NET_DIRECT:=0A=
+    case IDC_NET_PROXY:=0A=
+    case IDC_PROXY_HOST:=0A=
+    case IDC_PROXY_PORT:=0A=
+      save_dialog (GetHWND());=0A=
+      CheckIfEnableNext ();=0A=
+      break;=0A=
+=0A=
+    default:=0A=
+      // Wasn't recognized or handled.=0A=
+      return false;=0A=
+    }=0A=
+=0A=
+  // Was handled since we never got to default above.=0A=
+  return true;=0A=
 }=0A=
Index: net.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/net.h,v=0A=
retrieving revision 2.1=0A=
diff -p -u -r2.1 net.h=0A=
--- net.h	2001/12/23 12:13:29	2.1=0A=
+++ net.h	2002/01/01 14:02:27=0A=
@@ -1,42 +1,46 @@=0A=
-#ifndef CINSTALL_NET_H=0A=
-#define CINSTALL_NET_H=0A=
-=0A=
-/*=0A=
- * Copyright (c) 2001, Gary R. Van Sickle.=0A=
- *=0A=
- *     This program is free software; you can redistribute it and/or modif=
y=0A=
- *     it under the terms of the GNU General Public License as published b=
y=0A=
- *     the Free Software Foundation; either version 2 of the License, or=
=0A=
- *     (at your option) any later version.=0A=
- *=0A=
- *     A copy of the GNU General Public License can be found at=0A=
- *     http://www.gnu.org/=0A=
- *=0A=
- * Written by Gary R. Van Sickle <g.r.vansickle@worldnet.att.net>=0A=
- *=0A=
- */=0A=
-=0A=
-// This is the header for the NetPage class.  It allows the user to select=
=0A=
-// a proxy etc.=0A=
-=0A=
-=0A=
-#include "proppage.h"=0A=
-=0A=
-class NetPage:public PropertyPage=0A=
-{=0A=
-public:=0A=
-  NetPage ()=0A=
-  {=0A=
-  };=0A=
-  virtual ~ NetPage ()=0A=
-  {=0A=
-  };=0A=
-=0A=
-  bool Create ();=0A=
-=0A=
-  virtual void OnInit ();=0A=
-  virtual long OnNext ();=0A=
-  virtual long OnBack ();=0A=
-};=0A=
-=0A=
-#endif // CINSTALL_NET_H=0A=
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
+  void CheckIfEnableNext ();=0A=
+=0A=
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
+=0A=
+  virtual bool OnMessageCmd (int id, HWND hwndctl, UINT code);=0A=
+};=0A=
+=0A=
+#endif // CINSTALL_NET_H=0A=
Index: package_db.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/package_db.cc,v=0A=
retrieving revision 2.14=0A=
diff -p -u -r2.14 package_db.cc=0A=
--- package_db.cc	2002/01/01 12:32:36	2.14=0A=
+++ package_db.cc	2002/01/01 14:02:29=0A=
@@ -20,7 +20,7 @@=0A=
=20=0A=
 #if 0=0A=
 static const char *cvsid =3D=0A=
-  "\n%%% $Id: package_db.cc,v 2.14 2002/01/01 12:32:36 rbcollins Exp $\n";=
=0A=
+  "\n%%% $Id: package_db.cc,v 2.13 2001/12/23 12:13:29 rbcollins Exp $\n";=
=0A=
 #endif=0A=
 #include <stdio.h>=0A=
 #include <stdlib.h>=0A=
@@ -42,7 +42,7 @@ static const char *cvsid =3D=0A=
=20=0A=
 packagedb::packagedb ()=0A=
 {=0A=
-  io_stream *db =3D 0;=0A=
+  io_stream * db =3D 0;=0A=
   if (!installeddbread)=0A=
     {=0A=
       /* no parameters. Read in the local installation database. */=0A=
@@ -131,22 +131,22 @@ packagedb::flush ()=0A=
   ndb->write ("INSTALLED.DB 2\n", strlen ("INSTALLED.DB 2\n"));=0A=
   for (size_t n =3D 1; n < packages.number (); n++)=0A=
     {=0A=
-      packagemeta & pkgm =3D *packages[n];=0A=
-      if (pkgm.installed)=0A=
-	{=0A=
-	  char line[2048];=0A=
+      packagemeta &pkgm =3D * packages[n];=0A=
+	  if (pkgm.installed)=0A=
+	    {=0A=
+	      char line[2048];=0A=
=20=0A=
-	  /* size here is irrelevant - as we can assume that this install source=
=0A=
-	   * no longer exists, and it does not correlate to used disk space=0A=
-	   * also note that we are writing a fictional install source=20=0A=
-	   * to keep cygcheck happy.=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=0A=
-	   */=0A=
-	  sprintf (line, "%s %s %d\n", pkgm.name,=0A=
-		   concat (pkgm.name, "-",=0A=
-			   pkgm.installed->Canonical_version (),=0A=
-			   ".tar.bz2", 0), 0);=0A=
-	  ndb->write (line, strlen (line));=0A=
-	}=0A=
+	      /* size here is irrelevant - as we can assume that this install sou=
rce=0A=
+	       * no longer exists, and it does not correlate to used disk space=
=0A=
+	       * also note that we are writing a fictional install source=20=0A=
+	       * to keep cygcheck happy.=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=0A=
+	       */=0A=
+	      sprintf (line, "%s %s %d\n", pkgm.name,=0A=
+		       concat (pkgm.name, "-",=0A=
+			       pkgm.installed->Canonical_version (),=0A=
+			       ".tar.bz2", 0), 0);=0A=
+	      ndb->write (line, strlen (line));=0A=
+	    }=0A=
     }=0A=
=20=0A=
   delete ndb;=0A=
@@ -158,15 +158,9 @@ packagedb::flush ()=0A=
   return 0;=0A=
 }=0A=
=20=0A=
-int=0A=
-  packagedb::installeddbread =3D=0A=
-  0;=0A=
-list < packagemeta, char const *,=0A=
-  strcasecmp >=0A=
-  packagedb::packages;=0A=
+int packagedb::installeddbread =3D 0;=0A=
+list < packagemeta, char const *, strcasecmp > packagedb::packages;=0A=
 list < Category, char const *,=0A=
   strcasecmp >=0A=
   packagedb::categories;=0A=
-PackageDBActions=0A=
-  packagedb::task =3D=0A=
-  PackageDB_Install;=0A=
+PackageDBActions packagedb::task =3D PackageDB_Install;=0A=
Index: package_meta.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/package_meta.cc,v=0A=
retrieving revision 2.9=0A=
diff -p -u -r2.9 package_meta.cc=0A=
--- package_meta.cc	2002/01/01 12:32:36	2.9=0A=
+++ package_meta.cc	2002/01/01 14:02:30=0A=
@@ -15,7 +15,7 @@=0A=
=20=0A=
 #if 0=0A=
 static const char *cvsid =3D=0A=
-  "\n%%% $Id: package_meta.cc,v 2.9 2002/01/01 12:32:36 rbcollins Exp $\n"=
;=0A=
+  "\n%%% $Id: package_meta.cc,v 2.8 2001/12/20 11:49:54 rbcollins Exp $\n"=
;=0A=
 #endif=0A=
=20=0A=
 #include <stdio.h>=0A=
@@ -150,7 +150,7 @@ packagemeta::add_category (Category & ca=0A=
 }=0A=
=20=0A=
 char const *=0A=
-packagemeta::SDesc () const=0A=
+packagemeta::SDesc ()=0A=
 {=0A=
   return versions[1]->SDesc ();=0A=
 };=0A=
Index: package_meta.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/package_meta.h,v=0A=
retrieving revision 2.9=0A=
diff -p -u -r2.9 package_meta.h=0A=
--- package_meta.h	2002/01/01 12:32:36	2.9=0A=
+++ package_meta.h	2002/01/01 14:02:30=0A=
@@ -70,6 +70,7 @@ public:=0A=
     strcpy (installed_from, installedfrom);=0A=
   };=0A=
=20=0A=
+=0A=
   ~packagemeta ()=0A=
   {=0A=
     delete[] name;=0A=
@@ -90,7 +91,7 @@ public:=0A=
   char *installed_from;=0A=
   /* SDesc is global in theory, across all package versions.=20=0A=
      LDesc is not: it can be different per version */=0A=
-  char const *SDesc () const;=0A=
+  char const *SDesc ();=0A=
   /* what categories does this package belong in. Note that if multiple ve=
rsions=0A=
    * of a package disagree.... the first one read in will take precedence.=
=0A=
    */=0A=
Index: proppage.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/proppage.cc,v=0A=
retrieving revision 2.2=0A=
diff -p -u -r2.2 proppage.cc=0A=
--- proppage.cc	2002/01/01 12:32:36	2.2=0A=
+++ proppage.cc	2002/01/01 14:02:32=0A=
@@ -19,6 +19,7 @@=0A=
 #include "proppage.h"=0A=
 #include "propsheet.h"=0A=
 #include "win32.h"=0A=
+#include "resource.h"=0A=
=20=0A=
 bool PropertyPage::DoOnceForSheet =3D true;=0A=
=20=0A=
@@ -111,6 +112,11 @@ PropertyPage::DialogProc (UINT message,=20=0A=
     case WM_INITDIALOG:=0A=
       {=0A=
 	OnInit ();=0A=
+=0A=
+	// Set header title font of each internal page to MS Sans Serif, Bold, 8 =
Pt.=0A=
+	// This will just silently fail on the first and last pages.=0A=
+	SetDlgItemFont(IDC_STATIC_HEADER_TITLE, "MS Sans Serif", 8, FW_BOLD);=0A=
+=0A=
 	// TRUE =3D Set focus to default control (in wParam).=0A=
 	return TRUE;=0A=
 	break;=0A=
@@ -130,13 +136,6 @@ PropertyPage::DialogProc (UINT message,=20=0A=
 		GetOwner ()->SetHWNDFromPage (((NMHDR FAR *) lParam)->=0A=
 					      hwndFrom);=0A=
 		GetOwner ()->CenterWindow ();=0A=
-		// Add a minimize box to the parent property sheet.  We do this here=0A=
-		// instead of in the sheet class mainly because it will work with either=
=0A=
-		// modal or modeless sheets.=0A=
-		LONG style =3D::GetWindowLong (((NMHDR FAR *) lParam)->hwndFrom,=0A=
-					     GWL_STYLE);=0A=
-		::SetWindowLong (((NMHDR FAR *) lParam)->hwndFrom, GWL_STYLE,=0A=
-				 style | WS_MINIMIZEBOX);=0A=
 		DoOnceForSheet =3D false;=0A=
 	      }=0A=
=20=0A=
@@ -145,19 +144,16 @@ PropertyPage::DialogProc (UINT message,=20=0A=
 	      {=0A=
 		// Disable "Back" on first page.=0A=
 		GetOwner ()->SetButtons (PSWIZB_NEXT);=0A=
-		//::PropSheet_SetWizButtons(((NMHDR FAR *) lParam)->hwndFrom, PSWIZB_NEX=
T);=0A=
 	      }=0A=
 	    else if (IsLast)=0A=
 	      {=0A=
 		// Disable "Next", enable "Finish" on last page=0A=
 		GetOwner ()->SetButtons (PSWIZB_BACK | PSWIZB_FINISH);=0A=
-		//::PropSheet_SetWizButtons(((NMHDR FAR *) lParam)->hwndFrom, PSWIZB_BAC=
K | PSWIZB_FINISH);=0A=
 	      }=0A=
 	    else=0A=
 	      {=0A=
 		// Middle page, enable both "Next" and "Back" buttons=0A=
 		GetOwner ()->SetButtons (PSWIZB_BACK | PSWIZB_NEXT);=0A=
-		//::PropSheet_SetWizButtons(((NMHDR FAR *) lParam)->hwndFrom, PSWIZB_BAC=
K | PSWIZB_NEXT);=0A=
 	      }=0A=
=20=0A=
 	    OnActivate ();=0A=
@@ -202,11 +198,23 @@ PropertyPage::DialogProc (UINT message,=20=0A=
 	}=0A=
       break;=0A=
     case WM_COMMAND:=0A=
-      if (cmdproc !=3D NULL)=0A=
-	{=0A=
-	  return HANDLE_WM_COMMAND (GetHWND (), wParam, lParam, cmdproc);=0A=
-	}=0A=
-      break;=0A=
+      {=0A=
+	bool retval;=0A=
+=0A=
+	retval =3D=0A=
+	  OnMessageCmd (LOWORD (wParam), (HWND) lParam, HIWORD (wParam));=0A=
+	if (retval =3D=3D true)=0A=
+	  {=0A=
+	    // Handled, return 0=0A=
+	    SetWindowLong (GetHWND (), DWL_MSGRESULT, 0);=0A=
+	    return TRUE;=0A=
+	  }=0A=
+	else if (cmdproc !=3D NULL)=0A=
+	  {=0A=
+	    return HANDLE_WM_COMMAND (GetHWND (), wParam, lParam, cmdproc);=0A=
+	  }=0A=
+	break;=0A=
+      }=0A=
     default:=0A=
       break;=0A=
     }=0A=
Index: proppage.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/proppage.h,v=0A=
retrieving revision 2.1=0A=
diff -p -u -r2.1 proppage.h=0A=
--- proppage.h	2001/12/23 12:13:29	2.1=0A=
+++ proppage.h	2002/01/01 14:02:32=0A=
@@ -1,117 +1,117 @@=0A=
-#ifndef CINSTALL_PROPPAGE_H=0A=
-#define CINSTALL_PROPPAGE_H=0A=
-=0A=
-/*=0A=
- * Copyright (c) 2001, Gary R. Van Sickle.=0A=
- *=0A=
- *     This program is free software; you can redistribute it and/or modif=
y=0A=
- *     it under the terms of the GNU General Public License as published b=
y=0A=
- *     the Free Software Foundation; either version 2 of the License, or=
=0A=
- *     (at your option) any later version.=0A=
- *=0A=
- *     A copy of the GNU General Public License can be found at=0A=
- *     http://www.gnu.org/=0A=
- *=0A=
- * Written by Gary R. Van Sickle <g.r.vansickle@worldnet.att.net>=0A=
- *=0A=
- */=0A=
-=0A=
-// This is the header for the PropertyPage class.  It works closely with t=
he=0A=
-// PropSheet class to implement a single page of the property sheet.=0A=
-=0A=
-=0A=
-#include <windows.h>=0A=
-#include <prsht.h>=0A=
-=0A=
-#include "window.h"=0A=
-=0A=
-class PropSheet;=0A=
-=0A=
-class PropertyPage:public Window=0A=
-{=0A=
-  static bool DoOnceForSheet;=0A=
-  PROPSHEETPAGE psp;=0A=
-  DLGPROC proc;=0A=
-    BOOL (*cmdproc) (HWND h, int id, HWND hwndctl, UINT code);=0A=
-=0A=
-  // The sheet that owns this page.=0A=
-  PropSheet *OurSheet;=0A=
-=0A=
-  // For setting the back/finish buttons properly.=0A=
-  bool IsFirst, IsLast;=0A=
-=0A=
-  static BOOL CALLBACK FirstDialogProcReflector (HWND hwnd, UINT message,=
=0A=
-						 WPARAM wParam,=0A=
-						 LPARAM lParam);=0A=
-  static BOOL CALLBACK DialogProcReflector (HWND hwnd, UINT message,=0A=
-					    WPARAM wParam, LPARAM lParam);=0A=
-=0A=
-protected:=0A=
-    virtual BOOL CALLBACK DialogProc (UINT message, WPARAM wParam,=0A=
-				      LPARAM lParam);=0A=
-=0A=
-public:=0A=
-  PropertyPage ();=0A=
-  virtual ~ PropertyPage ();=0A=
-=0A=
-  PROPSHEETPAGE *GetPROPSHEETPAGEPtr ()=0A=
-  {=0A=
-    return &psp;=0A=
-  };=0A=
-=0A=
-  // FIXME: These should be private and friended to PropSheet.=0A=
-  void YouAreBeingAddedToASheet (PropSheet * ps)=0A=
-  {=0A=
-    OurSheet =3D ps;=0A=
-  };=0A=
-  void YouAreFirst ()=0A=
-  {=0A=
-    IsFirst =3D true;=0A=
-    IsLast =3D false;=0A=
-  };=0A=
-  void YouAreLast ()=0A=
-  {=0A=
-    IsFirst =3D false;=0A=
-    IsLast =3D true;=0A=
-  };=0A=
-  void YouAreMiddle ()=0A=
-  {=0A=
-    IsFirst =3D false;=0A=
-    IsLast =3D false;=0A=
-  };=0A=
-=0A=
-  virtual bool Create (int TemplateID);=0A=
-  virtual bool Create (DLGPROC dlgproc, int TemplateID);=0A=
-  virtual bool Create (DLGPROC dlgproc,=0A=
-		       BOOL (*cmdproc) (HWND h, int id, HWND hwndctl,=0A=
-					UINT code), int TemplateID);=0A=
-=0A=
-  virtual void OnInit ()=0A=
-  {=0A=
-  };=0A=
-  virtual void OnActivate ()=0A=
-  {=0A=
-  };=0A=
-  virtual void OnDeactivate ()=0A=
-  {=0A=
-  };=0A=
-  virtual long OnNext ()=0A=
-  {=0A=
-    return 0;=0A=
-  };=0A=
-  virtual long OnBack ()=0A=
-  {=0A=
-    return 0;=0A=
-  };=0A=
-  virtual bool OnFinish ()=0A=
-  {=0A=
-    return true;=0A=
-  };=0A=
-=0A=
-  PropSheet *GetOwner () const=0A=
-  {=0A=
-    return OurSheet;=0A=
-  };=0A=
-};=0A=
-=0A=
-#endif // CINSTALL_PROPPAGE_H=0A=
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
RCS file: /cvs/src/src/winsup/cinstall/propsheet.cc,v=0A=
retrieving revision 2.2=0A=
diff -p -u -r2.2 propsheet.cc=0A=
--- propsheet.cc	2002/01/01 12:32:36	2.2=0A=
+++ propsheet.cc	2002/01/01 14:02:33=0A=
@@ -35,7 +35,23 @@ DLLVERSIONINFO;=0A=
 typedef HRESULT CALLBACK (*DLLGETVERSIONPROC) (DLLVERSIONINFO * pdvi);=0A=
 #define PROPSHEETHEADER_V1_SIZE 40=0A=
=20=0A=
-=0A=
+// Sort of a "hidden" Windows structure.  Used in the PropSheetCallback.=
=0A=
+#include <pshpack1.h>=0A=
+typedef struct DLGTEMPLATEEX=0A=
+{=0A=
+  WORD dlgVer;=0A=
+  WORD signature;=0A=
+  DWORD helpID;=0A=
+  DWORD exStyle;=0A=
+  DWORD style;=0A=
+  WORD cDlgItems;=0A=
+  short x;=0A=
+  short y;=0A=
+  short cx;=0A=
+  short cy;=0A=
+}=0A=
+DLGTEMPLATEEX, *LPDLGTEMPLATEEX;=0A=
+#include <poppack.h>=0A=
=20=0A=
 PropSheet::PropSheet ()=0A=
 {=0A=
@@ -83,6 +99,28 @@ PropSheet::CreatePages ()=0A=
   return retarray;=0A=
 }=0A=
=20=0A=
+static int CALLBACK=0A=
+PropSheetProc (HWND hwndDlg, UINT uMsg, LPARAM lParam)=0A=
+{=0A=
+  switch (uMsg)=0A=
+    {=0A=
+    case PSCB_PRECREATE:=0A=
+      {=0A=
+	// Add a minimize box to the sheet/wizard.=0A=
+	if (((LPDLGTEMPLATEEX) lParam)->signature =3D=3D 0xFFFF)=0A=
+	  {=0A=
+	    ((LPDLGTEMPLATEEX) lParam)->style |=3D WS_MINIMIZEBOX;=0A=
+	  }=0A=
+	else=0A=
+	  {=0A=
+	    ((LPDLGTEMPLATE) lParam)->style |=3D WS_MINIMIZEBOX;=0A=
+	  }=0A=
+      }=0A=
+      return TRUE;=0A=
+    }=0A=
+  return TRUE;=0A=
+}=0A=
+=0A=
 static DWORD=0A=
 GetPROPSHEETHEADERSize ()=0A=
 {=0A=
@@ -126,15 +164,16 @@ GetPROPSHEETHEADERSize ()=0A=
   return retval;=0A=
 }=0A=
=20=0A=
-bool PropSheet::Create (const Window * Parent, DWORD Style)=0A=
+bool=0A=
+PropSheet::Create (const Window * Parent, DWORD Style)=0A=
 {=0A=
-  PROPSHEETHEADER=0A=
-    p;=0A=
+  PROPSHEETHEADER p;=0A=
=20=0A=
   PageHandles =3D CreatePages ();=0A=
=20=0A=
   p.dwSize =3D GetPROPSHEETHEADERSize ();=0A=
-  p.dwFlags =3D PSH_NOAPPLYNOW | PSH_WIZARD /*| PSH_MODELESS */ ;=0A=
+  p.dwFlags =3D=0A=
+    PSH_NOAPPLYNOW | PSH_WIZARD | PSH_USECALLBACK /*| PSH_MODELESS */ ;=0A=
   if (Parent !=3D NULL)=0A=
     {=0A=
       p.hwndParent =3D Parent->GetHWND ();=0A=
@@ -147,7 +186,7 @@ bool PropSheet::Create (const Window * P=0A=
   p.nPages =3D NumPropPages;=0A=
   p.nStartPage =3D 0;=0A=
   p.phpage =3D PageHandles;=0A=
-  p.pfnCallback =3D NULL;=0A=
+  p.pfnCallback =3D PropSheetProc;=0A=
=20=0A=
=20=0A=
   PropertySheet (&p);=0A=
@@ -188,13 +227,15 @@ PropSheet::AddPage (PropertyPage * p)=0A=
   NumPropPages++;=0A=
 }=0A=
=20=0A=
-bool PropSheet::SetActivePage (int i)=0A=
+bool=0A=
+PropSheet::SetActivePage (int i)=0A=
 {=0A=
   // Posts a message to the message queue, so this won't block=0A=
   return static_cast < bool > (::PropSheet_SetCurSel (GetHWND (), NULL, i)=
);=0A=
 }=0A=
=20=0A=
-bool PropSheet::SetActivePageByID (int resource_id)=0A=
+bool=0A=
+PropSheet::SetActivePageByID (int resource_id)=0A=
 {=0A=
   // Posts a message to the message queue, so this won't block=0A=
   return static_cast < bool >=0A=
Index: propsheet.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/propsheet.h,v=0A=
retrieving revision 2.1=0A=
diff -p -u -r2.1 propsheet.h=0A=
--- propsheet.h	2001/12/23 12:13:29	2.1=0A=
+++ propsheet.h	2002/01/01 14:02:33=0A=
@@ -1,59 +1,59 @@=0A=
-#ifndef CINSTALL_PROPSHEET_H=0A=
-#define CINSTALL_PROPSHEET_H=0A=
-=0A=
-/*=0A=
- * Copyright (c) 2001, Gary R. Van Sickle.=0A=
- *=0A=
- *     This program is free software; you can redistribute it and/or modif=
y=0A=
- *     it under the terms of the GNU General Public License as published b=
y=0A=
- *     the Free Software Foundation; either version 2 of the License, or=
=0A=
- *     (at your option) any later version.=0A=
- *=0A=
- *     A copy of the GNU General Public License can be found at=0A=
- *     http://www.gnu.org/=0A=
- *=0A=
- * Written by Gary R. Van Sickle <g.r.vansickle@worldnet.att.net>=0A=
- *=0A=
- */=0A=
-=0A=
-// This is the header for the PropSheet class.  This class encapsulates=0A=
-// a Windows property sheet / wizard and interfaces with the PropertyPage =
class.=0A=
-// It's named PropSheet instead of PropertySheet because the latter confli=
cts with=0A=
-// the Windows function of the same name.=0A=
-=0A=
-=0A=
-#include <windows.h>=0A=
-#include <prsht.h>=0A=
-=0A=
-#include "window.h"=0A=
-=0A=
-class PropertyPage;=0A=
-=0A=
-class PropSheet:public Window=0A=
-{=0A=
-  PropertyPage *PropertyPages[MAXPROPPAGES];=0A=
-  int NumPropPages;=0A=
-=0A=
-  HPROPSHEETPAGE *PageHandles;=0A=
-  HPROPSHEETPAGE *CreatePages ();=0A=
-=0A=
-public:=0A=
-  PropSheet ();=0A=
-  virtual ~ PropSheet ();=0A=
-=0A=
-  // Should be private and friended to PropertyPage=0A=
-  void SetHWNDFromPage (HWND h);=0A=
-=0A=
-  virtual bool Create (const Window * Parent =3D NULL,=0A=
-		       DWORD Style =3D=0A=
-		       WS_OVERLAPPEDWINDOW | WS_VISIBLE | WS_CLIPCHILDREN);=0A=
-=0A=
-  void AddPage (PropertyPage * p);=0A=
-=0A=
-  bool SetActivePage (int i);=0A=
-  bool SetActivePageByID (int resource_id);=0A=
-  void SetButtons (DWORD flags);=0A=
-  void PressButton (int button);=0A=
-};=0A=
-=0A=
-#endif // CINSTALL_PROPSHEET_H=0A=
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
retrieving revision 2.32=0A=
diff -p -u -r2.32 res.rc=0A=
--- res.rc	2001/12/23 12:13:29	2.32=0A=
+++ res.rc	2002/01/01 14:02:34=0A=
@@ -28,139 +28,149 @@ LANGUAGE LANG_ENGLISH, SUBLANG_ENGLISH_U=0A=
 // Dialog=0A=
 //=0A=
=20=0A=
-IDD_SOURCE DIALOG DISCARDABLE  0, 0, 215, 95=0A=
+IDD_SOURCE DIALOG DISCARDABLE  0, 0, 317, 179=0A=
 STYLE DS_MODALFRAME | DS_CENTER | WS_CHILD | WS_CAPTION | WS_SYSMENU=0A=
 CAPTION "Cygwin Setup"=0A=
 FONT 8, "MS Sans Serif"=0A=
 BEGIN=0A=
-    ICON            IDI_CYGWIN,-1,5,5,20,20=0A=
     CONTROL         "&Install from Internet",IDC_SOURCE_NETINST,"Button",=
=0A=
-                    BS_AUTORADIOBUTTON,55,15,75,10=0A=
+                    BS_AUTORADIOBUTTON | WS_GROUP | WS_TABSTOP,101,69,115,=
10=0A=
     CONTROL         "&Download from Internet",IDC_SOURCE_DOWNLOAD,"Button"=
,=0A=
-                    BS_AUTORADIOBUTTON,55,30,89,10=0A=
+                    BS_AUTORADIOBUTTON | WS_TABSTOP,101,84,115,10=0A=
     CONTROL         "Install from &Local Directory",IDC_SOURCE_CWD,"Button=
",=0A=
-                    BS_AUTORADIOBUTTON,55,45,99,10=0A=
+                    BS_AUTORADIOBUTTON | WS_TABSTOP,101,99,115,10=0A=
+    ICON            IDI_CYGWIN,IDC_STATIC,290,0,21,20=0A=
+    CONTROL         "",IDC_STATIC,"Static",SS_BLACKFRAME | SS_SUNKEN,0,28,=
=0A=
+                    317,1=0A=
+    LTEXT           "Choose A Download Source",IDC_STATIC_HEADER_TITLE,7,0=
,=0A=
+                    131,8,NOT WS_GROUP=0A=
+    LTEXT           "Choose whether to install or download from the intern=
et, or install from files in a local directory.",=0A=
+                    IDC_STATIC,21,9,239,16,NOT WS_GROUP=0A=
 END=0A=
=20=0A=
-IDD_LOCAL_DIR DIALOG DISCARDABLE  0, 0, 227, 94=0A=
+IDD_LOCAL_DIR DIALOG DISCARDABLE  0, 0, 317, 179=0A=
 STYLE DS_MODALFRAME | DS_CENTER | WS_CHILD | WS_CAPTION | WS_SYSMENU=0A=
 CAPTION "Cygwin Setup"=0A=
 FONT 8, "MS Sans Serif"=0A=
 BEGIN=0A=
-    ICON            IDI_CYGWIN,IDC_STATIC,5,5,20,20=0A=
-    PUSHBUTTON      "B&rowse...",IDC_LOCAL_DIR_BROWSE,185,30,34,14=0A=
-    LTEXT           "Local Package &Directory",IDC_STATIC,55,15,85,11=0A=
-    EDITTEXT        IDC_LOCAL_DIR,55,30,127,15,ES_AUTOHSCROLL=0A=
-END=0A=
-=0A=
-IDD_ROOT DIALOG DISCARDABLE  0, 0, 215, 95=0A=
-STYLE DS_MODALFRAME | DS_CENTER | WS_CHILD | WS_CAPTION | WS_SYSMENU=0A=
-CAPTION "Cygwin Setup"=0A=
-FONT 8, "MS Sans Serif"=0A=
-BEGIN=0A=
-    ICON            IDI_CYGWIN,IDC_STATIC,5,5,20,20=0A=
-    PUSHBUTTON      "B&rowse...",IDC_ROOT_BROWSE,150,10,34,14=0A=
-    LTEXT           "Select install root &directory",IDC_STATIC,55,15,85,1=
1=0A=
-    EDITTEXT        IDC_ROOT_DIR,55,25,127,12,ES_AUTOHSCROLL=0A=
-    RTEXT           "Default &Text File Type :",IDC_STATIC,20,45,100,8=0A=
-    CONTROL         "D&OS",IDC_ROOT_TEXT,"Button",BS_AUTORADIOBUTTON,125,4=
5,=0A=
-                    31,8=0A=
-    CONTROL         "&Unix",IDC_ROOT_BINARY,"Button",BS_AUTORADIOBUTTON,16=
0,=0A=
-                    45,30,8=0A=
-    RTEXT           "&Install For :",IDC_STATIC,55,60,65,8=0A=
-    CONTROL         "&All",IDC_ROOT_SYSTEM,"Button",BS_AUTORADIOBUTTON |=
=20=0A=
-                    WS_GROUP,125,60,25,8=0A=
-    CONTROL         "Just &Me",IDC_ROOT_USER,"Button",BS_AUTORADIOBUTTON,1=
60,=0A=
-                    60,50,8=0A=
+    EDITTEXT        IDC_LOCAL_DIR,58,83,165,15,ES_AUTOHSCROLL | WS_GROUP=
=0A=
+    PUSHBUTTON      "B&rowse...",IDC_LOCAL_DIR_BROWSE,223,83,34,14=0A=
+    GROUPBOX        "Local Package Directory",IDC_STATIC,53,67,210,45=0A=
+    ICON            IDI_CYGWIN,IDC_STATIC,290,0,21,20=0A=
+    CONTROL         "",IDC_STATIC,"Static",SS_BLACKFRAME | SS_SUNKEN,0,28,=
=0A=
+                    317,1=0A=
+    LTEXT           "Select a directory where you want Setup to store the =
installation files it dowloads.  The directory will be created if it does n=
ot already exist.",=0A=
+                    IDC_STATIC,21,9,248,16,NOT WS_GROUP=0A=
+    LTEXT           "Select Local Package Directory",IDC_STATIC_HEADER_TIT=
LE,=0A=
+                    7,0,258,8,NOT WS_GROUP=0A=
 END=0A=
=20=0A=
-IDD_SITE DIALOG DISCARDABLE  0, 0, 247, 94=0A=
+IDD_ROOT DIALOG DISCARDABLE  0, 0, 317, 179=0A=
 STYLE DS_MODALFRAME | DS_CENTER | WS_CHILD | WS_CAPTION | WS_SYSMENU=0A=
 CAPTION "Cygwin Setup"=0A=
 FONT 8, "MS Sans Serif"=0A=
 BEGIN=0A=
-    ICON            IDI_CYGWIN,IDC_STATIC,5,5,20,20=0A=
-    LTEXT           "Select Download &Site",IDC_STATIC,55,5,135,11=0A=
-    LISTBOX         IDC_URL_LIST,55,20,185,65,LBS_NOINTEGRALHEIGHT |=20=0A=
-                    LBS_EXTENDEDSEL | WS_VSCROLL | WS_HSCROLL | WS_TABSTOP=
=0A=
+    GROUPBOX        "Root Directory",IDC_STATIC,5,50,305,40,WS_TABSTOP=0A=
+    GROUPBOX        "Install For",IDC_STATIC,5,105,150,50,WS_TABSTOP=0A=
+    GROUPBOX        "Default Text File Type",IDC_STATIC,160,105,150,50=0A=
+    EDITTEXT        IDC_ROOT_DIR,15,65,245,15,ES_AUTOHSCROLL | WS_GROUP=0A=
+    PUSHBUTTON      "B&rowse...",IDC_ROOT_BROWSE,260,65,44,14=0A=
+    CONTROL         "&All Users",IDC_ROOT_SYSTEM,"Button",BS_AUTORADIOBUTT=
ON |=20=0A=
+                    WS_GROUP | WS_TABSTOP,15,120,85,8=0A=
+    CONTROL         "Just &Me",IDC_ROOT_USER,"Button",BS_AUTORADIOBUTTON |=
=20=0A=
+                    WS_TABSTOP,15,135,85,8=0A=
+    CONTROL         "D&OS",IDC_ROOT_TEXT,"Button",BS_AUTORADIOBUTTON |=20=
=0A=
+                    WS_GROUP | WS_TABSTOP,170,120,90,8=0A=
+    CONTROL         "&Unix",IDC_ROOT_BINARY,"Button",BS_AUTORADIOBUTTON |=
=20=0A=
+                    WS_TABSTOP,170,135,90,8=0A=
+    ICON            IDI_CYGWIN,IDC_STATIC,290,0,20,20=0A=
+    CONTROL         "",IDC_STATIC,"Static",SS_BLACKFRAME | SS_SUNKEN,0,28,=
=0A=
+                    317,1=0A=
+    LTEXT           "Select the directory where you want to install Cygwin=
.  Also choose a few installation parameters.",=0A=
+                    IDC_STATIC,21,9,239,16,NOT WS_GROUP=0A=
+    LTEXT           "Select Root Install Directory",IDC_STATIC_HEADER_TITL=
E,=0A=
+                    7,0,258,8,NOT WS_GROUP=0A=
 END=0A=
=20=0A=
-IDD_OTHER_URL DIALOG DISCARDABLE  0, 0, 215, 95=0A=
-STYLE DS_MODALFRAME | DS_CENTER | WS_POPUP | WS_CAPTION | WS_SYSMENU=0A=
+IDD_SITE DIALOG DISCARDABLE 0, 0, 317, 179=0A=
+STYLE DS_MODALFRAME | DS_3DLOOK | DS_CENTER | WS_CHILD | WS_VISIBLE |=20=
=0A=
+    WS_CAPTION | WS_SYSMENU=0A=
+EXSTYLE WS_EX_CONTROLPARENT=0A=
 CAPTION "Cygwin Setup"=0A=
 FONT 8, "MS Sans Serif"=0A=
 BEGIN=0A=
-    ICON            IDI_CYGWIN,IDC_STATIC,5,5,20,20=0A=
-    LTEXT           "Select &URL to download from",IDC_STATIC,55,15,135,11=
=0A=
-    EDITTEXT        IDC_OTHER_URL,55,25,127,12,ES_AUTOHSCROLL=0A=
-    DEFPUSHBUTTON   "&Next -->",IDOK,100,75,45,15=0A=
-    PUSHBUTTON      "Cancel",IDCANCEL,165,75,45,15=0A=
-    PUSHBUTTON      "<-- &Back",IDC_BACK,55,75,45,15=0A=
+    ICON            IDI_CYGWIN,IDC_STATIC,290,0,20,20=0A=
+    LISTBOX         IDC_URL_LIST,66,45,185,110,LBS_NOINTEGRALHEIGHT |=20=
=0A=
+                    LBS_EXTENDEDSEL | WS_VSCROLL | WS_HSCROLL | WS_GROUP |=
=20=0A=
+                    WS_TABSTOP=0A=
+    LTEXT           "Available Download Sites:",IDC_STATIC,66,34,183,8,NOT=
=20=0A=
+                    WS_GROUP=0A=
+    CONTROL         "",IDC_STATIC,"Static",SS_BLACKFRAME | SS_SUNKEN,0,28,=
=0A=
+                    317,1=0A=
+    LTEXT           "Choose a site from this list, or add your own sites t=
o the list",=0A=
+                    IDC_STATIC,21,9,239,16,NOT WS_GROUP=0A=
+    LTEXT           "Choose A Download Site",IDC_STATIC_HEADER_TITLE,7,0,2=
58,=0A=
+                    8,NOT WS_GROUP=0A=
+    EDITTEXT        IDC_EDIT_USER_URL,65,160,185,14,ES_AUTOHSCROLL |=20=0A=
+                    WS_GROUP=0A=
+    LTEXT           "User URL:",IDC_STATIC,15,162,45,8,NOT WS_GROUP=0A=
+    PUSHBUTTON      "Add",IDC_BUTTON_ADD_URL,250,160,50,14=0A=
 END=0A=
=20=0A=
-IDD_NET DIALOG DISCARDABLE  0, 0, 247, 106=0A=
+IDD_NET DIALOG DISCARDABLE  0, 0, 317, 179=0A=
 STYLE DS_MODALFRAME | DS_CENTER | WS_CHILD | WS_CAPTION | WS_SYSMENU=0A=
 CAPTION "Cygwin Setup"=0A=
 FONT 8, "MS Sans Serif"=0A=
 BEGIN=0A=
     CONTROL         "&Direct Connection",IDC_NET_DIRECT,"Button",=0A=
-                    BS_AUTORADIOBUTTON | WS_GROUP | WS_TABSTOP,55,10,73,10=
=0A=
+                    BS_AUTORADIOBUTTON | WS_GROUP | WS_TABSTOP,60,55,73,10=
=0A=
     CONTROL         "Use &IE5 Settings",IDC_NET_IE5,"Button",=0A=
-                    BS_AUTORADIOBUTTON | WS_TABSTOP,55,25,69,10=0A=
+                    BS_AUTORADIOBUTTON | WS_TABSTOP,60,70,69,10=0A=
     CONTROL         "Use HTTP/FTP &Proxy:",IDC_NET_PROXY,"Button",=0A=
-                    BS_AUTORADIOBUTTON | WS_TABSTOP,55,40,88,10=0A=
-    EDITTEXT        IDC_PROXY_HOST,115,60,120,12,ES_AUTOHSCROLL |=20=0A=
+                    BS_AUTORADIOBUTTON | WS_TABSTOP,60,85,88,10=0A=
+    EDITTEXT        IDC_PROXY_HOST,120,105,120,12,ES_AUTOHSCROLL |=20=0A=
                     WS_DISABLED | WS_GROUP=0A=
-    EDITTEXT        IDC_PROXY_PORT,115,80,30,12,ES_AUTOHSCROLL | WS_DISABL=
ED=0A=
-    GROUPBOX        "",IDC_STATIC,55,50,185,50=0A=
-    ICON            IDI_CYGWIN,IDC_STATIC,5,5,21,20=0A=
-    RTEXT           "Proxy &Host",IDC_STATIC,60,60,50,12,SS_CENTERIMAGE |=
=20=0A=
+    EDITTEXT        IDC_PROXY_PORT,120,125,30,12,ES_AUTOHSCROLL |=20=0A=
+                    WS_DISABLED=0A=
+    GROUPBOX        "",IDC_STATIC,60,95,185,50=0A=
+    RTEXT           "Proxy &Host",IDC_STATIC,65,105,50,12,SS_CENTERIMAGE |=
=20=0A=
                     NOT WS_GROUP=0A=
-    RTEXT           "Por&t",IDC_STATIC,80,80,30,12,SS_CENTERIMAGE | NOT=20=
=0A=
+    RTEXT           "Por&t",IDC_STATIC,85,125,30,12,SS_CENTERIMAGE | NOT=
=20=0A=
                     WS_GROUP=0A=
+    ICON            IDI_CYGWIN,IDC_STATIC,290,0,21,20=0A=
+    CONTROL         "",IDC_STATIC,"Static",SS_BLACKFRAME | SS_SUNKEN,0,28,=
=0A=
+                    317,1=0A=
+    LTEXT           "Setup needs to know how you want it to connect to the=
 internet.  Choose the appropriate settings below.",=0A=
+                    IDC_STATIC,21,9,239,16,NOT WS_GROUP=0A=
+    LTEXT           "Select Your Internet Connection",=0A=
+                    IDC_STATIC_HEADER_TITLE,7,0,258,8,NOT WS_GROUP=0A=
 END=0A=
=20=0A=
-IDD_DLSTATUS DIALOG DISCARDABLE  0, 0, 215, 95=0A=
+IDD_INSTATUS DIALOG DISCARDABLE  0, 0, 317, 179=0A=
 STYLE DS_MODALFRAME | DS_CENTER | WS_CHILD | WS_VISIBLE | WS_CAPTION |=20=
=0A=
     WS_SYSMENU=0A=
 CAPTION "Cygwin Setup"=0A=
 FONT 8, "MS Sans Serif"=0A=
 BEGIN=0A=
-    ICON            IDI_CYGWIN,IDC_STATIC,5,5,20,20=0A=
-    PUSHBUTTON      "Cancel",IDCANCEL,165,75,45,15=0A=
-    LTEXT           "Downloading...",IDC_STATIC,55,5,135,8=0A=
-    LTEXT           "(URL)",IDC_DLS_URL,55,15,150,8=0A=
-    LTEXT           "(RATE)",IDC_DLS_RATE,55,25,155,8=0A=
-    CONTROL         "Progress1",IDC_DLS_PROGRESS,"msctls_progress32",=0A=
-                    PBS_SMOOTH | WS_BORDER,55,40,155,10=0A=
-    CONTROL         "Progress1",IDC_DLS_PPROGRESS,"msctls_progress32",=0A=
-                    PBS_SMOOTH | WS_BORDER,55,50,155,10=0A=
-    CONTROL         "Progress1",IDC_DLS_IPROGRESS,"msctls_progress32",=0A=
-                    PBS_SMOOTH | WS_BORDER,55,60,155,10=0A=
-    RTEXT           "Package",IDC_DLS_PROGRESS_TEXT,5,40,45,8=0A=
-    RTEXT           "Total",IDC_DLS_PPROGRESS_TEXT,10,50,40,8=0A=
-    RTEXT           "Disk",IDC_DLS_IPROGRESS_TEXT,5,60,45,8=0A=
-END=0A=
-=0A=
-IDD_INSTATUS DIALOG DISCARDABLE  0, 0, 252, 94=0A=
-STYLE DS_MODALFRAME | DS_CENTER | WS_CHILD | WS_VISIBLE | WS_CAPTION |=20=
=0A=
-    WS_SYSMENU=0A=
-CAPTION "Cygwin Setup"=0A=
-FONT 8, "MS Sans Serif"=0A=
-BEGIN=0A=
-    ICON            IDI_CYGWIN,IDC_STATIC,5,5,21,20=0A=
-    LTEXT           "Installing...",IDC_INS_ACTION,55,5,135,8=0A=
-    LTEXT           "(PKG)",IDC_INS_PKG,55,15,150,8=0A=
-    LTEXT           "(FILE)",IDC_INS_FILE,55,25,155,8=0A=
+    LTEXT           "Installing...",IDC_INS_ACTION,45,55,205,8,NOT WS_GROU=
P=0A=
+    LTEXT           "(PKG)",IDC_INS_PKG,45,70,205,8,NOT WS_GROUP=0A=
+    LTEXT           "(FILE)",IDC_INS_FILE,45,85,205,8,NOT WS_GROUP=0A=
     CONTROL         "Progress1",IDC_INS_DISKFULL,"msctls_progress32",=0A=
-                    PBS_SMOOTH | WS_BORDER,90,60,155,10=0A=
+                    PBS_SMOOTH | WS_BORDER,95,130,155,10=0A=
     CONTROL         "Progress1",IDC_INS_IPROGRESS,"msctls_progress32",=0A=
-                    PBS_SMOOTH | WS_BORDER,90,50,155,10=0A=
+                    PBS_SMOOTH | WS_BORDER,95,115,155,10=0A=
     CONTROL         "Progress1",IDC_INS_PPROGRESS,"msctls_progress32",=0A=
-                    PBS_SMOOTH | WS_BORDER,90,40,155,10=0A=
-    RTEXT           "Package",IDC_INS_BL_PACKAGE,40,40,45,8=0A=
-    RTEXT           "Total",IDC_INS_BL_TOTAL,45,50,40,8=0A=
-    RTEXT           "Disk",IDC_INS_BL_DISK,40,60,45,8=0A=
+                    PBS_SMOOTH | WS_BORDER,95,100,155,10=0A=
+    LTEXT           "Package:",IDC_INS_BL_PACKAGE,45,100,47,8,NOT WS_GROUP=
=0A=
+    LTEXT           "Total:",IDC_INS_BL_TOTAL,45,115,48,8,NOT WS_GROUP=0A=
+    LTEXT           "Disk:",IDC_INS_BL_DISK,45,130,47,8,NOT WS_GROUP=0A=
+    ICON            IDI_CYGWIN,IDC_STATIC,290,0,20,20=0A=
+    CONTROL         "",IDC_STATIC,"Static",SS_BLACKFRAME | SS_SUNKEN,0,28,=
=0A=
+                    317,1=0A=
+    LTEXT           "This page displays the progress of the download or in=
stallation.",=0A=
+                    IDC_STATIC,21,9,239,16,NOT WS_GROUP=0A=
+    LTEXT           "Progress",IDC_STATIC_HEADER_TITLE,7,0,253,8,NOT=20=0A=
+                    WS_GROUP=0A=
 END=0A=
=20=0A=
 IDD_PROXY_AUTH DIALOG DISCARDABLE  0, 0, 215, 95=0A=
@@ -197,23 +207,26 @@ BEGIN=0A=
     PUSHBUTTON      "Cancel",IDCANCEL,165,75,45,15=0A=
 END=0A=
=20=0A=
-IDD_SPLASH DIALOG DISCARDABLE  0, 0, 216, 94=0A=
+IDD_SPLASH DIALOG DISCARDABLE  0, 0, 317, 179=0A=
 STYLE DS_MODALFRAME | DS_3DLOOK | DS_CENTER | WS_CHILD | WS_VISIBLE |=20=
=0A=
     WS_CAPTION | WS_SYSMENU=0A=
 CAPTION "Cygwin Setup"=0A=
 FONT 8, "MS Sans Serif"=0A=
 BEGIN=0A=
-    ICON            IDI_CYGWIN,IDC_STATIC,5,5,20,20=0A=
-    LTEXT           "Cygwin Net Release Setup Program",IDC_STATIC,55,10,11=
4,=0A=
-                    8=0A=
-    LTEXT           "Version (unknown)",IDC_VERSION,55,25,120,10=0A=
-    LTEXT           "Copyright 2000, 2001 Red Hat Inc.",IDC_STATIC,55,35,1=
20,=0A=
-                    8=0A=
-    LTEXT           "http://sources.redhat.com/cygwin/",IDC_STATIC,55,50,1=
12,=0A=
-                    8=0A=
+    ICON            IDI_CYGWIN,IDC_STATIC,113,112,21,20,WS_GROUP=0A=
+    CONTROL         "",IDC_STATIC,"Static",SS_WHITERECT,0,0,95,178=0A=
+    LTEXT           "Version (unknown)",IDC_VERSION,115,137,195,10=0A=
+    LTEXT           "Cygwin Net Release Setup Program",=0A=
+                    IDC_STATIC_WELCOME_TITLE,115,1,195,24=0A=
+    LTEXT           "Copyright 2000, 2001 Red Hat Inc.",IDC_STATIC,115,150=
,=0A=
+                    195,8=0A=
+    LTEXT           "http://sources.redhat.com/cygwin/",IDC_STATIC,115,162=
,=0A=
+                    195,8=0A=
+    LTEXT           "This wizard will guide you through the installation a=
nd updating of the Cygwin environment and a plethora of GNU packages.",=0A=
+                    IDC_STATIC,115,33,195,54=0A=
 END=0A=
=20=0A=
-IDD_CHOOSE DIALOGEX 0, 0, 430, 266=0A=
+IDD_CHOOSE DIALOG DISCARDABLE  0, 0, 430, 266=0A=
 STYLE DS_MODALFRAME | DS_3DLOOK | DS_CENTER | WS_CHILD | WS_VISIBLE |=20=
=0A=
     WS_CAPTION | WS_SYSMENU=0A=
 EXSTYLE WS_EX_CONTROLPARENT=0A=
@@ -241,17 +254,23 @@ BEGIN=0A=
     LTEXT           "",IDC_CHOOSE_VIEWCAPTION,390,5,30,10=0A=
 END=0A=
=20=0A=
-IDD_DESKTOP DIALOG DISCARDABLE  0, 0, 215, 95=0A=
+IDD_DESKTOP DIALOG DISCARDABLE  0, 0, 317, 179=0A=
 STYLE DS_MODALFRAME | DS_3DLOOK | DS_CENTER | WS_CHILD | WS_VISIBLE |=20=
=0A=
     WS_CAPTION | WS_SYSMENU=0A=
 CAPTION "Cygwin Setup"=0A=
 FONT 8, "MS Sans Serif"=0A=
 BEGIN=0A=
-    ICON            IDI_CYGWIN,IDC_STATIC,5,5,20,20=0A=
-    CONTROL         "Create Desktop &Icon",IDC_ROOT_DESKTOP,"Button",=0A=
-                    BS_AUTOCHECKBOX,55,25,100,8=0A=
-    CONTROL         "Add to &Start Menu",IDC_ROOT_MENU,"Button",=0A=
-                    BS_AUTOCHECKBOX,55,40,100,8=0A=
+    CONTROL         "Create icon on &Desktop",IDC_ROOT_DESKTOP,"Button",=
=0A=
+                    BS_AUTOCHECKBOX,108,78,100,8=0A=
+    CONTROL         "Add icon to &Start Menu",IDC_ROOT_MENU,"Button",=0A=
+                    BS_AUTOCHECKBOX,108,93,100,8=0A=
+    ICON            IDI_CYGWIN,IDC_STATIC,290,0,21,20=0A=
+    CONTROL         "",IDC_STATIC,"Static",SS_BLACKFRAME | SS_SUNKEN,0,28,=
=0A=
+                    317,1=0A=
+    LTEXT           "Tell setup if you want it to create a few icons for c=
onvenient access to the Cygwin environment.",=0A=
+                    IDC_STATIC,21,9,239,16,NOT WS_GROUP=0A=
+    LTEXT           "Create Icons",IDC_STATIC_HEADER_TITLE,7,0,258,8,NOT=
=20=0A=
+                    WS_GROUP=0A=
 END=0A=
=20=0A=
 IDD_FTP_AUTH DIALOG DISCARDABLE  0, 0, 215, 95=0A=
@@ -271,13 +290,14 @@ BEGIN=0A=
     PUSHBUTTON      "Cancel",IDCANCEL,165,75,45,15=0A=
 END=0A=
=20=0A=
-IDD_CHOOSER DIALOG DISCARDABLE  0, 0, 186, 90=0A=
+IDD_CHOOSER DIALOG DISCARDABLE  0, 0, 247, 116=0A=
 STYLE DS_MODALFRAME | DS_3DLOOK | WS_CHILD | WS_VISIBLE | WS_CAPTION |=20=
=0A=
     WS_SYSMENU=0A=
 CAPTION "Cygwin Setup"=0A=
 FONT 8, "MS Sans Serif"=0A=
 BEGIN=0A=
-    LTEXT           "Don't look here",IDC_STATIC,25,38,134,8=0A=
+    CTEXT           "This space intentionally left blank",IDC_STATIC,57,45=
,=0A=
+                    134,8=0A=
 END=0A=
=20=0A=
=20=0A=
@@ -333,21 +353,39 @@ CYGWIN.ICON             FILE    DISCARDA=0A=
 #ifdef APSTUDIO_INVOKED=0A=
 GUIDELINES DESIGNINFO DISCARDABLE=20=0A=
 BEGIN=0A=
+    IDD_SOURCE, DIALOG=0A=
+    BEGIN=0A=
+        RIGHTMARGIN, 285=0A=
+        BOTTOMMARGIN, 158=0A=
+    END=0A=
+=0A=
     IDD_LOCAL_DIR, DIALOG=0A=
+    BEGIN=0A=
+        RIGHTMARGIN, 305=0A=
+        BOTTOMMARGIN, 157=0A=
+    END=0A=
+=0A=
+    IDD_ROOT, DIALOG=0A=
     BEGIN=0A=
-        RIGHTMARGIN, 215=0A=
+        RIGHTMARGIN, 285=0A=
+        BOTTOMMARGIN, 158=0A=
     END=0A=
=20=0A=
     IDD_SITE, DIALOG=0A=
     BEGIN=0A=
-        RIGHTMARGIN, 215=0A=
-        BOTTOMMARGIN, 93=0A=
+        BOTTOMMARGIN, 178=0A=
     END=0A=
=20=0A=
     IDD_NET, DIALOG=0A=
+    BEGIN=0A=
+        RIGHTMARGIN, 285=0A=
+        BOTTOMMARGIN, 133=0A=
+    END=0A=
+=0A=
+    IDD_INSTATUS, DIALOG=0A=
     BEGIN=0A=
-        RIGHTMARGIN, 215=0A=
-        BOTTOMMARGIN, 60=0A=
+        RIGHTMARGIN, 252=0A=
+        BOTTOMMARGIN, 157=0A=
     END=0A=
=20=0A=
     IDD_PROXY_AUTH, DIALOG=0A=
@@ -360,11 +398,23 @@ BEGIN=0A=
         BOTTOMMARGIN, 49=0A=
     END=0A=
=20=0A=
+    IDD_SPLASH, DIALOG=0A=
+    BEGIN=0A=
+        RIGHTMARGIN, 247=0A=
+        BOTTOMMARGIN, 116=0A=
+    END=0A=
+=0A=
     IDD_CHOOSE, DIALOG=0A=
     BEGIN=0A=
         RIGHTMARGIN, 429=0A=
     END=0A=
=20=0A=
+    IDD_DESKTOP, DIALOG=0A=
+    BEGIN=0A=
+        RIGHTMARGIN, 285=0A=
+        BOTTOMMARGIN, 158=0A=
+    END=0A=
+=0A=
     IDD_FTP_AUTH, DIALOG=0A=
     BEGIN=0A=
         BOTTOMMARGIN, 49=0A=
@@ -373,9 +423,9 @@ BEGIN=0A=
     IDD_CHOOSER, DIALOG=0A=
     BEGIN=0A=
         LEFTMARGIN, 7=0A=
-        RIGHTMARGIN, 179=0A=
+        RIGHTMARGIN, 240=0A=
         TOPMARGIN, 7=0A=
-        BOTTOMMARGIN, 83=0A=
+        BOTTOMMARGIN, 109=0A=
     END=0A=
 END=0A=
 #endif    // APSTUDIO_INVOKED=0A=
Index: resource.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/resource.h,v=0A=
retrieving revision 2.14=0A=
diff -p -u -r2.14 resource.h=0A=
--- resource.h	2001/12/23 12:13:29	2.14=0A=
+++ resource.h	2002/01/01 14:02:35=0A=
@@ -107,6 +107,10 @@=0A=
 #define IDC_INS_BL_PACKAGE              1053=0A=
 #define IDC_INS_BL_TOTAL                1054=0A=
 #define IDC_INS_BL_DISK                 1055=0A=
+#define IDC_STATIC_HEADER_TITLE         1060=0A=
+#define IDC_STATIC_WELCOME_TITLE        1061=0A=
+#define IDC_EDIT_USER_URL               1062=0A=
+#define IDC_BUTTON_ADD_URL              1063=0A=
 #define IDC_STATIC                      -1=0A=
=20=0A=
 // Next default values for new objects=0A=
@@ -115,9 +119,9 @@=0A=
 #ifndef APSTUDIO_READONLY_SYMBOLS=0A=
 #define _APS_NO_MFC                     1=0A=
 #define _APS_3D_CONTROLS                     1=0A=
-#define _APS_NEXT_RESOURCE_VALUE        128=0A=
+#define _APS_NEXT_RESOURCE_VALUE        129=0A=
 #define _APS_NEXT_COMMAND_VALUE         40003=0A=
-#define _APS_NEXT_CONTROL_VALUE         1056=0A=
+#define _APS_NEXT_CONTROL_VALUE         1064=0A=
 #define _APS_NEXT_SYMED_VALUE           101=0A=
 #endif=0A=
 #endif=0A=
Index: root.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/root.h,v=0A=
retrieving revision 2.1=0A=
diff -p -u -r2.1 root.h=0A=
--- root.h	2001/12/23 12:13:29	2.1=0A=
+++ root.h	2002/01/01 14:02:35=0A=
@@ -1,23 +1,23 @@=0A=
-#ifndef CINSTALL_ROOT_H=0A=
-#define CINSTALL_ROOT_H=0A=
-=0A=
-#include "proppage.h"=0A=
-=0A=
-class RootPage:public PropertyPage=0A=
-{=0A=
-public:=0A=
-  RootPage ()=0A=
-  {=0A=
-  };=0A=
-  virtual ~ RootPage ()=0A=
-  {=0A=
-  };=0A=
-=0A=
-  bool Create ();=0A=
-=0A=
-  virtual void OnInit ();=0A=
-  virtual long OnNext ();=0A=
-  virtual long OnBack ();=0A=
-};=0A=
-=0A=
-#endif // CINSTALL_ROOT_H=0A=
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
+  virtual void OnInit ();=0A=
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
retrieving revision 2.11=0A=
diff -p -u -r2.11 site.cc=0A=
--- site.cc	2001/12/23 12:13:29	2.11=0A=
+++ site.cc	2002/01/01 14:02:37=0A=
@@ -45,12 +45,10 @@ static const char *cvsid =3D=0A=
 #include "threebar.h"=0A=
 extern ThreeBarProgressPage Progress;=0A=
=20=0A=
-#define NO_IDX (-1)=0A=
-#define OTHER_IDX (-2)=0A=
-=0A=
 list < site_list_type, const char *, strcasecmp > site_list;=0A=
 list < site_list_type, const char *, strcasecmp > all_site_list;=0A=
-static int mirror_idx =3D NO_IDX;=0A=
+=0A=
+static char *other_url =3D 0;=0A=
=20=0A=
 void=0A=
 site_list_type::init (char const *newurl)=0A=
@@ -91,41 +89,17 @@ site_list_type::site_list_type (char con=0A=
   init (newurl);=0A=
 }=0A=
=20=0A=
-static void=0A=
-check_if_enable_next (HWND h)=0A=
-{=0A=
-  EnableWindow (GetDlgItem (h, IDOK),=0A=
-		SendMessage (GetDlgItem (h, IDC_URL_LIST), LB_GETSELCOUNT, 0,=0A=
-			     0) > 0 ? 1 : 0);=0A=
-}=0A=
-=0A=
 static void=0A=
-load_dialog (HWND h)=0A=
+save_dialog (HWND h)=0A=
 {=0A=
-  HWND listbox =3D GetDlgItem (h, IDC_URL_LIST);=0A=
-  for (size_t n =3D 1; n <=3D site_list.number (); n++)=0A=
+  // Remove anything that was previously in the selected site list.=0A=
+  while (site_list.number () > 0)=0A=
     {=0A=
-      int index =3D SendMessage (listbox, LB_FINDSTRING, (WPARAM) - 1,=0A=
-			       (LPARAM) site_list[n]->displayed_url);=0A=
-      if (index !=3D LB_ERR)=0A=
-	{=0A=
-	  // Highlight the selected item=0A=
-	  SendMessage (listbox, LB_SELITEMRANGE, TRUE, (index << 16) | index);=0A=
-	  // Make sure it's fully visible=0A=
-	  SendMessage (listbox, LB_SETCARETINDEX, index, FALSE);=0A=
-	}=0A=
+      // we don't delete the object because it's stored in the all_site_li=
st.=0A=
+      site_list.removebyindex (1);=0A=
     }=0A=
-  check_if_enable_next (h);=0A=
-}=0A=
=20=0A=
-static void=0A=
-save_dialog (HWND h)=0A=
-{=0A=
   HWND listbox =3D GetDlgItem (h, IDC_URL_LIST);=0A=
-  mirror_idx =3D 0;=0A=
-  while (site_list.number () > 0)=0A=
-    /* we don't delete the object because it's stored in the all_site_list=
. */=0A=
-    site_list.removebyindex (1);=0A=
   int sel_count =3D SendMessage (listbox, LB_GETSELCOUNT, 0, 0);=0A=
   if (sel_count > 0)=0A=
     {=0A=
@@ -140,16 +114,9 @@ save_dialog (HWND h)=0A=
 	{=0A=
 	  int mirror =3D=0A=
 	    SendMessage (listbox, LB_GETITEMDATA, sel_buffer[n], 0);=0A=
-	  if (mirror =3D=3D OTHER_IDX)=0A=
-	    mirror_idx =3D OTHER_IDX;=0A=
-	  else=0A=
-	    site_list.registerbyobject (*all_site_list[mirror]);=0A=
+	  site_list.registerbyobject (*all_site_list[mirror]);=0A=
 	}=0A=
     }=0A=
-  else=0A=
-    {=0A=
-      NEXT (IDD_SITE);=0A=
-    }=0A=
 }=0A=
=20=0A=
 void=0A=
@@ -160,29 +127,17 @@ save_site_url ()=0A=
     {=0A=
       if (f)=0A=
 	{=0A=
-	  char temp[_MAX_PATH];=0A=
-	  /* TODO: potential buffer overflow. we need snprintf asap. */=0A=
 	  // FIXME: write all selected sites=0A=
+	  TCHAR *temp;=0A=
+	  temp =3D new TCHAR[sizeof (TCHAR) * (strlen (site_list[n]->url) + 2)];=
=0A=
 	  sprintf (temp, "%s\n", site_list[n]->url);=0A=
 	  f->write (temp, strlen (temp));=0A=
+	  delete[]temp;=0A=
 	}=0A=
     }=0A=
   delete f;=0A=
 }=0A=
=20=0A=
-static BOOL=0A=
-dialog_cmd (HWND h, int id, HWND hwndctl, UINT code)=0A=
-{=0A=
-  switch (id)=0A=
-    {=0A=
-=0A=
-    case IDC_URL_LIST:=0A=
-      check_if_enable_next (h);=0A=
-      break;=0A=
-    }=0A=
-  return 0;=0A=
-}=0A=
-=0A=
 static int=0A=
 get_site_list (HINSTANCE h, HWND owner)=0A=
 {=0A=
@@ -302,7 +257,8 @@ do_download_site_info_thread (void *p)=0A=
       if (get_site_list (hinst, h))=0A=
 	{=0A=
 	  // Error: Couldn't download the site info.  Go back to the Net setup pa=
ge.=0A=
-	  NEXT (IDD_NET);=0A=
+	  MessageBox (h, TEXT ("Can't get list of download sites.\n\=0A=
+Make sure your network settings are corect and try again."), NULL, MB_OK);=
=0A=
=20=0A=
 	  // Tell the progress page that we're done downloading=0A=
 	  Progress.PostMessage (WM_APP_SITE_INFO_DOWNLOAD_COMPLETE, 0,=0A=
@@ -313,7 +269,6 @@ do_download_site_info_thread (void *p)=0A=
     }=0A=
=20=0A=
   // Everything worked, go to the site select page=0A=
-  NEXT (IDD_SITE);=0A=
=20=0A=
   // Tell the progress page that we're done downloading=0A=
   Progress.PostMessage (WM_APP_SITE_INFO_DOWNLOAD_COMPLETE, 0, IDD_SITE);=
=0A=
@@ -334,32 +289,15 @@ do_download_site_info (HINSTANCE hinst,=20=0A=
=20=0A=
 }=0A=
=20=0A=
-bool=0A=
-SitePage::Create ()=0A=
+bool SitePage::Create ()=0A=
 {=0A=
-  return PropertyPage::Create (NULL, dialog_cmd, IDD_SITE);=0A=
+  return PropertyPage::Create (IDD_SITE);=0A=
 }=0A=
=20=0A=
 void=0A=
 SitePage::OnInit ()=0A=
 {=0A=
-  HWND h =3D GetHWND ();=0A=
-  int j;=0A=
-  HWND listbox;=0A=
-=0A=
   get_saved_sites ();=0A=
-=0A=
-  listbox =3D GetDlgItem (IDC_URL_LIST);=0A=
-  for (size_t i =3D 1; i <=3D all_site_list.number (); i++)=0A=
-    {=0A=
-      j =3D=0A=
-	SendMessage (listbox, LB_ADDSTRING, 0,=0A=
-		     (LPARAM) all_site_list[i]->displayed_url);=0A=
-      SendMessage (listbox, LB_SETITEMDATA, j, i);=0A=
-    }=0A=
-  j =3D SendMessage (listbox, LB_ADDSTRING, 0, (LPARAM) "Other URL");=0A=
-  SendMessage (listbox, LB_SETITEMDATA, j, OTHER_IDX);=0A=
-  load_dialog (h);=0A=
 }=0A=
=20=0A=
 long=0A=
@@ -368,19 +306,14 @@ SitePage::OnNext ()=0A=
   HWND h =3D GetHWND ();=0A=
=20=0A=
   save_dialog (h);=0A=
-  if (mirror_idx =3D=3D OTHER_IDX)=0A=
-    NEXT (IDD_OTHER_URL);=0A=
-  else=0A=
-    {=0A=
-      save_site_url ();=0A=
-      NEXT (IDD_S_LOAD_INI);=0A=
+  save_site_url ();=0A=
=20=0A=
-      for (size_t n =3D 1; n <=3D site_list.number (); n++)=0A=
-	log (0, "site: %s", site_list[n]->url);=0A=
+  // Log all the selected URLs from the list.=20=20=20=20=0A=
+  for (size_t n =3D 1; n <=3D site_list.number (); n++)=0A=
+    log (0, "site: %s", site_list[n]->url);=0A=
=20=0A=
-      Progress.SetActivateTask (WM_APP_START_SETUP_INI_DOWNLOAD);=0A=
-      return IDD_INSTATUS;=0A=
-    }=0A=
+  Progress.SetActivateTask (WM_APP_START_SETUP_INI_DOWNLOAD);=0A=
+  return IDD_INSTATUS;=0A=
=20=0A=
   return 0;=0A=
 }=0A=
@@ -391,6 +324,126 @@ SitePage::OnBack ()=0A=
   HWND h =3D GetHWND ();=0A=
=20=0A=
   save_dialog (h);=0A=
-  NEXT (IDD_NET);=0A=
+=0A=
+  // Go back to the net connection type page=0A=
   return 0;=0A=
+}=0A=
+=0A=
+void=0A=
+SitePage::OnActivate ()=0A=
+{=0A=
+  // Fill the list box with all known sites.=0A=
+  PopulateListBox ();=0A=
+=0A=
+  // Load the user URL box with whatever it was last time.=0A=
+  eset (GetHWND (), IDC_EDIT_USER_URL, other_url);=0A=
+=0A=
+  // Get the enabled/disabled states of the controls set accordingly.=0A=
+  CheckControlsAndDisableAccordingly ();=0A=
+}=0A=
+=0A=
+void=0A=
+SitePage::CheckControlsAndDisableAccordingly () const=0A=
+{=0A=
+  DWORD ButtonFlags =3D PSWIZB_BACK;=0A=
+=0A=
+  // Check that at least one download site is selected.=0A=
+  if (SendMessage (GetDlgItem (IDC_URL_LIST), LB_GETSELCOUNT, 0, 0) > 0)=
=0A=
+    {=0A=
+      // At least one official site selected, enable "Next".=0A=
+      ButtonFlags |=3D PSWIZB_NEXT;=0A=
+    }=0A=
+  GetOwner ()->SetButtons (ButtonFlags);=0A=
+}=0A=
+=0A=
+void=0A=
+SitePage::PopulateListBox ()=0A=
+{=0A=
+  int j;=0A=
+  HWND listbox =3D GetDlgItem (IDC_URL_LIST);=0A=
+=0A=
+  // Populate the list box with the URLs.=0A=
+  SendMessage (listbox, LB_RESETCONTENT, 0, 0);=0A=
+  for (size_t i =3D 1; i <=3D all_site_list.number (); i++)=0A=
+    {=0A=
+      j =3D SendMessage (listbox, LB_ADDSTRING, 0,=0A=
+		       (LPARAM) all_site_list[i]->displayed_url);=0A=
+      SendMessage (listbox, LB_SETITEMDATA, j, i);=0A=
+    }=0A=
+=0A=
+  // Select the selected ones.=0A=
+  for (size_t n =3D 1; n <=3D site_list.number (); n++)=0A=
+    {=0A=
+      int index =3D SendMessage (listbox, LB_FINDSTRING, (WPARAM) - 1,=0A=
+			       (LPARAM) site_list[n]->displayed_url);=0A=
+      if (index !=3D LB_ERR)=0A=
+	{=0A=
+	  // Highlight the selected item=0A=
+	  SendMessage (listbox, LB_SELITEMRANGE, TRUE, (index << 16) | index);=0A=
+	  // Make sure it's fully visible=0A=
+	  SendMessage (listbox, LB_SETCARETINDEX, index, FALSE);=0A=
+	}=0A=
+    }=0A=
+}=0A=
+=0A=
+bool SitePage::OnMessageCmd (int id, HWND hwndctl, UINT code)=0A=
+{=0A=
+  switch (id)=0A=
+    {=0A=
+    case IDC_EDIT_USER_URL:=0A=
+      {=0A=
+	if (code =3D=3D EN_CHANGE)=0A=
+	  {=0A=
+	    // Text in edit box may have changed.=0A=
+	    other_url =3D eget (GetHWND (), IDC_EDIT_USER_URL, other_url);=0A=
+	  }=0A=
+	break;=0A=
+      }=0A=
+    case IDC_URL_LIST:=0A=
+      {=0A=
+	if (code =3D=3D LBN_SELCHANGE)=0A=
+	  {=0A=
+	    CheckControlsAndDisableAccordingly ();=0A=
+	  }=0A=
+	break;=0A=
+      }=0A=
+    case IDC_BUTTON_ADD_URL:=0A=
+      {=0A=
+	if (code =3D=3D BN_CLICKED)=0A=
+	  {=0A=
+	    // User pushed the Add button.=0A=
+	    other_url =3D eget (GetHWND (), IDC_EDIT_USER_URL, other_url);=0A=
+	    site_list_type *=0A=
+	      newsite =3D=0A=
+	      new=0A=
+	      site_list_type (other_url);=0A=
+	    site_list_type & listobj =3D=0A=
+	      all_site_list.registerbyobject (*newsite);=0A=
+	    if (&listobj !=3D newsite)=0A=
+	      {=0A=
+		// That site was already registered=0A=
+		delete=0A=
+		  newsite;=0A=
+	      }=0A=
+	    else=0A=
+	      {=0A=
+		// Log the adding of this new URL.=0A=
+		log (0, "Adding site: %s", other_url);=0A=
+	      }=0A=
+=0A=
+	    // Assume the user wants to use it and select it for him.=0A=
+	    site_list.registerbyobject (listobj);=0A=
+=0A=
+	    // Update the list box.=0A=
+	    PopulateListBox ();=0A=
+	  }=0A=
+	break;=0A=
+      }=0A=
+    default:=0A=
+      // Wasn't recognized or handled.=0A=
+      return false;=0A=
+    }=0A=
+=0A=
+  // Was handled since we never got to default above.=0A=
+  return true;=0A=
 }=0A=
Index: site.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/site.h,v=0A=
retrieving revision 2.2=0A=
diff -p -u -r2.2 site.h=0A=
--- site.h	2001/12/23 12:13:29	2.2=0A=
+++ site.h	2002/01/01 14:02:37=0A=
@@ -36,8 +36,14 @@ public:=0A=
   bool Create ();=0A=
=20=0A=
   virtual void OnInit ();=0A=
+  virtual void OnActivate ();=0A=
   virtual long OnNext ();=0A=
   virtual long OnBack ();=0A=
+=0A=
+  virtual bool OnMessageCmd (int id, HWND hwndctl, UINT code);=0A=
+=0A=
+  void PopulateListBox();=0A=
+  void CheckControlsAndDisableAccordingly () const;=0A=
 };=0A=
=20=0A=
 void do_download_site_info (HINSTANCE h, HWND owner);=0A=
Index: source.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/source.h,v=0A=
retrieving revision 2.1=0A=
diff -p -u -r2.1 source.h=0A=
--- source.h	2001/12/23 12:13:29	2.1=0A=
+++ source.h	2002/01/01 14:02:37=0A=
@@ -1,43 +1,43 @@=0A=
-#ifndef CINSTALL_SOURCE_H=0A=
-#define CINSTALL_SOURCE_H=0A=
-=0A=
-/*=0A=
- * Copyright (c) 2001, Gary R. Van Sickle.=0A=
- *=0A=
- *     This program is free software; you can redistribute it and/or modif=
y=0A=
- *     it under the terms of the GNU General Public License as published b=
y=0A=
- *     the Free Software Foundation; either version 2 of the License, or=
=0A=
- *     (at your option) any later version.=0A=
- *=0A=
- *     A copy of the GNU General Public License can be found at=0A=
- *     http://www.gnu.org/=0A=
- *=0A=
- * Written by Gary R. Van Sickle <g.r.vansickle@worldnet.att.net>=0A=
- *=0A=
- */=0A=
-=0A=
-// This is the header for the SourcePage class, which lets the user=0A=
-// select Download+Install, Download, or Install From Local Directory.=0A=
-=0A=
-=0A=
-#include "proppage.h"=0A=
-=0A=
-class SourcePage:public PropertyPage=0A=
-{=0A=
-public:=0A=
-  SourcePage ()=0A=
-  {=0A=
-  };=0A=
-  virtual ~ SourcePage ()=0A=
-  {=0A=
-  };=0A=
-=0A=
-  bool Create ();=0A=
-=0A=
-  virtual void OnActivate ();=0A=
-  virtual void OnDeactivate ();=0A=
-  virtual long OnNext ();=0A=
-  virtual long OnBack ();=0A=
-};=0A=
-=0A=
-#endif=0A=
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
+  virtual void OnActivate ();=0A=
+  virtual void OnDeactivate ();=0A=
+  virtual long OnNext ();=0A=
+  virtual long OnBack ();=0A=
+};=0A=
+=0A=
+#endif=0A=
Index: splash.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/splash.cc,v=0A=
retrieving revision 2.7=0A=
diff -p -u -r2.7 splash.cc=0A=
--- splash.cc	2001/12/23 12:13:29	2.7=0A=
+++ splash.cc	2002/01/01 14:02:37=0A=
@@ -36,4 +36,7 @@ SplashPage::OnInit ()=0A=
   ver.Format (IDS_VERSION_INFO, version[0] ? version : "[unknown]");=0A=
=20=0A=
   SetWindowText (GetDlgItem (IDC_VERSION), ver.c_str ());=0A=
+=0A=
+  // Set the font for the IDC_STATIC_WELCOME_TITLE=0A=
+  SetDlgItemFont(IDC_STATIC_WELCOME_TITLE, "Ariel", 12, FW_BOLD);=0A=
 }=0A=
Index: splash.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/splash.h,v=0A=
retrieving revision 2.1=0A=
diff -p -u -r2.1 splash.h=0A=
--- splash.h	2001/12/23 12:13:29	2.1=0A=
+++ splash.h	2002/01/01 14:02:37=0A=
@@ -1,38 +1,38 @@=0A=
-#ifndef CINSTALL_SPLASH_H=0A=
-#define CINSTALL_SPLASH_H=0A=
-=0A=
-/*=0A=
- * Copyright (c) 2001, Gary R. Van Sickle.=0A=
- *=0A=
- *     This program is free software; you can redistribute it and/or modif=
y=0A=
- *     it under the terms of the GNU General Public License as published b=
y=0A=
- *     the Free Software Foundation; either version 2 of the License, or=
=0A=
- *     (at your option) any later version.=0A=
- *=0A=
- *     A copy of the GNU General Public License can be found at=0A=
- *     http://www.gnu.org/=0A=
- *=0A=
- * Written by Gary R. Van Sickle <g.r.vansickle@worldnet.att.net>=0A=
- *=0A=
- */=0A=
-=0A=
-// This is the header for the SplashPage class.  Since the splash page=0A=
-// has little to do, there's not much here.=0A=
-=0A=
-#include "proppage.h"=0A=
-=0A=
-class SplashPage:public PropertyPage=0A=
-{=0A=
-public:=0A=
-  SplashPage ()=0A=
-  {=0A=
-  };=0A=
-  virtual ~ SplashPage ()=0A=
-  {=0A=
-  };=0A=
-=0A=
-  bool Create ();=0A=
-  virtual void OnInit ();=0A=
-};=0A=
-=0A=
-#endif // CINSTALL_SPLASH_H=0A=
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
+  virtual void OnInit ();=0A=
+};=0A=
+=0A=
+#endif // CINSTALL_SPLASH_H=0A=
Index: threebar.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/threebar.cc,v=0A=
retrieving revision 2.1=0A=
diff -p -u -r2.1 threebar.cc=0A=
--- threebar.cc	2001/12/23 12:13:29	2.1=0A=
+++ threebar.cc	2002/01/01 14:02:38=0A=
@@ -1,207 +1,207 @@=0A=
-/*=0A=
- * Copyright (c) 2001, Gary R. Van Sickle.=0A=
- *=0A=
- *     This program is free software; you can redistribute it and/or modif=
y=0A=
- *     it under the terms of the GNU General Public License as published b=
y=0A=
- *     the Free Software Foundation; either version 2 of the License, or=
=0A=
- *     (at your option) any later version.=0A=
- *=0A=
- *     A copy of the GNU General Public License can be found at=0A=
- *     http://www.gnu.org/=0A=
- *=0A=
- * Written by Gary R. Van Sickle <g.r.vansickle@worldnet.att.net>=0A=
- *=0A=
- */=0A=
-=0A=
-// This is the implementation of the ThreeBarProgressPage class.  It is a =
fairly generic=0A=
-// progress indicator property page with three progress bars.=0A=
-=0A=
-#include "win32.h"=0A=
-#include "commctrl.h"=0A=
-#include "resource.h"=0A=
-=0A=
-#include "dialog.h"=0A=
-#include "site.h"=0A=
-=0A=
-#include "propsheet.h"=0A=
-#include "threebar.h"=0A=
-=0A=
-bool=0A=
-ThreeBarProgressPage::Create ()=0A=
-{=0A=
-  return PropertyPage::Create (IDD_INSTATUS);=0A=
-}=0A=
-=0A=
-void=0A=
-ThreeBarProgressPage::OnInit ()=0A=
-{=0A=
-  // Get HWNDs to the dialog controls=0A=
-  ins_action =3D GetDlgItem (IDC_INS_ACTION);=0A=
-  ins_pkgname =3D GetDlgItem (IDC_INS_PKG);=0A=
-  ins_filename =3D GetDlgItem (IDC_INS_FILE);=0A=
-  // Bars=0A=
-  ins_pprogress =3D GetDlgItem (IDC_INS_PPROGRESS);=0A=
-  ins_iprogress =3D GetDlgItem (IDC_INS_IPROGRESS);=0A=
-  ins_diskfull =3D GetDlgItem (IDC_INS_DISKFULL);=0A=
-  // Bar labels=0A=
-  ins_bl_package =3D GetDlgItem (IDC_INS_BL_PACKAGE);=0A=
-  ins_bl_total =3D GetDlgItem (IDC_INS_BL_TOTAL);=0A=
-  ins_bl_disk =3D GetDlgItem (IDC_INS_BL_DISK);=0A=
-}=0A=
-=0A=
-void=0A=
-ThreeBarProgressPage::SetText1 (const TCHAR * t)=0A=
-{=0A=
-  SetWindowText (ins_action, t);=0A=
-}=0A=
-=0A=
-void=0A=
-ThreeBarProgressPage::SetText2 (const TCHAR * t)=0A=
-{=0A=
-  SetWindowText (ins_pkgname, t);=0A=
-}=0A=
-=0A=
-void=0A=
-ThreeBarProgressPage::SetText3 (const TCHAR * t)=0A=
-{=0A=
-  SetWindowText (ins_filename, t);=0A=
-}=0A=
-=0A=
-void=0A=
-ThreeBarProgressPage::SetBar1 (long progress, long max)=0A=
-{=0A=
-  int percent =3D (int) (100.0 * ((double) progress) / (double) max);=0A=
-  SendMessage (ins_pprogress, PBM_SETPOS, (WPARAM) percent, 0);=0A=
-}=0A=
-=0A=
-void=0A=
-ThreeBarProgressPage::SetBar2 (long progress, long max)=0A=
-{=0A=
-  int percent =3D (int) (100.0 * ((double) progress) / (double) max);=0A=
-  SendMessage (ins_iprogress, PBM_SETPOS, (WPARAM) percent, 0);=0A=
-}=0A=
-=0A=
-void=0A=
-ThreeBarProgressPage::SetBar3 (long progress, long max)=0A=
-{=0A=
-  int percent =3D (int) (100.0 * ((double) progress) / (double) max);=0A=
-  SendMessage (ins_diskfull, PBM_SETPOS, (WPARAM) percent, 0);=0A=
-}=0A=
-=0A=
-void=0A=
-ThreeBarProgressPage::EnableSingleBar (bool enable)=0A=
-{=0A=
-  // Switch to/from single bar mode=0A=
-  ShowWindow (ins_bl_total, enable ? SW_HIDE : SW_SHOW);=0A=
-  ShowWindow (ins_bl_disk, enable ? SW_HIDE : SW_SHOW);=0A=
-  ShowWindow (ins_iprogress, enable ? SW_HIDE : SW_SHOW);=0A=
-  ShowWindow (ins_diskfull, enable ? SW_HIDE : SW_SHOW);=0A=
-}=0A=
-=0A=
-void=0A=
-ThreeBarProgressPage::OnActivate ()=0A=
-{=0A=
-  // Disable back and next buttons=0A=
-  GetOwner ()->SetButtons (0);=0A=
-=0A=
-  // Set all bars to 0=0A=
-  SetBar1 (0);=0A=
-  SetBar2 (0);=0A=
-  SetBar3 (0);=0A=
-=0A=
-  switch (task)=0A=
-    {=0A=
-    case WM_APP_START_SITE_INFO_DOWNLOAD:=0A=
-    case WM_APP_START_SETUP_INI_DOWNLOAD:=0A=
-      // For these tasks, show only a single progress bar.=0A=
-      EnableSingleBar ();=0A=
-      break;=0A=
-    default:=0A=
-      // Show the normal 3-bar view by default=0A=
-      EnableSingleBar (false);=0A=
-      break;=0A=
-    }=0A=
-=0A=
-  Window::PostMessage (task);=0A=
-}=0A=
-=0A=
-bool=0A=
-ThreeBarProgressPage::OnMessageApp (UINT uMsg, WPARAM wParam, LPARAM lPara=
m)=0A=
-{=0A=
-  switch (uMsg)=0A=
-    {=0A=
-    case WM_APP_START_DOWNLOAD:=0A=
-      {=0A=
-	// Start the package download thread.=0A=
-	do_download (GetInstance (), GetHWND ());=0A=
-	break;=0A=
-      }=0A=
-    case WM_APP_DOWNLOAD_THREAD_COMPLETE:=0A=
-      {=0A=
-	if (lParam =3D=3D IDD_S_INSTALL)=0A=
-	  {=0A=
-	    // Download is complete and we want to go on to the install.=0A=
-	    Window::PostMessage (WM_APP_START_INSTALL);=0A=
-	  }=0A=
-	else if (lParam !=3D 0)=0A=
-	  {=0A=
-	    // Download failed for some reason, go back to site selection page=0A=
-	    GetOwner ()->SetActivePageByID (lParam);=0A=
-	  }=0A=
-	else=0A=
-	  {=0A=
-	    // Was a download-only, and is complete or failed.=0A=
-	    GetOwner ()->PressButton (PSBTN_CANCEL);=0A=
-	  }=0A=
-	break;=0A=
-      }=0A=
-    case WM_APP_START_INSTALL:=0A=
-      {=0A=
-	// Start the install thread.=0A=
-	do_install (GetInstance (), GetHWND ());=0A=
-	break;=0A=
-      }=0A=
-    case WM_APP_INSTALL_THREAD_COMPLETE:=0A=
-      {=0A=
-	// Re-enable and "Push" the Next button=0A=
-	GetOwner ()->SetButtons (PSWIZB_NEXT);=0A=
-	GetOwner ()->PressButton (PSBTN_NEXT);=0A=
-	break;=0A=
-      }=0A=
-    case WM_APP_START_SITE_INFO_DOWNLOAD:=0A=
-      {=0A=
-	do_download_site_info (GetInstance (), GetHWND ());=0A=
-	break;=0A=
-      }=0A=
-    case WM_APP_SITE_INFO_DOWNLOAD_COMPLETE:=0A=
-      {=0A=
-	GetOwner ()->SetActivePageByID (lParam);=0A=
-	break;=0A=
-      }=0A=
-    case WM_APP_START_SETUP_INI_DOWNLOAD:=0A=
-      {=0A=
-	do_ini (GetInstance (), GetHWND ());=0A=
-	break;=0A=
-      }=0A=
-    case WM_APP_SETUP_INI_DOWNLOAD_COMPLETE:=0A=
-      {=0A=
-	if (lParam =3D=3D IDD_S_FROM_CWD)=0A=
-	  {=0A=
-	    // There isn't actually a dialog template named this=0A=
-	    do_fromcwd (GetInstance (), GetHWND ());=0A=
-	  }=0A=
-	else=0A=
-	  {=0A=
-	    GetOwner ()->SetActivePageByID (lParam);=0A=
-	  }=0A=
-	break;=0A=
-      }=0A=
-    default:=0A=
-      {=0A=
-	// Not handled=0A=
-	return false;=0A=
-      }=0A=
-    }=0A=
-=0A=
-  return true;=0A=
-}=0A=
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
+	if (lParam =3D=3D IDD_S_FROM_CWD)=0A=
+	  {=0A=
+	    // There isn't actually a dialog template named this=0A=
+	    do_fromcwd (GetInstance (), GetHWND ());=0A=
+	  }=0A=
+	else=0A=
+	  {=0A=
+	    GetOwner ()->SetActivePageByID (lParam);=0A=
+	  }=0A=
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
RCS file: /cvs/src/src/winsup/cinstall/threebar.h,v=0A=
retrieving revision 2.1=0A=
diff -p -u -r2.1 threebar.h=0A=
--- threebar.h	2001/12/23 12:13:29	2.1=0A=
+++ threebar.h	2002/01/01 14:02:38=0A=
@@ -1,81 +1,81 @@=0A=
-#ifndef CINSTALL_THREEBAR_H=0A=
-#define CINSTALL_THREEBAR_H=0A=
-=0A=
-/*=0A=
- * Copyright (c) 2001, Gary R. Van Sickle.=0A=
- *=0A=
- *     This program is free software; you can redistribute it and/or modif=
y=0A=
- *     it under the terms of the GNU General Public License as published b=
y=0A=
- *     the Free Software Foundation; either version 2 of the License, or=
=0A=
- *     (at your option) any later version.=0A=
- *=0A=
- *     A copy of the GNU General Public License can be found at=0A=
- *     http://www.gnu.org/=0A=
- *=0A=
- * Written by Gary R. Van Sickle <g.r.vansickle@worldnet.att.net>=0A=
- *=0A=
- */=0A=
-=0A=
-// This is the header for the ThreeBarProgressPage class.  It is a fairly =
generic=0A=
-// progress indicator property page with three progress bars.=0A=
-=0A=
-=0A=
-#include "win32.h"=0A=
-#include "proppage.h"=0A=
-=0A=
-#define WM_APP_START_DOWNLOAD              WM_APP+0=0A=
-#define WM_APP_DOWNLOAD_THREAD_COMPLETE    WM_APP+1=0A=
-#define WM_APP_START_INSTALL               WM_APP+2=0A=
-#define WM_APP_INSTALL_THREAD_COMPLETE     WM_APP+3=0A=
-#define WM_APP_START_SITE_INFO_DOWNLOAD    WM_APP+4=0A=
-#define WM_APP_SITE_INFO_DOWNLOAD_COMPLETE WM_APP+5=0A=
-#define WM_APP_START_SETUP_INI_DOWNLOAD    WM_APP+6=0A=
-#define WM_APP_SETUP_INI_DOWNLOAD_COMPLETE WM_APP+7=0A=
-=0A=
-class ThreeBarProgressPage:public PropertyPage=0A=
-{=0A=
-  HWND ins_dialog;=0A=
-  HWND ins_action;=0A=
-  HWND ins_pkgname;=0A=
-  HWND ins_filename;=0A=
-  HWND ins_pprogress;=0A=
-  HWND ins_iprogress;=0A=
-  HWND ins_diskfull;=0A=
-  HWND ins_bl_package;=0A=
-  HWND ins_bl_total;=0A=
-  HWND ins_bl_disk;=0A=
-=0A=
-  int task;=0A=
-=0A=
-  void EnableSingleBar (bool enable =3D true);=0A=
-=0A=
-public:=0A=
-    ThreeBarProgressPage ()=0A=
-  {=0A=
-  };=0A=
-  virtual ~ ThreeBarProgressPage ()=0A=
-  {=0A=
-  };=0A=
-=0A=
-  bool Create ();=0A=
-=0A=
-  virtual void OnInit ();=0A=
-  virtual void OnActivate ();=0A=
-  virtual bool OnMessageApp (UINT uMsg, WPARAM wParam, LPARAM lParam);=0A=
-=0A=
-  void SetText1 (const TCHAR * t);=0A=
-  void SetText2 (const TCHAR * t);=0A=
-  void SetText3 (const TCHAR * t);=0A=
-=0A=
-  void SetBar1 (long progress, long max =3D 100);=0A=
-  void SetBar2 (long progress, long max =3D 100);=0A=
-  void SetBar3 (long progress, long max =3D 100);=0A=
-=0A=
-  void SetActivateTask (int t)=0A=
-  {=0A=
-    task =3D t;=0A=
-  };=0A=
-};=0A=
-=0A=
-=0A=
-#endif // CINSTALL_THREEBAR_H=0A=
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
RCS file: /cvs/src/src/winsup/cinstall/window.cc,v=0A=
retrieving revision 2.2=0A=
diff -p -u -r2.2 window.cc=0A=
--- window.cc	2002/01/01 12:32:37	2.2=0A=
+++ window.cc	2002/01/01 14:02:39=0A=
@@ -38,10 +38,19 @@ Window::Window ()=0A=
 {=0A=
   WindowHandle =3D NULL;=0A=
   Parent =3D NULL;=0A=
+  FontCounter =3D 0;=0A=
 }=0A=
=20=0A=
 Window::~Window ()=0A=
 {=0A=
+  // Delete any fonts we created.=0A=
+  int i;=0A=
+  for (i =3D 0; i < FontCounter; i++)=0A=
+    {=0A=
+      DeleteObject (Fonts[i]);=0A=
+    }=0A=
+  FontCounter =3D 0;=0A=
+=0A=
   // FIXME: Maybe do some reference counting and do this Unregister=0A=
   // when there are no more of us left.  Not real critical unless=0A=
   // we're in a DLL which we're not right now.=0A=
@@ -259,4 +268,50 @@ void=0A=
 Window::PostMessage (UINT uMsg, WPARAM wParam, LPARAM lParam)=0A=
 {=0A=
   ::PostMessage (GetHWND (), uMsg, wParam, lParam);=0A=
+}=0A=
+=0A=
+UINT Window::IsButtonChecked (int nIDButton) const=0A=
+{=0A=
+  return::IsDlgButtonChecked (GetHWND (), nIDButton);=0A=
+}=0A=
+=0A=
+bool=0A=
+  Window::SetDlgItemFont (int id, const TCHAR * fontname, int Pointsize,=
=0A=
+			  int Weight, bool Italic, bool Underline,=0A=
+			  bool Strikeout)=0A=
+{=0A=
+  HWND ctrl;=0A=
+  ctrl =3D GetDlgItem (id);=0A=
+  if (ctrl =3D=3D NULL)=0A=
+    {=0A=
+      // Couldn't get that ID=0A=
+      return false;=0A=
+    }=0A=
+=0A=
+  // We need the DC for the point size calculation.=0A=
+  HDC hdc =3D GetDC (ctrl);=0A=
+=0A=
+  // Create the font.  We have to keep it around until the dialog item=0A=
+  // goes away - basically until we're destroyed.=0A=
+  HFONT hfnt;=0A=
+  hfnt =3D=0A=
+    CreateFont (-MulDiv (Pointsize, GetDeviceCaps (hdc, LOGPIXELSY), 72), =
0,=0A=
+		0, 0, Weight, Italic ? TRUE : FALSE,=0A=
+		Underline ? TRUE : FALSE, Strikeout ? TRUE : FALSE,=0A=
+		ANSI_CHARSET, OUT_TT_PRECIS, CLIP_DEFAULT_PRECIS,=0A=
+		PROOF_QUALITY, DEFAULT_PITCH | FF_DONTCARE, fontname);=0A=
+  if (hfnt =3D=3D NULL)=0A=
+    {=0A=
+      // Font creation failed=0A=
+      return false;=0A=
+    }=0A=
+=0A=
+  // Set the new fint, and redraw any text which was already in the item.=
=0A=
+  SendMessage (ctrl, WM_SETFONT, (WPARAM) hfnt, TRUE);=0A=
+=0A=
+  // Save it for later.=0A=
+  Fonts[FontCounter] =3D hfnt;=0A=
+  FontCounter++;=0A=
+=0A=
+  return true;=0A=
 }=0A=
Index: window.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/window.h,v=0A=
retrieving revision 2.2=0A=
diff -p -u -r2.2 window.h=0A=
--- window.h	2002/01/01 12:32:37	2.2=0A=
+++ window.h	2002/01/01 14:02:39=0A=
@@ -39,6 +39,11 @@ class Window=0A=
=20=0A=
   Window *Parent;=0A=
=20=0A=
+  // FIXME: replace with <vector> when we get a chance.=0A=
+  static const int MAXFONTS =3D 5;=0A=
+  HFONT Fonts[MAXFONTS];=0A=
+  int FontCounter;=0A=
+=0A=
 protected:=0A=
   void SetHWND (HWND h)=0A=
   {=0A=
@@ -79,11 +84,21 @@ public:=0A=
   {=0A=
     return::GetDlgItem (GetHWND (), id);=0A=
   };=0A=
+  bool SetDlgItemFont(int id, const TCHAR *fontname, int Pointsize,=0A=
+	  int Weight =3D FW_NORMAL, bool Italic =3D false, bool Underline =3D fal=
se, bool Strikeout =3D false);=0A=
+=0A=
+  UINT IsButtonChecked (int nIDButton) const;=0A=
=20=0A=
   void PostMessage (UINT uMsg, WPARAM wParam =3D 0, LPARAM lParam =3D 0);=
=0A=
=20=0A=
   virtual bool OnMessageApp (UINT uMsg, WPARAM wParam, LPARAM lParam)=0A=
   {=0A=
+    return false;=0A=
+  };=0A=
+=0A=
+  virtual bool OnMessageCmd (int id, HWND hwndctl, UINT code)=0A=
+  {=0A=
+    // Not processed.=0A=
     return false;=0A=
   };=0A=
=20=0A=

------=_NextPart_000_0000_01C1929D.4500DDD0
Content-Type: application/octet-stream;
	name="ChangeLog.setup.grvs"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="ChangeLog.setup.grvs"
Content-length: 4565

2001-12-30  Gary R. Van Sickle  <g.r.vansickle@worldnet.att.net>=0A=
=0A=
	* res.rc: Resize and rearrange property page dialog templates=0A=
	to bring them in line with "Microsoft's Backward Compatible Wizard 97"=0A=
	specification.=0A=
	(IDD_SITE): Add an edit control and an "Add" button in order to=0A=
	combine the IDD_SITE and IDD_OTHER_URL functionality onto one page.=0A=
	(IDD_OTHER_URL): Remove dialog template.=0A=
	(IDD_DLSTATUS): Remove dialog template.=0A=
=0A=
	* propsheet.cc (PropSheetProc): New function.  Add minimize box=0A=
	here instead of in PropertyPage::DialogProc.=0A=
=0A=
	* propsheet.h: Run indent.=0A=
	* proppage.h: Run indent.=0A=
=0A=
	* proppage.cc (PropertyPage::DialogProc): Remove minimize-box-adding=0A=
	functionality.  Remove commented-out "PropSheet_SetWizButtons" calls.=0A=
	Add support for calling virtual OnMessageCmd.  Add setting of fonts in=0A=
	WM_INITDIALOG handler.=0A=
	(resource.h): New include for resource IDs.=0A=
=0A=
	* site.cc (SitePage::OnBack): Remove NEXT() macro invocation.=0A=
	(SitePage::OnActivate): New member function.=0A=
	(load_dialog): Remove.  Functionality subsumed into=0A=
	SitePage::OnActivate.=0A=
	(save_dialog): Change to support both list and user URLs.  Remove=0A=
	OTHER_IDX and mirror_idx logic.=0A=
	(SitePage::PopulateListBox): New member function.=0A=
	(SitePage::CheckControlsAndDisableAccordingly): New member function.=0A=
	(SitePage::OnMessageCmd): New override.=0A=
	(check_if_enable_next): Remove.=0A=
	(dialog_cmd): Remove.=0A=
	(do_download_site_info_thread): Remove calls to NEXT() macro.=0A=
	(SitePage::Create): Call the single-param PropertyPage::Create=0A=
	overload.=0A=
	(other_url): New static taken from other.cc.=0A=
	(SitePage::OnNext): Remove mirror_idx logic.=0A=
	(SitePage::OnInit): Remove "Other URL" entry from list box.  Remove=0A=
	list box populating code, now handled in SitePage::PopulateListBox.=0A=
	(mirror_idx, NO_IDX, OTHER_IDX): Remove.=0A=
	(save_site_url): Fix potential buffer overflow problem.  Switched to=0A=
	TCHAR in grossly premature preparation for multilingual support.=0A=
	* site.h (SitePage::OnActivate): New member function.=0A=
	(SitePage::CheckControlsAndDisableAccordingly) New member.=0A=
	(SitePage::OnMessageCmd): New override.=0A=
	(do_download_site_info_thread): Add MessageBox call on failure to=0A=
	download site list.=0A=
=0A=
	* splash.cc (SplashPage::OnInit): Set the font for the title.=0A=
=0A=
	* window.h (Window::IsButtonChecked): New member function declaration.=0A=
	(Window::OnMessageCmd): New member function.=0A=
	(Window::SetDlgItemFont): New member function declaration.=0A=
	(Window::MAXFONTS, Window::Fonts, Window::FontCounter): New data=0A=
	members.=0A=
	* window.cc (Window::IsButtonChecked): New member function definition.=0A=
	(Window::SetDlgItemFont): New member function definition.=0A=
	(Window::Window): Add initialization for FontCounter.=0A=
	(Window::~Window): Delete any fonts we created.=0A=
=0A=
	* desktop.cc (etc_profile): Remove "test -f ./.bashrc && . ./.bashrc"=0A=
	from the generated /etc/profile.  Bash will source this file=0A=
	automatically, and having this here merely results in .bashrc being=0A=
	executed twice.=0A=
=0A=
	* geturl.cc (progress): Remove the "3" field width from the "%3d"=0A=
	percent-complete format indicator.  Causes line to not start at=0A=
	beginning of text box, and does little to help with "jumping", since=0A=
	the "bytes downloaded so far" field is variable-width anyway.  Change=0A=
	kb/s format field to "%03.1" to 0-pad the kb/s number in the event of=0A=
	painfully slow connections, or temporary slowdowns in faster=0A=
	connections should such more-instantaneous functionality become=0A=
	available.=0A=
=0A=
	* net.h (NetPage::OnMessageCmd): New member function declaration.=0A=
	(NetPage::CheckIfEnableNext): New member function declaration.=0A=
	* net.cc (NetPage::OnMessageCmd): New member function definition.=0A=
	(dialog_cmd): Remove, subsumed into NetPage::OnMessageCmd.=0A=
	(check_if_enable_next): Remove.=0A=
	(NetPage::CheckIfEnableNext): New member function, subsumes=0A=
	check_if_enable_next.=0A=
	(propsheet.h): Add include.=0A=
	(NetPage::Init): Add call to CheckIfEnableNext.=0A=
	(load_dialog): Remove call to check_if_enable_next.=0A=
	(NetPage::Create): Call single-template-ID-parameter overload of=0A=
	PropertyPage::Create instead of three-parameter one.=0A=
=0A=
	* Makefile.in (OBJS): Remove other.o.=0A=
	* other.cc: Remove file.=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=

------=_NextPart_000_0000_01C1929D.4500DDD0--
