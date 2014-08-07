Return-Path: <cygwin-patches-return-8014-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1604 invoked by alias); 7 Aug 2014 20:15:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 1575 invoked by uid 89); 7 Aug 2014 20:15:36 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.4 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,RP_MATCHES_RCVD autolearn=ham version=3.3.2
X-HELO: mailout04.t-online.de
Received: from mailout04.t-online.de (HELO mailout04.t-online.de) (194.25.134.18) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Thu, 07 Aug 2014 20:15:34 +0000
Received: from fwd08.aul.t-online.de (fwd08.aul.t-online.de [172.20.26.151])	by mailout04.t-online.de (Postfix) with SMTP id DAF8840504C	for <cygwin-patches@cygwin.com>; Thu,  7 Aug 2014 22:15:30 +0200 (CEST)
Received: from [192.168.2.108] (ZedFEqZJYh4A-aYW3lDYgoE2pY0NIss39TufYLCl5xFHti6cVw5Rt4EqO2skVcwZAe@[84.180.77.139]) by fwd08.t-online.de	with (TLSv1.2:ECDHE-RSA-AES256-SHA encrypted)	esmtp id 1XFU5v-3FnyKm0; Thu, 7 Aug 2014 22:15:27 +0200
Message-ID: <53E3DE5D.10302@t-online.de>
Date: Thu, 07 Aug 2014 20:15:00 -0000
From: Christian Franke <Christian.Franke@t-online.de>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:29.0) Gecko/20100101 Firefox/29.0 SeaMonkey/2.26.1
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [PATCH] cygcheck -m, --check-mtimes option
Content-Type: multipart/mixed; boundary="------------060008030007000203090003"
X-IsSubscribed: yes
X-SW-Source: 2014-q3/txt/msg00009.txt.bz2

This is a multi-part message in MIME format.
--------------060008030007000203090003
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 553

Attached is an experimental patch which adds -m, 
--check-mtimes[=SECONDS] option to cygcheck. It provides an IMO useful 
heuristics to find files possibly modified after installation.

"cygcheck -c -m" prints the number of files with st_mtime > 
INSTALL_TIME+SECONDS. INSTALL_TIME is the st_mtime of the 
/etc/setup/PACKAGE.lst.gz file.

With -v, the affected path names are printed. The optional parameter 
SECONDS defaults to 600 to hide files modified by postinstall scripts.

Documentation update and changelog entry are still missing.

Christian


--------------060008030007000203090003
Content-Type: text/x-patch;
 name="cygcheck-mtime-option.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="cygcheck-mtime-option.patch"
Content-length: 7785

diff --git a/winsup/utils/cygcheck.cc b/winsup/utils/cygcheck.cc
index 465bc78..7a1b532 100644
--- a/winsup/utils/cygcheck.cc
+++ b/winsup/utils/cygcheck.cc
@@ -61,7 +61,7 @@ typedef __int64 longlong;
 #endif
 
 /* In dump_setup.cc  */
-void dump_setup (int, char **, bool);
+void dump_setup (int, char **, bool, int);
 void package_find (int, char **);
 void package_list (int, char **);
 /* In bloda.cc  */
