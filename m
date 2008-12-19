Return-Path: <cygwin-patches-return-6396-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18926 invoked by alias); 19 Dec 2008 13:59:34 -0000
Received: (qmail 18914 invoked by uid 22791); 19 Dec 2008 13:59:32 -0000
X-SWARE-Spam-Status: No, hits=-1.7 required=5.0 	tests=AWL,BAYES_00
X-Spam-Check-By: sourceware.org
Received: from mailout04.t-online.de (HELO mailout04.t-online.de) (194.25.134.18)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 19 Dec 2008 13:58:55 +0000
Received: from fwd08.aul.t-online.de  	by mailout04.sul.t-online.de with smtp  	id 1LDfsR-0004cX-01; Fri, 19 Dec 2008 14:58:51 +0100
Received: from [10.3.2.2] (rXO+zsZX8hJhQpKzWkSLB0qPymfFO0Bi9q9Xxdxq-iq8vo5jglLXGNRW4IZct-WQhj@[217.235.254.73]) by fwd08.aul.t-online.de 	with esmtp id 1LDfsH-2BNptg0; Fri, 19 Dec 2008 14:58:41 +0100
Message-ID: <494BA890.8000004@t-online.de>
Date: Fri, 19 Dec 2008 13:59:00 -0000
From: Christian Franke <Christian.Franke@t-online.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.16) Gecko/20080702 SeaMonkey/1.1.11
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [Patch] Allow access to /proc/registry/HKEY_PERFORMANCE_DATA
Content-Type: multipart/mixed;  boundary="------------020902050001090904070401"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q4/txt/msg00040.txt.bz2

This is a multi-part message in MIME format.
--------------020902050001090904070401
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 1376

The command 'ls /proc/registry/HKEY_PERFORMANCE_DATA' returns garbage, 
because the registry functions don't work or work different for this 
(pseudo-)key.

This patch fixes the directory listing and allows access to the raw 
binary counter data, e.g.

All Global values, except "Costly" values:
xxd /proc/registry/HKEY_PERFORMANCE_DATA/Global

Prozessor time:
xxd /proc/registry/HKEY_PERFORMANCE_DATA/6

The directory listing is fixed, all lists of numbers are accepted as 
file names.
The actual counter numbers listed in the key
HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Perflib
are not considered yet.

2008-12-19  Christian Franke  <franke@computer.org>

	* fhandler_registry.cc (perf_data_files): New table.
	(PERF_DATA_FILE_COUNT): New constant.
	(fhandler_registry::exists): Add check for HKEY_PERFORMANCE_DATA
	value names.
	(fhandler_registry::fstat): For HKEY_PERFORMANCE_DATA, return
	default values only.
	(fhandler_registry::readdir): For HKEY_PERFORMANCE_DATA, list
	names from perf_data_files only.
	(fhandler_registry::fill_filebuf): Use larger buffer to speed up
	access to HKEY_PERFORMANCE_DATA values.  Remove check for possible
	subkey.  Add RegCloseKey ().
	(open_key): Replace goto by break, remove label.  Do not try to
	open subkey of HKEY_PERFORMANCE_DATA.  Add missing RegCloseKey ()
	after open subkey error.



Christian





--------------020902050001090904070401
Content-Type: text/x-diff;
 name="cygwin-1.7-registry-perfdata.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygwin-1.7-registry-perfdata.patch"
Content-length: 4813

diff --git a/winsup/cygwin/fhandler_registry.cc b/winsup/cygwin/fhandler_registry.cc
index 9efb2d1..c3c2264 100644
--- a/winsup/cygwin/fhandler_registry.cc
+++ b/winsup/cygwin/fhandler_registry.cc
@@ -75,6 +75,22 @@ static const char *special_dot_files[] =
 static const int SPECIAL_DOT_FILE_COUNT =
   (sizeof (special_dot_files) / sizeof (const char *)) - 1;
 
