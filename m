Return-Path: <cygwin-patches-return-4839-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26379 invoked by alias); 17 Jun 2004 02:58:29 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 26370 invoked from network); 17 Jun 2004 02:58:27 -0000
Message-Id: <3.0.5.32.20040616225506.00810660@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Thu, 17 Jun 2004 02:58:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Re: [Patch]: Unicode length
In-Reply-To: <20040616123744.GA25094@cygbert.vinschen.de>
References: <3.0.5.32.20040616072824.00812cf0@incoming.verizon.net>
 <3.0.5.32.20040616003625.0081c940@incoming.verizon.net>
 <3.0.5.32.20040616003625.0081c940@incoming.verizon.net>
 <3.0.5.32.20040616072824.00812cf0@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1087455306==_"
X-SW-Source: 2004-q2/txt/msg00191.txt.bz2

--=====================_1087455306==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 856

This is a full implementation of what I started yesterday, with
more robust protection against string buffer overflows.

I also reorganized the debug_printf in fhandler_base::openX

Pierre

2004-06-17  Pierre Humblet <pierre.humblet@ieee.org>

	* fhandler.cc (fhandler_base::open_9x): Do not check for null name.
	Move debug_printf to common code line.
	(fhandler_base::open): Ditto. Initialize upath. Remove second argument
 	of pc.get_nt_native_path.
	* path.h (path_conv::get_nt_native_path): Remove second argument.
	* path.cc (path_conv::get_nt_native_path): Ditto. Call str2uni_cat.
	* security.h (str2buf2uni_cat): Delete declaration.
	(str2uni_cat): New declaration.
	* security.cc (str2buf2uni): Get length from sys_mbstowcs call.
	(str2buf2uni_cat): Delete function.
	(str2uni_cat): New function.
	* miscfuncs.cc (sys_mbstowcs): Add debug_printf.
--=====================_1087455306==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="unicode.diff"
Content-length: 8657

