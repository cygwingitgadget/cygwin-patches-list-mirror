Return-Path: <cygwin-patches-return-6392-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24968 invoked by alias); 13 Dec 2008 13:38:52 -0000
Received: (qmail 24954 invoked by uid 22791); 13 Dec 2008 13:38:51 -0000
X-Spam-Check-By: sourceware.org
Received: from mailout05.t-online.de (HELO mailout05.t-online.de) (194.25.134.82)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sat, 13 Dec 2008 13:38:02 +0000
Received: from fwd08.aul.t-online.de  	by mailout05.sul.t-online.de with smtp  	id 1LBUgw-0007QD-06; Sat, 13 Dec 2008 14:37:58 +0100
Received: from [10.3.2.2] (rw+y3qZbQhcFJKmx3EeuLThiI32ABxcPCsOOhs5hAJ3u0MK9eq7t2oVQTwU6HqkZVC@[217.235.244.92]) by fwd08.aul.t-online.de 	with esmtp id 1LBUgs-1Rbk7k0; Sat, 13 Dec 2008 14:37:54 +0100
Message-ID: <4943BAB0.8080001@t-online.de>
Date: Sat, 13 Dec 2008 13:38:00 -0000
From: Christian Franke <Christian.Franke@t-online.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.16) Gecko/20080702 SeaMonkey/1.1.11
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Avoid duplicate names in /proc/registry (which may 	crash      find)
References: <493C1DF7.6090905@t-online.de> <20081208114800.GW12905@calimero.vinschen.de> <20081208115433.GX12905@calimero.vinschen.de> <49417625.4030209@t-online.de> <20081212152000.GA32492@calimero.vinschen.de> <494287F4.2080505@byu.net> <20081212161304.GK32197@calimero.vinschen.de> <49428EA4.5090402@byu.net> <20081212164007.GL32197@calimero.vinschen.de> <4942A03A.5060104@t-online.de> <20081213091246.GN32197@calimero.vinschen.de>
In-Reply-To: <20081213091246.GN32197@calimero.vinschen.de>
Content-Type: multipart/mixed;  boundary="------------060102050703070904010403"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q4/txt/msg00036.txt.bz2

This is a multi-part message in MIME format.
--------------060102050703070904010403
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 1202

Corinna Vinschen wrote:
> On Dec 12 18:32, Christian Franke wrote:
>   
>> Why not encode "@" as a reserved name like it is already done for "." and 
>> ".." (which appear as "%2E" and "%2E.")? This would provide backward 
>> compatibility and consistency with current conversions:
>>
>> @ - default value
>> %40 - named key or value
>> %40%val - named value if key exists
>>
>> I will post a patch.
>>     
>
> Perfect.
>
>   

As a side effect, the patch fixes an old bug:
stat("/proc/registry/.../@", .) did not set st_size.


2008-12-13  Christian Franke  <franke@computer.org>

	* fhandler_registry.cc (DEFAULT_VALUE_NAME): Remove constant.
	(encode_regname): Encode empty (default) name to "@".
	Encode "@" to "%40".  Change error return to -1.
	(decode_regname): Decode "@" to empty name.  Decode "%40" to "@".
	(fhandler_registry::exists): Skip check for keys if name is empty.
	Remove check for DEFAULT_VALUE_NAME, now handled by decode_regname ().
	(fhandler_registry::readdir): Remove check for empty name, now
	handled by encode_regname ().
	(fhandler_registry::open): Remove check for DEFAULT_VALUE_NAME.
	(fhandler_registry::open_key): Fail with ENOENT if key name is empty.

Christian



--------------060102050703070904010403
Content-Type: text/x-diff;
 name="cygwin-1.7-registry-defval.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygwin-1.7-registry-defval.patch"
Content-length: 5459

diff --git a/winsup/cygwin/fhandler_registry.cc b/winsup/cygwin/fhandler_registry.cc
index 4efe48e..17d9109 100644
--- a/winsup/cygwin/fhandler_registry.cc
+++ b/winsup/cygwin/fhandler_registry.cc
@@ -75,9 +75,6 @@ static const char *special_dot_files[] =
 static const int SPECIAL_DOT_FILE_COUNT =
   (sizeof (special_dot_files) / sizeof (const char *)) - 1;
 
