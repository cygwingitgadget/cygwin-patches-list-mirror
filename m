Return-Path: <cygwin-patches-return-5782-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7143 invoked by alias); 2 Mar 2006 20:59:32 -0000
Received: (qmail 7124 invoked by uid 22791); 2 Mar 2006 20:59:30 -0000
X-Spam-Check-By: sourceware.org
Received: from mailout08.sul.t-online.com (HELO mailout08.sul.t-online.com) (194.25.134.20)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 02 Mar 2006 20:59:26 +0000
Received: from fwd28.aul.t-online.de  	by mailout08.sul.t-online.com with smtp  	id 1FEutP-000458-05; Thu, 02 Mar 2006 21:59:23 +0100
Received: from [10.3.2.2] (E68Go-ZSQerMqm08AIjYW-PawuhdVq1+r6UY7oImYrqujwyMPknrEF@[80.137.84.7]) by fwd28.sul.t-online.de 	with esmtp id 1FEutL-1YqEtM0; Thu, 2 Mar 2006 21:59:19 +0100
Message-ID: <44075CAA.8030009@t-online.de>
Date: Thu, 02 Mar 2006 20:59:00 -0000
From: Christian Franke <Christian.Franke@t-online.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.1) Gecko/20060130 SeaMonkey/1.0
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: Re: [Patch] regtool: Add load/unload commands and --binary option
References: <43D6876F.9080608@t-online.de> <20060125105240.GM8318@calimero.vinschen.de> <43D7E666.8080803@t-online.de> <20060126091944.GT8318@calimero.vinschen.de> <20060211103418.GM14219@calimero.vinschen.de> <43F0E145.6080109@t-online.de> <20060215104302.GA13856@calimero.vinschen.de> <4405F274.6080009@t-online.de> <20060301222502.GW3184@calimero.vinschen.de>
In-Reply-To: <20060301222502.GW3184@calimero.vinschen.de>
Content-Type: multipart/mixed;  boundary="------------040408000208070401090606"
X-ID: E68Go-ZSQerMqm08AIjYW-PawuhdVq1+r6UY7oImYrqujwyMPknrEF
X-TOI-MSGID: 60ac63ca-c5f0-4658-b743-9c032f433372
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q1/txt/msg00091.txt.bz2

This is a multi-part message in MIME format.
--------------040408000208070401090606
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 2052

Corinna Vinschen wrote:
> ...
>   
>>    //printf("key `%s' value `%s'\n", n, value);
>>     
>
> Why is this printf commented out?  If it's not needed, please remove.
>   

cvs annotate regtool.cc
...
1.1 (cgf      17-Feb-00):     }
1.1 (cgf      17-Feb-00):   //printf("key `%s' value `%s'\n", n, value);
1.1 (cgf      17-Feb-00): }

Doing code-janitor work on historic code was not the intent of my patch ;-)
Uncommenting this line during testing was helpful, so I left it untouched.


