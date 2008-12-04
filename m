Return-Path: <cygwin-patches-return-6371-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1195 invoked by alias); 4 Dec 2008 20:50:21 -0000
Received: (qmail 1179 invoked by uid 22791); 4 Dec 2008 20:50:20 -0000
X-Spam-Check-By: sourceware.org
Received: from mailout04.t-online.de (HELO mailout04.t-online.de) (194.25.134.18)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 04 Dec 2008 20:49:42 +0000
Received: from fwd07.aul.t-online.de  	by mailout04.sul.t-online.de with smtp  	id 1L8L8l-0002d8-01; Thu, 04 Dec 2008 21:49:39 +0100
Received: from [10.3.2.2] (bKXz8BZEYhomSdorMe+Pc5yjFcZaNDsM6PJj5DSn-Mu9XPxnnofPO6bvc1QtKqXgzG@[217.235.245.223]) by fwd07.aul.t-online.de 	with esmtp id 1L8L8R-2IdyxU0; Thu, 4 Dec 2008 21:49:19 +0100
Message-ID: <49384250.7080707@t-online.de>
Date: Thu, 04 Dec 2008 20:50:00 -0000
From: Christian Franke <Christian.Franke@t-online.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.16) Gecko/20080702 SeaMonkey/1.1.11
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [Patch] Avoid duplicate names in /proc/registry (which may crash  find)
Content-Type: multipart/mixed;  boundary="------------090709000908040104000000"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q4/txt/msg00015.txt.bz2

This is a multi-part message in MIME format.
--------------090709000908040104000000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 695

Here is a simple approach to handle the duplicate key/value name problem 
in /proc/registry. A value is skipped if key with same name exists. 
Number of actual key existence checks are reduced by a simple hash table.

The patch also adds dirent.d_type support, find does no longer crash.

Christian


2008-12-04  Christian Franke  <franke@computer.org>

	* fhandler_registry.cc (__DIR_hash): New class.
	(d_hash): New macro.
	(key_exists): New function.
	(fhandler_registry::readdir): Allocate __DIR_hash.
	Record key names in hash table. Skip value if key
	with same name exists. Fix error handling of
	encode_regname (). Set dirent.d_type.
	(fhandler_registry::closedir): Delete __DIR_hash.



--------------090709000908040104000000
Content-Type: text/x-patch;
 name="cygwin-1.7-registry-nodups.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygwin-1.7-registry-nodups.patch"
Content-length: 3526

diff --git a/winsup/cygwin/fhandler_registry.cc b/winsup/cygwin/fhandler_registry.cc
index ce4335f..4c95c77 100644
--- a/winsup/cygwin/fhandler_registry.cc
+++ b/winsup/cygwin/fhandler_registry.cc
@@ -143,6 +143,48 @@ decode_regname (char * dst, const char * src, int len = -1)
   return 0;
 }
 
+
+/* Hash table to limit calls to key_exists ().
+ */
+class __DIR_hash
+{
+public:
+  __DIR_hash ()
+    {
+      memset (table, 0, sizeof(table));
+    }
+
+  void set (unsigned h)
+    {
+      table [(h >> 3) & (HASH_SIZE - 1)] |= (1 << (h & 0x3));
+    }
+
+  bool is_set (unsigned h) const
+    {
+      return (table [(h >> 3) & (HASH_SIZE - 1)] & (1 << (h & 0x3))) != 0;
+    }
+
+private:
+  enum { HASH_SIZE = 1024 };
+  unsigned char table[HASH_SIZE];
+};
+
+#define d_hash(d)	((__DIR_hash *) (d)->__d_internal)
+
+
+/* Return true if subkey NAME exists in key PARENT.
+ */
+static bool
+key_exists (HKEY parent, const char * name, DWORD wow64)
+{
+  HKEY hKey = (HKEY) INVALID_HANDLE_VALUE;
+  LONG error = RegOpenKeyEx (parent, name, 0, KEY_READ | wow64, &hKey);
+  if (error == ERROR_SUCCESS)
+    RegCloseKey (hKey);
+
+  return (error == ERROR_SUCCESS || error == ERROR_ACCESS_DENIED);
+}
+
 /* Returns 0 if path doesn't exist, >0 if path is a directory,
  * <0 if path is a file.
  *
@@ -381,13 +423,16 @@ fhandler_registry::readdir (DIR *dir, dirent *de)
       res = 0;
       goto out;
     }
-  if (dir->__handle == INVALID_HANDLE_VALUE && dir->__d_position == 0)
+  if (dir->__handle == INVALID_HANDLE_VALUE)
     {
+      if (dir->__d_position != 0)
+	goto out;
       handle = open_key (path + 1, KEY_READ, wow64, false);
       dir->__handle = handle;
+      if (dir->__handle == INVALID_HANDLE_VALUE)
+	goto out;
+      dir->__d_internal = (unsigned) new __DIR_hash ();
     }
-  if (dir->__handle == INVALID_HANDLE_VALUE)
-    goto out;
   if (dir->__d_position < SPECIAL_DOT_FILE_COUNT)
     {
       strcpy (de->d_name, special_dot_files[dir->__d_position++]);
@@ -425,14 +470,37 @@ retry:
     }
 
   /* We get here if `buf' contains valid data.  */
+  dir->__d_position++;
+  if (dir->__d_position & REG_ENUM_VALUES_MASK)
+    dir->__d_position += 0x10000;
+
   if (*buf == 0)
     strcpy (de->d_name, DEFAULT_VALUE_NAME);
-  else if (encode_regname (de->d_name, buf))
-    goto retry;
+  else
+    {
+      /* Skip value if name is identical to a previous key name.  */
+      unsigned h = hash_path_name (1, buf);
+      if (! (dir->__d_position & REG_ENUM_VALUES_MASK))
+	d_hash (dir)->set (h);
+      else if (d_hash (dir)->is_set (h)
+	       && key_exists ((HKEY) dir->__handle, buf, wow64))
+	{
+	  buf_size = NAME_MAX + 1;
+	  goto retry;
+	}
+
+      if (encode_regname (de->d_name, buf))
+	{
+	  buf_size = NAME_MAX + 1;
+	  goto retry;
+	}
+    }
 
-  dir->__d_position++;
   if (dir->__d_position & REG_ENUM_VALUES_MASK)
-    dir->__d_position += 0x10000;
+    de->d_type = DT_REG;
+  else
+    de->d_type = DT_DIR;
+
   res = 0;
 out:
   syscall_printf ("%d = readdir (%p, %p)", res, dir, de);
@@ -473,11 +541,14 @@ int
 fhandler_registry::closedir (DIR * dir)
 {
   int res = 0;
-  if (dir->__handle != INVALID_HANDLE_VALUE &&
-      RegCloseKey ((HKEY) dir->__handle) != ERROR_SUCCESS)
+  if (dir->__handle != INVALID_HANDLE_VALUE)
     {
-      __seterrno ();
-      res = -1;
+      delete d_hash (dir);
+      if (RegCloseKey ((HKEY) dir->__handle) != ERROR_SUCCESS)
+	{
+	  __seterrno ();
+	  res = -1;
+	}
     }
   syscall_printf ("%d = closedir (%p)", res, dir);
   return 0;

--------------090709000908040104000000--
