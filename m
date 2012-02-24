Return-Path: <cygwin-patches-return-7600-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25197 invoked by alias); 24 Feb 2012 08:39:00 -0000
Received: (qmail 25019 invoked by uid 22791); 24 Feb 2012 08:38:58 -0000
X-SWARE-Spam-Status: No, hits=-2.4 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,TW_MK,TW_RG
X-Spam-Check-By: sourceware.org
Received: from mail-iy0-f171.google.com (HELO mail-iy0-f171.google.com) (209.85.210.171)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 24 Feb 2012 08:38:44 +0000
Received: by iaeh11 with SMTP id h11so3408321iae.2        for <cygwin-patches@cygwin.com>; Fri, 24 Feb 2012 00:38:43 -0800 (PST)
Received-SPF: pass (google.com: domain of yselkowitz@gmail.com designates 10.42.155.193 as permitted sender) client-ip=10.42.155.193;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of yselkowitz@gmail.com designates 10.42.155.193 as permitted sender) smtp.mail=yselkowitz@gmail.com; dkim=pass header.i=yselkowitz@gmail.com
Received: from mr.google.com ([10.42.155.193])        by 10.42.155.193 with SMTP id v1mr1244240icw.26.1330072723973 (num_hops = 1);        Fri, 24 Feb 2012 00:38:43 -0800 (PST)
Received: by 10.42.155.193 with SMTP id v1mr1015836icw.26.1330072723942;        Fri, 24 Feb 2012 00:38:43 -0800 (PST)
Received: from [192.168.0.100] (S0106000cf16f58b1.wp.shawcable.net. [24.79.200.150])        by mx.google.com with ESMTPS id ko6sm1142404igc.2.2012.02.24.00.38.42        (version=SSLv3 cipher=OTHER);        Fri, 24 Feb 2012 00:38:43 -0800 (PST)
Message-ID: <1330072720.7808.10.camel@YAAKOV04>
Subject: [PATCH] Add pldd(1)
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
To: cygwin-patches@cygwin.com
Date: Fri, 24 Feb 2012 08:39:00 -0000
Content-Type: multipart/mixed; boundary="=-//7Xz+HYUrDLbRF6Jtsq"
Mime-Version: 1.0
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2012-q1/txt/msg00023.txt.bz2


--=-//7Xz+HYUrDLbRF6Jtsq
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 192

The pldd(1) command apparently originates from Solaris and was added to
glibc-2.15[1].  Patches and new file attached.


Yaakov

[1] http://sourceware.org/git/?p=glibc.git;a=blob_plain;f=NEWS

--=-//7Xz+HYUrDLbRF6Jtsq
Content-Disposition: attachment; filename="pldd.c"
Content-Type: text/x-csrc; name="pldd.c"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 3725

/* pldd.cc

   Copyright 2012 Red Hat, Inc.

This file is part of Cygwin.

This software is a copyrighted work licensed under the terms of the
Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
details. */

#define WIN32_LEAN_AND_MEAN
#define UNICODE
#include <errno.h>
#include <error.h>
#include <getopt.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/cygwin.h>
#include <cygwin/version.h>
#include <windows.h>
#include <psapi.h>

struct option longopts[] =
{
  {"help", no_argument, NULL, '?'},
  {"version", no_argument, NULL, 'V'},
  {"usage", no_argument, NULL, 0},
  {0, no_argument, NULL, 0}
};
const char *opts = "?V";

__attribute__((noreturn))
static void
print_help (void)
{
  printf ("Usage: pldd [OPTION...] PID\n\n"
          "List dynamic shared objects loaded into a process.\n\n"
          "  -?, --help                 Give this help list\n"
          "      --usage                Give a short usage message\n"
          "  -V, --version              Print program version\n");
  exit (EXIT_SUCCESS);
}

__attribute__((noreturn))
static void
print_usage (void)
{
  printf ("Usage: pldd [-?V] [--help] [--usage] [--version] PID\n");
  exit (EXIT_SUCCESS);
}

__attribute__((noreturn))
static void
print_version ()
{
  printf ("pldd (cygwin) %d.%d.%d\n"
	  "List dynamic shared objects loaded into process.\n"
	  "Copyright (C) 2012 Red Hat, Inc.\n\n"
	  "This program comes with NO WARRANTY, to the extent permitted by law.\n"
	  "You may redistribute copies of this program under the terms of\n"
	  "the Cygwin license. Please consult the CYGWIN_LICENSE file for details.\n",
	  CYGWIN_VERSION_DLL_MAJOR / 1000,
	  CYGWIN_VERSION_DLL_MAJOR % 1000,
	  CYGWIN_VERSION_DLL_MINOR);
  exit (EXIT_SUCCESS);
}

__attribute__((noreturn))
static void
print_nargs (void)
{
  fprintf (stderr, "Exactly one parameter with process ID required.\n"
                   "Try `pldd --help' or `pldd --usage' for more information.\n");
  exit (EXIT_FAILURE);
}

