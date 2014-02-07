Return-Path: <cygwin-patches-return-7957-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23234 invoked by alias); 7 Feb 2014 16:36:02 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 23221 invoked by uid 89); 7 Feb 2014 16:36:01 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-0.1 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,UNSUBSCRIBE_BODY autolearn=no version=3.3.2
X-HELO: smtpout09.bt.lon5.cpcloud.co.uk
Received: from smtpout09.bt.lon5.cpcloud.co.uk (HELO smtpout09.bt.lon5.cpcloud.co.uk) (65.20.0.129) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 07 Feb 2014 16:36:00 +0000
X-CTCH-RefID: str=0001.0A090206.52F50B6C.0166,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-Junkmail-Premium-Raw: score=8/97,refid=2.7.2:2014.2.7.120915:17:8.129,ip=,rules=__MOZILLA_MSGID, __HAS_MSGID, __SANE_MSGID, __HAS_FROM, __USER_AGENT, __MOZILLA_USER_AGENT, __MIME_VERSION, __TO_MALFORMED_2, __SUBJ_ALPHA_END, __CT, __CTYPE_HAS_BOUNDARY, __CTYPE_MULTIPART, __CTYPE_MULTIPART_MIXED, __BAT_BOUNDARY, __ANY_URI, __URI_NO_WWW, __URI_NO_PATH, __CANPHARM_COPYRIGHT, __STOCK_PHRASE_7, __LINES_OF_YELLING, BODY_SIZE_10000_PLUS, BODYTEXTP_SIZE_3000_LESS, __MIME_TEXT_ONLY, __URI_NS, HTML_00_01, HTML_00_10, MIME_TEXT_ONLY_MP_MIXED
X-CTCH-Spam: Unknown
Received: from [192.168.1.72] (86.174.32.243) by smtpout09.bt.lon5.cpcloud.co.uk (8.6.100.99.10223) (authenticated as jonturney@btinternet.com)        id 52F02AF9003E079D for cygwin-patches@cygwin.com; Fri, 7 Feb 2014 16:35:56 +0000
Message-ID: <52F50B71.8030608@dronecode.org.uk>
Date: Fri, 07 Feb 2014 16:36:00 -0000
From: Jon TURNEY <jon.turney@dronecode.org.uk>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
MIME-Version: 1.0
To: cygwin-patches <cygwin-patches@cygwin.com>
Subject: [PATCH] Add minidump write utility
Content-Type: multipart/mixed; boundary="------------010802010507040804020607"
X-SW-Source: 2014-q1/txt/msg00030.txt.bz2

This is a multi-part message in MIME format.
--------------010802010507040804020607
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 445


This patch adds a 'minidumper' utility, which functions identically to
'dumper' except it writes a Windows minidump, rather than a core file.
	
I'm not sure if this is of use to anyone but me, but since I've had the patch
sitting around for a couple of years, here it is...

2014-02-07  Jon TURNEY  <jon.turney@dronecode.org.uk>

	* minidumper.cc: New file.
	* Makefile.in (CYGWIN_BINS): Add minidumper.
	* utils.xml (minidumper): New section.

--------------010802010507040804020607
Content-Type: text/plain; charset=windows-1252;
 name="minidumper.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="minidumper.patch"
Content-length: 9043

Index: utils/Makefile.in
===================================================================
RCS file: /cvs/src/src/winsup/utils/Makefile.in,v
retrieving revision 1.113
diff -u -u -p -r1.113 Makefile.in
--- utils/Makefile.in	19 Nov 2013 11:14:36 -0000	1.113
+++ utils/Makefile.in	14 Jan 2014 00:01:13 -0000
@@ -56,7 +56,7 @@ MINGW_CXX      := @MINGW_CXX@
 
 # List all binaries to be linked in Cygwin mode.  Each binary on this list
 # must have a corresponding .o of the same name.
