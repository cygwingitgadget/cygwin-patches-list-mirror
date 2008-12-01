Return-Path: <cygwin-patches-return-6367-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23698 invoked by alias); 1 Dec 2008 19:24:37 -0000
Received: (qmail 23686 invoked by uid 22791); 1 Dec 2008 19:24:36 -0000
X-Spam-Check-By: sourceware.org
Received: from mailout01.t-online.de (HELO mailout01.t-online.de) (194.25.134.80)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 01 Dec 2008 19:23:49 +0000
Received: from fwd09.aul.t-online.de  	by mailout01.t-online.de with smtp  	id 1L7EMz-0000hg-08; Mon, 01 Dec 2008 20:23:45 +0100
Received: from [10.3.2.2] (S92KcyZAZhQGHvmcUwGZ8RLMGCV2lqEeE+BlA-6mHToczKH0FWuVr0PQlncy6PNwTF@[217.235.201.115]) by fwd09.aul.t-online.de 	with esmtp id 1L7EMs-2ANgqO0; Mon, 1 Dec 2008 20:23:38 +0100
Message-ID: <493439BA.8@t-online.de>
Date: Mon, 01 Dec 2008 19:24:00 -0000
From: Christian Franke <Christian.Franke@t-online.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.16) Gecko/20080702 SeaMonkey/1.1.11
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [Patch] Encode invalid chars in /proc/registry entries (merge from  1.5)
Content-Type: multipart/mixed;  boundary="------------030602080904050604060208"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q4/txt/msg00011.txt.bz2

This is a multi-part message in MIME format.
--------------030602080904050604060208
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 590

This is a 1.5->1.7 merge of my patch from 
http://sourceware.org/ml/cygwin-patches/2007-q4/msg00017.html

Christian


2008-12-01  Christian Franke  <franke@computer.org>

	* fhandler_registry.cc (must_encode): New function.
	(encode_regname): Ditto.
	(decode_regname): Ditto.
	(fhandler_registry::exists): Encode name before path compare.
	(fhandler_registry::fstat): Pass decoded name to win32 registry call.
	(fhandler_registry::readdir): Return encoded name to user.
	(fhandler_registry::open): Store decoded name into value_name.
	(open_key): Pass decoded name to win32 registry call



--------------030602080904050604060208
Content-Type: text/x-patch;
 name="cygwin-1.7-regnames-encode.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygwin-1.7-regnames-encode.patch"
Content-length: 4474

diff --git a/winsup/cygwin/fhandler_registry.cc b/winsup/cygwin/fhandler_registry.cc
index dcf46de..ce4335f 100644
--- a/winsup/cygwin/fhandler_registry.cc
+++ b/winsup/cygwin/fhandler_registry.cc
@@ -11,6 +11,7 @@ details. */
 /* FIXME: Access permissions are ignored at the moment.  */
 
 #include "winsup.h"
+#include <stdlib.h>
 #include "cygerrno.h"
 #include "security.h"
 #include "path.h"
@@ -79,6 +80,69 @@ static const char *DEFAULT_VALUE_NAME = "@";
 
 static HKEY open_key (const char *name, REGSAM access, DWORD wow64, bool isValue);
 
