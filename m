Return-Path: <cygwin-patches-return-2790-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 32762 invoked by alias); 7 Aug 2002 18:28:25 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 32747 invoked from network); 7 Aug 2002 18:28:25 -0000
X-Authentication-Warning: slinky.cs.nyu.edu: pechtcha owned process doing -bs
Date: Wed, 07 Aug 2002 11:28:00 -0000
From: Igor Pechtchanski <pechtcha@cs.nyu.edu>
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
Subject: regtool support for custom key separators
Message-ID: <Pine.GSO.4.44.0208071426430.16431-100000@slinky.cs.nyu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2002-q3/txt/msg00238.txt.bz2

I'm re-sending this because the original message had BASE64 attachments.

Hi all,

The attached patch allows the users of regtool to specify a custom separator
between the key and the value for the 'set' and 'unset' actions.
E.g.
	regtool -K@ set "/HKLM/SOFTWARE/Cygnus Solutions/Cygwin/Program Options@c:\\\\cygwin\\\\bin\\\\ssh.exe" "tty export"

This is necessary for creating registry values with names containing a '\\'.
	Igor
-- 
				http://cs.nyu.edu/~pechtcha/
      |\      _,,,---,,_		pechtcha@cs.nyu.edu
ZZZzz /,`.-'`'    -.  ;-;;,_		igor@watson.ibm.com
     |,4-  ) )-,_. ,\ (  `'-'		Igor Pechtchanski
    '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!

It took the computational power of three Commodore 64s to fly to the moon.
It takes a 486 to run Windows 95.  Something is wrong here. -- SC sig file


2002-08-07  Igor Pechtchanski <pechtcha@cs.nyu.edu>

	* regtool.cc (find_key): Add support for custom key separator.
	(usage): Document it.


Index: utils/regtool.cc
===================================================================
RCS file: /cvs/src/src/winsup/utils/regtool.cc,v
retrieving revision 1.10
diff -u -p -2 -r1.10 regtool.cc
--- utils/regtool.cc	7 Jun 2002 11:12:16 -0000	1.10
+++ utils/regtool.cc	7 Aug 2002 16:53:46 -0000
@@ -15,4 +15,6 @@ details. */
 #include <windows.h>

+#define DEFAULT_KEY_SEPARATOR '\\'
+
 enum
 {
@@ -20,4 +22,6 @@ enum
 } key_type = KT_AUTO;

+char key_sep = DEFAULT_KEY_SEPARATOR;
+
 #define LIST_KEYS	0x01
 #define LIST_VALS	0x02
@@ -40,8 +44,9 @@ static struct option longopts[] =
   {"verbose", no_argument, NULL, 'v'},
   {"version", no_argument, NULL, 'V'},
+  {"key-separator", required_argument, NULL, 'K'},
   {NULL, 0, NULL, 0}
 };

-static char opts[] = "ehiklmpqsvV";
+static char opts[] = "ehiklmpqsvVK::";

 int listwhat = 0;
@@ -84,4 +89,7 @@ usage (FILE *where = stderr)
   " -s, --string         set type to REG_SZ\n"
   "\n"
+  "Options for 'set' and 'unset' Actions:\n"
+  " -K<c>, --key-separator[=]<c>  set key separator to <c> instead of '\\'\n"
+  "\n"
   "Other Options:\n"
   " -h, --help     output usage information and exit\n"
@@ -309,7 +317,7 @@ find_key (int howmanyparts, REGSAM acces
   if (howmanyparts > 1)
     {
-      while (n < e && *e != '\\')
+      while (n < e && *e != key_sep)
 	e--;
-      if (*e != '\\')
+      if (*e != key_sep)
 	{
 	  key = wkprefixes[i].key;
@@ -662,4 +670,7 @@ main (int argc, char **_argv)
 	  print_version ();
 	  exit (0);
+	case 'K':
+	  key_sep = *optarg;
+	  break;
 	default :
 	  usage ();
