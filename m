Return-Path: <cygwin-patches-return-6168-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23984 invoked by alias); 16 Nov 2007 19:25:35 -0000
Received: (qmail 23931 invoked by uid 22791); 16 Nov 2007 19:25:34 -0000
X-Spam-Check-By: sourceware.org
Received: from mailout04.sul.t-online.de (HELO mailout04.sul.t-online.com) (194.25.134.18)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 16 Nov 2007 19:25:30 +0000
Received: from fwd34.aul.t-online.de  	by mailout04.sul.t-online.com with smtp  	id 1It6oh-0000hU-04; Fri, 16 Nov 2007 20:25:27 +0100
Received: from [10.3.2.2] (EIb3fUZZohmRF-iza3QKsqtWaptDIxC6FkvwFidArAL9jGJG91NrweHO4iDZ8Z5ZG5@[217.235.208.193]) by fwd34.aul.t-online.de 	with esmtp id 1It6od-1hWvhY0; Fri, 16 Nov 2007 20:25:23 +0100
Message-ID: <473DEEA7.1060901@t-online.de>
Date: Fri, 16 Nov 2007 19:25:00 -0000
From: Christian Franke <Christian.Franke@t-online.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.6) Gecko/20070802 SeaMonkey/1.1.4
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: Re: [Patch] Encode invalid chars in /proc/registry entries
References: <473CC0A6.6010409@t-online.de> <20071116110901.GK30894@calimero.vinschen.de>
In-Reply-To: <20071116110901.GK30894@calimero.vinschen.de>
Content-Type: multipart/mixed;  boundary="------------070506040607000705090407"
X-ID: EIb3fUZZohmRF-iza3QKsqtWaptDIxC6FkvwFidArAL9jGJG91NrweHO4iDZ8Z5ZG5
X-TOI-MSGID: fd693e0e-6122-4d5a-aaac-3a48195ec758
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q4/txt/msg00020.txt.bz2

This is a multi-part message in MIME format.
--------------070506040607000705090407
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 2205

Hi Corinna,

Corinna Vinschen wrote:
>> ...
>>
>> Patch is tested with 1.5.24-2. Merge with HEAD looks good, but was not 
>> actually tested. Therefore, no changelog provided yet.
>>     
>
> Thanks for this patch.  Apart from the missing ChangeLog I'm inclined
> to apply it to the upcoming 1.5.25 release, but I don't like to have it
> in HEAD as is.
>   

Thanks, I would appreciate to have this issue fixed in the bugfix release.

Here is a new version of the patch and a ChangeLog.

The names "." and ".." are now also encoded. Theses are also valid as 
Key/Value Names and ".." may result in infinite recursion.


> The reason is that the patch introduces more usages of CYG_MAX_PATH plus
> static buffers of that size.  That's ok for 1.5, but that's not ok
> anymore for 1.7.  We're heading to support PATH_MAX = ~32K paths.  The
> registry also supports long paths, unfortunately with undefined max
> length.  The current definition in MSDN(*) is
>
>   Max name length of keys:      255 chars
>   Max name length of values:  16383 chars
>   Max tree depth:               512 levels
>
> So, for HEAD I'd like to ask you to allow arbitrary path lengths in your
> code.  Personally I could live with restricting registry paths to
> PATH_MAX as well.
>
>   

Agree. Probably Cygwin should never descend paths that exceed PATH_MAX, 
as an application using PATH_MAX may have no buffer overflow check.


> While you're digging in registry code anyway... would you be interested
> to convert the entire registry code to wide char and long path names?
> I'd be glad for any help.
>
>   

I will have a look at it, but be patient. Is current HEAD a reasonable 
starting point or is there a better (more stable) snapshot?

Christian

2007-11-16  Christian Franke  <franke@computer.org>

	* fhandler_registry.cc (must_encode): New function.
	(encode_regname): Ditto.
	(decode_regname): Ditto.
	(fhandler_registry::exists): Encode name before path compare.
	(fhandler_registry::fstat): Pass decoded name to win32 registry call.
	(fhandler_registry::readdir): Return encoded name to user.
	(fhandler_registry::open): Store decoded name into value_name.
	(open_key): Pass decoded name to win32 registry call.



--------------070506040607000705090407
Content-Type: text/x-patch;
 name="cygwin-1.5.24-2-regnames-encode-2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygwin-1.5.24-2-regnames-encode-2.patch"
Content-length: 4168

--- cygwin-1.5.24-2.orig/winsup/cygwin/fhandler_registry.cc	2006-01-27 22:50:40.001000000 +0100
+++ cygwin-1.5.24-2/winsup/cygwin/fhandler_registry.cc	2007-11-16 16:34:45.000000000 +0100
@@ -86,6 +86,69 @@ static const char *DEFAULT_VALUE_NAME = 
 
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
+      if (must_encode (c) ||
+	  (c == '.' && si == 0 && (!src[1] || (src[1] == '.' && !src[2]))))
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
@@ -166,8 +229,9 @@ fhandler_registry::exists ()
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
@@ -246,9 +310,11 @@ fhandler_registry::fstat (struct __stat6
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
@@ -338,8 +404,8 @@ retry:
   /* We get here if `buf' contains valid data.  */
   if (*buf == 0)
     strcpy (de->d_name, DEFAULT_VALUE_NAME);
-  else
-    strcpy (de->d_name, buf);
+  else if (encode_regname (de->d_name, buf))
+    goto retry;
 
   dir->__d_position++;
   if (dir->__d_position & REG_ENUM_VALUES_MASK)
@@ -482,6 +548,14 @@ fhandler_registry::open (int flags, mode
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
@@ -497,10 +571,10 @@ fhandler_registry::open (int flags, mode
 
   set_io_handle (handle);
 
-  if (pathmatch (file, DEFAULT_VALUE_NAME))
+  if (pathmatch (dec_file, DEFAULT_VALUE_NAME))
     value_name = cstrdup ("");
   else
-    value_name = cstrdup (file);
+    value_name = cstrdup (dec_file);
 
   if (!(flags & O_DIROPEN) && !fill_filebuf ())
     {
@@ -638,8 +712,14 @@ open_key (const char *name, REGSAM acces
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

--------------070506040607000705090407--
