Return-Path: <cygwin-patches-return-5542-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17684 invoked by alias); 20 Jun 2005 20:09:29 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 17125 invoked by uid 22791); 20 Jun 2005 20:08:52 -0000
Received: from dessent.net (HELO dessent.net) (66.17.244.20)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Mon, 20 Jun 2005 20:08:51 +0000
Received: from localhost ([127.0.0.1] helo=dessent.net)
	by dessent.net with esmtp (Exim 4.50)
	id 1DkSZT-0000yb-V4
	for cygwin-patches@cygwin.com; Mon, 20 Jun 2005 20:08:44 +0000
Message-ID: <42B7215D.309F67EE@dessent.net>
Date: Mon, 20 Jun 2005 20:09:00 -0000
From: Brian Dessent <brian@dessent.net>
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [patch] add -p option to cygcheck to query website package search
Content-Type: multipart/mixed;
 boundary="------------75027CE24370E1E181628DE4"
X-Spam-Report: -5.9/5.0 ---- Start SpamAssassin results 
	* -3.3 ALL_TRUSTED Did not pass through any untrusted hosts
	* -2.6 BAYES_00 BODY: Bayesian spam probability is 0 to 1%
	*      [score: 0.0000]
	*  0.0 AWL AWL: From: address is in the auto white-list
	---- End SpamAssassin results
X-Virus-Checked: Checked by ClamAV on sourceware.org
X-SW-Source: 2005-q2/txt/msg00138.txt.bz2

This is a multi-part message in MIME format.
--------------75027CE24370E1E181628DE4
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-length: 5705


Here is a patch that implements the -p option to cygcheck that was mentioned on
the list previously.  It uses the WinInet API to hit the package-grep.cgi URL on
cygwin.com with the search regexp supplied by the user.

Rather than trying to parse the html output or requiring cygcheck to depend on
awk or something, I instead modified the cgi script to recognise an additional
parameter named 'plain'.  If present in the request, the script replies with a
text/plain version of the results that cygcheck just copies to stdout.

Included in the patch is an update of the utils.sgml documentation for the new
parameter.  As I understand it the man pages are created from this part of the
user's guide, so that should kill two birds with one stone.

I also document the new switch in the --help output.  I took the liberty of
rewording it considerably, because the way that it described the options seemed
rather unintuitive -- there are certain combinations of allowed and unallowed
parameters, and rather than trying to explain for each switch which others it is
incompatible with, instead it gives a list of the acceptible forms of calling
the program.  Here is the output after this patch:

$ cygcheck -h      
Usage: cygcheck PROGRAM [ -v ] [ -h ]
       cygcheck -c [ PACKAGE ] [ -d ]
       cygcheck -s [ -r ] [ -v ] [ -h ]
       cygcheck -k
       cygcheck -f FILE [ FILE ... ]
       cygcheck -l [ PACKAGE ] [ PACKAGE ... ]
       cygcheck -p REGEXP
List system information, check installed packages, or query package database.

At least one command option or a PROGRAM is required, as shown above.

  PROGRAM              list library (DLL) dependencies of PROGRAM
  -c, --check-setup    show installed version of PACKAGE and verify integrity
                       (or for all installed packages if none specified)
  -d, --dump-only      just list packages, do not verify (with -c)
  -s, --sysinfo        produce diagnostic system information (implies -c -d)
  -r, --registry       also scan registry for Cygwin settings (with -s)
  -k, --keycheck       perform a keyboard check session (must be run from a
                       plain console only, not from a pty/rxvt/xterm)
  -f, --find-package   find the package that FILE belongs to
  -l, --list-package   list contents of PACKAGE (or all packages if none given)
  -p, --package-query  search for REGEXP in the entire cygwin.com package
                       repository (requies internet connectivity)
  -v, --verbose        produce more verbose output
  -h, --help           annotate output with explanatory comments when given
                       with another command, otherwise print this help
  -V, --version        print the version of cygcheck and exit

