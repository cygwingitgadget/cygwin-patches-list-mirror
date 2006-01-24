Return-Path: <cygwin-patches-return-5719-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19824 invoked by alias); 24 Jan 2006 20:01:08 -0000
Received: (qmail 19813 invoked by uid 22791); 24 Jan 2006 20:01:06 -0000
X-Spam-Check-By: sourceware.org
Received: from mailout09.sul.t-online.com (HELO mailout09.sul.t-online.com) (194.25.134.84)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Tue, 24 Jan 2006 20:01:04 +0000
Received: from fwd34.aul.t-online.de  	by mailout09.sul.t-online.com with smtp  	id 1F1ULd-0005AW-00; Tue, 24 Jan 2006 21:01:01 +0100
Received: from [10.3.2.2] (GnzRhvZX8eSgdoR7mA53SU5SCnq3hI37AQJLSXk9L68k5zNdMv3SQ6@[80.137.104.253]) by fwd34.sul.t-online.de 	with esmtp id 1F1ULN-0JHLbE0; Tue, 24 Jan 2006 21:00:45 +0100
Message-ID: <43D6876F.9080608@t-online.de>
Date: Tue, 24 Jan 2006 20:01:00 -0000
From: Christian Franke <Christian.Franke@t-online.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8b) Gecko/20050217
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: [Patch] regtool: Add load/unload commands and --binary option
Content-Type: multipart/mixed;  boundary="------------090703090502000003070001"
X-ID: GnzRhvZX8eSgdoR7mA53SU5SCnq3hI37AQJLSXk9L68k5zNdMv3SQ6
X-TOI-MSGID: ca3c1894-bd57-4c69-bd4d-b33fb9258c4b
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q1/txt/msg00028.txt.bz2

This is a multi-part message in MIME format.
--------------090703090502000003070001
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 1438

Hi,

the attached patch adds commands "load" and "unload" and options "-b, 
--binary" to regtool.

Load a registry hive from PATH into new SUBKEY:

 regtool load KEY\SUBKEY PATH

Unload and remove SUBKEY later:

 regtool unload KEY\SUBKEY

Print REG_BINARY value as hex:

 regtool -b get KEY\VALUE

Set REG_BINARY value from hex args:

 regtool -b set KEY\VALUE XX XX XX XX ...


Example:
Suppose S:\ is a partition on a second HD which contains a copy of all 
files of XP system partition C:\.
The following script fixes the logical drive mappings of the backup 
installation.
This allows booting backup drive S:\ as C:\ after original C:\ drive has 
been removed.

#!/bin/sh
set -e

# Load backup SYSTEM hive as SYSTEM.TMP
regtool load /HKLM/SYSTEM.TMP /cygdrive/s/WINDOWS/system32/config/system
trap 'regtool unload /HKLM/SYSTEM.TMP' ERR

# Remove all logical drive mappings in backup
# (Somewhat tricky, because key value names contain backslashes)
for v in $(regtool list /HKLM/SYSTEM.TMP/MountedDevices |
          sed -n '/^\\DosDevices\\[C-Z]:$/s,\\,/,gp')
do
  regtool -K, unset "/HKLM/SYSTEM.TMP/MountedDevices,$v"
done

# Map current S:\ as C:\ in backup
m=$(regtool -K, -b get /HKLM/SYSTEM/MountedDevices/,/DosDevices/S:)
regtool -K, -b set /HKLM/SYSTEM.TMP/MountedDevices/,/DosDevices/C: $m

# Unload hive
trap '' ERR
regtool unload /HKLM/SYSTEM.TMP

# End of script
####################


Thanks for any comment

Christian


--------------090703090502000003070001
Content-Type: text/plain;
 name="regtool-load-patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="regtool-load-patch.txt"
Content-length: 4923

--- regtool.cc.orig	2005-09-12 01:48:05.001000000 +0200
+++ regtool.cc	2006-01-24 15:48:55.750000000 +0100
@@ -10,15 +10,17 @@
 
 #include <stdio.h>
 #include <stdlib.h>
+#include <errno.h>
 #include <ctype.h>
 #include <getopt.h>
 #include <windows.h>
+#include <sys/cygwin.h>
 
 #define DEFAULT_KEY_SEPARATOR '\\'
 
 enum
 {
-  KT_AUTO, KT_INT, KT_STRING, KT_EXPAND, KT_MULTI
+  KT_AUTO, KT_BINARY, KT_INT, KT_STRING, KT_EXPAND, KT_MULTI
 } key_type = KT_AUTO;
 
 char key_sep = DEFAULT_KEY_SEPARATOR;
@@ -32,6 +34,7 @@
 
 static struct option longopts[] =
 {
+  {"binary", no_argument, NULL, 'b' },
   {"expand-string", no_argument, NULL, 'e' },
   {"help", no_argument, NULL, 'h' },
   {"integer", no_argument, NULL, 'i' },
@@ -47,7 +50,7 @@
   {NULL, 0, NULL, 0}
 };
 
-static char opts[] = "ehiklmpqsvVK:";
+static char opts[] = "behiklmpqsvVK:";
 
 int listwhat = 0;
 int postfix = 0;
