Return-Path: <cygwin-patches-return-1729-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 22121 invoked by alias); 17 Jan 2002 15:01:26 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 22065 invoked from network); 17 Jan 2002 15:01:24 -0000
Message-ID: <000801c19f67$87073950$b3e0290c@world9t3igycu7>
From: "Joshua Daniel Franklin" <joshuadfranklin@yahoo.com>
To: <cygwin-patches@cygwin.com>
Subject: Cygpath patch resend
Date: Thu, 17 Jan 2002 07:01:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0005_01C19F34.F02EA8B0"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
X-SW-Source: 2002-q1/txt/msg00086.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_0005_01C19F34.F02EA8B0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 911

OK, I've abandoned the web-based email client which will hopefully fix the
spacing issue. Here it is again:

I've added these options to cygpath:

  -A|--allusers        use `All Users' instead of current user for -D, -P
  -D|--desktop        output `Desktop' directory and exit
  -P|--smprograms    output Start Menu `Programs' directory and exit

I've also fixed the issue where options that depend on other options do not
behave as expected. For example, -Ww and -wW behaved differently but now
will do the right thing.

Here's a changelog:

2001-01-16 Joshua Daniel Franklin <joshuadfranklin@yahoo.com>

* cygpath.cc (main): Added options to show Desktop and Start Menu's Programs
directory for current user or all users
* cygpath.cc (main): moved bulk of DPWS options outside the getopt case
statement
 (since their output depends on uwA switches)
* utils.sgml: updated cygpath section for ADPWS options



------=_NextPart_000_0005_01C19F34.F02EA8B0
Content-Type: application/octet-stream;
	name="cygpath.cc-patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="cygpath.cc-patch"
Content-length: 7434

--- cygpath.cc-orig	Sat Jan 12 12:37:11 2002=0A=
+++ cygpath.cc	Wed Jan 16 08:59:52 2002=0A=
@@ -1,5 +1,5 @@=0A=
 /* cygpath.cc -- convert pathnames between Windows and Unix format=0A=
-   Copyright 1998, 1999, 2000, 2001 Red Hat, Inc.=0A=
+   Copyright 1998-2002 Red Hat, Inc.=0A=
=20=0A=
 This file is part of Cygwin.=0A=
=20=0A=
@@ -7,6 +7,9 @@ This software is a copyrighted work lice=0A=
 Cygwin license.  Please consult the file "CYGWIN_LICENSE" for=0A=
 details. */=0A=
=20=0A=
+#define NOCOMATTRIBUTE=0A=
+=0A=
+#include <shlobj.h>=0A=
 #include <stdio.h>=0A=
 #include <string.h>=0A=
 #include <stdlib.h>=0A=
@@ -22,7 +25,7 @@ static char *prog_name;=0A=
 static char *file_arg;=0A=
 static char *close_arg;=0A=
 static int path_flag, unix_flag, windows_flag, absolute_flag;=0A=
-static int shortname_flag, ignore_flag;=0A=
+static int shortname_flag, ignore_flag, allusers_flag, output_flag;=0A=
=20=0A=
 static struct option long_options[] =3D=0A=
 {=0A=
@@ -39,6 +42,9 @@ static struct option long_options[] =3D=0A=
   { (char *) "windir", no_argument, NULL, 'W' },=0A=
   { (char *) "sysdir", no_argument, NULL, 'S' },=0A=
   { (char *) "ignore", no_argument, NULL, 'i' },=0A=
+  { (char *) "allusers", no_argument, NULL, 'A' },=0A=
+  { (char *) "desktop", no_argument, NULL, 'D' },=0A=
+  { (char *) "smprograms", no_argument, NULL, 'P' },=0A=
   { 0, no_argument, 0, 0 }=0A=
 };=0A=
=20=0A=
@@ -50,14 +56,18 @@ usage (FILE *stream, int status)=0A=
 Usage: %s [-p|--path] (-u|--unix)|(-w|--windows [-s|--short-name]) filenam=
e\n\=0A=
   -a|--absolute		output absolute path\n\=0A=
   -c|--close handle	close handle (for use in captured process)\n\=0A=
-  -f|--file file	read file for path information\n\=0A=
+  -f|--file file	read file for input path information\n\=0A=
   -i|--ignore		ignore missing argument\n\=0A=
   -p|--path		filename argument is a path\n\=0A=
   -s|--short-name	print Windows short form of filename\n\=0A=
-  -S|--sysdir		print `system' directory\n\=0A=
   -u|--unix		print Unix form of filename\n\=0A=
