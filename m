Return-Path: <cygwin-patches-return-2198-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 28570 invoked by alias); 21 May 2002 07:03:17 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 28514 invoked from network); 21 May 2002 07:03:13 -0000
Message-ID: <1264BCF4F426D611B0B00050DA782A50014C228E@mail.gft.com>
From: =?iso-8859-1?Q?=22Schaible=2C_J=F6rg=22?= <Joerg.Schaible@gft.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] cygpath.cc
Date: Tue, 21 May 2002 00:03:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C20095.67758F80"
X-SW-Source: 2002-q2/txt/msg00182.txt.bz2

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C20095.67758F80
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-length: 993

Hi,

as already announced here is the next patch for cygpath.cc supporting -l
option to convert file names to Windows long format. Unfortunately this
works not for strict mode, since functions cygwin_conv_to_win32_path and
cygwin_conv_to_full_win32_path will return an error for a Windows short
path/name.

2002-05-20  Joerg Schaible <joerg.schaible@gmx.de>

	* cygpath.cc (main): Add option l to support conversion to
	Windows long file names.  Refactured code for capital options.
	Support of options from file for capital options.
	(dowin): New function.  Refactured from main.
	(doit): Call long path conversion.
	(get_long_name): New function.
	(get_long_paths): New function.
	(get_long_path_name_w32impl): New function.  Reimplementation
	of Windows API function GetLongPathName (only 98/Me/2000/XP or=20
	higher).
	(get_short_name): Call GetShortPathName only once.
	(get_short_paths): Fix calculating buffer size.
	* utils.sgml: Update cygpath section for l option.

Regards,
J=F6rg


------_=_NextPart_000_01C20095.67758F80
Content-Type: application/octet-stream;
	name="cygpath.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="cygpath.diff"
Content-length: 14627

Index: cygpath.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/utils/cygpath.cc,v=0A=
retrieving revision 1.17=0A=
diff -u -p -r1.17 cygpath.cc=0A=
--- cygpath.cc	15 May 2002 11:36:00 -0000	1.17=0A=
+++ cygpath.cc	20 May 2002 19:25:05 -0000=0A=
@@ -27,7 +27,8 @@ static char *prog_name;=0A=
 static char *file_arg;=0A=
 static char *close_arg;=0A=
 static int path_flag, unix_flag, windows_flag, absolute_flag;=0A=