+/* Return true if char must be encoded.
+ */
+static inline bool
+must_encode (char c)
+{
+  return (isdirsep (c) || c == ':' || c == '%');
+}
+
+/* Encode special chars in registry key or value name.
+ */
+static int
+encode_regname (char * dst, const char * src)
+{
+  int di = 0;
+  for (int si = 0; src[si]; si++)
+    {
+      char c = src[si];
+      if (must_encode (c) ||
+	  (c == '.' && si == 0 && (!src[1] || (src[1] == '.' && !src[2]))))
+	{
+	  if (di + 3 >= NAME_MAX + 1)
+	    return ENAMETOOLONG;
+	  __small_sprintf (dst + di, "%%%02x", c);
+	  di += 3;
+	}
+      else
+	dst[di++] = c;
+    }
+  dst[di] = 0;
+  return 0;
+}
+
+/* Decode special chars in registry key or value name.
+ */
+static int
+decode_regname (char * dst, const char * src, int len = -1)
+{
+  if (len < 0)
+    len = strlen (src);
+  int di = 0;
+  for (int si = 0; si < len; si++)
+    {
+      char c = src[si];
+      if (c == '%')
+	{
+	  if (si + 2 >= len)
+	    return EINVAL;
+	  char s[] = {src[si+1], src[si+2], '\0'};
+	  char *p;
+	  c = strtoul (s, &p, 16);
+	  if (!(must_encode (c) ||
+	        (c == '.' && si == 0 && (len == 3 || (src[3] == '.' && len == 4)))))
+	    return EINVAL;
+	  dst[di++] = c;
+	  si += 2;
+	}
+      else
+	dst[di++] = c;
+    }
+  dst[di] = 0;
+  return 0;
+}
+
 /* Returns 0 if path doesn't exist, >0 if path is a directory,
  * <0 if path is a file.
  *
@@ -159,8 +223,9 @@ fhandler_registry::exists ()
 				    NULL, NULL))
 	     || (error == ERROR_MORE_DATA))
 	{
-	  if (strcasematch (buf, file)
-	      || (buf[0] == '\0' && strcasematch (file, DEFAULT_VALUE_NAME)))
+	  char enc_buf[NAME_MAX + 1];
+	  if (   (buf[0] == '\0' && strcasematch (file, DEFAULT_VALUE_NAME))
+	      || (!encode_regname (enc_buf, buf) && strcasematch (enc_buf, file)))
 	    {
 	      file_type = -1;
 	      goto out;
@@ -257,9 +322,11 @@ fhandler_registry::fstat (struct __stat64 *buf)
 		  while (!isdirsep (*value_name))
 		    value_name--;
 		  value_name++;
+		  char dec_value_name[NAME_MAX + 1];
 		  DWORD dwSize;
-		  if (ERROR_SUCCESS ==
-		      RegQueryValueEx (hKey, value_name, NULL, NULL, NULL,
+		  if (!decode_regname (dec_value_name, value_name) &&
+		      ERROR_SUCCESS ==
+		      RegQueryValueEx (hKey, dec_value_name, NULL, NULL, NULL,
 				       &dwSize))
 		    buf->st_size = dwSize;
 		}
@@ -360,8 +427,8 @@ retry:
   /* We get here if `buf' contains valid data.  */
   if (*buf == 0)
     strcpy (de->d_name, DEFAULT_VALUE_NAME);
-  else
-    strcpy (de->d_name, buf);
+  else if (encode_regname (de->d_name, buf))
+    goto retry;
 
   dir->__d_position++;
   if (dir->__d_position & REG_ENUM_VALUES_MASK)
@@ -505,6 +572,14 @@ fhandler_registry::open (int flags, mode_t mode)
       goto out;
     }
 
+  char dec_file[NAME_MAX + 1];
+  if (decode_regname (dec_file, file))
+    {
+      set_errno (EINVAL);
+      res = 0;
+      goto out;
+    }
+
   handle = open_key (path, KEY_READ, wow64, false);
   if (handle == (HKEY) INVALID_HANDLE_VALUE)
     {
@@ -520,10 +595,10 @@ fhandler_registry::open (int flags, mode_t mode)
 
   set_io_handle (handle);
 
-  if (strcasematch (file, DEFAULT_VALUE_NAME))
+  if (strcasematch (dec_file, DEFAULT_VALUE_NAME))
     value_name = cstrdup ("");
   else
-    value_name = cstrdup (file);
+    value_name = cstrdup (dec_file);
 
   if (!(flags & O_DIROPEN) && !fill_filebuf ())
     {
@@ -661,8 +736,14 @@ open_key (const char *name, REGSAM access, DWORD wow64, bool isValue)
       const char *anchor = name;
       while (*name && !isdirsep (*name))
 	name++;
-      strncpy (component, anchor, name - anchor);
-      component[name - anchor] = '\0';
+      if (decode_regname (component, anchor, name - anchor))
+        {
+	  set_errno (EINVAL);
+	  if (parentOpened)
+	    RegCloseKey (hParentKey);
+	  hKey = (HKEY) INVALID_HANDLE_VALUE;
+	  break;
+	}
       if (*name)
 	name++;
       if (*name == 0 && isValue == true)

--------------030602080904050604060208--