+/* Value names for HKEY_PERFORMANCE_DATA.
+ *
+ * CAUTION: Never call RegQueryValueEx (HKEY_PERFORMANCE_DATA, "Add", ...).
+ * It WRITES data and may destroy the perfc009.dat file.  Same applies to
+ * name prefixes "Ad" and "A".
+ */
+static const char * const perf_data_files[] =
+{
+  "@",
+  "Costly",
+  "Global"
+};
+
+static const int PERF_DATA_FILE_COUNT =
+  sizeof (perf_data_files) / sizeof (perf_data_files[0]);
+
 static HKEY open_key (const char *name, REGSAM access, DWORD wow64, bool isValue);
 
 /* Return true if char must be encoded.
@@ -273,6 +289,24 @@ fhandler_registry::exists ()
 	  if (hKey == (HKEY) INVALID_HANDLE_VALUE)
 	    return 0;
 
+	  if (hKey == HKEY_PERFORMANCE_DATA)
+	    {
+	      /* RegEnumValue () returns garbage for this key.
+	         RegQueryValueEx () returns a PERF_DATA_BLOCK even
+	         if a value does not contain any counter objects.
+	         So allow access to the generic names and to
+	         (blank separated) lists of counter numbers.
+	         Never allow access to "Add", see above comment.  */
+	      for (int i = 0; i < PERF_DATA_FILE_COUNT && file_type == 0; i++)
+		{
+		  if (strcasematch (perf_data_files[i], file))
+		    file_type = -1;
+		}
+	      if (file_type == 0 && !file[strspn (file, " 0123456789")])
+		file_type = -1;
+	      goto out;
+	    }
+
 	  if (!val_only && dec_file[0])
 	    {
 	      while (ERROR_SUCCESS ==
@@ -376,7 +410,11 @@ fhandler_registry::fstat (struct __stat64 *buf)
 	open_key (path, STANDARD_RIGHTS_READ | KEY_QUERY_VALUE, wow64,
 		  (file_type < 0) ? true : false);
 
-      if (hKey != (HKEY) INVALID_HANDLE_VALUE)
+      if (hKey == HKEY_PERFORMANCE_DATA)
+	/* RegQueryInfoKey () always returns write time 0,
+	   RegQueryValueEx () does not return required buffer size.  */
+	;
+      else if (hKey != (HKEY) INVALID_HANDLE_VALUE)
 	{
 	  FILETIME ftLastWriteTime;
 	  DWORD subkey_count;
@@ -474,6 +512,18 @@ fhandler_registry::readdir (DIR *dir, dirent *de)
       res = 0;
       goto out;
     }
+  if ((HKEY) dir->__handle == HKEY_PERFORMANCE_DATA)
+    {
+      /* RegEnumValue () returns garbage for this key,
+         simulate only a minimal listing of the generic names.  */
+      if (dir->__d_position >= SPECIAL_DOT_FILE_COUNT + PERF_DATA_FILE_COUNT)
+	goto out;
+      strcpy (de->d_name, perf_data_files[dir->__d_position - SPECIAL_DOT_FILE_COUNT]);
+      dir->__d_position++;
+      res = 0;
+      goto out;
+    }
+
 retry:
   if (dir->__d_position & REG_ENUM_VALUES_MASK)
     /* For the moment, the type of key is ignored here. when write access is added,
@@ -782,23 +832,21 @@ fhandler_registry::fill_filebuf ()
       bufalloc = 0;
       do
 	{
-	  bufalloc += 1000;
+	  bufalloc += 16 * 1024;
 	  filebuf = (char *) crealloc_abort (filebuf, bufalloc);
 	  size = bufalloc;
 	  error = RegQueryValueEx (handle, value_name, NULL, &type,
 				   (BYTE *) filebuf, &size);
 	  if (error != ERROR_SUCCESS && error != ERROR_MORE_DATA)
 	    {
-	      if (error != ERROR_FILE_NOT_FOUND)
-		{
-		  seterrno_from_win_error (__FILE__, __LINE__, error);
-		  return true;
-		}
-	      goto value_not_found;
+	      seterrno_from_win_error (__FILE__, __LINE__, error);
+	      return false;
 	    }
 	}
       while (error == ERROR_MORE_DATA);
       filesize = size;
+      /* RegQueryValueEx () opens HKEY_PERFORMANCE_DATA.  */
+      RegCloseKey (handle);
     }
   return true;
 value_not_found:
@@ -851,9 +899,9 @@ open_key (const char *name, REGSAM access, DWORD wow64, bool isValue)
       if (*name)
 	name++;
       if (*name == 0 && isValue == true)
-	goto out;
+	break;
 
-      if (val_only || !component[0])
+      if (val_only || !component[0] || hKey == HKEY_PERFORMANCE_DATA)
 	{
 	  set_errno (ENOENT);
 	  if (parentOpened)
@@ -874,14 +922,14 @@ open_key (const char *name, REGSAM access, DWORD wow64, bool isValue)
 				    REG_OPTION_BACKUP_RESTORE,
 				    effective_access | wow64, NULL,
 				    &hKey, NULL);
+	  if (parentOpened)
+	    RegCloseKey (hParentKey);
 	  if (error != ERROR_SUCCESS)
 	    {
 	      hKey = (HKEY) INVALID_HANDLE_VALUE;
 	      seterrno_from_win_error (__FILE__, __LINE__, error);
 	      return hKey;
 	    }
-	  if (parentOpened)
-	    RegCloseKey (hParentKey);
 	  hParentKey = hKey;
 	  parentOpened = true;
 	}
@@ -895,7 +943,6 @@ open_key (const char *name, REGSAM access, DWORD wow64, bool isValue)
 	  hParentKey = hKey;
 	}
     }
-out:
   return hKey;
 }
 

--------------020902050001090904070401--