-static int shortname_flag, ignore_flag, allusers_flag, output_flag;=0A=
+static int shortname_flag, longname_flag;=0A=
+static int ignore_flag, allusers_flag, output_flag;=0A=
=20=0A=
 static struct option long_options[] =3D {=0A=
   {(char *) "help", no_argument, NULL, 'h'},=0A=
@@ -40,6 +41,7 @@ static struct option long_options[] =3D {=0A=
   {(char *) "version", no_argument, NULL, 'v'},=0A=
   {(char *) "windows", no_argument, NULL, 'w'},=0A=
   {(char *) "short-name", no_argument, NULL, 's'},=0A=
+  {(char *) "long-name", no_argument, NULL, 'l'},=0A=
   {(char *) "windir", no_argument, NULL, 'W'},=0A=
   {(char *) "sysdir", no_argument, NULL, 'S'},=0A=
   {(char *) "ignore", no_argument, NULL, 'i'},=0A=
@@ -60,6 +62,7 @@ Usage: %s [-p|--path] (-u|--unix)|(-w|--=0A=
   -c|--close handle	close handle (for use in captured process)\n\=0A=
   -f|--file file	read file for input path information\n\=0A=
   -i|--ignore		ignore missing argument\n\=0A=
+  -l|--long-name	print Windows long form of filename\n\=0A=
   -p|--path		filename argument is a path\n\=0A=
   -s|--short-name	print Windows short form of filename\n\=0A=
   -u|--unix		print Unix form of filename\n\=0A=
@@ -123,6 +126,7 @@ get_short_paths (char *path)=0A=
 	break;=0A=
       *sptr =3D ';';=0A=
       ++ptr, ++sptr;=0A=
+      acc -=3D len + 1;=0A=
     }=0A=
   return sbuf;=0A=
 }=0A=
@@ -130,8 +134,8 @@ get_short_paths (char *path)=0A=
 static char *=0A=
 get_short_name (const char *filename)=0A=
 {=0A=
-  char *sbuf;=0A=
-  DWORD len =3D GetShortPathName (filename, NULL, 0);=0A=
+  char *sbuf, buf[MAX_PATH];=0A=
+  DWORD len =3D GetShortPathName (filename, buf, MAX_PATH);=0A=
   if (len =3D=3D 0 && GetLastError () =3D=3D ERROR_INVALID_PARAMETER)=0A=
     {=0A=
       fprintf (stderr, "%s: cannot create short name of %s\n", prog_name,=
=0A=
@@ -144,14 +148,225 @@ get_short_name (const char *filename)=0A=
       fprintf (stderr, "%s: out of memory\n", prog_name);=0A=
       exit (1);=0A=
     }=0A=
-  len =3D GetShortPathName (filename, sbuf, len);=0A=
+  return strcpy (sbuf, buf);=0A=
+}=0A=
+=0A=
+static DWORD=0A=
+get_long_path_name_w32impl (LPCSTR src, LPSTR sbuf, DWORD)=0A=
+{=0A=
+  char buf1[MAX_PATH], buf2[MAX_PATH], *ptr;=0A=
+  const char *pelem, *next;=0A=
+  WIN32_FIND_DATA w32_fd;=0A=
+  int len;=0A=
+=20=20=0A=
+  strcpy (buf1, src);=0A=
+  *buf2 =3D 0;=0A=
+  pelem =3D src;=0A=
+  ptr =3D buf2;=0A=
+  while (pelem)=0A=
+    {=0A=
+      next =3D pelem;=0A=
+      if (*next =3D=3D '\\')=0A=
+	{=0A=
+	  strcat (ptr++, "\\");=0A=
+	  pelem++;=0A=
+	  if (!*pelem)=0A=
+	    break;=0A=
+	  continue;=0A=
+	}=0A=
+      pelem =3D strchr (next, '\\');=0A=
+      len =3D pelem ? (pelem++ - next) : strlen (next);=0A=
+      strncpy (ptr, next, len);=0A=
+      ptr[len] =3D 0;=0A=
+      if (next[1] !=3D ':' && strcmp(next, ".") && strcmp(next, ".."))=0A=
+	{=0A=
+	  if (FindFirstFile (buf2, &w32_fd) !=3D INVALID_HANDLE_VALUE)=0A=
+	    strcpy (ptr, w32_fd.cFileName);=0A=
+	}=0A=
+      ptr +=3D strlen (ptr);=0A=
+      if (pelem)=0A=
+	{=0A=
+	  *ptr++ =3D '\\';=0A=
+	  *ptr =3D 0;=0A=
+	}=0A=
+    }=0A=
+  if (sbuf)=0A=
+    strcpy (sbuf, buf2);=0A=
+  SetLastError (0);=0A=
+  return strlen (buf2) + (sbuf ? 0 : 1);=0A=
+}=0A=
+=0A=
+static char *=0A=
+get_long_paths (char *path)=0A=
+{=0A=
+  char *sbuf;=0A=
+  char *sptr;=0A=
+  char *next;=0A=
+  char *ptr =3D path;=0A=
+  char *end =3D strrchr (path, 0);=0A=
+  DWORD acc =3D 0;=0A=
+  DWORD len;=0A=
+=0A=
+  HINSTANCE hinst;=0A=
+  DWORD (*GetLongPathNameAPtr) (LPCSTR, LPSTR, DWORD) =3D 0;=0A=
+  hinst =3D LoadLibrary ("kernel32");=0A=
+  if (hinst)=0A=
+    GetLongPathNameAPtr =3D (DWORD (*) (LPCSTR, LPSTR, DWORD))=0A=
+      GetProcAddress (hinst, "GetLongPathNameA");=0A=
+  /* subsequent calls of kernel function with NULL cause SegFault in W2K!!=
 */=0A=
+  if (1 || !GetLongPathNameAPtr)=0A=
+    GetLongPathNameAPtr =3D get_long_path_name_w32impl;=0A=
+=0A=
+  while (ptr !=3D NULL)=0A=
+    {=0A=
+      next =3D ptr;=0A=
+      ptr =3D strchr (ptr, ';');=0A=
+      if (ptr)=0A=
+	*ptr++ =3D 0;=0A=
+      len =3D (*GetLongPathNameAPtr) (next, NULL, 0);=0A=
+      if (len =3D=3D 0 && GetLastError () =3D=3D ERROR_INVALID_PARAMETER)=
=0A=
+	{=0A=
+	  fprintf (stderr, "%s: cannot create long name of %s\n", prog_name,=0A=
+		   next);=0A=
+	  exit (2);=0A=
+	}=0A=
+      acc +=3D len + 1;=0A=
+    }=0A=
+  sptr =3D sbuf =3D (char *) malloc (acc + 1);=0A=
+  if (sbuf =3D=3D NULL)=0A=
+    {=0A=
+      fprintf (stderr, "%s: out of memory\n", prog_name);=0A=
+      exit (1);=0A=
+    }=0A=
+  ptr =3D path;=0A=
+  for (;;)=0A=
+    {=0A=
+      len =3D (*GetLongPathNameAPtr) (ptr, sptr, acc);=0A=
+      if (len =3D=3D 0 && GetLastError () =3D=3D ERROR_INVALID_PARAMETER)=
=0A=
+	{=0A=
+	  fprintf (stderr, "%s: cannot create long name of %s\n", prog_name,=0A=
+		   ptr);=0A=
+	  exit (2);=0A=
+	}=0A=
+=0A=
+      ptr =3D strrchr (ptr, 0);=0A=
+      sptr =3D strrchr (sptr, 0);=0A=
+      if (ptr =3D=3D end)=0A=
+	break;=0A=
+      *ptr =3D *sptr =3D ';';=0A=
+      ++ptr, ++sptr;=0A=
+      acc -=3D len + 1;=0A=
+    }=0A=
+  return sbuf;=0A=
+}=0A=
+=0A=
+static char *=0A=
+get_long_name (const char *filename)=0A=
+{=0A=
+  char *sbuf, buf[MAX_PATH];=0A=
+  DWORD len;=0A=
+  HINSTANCE hinst;=0A=
+  DWORD (*GetLongPathNameAPtr) (LPCSTR, LPSTR, DWORD) =3D 0;=0A=
+  hinst =3D LoadLibrary ("kernel32");=0A=
+  if (hinst)=0A=
+    GetLongPathNameAPtr =3D (DWORD (*) (LPCSTR, LPSTR, DWORD))=0A=
+      GetProcAddress (hinst, "GetLongPathNameA");=0A=
+  if (!GetLongPathNameAPtr)=0A=
+    GetLongPathNameAPtr =3D get_long_path_name_w32impl;=0A=
+=20=20=0A=
+  len =3D (*GetLongPathNameAPtr) (filename, buf, MAX_PATH);=0A=
   if (len =3D=3D 0 && GetLastError () =3D=3D ERROR_INVALID_PARAMETER)=0A=
     {=0A=
-      fprintf (stderr, "%s: cannot create short name of %s\n", prog_name,=
=0A=
+      fprintf (stderr, "%s: cannot create long name of %s\n", prog_name,=
=0A=
 	       filename);=0A=
       exit (2);=0A=
     }=0A=
-  return sbuf;=0A=
+  sbuf =3D (char *) malloc (++len);=0A=
+  if (sbuf =3D=3D NULL)=0A=
+    {=0A=
+      fprintf (stderr, "%s: out of memory\n", prog_name);=0A=
+      exit (1);=0A=
+    }=0A=
+  return strcpy (sbuf, buf);=0A=
+}=0A=
+=0A=
+static void=0A=
+dowin (char option)=0A=
+{=0A=
+  char *buf, buf1[MAX_PATH], buf2[MAX_PATH];=0A=
+  DWORD len =3D MAX_PATH;=0A=
+  WIN32_FIND_DATA w32_fd;=0A=
+  LPITEMIDLIST id;=0A=
+  HINSTANCE hinst;=0A=
+  BOOL (*GetProfilesDirectoryAPtr) (LPSTR, LPDWORD) =3D 0;=0A=
+=20=20=20=20=20=20=0A=
+  buf =3D buf1;=0A=
+  switch (option)=0A=
+    {=0A=
+    case 'D':=0A=
+      SHGetSpecialFolderLocation (NULL, allusers_flag ?=20=0A=
+	CSIDL_COMMON_DESKTOPDIRECTORY : CSIDL_DESKTOPDIRECTORY, &id);=0A=
+      SHGetPathFromIDList (id, buf);=0A=
+      /* This if clause is a Fix for Win95 without any "All Users" */=0A=
+      if (strlen (buf) =3D=3D 0)=0A=
+	{=0A=
+	  SHGetSpecialFolderLocation (NULL, CSIDL_DESKTOPDIRECTORY, &id);=0A=
+	  SHGetPathFromIDList (id, buf);=0A=
+	}=0A=
+      break;=0A=
+=0A=
+    case 'P':=0A=
+      SHGetSpecialFolderLocation (NULL, allusers_flag ?=20=0A=
+	CSIDL_COMMON_PROGRAMS : CSIDL_PROGRAMS, &id);=0A=
+      SHGetPathFromIDList (id, buf);=0A=
+      /* This if clause is a Fix for Win95 without any "All Users" */=0A=
+      if (strlen (buf) =3D=3D 0)=0A=
+	{=0A=
+	  SHGetSpecialFolderLocation (NULL, CSIDL_PROGRAMS, &id);=0A=
+	  SHGetPathFromIDList (id, buf);=0A=
+	}=0A=
+      break;=0A=
+=0A=
+    case 'H':=0A=
+      hinst =3D LoadLibrary ("userenv");=0A=
+      if (hinst)=0A=
+	GetProfilesDirectoryAPtr =3D (BOOL (*) (LPSTR, LPDWORD))=0A=
+	  GetProcAddress (hinst, "GetProfilesDirectoryA");=0A=
+      if (GetProfilesDirectoryAPtr)=0A=
+        (*GetProfilesDirectoryAPtr) (buf, &len);=0A=
+      else=0A=
+	{=0A=
+	  GetWindowsDirectory (buf, MAX_PATH);=0A=
+	  strcat (buf, "\\Profiles");=0A=
+	}=0A=
+      break;=0A=
+=0A=
+    case 'S':=0A=
+      GetSystemDirectory (buf, MAX_PATH);=0A=
+      FindFirstFile (buf, &w32_fd);=0A=
+      strcpy (strrchr (buf, '\\') + 1, w32_fd.cFileName);=0A=
+      break;=0A=
+=0A=
+    case 'W':=0A=
+      GetWindowsDirectory (buf, MAX_PATH);=0A=
+      break;=0A=
+=0A=
+    default:=0A=
+      usage (stderr, 1);=0A=
+    }=0A=
+=0A=
+  if (!windows_flag)=0A=
+    {=0A=
+      cygwin_conv_to_posix_path (buf, buf2);=0A=
+      buf =3D buf2;=0A=
+    }=0A=
+  else=0A=
+    {=0A=
+      if (shortname_flag)=0A=
+        buf =3D get_short_name (buf);=0A=
+    }=0A=
+  printf ("%s\n", buf);=0A=
+  exit (0);=0A=
 }=0A=
=20=0A=
 static void=0A=
@@ -213,6 +428,8 @@ doit (char *filename)=0A=
 	  cygwin_posix_to_win32_path_list (filename, buf);=0A=
 	  if (shortname_flag)=0A=
 	    buf =3D get_short_paths (buf);=0A=
+	  if (longname_flag)=0A=
+	    buf =3D get_long_paths (buf);=0A=
 	}=0A=
     }=0A=
   else=0A=
@@ -230,8 +447,13 @@ doit (char *filename)=0A=
 		   prog_name, filename);=0A=
 	  exit (1);=0A=
 	}=0A=