-CYGWIN_BINS := ${addsuffix .exe,cygpath getconf getfacl ldd locale kill mkgroup \
+CYGWIN_BINS := ${addsuffix .exe,cygpath getconf getfacl ldd locale kill minidumper mkgroup \
         mkpasswd mount passwd pldd ps regtool setfacl setmetamode ssp tzset umount}
 
 # List all binaries to be linked in MinGW mode.  Each binary on this list
Index: utils/minidumper.cc
===================================================================
RCS file: utils/minidumper.cc
diff -N utils/minidumper.cc
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ utils/minidumper.cc	14 Jan 2014 00:01:13 -0000
@@ -0,0 +1,225 @@
+/* minidumper.cc
+
+   Copyright 2012
+
+   This file is part of Cygwin.
+
+   This program is free software; you can redistribute it and/or modify
+   it under the terms of the GNU General Public License as published by
+   the Free Software Foundation; either version 2 of the License, or
+   (at your option) any later version.
+
+   This program is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+   GNU General Public License (file COPYING.dumper) for more details.
+
+   You should have received a copy of the GNU General Public License
+   along with this program; if not, write to the Free Software
+   Foundation, Inc., 51 Franklin Street - Fifth Floor, Boston, MA 02110-1301, USA.
+*/
+
+#include <sys/cygwin.h>
+#include <cygwin/version.h>
+#include <getopt.h>
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <windows.h>
+
+BOOL verbose = FALSE;
+
+typedef DWORD MINIDUMP_TYPE;
+
+typedef BOOL (WINAPI *MiniDumpWriteDump_type)(
+                                              HANDLE hProcess,
+                                              DWORD dwPid,
+                                              HANDLE hFile,
+                                              MINIDUMP_TYPE DumpType,
+                                              CONST void *ExceptionParam,
+                                              CONST void *UserStreamParam,
+                                              CONST void *allbackParam);
+
+static void
+minidump(DWORD pid, MINIDUMP_TYPE dump_type, const char *minidump_file)
+{
+  HANDLE dump_file;
+  HANDLE process;
+  MiniDumpWriteDump_type MiniDumpWriteDump_fp;
+  HMODULE module;
+
+  module = LoadLibrary("dbghelp.dll");
+  if (!module)
+    {
+      fprintf (stderr, "error loading DbgHelp\n");
+      return;
+    }
+
+  MiniDumpWriteDump_fp = (MiniDumpWriteDump_type)GetProcAddress(module, "MiniDumpWriteDump");
+  if (!MiniDumpWriteDump_fp)
+    {
+      fprintf (stderr, "error getting the address of MiniDumpWriteDump\n");
+      return;
+    }
+
+  dump_file = CreateFile(minidump_file,
+                         GENERIC_WRITE,
+                         0,
+                         NULL,
+                         CREATE_ALWAYS,
+                         FILE_ATTRIBUTE_NORMAL,
+                         NULL);
+  if (dump_file == INVALID_HANDLE_VALUE)
+    {
+      fprintf (stderr, "error opening file\n");
+      return;
+    }
+
+  process = OpenProcess(PROCESS_QUERY_INFORMATION | PROCESS_VM_READ,
+                        FALSE,
+                        pid);
+  if (dump_file == INVALID_HANDLE_VALUE)
+    {
+      fprintf (stderr, "error opening process\n");
+      return;
+    }
+
+  BOOL success = (*MiniDumpWriteDump_fp)(process,
+                                         pid,
+                                         dump_file,
+                                         dump_type,
+                                         NULL,
+                                         NULL,
+                                         NULL);
+  if (success)
+    {
+      if (verbose)
+        printf ("minidump created successfully\n");
+    }
+  else
+    {
+      fprintf (stderr, "error creating minidump\n");
+    }
+
+  CloseHandle(process);
+  CloseHandle(dump_file);
+  FreeLibrary(module);
+}
+
+static void
+usage (FILE *stream, int status)
+{
+  fprintf (stream, "\
+Usage: %s [OPTION] FILENAME WIN32PID\n\
+\n\
+Write minidump from WIN32PID to FILENAME.dmp\n\
+\n\
+ -t, --type     minidump type flags\n\
+ -d, --verbose  be verbose while dumping\n\
+ -h, --help     output help information and exit\n\
+ -q, --quiet    be quiet while dumping (default)\n\
+ -V, --version  output version information and exit\n\
+\n", program_invocation_short_name);
+  exit (status);
+}
+
+struct option longopts[] = {
+  {"type", required_argument, NULL, 't'},
+  {"verbose", no_argument, NULL, 'd'},
+  {"help", no_argument, NULL, 'h'},
+  {"quiet", no_argument, NULL, 'q'},
+  {"version", no_argument, 0, 'V'},
+  {0, no_argument, NULL, 0}
+};
+const char *opts = "tdhqV";
+
+static void
+print_version ()
+{
+  printf ("minidumper (cygwin) %d.%d.%d\n"
+	  "Minidump write for Cygwin\n"
+	  "Copyright (C) 1999 - %s Red Hat, Inc.\n"
+	  "This is free software; see the source for copying conditions.  There is NO\n"
+	  "warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.\n",
+	  CYGWIN_VERSION_DLL_MAJOR / 1000,
+	  CYGWIN_VERSION_DLL_MAJOR % 1000,
+	  CYGWIN_VERSION_DLL_MINOR,
+	  strrchr (__DATE__, ' ') + 1);
+}
+
+int
+main (int argc, char **argv)
+{
+  int opt;
+  const char *p = "";
+  DWORD pid;
+  MINIDUMP_TYPE dump_type = 0; // MINIDUMP_NORMAL
+
+  while ((opt = getopt_long (argc, argv, opts, longopts, NULL) ) != EOF)
+    switch (opt)
+      {
+      case 't':
+        {
+          char *endptr;
+          dump_type = strtoul(optarg, &endptr, 0);
+          if (*endptr != '\0')
+            {
+              fprintf (stderr, "syntax error in minidump type \"%s\" near character #%d.\n", optarg, (int) (endptr - optarg));
+              exit(1);
+            }
+        }
+        break;
+      case 'd':
+	verbose = TRUE;
+	break;
+      case 'q':
+	verbose = FALSE;
+	break;
+      case 'h':
+	usage (stdout, 0);
+      case 'V':
+	print_version ();
+	exit (0);
+      default:
+	fprintf (stderr, "Try `%s --help' for more information.\n",
+		 program_invocation_short_name);
+	exit (1);
+      }
+
+  if (argv && *(argv + optind) && *(argv + optind +1))
+    {
+      ssize_t len = cygwin_conv_path (CCP_POSIX_TO_WIN_A | CCP_RELATIVE,
+				      *(argv + optind), NULL, 0);
+      char *win32_name = (char *) alloca (len);
+      cygwin_conv_path (CCP_POSIX_TO_WIN_A | CCP_RELATIVE,  *(argv + optind),
+			win32_name, len);
+      if ((p = strrchr (win32_name, '\\')))
+	p++;
+      else
+	p = win32_name;
+
+      pid = strtoul (*(argv + optind + 1), NULL, 10);
+    }
+  else
+    {
+      usage (stderr, 1);
+      return -1;
+    }
+
+  char *minidump_file = (char *) malloc (strlen (p) + sizeof (".dmp"));
+  if (!minidump_file)
+    {
+      fprintf (stderr, "error allocating memory\n");
+      return -1;
+    }
+  sprintf (minidump_file, "%s.dmp", p);
+
+  if (verbose)
+    printf ("dumping process %u to %s using dump type flags 0x%x\n", (unsigned int)pid, minidump_file, (unsigned int)dump_type);
+
+  minidump(pid, dump_type, minidump_file);
+
+  free (minidump_file);
+
+  return 0;
+};
Index: utils/utils.xml
===================================================================
RCS file: /cvs/src/src/winsup/utils/utils.xml,v
retrieving revision 1.2
diff -u -u -p -r1.2 utils.xml
--- utils/utils.xml	10 May 2013 15:58:48 -0000	1.2
+++ utils/utils.xml	14 Jan 2014 00:01:13 -0000
@@ -833,6 +833,39 @@ bash$ locale noexpr
 
   </sect2>
 
+  <sect2 id="minidumper"><title>minidumper</title>
+
+  <screen>
+Usage: minidumper [OPTION] FILENAME WIN32PID
+
+Write minidump from WIN32PID to FILENAME.dmp
+
+-t, --type     minidump type flags
+-d, --verbose  be verbose while dumping
+-h, --help     output help information and exit
+-q, --quiet    be quiet while dumping (default)
+-V, --version  output version information and exit
+  </screen>
+
+  <para>
+    The <command>minidumper</command> utility can be used to create a
+    minidump of a running Windows process.  This minidump can be later
+    analysed using breakpad or Windows debugging tools.
+  </para>
+
+  <para>
+    <command>minidumper</command> can be used with cygwin's Just-In-Time
+    debugging facility in exactly the same way as <command>dumper</command>
+    (See <xref linkend="dumper"></xref>).
+  </para>
+
+  <para>
+    <command>minidumper</command> can also be started from the command line to
+    create a minidump of any running process.
+  </para>
+
+  </sect2>
+
   <sect2 id="mkgroup">
     <title>mkgroup</title>
 

--------------010802010507040804020607--
