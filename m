Return-Path: <cygwin-patches-return-4415-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24763 invoked by alias); 17 Nov 2003 22:10:14 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24750 invoked from network); 17 Nov 2003 22:10:12 -0000
Message-ID: <71A0F7B0F1F4F94F85F3D64C4BD0CCFE03C214E7@bmkc1svmail01.am.mfg>
From: "Parker, Ron" <rdparker@butlermfg.com>
To: Robert Collins <rbcollins@cygwin.com>
Cc: Arch Users <gnu-arch-users@gnu.org>, cygwin-patches@cygwin.com
Subject: Additional Cygwin long file path patch
Date: Mon, 17 Nov 2003 22:10:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C3AD57.59770C40"
X-SW-Source: 2003-q4/txt/msg00134.txt.bz2

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C3AD57.59770C40
Content-Type: text/plain;
	charset="iso-8859-1"
Content-length: 1204

> From: Robert Collins [mailto:rbcollins@cygwin.com]

> 0) Fill out the last couple of thunks. FindFirstFile and FindNextFile 
> need to be always Ansi or always Wide, and if following that 
> principle 
> there, it probably makes sense to always use one or the other, not 
> decide on a per-call basis.

I had implemented this already, but not sent a patch for it.  I thought it
was bugged, but it turned out that I was running into the gcc alloca issue
when I increased PATH_MAX to 4096 on my machine.  It has been adapted to the
CVS code in line with your changes.  

Here is a patch against cygio.h.  I know you hate side-effects, but it
removes the extraneous trailing ';' from the switch statements and switches
to my home email address as well.  I'll break it apart if necessary.

The good thing here is that FindFirstFileW may be freely mixed with
FindNextFileA.  So, we do not have to remember which form was used for
FindFirstFile when calling FindNextFile.  This reduces the whole
decide-which-API-to-call-and-perform-UNICODE-translation to once per
FindFirstFile/FindNextFile loop.

Running a 'tla import' this will get us further.  It now experiences a
permissions failure at vu_sys_chmod.


------_=_NextPart_000_01C3AD57.59770C40
Content-Type: application/octet-stream;
	name="rbc01-find-first-file"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="rbc01-find-first-file"
Content-length: 2529

--- ../../../../cygio.h	2003-11-17 13:51:10.378169600 -0600=0A=
+++ cygio.h	2003-11-17 15:59:37.931086400 -0600=0A=
@@ -1,7 +1,7 @@=0A=
 /* cygio.h=0A=
=20=0A=
    Copyright 2003 Robert Collins  <rbtcollins@hotmail.com>=0A=
-   Copyright 2003 Ron Parker      <rdparker@butlermfg.com>=0A=
+   Copyright 2003 Ron Parker      <rparker1@kc.rr.com>=0A=
=20=0A=
 This file is part of Cygwin.=0A=
=20=0A=
@@ -145,7 +145,7 @@=0A=
       trace_file_wcs(state);=0A=
       return CreateFileW (state.getWide(), access, share_mode, sec_attr, d=
isposition,=0A=
                       flags, template_file);=0A=
-  };=0A=
+  }=0A=
 }=0A=
=20=0A=
 inline BOOL=0A=
@@ -160,7 +160,7 @@=0A=
       return CreateDirectoryA (filename, sec_attr);=0A=
     case IOThunkState::WIDE:=0A=
       return CreateDirectoryW (state.getWide(), sec_attr);=0A=
-  };=0A=
+  }=0A=
 }=0A=
=20=0A=
 inline BOOL=0A=
@@ -189,7 +189,34 @@=0A=
 find_first_file (LPCSTR filename, LPWIN32_FIND_DATA data)=0A=
 {=0A=
   /* INVALID_HANDLE_VALUE is failure */=0A=
-  return FindFirstFile (filename, data);=0A=
+  HANDLE handle =3D INVALID_HANDLE_VALUE;=0A=
+  IOThunkState state(filename);=0A=
+  switch (state.condition)=20=0A=
+  {=0A=
+    case IOThunkState::ANSI:=0A=
+      handle =3D FindFirstFileA (filename, data);=0A=
+      break;=0A=
+    case IOThunkState::WIDE:=20=0A=
+      {=0A=
+	WIN32_FIND_DATAW wdata;=0A=
+	trace_file_wcs(state);=0A=
+	handle =3D FindFirstFileW (state.getWide(), &wdata);=0A=
+	if (handle !=3D INVALID_HANDLE_VALUE)=0A=
+		{=0A=
+		  /* Copy the start of the UNICODE find data into find_data.=0A=
+		   * Then convert the UNICODE strings to multibyte strings.=0A=
+		   */=0A=
+		  memcpy (find_data, &wfind_data, offsetof (WIN32_FIND_DATA,=0A=
+			  cFileName));=0A=
+		  sys_wcstombs (find_data->cFileName, wfind_data->cFileName,=0A=
+				sizeof(find_data->cFileName));=0A=
+		  sys_wcstombs (find_data->cAlternateFileName,=0A=
+			  	wfind_data->cAlternateFileName,=0A=
+				sizeof(find_data->cAlternateFileName));=0A=
+		}=0A=
+      }=0A=
+  }=0A=
+  return handle;=0A=
 }=0A=
=20=0A=
=20=0A=
@@ -212,7 +239,7 @@=0A=
       return GetFileAttributesA (filename);=0A=
     case IOThunkState::WIDE:=0A=
       return GetFileAttributesW (state.getWide());=0A=
-  };=0A=
+  }=0A=
 }=0A=
=20=0A=
 inline BOOL=0A=
@@ -227,7 +254,7 @@=0A=
       return SetFileAttributesA(filename, attr);=0A=
     case IOThunkState::WIDE:=0A=
       return SetFileAttributesW(state.getWide(), attr);=0A=
-  };=0A=
+  }=0A=
 }=0A=
=20=0A=
 inline BOOL=0A=

------_=_NextPart_000_01C3AD57.59770C40--