Note: -c, -f, and -l only report on packages that are currently installed. To
  search all official Cygwin packages use -p instead.  The -p REGEXP matches
  package names, descriptions, and names of files/paths within all packages.

The new --package-query command works more or less as you would expect. 
Whatever you supply after -p is passed along to the CGI as if you'd entered it
in the web form.  The only thing I changed was I omitted the directory name that
the package is in, so save a little bit of screen width.  Here is a sample:

$ cygcheck -p 'cygintl-2\.dll'
Found 1 matches for 'cygintl-2\.dll'.

libintl2-0.12.1-3         GNU Internationalization runtime library

$ cygcheck -p 'libexpat.*\.a'
Found 2 matches for 'libexpat.*\.a'.

expat-1.95.7-1            XML parser library written in C
expat-1.95.8-1            XML parser library written in C

$ cygcheck -p '/ls\.exe'
Found 2 matches for '/ls\.exe'.

coreutils-5.2.1-5         GNU core utilities (includes fileutils, sh-utils and
textutils)
coreutils-5.3.0-6         GNU core utilities (includes fileutils, sh-utils and
textutils)


There is an additional unrelated bugfix that I included with this patch.  The
bug was introduced with my patch to cygcheck that calls cygrunsrv.  It did not
properly null-terminate the buffer that was read from popen(), which would
result in the strtok() loop erroniously calling "cygrunsrv --query <garbage>"
after the last service.  This resulted in an occasional spurious cygrunsrv error
to stdout if you ran "cygcheck -s" without -v.  If the package-grep part of the
patch is not yet ready for primetime, I will resubmit just this fix by itself
since it's a pretty dumb bug.

I have tested the WinInet stuff on WinXP and Win98 and it seemed ok on both. 
MSDN claims that this API exists as far back as Win95 and only requires IE 3.0. 
I have tested the package-grep.cgi script locally.

In terms of error reporting cygcheck will emit an error if the HTTP response
code was not 200.  It will also emit an error (and call FormatMessage to get a
textual version) if there is a problem connecting or resolving the domain.

Brian

winsup/utils:
2005-06-20  Brian Dessent  <brian@dessent.net>

	* Makefile.in: Link cygcheck with libwininet.a.
	* cygcheck.cc: Add includes.
	(grep_packages): New global variable.
	(display_internet_error): New function.
	(dump_sysinfo_services): Ensure that 'buf' is NULL-terminated.
	(safe_chars): New global variable.
	(base_url): Ditto.
	(package_grep): New function.
	(usage): Reword --help output for clarity.  Document new argument.
	(longopts): Add 'package-query' option.
	(opts): Add 'p' option, reorder to be consistent with 'longopts'.
	(main): Accomodate new option.
	* utils.sgml (cygcheck): Update --help output.  Document new -p option.

htdocs/cgi-bin2:
2005-06-20  Brian Dessent  <brian@dessent.net>

	* package-grep.cgi (plain): New variable.
	Modify all output statements throughout to support a plain text output
	style.
--------------75027CE24370E1E181628DE4
Content-Type: text/plain; charset=us-ascii;
 name="cygcheck_pkg_grep.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygcheck_pkg_grep.patch"
Content-length: 17340

Index: Makefile.in
===================================================================
RCS file: /cvs/src/src/winsup/utils/Makefile.in,v
retrieving revision 1.57
diff -u -p -r1.57 Makefile.in
--- Makefile.in	21 Feb 2004 04:51:15 -0000	1.57
+++ Makefile.in	20 Jun 2005 18:58:14 -0000
@@ -99,15 +99,15 @@ else
 	$(CXX) $(MINGW_CXXFLAGS) -o $@ ${wordlist 1,2,$^} -B$(mingw_build)/ $(MINGW_LDFLAGS)
 endif
 
