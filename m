Return-Path: <cygwin-patches-return-3830-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16851 invoked by alias); 26 Apr 2003 20:40:39 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 16842 invoked from network); 26 Apr 2003 20:40:38 -0000
Date: Sat, 26 Apr 2003 20:40:00 -0000
From: Joshua Daniel Franklin <joshuadfranklin@yahoo.com>
To: cygwin-patches@cygwin.com
Subject: Add description to usage on some utils
Message-ID: <20030426204209.GA828@world-gov>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-SW-Source: 2003-q2/txt/msg00057.txt.bz2


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-length: 1207

I'd like permission to check in this patch which adds a short
description of the function of each util to the usage output.
A couple utils already have this, standardized the output where
necessary.

This is mainly to get a good way to create the .SH NAME section
for the man pages, though it's also in the GNU coreutils so is
some kind of standard. 

2003-04-26  Joshua Daniel Franklin <joshuadfranklin@yahoo.com>

        * cygcheck.cc (usage) Add description output.
        * cygpath.cc (usage) Add description output.
        * dumper.cc (usage) Add newline to description output.
        * kill.cc (usage) Add description output.
        * mkgroup.c (usage) Grammatical change to description output.
        * mkpasswd.c (usage) Grammatical change to description output.
        * mount.cc (usage) Add description output.
        * passwd.c (usage) Add description output.
        * ps.cc (usage) Add description output.
        * regtool.cc (usage) Add description output.
        * setfacl.c (usage) Remove extra newline from description output.
        * ssp.c (usage) Add description output.
        * strace.cc (usage) Add description output.
        * umount.cc (usage) Add description output.


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="utils-usage-desc.diff"
Content-length: 8930