>> @@ -577,7 +647,14 @@
>>    switch (vtype)
>>      {
>>      case REG_BINARY:
>> -      fwrite (data, dsize, 1, stdout);
>> +      if (key_type == KT_BINARY)	// hack
>>     
>
> Hack?  Why hack?  Otherwise, please remove this comment.
>   

Because {re|mis}using "set" key_type for as a "get" option has been 
called a hack many years ago:

1.1 (cgf      17-Feb-00):     case REG_EXPAND_SZ:
1.3 (cgf      10-Jan-01):       if (key_type == KT_EXPAND)    // hack
1.1 (cgf      17-Feb-00):     {


Attached is a new version of the patch.
Thanks to your help regarding SE_BACKUP_NAME, the "save" action is now 
included.

Example: Backup system registry hives
(aka these ugly-forever-locked files in /windows/system32/config ;-)

#!/bin/sh
set -e
d="${1:-.}"

for k in SAM SECURITY SOFTWARE SYSTEM; do
  regtool save /HKLM/$k "$d/$k"
done
regtool save /HKU/.DEFAULT "$d/DEFAULT"
# End of script
####################

Hope the new features are helpful.

Christian


=====================

2006-03-02  Christian Franke <franke@computer.org>

       * regtool.cc (options): Add 'binary'.
         (usage): Document 'load|unload|save' and '-b'.
         (find_key): Add 'options' parameter, add load/unload.
         (cmd_set): Add KT_BINARY case.
         (cmd_get): Add hex output in KT_BINARY case.
         (cmd_load): New function.
         (cmd_unload): New function.
         (set_privilege): New function.
         (cmd_save): New function.
         (commands): Add load, unload and save.
         (main): Add '-b'
       * utils.sgml (regtool): Document it.



--------------040408000208070401090606
Content-Type: text/plain;
 name="regtool-load-save-patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="regtool-load-save-patch.txt"
Content-length: 10276

Index: regtool.cc
===================================================================
RCS file: /cvs/src/src/winsup/utils/regtool.cc,v
retrieving revision 1.19
diff -u -p -r1.19 regtool.cc
--- regtool.cc	15 Feb 2006 10:57:17 -0000	1.19
+++ regtool.cc	2 Mar 2006 20:46:24 -0000
@@ -10,15 +10,17 @@ details. */
 
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
@@ -32,6 +34,7 @@ static char *prog_name;
 
 static struct option longopts[] =
 {
+  {"binary", no_argument, NULL, 'b' },
   {"expand-string", no_argument, NULL, 'e' },
   {"help", no_argument, NULL, 'h' },
   {"integer", no_argument, NULL, 'i' },
@@ -47,7 +50,7 @@ static struct option longopts[] =
   {NULL, 0, NULL, 0}
 };
 
-static char opts[] = "ehiklmpqsvVK:";
+static char opts[] = "behiklmpqsvVK:";
 
 int listwhat = 0;
 int postfix = 0;
@@ -62,7 +65,7 @@ static void
 usage (FILE *where = stderr)
 {
   fprintf (where, ""
-  "Usage: %s [OPTION] (add | check | get | list | remove | unset) KEY\n"
+  "Usage: %s [OPTION] (add|check|get|list|remove|unset|load|unload|save) KEY\n"
   "View or edit the Win32 registry\n"
   "\n"
   "", prog_name);
@@ -76,6 +79,9 @@ usage (FILE *where = stderr)
     " remove KEY                 remove KEY\n"
     " set KEY\\VALUE [data ...]   set VALUE\n"
     " unset KEY\\VALUE            removes VALUE from KEY\n"
+    " load KEY\\SUBKEY PATH       load hive from PATH into new SUBKEY\n"
+    " unload KEY\\SUBKEY          unload hive and remove SUBKEY\n"
+    " save KEY\\SUBKEY PATH       save SUBKEY into new hive PATH\n"
     "\n");
   fprintf (where, ""
   "Options for 'list' Action:\n"
@@ -83,7 +89,11 @@ usage (FILE *where = stderr)
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
@@ -265,7 +275,7 @@ translate (char *key)
 }
 
 void
-find_key (int howmanyparts, REGSAM access)
+find_key (int howmanyparts, REGSAM access, int option = 0)
 {
   HKEY base;
   int rv;
@@ -348,9 +358,44 @@ find_key (int howmanyparts, REGSAM acces
     key = base;
   else
     {
-      rv = RegOpenKeyEx (base, n, 0, access, &key);
-      if (rv != ERROR_SUCCESS)
-	Fail (rv);
+      if (access)
+	{
+	  rv = RegOpenKeyEx (base, n, 0, access, &key);
+	  if (option && (rv == ERROR_SUCCESS || rv == ERROR_ACCESS_DENIED))
+	    {
+	      /* reopen with desired option due to missing option support in RegOpenKeyE */
+	      /* FIXME: may create the key in rare cases (e.g. access denied in parent) */
+	      HKEY key2;
+	      if (RegCreateKeyEx (base, n, 0, NULL, option, access, NULL, &key2, NULL)
+		  == ERROR_SUCCESS)
+	        {
+		  if (rv == ERROR_SUCCESS)
+		    RegCloseKey (key);
+		  key = key2;
+		  rv = ERROR_SUCCESS;
+	        }
+	    }
+	  if (rv != ERROR_SUCCESS)
+	    Fail (rv);
+	}
+      else if (argv[1])
+	{ 
+	  char win32_path[MAX_PATH];
+	  cygwin_conv_to_win32_path (argv[1], win32_path);
+	  rv = RegLoadKey (base, n, win32_path);
+	  if (rv != ERROR_SUCCESS)
+	    Fail (rv);
+	  if (verbose)
+	    printf ("key %s loaded from file %s\n", n, win32_path);
+	}
+      else
+	{ 
+	  rv = RegUnLoadKey (base, n);
+	  if (rv != ERROR_SUCCESS)
+	    Fail (rv);
+	  if (verbose)
+	    printf ("key %s unloaded\n", n);
+	}
     }
   //printf("key `%s' value `%s'\n", n, value);
 }
@@ -491,7 +536,7 @@ cmd_set ()
 {
   int i, n;
   DWORD v, rv;
-  char *a = argv[1], *data;
+  char *a = argv[1], *data = 0;
   find_key (2, KEY_ALL_ACCESS);
 
   if (key_type == KT_AUTO)
@@ -510,6 +555,43 @@ cmd_set ()
 
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
@@ -542,6 +624,9 @@ cmd_set ()
       rv = ERROR_INVALID_CATEGORY;
       break;
     }
+ 
+  if (data)
+    free(data);
 
   if (rv != ERROR_SUCCESS)
     Fail (rv);
@@ -577,7 +662,14 @@ cmd_get ()
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
@@ -610,6 +702,72 @@ cmd_get ()
   return 0;
 }
 
+int
+cmd_load ()
+{
+  if (!argv[1])
+    {
+      usage ();
+      return 1;
+    }
+  find_key (1, 0);
+  return 0;
+}
+
+int
+cmd_unload ()
+{
+  if (argv[1])
+    {
+      usage ();
+      return 1;
+    }
+  find_key (1, 0);
+  return 0;
+}
+
+DWORD
+set_privilege (const char * name)
+{
+  TOKEN_PRIVILEGES tp;
+  if (!LookupPrivilegeValue (NULL, name, &tp.Privileges[0].Luid))
+    return GetLastError ();
+  tp.PrivilegeCount = 1;
+  tp.Privileges[0].Attributes = SE_PRIVILEGE_ENABLED;
+  HANDLE t;
+  /* OpenProcessToken does not work here, because main thread has its own
+     impersonation token */
+  if (!OpenThreadToken (GetCurrentThread (), TOKEN_ADJUST_PRIVILEGES, FALSE, &t))
+    return GetLastError ();
+  AdjustTokenPrivileges (t, FALSE, &tp, 0, NULL, NULL);
+  DWORD rv = GetLastError ();
+  CloseHandle (t);
+  return rv;
+}
+
+int
+cmd_save ()
+{
+  if (!argv[1])
+    {
+      usage ();
+      return 1;
+    }
+  /* try to set SeBackupPrivilege, let RegSaveKey report the error */
+  set_privilege (SE_BACKUP_NAME);
+  /* REG_OPTION_BACKUP_RESTORE is necessary to save /HKLM/SECURITY */
+  find_key (1, KEY_QUERY_VALUE, REG_OPTION_BACKUP_RESTORE);
+  char win32_path[MAX_PATH];
+  cygwin_conv_to_win32_path (argv[1], win32_path);
+  DWORD rv = RegSaveKey (key, win32_path, NULL);
+  if (rv != ERROR_SUCCESS)
+    Fail (rv);
+  if (verbose)
+    printf ("key saved to %s\n", win32_path);
+  return 0;
+}
+
+
 struct
 {
   const char *name;
@@ -623,6 +781,9 @@ struct
   {"set", cmd_set},
   {"unset", cmd_unset},
   {"get", cmd_get},
+  {"load", cmd_load},
+  {"unload", cmd_unload},
+  {"save", cmd_save},
   {0, 0}
 };
 
@@ -642,6 +803,9 @@ main (int argc, char **_argv)
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
diff -u -p -r1.58 utils.sgml
--- utils.sgml	16 Feb 2006 11:17:19 -0000	1.58
+++ utils.sgml	2 Mar 2006 20:46:30 -0000
@@ -1023,7 +1023,7 @@ option.
 <sect2 id="regtool"><title>regtool</title>
 
 <screen>
-Usage: regtool.exe [OPTION] (add | check | get | list | remove | unset) KEY
+Usage: regtool [OPTION] (add|check|get|list|remove|unset|load|unload|save) KEY
 View or edit the Win32 registry
 
 Actions:
@@ -1034,13 +1034,20 @@ Actions:
  remove KEY                 remove KEY
  set KEY\VALUE [data ...]   set VALUE
  unset KEY\VALUE            removes VALUE from KEY
+ load KEY\SUBKEY PATH       load hive from PATH into new SUBKEY
+ unload KEY\SUBKEY          unload hive and remove SUBKEY
+ save KEY\SUBKEY PATH       save SUBKEY into new hive PATH
 
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
@@ -1109,6 +1116,10 @@ accidentally removing too much.  
 </para>
 
 <para>The <literal>set</literal> action sets a value within a key.
+<literal>-b</literal> means it's binary data (REG_BINARY).
+The binary values are specified as hex bytes in the argument list.
+If the argument is <literal>'-'</literal>, binary data is read
+from stdin instead.
 <literal>-e</literal> means it's an expanding string (REG_EXPAND_SZ)
 that contains embedded environment variables.  
 <literal>-i</literal> means the value is an integer (REG_DWORD).
@@ -1122,6 +1133,17 @@ a regular string.
 The <literal>unset</literal> action removes a value from a key.
 </para>
 
+<para>The <literal>load</literal> action adds a new subkey and loads
+the contents of a registry hive into it.
+The parent key must be HKEY_LOCAL_MACHINE or HKEY_USERS.
+The <literal>unload</literal> action unloads the file and removes
+the subkey.
+</para>
+
+<para>The <literal>save</literal> action saves a subkey into a
+registry hive.
+</para>
+
 <para>
 By default, the last "\" or "/" is assumed to be the separator between the
 key and the value.  You can use the <literal>-K</literal> option to provide 


--------------040408000208070401090606--