-cygcheck.exe: cygcheck.o path.o dump_setup.o $(MINGW_DEP_LDLIBS)
+cygcheck.exe: cygcheck.o path.o dump_setup.o $(MINGW_DEP_LDLIBS) $(w32api_lib)/libwininet.a
 ifeq "$(libz)" ""
 	@echo '*** Building cygcheck without package content checking due to missing mingw libz.a.'
 endif
 ifdef VERBOSE
-	$(CXX) $(MINGW_CXXFLAGS) -o $@ ${wordlist 1,3,$^} -B$(mingw_build)/ $(MINGW_LDFLAGS) $(libz)
+	$(CXX) $(MINGW_CXXFLAGS) -o $@ ${wordlist 1,3,$^} -B$(mingw_build)/ $(MINGW_LDFLAGS) $(libz) $(w32api_lib)/libwininet.a
 else
-	@echo $(CXX) -o $@ ${wordlist 1,3,$^} ${filter-out -B%, $(MINGW_CXXFLAGS) $(MINGW_LDFLAGS)} $(libz);\
-	$(CXX) $(MINGW_CXXFLAGS) -o $@ ${wordlist 1,3,$^} -B$(mingw_build)/ $(MINGW_LDFLAGS) $(libz)
+	@echo $(CXX) -o $@ ${wordlist 1,3,$^} ${filter-out -B%, $(MINGW_CXXFLAGS) $(MINGW_LDFLAGS)} $(libz) $(w32api_lib)/libwininet.a;\
+	$(CXX) $(MINGW_CXXFLAGS) -o $@ ${wordlist 1,3,$^} -B$(mingw_build)/ $(MINGW_LDFLAGS) $(libz) $(w32api_lib)/libwininet.a
 endif
 
 dumper.o: dumper.cc dumper.h
Index: cygcheck.cc
===================================================================
RCS file: /cvs/src/src/winsup/utils/cygcheck.cc,v
retrieving revision 1.74
diff -u -p -r1.74 cygcheck.cc
--- cygcheck.cc	30 May 2005 15:49:31 -0000	1.74
+++ cygcheck.cc	20 Jun 2005 18:58:17 -0000
@@ -11,11 +11,13 @@
 #define cygwin_internal cygwin_internal_dontuse
 #include <stdio.h>
 #include <stdlib.h>
+#include <stdarg.h>
 #include <string.h>
 #include <sys/time.h>
 #include <ctype.h>
 #include <io.h>
 #include <windows.h>
+#include <wininet.h>
 #include "path.h"
 #include <getopt.h>
 #include "cygwin/include/sys/cygwin.h"
@@ -33,6 +35,7 @@ int check_setup = 0;
 int dump_only = 0;
 int find_package = 0;
 int list_package = 0;
+int grep_packages = 0;
 
 #ifdef __GNUC__
 typedef long long longlong;
@@ -124,6 +127,39 @@ display_error (const char *name, bool sh
   return 1;
 }
 
+/* Display a WinInet error message, and close a variable number of handles.
+   (Passed a list of handles terminated by NULL.)  */
+static int
+display_internet_error (const char *message, ...)
+{
+  DWORD err = GetLastError ();
+  TCHAR err_buf[256];
+  va_list hptr;
+  HINTERNET h;
+
+  /* in the case of a successful connection but 404 response, there is no
+     win32 error message, but we still get passed a message to display.  */
+  if (err)
+    {
+      if (FormatMessage (FORMAT_MESSAGE_FROM_HMODULE,
+          GetModuleHandle ("wininet.dll"), err, 0, err_buf,
+          sizeof (err_buf), NULL) == 0)
+        strcpy (err_buf, "(Unknown error)");
+
+      fprintf (stderr, "cygcheck: %s: %s (win32 error %d)\n", message,
+               err_buf, err);
+    }
+  else
+    fprintf (stderr, "cygcheck: %s\n", message);
+
+  va_start (hptr, message);
+  while ((h = va_arg (hptr, HINTERNET)) != 0)
+    InternetCloseHandle (h);
+  va_end (hptr);
+
+  return 1;
+}
+
 static void
 add_path (char *s, int maxlen)
 {
@@ -919,7 +955,8 @@ dump_sysinfo_services ()
       printf ("Failed to execute '%s', skipping services check.\n", buf);
       return;
     }