Index: cygcheck.cc
===================================================================
RCS file: /cvs/src/src/winsup/utils/cygcheck.cc,v
retrieving revision 1.33
diff -u -p -r1.33 cygcheck.cc
--- cygcheck.cc	25 Mar 2003 01:20:04 -0000	1.33
+++ cygcheck.cc	26 Apr 2003 20:26:39 -0000
@@ -1314,7 +1314,9 @@ static void
 usage (FILE * stream, int status)
 {
   fprintf (stream, "\
-Usage: cygcheck [OPTIONS] [program ...]\n\
+Usage: cygcheck [OPTIONS] [PROGRAM...]\n\
+Check system information or PROGRAM library dependencies\n\
+\n\
  -c, --check-setup  check packages installed via setup.exe\n\
  -s, --sysinfo      system information (not with -k)\n\
  -v, --verbose      verbose output (indented) (for -s or programs)\n\
Index: cygpath.cc
===================================================================
RCS file: /cvs/src/src/winsup/utils/cygpath.cc,v
retrieving revision 1.26
diff -u -p -r1.26 cygpath.cc
--- cygpath.cc	12 Feb 2003 22:48:13 -0000	1.26
+++ cygpath.cc	26 Apr 2003 20:26:40 -0000
@@ -65,6 +65,8 @@ usage (FILE * stream, int status)
     fprintf (stream, "\
 Usage: %s (-d|-m|-u|-w|-t TYPE) [-c HANDLE] [-f FILE] [options] NAME\n\
        %s [-ADHPSW] \n\
+Convert Unix and Windows format paths, or output system path information\n\
+\n\ 
 Output type options:\n\
   -d, --dos	        print DOS (short) form of NAME (C:\\PROGRA~1\\)\n\
   -m, --mixed           like --windows, but with regular slashes (C:/WINNT)\n\
Index: dumper.cc
===================================================================
RCS file: /cvs/src/src/winsup/utils/dumper.cc,v
retrieving revision 1.9
diff -u -p -r1.9 dumper.cc
--- dumper.cc	8 May 2002 01:55:56 -0000	1.9
+++ dumper.cc	26 Apr 2003 20:26:41 -0000
@@ -777,6 +777,7 @@ usage (FILE *stream, int status)
   fprintf (stream, "\
 Usage: dumper [OPTION] FILENAME WIN32PID\n\
 Dump core from WIN32PID to FILENAME.core\n\
+\n\
  -d, --verbose  be verbose while dumping\n\
  -h, --help     output help information and exit\n\
  -q, --quiet    be quiet while dumping (default)\n\
Index: kill.cc
===================================================================
RCS file: /cvs/src/src/winsup/utils/kill.cc,v
retrieving revision 1.16
diff -u -p -r1.16 kill.cc
--- kill.cc	15 Sep 2002 19:24:36 -0000	1.16
+++ kill.cc	26 Apr 2003 20:26:41 -0000
@@ -41,6 +41,8 @@ usage (FILE *where = stderr)
   fprintf (where , ""
 	"Usage: %s [-f] [-signal] [-s signal] pid1 [pid2 ...]\n"
 	"       %s -l [signal]\n"
+	"Send signals to processes\n"
+	"\n"
 	" -f, --force     force, using win32 interface if necessary\n"
 	" -l, --list      print a list of signal names\n"
 	" -s, --signal    send signal (use %s --list for a list)\n"
Index: mkgroup.c
===================================================================
RCS file: /cvs/src/src/winsup/utils/mkgroup.c,v
retrieving revision 1.21
diff -u -p -r1.21 mkgroup.c
--- mkgroup.c	10 Apr 2003 01:14:18 -0000	1.21
+++ mkgroup.c	26 Apr 2003 20:26:42 -0000
@@ -481,8 +481,8 @@ current_group (int print_sids, int print
 int
 usage (FILE * stream, int isNT)
 {
-  fprintf (stream, "Usage: mkgroup [OPTION]... [domain]...\n\n"
-	           "This program prints a /etc/group file to stdout\n\n"
+  fprintf (stream, "Usage: mkgroup [OPTION]... [domain]...\n"
+	           "Print /etc/group file to stdout\n\n"
 	           "Options:\n");
   if (isNT)
     fprintf (stream, "   -l,--local             print local group information\n"
Index: mkpasswd.c
===================================================================
RCS file: /cvs/src/src/winsup/utils/mkpasswd.c,v
retrieving revision 1.30
diff -u -p -r1.30 mkpasswd.c
--- mkpasswd.c	10 Apr 2003 01:14:18 -0000	1.30
+++ mkpasswd.c	26 Apr 2003 20:26:43 -0000
@@ -485,7 +485,7 @@ int
 usage (FILE * stream, int isNT)
 {
   fprintf (stream, "Usage: mkpasswd [OPTION]... [domain]...\n\n"
-	           "This program prints a /etc/passwd file to stdout\n\n"
+	           "Print /etc/passwd file to stdout\n\n"
 	           "Options:\n");
   if (isNT)
     fprintf (stream, "   -l,--local              print local user accounts\n"
Index: mount.cc
===================================================================
RCS file: /cvs/src/src/winsup/utils/mount.cc,v
retrieving revision 1.28
diff -u -p -r1.28 mount.cc
--- mount.cc	19 Oct 2002 11:41:31 -0000	1.28
+++ mount.cc	26 Apr 2003 20:26:43 -0000
@@ -134,6 +134,8 @@ static void
 usage (FILE *where = stderr)
 {
   fprintf (where, "Usage: %s [OPTION] [<win32path> <posixpath>]\n\
+Display information about mounted filesystems, or mount a filesystem\n\
+\n\
   -b, --binary     (default)    text files are equivalent to binary files\n\
 				(newline = \\n)\n\
   -c, --change-cygdrive-prefix  change the cygdrive path prefix to <posixpath>\n\
Index: passwd.c
===================================================================
RCS file: /cvs/src/src/winsup/utils/passwd.c,v
retrieving revision 1.7
diff -u -p -r1.7 passwd.c
--- passwd.c	15 Sep 2002 19:24:36 -0000	1.7
+++ passwd.c	26 Apr 2003 20:26:44 -0000
@@ -243,6 +243,7 @@ usage (FILE * stream, int status)
   fprintf (stream, ""
   "Usage: %s (-l|-u|-S) [USER]\n"
   "       %s [-i NUM] [-n MINDAYS] [-x MAXDAYS] [-L LEN]\n"
+  "Change USER's password or password attributes\n"
   "\n"
   "User operations:\n"
   " -l, --lock      lock USER's account\n"
Index: ps.cc
===================================================================
RCS file: /cvs/src/src/winsup/utils/ps.cc,v
retrieving revision 1.16
diff -u -p -r1.16 ps.cc
--- ps.cc	15 Sep 2002 19:24:36 -0000	1.16
+++ ps.cc	26 Apr 2003 20:26:44 -0000
@@ -201,6 +201,8 @@ usage (FILE * stream, int status)
 {
   fprintf (stream, "\
 Usage: %s [-aefls] [-u UID]\n\
+Report process status\n\
+\n\
  -a, --all       show processes of all users\n\
  -e, --everyone  show processes of all users\n\
  -f, --full      show process uids, ppids\n\
Index: regtool.cc
===================================================================
RCS file: /cvs/src/src/winsup/utils/regtool.cc,v
retrieving revision 1.12
diff -u -p -r1.12 regtool.cc
--- regtool.cc	15 Sep 2002 19:24:36 -0000	1.12
+++ regtool.cc	26 Apr 2003 20:26:45 -0000
@@ -63,6 +63,7 @@ usage (FILE *where = stderr)
 {
   fprintf (where, ""
   "Usage: %s [OPTION] (add | check | get | list | remove | unset) KEY\n"
+  "View or edit the Win32 registry\n"
   "\n"
   "", prog_name);
   if (where == stdout)
Index: setfacl.c
===================================================================
RCS file: /cvs/src/src/winsup/utils/setfacl.c,v
retrieving revision 1.11
diff -u -p -r1.11 setfacl.c
--- setfacl.c	15 Jan 2003 10:08:37 -0000	1.11
+++ setfacl.c	26 Apr 2003 20:26:46 -0000
@@ -284,7 +284,6 @@ usage (FILE * stream)
   fprintf (stream, ""
             "Usage: %s [-r] (-f ACL_FILE | -s acl_entries) FILE...\n"
             "       %s [-r] ([-d acl_entries] [-m acl_entries]) FILE...\n"
-            "\n"
             "Modify file and directory access control lists (ACLs)\n"
             "\n"
             "  -d, --delete     delete one or more specified ACL entries\n"
Index: ssp.c
===================================================================
RCS file: /cvs/src/src/winsup/utils/ssp.c,v
retrieving revision 1.6
diff -u -p -r1.6 ssp.c
--- ssp.c	30 Sep 2002 03:01:17 -0000	1.6
+++ ssp.c	26 Apr 2003 20:26:47 -0000
@@ -648,6 +648,8 @@ usage (FILE * stream)
 {
   fprintf (stream , ""
   "Usage: %s [options] low_pc high_pc command...\n"
+  "Single-step profile COMMAND\n"
+  "\n"
   " -c, --console-trace  trace every EIP value to the console. *Lots* slower.\n"
   " -d, --disable        disable single-stepping by default; use\n"
   "                      OutputDebugString (\"ssp on\") to enable stepping\n"
Index: strace.cc
===================================================================
RCS file: /cvs/src/src/winsup/utils/strace.cc,v
retrieving revision 1.27
diff -u -p -r1.27 strace.cc
--- strace.cc	4 Mar 2003 05:30:50 -0000	1.27
+++ strace.cc	26 Apr 2003 20:26:48 -0000
@@ -800,6 +800,8 @@ usage (FILE *where = stderr)
   fprintf (where, "\
 Usage: %s [OPTIONS] <command-line>\n\
 Usage: %s [OPTIONS] -p <pid>\n\
+Trace system calls and signals\n\
+\n\
   -b, --buffer-size=SIZE       set size of output file buffer\n\
   -d, --no-delta               don't display the delta-t microsecond timestamp\n\
   -f, --trace-children         trace child processes (toggle - default true)\n\
Index: umount.cc
===================================================================
RCS file: /cvs/src/src/winsup/utils/umount.cc,v
retrieving revision 1.13
diff -u -p -r1.13 umount.cc
--- umount.cc	15 Sep 2002 19:24:37 -0000	1.13
+++ umount.cc	26 Apr 2003 20:26:48 -0000
@@ -44,6 +44,8 @@ usage (FILE *where = stderr)
 {
   fprintf (where, "\
 Usage: %s [OPTION] [<posixpath>]\n\
+Unmount filesystems\n\
+\n\
   -A, --remove-all-mounts       remove all mounts\n\
   -c, --remove-cygdrive-prefix  remove cygdrive prefix\n\
   -h, --help                    output usage information and exit\n\

--sm4nu43k4a2Rpi4c--
