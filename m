Return-Path: <cygwin-patches-return-6373-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17631 invoked by alias); 5 Dec 2008 22:24:42 -0000
Received: (qmail 17612 invoked by uid 22791); 5 Dec 2008 22:24:40 -0000
X-Spam-Check-By: sourceware.org
Received: from mailout10.t-online.de (HELO mailout10.t-online.de) (194.25.134.21)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 05 Dec 2008 22:24:01 +0000
Received: from fwd08.aul.t-online.de  	by mailout10.sul.t-online.de with smtp  	id 1L8j5Z-0000Vl-01; Fri, 05 Dec 2008 23:23:57 +0100
Received: from [10.3.2.2] (TltlPiZdQhIFiL4wXMn8WvN6dtPnDzAkIzXD+LRkuhA56dplmN8+82wlj-Yq0WEQPo@[217.235.220.126]) by fwd08.aul.t-online.de 	with esmtp id 1L8j5U-167SAS0; Fri, 5 Dec 2008 23:23:52 +0100
Message-ID: <4939A9F7.1000400@t-online.de>
Date: Fri, 05 Dec 2008 22:24:00 -0000
From: Christian Franke <Christian.Franke@t-online.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.16) Gecko/20080702 SeaMonkey/1.1.11
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Avoid duplicate names in /proc/registry (which may crash  find)
References: <49384250.7080707@t-online.de> <20081205095742.GP12905@calimero.vinschen.de>
In-Reply-To: <20081205095742.GP12905@calimero.vinschen.de>
Content-Type: multipart/mixed;  boundary="------------060807000803020000080408"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q4/txt/msg00017.txt.bz2

This is a multi-part message in MIME format.
--------------060807000803020000080408
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 2600

Corinna Vinschen wrote:
> On Dec  4 21:49, Christian Franke wrote:
>   
>> Here is a simple approach to handle the duplicate key/value name problem in 
>> /proc/registry. A value is skipped if key with same name exists. Number of 
>> actual key existence checks are reduced by a simple hash table.
>>
>> ...
>>     
>
> That looks like a quite neat idea to rectify this problem but, now that
> I think of it I'm wondering if this isn't a good starting point for
> a better solution as you proposed on the Cygwin list.
>
>   

Yes, it is ... see below.