-  size_t nchars = fread ((void *) buf, 1, sizeof (buf), f);
+  size_t nchars = fread ((void *) buf, 1, sizeof (buf) - 1, f);
+  buf[nchars] = 0;
   pclose (f);
 
   /* were any services found?  */
@@ -1474,24 +1511,122 @@ check_keys ()
   return 0;
 }
 
+/* RFC1738 says that these do not need to be escaped.  */
+static const char safe_chars[] = "$-_.+!*'(),";
+
+/* the URL to query.  */
+static const char base_url[] =
+        "http://cygwin.com/cgi-bin2/package-grep.cgi?plain=1&grep=";
+
+/* Queries Cygwin web site for packages containing files matching a regexp.
+   Return value is 1 if there was a problem, otherwise 0.  */
+static int
+package_grep (char *search)
+{
+  char buf[1024];
+
+  /* construct the actual URL by escaping  */
+  char *url = (char *) alloca (sizeof (base_url) + strlen (search) * 3);
+  strcpy (url, base_url);
+
+  char *dest;
+  for (dest = &url[sizeof (base_url) - 1]; *search; search++)
+    {
+      if (isalnum (*search)
+          || memchr (safe_chars, *search, sizeof (safe_chars) - 1))
+        {
+          *dest++ = *search;
+        }
+      else
+        {
+          *dest++ = '%';
+          sprintf (dest, "%02x", (unsigned char) *search);
+          dest += 2;
+        }
+    }
+  *dest = 0;
+
+  /* Connect to the net and open the URL.  */
+  if (InternetAttemptConnect (0) != ERROR_SUCCESS)
+    {
+      fputs ("An internet connection is required for this function.\n", stderr);
+      return 1;
+    }
+
+  /* Initialize WinInet and attempt to fetch our URL.  */
+  HINTERNET hi = NULL, hurl = NULL;
+  if (!(hi = InternetOpen ("cygcheck", INTERNET_OPEN_TYPE_PRECONFIG, NULL, NULL, 0)))
+    return display_internet_error ("InternetOpen() failed", NULL);
+
+  if (!(hurl = InternetOpenUrl (hi, url, NULL, 0, 0, 0)))
+    return display_internet_error ("unable to contact cygwin.com site, "
+                                   "InternetOpenUrl() failed", hi, NULL);
+
+  /* Check the HTTP response code.  */
+  DWORD rc = 0, rc_s = sizeof (DWORD);
+  if (!HttpQueryInfo (hurl, HTTP_QUERY_STATUS_CODE | HTTP_QUERY_FLAG_NUMBER,
+                      (void *) &rc, &rc_s, NULL))
+    return display_internet_error ("HttpQueryInfo() failed", hurl, hi, NULL);
+
+  if (rc != HTTP_STATUS_OK)
+    {
+      sprintf (buf, "error retrieving results from cygwin.com site, "
+                    "HTTP status code %lu", rc);
+      return display_internet_error (buf, hurl, hi, NULL);
+    }
+
+  /* Fetch result and print to stdout.  */
+  DWORD numread;
+  do
+    {
+      if (!InternetReadFile (hurl, (void *) buf, sizeof (buf), &numread))
+        return display_internet_error ("InternetReadFile failed", hurl, hi, NULL);
+      if (numread)
+        fwrite ((void *) buf, (size_t) numread, 1, stdout);
+    }
+  while (numread);
+
+  InternetCloseHandle (hurl);
+  InternetCloseHandle (hi);
+  return 0;
+}
+
 static void
 usage (FILE * stream, int status)
 {
   fprintf (stream, "\
-Usage: cygcheck [OPTIONS] [PROGRAM...]\n\
-Check system information or PROGRAM library dependencies\n\
+Usage: cygcheck PROGRAM [ -v ] [ -h ]\n\
+       cygcheck -c [ PACKAGE ] [ -d ]\n\
+       cygcheck -s [ -r ] [ -v ] [ -h ]\n\
+       cygcheck -k\n\
+       cygcheck -f FILE [ FILE ... ]\n\
+       cygcheck -l [ PACKAGE ] [ PACKAGE ... ]\n\
+       cygcheck -p REGEXP\n\
+List system information, check installed packages, or query package database.\n\
+\n\
+At least one command option or a PROGRAM is required, as shown above.\n\
+\n\
+  PROGRAM              list library (DLL) dependencies of PROGRAM\n\
+  -c, --check-setup    show installed version of PACKAGE and verify integrity\n\
+                       (or for all installed packages if none specified)\n\
+  -d, --dump-only      just list packages, do not verify (with -c)\n\
+  -s, --sysinfo        produce diagnostic system information (implies -c -d)\n\
+  -r, --registry       also scan registry for Cygwin settings (with -s)\n\
+  -k, --keycheck       perform a keyboard check session (must be run from a\n\
+                       plain console only, not from a pty/rxvt/xterm)\n\
+  -f, --find-package   find the package that FILE belongs to\n\
+  -l, --list-package   list contents of PACKAGE (or all packages if none given)\n\
+  -p, --package-query  search for REGEXP in the entire cygwin.com package\n\
+                       repository (requies internet connectivity)\n\
+  -v, --verbose        produce more verbose output\n\
+  -h, --help           annotate output with explanatory comments when given\n\
+                       with another command, otherwise print this help\n\
+  -V, --version        print the version of cygcheck and exit\n\
 \n\
- -c, --check-setup   check packages installed via setup.exe\n\
- -d, --dump-only     no integrity checking of package contents (requires -c)\n\
- -s, --sysinfo       system information (not with -k)\n\
- -v, --verbose       verbose output (indented) (for -[cfls] or programs)\n\
- -r, --registry      registry search (requires -s)\n\
- -k, --keycheck      perform a keyboard check session (not with -[scfl])\n\
- -f, --find-package  find installed packages containing files (not with -[cl])\n\
- -l, --list-package  list the contents of installed packages (not with -[cf])\n\
- -h, --help          give help about the info (not with -[cfl])\n\
- -V, --version       output version information and exit\n\
-You must at least give either -s or -k or a program name\n");
+Note: -c, -f, and -l only report on packages that are currently installed. To\n\
+  search all official Cygwin packages use -p instead.  The -p REGEXP matches\n\
+  package names, descriptions, and names of files/paths within all packages.\n\
+\n");
   exit (status);
 }
 
