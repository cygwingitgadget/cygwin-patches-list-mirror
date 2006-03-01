Return-Path: <cygwin-patches-return-5778-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4779 invoked by alias); 1 Mar 2006 19:14:06 -0000
Received: (qmail 4769 invoked by uid 22791); 1 Mar 2006 19:14:04 -0000
X-Spam-Check-By: sourceware.org
Received: from mailout10.sul.t-online.com (HELO mailout10.sul.t-online.com) (194.25.134.21)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Wed, 01 Mar 2006 19:14:01 +0000
Received: from fwd31.aul.t-online.de  	by mailout10.sul.t-online.com with smtp  	id 1FEWlp-0002ZZ-09; Wed, 01 Mar 2006 20:13:57 +0100
Received: from [10.3.2.2] (TlwISMZUgefcbIWaR4v0FKrajhZHsDT6XLIG-50-GQBwe+zbeScUYC@[80.137.119.225]) by fwd31.sul.t-online.de 	with esmtp id 1FEWlm-19ElY80; Wed, 1 Mar 2006 20:13:54 +0100
Message-ID: <4405F274.6080009@t-online.de>
Date: Wed, 01 Mar 2006 19:14:00 -0000
From: Christian Franke <Christian.Franke@t-online.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.1) Gecko/20060130 SeaMonkey/1.0
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: Re: [Patch] regtool: Add load/unload commands and --binary option
References: <43D6876F.9080608@t-online.de> <20060125105240.GM8318@calimero.vinschen.de> <43D7E666.8080803@t-online.de> <20060126091944.GT8318@calimero.vinschen.de> <20060211103418.GM14219@calimero.vinschen.de> <43F0E145.6080109@t-online.de> <20060215104302.GA13856@calimero.vinschen.de>
In-Reply-To: <20060215104302.GA13856@calimero.vinschen.de>
Content-Type: multipart/mixed;  boundary="------------080007020104040809040108"
X-ID: TlwISMZUgefcbIWaR4v0FKrajhZHsDT6XLIG-50-GQBwe+zbeScUYC
X-TOI-MSGID: 18e1de9f-8fa6-4a1b-8d82-c2a429477b6a
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q1/txt/msg00087.txt.bz2

This is a multi-part message in MIME format.
--------------080007020104040809040108
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 640

Attached is version 2 of the patch, including an update of utils.sgml

REG_BINARY can now be ether read as binary from stdin:

$ echo 0: 01 02 FE FF | xxd -r | regtool -b set KEY/BINVALUE -

$ regtool get KEY/BINVALUE | regtool -b set KEY/BINVALUE -

or specified as hex arguments:

$ regtool -b set KEY/BINVALUE 01 02 FE FF

$ x=$(regtool -b get KEY/BINVALUE)
$ regtool -b set KEY/BINVALUE $x


The load/unload actions are unchanged.

Christian

=====================

2006-03-01  Christian Franke <franke@computer.org>

        * regtool.cc: Add actions load/unload and option -b, --binary.
        * utils.sgml (regtool): Document it.



--------------080007020104040809040108
Content-Type: text/plain;
 name="regtool-load-patch-2.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="regtool-load-patch-2.txt"
Content-length: 7797