-/* Name given to default values */
-static const char *DEFAULT_VALUE_NAME = "@";
-
 static HKEY open_key (const char *name, REGSAM access, DWORD wow64, bool isValue);
 
 /* Return true if char must be encoded.
@@ -89,30 +86,35 @@ must_encode (char c)
 }
 
 /* Encode special chars in registry key or value name.
+ * Returns 0: success, -1: error.
  */
 static int
 encode_regname (char * dst, const char * src, bool add_val)
 {
   int di = 0;
-  for (int si = 0; src[si]; si++)
-    {
-      char c = src[si];
-      if (must_encode (c) ||
-	  (c == '.' && si == 0 && (!src[1] || (src[1] == '.' && !src[2]))))
-	{
-	  if (di + 3 >= NAME_MAX + 1)
-	    return ENAMETOOLONG;
-	  __small_sprintf (dst + di, "%%%02x", c);
-	  di += 3;
-	}
-      else
-	dst[di++] = c;
-    }
+  if (!src[0])
+    dst[di++] = '@'; // Default value.
+  else
+    for (int si = 0; src[si]; si++)
+      {
+	char c = src[si];
+	if (must_encode (c) ||
+	    (si == 0 && ((c == '.' && (!src[1] || (src[1] == '.' && !src[2]))) ||
+			(c == '@' && !src[1]))))
+	  {
+	    if (di + 3 >= NAME_MAX + 1)
+	      return -1;
+	    __small_sprintf (dst + di, "%%%02x", c);
+	    di += 3;
+	  }
+	else
+	  dst[di++] = c;
+      }
 
   if (add_val)
     {
       if (di + 4 >= NAME_MAX + 1)
-	return ENAMETOOLONG;
+	return -1;
       memcpy (dst + di, "%val", 4);
       di += 4;
     }
@@ -129,32 +131,39 @@ decode_regname (char * dst, const char * src, int len = -1)
 {
   if (len < 0)
     len = strlen (src);
+
   int res = 0;
-  int di = 0;
-  for (int si = 0; si < len; si++)
+  if (len > 4 && !memcmp (src + len - 4, "%val", 4))
     {
-      char c = src[si];
-      if (c == '%')
-	{
-	  if (si + 4 == len && !memcmp (src + si, "%val", 4))
-	    {
-	      res = 1;
-	      break;
-	    }
-	  if (si + 2 >= len)
-	    return -1;
-	  char s[] = {src[si+1], src[si+2], '\0'};
-	  char *p;
-	  c = strtoul (s, &p, 16);
-	  if (!(must_encode (c) ||
-	        (c == '.' && si == 0 && (len == 3 || (src[3] == '.' && len == 4)))))
-	    return -1;
-	  dst[di++] = c;
-	  si += 2;
-	}
-      else
-	dst[di++] = c;
+      len -= 4;
+      res = 1;
     }
+
+  int di = 0;
+  if (len == 1 && src[0] == '@')
+    ; // Default value.
+  else
+    for (int si = 0; si < len; si++)
+      {
+	char c = src[si];
+	if (c == '%')
+	  {
+	    if (si + 2 >= len)
+	      return -1;
+	    char s[] = {src[si+1], src[si+2], '\0'};
+	    char *p;
+	    c = strtoul (s, &p, 16);
+	    if (!(must_encode (c) ||
+		  (si == 0 && ((c == '.' && (len == 3 || (src[3] == '.' && len == 4))) ||
+			       (c == '@' && len == 3)))))
+	      return -1;
+	    dst[di++] = c;
+	    si += 2;
+	  }
+	else
+	  dst[di++] = c;
+      }
+
   dst[di] = 0;
   return res;
 }
@@ -263,7 +272,7 @@ fhandler_registry::exists ()
       if (hKey == (HKEY) INVALID_HANDLE_VALUE)
 	return 0;
 
-      if (!val_only)
+      if (!val_only && dec_file[0])
 	{
 	  while (ERROR_SUCCESS ==
 		 (error = RegEnumKeyEx (hKey, index++, buf, &buf_size,
@@ -291,8 +300,7 @@ fhandler_registry::exists ()
 				    NULL, NULL))
 	     || (error == ERROR_MORE_DATA))
 	{
-	  if (   (buf[0] == '\0' && strcasematch (file, DEFAULT_VALUE_NAME))
-	      || strcasematch (buf, dec_file))
+	  if (strcasematch (buf, dec_file))
 	    {
 	      file_type = -1;
 	      goto out;
@@ -499,25 +507,22 @@ retry:
   if (dir->__d_position & REG_ENUM_VALUES_MASK)
     dir->__d_position += 0x10000;
 
-  if (*buf == 0)
-    strcpy (de->d_name, DEFAULT_VALUE_NAME);
-  else
-    {
-      /* Append "%val" if value name is identical to a previous key name.  */
-      unsigned h = hash_path_name (1, buf);
-      bool add_val = false;
-      if (! (dir->__d_position & REG_ENUM_VALUES_MASK))
-	d_hash (dir)->set (h);
-      else if (d_hash (dir)->is_set (h)
-	       && key_exists ((HKEY) dir->__handle, buf, wow64))
-	add_val = true;
-
-      if (encode_regname (de->d_name, buf, add_val))
-	{
-	  buf_size = NAME_MAX + 1;
-	  goto retry;
-	}
-    }
+  {
+    /* Append "%val" if value name is identical to a previous key name.  */
+    unsigned h = hash_path_name (1, buf);
+    bool add_val = false;
+    if (! (dir->__d_position & REG_ENUM_VALUES_MASK))
+      d_hash (dir)->set (h);
+    else if (d_hash (dir)->is_set (h)
+	     && key_exists ((HKEY) dir->__handle, buf, wow64))
+      add_val = true;
+
+    if (encode_regname (de->d_name, buf, add_val))
+      {
+	buf_size = NAME_MAX + 1;
+	goto retry;
+      }
+  }
 
   if (dir->__d_position & REG_ENUM_VALUES_MASK)
     de->d_type = DT_REG;
@@ -690,11 +695,7 @@ fhandler_registry::open (int flags, mode_t mode)
     flags |= O_DIROPEN;
 
   set_io_handle (handle);
-
-  if (strcasematch (dec_file, DEFAULT_VALUE_NAME))
-    value_name = cstrdup ("");
-  else
-    value_name = cstrdup (dec_file);
+  value_name = cstrdup (dec_file);
 
   if (!(flags & O_DIROPEN) && !fill_filebuf ())
     {
@@ -846,7 +847,7 @@ open_key (const char *name, REGSAM access, DWORD wow64, bool isValue)
       if (*name == 0 && isValue == true)
 	goto out;
 
-      if (val_only)
+      if (val_only || !component[0])
 	{
 	  set_errno (ENOENT);
 	  if (parentOpened)

--------------060102050703070904010403--
