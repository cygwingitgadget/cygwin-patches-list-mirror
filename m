From: Corinna Vinschen <corinna@vinschen.de>
To: cygpatch <cygwin-patches@sourceware.cygnus.com>
Subject: [RFA]: regtool.cc: "Permission denied" for normal users on NT/W2K
Date: Fri, 19 May 2000 06:00:00 -0000
Message-id: <39253ADA.3F50E194@vinschen.de>
X-SW-Source: 2000-q2/msg00066.html

Hi,

the following patch solves a problem in regtool. If eg.
admin has created a subkey of HKLM, that key has
"Full Control" permission only for Administrators and
SYSTEM and "Read" permission for all other users.

If a user of group "Users" now tries to read that key
with `regtool', s/he gets a "Permission denied", though.

Reason: `regtool' tries to open a key always with
KEY_ALL_ACCESS as desired access regardless of the
requested action. This results in the "Permission denied"
for unprivileged users as well in the case of eg. a

	regtool list /HKLM/...

If nobody has any objections, I will commit that
patch today.

Corinna


ChangeLog:
==========

	* regtool.cc (find_key): Add parameter `access'.
	Call `RegOpenKeyEx' with that desired access.
	(cmd_add, cmd_remove, cmd_set, cmd_unset): Call
	`find_key' with KEY_ALL_ACCESS access.
	(cmd_list, cmd_check, cmd_get): Call `find_key'
	with KEY_READ access.
Index: regtool.cc
===================================================================
RCS file: /cvs/src/src/winsup/utils/regtool.cc,v
retrieving revision 1.1.1.1
diff -u -p -r1.1.1.1 regtool.cc
--- regtool.cc	2000/02/17 19:38:31	1.1.1.1
+++ regtool.cc	2000/05/19 12:44:16
@@ -167,7 +167,7 @@ void translate(char *key)
 }
 
 void
-find_key(int howmanyparts)
+find_key(int howmanyparts, REGSAM access)
 {
   char *n = argv[0], *e, c;
   int i;
@@ -211,7 +211,7 @@ find_key(int howmanyparts)
       key = wkprefixes[i].key;
       return;
     }
-  int rv = RegOpenKeyEx(wkprefixes[i].key, n, 0, KEY_ALL_ACCESS, &key);
+  int rv = RegOpenKeyEx(wkprefixes[i].key, n, 0, access, &key);
   if (rv != ERROR_SUCCESS)
     Fail(rv);
   //printf("key `%s' value `%s'\n", n, value);
@@ -228,7 +228,7 @@ cmd_list()
   DWORD i, j, m, n, t;
   int v;
 
-  find_key(1);
+  find_key(1, KEY_READ);
   RegQueryInfoKey(key, 0, 0, 0, &num_subkeys, &maxsubkeylen, &maxclasslen,
 		  &num_values, &maxvalnamelen, &maxvaluelen, 0, 0);
 
@@ -302,7 +302,7 @@ cmd_list()
 int
 cmd_add()
 {
-  find_key(2);
+  find_key(2, KEY_ALL_ACCESS);
   HKEY newkey;
   DWORD newtype;
   int rv = RegCreateKeyEx(key, value, 0, (char *)"", REG_OPTION_NON_VOLATILE,
@@ -323,7 +323,7 @@ cmd_add()
 int
 cmd_remove()
 {
-  find_key(2);
+  find_key(2, KEY_ALL_ACCESS);
   DWORD rv = RegDeleteKey(key, value);
   if (rv != ERROR_SUCCESS)
     Fail(rv);
@@ -335,7 +335,7 @@ cmd_remove()
 int
 cmd_check()
 {
-  find_key(1);
+  find_key(1, KEY_READ);
   if (verbose)
     printf("key %s exists\n", argv[0]);
   return 0;
@@ -347,7 +347,7 @@ cmd_set()
   int i, n;
   DWORD v, rv;
   char *a = argv[1], *data;
-  find_key(2);
+  find_key(2, KEY_ALL_ACCESS);
 
   if (key_type == KT_AUTO)
     {
@@ -400,7 +400,7 @@ cmd_set()
 int
 cmd_unset()
 {
-  find_key(2);
+  find_key(2, KEY_ALL_ACCESS);
   DWORD rv = RegDeleteValue(key, value);
   if (rv != ERROR_SUCCESS)
     Fail(rv);
@@ -412,7 +412,7 @@ cmd_unset()
 int
 cmd_get()
 {
-  find_key(2);
+  find_key(2, KEY_READ);
   DWORD vtype, dsize, rv;
   char *data, *vd;
   rv = RegQueryValueEx(key, value, 0, &vtype, 0, &dsize);