Index: regtool.cc
===================================================================
RCS file: /cvs/src/src/winsup/utils/regtool.cc,v
retrieving revision 1.19
diff -u -r1.19 regtool.cc
--- regtool.cc	15 Feb 2006 10:57:17 -0000	1.19
+++ regtool.cc	1 Mar 2006 18:35:01 -0000
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
+  " -b, --binary         set type to REG_BINARY (hex args or '-')\n"
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
@@ -510,6 +540,43 @@
 
   switch (key_type)
     {
+    case KT_BINARY:
+      for (n = 0; argv[n+1]; n++)
+        ;
+      if (n == 1 && strcmp (argv[1], "-") == 0)
+	{ /* read from stdin */
+	  i = n = 0;
+	  for (;;)
+	    {
+	      if (i <= n)
+		{
+		  i = n + BUFSIZ;
+		  data = (char *) realloc (data, i);
+		}
+	      int r = fread (data+n, 1, i-n, stdin);
+	      if (r <= 0)
+		break;
+	      n += r;
+	    }
+	}
+      else if (n > 0)
+	{ /* parse hex from argv */
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
@@ -542,6 +609,9 @@
       rv = ERROR_INVALID_CATEGORY;
       break;
     }
+ 
+  if (data)
+    free(data);
 
   if (rv != ERROR_SUCCESS)
     Fail (rv);
@@ -577,7 +647,14 @@
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
@@ -610,6 +687,31 @@
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
@@ -623,6 +725,8 @@
   {"set", cmd_set},
   {"unset", cmd_unset},
   {"get", cmd_get},
+  {"load", cmd_load},
+  {"unload", cmd_unload},
   {0, 0}
 };
 
@@ -642,6 +746,9 @@
   while ((g = getopt_long (argc, _argv, opts, longopts, NULL)) != EOF)
     switch (g)
 	{
+	case 'b':
+	  key_type = KT_BINARY;
+	  break;
 	case 'e':
 	  key_type = KT_EXPAND;
 	  break;
Index: utils.sgml
===================================================================
RCS file: /cvs/src/src/winsup/utils/utils.sgml,v
retrieving revision 1.58
diff -u -r1.58 utils.sgml
--- utils.sgml	16 Feb 2006 11:17:19 -0000	1.58
+++ utils.sgml	1 Mar 2006 18:35:09 -0000
@@ -1023,7 +1023,7 @@
 <sect2 id="regtool"><title>regtool</title>
 
 <screen>
-Usage: regtool.exe [OPTION] (add | check | get | list | remove | unset) KEY
+Usage: regtool [OPTION] (add|check|get|list|remove|unset|load|unload) KEY
 View or edit the Win32 registry
 
 Actions:
@@ -1034,13 +1034,19 @@
  remove KEY                 remove KEY
  set KEY\VALUE [data ...]   set VALUE
  unset KEY\VALUE            removes VALUE from KEY
+ load KEY\SUBKEY PATH       load hive from PATH into new SUBKEY
+ unload KEY\SUBKEY          unload hive and remove SUBKEY
 
 Options for 'list' Action:
  -k, --keys           print only KEYs
  -l, --list           print only VALUEs
  -p, --postfix        like ls -p, appends '\' postfix to KEY names
 
+Options for 'get' Action:
+ -b, --binary         print REG_BINARY data as hex bytes
+
 Options for 'set' Action:
+ -b, --binary         set type to REG_BINARY (hex args or '-')
  -e, --expand-string  set type to REG_EXPAND_SZ
  -i, --integer        set type to REG_DWORD
  -m, --multi-string   set type to REG_MULTI_SZ
@@ -1109,6 +1115,10 @@
 </para>
 
 <para>The <literal>set</literal> action sets a value within a key.
+<literal>-b</literal> means it's binary data (REG_BINARY).
+The binary values are specified as hex bytes in the argument list.
+If the argument is <literal>'-'</literal>, binary data is read
+from stdin instead.
 <literal>-e</literal> means it's an expanding string (REG_EXPAND_SZ)
 that contains embedded environment variables.  
 <literal>-i</literal> means the value is an integer (REG_DWORD).
@@ -1122,6 +1132,13 @@
 The <literal>unset</literal> action removes a value from a key.
 </para>
 
+<para>The <literal>load</literal> action adds a new subkey and loads
+the contents of a registry hive into it.
+The parent key must be HKEY_LOCAL_MACHINE or HKEY_USERS.
+The <literal>unload</literal> action unloads the file and removes
+the subkey.
+</para>
+
 <para>
 By default, the last "\" or "/" is assumed to be the separator between the
 key and the value.  You can use the <literal>-K</literal> option to provide 


--------------080007020104040809040108--
