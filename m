Return-Path: <cygwin-patches-return-6165-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7937 invoked by alias); 15 Nov 2007 21:57:07 -0000
Received: (qmail 7912 invoked by uid 22791); 15 Nov 2007 21:57:00 -0000
X-Spam-Check-By: sourceware.org
Received: from mailout06.sul.t-online.de (HELO mailout06.sul.t-online.com) (194.25.134.19)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 15 Nov 2007 21:56:57 +0000
Received: from fwd35.aul.t-online.de  	by mailout06.sul.t-online.com with smtp  	id 1Ismhh-0004qA-01; Thu, 15 Nov 2007 22:56:53 +0100
Received: from [10.3.2.2] (Jb64DUZ6ohzvLfWNZyCmP+rsTp2omKMoflaAabxvEUGCndRcf9frkLg6p0tvZ-sQs6@[217.235.204.198]) by fwd35.aul.t-online.de 	with esmtp id 1Ismhf-1WCcnA0; Thu, 15 Nov 2007 22:56:51 +0100
Message-ID: <473CC0A6.6010409@t-online.de>
Date: Thu, 15 Nov 2007 21:57:00 -0000
From: Christian Franke <Christian.Franke@t-online.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.6) Gecko/20070802 SeaMonkey/1.1.4
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: [Patch] Encode invalid chars in /proc/registry entries
Content-Type: multipart/mixed;  boundary="------------090307020500070302080200"
X-ID: Jb64DUZ6ohzvLfWNZyCmP+rsTp2omKMoflaAabxvEUGCndRcf9frkLg6p0tvZ-sQs6
X-TOI-MSGID: 955e4bfd-d19c-4360-bba5-51c49d37d05a
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q4/txt/msg00017.txt.bz2

This is a multi-part message in MIME format.
--------------090307020500070302080200
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 1651

Registry key and value names may contain chars which are not allowed 
within file names ('/', '\', ":"). But Cygwin's /proc/registry returns 
these names unchanged to the app. The obvious effect is that such 
entries cannot be accessed.

But if an entry name is identical to an existing path, more interesting 
results occur. Cygwin itself adds registry entries which are testcases 
for this issue :-))

An app that descends dirs by chdir() continues outside of /proc/registry 
and may finally re-enter /proc/registry:

$ find /proc/registry/HKEY_LOCAL_MACHINE/SOFTWARE/Cygnus Solutions/
/proc/registry/.../Cygnus Solutions/Cygwin/
/proc/registry/.../Cygnus Solutions/Cygwin/mounts v2
/proc/registry/.../Cygnus Solutions/Cygwin/mounts v2//
/proc/registry/.../Cygnus Solutions/Cygwin/mounts v2//bin
/proc/registry/.../Cygnus Solutions/Cygwin/mounts v2//bin/822-date
/proc/registry/.../Cygnus Solutions/Cygwin/mounts v2//bin/a2p.exe
/proc/registry/.../Cygnus Solutions/Cygwin/mounts v2//bin/aclocal-1.10
...
/proc/registry/.../Cygnus Solutions/Cygwin/mounts v2//bin/znew
...
/proc/registry/.../Cygnus Solutions/Cygwin/mounts v2//proc/registry/...


If an app descends by path concatenation (like ncdu), infinite recursion 
may occur if entry name is "/":

/proc/registry/.../Cygnus Solutions/Cygwin/mounts v2//
/proc/registry/.../Cygnus Solutions/Cygwin/mounts v2////
/proc/registry/.../Cygnus Solutions/Cygwin/mounts v2//////
...


The attached patch encodes the critical chars with %XX to avoid such 
problems.

Patch is tested with 1.5.24-2. Merge with HEAD looks good, but was not 
actually tested. Therefore, no changelog provided yet.

Christian


--------------090307020500070302080200
Content-Type: text/x-patch;
 name="cygwin-1.5.24-2-regnames-encode.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygwin-1.5.24-2-regnames-encode.patch"
Content-length: 4014

--- cygwin-1.5.24-2.orig/winsup/cygwin/fhandler_registry.cc	2006-01-27 22:50:40.001000000 +0100
+++ cygwin-1.5.24-2/winsup/cygwin/fhandler_registry.cc	2007-11-15 22:27:44.031250000 +0100
@@ -86,6 +86,67 @@ static const char *DEFAULT_VALUE_NAME = 
 
 static HKEY open_key (const char *name, REGSAM access, bool isValue);
 
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
+      if (must_encode (c))
+	{
+	  if (di + 3 >= CYG_MAX_PATH)
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
+	  if (!must_encode (c))
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
@@ -166,8 +227,9 @@ fhandler_registry::exists ()
 				    NULL, NULL))
 	     || (error == ERROR_MORE_DATA))
 	{
-	  if (pathmatch (buf, file) || (buf[0] == '\0' &&
-					pathmatch (file, DEFAULT_VALUE_NAME)))
+	  char enc_buf[CYG_MAX_PATH];
+	  if (   (buf[0] == '\0' && pathmatch (file, DEFAULT_VALUE_NAME))
+	      || (!encode_regname (enc_buf, buf) && pathmatch (enc_buf, file)))
 	    {
 	      file_type = -1;
 	      goto out;
@@ -246,9 +308,11 @@ fhandler_registry::fstat (struct __stat6
 		  while (!isdirsep (*value_name))
 		    value_name--;
 		  value_name++;
+		  char dec_value_name[CYG_MAX_PATH];
 		  DWORD dwSize;
-		  if (ERROR_SUCCESS ==
-		      RegQueryValueEx (hKey, value_name, NULL, NULL, NULL,
+		  if (!decode_regname (dec_value_name, value_name) &&
+		      ERROR_SUCCESS ==
+		      RegQueryValueEx (hKey, dec_value_name, NULL, NULL, NULL,
 				       &dwSize))
 		    buf->st_size = dwSize;
 		}
@@ -338,8 +402,8 @@ retry:
   /* We get here if `buf' contains valid data.  */
   if (*buf == 0)
     strcpy (de->d_name, DEFAULT_VALUE_NAME);
-  else
-    strcpy (de->d_name, buf);
+  else if (encode_regname (de->d_name, buf))
+    goto retry;
 
   dir->__d_position++;
   if (dir->__d_position & REG_ENUM_VALUES_MASK)
@@ -482,6 +546,14 @@ fhandler_registry::open (int flags, mode
       goto out;
     }
 
+  char dec_file[CYG_MAX_PATH];
+  if (decode_regname (dec_file, file))
+    {
+      set_errno (EINVAL);
+      res = 0;
+      goto out;
+    }
+
   handle = open_key (path, KEY_READ, false);
   if (handle == (HKEY) INVALID_HANDLE_VALUE)
     {
@@ -497,10 +569,10 @@ fhandler_registry::open (int flags, mode
 
   set_io_handle (handle);
 
-  if (pathmatch (file, DEFAULT_VALUE_NAME))
+  if (pathmatch (dec_file, DEFAULT_VALUE_NAME))
     value_name = cstrdup ("");
   else
-    value_name = cstrdup (file);
+    value_name = cstrdup (dec_file);
 
   if (!(flags & O_DIROPEN) && !fill_filebuf ())
     {
@@ -638,8 +710,14 @@ open_key (const char *name, REGSAM acces
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

--------------090307020500070302080200--