@@ -1504,12 +1639,13 @@ struct option longopts[] = {
   {"keycheck", no_argument, NULL, 'k'},
   {"find-package", no_argument, NULL, 'f'},
   {"list-package", no_argument, NULL, 'l'},
+  {"package-query", no_argument, NULL, 'p'},
   {"help", no_argument, NULL, 'h'},
   {"version", no_argument, 0, 'V'},
   {0, no_argument, NULL, 0}
 };
 
-static char opts[] = "cdfhklrsvV";
+static char opts[] = "cdsrvkflphV";
 
 static void
 print_version ()
@@ -1620,6 +1756,9 @@ main (int argc, char **argv)
       case 'l':
 	list_package = 1;
 	break;
+      case 'p':
+        grep_packages = 1;
+        break;
       case 'h':
 	givehelp = 1;
 	break;
@@ -1638,20 +1777,23 @@ main (int argc, char **argv)
     else
       usage (stderr, 1);
 
-  if ((check_setup || sysinfo || find_package || list_package) && keycheck)
+  if ((check_setup || sysinfo || find_package || list_package || grep_packages)
+      && keycheck)
     usage (stderr, 1);
 
-  if ((find_package || list_package) && check_setup)
+  if ((find_package || list_package || grep_packages) && check_setup)
     usage (stderr, 1);
 
   if (dump_only && !check_setup)
     usage (stderr, 1);
 