-      if (!unix_flag && shortname_flag)=0A=
-	buf =3D get_short_name (buf);=0A=
+      if (!unix_flag)=0A=
+	{=0A=
+	if (shortname_flag)=0A=
+	  buf =3D get_short_name (buf);=0A=
+	if (longname_flag)=0A=
+	  buf =3D get_long_name (buf);=0A=
+	}=0A=
     }=0A=
=20=0A=
   puts (buf);=0A=
@@ -278,12 +500,13 @@ main (int argc, char **argv)=0A=
   unix_flag =3D 0;=0A=
   windows_flag =3D 0;=0A=
   shortname_flag =3D 0;=0A=
+  longname_flag =3D 0;=0A=
   ignore_flag =3D 0;=0A=
   options_from_file_flag =3D 0;=0A=
   allusers_flag =3D 0;=0A=
   output_flag =3D 0;=0A=
   while ((c =3D=0A=
-	  getopt_long (argc, argv, (char *) "hac:f:opsSuvwWiDPAH",=0A=
+	  getopt_long (argc, argv, (char *) "hac:f:opslSuvwWiDPAH",=0A=
 		       long_options, (int *) NULL)) !=3D EOF)=0A=
     {=0A=
       switch (c)=0A=
@@ -320,8 +543,14 @@ main (int argc, char **argv)=0A=
 	  windows_flag =3D 1;=0A=
 	  break;=0A=
=20=0A=
+	case 'l':=0A=
+	  if (unix_flag || shortname_flag)=0A=
+	    usage (stderr, 1);=0A=
+	  longname_flag =3D 1;=0A=
+	  break;=0A=
+=0A=
 	case 's':=0A=
-	  if (unix_flag)=0A=
+	  if (unix_flag || longname_flag)=0A=
 	    usage (stderr, 1);=0A=
 	  shortname_flag =3D 1;=0A=
 	  break;=0A=
@@ -360,97 +589,17 @@ main (int argc, char **argv)=0A=
=20=0A=
     }=0A=
=20=0A=
-  if (output_flag)=0A=
-    {=0A=
-      char *buf, buf1[MAX_PATH], buf2[MAX_PATH];=0A=
-      DWORD len =3D MAX_PATH;=0A=
-      WIN32_FIND_DATA w32_fd;=0A=
-      LPITEMIDLIST id;=0A=
-      HINSTANCE hinst;=0A=
-      BOOL (*GetProfilesDirectoryAPtr) (LPSTR, LPDWORD) =3D 0;=0A=
-=20=20=20=20=20=20=0A=
-      buf =3D buf1;=0A=
-      switch (o)=0A=
-	{=0A=
-	case 'D':=0A=
-	  if (!allusers_flag)=0A=
-	    SHGetSpecialFolderLocation (NULL, CSIDL_DESKTOPDIRECTORY, &id);=0A=
-	  else=0A=
-	    SHGetSpecialFolderLocation (NULL, CSIDL_COMMON_DESKTOPDIRECTORY,=0A=
-					&id);=0A=
-	  SHGetPathFromIDList (id, buf);=0A=
-	  /* This if clause is a Fix for Win95 without any "All Users" */=0A=
-	  if (strlen (buf) =3D=3D 0)=0A=
-	    {=0A=
-	      SHGetSpecialFolderLocation (NULL, CSIDL_DESKTOPDIRECTORY, &id);=0A=
-	      SHGetPathFromIDList (id, buf);=0A=
-	    }=0A=
-	  break;=0A=
-=0A=
-	case 'P':=0A=
-	  if (!allusers_flag)=0A=
-	    SHGetSpecialFolderLocation (NULL, CSIDL_PROGRAMS, &id);=0A=
-	  else=0A=
-	    SHGetSpecialFolderLocation (NULL, CSIDL_COMMON_PROGRAMS, &id);=0A=
-	  SHGetPathFromIDList (id, buf);=0A=
-	  /* This if clause is a Fix for Win95 without any "All Users" */=0A=
-	  if (strlen (buf) =3D=3D 0)=0A=
-	    {=0A=
-	      SHGetSpecialFolderLocation (NULL, CSIDL_PROGRAMS, &id);=0A=
-	      SHGetPathFromIDList (id, buf);=0A=
-	    }=0A=
-	  break;=0A=
-=0A=
-	case 'H':=0A=
-	  hinst =3D LoadLibrary ("userenv");=0A=
-	  if (hinst)=0A=
-	    GetProfilesDirectoryAPtr =3D (BOOL (*) (LPSTR, LPDWORD))=0A=
-	      GetProcAddress (hinst, "GetProfilesDirectoryA");=0A=
-	  if (GetProfilesDirectoryAPtr)=0A=
-	    (*GetProfilesDirectoryAPtr) (buf, &len);=0A=
-	  else=0A=
-	    {=0A=
-	      GetWindowsDirectory (buf, MAX_PATH);=0A=
-	      strcat (buf, "\\Profiles");=0A=
-	    }=0A=
-	  break;=0A=
-=0A=
-	case 'S':=0A=
-	  GetSystemDirectory (buf, MAX_PATH);=0A=
-	  FindFirstFile (buf, &w32_fd);=0A=
-	  strcpy (strrchr (buf, '\\') + 1, w32_fd.cFileName);=0A=
-	  break;=0A=
-=0A=
-	case 'W':=0A=
-	  GetWindowsDirectory (buf, MAX_PATH);=0A=
-	  break;=0A=
-=0A=
-	default:=0A=
-    	  usage (stderr, 1);=0A=
-	}=0A=
-=0A=
-	if (!windows_flag)=0A=
-	  {=0A=
-	    cygwin_conv_to_posix_path (buf, buf2);=0A=
-	    buf =3D buf2;=0A=
-	  }=0A=
-	else=0A=
-	  {=0A=
-	    if (shortname_flag)=0A=
-	      buf =3D get_short_name (buf);=0A=
-	  }=0A=
-	printf ("%s\n", buf);=0A=
-	exit (0);=0A=
-    }=0A=
-=0A=
   if (options_from_file_flag && !file_arg)=0A=
     usage (stderr, 1);=0A=
=20=0A=
-  if (!unix_flag && !windows_flag && !options_from_file_flag)=0A=
+  if (!output_flag && !unix_flag && !windows_flag && !options_from_file_fl=
ag)=0A=
     usage (stderr, 1);=0A=
=20=0A=
   if (!file_arg)=0A=
     {=0A=
+      if (output_flag)=0A=
+	dowin (o);=0A=
+=0A=
       if (optind !=3D argc - 1)=0A=
 	usage (stderr, 1);=0A=
=20=0A=
@@ -499,6 +648,11 @@ main (int argc, char **argv)=0A=
 		    break;=0A=
 		  case 's':=0A=
 		    shortname_flag =3D 1;=0A=
+		    longname_flag =3D 0;=0A=
+		    break;=0A=
+		  case 'l':=0A=
+		    shortname_flag =3D 0;=0A=
+		    longname_flag =3D 1;=0A=
 		    break;=0A=
 		  case 'w':=0A=
 		    unix_flag =3D 0;=0A=
@@ -510,14 +664,25 @@ main (int argc, char **argv)=0A=
 		    break;=0A=
 		  case 'p':=0A=
 		    path_flag =3D 1;=0A=
+		    break;=0A=
+		  case 'D':=0A=
+		  case 'H':=0A=
+		  case 'P':=0A=
+		  case 'S':=0A=
+		  case 'W':=0A=
+	  	    output_flag =3D 1;=0A=
+		    o =3D c;=0A=
+	  	    break;=0A=
 		  }=0A=
 	      if (*s)=0A=
 		do=0A=
 		  s++;=0A=
 		while (*s && isspace (*s));=0A=
 	    }=0A=