@@ -62,7 +65,7 @@
 usage (FILE *where = stderr)
 {
   fprintf (where, ""
-  "Usage: %s [OPTION] (add | check | get | list | remove | unset) KEY\n"
+  "Usage: %s [OPTION] (add|check|get|list|remove|unset|load|unload) KEY\n"
   "View or edit the Win32 registry\n"
   "\n"
   "", prog_name);
@@ -76,6 +79,8 @@
     " remove KEY                 remove KEY\n"
     " set KEY\\VALUE [data ...]   set VALUE\n"
     " unset KEY\\VALUE            removes VALUE from KEY\n"
+    " load KEY\\SUBKEY PATH       load hive from PATH into new SUBKEY\n"
+    " unload KEY\\SUBKEY          unload hive and remove SUBKEY\n"
     "\n");
   fprintf (where, ""
   "Options for 'list' Action:\n"
@@ -83,7 +88,11 @@
   " -l, --list           print only VALUEs\n"
   " -p, --postfix        like ls -p, appends '\\' postfix to KEY names\n"
   "\n"
+  "Options for 'get' Action:\n"
+  " -b, --binary         print REG_BINARY data as hex bytes\n"
+  "\n"
   "Options for 'set' Action:\n"
+  " -b, --binary         set type to REG_BINARY\n"
   " -e, --expand-string  set type to REG_EXPAND_SZ\n"
   " -i, --integer        set type to REG_DWORD\n"
   " -m, --multi-string   set type to REG_MULTI_SZ\n"
@@ -348,9 +357,30 @@
     key = base;
   else
     {
-      rv = RegOpenKeyEx (base, n, 0, access, &key);
-      if (rv != ERROR_SUCCESS)
-	Fail (rv);
+      if (access)
+	{ 
+	  rv = RegOpenKeyEx (base, n, 0, access, &key);
+	  if (rv != ERROR_SUCCESS)
+	    Fail (rv);
+	}
+      else if (argv[1])
+	{ 
+	  char win32_path[MAX_PATH];
+	  cygwin_conv_to_win32_path(argv[1], win32_path);
+	  rv = RegLoadKey(base, n, win32_path);
+	  if (rv != ERROR_SUCCESS)
+	    Fail (rv);
+	  if (verbose)
+	    printf("key %s loaded from file %s\n", n, win32_path);
+	}
+      else
+	{ 
+	  rv = RegUnLoadKey(base, n);
+	  if (rv != ERROR_SUCCESS)
+	    Fail (rv);
+	  if (verbose)
+	    printf("key %s unloaded\n", n);
+	}
     }
   //printf("key `%s' value `%s'\n", n, value);
 }
@@ -491,7 +521,7 @@
 {
   int i, n;
   DWORD v, rv;
-  char *a = argv[1], *data;
+  char *a = argv[1], *data = 0;
   find_key (2, KEY_ALL_ACCESS);
 
   if (key_type == KT_AUTO)
@@ -510,6 +540,27 @@
 
   switch (key_type)
     {
+    case KT_BINARY:
+      for (n = 0; argv[n+1]; n++)
+        ;
+      if (n > 0)
+	{
+	  data = (char *) malloc (n);
+	  for (i = 0; i < n; i++)
+	    {
+	      char *e;
+	      errno = 0;
+	      v = strtoul (argv[i+1], &e, 16);
+	      if (errno || v > 0xff || *e)
+		{
+		  fprintf (stderr, "Invalid hex constant `%s'\n", argv[i+1]);
+		  exit (1);
+		}
+	      data[i] = (char) v;
+	    }
+	}
+      rv = RegSetValueEx (key, value, 0, REG_BINARY, (const BYTE *) data, n);
+      break;
     case KT_INT:
       v = strtoul (a, 0, 0);
       rv = RegSetValueEx (key, value, 0, REG_DWORD, (const BYTE *) &v,
@@ -542,6 +593,9 @@
       rv = ERROR_INVALID_CATEGORY;
       break;
     }
+ 
+  if (data)
+    free(data);
 
   if (rv != ERROR_SUCCESS)
     Fail (rv);
@@ -577,7 +631,14 @@
   switch (vtype)
     {
     case REG_BINARY:
-      fwrite (data, dsize, 1, stdout);
+      if (key_type == KT_BINARY)	// hack
+	{
+	  for (unsigned i = 0; i < dsize; i++)
+	    printf ("%02x%c", (unsigned char)data[i],
+	      (i < dsize-1 ? ' ' : '\n'));
+	}
+      else
+ 	fwrite (data, dsize, 1, stdout);
       break;
     case REG_DWORD:
       printf ("%lu\n", *(DWORD *) data);
@@ -610,6 +671,31 @@
   return 0;
 }
 
+int
+cmd_load ()
+{
+  if (!argv[1])
+    {
+      usage();
+      return 1;
+    }
+  find_key(1, 0);
+  return 0;
+}
+
+int
+cmd_unload ()
+{
+  if (argv[1])
+    {
+      usage();
+      return 1;
+    }
+  find_key(1, 0);
+  return 0;
+}
+
+
 struct
 {
   const char *name;
@@ -623,6 +709,8 @@
   {"set", cmd_set},
   {"unset", cmd_unset},
   {"get", cmd_get},
+  {"load", cmd_load},
+  {"unload", cmd_unload},
   {0, 0}
 };
 
@@ -642,6 +730,9 @@
   while ((g = getopt_long (argc, _argv, opts, longopts, NULL)) != EOF)
     switch (g)
 	{
+	case 'b':
+	  key_type = KT_BINARY;
+	  break;
 	case 'e':
 	  key_type = KT_EXPAND;
 	  break;

--------------090703090502000003070001--
