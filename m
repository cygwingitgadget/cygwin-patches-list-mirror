Return-Path: <cygwin-patches-return-1708-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 14264 invoked by alias); 16 Jan 2002 20:56:42 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 14147 invoked from network); 16 Jan 2002 20:56:40 -0000
Message-ID: <20020116205633.59429.qmail@web20005.mail.yahoo.com>
Date: Wed, 16 Jan 2002 12:56:00 -0000
From: Joshua Franklin <joshuadfranklin@yahoo.com>
Subject: cygpath patch
To: cygwin-patches@cygwin.com
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1758171140-1011214593=:54080"
X-SW-Source: 2002-q1/txt/msg00065.txt.bz2

--0-1758171140-1011214593=:54080
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-length: 945

I've added these options to cygpath:

  -A|--allusers         use `All Users' instead of
current user for -D, -P
  -D|--desktop          output `Desktop' directory and
exit
  -P|--smprograms       output Start Menu `Programs'
directory and exit

I've also fixed the issue where options that depend
on other options do not behave as expected. For
example, -Ww and -wW behaved differently but now will
do the right thing.

Here's a changelog:

2001-01-16 Joshua Daniel Franklin
<joshuadfranklin@yahoo.com>

* cygpath.cc (main): Added options to show Desktop and
Start Menu's Programs directory for current user or
all users
* cygpath.cc (main): moved bulk of DPWS options
outside the getopt case statement (since their output
depends on uwA switches)
* utils.sgml: updated cygpath section for ADPWS
options


__________________________________________________
Do You Yahoo!?
Send FREE video emails in Yahoo! Mail!
http://promo.yahoo.com/videomail/
--0-1758171140-1011214593=:54080
Content-Type: text/plain; name="cygpath.cc-patch"
Content-Description: cygpath.cc-patch
Content-Disposition: inline; filename="cygpath.cc-patch"
Content-length: 6449

--- cygpath.cc-orig	Sat Jan 12 12:37:11 2002
+++ cygpath.cc	Wed Jan 16 08:59:52 2002
@@ -1,5 +1,5 @@
 /* cygpath.cc -- convert pathnames between Windows and Unix format
-   Copyright 1998, 1999, 2000, 2001 Red Hat, Inc.
+   Copyright 1998-2002 Red Hat, Inc.
 
 This file is part of Cygwin.
 
@@ -7,6 +7,9 @@ This software is a copyrighted work lice
 Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
 details. */
 
+#define NOCOMATTRIBUTE
+
+#include <shlobj.h>
 #include <stdio.h>
 #include <string.h>
 #include <stdlib.h>
@@ -22,7 +25,7 @@ static char *prog_name;
 static char *file_arg;
 static char *close_arg;
 static int path_flag, unix_flag, windows_flag, absolute_flag;
-static int shortname_flag, ignore_flag;
+static int shortname_flag, ignore_flag, allusers_flag, output_flag;
 
 static struct option long_options[] =
 {
@@ -39,6 +42,9 @@ static struct option long_options[] =
   { (char *) "windir", no_argument, NULL, 'W' },
   { (char *) "sysdir", no_argument, NULL, 'S' },
   { (char *) "ignore", no_argument, NULL, 'i' },
+  { (char *) "allusers", no_argument, NULL, 'A' },
+  { (char *) "desktop", no_argument, NULL, 'D' },
+  { (char *) "smprograms", no_argument, NULL, 'P' },
   { 0, no_argument, 0, 0 }
 };
 
@@ -50,14 +56,18 @@ usage (FILE *stream, int status)
 Usage: %s [-p|--path] (-u|--unix)|(-w|--windows [-s|--short-name]) 
filename\n\
   -a|--absolute		output absolute path\n\
   -c|--close handle	close handle (for use in captured process)\n\
-  -f|--file file	read file for path information\n\
+  -f|--file file	read file for input path information\n\
   -i|--ignore		ignore missing argument\n\
   -p|--path		filename argument is a path\n\
   -s|--short-name	print Windows short form of filename\n\
-  -S|--sysdir		print `system' directory\n\
   -u|--unix		print Unix form of filename\n\
+  -v|--version		output version information and exit\n\
   -w|--windows		print Windows form of filename\n\
-  -W|--windir		print `Windows' directory\n",
+  -A|--allusers		use `All Users' instead of current user for -D, -P\n\
+  -D|--desktop		output `Desktop' directory and exit\n\
+  -P|--smprograms	output Start Menu `Programs' directory and exit\n\
+  -S|--sysdir		output system directory and exit\n\
+  -W|--windir		output `Windows' directory and exit\n",
 	   prog_name);
   exit (ignore_flag ? 0 : status);
 }
@@ -219,11 +229,12 @@ doit (char *filename)
 int
 main (int argc, char **argv)
 {
-  int c;
+  int c, o;
   int options_from_file_flag;
   char *filename;
   char buf[MAX_PATH], buf2[MAX_PATH];
   WIN32_FIND_DATA w32_fd;
+  LPITEMIDLIST id;
 
   prog_name = strrchr (argv[0], '/');
   if (prog_name == NULL)
@@ -239,7 +250,9 @@ main (int argc, char **argv)
   shortname_flag = 0;
   ignore_flag = 0;
   options_from_file_flag = 0;
-  while ((c = getopt_long (argc, argv, (char *) "hac:f:opsSuvwWi", 
long_options, (int *) NULL))
+  allusers_flag = 0;
+  output_flag = 0;
+  while ((c = getopt_long (argc, argv, (char *) "hac:f:opsSuvwWiDPA", 
long_options, (int *) NULL))
 	 != EOF)
     {
       switch (c)
@@ -282,25 +295,37 @@ main (int argc, char **argv)
 	  shortname_flag = 1;
 	  break;
 
-	case 'W':
-	  GetWindowsDirectory(buf, MAX_PATH);
-	  if (!windows_flag)
-	    cygwin_conv_to_posix_path(buf, buf2);
-	  else
-	    strcpy(buf2, buf);
-	  printf("%s\n", buf2);
-	  exit(0);
+	case 'A':
+	  allusers_flag = 1;
+	  break;
+
+	case 'D':
+	  if (output_flag)
+	    usage (stderr, 1);
+	  output_flag = 1;
+	  o = 'D';
+	  break;
+
+	case 'P':
+	  if (output_flag)
+	    usage (stderr, 1);
+	  output_flag = 1;
+	  o = 'P';
+          break;
 
 	case 'S':
-	  GetSystemDirectory(buf, MAX_PATH);
-	  FindFirstFile(buf, &w32_fd);
-	  strcpy(strrchr(buf, '\\')+1, w32_fd.cFileName);
-	  if (!windows_flag)
-	    cygwin_conv_to_posix_path(buf, buf2);
-	  else
-	    strcpy(buf2, buf);
-	  printf("%s\n", buf2);
-	  exit(0);
+	  if (output_flag)
+	    usage (stderr, 1);
+	  output_flag = 1;
+	  o = 'S';
+          break;
+
+	case 'W':
+	  if (output_flag)
+	    usage (stderr, 1);
+	  output_flag = 1;
+	  o = 'W';
+	  break;
 
 	case 'i':
 	  ignore_flag = 1;
@@ -311,15 +336,80 @@ main (int argc, char **argv)
 	  break;
 
 	case 'v':
-	  printf ("Cygwin path conversion version 1.1\n");
-	  printf ("Copyright 1998,1999,2000,2001 Red Hat, Inc.\n");
+	  printf ("Cygwin path conversion version 1.2\n");
+	  printf ("Copyright 1998-2002 Red Hat, Inc.\n");
 	  exit (0);
 
 	default:
 	  usage (stderr, 1);
 	  break;
 	}
+
     }
+
+  if (output_flag) 
+    {
+      switch(o) {
+	case 'D':
+	  if (!allusers_flag)
+            SHGetSpecialFolderLocation(NULL, 
CSIDL_DESKTOPDIRECTORY,&id);
+	  else
+            SHGetSpecialFolderLocation(NULL, 
CSIDL_COMMON_DESKTOPDIRECTORY,&id);
+          SHGetPathFromIDList(id, buf);
+          /* This if clause is a Fix for Win95 without any "All Users" 
*/
+          if ( strlen(buf) == 0 ) {
+            SHGetSpecialFolderLocation(NULL, 
CSIDL_DESKTOPDIRECTORY,&id);
+            SHGetPathFromIDList(id, buf);
+          }
+	  if (!windows_flag)
+	    cygwin_conv_to_posix_path(buf, buf2);
+	  else
+	    strcpy(buf2, buf);
+          printf("%s\n", buf2);
+          exit(0);
+
+	case 'P':
+	  if (!allusers_flag)
+            SHGetSpecialFolderLocation(NULL, CSIDL_PROGRAMS, &id);
+	  else
+            SHGetSpecialFolderLocation(NULL, CSIDL_COMMON_PROGRAMS, 
&id);
+          SHGetPathFromIDList(id, buf);
+          /* This if clause is a Fix for Win95 without any "All Users" 
*/
+          if ( strlen(buf) == 0 ) {
+            SHGetSpecialFolderLocation(NULL, CSIDL_PROGRAMS, &id);
+            SHGetPathFromIDList(id, buf);
+          }
+	  if (!windows_flag)
+	    cygwin_conv_to_posix_path(buf, buf2);
+	  else
+	    strcpy(buf2, buf);
+          printf("%s\n", buf2);
+          exit(0);
+ 
+	case 'S':
+	  GetSystemDirectory(buf, MAX_PATH);
+	  FindFirstFile(buf, &w32_fd);
+	  strcpy(strrchr(buf, '\\')+1, w32_fd.cFileName);
+	  if (!windows_flag)
+	    cygwin_conv_to_posix_path(buf, buf2);
+	  else
+	    strcpy(buf2, buf);
+          printf("%s\n", buf2);
+          exit(0);
+
+	case 'W':
+	  GetWindowsDirectory(buf, MAX_PATH);
+	  if (!windows_flag)
+	    cygwin_conv_to_posix_path(buf, buf2);
+	  else
+	    strcpy(buf2, buf);
+          printf("%s\n", buf2);
+          exit(0);
+ 
+	default:
+	  fprintf(stderr, "ERROR: main: switch(o)!\n");
+      }
+  }
 
   if (options_from_file_flag && !file_arg)
     usage (stderr, 1);



--0-1758171140-1011214593=:54080
Content-Type: text/html; name="utils.sgml-patch"
Content-Description: utils.sgml-patch
Content-Disposition: inline; filename="utils.sgml-patch"
Content-length: 2625

--- utils.sgml-orig	Wed Jan 16 08:43:59 2002
+++ utils.sgml	Wed Jan 16 09:00:36 2002
@@ -70,20 +70,21 @@ or if you know what everything is alread
 <sect2 id="cygpath"><title>cygpath</title>
 
 <screen>
-Usage: cygpath [-p|--path] (-u|--unix)|(-w|--windows 
[-s|--short-name]) filename
-       cygpath [-v|--version]
-       cygpath [-W|--windir|-S|--sysdir]
-  -a|--absolute      output absolute path
-  -c|--close handle  close handle (for use in captured process)
-  -f|--file file     read file for path information
-  -i|--ignore        ignore missing filename argument
-  -p|--path          filename argument is a path
-  -s|--short-name    print Windows short form of filename
-  -S|--sysdir        print Windows system directory
-  -u|--unix          print UNIX form of filename
-  -v|--version       print program version
-  -w|--windows       print Windows form of filename
-  -W|--windir        print Windows directory
+Usage: cygpath.exe [-p|--path] (-u|--unix)|(-w|--windows 
[-s|--short-name]) filename
+  -a|--absolute         output absolute path
+  -c|--close handle     close handle (for use in captured process)
+  -f|--file file        read file for input path information
+  -i|--ignore           ignore missing argument
+  -p|--path             filename argument is a path
+  -s|--short-name       print Windows short form of filename
+  -u|--unix             print Unix form of filename
+  -v|--version          output version information and exit
+  -w|--windows          print Windows form of filename
+  -A|--allusers         use `All Users' instead of current user for 
-D, -P
+  -D|--desktop          output `Desktop' directory and exit
+  -P|--smprograms       output Start Menu `Programs' directory and 
exit
+  -S|--sysdir           output system directory and exit
+  -W|--windir           output `Windows' directory and exit
 </screen>
 
 <para>The <command>cygpath</command> program is a utility that
@@ -123,6 +124,17 @@ do
 done
 </screen>
 </example>
+
+<para>The capital options 
+<literal>-D</literal>, <literal>-P</literal>, <literal>-S</literal>, 
and
+<literal>-W</literal> output directories used by Windows that are not 
the
+same on all systems, for example <literal>-S</literal> might output 
+C:\WINNT\SYSTEM32 or C:\WINDOWS\SYSTEM. The <literal>-A</literal> 
option
+forces use of the "All Users" directories instead of the current user
+for the <literal>-D</literal> and <literal>-P</literal> options.
+On Win9x systems with only a single user, <literal>-A</literal> has no
+effect; <literal>-D</literal> and <literal>-AD</literal> would have 
the
+same output.
 
 </sect2>
 


--0-1758171140-1011214593=:54080--