-	  if (*s)=0A=
+	  if (*s && !output_flag)=0A=
 	    doit (s);=0A=
+	  if (!*s && output_flag)=0A=
+	    dowin (o);=0A=
 	}=0A=
     }=0A=
=20=0A=

------_=_NextPart_000_01C20095.67758F80
Content-Type: application/octet-stream;
	name="utils.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="utils.diff"
Content-length: 3028

Index: utils.sgml=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/utils/utils.sgml,v=0A=
retrieving revision 1.20=0A=
diff -u -p -r1.20 utils.sgml=0A=
--- utils.sgml	15 May 2002 11:36:00 -0000	1.20=0A=
+++ utils.sgml	20 May 2002 19:32:07 -0000=0A=
@@ -71,18 +71,22 @@ or if you know what everything is alread=0A=
 <sect2 id=3D"cygpath"><title>cygpath</title>=0A=
=20=0A=
 <screen>=0A=
-Usage: cygpath.exe [-p|--path] (-u|--unix)|(-w|--windows [-s|--short-name]=
) filename=0A=
+Usage: cygpath [-p|--path] (-w|--windows) ([-s|--short-name]|[-l|--long-na=
me]) filename=0A=
+Usage: cygpath [-p|--path] (-u|--unix) filename=0A=
+Usage: cygpath (-H|--homeroot)|(-S|--sysdir)|(-W|--windir) [-s|--short-nam=
e]=0A=
+Usage: cygpath [-A|--allusers] (-D|--desktop)|(-P|--smprograms) [-s|--shor=
t-name]=0A=
   -a|--absolute         output absolute path=0A=
   -c|--close handle     close handle (for use in captured process)=0A=
   -f|--file file        read file for input path information=0A=
   -i|--ignore           ignore missing argument=0A=