+  -v|--version		output version information and exit\n\=0A=
   -w|--windows		print Windows form of filename\n\=0A=
-  -W|--windir		print `Windows' directory\n",=0A=
+  -A|--allusers		use `All Users' instead of current user for -D, -P\n\=0A=
+  -D|--desktop		output `Desktop' directory and exit\n\=0A=
+  -P|--smprograms	output Start Menu `Programs' directory and exit\n\=0A=
+  -S|--sysdir		output system directory and exit\n\=0A=
+  -W|--windir		output `Windows' directory and exit\n",=0A=
 	   prog_name);=0A=
   exit (ignore_flag ? 0 : status);=0A=
 }=0A=
@@ -219,11 +229,12 @@ doit (char *filename)=0A=
 int=0A=
 main (int argc, char **argv)=0A=
 {=0A=
-  int c;=0A=
+  int c, o;=0A=
   int options_from_file_flag;=0A=
   char *filename;=0A=
   char buf[MAX_PATH], buf2[MAX_PATH];=0A=
   WIN32_FIND_DATA w32_fd;=0A=
+  LPITEMIDLIST id;=0A=
=20=0A=
   prog_name =3D strrchr (argv[0], '/');=0A=
   if (prog_name =3D=3D NULL)=0A=
@@ -239,7 +250,9 @@ main (int argc, char **argv)=0A=
   shortname_flag =3D 0;=0A=
   ignore_flag =3D 0;=0A=
   options_from_file_flag =3D 0;=0A=
-  while ((c =3D getopt_long (argc, argv, (char *) "hac:f:opsSuvwWi", long_=
options, (int *) NULL))=0A=
+  allusers_flag =3D 0;=0A=
+  output_flag =3D 0;=0A=
+  while ((c =3D getopt_long (argc, argv, (char *) "hac:f:opsSuvwWiDPA", lo=
ng_options, (int *) NULL))=0A=
 	 !=3D EOF)=0A=
     {=0A=
       switch (c)=0A=
@@ -282,25 +295,37 @@ main (int argc, char **argv)=0A=
 	  shortname_flag =3D 1;=0A=
 	  break;=0A=
=20=0A=
-	case 'W':=0A=
-	  GetWindowsDirectory(buf, MAX_PATH);=0A=
-	  if (!windows_flag)=0A=
-	    cygwin_conv_to_posix_path(buf, buf2);=0A=
-	  else=0A=
-	    strcpy(buf2, buf);=0A=
-	  printf("%s\n", buf2);=0A=
-	  exit(0);=0A=
+	case 'A':=0A=
+	  allusers_flag =3D 1;=0A=
+	  break;=0A=
+=0A=
+	case 'D':=0A=
+	  if (output_flag)=0A=
+	    usage (stderr, 1);=0A=
+	  output_flag =3D 1;=0A=
+	  o =3D 'D';=0A=
+	  break;=0A=
+=0A=
+	case 'P':=0A=
+	  if (output_flag)=0A=
+	    usage (stderr, 1);=0A=
+	  output_flag =3D 1;=0A=
+	  o =3D 'P';=0A=
+          break;=0A=
=20=0A=
 	case 'S':=0A=
-	  GetSystemDirectory(buf, MAX_PATH);=0A=
-	  FindFirstFile(buf, &w32_fd);=0A=
-	  strcpy(strrchr(buf, '\\')+1, w32_fd.cFileName);=0A=
-	  if (!windows_flag)=0A=
-	    cygwin_conv_to_posix_path(buf, buf2);=0A=
-	  else=0A=
-	    strcpy(buf2, buf);=0A=
-	  printf("%s\n", buf2);=0A=
-	  exit(0);=0A=
+	  if (output_flag)=0A=
+	    usage (stderr, 1);=0A=
+	  output_flag =3D 1;=0A=
+	  o =3D 'S';=0A=
+          break;=0A=
+=0A=
+	case 'W':=0A=
+	  if (output_flag)=0A=
+	    usage (stderr, 1);=0A=
+	  output_flag =3D 1;=0A=
+	  o =3D 'W';=0A=
+	  break;=0A=
=20=0A=
 	case 'i':=0A=
 	  ignore_flag =3D 1;=0A=
@@ -311,15 +336,80 @@ main (int argc, char **argv)=0A=
 	  break;=0A=
=20=0A=
 	case 'v':=0A=
-	  printf ("Cygwin path conversion version 1.1\n");=0A=
-	  printf ("Copyright 1998,1999,2000,2001 Red Hat, Inc.\n");=0A=
+	  printf ("Cygwin path conversion version 1.2\n");=0A=
+	  printf ("Copyright 1998-2002 Red Hat, Inc.\n");=0A=
 	  exit (0);=0A=
=20=0A=
 	default:=0A=
 	  usage (stderr, 1);=0A=
 	  break;=0A=
 	}=0A=
+=0A=
     }=0A=
+=0A=
+  if (output_flag)=20=0A=
+    {=0A=
+      switch(o) {=0A=
+	case 'D':=0A=
+	  if (!allusers_flag)=0A=
+            SHGetSpecialFolderLocation(NULL, CSIDL_DESKTOPDIRECTORY,&id);=
=0A=
+	  else=0A=
+            SHGetSpecialFolderLocation(NULL, CSIDL_COMMON_DESKTOPDIRECTORY=
,&id);=0A=
+          SHGetPathFromIDList(id, buf);=0A=
+          /* This if clause is a Fix for Win95 without any "All Users" */=
=0A=
+          if ( strlen(buf) =3D=3D 0 ) {=0A=
+            SHGetSpecialFolderLocation(NULL, CSIDL_DESKTOPDIRECTORY,&id);=
=0A=
+            SHGetPathFromIDList(id, buf);=0A=
+          }=0A=
+	  if (!windows_flag)=0A=
+	    cygwin_conv_to_posix_path(buf, buf2);=0A=
+	  else=0A=
+	    strcpy(buf2, buf);=0A=
+          printf("%s\n", buf2);=0A=
+          exit(0);=0A=
+=0A=
+	case 'P':=0A=
+	  if (!allusers_flag)=0A=
+            SHGetSpecialFolderLocation(NULL, CSIDL_PROGRAMS, &id);=0A=
+	  else=0A=
+            SHGetSpecialFolderLocation(NULL, CSIDL_COMMON_PROGRAMS, &id);=
=0A=
+          SHGetPathFromIDList(id, buf);=0A=
+          /* This if clause is a Fix for Win95 without any "All Users" */=
=0A=
+          if ( strlen(buf) =3D=3D 0 ) {=0A=
+            SHGetSpecialFolderLocation(NULL, CSIDL_PROGRAMS, &id);=0A=
+            SHGetPathFromIDList(id, buf);=0A=
+          }=0A=
+	  if (!windows_flag)=0A=
+	    cygwin_conv_to_posix_path(buf, buf2);=0A=
+	  else=0A=
+	    strcpy(buf2, buf);=0A=
+          printf("%s\n", buf2);=0A=
+          exit(0);=0A=
+=20=0A=
+	case 'S':=0A=
+	  GetSystemDirectory(buf, MAX_PATH);=0A=
+	  FindFirstFile(buf, &w32_fd);=0A=
+	  strcpy(strrchr(buf, '\\')+1, w32_fd.cFileName);=0A=
+	  if (!windows_flag)=0A=
+	    cygwin_conv_to_posix_path(buf, buf2);=0A=
+	  else=0A=
+	    strcpy(buf2, buf);=0A=
+          printf("%s\n", buf2);=0A=
+          exit(0);=0A=
+=0A=
+	case 'W':=0A=
+	  GetWindowsDirectory(buf, MAX_PATH);=0A=
+	  if (!windows_flag)=0A=
+	    cygwin_conv_to_posix_path(buf, buf2);=0A=
+	  else=0A=
+	    strcpy(buf2, buf);=0A=
+          printf("%s\n", buf2);=0A=
+          exit(0);=0A=
+=20=0A=
+	default:=0A=
+	  fprintf(stderr, "ERROR: main: switch(o)!\n");=0A=
+      }=0A=
+  }=0A=
=20=0A=
   if (options_from_file_flag && !file_arg)=0A=
     usage (stderr, 1);=0A=

------=_NextPart_000_0005_01C19F34.F02EA8B0
Content-Type: application/octet-stream;
	name="utils.sgml-patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="utils.sgml-patch"
Content-length: 2866

--- utils.sgml-orig	Wed Jan 16 08:43:59 2002=0A=
+++ utils.sgml	Wed Jan 16 09:00:36 2002=0A=
@@ -70,20 +70,21 @@ or if you know what everything is alread=0A=
 <sect2 id=3D"cygpath"><title>cygpath</title>=0A=
=20=0A=
 <screen>=0A=
-Usage: cygpath [-p|--path] (-u|--unix)|(-w|--windows [-s|--short-name]) fi=
lename=0A=
-       cygpath [-v|--version]=0A=
-       cygpath [-W|--windir|-S|--sysdir]=0A=
-  -a|--absolute      output absolute path=0A=
-  -c|--close handle  close handle (for use in captured process)=0A=
-  -f|--file file     read file for path information=0A=
-  -i|--ignore        ignore missing filename argument=0A=
-  -p|--path          filename argument is a path=0A=
-  -s|--short-name    print Windows short form of filename=0A=
-  -S|--sysdir        print Windows system directory=0A=
-  -u|--unix          print UNIX form of filename=0A=
-  -v|--version       print program version=0A=
-  -w|--windows       print Windows form of filename=0A=
-  -W|--windir        print Windows directory=0A=
+Usage: cygpath.exe [-p|--path] (-u|--unix)|(-w|--windows [-s|--short-name]=
) filename=0A=
+  -a|--absolute         output absolute path=0A=
+  -c|--close handle     close handle (for use in captured process)=0A=
+  -f|--file file        read file for input path information=0A=
+  -i|--ignore           ignore missing argument=0A=
+  -p|--path             filename argument is a path=0A=
+  -s|--short-name       print Windows short form of filename=0A=
+  -u|--unix             print Unix form of filename=0A=
+  -v|--version          output version information and exit=0A=
+  -w|--windows          print Windows form of filename=0A=
+  -A|--allusers         use `All Users' instead of current user for -D, -P=
=0A=
+  -D|--desktop          output `Desktop' directory and exit=0A=
+  -P|--smprograms       output Start Menu `Programs' directory and exit=0A=
+  -S|--sysdir           output system directory and exit=0A=
+  -W|--windir           output `Windows' directory and exit=0A=
 </screen>=0A=
=20=0A=
 <para>The <command>cygpath</command> program is a utility that=0A=
@@ -123,6 +124,17 @@ do=0A=
 done=0A=
 </screen>=0A=
 </example>=0A=
+=0A=
+<para>The capital options=20=0A=
+<literal>-D</literal>, <literal>-P</literal>, <literal>-S</literal>, and=
=0A=
+<literal>-W</literal> output directories used by Windows that are not the=
=0A=
+same on all systems, for example <literal>-S</literal> might output=20=0A=
+C:\WINNT\SYSTEM32 or C:\WINDOWS\SYSTEM. The <literal>-A</literal> option=
=0A=
+forces use of the "All Users" directories instead of the current user=0A=
+for the <literal>-D</literal> and <literal>-P</literal> options.=0A=
+On Win9x systems with only a single user, <literal>-A</literal> has no=0A=
+effect; <literal>-D</literal> and <literal>-AD</literal> would have the=0A=
+same output.=0A=
=20=0A=
 </sect2>=0A=
=20=0A=

------=_NextPart_000_0005_01C19F34.F02EA8B0--


_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