int
main (int argc, char *argv[])
{
  int optch, pid, winpid, i;
  char *pidfile, *exefile, *exename;
  FILE *fd;
  HANDLE hProcess;
  HMODULE hModules[1024];
  DWORD cbModules;

  while ((optch = getopt_long (argc, argv, opts, longopts, &optind)) != -1)
    switch (optch)
      {
      case '?':
        print_help ();
        break;
      case 'V':
        print_version ();
        break;
      case 0:
        if (strcmp( "usage", longopts[optind].name ) == 0)
          print_usage ();
        break;
      default:
        break;
      }

  argc -= optind;
  argv += optind;
  if (argc != 1)
    print_nargs ();

  pid = atoi (argv[0]);

  if ((pid == 0))
    error (1, 0, "invalid process ID '%s'", argv[0]);

  pidfile = (char *) malloc (32);
  sprintf(pidfile, "/proc/%d/winpid", pid);
  fd = fopen (pidfile, "rb");
  if (!fd)
    error (1, ENOENT, "cannot open /proc/%d", pid);
  fscanf (fd, "%d", &winpid);

  exefile = (char *) malloc (32);
  exename = (char *) malloc (MAX_PATH);
  sprintf(exefile, "/proc/%d/exename", pid);
  fd = fopen (exefile, "rb");
  fscanf (fd, "%s", exename);

  hProcess = OpenProcess (PROCESS_QUERY_INFORMATION | PROCESS_VM_READ, 0, winpid);
  if (!hProcess)
    error (1, EPERM, "cannot attach to process %d", pid);

  printf ("%d:\t%s\n", pid, exename);

  EnumProcessModules (hProcess, hModules, sizeof(hModules), &cbModules);
  /* start at 1 to skip the executable itself */
  for (i = 1; i < (cbModules / sizeof(HMODULE)); i++)
    {
      TCHAR winname[MAX_PATH];
      char posixname[MAX_PATH];
      GetModuleFileNameEx (hProcess, hModules[i], winname, MAX_PATH);
      cygwin_conv_path (CCP_WIN_W_TO_POSIX, winname, posixname, MAX_PATH);
      printf ("%s\n", posixname);
    }

  return 0;
}

--=-//7Xz+HYUrDLbRF6Jtsq
Content-Disposition: attachment; filename="utils-pldd.patch"
Content-Type: text/x-patch; name="utils-pldd.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 2089

2012-02-??  Yaakov Selkowitz  <yselkowitz@...>

	* Makefile.in (CYGWIN_BINS): Add pldd.
	(pldd.exe): Add -lpsapi to ALL_LDFLAGS.
	* pldd.c: New file.
	* utils.sgml (pldd): New section.

Index: Makefile.in
===================================================================
RCS file: /cvs/src/src/winsup/utils/Makefile.in,v
retrieving revision 1.98
diff -u -p -r1.98 Makefile.in
--- Makefile.in	29 Jan 2012 09:41:06 -0000	1.98
+++ Makefile.in	24 Feb 2012 07:44:28 -0000
@@ -53,7 +53,7 @@ MINGW_CXX        := ${srcdir}/mingw ${CX
 # List all binaries to be linked in Cygwin mode.  Each binary on this list
 # must have a corresponding .o of the same name.
 CYGWIN_BINS := ${addsuffix .exe,cygpath getconf getfacl ldd locale kill mkgroup \
-        mkpasswd mount passwd ps regtool setfacl setmetamode ssp tzset umount}
+        mkpasswd mount passwd pldd ps regtool setfacl setmetamode ssp tzset umount}
 
 # List all binaries to be linked in MinGW mode.  Each binary on this list
 # must have a corresponding .o of the same name.
@@ -81,6 +81,7 @@ ps.exe: ALL_LDFLAGS += -lcygwin -lpsapi 
 strace.exe: MINGW_LDFLAGS += -lntdll
 
 ldd.exe: ALL_LDFLAGS += -lpsapi
+pldd.exe: ALL_LDFLAGS += -lpsapi
 
 ldh.exe: MINGW_LDLIBS :=
 ldh.exe: MINGW_LDFLAGS := -nostdlib -lkernel32
Index: utils.sgml
===================================================================
RCS file: /cvs/src/src/winsup/utils/utils.sgml,v
retrieving revision 1.99
diff -u -p -r1.99 utils.sgml
--- utils.sgml	4 Feb 2012 11:42:04 -0000	1.99
+++ utils.sgml	24 Feb 2012 07:44:28 -0000
@@ -1434,6 +1434,23 @@ some systems.</para>
 
 </sect2>
 
+<sect2 id="pldd"><title>pldd</title>
+
+<screen>
+Usage: pldd [OPTION...] PID
+
+List dynamic shared objects loaded into a process.
+
+  -?, --help                 Give this help list
+      --usage                Give a short usage message
+  -V, --version              Print program version
+</screen>
+
+<para><command>pldd</command> prints the shared libraries (DLLs) loaded
+by the process with the given PID.</para>
+
+</sect2>
+
 <sect2 id="ps"><title>ps</title>
 
 <screen>

--=-//7Xz+HYUrDLbRF6Jtsq
Content-Disposition: attachment; filename="doc-pldd.patch"
Content-Type: text/x-patch; name="doc-pldd.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 681

2012-02-??  Yaakov Selkowitz  <yselkowitz@...>

	* new-features.sgml (ov-new1.7.11): Document pldd.


Index: new-features.sgml
===================================================================
RCS file: /cvs/src/src/winsup/doc/new-features.sgml,v
retrieving revision 1.102
diff -u -p -r1.102 new-features.sgml
--- new-features.sgml	22 Feb 2012 02:06:15 -0000	1.102
+++ new-features.sgml	24 Feb 2012 08:27:09 -0000
@@ -5,6 +5,10 @@
 <itemizedlist mark="bullet">
 
 <listitem><para>
+New <command>pldd</command> command for listing DLLs loaded by a process.
+</para></listitem>
+
+<listitem><para>
 New API: pthread_getname_np, pthread_setname_np, scandirat.
 </para></listitem>
 

--=-//7Xz+HYUrDLbRF6Jtsq--