+  -l|--long-name        print Windows long form of filename=0A=
   -p|--path             filename argument is a path=0A=
   -s|--short-name       print Windows short form of filename=0A=
   -u|--unix             print Unix form of filename=0A=
   -v|--version          output version information and exit=0A=
   -w|--windows          print Windows form of filename=0A=
   -A|--allusers         use `All Users' instead of current user for -D, -P=
=0A=
-  -H|--homeroot		output `Profiles' directory (home root) and exit\n\=0A=
+  -H|--homeroot		output `Profiles' directory (home root) and exit=0A=
   -D|--desktop          output `Desktop' directory and exit=0A=
   -P|--smprograms       output Start Menu `Programs' directory and exit=0A=
   -S|--sysdir           output system directory and exit=0A=
@@ -102,8 +106,14 @@ indicate whether you want a conversion f=0A=
 format (<literal>-u</literal>) or a conversion from UNIX (POSIX) to=0A=
 Windows format (<literal>-w</literal>).  You must give exactly=0A=
 one of these.  To give neither or both is an error.  Use the=0A=
-<literal>-s</literal> option in combination with the <literal>-w=0A=
-</literal> option to convert to Windows short form.</para>=0A=
+<literal>-l</literal> or <literal>-s</literal> option in combination=20=0A=
+with the <literal>-w</literal> option to convert to Windows long or=20=0A=
+short form.</para>=0A=
+=0A=
+<para>Caveat: The <literal>-l</literal> option does not work if the=0A=
+<em>check_case</em> parameter of <em>CYGWIN</em> is set to <em>strict</em>=
,=0A=
+since Cygwin is not able to match any Windows short path in this mode.=0A=
+</para>=0A=
=20=0A=
 <para>The <literal>-p</literal> option means that you want to convert=0A=
 a path-style string rather than a single filename.  For example, the=0A=

------_=_NextPart_000_01C20095.67758F80--