@@ -2169,7 +2169,7 @@ usage (FILE * stream, int status)
 {
   fprintf (stream, "\
 Usage: cygcheck [-v] [-h] PROGRAM\n\
-       cygcheck -c [-d] [PACKAGE]\n\
+       cygcheck -c [-d] [-m] [PACKAGE]\n\
        cygcheck -s [-r] [-v] [-h]\n\
        cygcheck -k\n\
        cygcheck -f FILE [FILE]...\n\
@@ -2188,6 +2188,8 @@ At least one command option or a PROGRAM is required, as shown above.\n\
   -c, --check-setup    show installed version of PACKAGE and verify integrity\n\
 		       (or for all installed packages if none specified)\n\
   -d, --dump-only      just list packages, do not verify (with -c)\n\
+  -m, --check-mtimes[=SECONDS]\n\
+                       check for files newer than install time (with -c)\n\
   -s, --sysinfo        produce diagnostic system information (implies -c)\n\
   -r, --registry       also scan registry for Cygwin settings (with -s)\n\
   -k, --keycheck       perform a keyboard check session (must be run from a\n\
@@ -2224,6 +2226,7 @@ Note: -c, -f, and -l only report on packages that are currently installed. To\n\
 struct option longopts[] = {
   {"check-setup", no_argument, NULL, 'c'},
   {"dump-only", no_argument, NULL, 'd'},
+  {"check-mtimes", optional_argument, NULL, 'm'},
   {"sysinfo", no_argument, NULL, 's'},
   {"registry", no_argument, NULL, 'r'},
   {"verbose", no_argument, NULL, 'v'},
@@ -2240,7 +2243,7 @@ struct option longopts[] = {
   {0, no_argument, NULL, 0}
 };
 
-static char opts[] = "cdsrvkflphV";
+static char opts[] = "cdmsrvkflphV";
 
 static void
 print_version ()
@@ -2326,6 +2329,8 @@ main (int argc, char **argv)
   bool ok = true;
   load_cygwin (argc, argv);
 
+  int check_mtimes_offset = -1;
+
   /* Need POSIX sorting while parsing args, but don't forget the
      user's original environment.  */
   char *posixly = getenv ("POSIXLY_CORRECT");
@@ -2343,6 +2348,9 @@ main (int argc, char **argv)
       case 'd':
 	dump_only = 1;
 	break;
+      case 'm':
+	check_mtimes_offset = (optarg ? atoi(optarg) : 600);
+	break;
       case 'r':
 	registry = 1;
 	break;
@@ -2437,7 +2445,7 @@ main (int argc, char **argv)
     }
 
   if (check_setup)
-    dump_setup (verbose, argv, !dump_only);
+    dump_setup (verbose, argv, !dump_only, check_mtimes_offset);
   else if (find_package)
     package_find (verbose, argv);
   else if (list_package)
@@ -2456,7 +2464,7 @@ main (int argc, char **argv)
       if (!check_setup)
 	{
 	  puts ("");
-	  dump_setup (verbose, NULL, !dump_only);
+	  dump_setup (verbose, NULL, !dump_only, check_mtimes_offset);
 	}
 
       if (!givehelp)
diff --git a/winsup/utils/dump_setup.cc b/winsup/utils/dump_setup.cc
index 002c91d..0d3b2c5 100644
--- a/winsup/utils/dump_setup.cc
+++ b/winsup/utils/dump_setup.cc
@@ -25,6 +25,12 @@ details. */
 #include "path.h"
 #include <zlib.h>
 
+/* From ../cygwin/hires.h: */
+/* 100ns difference between Windows and UNIX timebase. */
+#define FACTOR (0x19db1ded53e8000LL)
+/* # of 100ns intervals per second. */
+#define NSPERSEC 10000000LL
+
 static int package_len = 20;
 static unsigned int version_len = 10;
 
@@ -297,6 +303,7 @@ simple_nt_stat (const char *filename, struct stat *st)
     {
       st->st_mode = (fbi.FileAttributes & FILE_ATTRIBUTE_DIRECTORY)
 		    ? S_IFDIR : S_IFREG;
+      st->st_mtime = (fbi.LastWriteTime.QuadPart - FACTOR) / NSPERSEC;
       return 0;
     }
   if (status == STATUS_OBJECT_PATH_NOT_FOUND
@@ -331,7 +338,7 @@ directory_exists (int verbose, char *filename, char *package)
 }
 
 static bool
-file_exists (int verbose, char *filename, const char *alt, char *package)
+file_exists (int verbose, char *filename, const char *alt, char *package, time_t *mtime = NULL)
 {
   struct stat status;
   if (simple_nt_stat(cygpath("/", filename, NULL), &status) &&
@@ -346,17 +353,27 @@ file_exists (int verbose, char *filename, const char *alt, char *package)
 	printf ("File type mismatch: /%s from package %s\n", filename, package);
       return false;
     }
+
+  if (mtime)
+    *mtime = status.st_mtime;
   return true;
 }
 
 static gzFile
-open_package_list (char *package)
+open_package_list (char *package, time_t *install_time = NULL)
 {
   char filelist[MAX_PATH + 1] = "/etc/setup/";
   strcat (strcat (filelist, package), ".lst.gz");
   if (!file_exists (false, filelist + 1, NULL, NULL))
     return NULL;
 
+  if (install_time)
+    {
+      struct stat status;
+      if (!simple_nt_stat (cygpath ("/", filelist, NULL), &status))
+         *install_time = status.st_mtime;
+    }
+
   gzFile fp;
 #ifndef ZLIB_VERSION
   fp = NULL;
@@ -370,9 +387,11 @@ open_package_list (char *package)
 }
 
 static bool
-check_package_files (int verbose, char *package)
+check_package_files (int verbose, char *package, int *newcnt, int check_mtimes_offset)
 {
-  gzFile fp = open_package_list (package);
+  time_t install_time = -1;
+  gzFile fp = open_package_list (package,
+		(check_mtimes_offset >= 0 ? &install_time : NULL));
   if (!fp)
     {
       if (verbose)
@@ -385,6 +404,7 @@ check_package_files (int verbose, char *package)
   while (gzgets (fp, buf, MAX_PATH))
     {
       char *filename = strtok(buf, "\n");
+      time_t mtime = -1;
 
       if (*filename == '/')
 	++filename;
@@ -398,14 +418,36 @@ check_package_files (int verbose, char *package)
 	}
       else if (!strncmp (filename, "etc/postinstall/", 16))
 	{
-	  if (!file_exists (verbose, filename, ".done", package))
+	  if (!file_exists (verbose, filename, ".done", package, &mtime))
 	    result = false;
 	}
       else
 	{
-	  if (!file_exists (verbose, filename, ".lnk", package))
+	  if (!file_exists (verbose, filename, ".lnk", package, &mtime))
 	    result = false;
 	}
+
+	if (check_mtimes_offset >= 0 && mtime > 0 && install_time > 0
+	    && mtime > install_time + check_mtimes_offset)
+	  {
+	    (*newcnt)++;
+
+	    if (verbose)
+	      {
+		int diff = (int)(mtime - install_time);
+		const char * unit;
+		if (diff < 60)
+		  unit = "second";
+		else if (diff < 60*60)
+		  diff /= 60, unit = "minute";
+		else if (diff < 60*60*24)
+		  diff /= 60*60, unit = "hour";
+		else
+		  diff /= 60*60*24, unit = "day";
+		printf ("Newer file: /%s from package %s (written %d %s%s after installation)\n",
+			filename, package, diff, unit, (diff == 1 ? "" : "s"));
+	      }
+	  }
     }
 
   gzclose (fp);
@@ -481,7 +523,7 @@ get_packages (char **argv)
 }
 
 void
-dump_setup (int verbose, char **argv, bool check_files)
+dump_setup (int verbose, char **argv, bool check_files, int check_mtimes_offset)
 {
   pkgver *packages = get_packages(argv);
 
@@ -505,10 +547,19 @@ dump_setup (int verbose, char **argv, bool check_files)
   for (int i = 0; packages[i].name; i++)
     {
       if (check_files)
-	printf ("%-*s %-*s%s\n", package_len, packages[i].name,
-		version_len, packages[i].ver,
-		check_package_files (verbose, packages[i].name)
-		  ? "     OK" : "     Incomplete");
+	{
+	  int newcnt = 0;
+	  bool ok = check_package_files (verbose, packages[i].name, &newcnt,
+					 check_mtimes_offset);
+
+	  char newmsg[32] = "";
+	  if (newcnt)
+	    snprintf (newmsg, sizeof(newmsg), "(%d newer)", newcnt);
+
+	  printf ("%-*s %-*s     %-*s%s\n", package_len, packages[i].name,
+		  version_len, packages[i].ver, (newmsg[0] ? 12 : 2),
+		  (ok ? "OK" : "Incomplete"), newmsg);
+        }
       else
 	printf ("%-*s %s\n", package_len, packages[i].name, packages[i].ver);
       fflush(stdout);


--------------060008030007000203090003--