-  if (find_package && list_package)
+  if (find_package + list_package + grep_packages > 1)
     usage (stderr, 1);
 
   if (keycheck)
     return check_keys ();
+  if (grep_packages)
+    return package_grep (*argv);
 
   init_paths ();
 
Index: utils.sgml
===================================================================
RCS file: /cvs/src/src/winsup/utils/utils.sgml,v
retrieving revision 1.53
diff -u -p -r1.53 utils.sgml
--- utils.sgml	1 May 2005 15:50:02 -0000	1.53
+++ utils.sgml	20 Jun 2005 18:58:20 -0000
@@ -13,19 +13,37 @@ command-line utilities support the <lite
 <sect2 id="cygcheck"><title>cygcheck</title>
 
 <screen>
-Usage: cygcheck [OPTIONS] [PROGRAM...]
-Check system information or PROGRAM library dependencies
-
- -c, --check-setup   check packages installed via setup.exe
- -d, --dump-only     no integrity checking of package contents (requires -c)
- -s, --sysinfo       system information (not with -k)
- -v, --verbose       verbose output (indented) (for -[cfls] or programs)
- -r, --registry      registry search (requires -s)
- -k, --keycheck      perform a keyboard check session (not with -[scfl])
- -f, --find-package  find installed packages containing files (not with -[cl])
- -l, --list-package  list the contents of installed packages (not with -[cf])
- -h, --help          give help about the info (not with -[cfl])
- -V, --version       output version information and exit
+Usage: cygcheck PROGRAM [ -v ] [ -h ]
+       cygcheck -c [ PACKAGE ... ] [ -d ]
+       cygcheck -s [ -r ] [ -v ] [ -h ]
+       cygcheck -k
+       cygcheck -f FILE [ FILE ... ]
+       cygcheck -l [ PACKAGE ... ]
+       cygcheck -p REGEXP
+List system information, check installed packages, or query package database.
+
+At least one command option or a PROGRAM is required, as shown above.
+
+  PROGRAM              list library (DLL) dependencies of PROGRAM
+  -c, --check-setup    show installed version of PACKAGE and verify integrity
+                       (or for all installed packages if none specified)
+  -d, --dump-only      just list packages, do not verify (with -c)
+  -s, --sysinfo        produce diagnostic system information (implies -c -d)
+  -r, --registry       also scan registry for Cygwin settings (with -s)
+  -k, --keycheck       perform a keyboard check session (must be run from a
+                       plain console only, not from a pty/rxvt/xterm)
+  -f, --find-package   find the package that FILE belongs to
+  -l, --list-package   list contents of PACKAGE (or all packages if none given)
+  -p, --package-query  search for REGEXP in the entire cygwin.com package
+                       repository (requies internet connectivity)
+  -v, --verbose        produce more verbose output
+  -h, --help           annotate output with explanatory comments when given
+                       with another command, otherwise print this help
+  -V, --version        print the version of cygcheck and exit
+
+Note: -c, -f, and -l only report on packages that are currently installed. To
+  search all official Cygwin packages use -p instead.  The -p REGEXP matches
+  package names, descriptions, and names of files/paths within all packages.
 </screen>
 
 <para>
@@ -65,10 +83,10 @@ For example, to find out about <filename
 package:
 <example><title>Example <command>cygcheck</command> usage</title>
 <screen>
-$ cygcheck.exe -f /usr/bin/less
+$ cygcheck -f /usr/bin/less
 less-381-1
 
-$ cygcheck.exe -l less
+$ cygcheck -l less
 /usr/bin/less.exe
 /usr/bin/lessecho.exe
 /usr/bin/lesskey.exe