Index: fhandler.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/fhandler.cc,v
retrieving revision 1.198
diff -u -p -r1.198 fhandler.cc
--- fhandler.cc	3 Jun 2004 22:27:25 -0000	1.198
+++ fhandler.cc	17 Jun 2004 00:12:01 -0000
@@ -437,12 +437,6 @@ fhandler_base::open_9x (int flags, mode_

   syscall_printf ("(%s, %p)", get_win32_name (), flags);

-  if (get_win32_name () =3D=3D NULL)
-    {
-      set_errno (ENOENT);
-      goto done;
-    }
-
   if ((flags & (O_RDONLY | O_WRONLY | O_RDWR)) =3D=3D O_RDONLY)
     access =3D GENERIC_READ;
   else if ((flags & (O_RDONLY | O_WRONLY | O_RDWR)) =3D=3D O_WRONLY)
@@ -512,16 +506,16 @@ fhandler_base::open_9x (int flags, mode_
 	goto done;
    }

-  syscall_printf ("%p =3D CreateFile (%s, %p, %p, %p, %p, %p, 0)",
-		  x, get_win32_name (), access, shared, &sa,
-		  creation_distribution, file_attributes);
-
   set_io_handle (x);
   set_flags (flags, pc.binmode ());

   res =3D 1;
   set_open_status ();
 done:
+  debug_printf ("%p =3D CreateFile (%s, %p, %p, %p, %p, %p, 0)",
+		x, get_win32_name (), access, shared, &sa,
+		creation_distribution, file_attributes);
+
   syscall_printf ("%d =3D fhandler_base::open (%s, %p)", res, get_win32_na=
me (),
 		  flags);
   return res;
@@ -534,11 +528,11 @@ fhandler_base::open (int flags, mode_t m
   if (!wincap.is_winnt ())
     return fhandler_base::open_9x (flags, mode);

-  UNICODE_STRING upath;
   WCHAR wpath[CYG_MAX_PATH + 10];
-  pc.get_nt_native_path (upath, wpath);
+  UNICODE_STRING upath =3D {0, sizeof (wpath), wpath};
+  pc.get_nt_native_path (upath);

-  if (RtlIsDosDeviceName_U (wpath))
+  if (RtlIsDosDeviceName_U (upath.Buffer))
     return fhandler_base::open_9x (flags, mode);

   int res =3D 0;
@@ -554,11 +548,6 @@ fhandler_base::open (int flags, mode_t m
   NTSTATUS status;

   syscall_printf ("(%s, %p)", get_win32_name (), flags);
-  if (get_win32_name () =3D=3D NULL)
-    {
-      set_errno (ENOENT);
-      goto done;
-    }

   InitializeObjectAttributes (&attr, &upath, OBJ_CASE_INSENSITIVE | OBJ_IN=
HERIT,
 			      sa.lpSecurityDescriptor, NULL);
@@ -657,17 +646,17 @@ fhandler_base::open (int flags, mode_t m
 	goto done;
    }

-  syscall_printf ("%x =3D NtCreateFile "
-		  "(%p, %x, %s, io, NULL, %x, %x, %x, %x, NULL, 0)",
-		  status, x, access, get_win32_name (), file_attributes, shared,
-		  create_disposition, create_options);
-
   set_io_handle (x);
   set_flags (flags, pc.binmode ());

   res =3D 1;
   set_open_status ();
 done:
+  debug_printf ("%x =3D NtCreateFile "
+		"(%p, %x, %s, io, NULL, %x, %x, %x, %x, NULL, 0)",
+		status, x, access, get_win32_name (), file_attributes, shared,
+		create_disposition, create_options);
+
   syscall_printf ("%d =3D fhandler_base::open (%s, %p)", res, get_win32_na=
me (),
 		  flags);
   return res;
Index: path.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/path.h,v
retrieving revision 1.65
diff -u -p -r1.65 path.h
--- path.h	11 May 2004 15:39:50 -0000	1.65
+++ path.h	17 Jun 2004 00:12:02 -0000
@@ -192,7 +192,7 @@ class path_conv

   ~path_conv ();
   inline char *get_win32 () { return path; }
-  PUNICODE_STRING get_nt_native_path (UNICODE_STRING &upath, WCHAR *wpath);
+  PUNICODE_STRING get_nt_native_path (UNICODE_STRING &upath);
   operator char *() {return path;}
   operator const char *() {return path;}
   operator DWORD &() {return fileattr;}
Index: path.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/path.cc,v
retrieving revision 1.316
diff -u -p -r1.316 path.cc
--- path.cc	8 Jun 2004 07:20:04 -0000	1.316
+++ path.cc	17 Jun 2004 00:12:08 -0000
@@ -459,25 +459,25 @@ path_conv::set_normalized_path (const ch
 }

 PUNICODE_STRING
-path_conv::get_nt_native_path (UNICODE_STRING &upath, WCHAR *wpath)
+path_conv::get_nt_native_path (UNICODE_STRING &upath)
 {
   if (path[0] !=3D '\\')			/* X:\...  or NUL, etc. */
     {
-      str2buf2uni (upath, wpath, "\\??\\");
-      str2buf2uni_cat (upath, path);
+      str2uni_cat (upath, "\\??\\");
+      str2uni_cat (upath, path);
     }
   else if (path[1] !=3D '\\')		/* \Device\... */
-    str2buf2uni (upath, wpath, path);
+    str2uni_cat (upath, path);
   else if (path[2] !=3D '.'
 	   || path[3] !=3D '\\')		/* \\server\share\... */
     {
-      str2buf2uni (upath, wpath, "\\??\\UNC\\");
-      str2buf2uni_cat (upath, path + 2);
+      str2uni_cat (upath, "\\??\\UNC\\");
+      str2uni_cat (upath, path + 2);
     }
   else					/* \\.\device */
     {
-      str2buf2uni (upath, wpath, "\\??\\");
-      str2buf2uni_cat (upath, path + 4);
+      str2uni_cat (upath, "\\??\\");
+      str2uni_cat (upath, path + 4);
     }
   return &upath;
 }
Index: security.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/security.h,v
retrieving revision 1.57
diff -u -p -r1.57 security.h
--- security.h	16 Apr 2004 21:22:13 -0000	1.57
+++ security.h	17 Jun 2004 00:12:09 -0000
@@ -276,7 +276,7 @@ int setacl (HANDLE, const char *, int, _

 struct _UNICODE_STRING;
 void __stdcall str2buf2uni (_UNICODE_STRING &, WCHAR *, const char *) __at=
tribute__ ((regparm (3)));
-void __stdcall str2buf2uni_cat (_UNICODE_STRING &, const char *) __attribu=
te__ ((regparm (2)));
+void __stdcall str2uni_cat (_UNICODE_STRING &, const char *) __attribute__=
 ((regparm (2)));

 /* Try a subauthentication. */
 HANDLE subauth (struct passwd *pw);
Index: security.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/security.cc,v
retrieving revision 1.172
diff -u -p -r1.172 security.cc
--- security.cc	28 May 2004 19:50:06 -0000	1.172
+++ security.cc	17 Jun 2004 00:12:12 -0000
@@ -156,23 +156,28 @@ str2buf2lsa (LSA_STRING &tgt, char *buf,
   memcpy (buf, srcstr, tgt.MaximumLength);
 }

+/* The dimension of buf is assumed to be at least strlen(srcstr) + 1,
+   The result will be shorter if the input has multibyte chars */
 void
 str2buf2uni (UNICODE_STRING &tgt, WCHAR *buf, const char *srcstr)
 {
-  tgt.Length =3D strlen (srcstr) * sizeof (WCHAR);
-  tgt.MaximumLength =3D tgt.Length + sizeof (WCHAR);
   tgt.Buffer =3D (PWCHAR) buf;
-  sys_mbstowcs (buf, srcstr, tgt.MaximumLength);
+  tgt.MaximumLength =3D (strlen (srcstr) + 1) * sizeof (WCHAR);
+  tgt.Length =3D sys_mbstowcs (buf, srcstr, tgt.MaximumLength / sizeof (WC=
HAR))
+               * sizeof (WCHAR);
+  if (tgt.Length)
+    tgt.Length -=3D sizeof (WCHAR);
 }

 void
-str2buf2uni_cat (UNICODE_STRING &tgt, const char *srcstr)
+str2uni_cat (UNICODE_STRING &tgt, const char *srcstr)
 {
-  DWORD len =3D strlen (srcstr) * sizeof (WCHAR);
-  sys_mbstowcs (tgt.Buffer + tgt.Length / sizeof (WCHAR), srcstr,
-		len + tgt.MaximumLength);
-  tgt.Length +=3D len;
-  tgt.MaximumLength +=3D len;
+  int len =3D sys_mbstowcs (tgt.Buffer + tgt.Length / sizeof (WCHAR), srcs=
tr,
+		          (tgt.MaximumLength - tgt.Length) / sizeof (WCHAR));
+  if (len)
+    tgt.Length +=3D (len - 1) * sizeof (WCHAR);
+  else
+    tgt.Length =3D tgt.MaximumLength =3D 0;
 }

 #if 0				/* unused */
Index: miscfuncs.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/miscfuncs.cc,v
retrieving revision 1.30
diff -u -p -r1.30 miscfuncs.cc
--- miscfuncs.cc	26 Feb 2004 11:32:20 -0000	1.30
+++ miscfuncs.cc	17 Jun 2004 00:12:13 -0000
@@ -312,7 +312,10 @@ sys_wcstombs (char *tgt, const WCHAR *sr
 int __stdcall
 sys_mbstowcs (WCHAR *tgt, const char *src, int len)
 {
-  return MultiByteToWideChar (get_cp (), 0, src, -1, tgt, len);
+  int res =3D MultiByteToWideChar (get_cp (), 0, src, -1, tgt, len);
+  if (!res)
+    debug_printf ("MultiByteToWideChar %E");
+  return res;
 }

 extern "C" int

--=====================_1087455306==_--