> So let's assume there's a key and a value with the same name. 
>
> The old implementation just ignored the problem.  Trying to access the
> value failed because the value was simply shadowed by the key.  `cat
> foo' returned "is a directory" or something.
>
> The now proposed solution hides the value instead.  There just isn't a
> value of that name anymore.  In the end, the result is the same.
> Accessing the value still doesn't work.
>
>   

The hidden value also prevents that the key is scanned twice by find and ls.


> However, since these value were never accessible, doesn't that mean
> there is no backward compatibility problem if we actually change the
> name of the values instead to, say, foo.val?  That's what you proposed
> on the main list, right?
>
> Is the above line of thought correct?  If yes, together with your hash
> table it would be quite simle to implement this.  We would just have to
> think of a good value for ".val".  Unfortunately, there's no character
> disallowed in the registry names, not even a \0 :(
>
>   

Yes, and \0 is reportedly used at least by some copy protection software.


> Maybe ".val" is already a good suffix?
>
>   

I would prefer "%val" to avoid any extra encoding for names using 
".val". The "%" is already used as an escape char, so "%val" in a name 
would appear as "%25val"

With the attached patch, a duplicate name "foo" is handled as follows:

- readdir() returns the key as "foo" and the value as "foo%val".
- If the name is "foo%val", stat() and open() consider only the value "foo".

This keeps the names 'as is' if possible and allows access to the (very 
few) entries with duplicate names. The "%val" is at least somewhat 
self-explanatory.

Example:

$ ls -l 
/proc/registry/HKEY_LOCAL_MACHINE/SYSTEM/ControlSet001/Services/Eventlog/Security
...
dr--r-x--- 3 Administratoren SYSTEM   0 Mar 29  2005 Security
dr--r-x--- 3 Administratoren SYSTEM   0 Mar 29  2005 Security Account 
Manager
-r--r----- 1 Administratoren SYSTEM 168 Mar 29  2005 Security%val
...

Christian


--------------060807000803020000080408
Content-Type: text/x-patch;
 name="cygwin-1.7-registry-nodups-2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygwin-1.7-registry-nodups-2.patch"
Content-length: 8685

diff --git a/winsup/cygwin/fhandler_registry.cc b/winsup/cygwin/fhandler_registry.cc
index ce4335f..4efe48e 100644
--- a/winsup/cygwin/fhandler_registry.cc
+++ b/winsup/cygwin/fhandler_registry.cc
@@ -91,7 +91,7 @@ must_encode (char c)
 /* Encode special chars in registry key or value name.
  */
 static int
-encode_regname (char * dst, const char * src)
+encode_regname (char * dst, const char * src, bool add_val)
 {
   int di = 0;
   for (int si = 0; src[si]; si++)
@@ -108,31 +108,47 @@ encode_regname (char * dst, const char * src)
       else
 	dst[di++] = c;
     }
+
+  if (add_val)
+    {
+      if (di + 4 >= NAME_MAX + 1)
+	return ENAMETOOLONG;
+      memcpy (dst + di, "%val", 4);
+      di += 4;
+    }
+
   dst[di] = 0;
   return 0;
 }
 
 /* Decode special chars in registry key or value name.
+ * Returns 0: success, 1: "%val" detected, -1: error.
  */
 static int
 decode_regname (char * dst, const char * src, int len = -1)
 {
   if (len < 0)
     len = strlen (src);
+  int res = 0;
   int di = 0;
   for (int si = 0; si < len; si++)
     {
       char c = src[si];
       if (c == '%')
 	{
+	  if (si + 4 == len && !memcmp (src + si, "%val", 4))
+	    {
+	      res = 1;
+	      break;
+	    }
 	  if (si + 2 >= len)
-	    return EINVAL;
+	    return -1;
 	  char s[] = {src[si+1], src[si+2], '\0'};
 	  char *p;
 	  c = strtoul (s, &p, 16);
 	  if (!(must_encode (c) ||
 	        (c == '.' && si == 0 && (len == 3 || (src[3] == '.' && len == 4)))))
-	    return EINVAL;
+	    return -1;
 	  dst[di++] = c;
 	  si += 2;
 	}
@@ -140,7 +156,49 @@ decode_regname (char * dst, const char * src, int len = -1)
 	dst[di++] = c;
     }
   dst[di] = 0;
-  return 0;
+  return res;
+}
+
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
 }
 
 /* Returns 0 if path doesn't exist, >0 if path is a directory,
@@ -190,7 +248,13 @@ fhandler_registry::exists ()
       goto out;
     }
 
-  hKey = open_key (path, KEY_READ, wow64, false);
+  char dec_file[NAME_MAX + 1];
+  int val_only = decode_regname (dec_file, file);
+  if (val_only < 0)
+    goto out;
+
+  if (!val_only)
+    hKey = open_key (path, KEY_READ, wow64, false);
   if (hKey != (HKEY) INVALID_HANDLE_VALUE)
     file_type = 1;
   else
@@ -199,33 +263,36 @@ fhandler_registry::exists ()
       if (hKey == (HKEY) INVALID_HANDLE_VALUE)
 	return 0;
 
-      while (ERROR_SUCCESS ==
-	     (error = RegEnumKeyEx (hKey, index++, buf, &buf_size, NULL, NULL,
-				     NULL, NULL))
-	     || (error == ERROR_MORE_DATA))
+      if (!val_only)
 	{
-	  if (strcasematch (buf, file))
+	  while (ERROR_SUCCESS ==
+		 (error = RegEnumKeyEx (hKey, index++, buf, &buf_size,
+					NULL, NULL, NULL, NULL))
+		 || (error == ERROR_MORE_DATA))
+	    {
+	      if (strcasematch (buf, dec_file))
+		{
+		  file_type = 1;
+		  goto out;
+		}
+		buf_size = NAME_MAX + 1;
+	    }
+	  if (error != ERROR_NO_MORE_ITEMS)
 	    {
-	      file_type = 1;
+	      seterrno_from_win_error (__FILE__, __LINE__, error);
 	      goto out;
 	    }
+	  index = 0;
 	  buf_size = NAME_MAX + 1;
 	}
-      if (error != ERROR_NO_MORE_ITEMS)
-	{
-	  seterrno_from_win_error (__FILE__, __LINE__, error);
-	  goto out;
-	}
-      index = 0;
-      buf_size = NAME_MAX + 1;
+
       while (ERROR_SUCCESS ==
 	     (error = RegEnumValue (hKey, index++, buf, &buf_size, NULL, NULL,
 				    NULL, NULL))
 	     || (error == ERROR_MORE_DATA))
 	{
-	  char enc_buf[NAME_MAX + 1];
 	  if (   (buf[0] == '\0' && strcasematch (file, DEFAULT_VALUE_NAME))
-	      || (!encode_regname (enc_buf, buf) && strcasematch (enc_buf, file)))
+	      || strcasematch (buf, dec_file))
 	    {
 	      file_type = -1;
 	      goto out;
@@ -324,7 +391,7 @@ fhandler_registry::fstat (struct __stat64 *buf)
 		  value_name++;
 		  char dec_value_name[NAME_MAX + 1];
 		  DWORD dwSize;
-		  if (!decode_regname (dec_value_name, value_name) &&
+		  if (decode_regname (dec_value_name, value_name) >= 0 &&
 		      ERROR_SUCCESS ==
 		      RegQueryValueEx (hKey, dec_value_name, NULL, NULL, NULL,
 				       &dwSize))
@@ -381,13 +448,16 @@ fhandler_registry::readdir (DIR *dir, dirent *de)
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
@@ -425,14 +495,35 @@ retry:
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
+      /* Append "%val" if value name is identical to a previous key name.  */
+      unsigned h = hash_path_name (1, buf);
+      bool add_val = false;
+      if (! (dir->__d_position & REG_ENUM_VALUES_MASK))
+	d_hash (dir)->set (h);
+      else if (d_hash (dir)->is_set (h)
+	       && key_exists ((HKEY) dir->__handle, buf, wow64))
+	add_val = true;
+
+      if (encode_regname (de->d_name, buf, add_val))
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
@@ -473,11 +564,14 @@ int
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
@@ -488,7 +582,7 @@ fhandler_registry::open (int flags, mode_t mode)
 {
   int pathlen;
   const char *file;
-  HKEY handle;
+  HKEY handle = (HKEY) INVALID_HANDLE_VALUE;
 
   int res = fhandler_virtual::open (flags, mode);
   if (!res)
@@ -573,14 +667,16 @@ fhandler_registry::open (int flags, mode_t mode)
     }
 
   char dec_file[NAME_MAX + 1];
-  if (decode_regname (dec_file, file))
+  int val_only = decode_regname (dec_file, file);
+  if (val_only < 0)
     {
       set_errno (EINVAL);
       res = 0;
       goto out;
     }
 
-  handle = open_key (path, KEY_READ, wow64, false);
+  if (!val_only)
+    handle = open_key (path, KEY_READ, wow64, false);
   if (handle == (HKEY) INVALID_HANDLE_VALUE)
     {
       handle = open_key (path, KEY_READ, wow64, true);
@@ -736,7 +832,8 @@ open_key (const char *name, REGSAM access, DWORD wow64, bool isValue)
       const char *anchor = name;
       while (*name && !isdirsep (*name))
 	name++;
-      if (decode_regname (component, anchor, name - anchor))
+      int val_only = decode_regname (component, anchor, name - anchor);
+      if (val_only < 0)
         {
 	  set_errno (EINVAL);
 	  if (parentOpened)
@@ -749,6 +846,15 @@ open_key (const char *name, REGSAM access, DWORD wow64, bool isValue)
       if (*name == 0 && isValue == true)
 	goto out;
 
+      if (val_only)
+	{
+	  set_errno (ENOENT);
+	  if (parentOpened)
+	    RegCloseKey (hParentKey);
+	  hKey = (HKEY) INVALID_HANDLE_VALUE;
+	  break;
+	}
+
       if (hParentKey != (HKEY) INVALID_HANDLE_VALUE)
 	{
 	  REGSAM effective_access = KEY_READ;

--------------060807000803020000080408--