@@ -98,6 +116,65 @@ ones that have "Cygwin" in the name.  If
 privacy, you may remove information from this report, but please keep
 in mind that doing so makes it harder to diagnose your problems.</para>
 
+<para>In contrast to the other options that search the packages that are
+installed on your local system, the <literal>-p</literal> option can be used
+to search the entire official Cygwin package repository.  It takes as argument
+a Perl-compatible regular expression which is used to match package names, 
+package descriptions, and path/filenames of the contents of packages.  This
+feature requires an active internet connection, since it must query the
+<literal>cygwin.com</literal> web site.  In fact, it is equalivant to the
+search that is available on the <ulink url="http://cygwin.com/packages/">Cygwin
+package listing</ulink> page.</para>
+
+<para>For example, perhaps you are getting an error because you are missing a
+certain DLL and you want to know which package includes that file:
+<example><title>Searching all packages for a file</title>
+<screen>
+$ cygcheck -p 'cygintl-2\.dll'
+Found 1 matches for 'cygintl-2\.dll'.
+
+libintl2-0.12.1-3         GNU Internationalization runtime library
+
+$ cygcheck -p 'libexpat.*\.a'
+Found 2 matches for 'libexpat.*\.a'.
+
+expat-1.95.7-1            XML parser library written in C
+expat-1.95.8-1            XML parser library written in C
+
+$ cygcheck -p '/ls\.exe'
+Found 2 matches for '/ls\.exe'.
+
+coreutils-5.2.1-5         GNU core utilities (includes fileutils, sh-utils and textutils)
+coreutils-5.3.0-6         GNU core utilities (includes fileutils, sh-utils and textutils)
+</screen>
+</example>
+</para>
+
+<para>Note that this option takes a regular expression, not a glob or wildcard.
+This means that you need to use <literal>.*</literal> if you want something
+similar to the wildcard <literal>*</literal> commonly used in filename globbing.
+Similarly, to match the period character you should use <literal>\.</literal>
+since the <literal>.</literal> character in a regexp is a metacharacter that
+will match any character.  Also be aware that the characters such as 
+<literal>\</literal> and <literal>*</literal> are shell metacharacters, so 
+they must be either escaped or quoted, as in the example above.</para>
+
+<para>The third example above illustrates that if you want to match a whole 
+filename, you should include the <literal>/</literal> path seperator.  In the
+given example this ensures that filenames that happen to end in
+<literal>ls.exe</literal> such as <literal>ncftpls.exe</literal> are not shown.
+Note that this use does not mean "look for packages with <literal>ls</literal>
+in the root directory," since the <literal>/</literal> can match anywhere in the
+path.  It's just there to anchor the match so that it matches a full
+filename.</para>
+
+<para>By default the matching is case-sensitive.  To get a case insensitive
+match, begin your regexp with <literal>(?i)</literal> which is a PCRE-specific
+feature.  For complete documentation on Perl-compatible regular expression
+syntax and options, read the <command>perlre</command> manpage, or one of many
+websites such as <literal>perldoc.com</literal> that document the Perl
+language.</para>
+
 <para>The <command>cygcheck</command> program should be used to send
 information about your system for troubleshooting when requested.  
 When asked to run this command save the output so that you can email it,


--------------75027CE24370E1E181628DE4
Content-Type: text/plain; charset=us-ascii;
 name="package-grep.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="package-grep.patch"
Content-length: 3622

Index: package-grep.cgi
===================================================================
RCS file: /cvs/cygwin/htdocs/cgi-bin2/package-grep.cgi,v
retrieving revision 1.32
diff -u -p -r1.32 package-grep.cgi
--- package-grep.cgi	13 Jul 2004 01:16:23 -0000	1.32
+++ package-grep.cgi	20 Jun 2005 19:16:27 -0000
@@ -12,22 +12,33 @@ my $html = new CGI;
 
 # Get our data
 my $grep = $html->param('grep');
+my $plain = defined($html->param('plain'));
 
 $main::packages = ();
 $main::count = 0;
 use FindBin qw($Bin);
 
-print $html->header, "\n<html>\n<head>\n<title>Package List Search Results</title>\n</head>\n",
-      LWP::Simple::get('http://cygwin.com/cygwin-header.html'), "</td></table>\n",
-      "<table>\n",
-      $html->h1({-align=>'center'}, 'Cygwin Package List'), "\n";
+if (!$plain) {
+    print $html->header, "\n<html>\n<head>\n<title>Package List Search Results</title>\n</head>\n",
+          LWP::Simple::get('http://cygwin.com/cygwin-header.html'), "</td></table>\n",
+          "<table>\n",
+          $html->h1({-align=>'center'}, 'Cygwin Package List'), "\n";
+} else {
+    print $html->header(-type => 'text/plain');
+}          
 
 eval '"foo" =~ /$grep/o';
 if ($@ || $grep =~ m!\\.\\.!o) {
-    print $html->h3({-align=>'center'}, '*** Invalid regular expression search string: ', $grep);
-    print $html->h3({-align=>'center'}, '<a href="http://cygwin.com/packages/" align="center">Back</a>');
+    if (!$plain) {
+        print $html->h3({-align=>'center'}, '*** Invalid regular expression search string: ', $grep);
+        print $html->h3({-align=>'center'}, '<a href="http://cygwin.com/packages/" align="center">Back</a>');
+    } else {
+        print "*** Invalid regular expression search string: $grep\n";
+    }
 } else {
-    print $html->h2({-align=>'center'}, 'Search Results'), "\n";
+    if (!$plain) {
+        print $html->h2({-align=>'center'}, 'Search Results'), "\n";
+    }
     chdir("$Bin/../packages");
     for my $f (<*/*>) {
 	open(F, '<', $f) or next;
@@ -48,21 +59,32 @@ if ($@ || $grep =~ m!\\.\\.!o) {
 	close INDEX;
     }
 
-    print "Found <b>$main::count</b> matches for <b>$grep</b>.<br><br>\n";
+    if (!$plain) {
+        print "Found <b>$main::count</b> matches for <b>$grep</b>.<br><br>\n";
+    } else {
+        print "Found $main::count matches for \'$grep\'.\n\n";
+    }
     if (%main::packages) {
 	for my $p (sort keys %main::packages) {
 	    for my $f (@{$main::packages{$p}}) {
-		print '<tr><td><img src="http://sources.redhat.com/icons/ball.gray.gif" height=10 width=10 alt=""></td>',
-		       '<td cellspacing=10><a href="package-cat.cgi?file=' . uri_escape($f) . '&grep=' .
-		       uri_escape($grep) . '">' . $f . '</a></td><td align="left">' . findheader($p, $index) . "</td></tr>\n";
+		if (!$plain) {
+                    print '<tr><td><img src="http://sources.redhat.com/icons/ball.gray.gif" height=10 width=10 alt=""></td>',
+                           '<td cellspacing=10><a href="package-cat.cgi?file=' . uri_escape($f) . '&grep=' .
+                           uri_escape($grep) . '">' . $f . '</a></td><td align="left">' . findheader($p, $index) . "</td></tr>\n";
+                } else {
+                    printf("%-25s %s\n", substr($f, rindex($f, "/") + 1), findheader($p, $index));
+                }
 	    }
 	}
     }
 }
-print "</table>";
-open(FOOTER, '../cygwin-footer.html');
-print <FOOTER>, $html->end_html;
-close FOOTER;
+
+if (!$plain) {
+    print "</table>";
+    open(FOOTER, '../cygwin-footer.html');
+    print <FOOTER>, $html->end_html;
+    close FOOTER;
+}
 
 sub addfn($) {
     $main::count++;

--------------75027CE24370E1E181628DE4--

