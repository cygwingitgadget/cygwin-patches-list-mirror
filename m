Return-Path: <cygwin-patches-return-5914-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15987 invoked by alias); 6 Jul 2006 06:27:40 -0000
Received: (qmail 15931 invoked by uid 22791); 6 Jul 2006 06:27:37 -0000
X-Spam-Check-By: sourceware.org
Received: from okigate.oki.co.jp (HELO iscan1.intra.oki.co.jp) (202.226.91.194)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 06 Jul 2006 06:27:31 +0000
Received: from s24c53.dm1.oii.oki.co.jp (IDENT:root@localhost.localdomain [127.0.0.1]) 	by iscan1.intra.oki.co.jp (8.9.3/8.9.3) with ESMTP id PAA09685; 	Thu, 6 Jul 2006 15:27:28 +0900
Received: from [10.161.35.40] (suzuki611-note.ngo.okisoft.co.jp [10.161.35.40]) 	by s24c53.dm1.oii.oki.co.jp (8.11.6/8.11.2) with ESMTP id k666RSd15415; 	Thu, 6 Jul 2006 15:27:28 +0900
Message-ID: <44ACAD7A.403@oki.com>
Date: Thu, 06 Jul 2006 06:27:00 -0000
From: SUZUKI Hisao <suzuki611@oki.com>
User-Agent: Thunderbird 1.5.0.4 (Macintosh/20060516)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: UTF-8 Cygwin
References: <44A0C650.6060001@oki.com> <20060627055956.GA30923@trixie.casa.cgf.cx> <44AC584F.1050408@oki.com> <44AC6D1A.1020200@cygwin.com>
In-Reply-To: <44AC6D1A.1020200@cygwin.com>
Content-Type: multipart/mixed;  boundary="------------020008010707080703010708"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q3/txt/msg00009.txt.bz2

This is a multi-part message in MIME format.
--------------020008010707080703010708
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 1662

Larry Hall wrote:
> SUZUKI Hisao wrote:
[snip]
>>
>> Yes, I have filled out the assignment form and have sent it to Red
>> Hat.  I hope you can adopt and adapt the patch without any legal
>> fears now ;-).
>>
>>
>> P.S.
>>
>> Based on Cygwin 1.5.20-1, I have updated the UTF-8 patch.
>>
>> In fact, I have just "diff -c"'ed the old ones and have patch'ed the
>> results to cygwin-1.5.20-1-src, except for sys_wcstombs() in
>> miscfuncs.cc.  Its definition differs from what is in cygwin-1.5.19-4.
>> I have just done a few lines of tweaks on it.
>>
>> Though I have not looked into the details yet, it seems working fine.
>> Please try it:

You know the modified source has been available here from the very first:

>> http://www.okisoft.co.jp/esc/utf8-cygwin/
 >
> Sounds like things are all moving in the right direction!  Once you receive
> the "OK" from Corinna (indicating that your assignment form has arrived at
> Red Hat's headquarters), you'll want to generate a patch to submit to this
> list for discussion/approval.  The details of this process are described 
> here:
> 
> <http://cygwin.com/contrib.html>
> 
> Looking forward to your contribution and thanks in advance for the work!

Indeed, if you need a certain format of patch, you can make it freely.

Anyway, I append it to this mail with its "ChangeLog".  I have not
received the "OK" from Corinna yet, but the source has been and will be
open for everyone.

Sorry, but I cannot access to CVS server because of firewall.  So the
patch file was made from the cygwin-1.5.20-1-src.

370a91f5153004455e71aa0c15e83f87  ChangeLog
d6e79e15e92814da891ba4d8040e1722  utf-8-patch-07-05

-- SUZUKI Hisao

--------------020008010707080703010708
Content-Type: text/plain; x-mac-type="0"; x-mac-creator="0";
 name="utf-8-patch-07-05"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="utf-8-patch-07-05"
Content-length: 29951

diff -rup ../../cygwin-1.5.20-1/winsup/cygwin/fhandler.h cygwin/fhandler.h
--- ../../cygwin-1.5.20-1/winsup/cygwin/fhandler.h	2006-06-27 01:10:51.000000000 +0900
+++ cygwin/fhandler.h	2006-07-05 13:54:48.704740800 +0900
@@ -871,10 +871,13 @@ class dev_console
 class fhandler_console: public fhandler_termios
 {
  private:
+  char utf8buf[4];		// XXX
+  int utf8count;		// XXX
   static dev_console *dev_state;
   static bool invisible_console;
 
 /* Output calls */
+  void insert_spaces (int);	// XXX
   void set_default_attr ();
 
   void clear_screen (int, int, int, int);
diff -rup ../../cygwin-1.5.20-1/winsup/cygwin/fhandler_console.cc cygwin/fhandler_console.cc
--- ../../cygwin-1.5.20-1/winsup/cygwin/fhandler_console.cc	2006-06-27 01:10:51.000000000 +0900
+++ cygwin/fhandler_console.cc	2006-07-05 13:55:13.430294400 +0900
@@ -291,7 +291,8 @@ fhandler_console::read (void *pv, size_t
       INPUT_RECORD input_rec;
       const char *toadd = NULL;
 
-      if (!ReadConsoleInput (h, &input_rec, 1, &nread))
+      // if (!ReadConsoleInput (h, &input_rec, 1, &nread))
+      if (!ReadConsoleInputW (h, &input_rec, 1, &nread)) // XXX
 	{
 	  syscall_printf ("ReadConsoleInput failed, %E");
 	  goto err;		/* seems to be failure */
@@ -375,11 +376,13 @@ fhandler_console::read (void *pv, size_t
 	    }
 	  else
 	    {
-	      tmp[1] = ich;
+	      // XXX tmp[1] = ich;
+	      nread = WideCharToMultiByte (CP_UTF8, 0, &wch, 1,
+					   tmp + 1, 60 - 1, NULL, NULL); // XXX
 	      /* Need this check since US code page seems to have a bug when
 		 converting a CTRL-U. */
-	      if ((unsigned char) ich > 0x7f)
-		dev_state->con_to_str (tmp + 1, tmp + 1, 1);
+	      // XXX if ((unsigned char) ich > 0x7f)
+	      // XXX   dev_state->con_to_str (tmp + 1, tmp + 1, 1);
 	      /* Determine if the keystroke is modified by META.  The tricky
 		 part is to distinguish whether the right Alt key should be
 		 recognized as Alt, or as AltGr. */
@@ -637,6 +640,7 @@ fhandler_console::open (int flags, mode_
 {
   HANDLE h;
 
+  utf8count = 0;		// XXX
   tcinit (get_tty_stuff (flags));
 
   set_io_handle (NULL);
@@ -1433,6 +1437,68 @@ beep ()
   MessageBeep (MB_OK);
 }
 
+static int
+check_for_utf8(const char* buf, int count) // XXX
+{
+  if (count > 0)
+    {
+      int ch = buf[0];
+      int size = 0;
+      if ((ch & 0x80) == 0x00)	// 0xxx_xxxx
+	size = 1;
+      else if ((ch & 0xE0) == 0xC0) // 110x_xxxx 10xx_xxxx
+	size = 2;
+      else if ((ch & 0xF0) == 0xE0) // 1110_xxxx (10xx_xxxx)* 2
+	size = 3;
+      else if ((ch & 0xF8) == 0xF0) // 1111_0xxx (10xx_xxxx) * 3
+	size = 4;
+      else
+	return -1;		// Not UTF-8
+      int rest = size - 1;
+      for (int i = 1; i < count && 0 < rest; i++, rest--)
+	{
+	  if ((buf[i] & 0xC0) != 0x80)
+	    return -1;		// Not UTF-8
+	}
+      if (rest == 0)
+	return size;		// 1, 2, 3 or 4
+      else
+	return 0;		// Incomlete
+     }
+  return -1;			// Not UTF-8
+}
+
+void
+fhandler_console::insert_spaces (int len) // XXX
+{
+  if (dev_state->insert_mode)
+    {
+      int x, y;
+      cursor_get (&x, &y);
+      scroll_screen (x, y, -1, y, x + len, y);
+    }
+}
+
+static int
+mock_wcwidth (wchar_t w)	// XXX
+{
+  if ((0x2E80 <= w && w <= 0xFAFF) ||
+      (0xFE30 <= w && w <= 0xFE4F) ||
+      (0xFF00 <= w && w <= 0xFF60))
+    return 2;
+  else
+    return 1;
+}
+
+static int
+mock_wswidth (wchar_t* ws, int len) // XXX
+{
+  int sum = 0;
+  for (int i = 0; i < len; i++)
+    sum += mock_wcwidth (ws[i]);
+  return sum;
+}
+
 const unsigned char *
 fhandler_console::write_normal (const unsigned char *src,
 				const unsigned char *end)
@@ -1458,22 +1524,86 @@ fhandler_console::write_normal (const un
 	  DWORD buf_len;
 	  char buf[CONVERT_LIMIT];
 	  done = buf_len = min (sizeof (buf), len);
-	  if (!dev_state->str_to_con (buf, (const char *) src, buf_len))
-	    {
-	      debug_printf ("conversion error, handle %p",
-			    get_output_handle ());
-	      __seterrno ();
-	      return 0;
+	  //if (!dev_state->str_to_con (buf, (const char *) src, buf_len))
+	  //  {
+	  //    debug_printf ("conversion error, handle %p",
+	  //		    get_output_handle ());
+	  //    __seterrno ();
+	  //    return 0;
+	  //  }
+
+	  //if (dev_state->insert_mode)
+	  //  {
+	  //    int x, y;
+	  //    cursor_get (&x, &y);
+	  //    scroll_screen (x, y, -1, y, x + buf_len, y);
+	  //  }
+	  //if (!WriteFile (get_output_handle (), buf, buf_len, &done, 0))
+	  // XXX <<
+	  memcpy (buf, src, buf_len);
+	  void* oh = get_output_handle ();
+	  DWORD dummy;
+	  int r = 1;
+	  if (utf8count > 0)
+	    {
+	      utf8buf[utf8count++] = buf[0];
+	      done = 1;
+	      int i = check_for_utf8 (utf8buf, utf8count);
+	      if (i < 0)	// not utf-8
+		{
+		  insert_spaces (utf8count);
+		  r = WriteFile (oh, utf8buf, utf8count, &dummy, 0);
+		  utf8count = 0;
+		}
+	      else if (i > 0)	// a complete utf-8 bytes
+		{
+		  wchar_t wch = L'_';
+		  MultiByteToWideChar (CP_UTF8, 0, utf8buf, i, &wch, 1);
+		  insert_spaces (mock_wcwidth (wch));
+		  r = WriteConsoleW (oh, &wch, 1, &dummy, 0);
+		  utf8count = 0;
+		}
 	    }
-
-	  if (dev_state->insert_mode)
+	  else
 	    {
-	      int x, y;
-	      cursor_get (&x, &y);
-	      scroll_screen (x, y, -1, y, x + buf_len, y);
+	      r = MultiByteToWideChar (CP_UTF8, MB_ERR_INVALID_CHARS,
+				       buf, buf_len, 0, 0);
+	      if (r == 0)
+		{
+		  int i = check_for_utf8 (buf, buf_len);
+		  if (i > 0)
+		    {
+		      done = i;
+		      wchar_t wch = L'o';
+		      MultiByteToWideChar (CP_UTF8, 0, buf, i, &wch, 1);
+		      insert_spaces (mock_wcwidth (wch));
+		      r = WriteConsoleW (oh, &wch, 1, &dummy, 0);
+		    }
+		  else if (i == 0)
+		    {
+		      utf8buf[utf8count++] = buf[0];
+		      done = 1;
+		      r = 1;
+		    }
+		  else
+		    {
+		      insert_spaces (buf_len);
+		      r = WriteFile (oh, buf, buf_len, &done, 0);
+		    }
+		}
+	      else
+		{
+		  wchar_t wbuf[r];
+		  MultiByteToWideChar (CP_UTF8, 0, buf, buf_len, wbuf, r); 
+		  insert_spaces (mock_wswidth (wbuf, r));
+		  r = WriteConsoleW (oh, wbuf, r, &done, 0);
+		  // Now, "done" equals to the number of chars written.
+		  done = WideCharToMultiByte (CP_UTF8, 0, wbuf, done,
+					      0, 0, 0, 0);
+		}
 	    }
-
-	  if (!WriteFile (get_output_handle (), buf, buf_len, &done, 0))
+	  if (r == 0)
+	  // XXX >>
 	    {
 	      debug_printf ("write failed, handle %p", get_output_handle ());
 	      __seterrno ();
@@ -1488,6 +1618,7 @@ fhandler_console::write_normal (const un
   if (src < end)
     {
       int x, y;
+      utf8count = 0;		// XXX
       switch (base_chars[*src])
 	{
 	case BEL:
diff -rup ../../cygwin-1.5.20-1/winsup/cygwin/miscfuncs.cc cygwin/miscfuncs.cc
--- ../../cygwin-1.5.20-1/winsup/cygwin/miscfuncs.cc	2006-06-27 01:10:51.000000000 +0900
+++ cygwin/miscfuncs.cc	2006-07-05 16:56:18.039142400 +0900
@@ -9,7 +9,7 @@ This software is a copyrighted work lice
 Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
 details. */
 
-#define _WIN32_WINNT 0x400
+//#define _WIN32_WINNT 0x400
 #include "winsup.h"
 #include "cygerrno.h"
 #include <sys/errno.h>
@@ -210,29 +210,430 @@ get_cp ()
   return current_codepage == ansi_cp ? GetACP() : GetOEMCP();
 }
 
+
+// ----------------------------------------------------------------------
 /* tlen is always treated as the maximum buffer size, including the '\0'
    character.  sys_wcstombs will always return a 0-terminated result, no
    matter what. */
 int __stdcall
 sys_wcstombs (char *tgt, int tlen, const WCHAR *src, int slen)
 {
-  int ret;
-
-  ret = WideCharToMultiByte (get_cp (), 0, src, slen, tgt, tlen, NULL, NULL);
+  int ret = WideCharToMultiByte (CP_UTF8, 0, src, slen, tgt, tlen, NULL, NULL);
   if (ret)
-    tgt[ret < tlen ? ret : tlen - 1] = '\0';
+    tgt[(ret < tlen) ? ret : tlen - 1] = '\0';
   return ret;
 }
 
+#define u_mbstowcs sys_mbstowcs
+
+int __stdcall
+u_wcstombs (char* tgt, const wchar_t* src, int len)
+{
+  return WideCharToMultiByte (CP_UTF8, 0, src, -1, tgt, len, NULL, NULL);
+}
+
+int __stdcall
+u_mbstowcs (wchar_t* tgt, const char* src, int len)
+{
+  int r = MultiByteToWideChar (CP_UTF8, MB_ERR_INVALID_CHARS,
+			       src, -1, tgt, len);
+  if (r == 0)			// fall back to default cp.
+    {
+      r = MultiByteToWideChar (get_cp (), 0, src, -1, tgt, len);
+      if (r == 0)
+	debug_printf ("MultiByteToWideChar %E");
+    }
+  else if (len > 0)
+    {			      // for COMBINING KANA (SEMI-)VOICED MARK
+      wchar_t* p = tgt;
+      wchar_t* q = tgt;
+      wchar_t c0 = *p++;
+      for (;;)
+	{
+	  if (c0 == 0)
+	    {
+	      *q = 0x0000;
+	      break;
+	    }
+	  wchar_t c1 = *p++;
+	  if (c1 == 0x3099)	// combining kana voiced mark
+	    {
+	      if (c0 == 0x3046) // hiragana "U"
+		c0 = 0x3094;
+	      if (c0 == 0x30a6) // katakana "U"
+		c0 = 0x30f4;
+	      else if (0x30ef <= c0 && c0 <= 0x30f2) //  katakana "WA" - "WO"
+		c0 += 8;
+	      else if (0x3031 <= c0 && c0 <= 0x30ff) // XXX
+		c0 += 1;
+	      else		// XXX
+		{
+		  *q++ = c0;
+		  c0 = 0x309b;	// kana voiced mark
+		  r++;
+		}
+	      r--;
+	      *q++ = c0;
+	      c0 = *p++;
+	    }
+	  else if (c1 == 0x309a)
+	    {			// XXX
+	      if ((0x306f <= c0 && c0 <= 0x307b) || // hiragana "HA" - "HO"
+		  (0x30cf <= c0 && c0 <= 0x30db)) // katakana "HA" - "HO"
+		c0 += 2;
+	      else
+		{
+		  *q++ = c0;
+		  c0 = 0x309c;	// kana semi-voiced mark
+		  r++;
+		}
+	      r--;
+	      *q++ = c0;
+	      c0 = *p++;
+	    }
+	  else			// XXX combining grave, acute etc?
+	    {
+	      *q++ = c0;
+	      c0 = c1;
+	    }
+	}
+    }
+  return r;
+}
+
+static int
+u_size_as_wcs (const char* src)
+{
+  int r = MultiByteToWideChar (CP_UTF8, MB_ERR_INVALID_CHARS,
+			       src, -1, NULL, 0);
+  if (r == 0)			// fall back to default cp.
+    r = MultiByteToWideChar (get_cp (), 0, src, -1, NULL, 0);
+  return r;
+}
+
+void* __stdcall
+CreateFileU (const char* filename, DWORD access_mode, DWORD share_mode,
+	     SECURITY_ATTRIBUTES* security_attr, DWORD create_disp,
+	     DWORD flags, void* template_file)
+{
+  wchar_t wname[CYG_MAX_PATH];
+  if (!u_mbstowcs (wname, filename, CYG_MAX_PATH))
+    return INVALID_HANDLE_VALUE;
+  return CreateFileW (wname, access_mode, share_mode,
+		      security_attr, create_disp, flags, template_file);
+    
+}
+
+HINSTANCE __stdcall
+LoadLibraryU (const char* filename)
+{
+  wchar_t wname[CYG_MAX_PATH];
+  if (!u_mbstowcs (wname, filename, CYG_MAX_PATH))
+    return NULL;
+  return LoadLibraryW (wname);
+}
+
+static void
+copy_find_dataw_to_dataa (const WIN32_FIND_DATAW* wbuf, WIN32_FIND_DATAA* buf)
+{
+  buf->dwFileAttributes = wbuf->dwFileAttributes;
+  buf->ftCreationTime = wbuf->ftCreationTime;
+  buf->ftLastAccessTime = wbuf->ftLastAccessTime;
+  buf->ftLastWriteTime = wbuf->ftLastWriteTime;
+  buf->nFileSizeHigh = wbuf->nFileSizeHigh;
+  buf->nFileSizeLow = wbuf->nFileSizeLow;
+  buf->dwReserved0 = wbuf->dwReserved0;
+  buf->dwReserved1 = wbuf->dwReserved1;
+  u_wcstombs (buf->cFileName, wbuf->cFileName, MAX_PATH);
+  WideCharToMultiByte (get_cp (), 0, wbuf->cAlternateFileName, -1,
+		       buf->cAlternateFileName, 14, NULL, NULL);
+}
+
+void* __stdcall
+FindFirstFileU (const char* filename, WIN32_FIND_DATAA* buf)
+{
+  wchar_t wname[CYG_MAX_PATH];
+  if (!u_mbstowcs (wname, filename, CYG_MAX_PATH))
+    return INVALID_HANDLE_VALUE;
+  else
+    {
+      WIN32_FIND_DATAW wbuf;
+      void* r = FindFirstFileW (wname, &wbuf);
+      if (r != INVALID_HANDLE_VALUE)
+	copy_find_dataw_to_dataa (&wbuf, buf);
+      return r;
+    }
+}
+
+int __stdcall
+FindNextFileU (void* handle, WIN32_FIND_DATAA* buf)
+{
+  WIN32_FIND_DATAW wbuf;
+  wbuf.dwFileAttributes = buf->dwFileAttributes;
+  wbuf.ftCreationTime = buf->ftCreationTime;
+  wbuf.ftLastAccessTime = buf->ftLastAccessTime;
+  wbuf.ftLastWriteTime = buf->ftLastWriteTime;
+  wbuf.nFileSizeHigh = buf->nFileSizeHigh;
+  wbuf.nFileSizeLow = buf->nFileSizeLow;
+  wbuf.dwReserved0 = buf->dwReserved0;
+  wbuf.dwReserved1 = buf->dwReserved1;
+  u_mbstowcs (wbuf.cFileName, buf->cFileName, MAX_PATH);
+  MultiByteToWideChar (get_cp(), 0, buf->cAlternateFileName, -1,
+		       wbuf.cAlternateFileName, 14);
+  int r = FindNextFileW (handle, &wbuf);
+  if (r != 0)
+    copy_find_dataw_to_dataa (&wbuf, buf);
+  return r;
+}
+
+int __stdcall
+SetFileAttributesU (const char* filename, DWORD attr)
+{
+  wchar_t wname[CYG_MAX_PATH];
+  if (!u_mbstowcs (wname, filename, CYG_MAX_PATH))
+    return 0;
+  return SetFileAttributesW (wname, attr);
+}
+
+DWORD __stdcall
+GetFileAttributesU (const char* filename)
+{
+  wchar_t wname[CYG_MAX_PATH];
+  if (!u_mbstowcs (wname, filename, CYG_MAX_PATH))
+    return (DWORD) -1;
+  return GetFileAttributesW (wname);
+}
+
+int __stdcall
+CreateHardLinkU (const char* filename, const char* existing_filename,
+		 SECURITY_ATTRIBUTES* attr)
+{
+  wchar_t wname1[CYG_MAX_PATH];
+  wchar_t wname2[CYG_MAX_PATH];
+  if (!u_mbstowcs (wname1, filename, CYG_MAX_PATH))
+    return 0;
+  if (!u_mbstowcs (wname2, existing_filename, CYG_MAX_PATH))
+    return 0;
+  return CreateHardLinkW (wname1, wname2, attr);
+}
+
+int __stdcall
+CopyFileU (const char* fname1, const char* fname2, int flag)
+{
+  wchar_t wname1[CYG_MAX_PATH];
+  wchar_t wname2[CYG_MAX_PATH];
+  if (!u_mbstowcs (wname1, fname1, CYG_MAX_PATH))
+    return 0;
+  if (!u_mbstowcs (wname2, fname2, CYG_MAX_PATH))
+    return 0;
+  return CopyFileW (wname1, wname2, flag);
+}
+
 int __stdcall
-sys_mbstowcs (WCHAR *tgt, const char *src, int len)
+CreateDirectoryU (const char* fname, SECURITY_ATTRIBUTES* attr)
 {
-  int res = MultiByteToWideChar (get_cp (), 0, src, -1, tgt, len);
-  if (!res)
-    debug_printf ("MultiByteToWideChar %E");
-  return res;
+  wchar_t wname[CYG_MAX_PATH];
+  if (!u_mbstowcs (wname, fname, CYG_MAX_PATH))
+    return 0;
+  return CreateDirectoryW (wname, attr);
 }
 
+int __stdcall
+RemoveDirectoryU (const char* fname)
+{
+  wchar_t wname[CYG_MAX_PATH];
+  if (!u_mbstowcs (wname, fname, CYG_MAX_PATH))
+    return 0;
+  return RemoveDirectoryW (wname);
+}
+
+int __stdcall
+SetCurrentDirectoryU (const char* fname)
+{
+  wchar_t wname[CYG_MAX_PATH];
+  if (!u_mbstowcs (wname, fname, CYG_MAX_PATH))
+    return 0;
+  return SetCurrentDirectoryW (wname);
+}
+
+DWORD __stdcall
+GetCurrentDirectoryU (DWORD len, char* buf)
+{
+  wchar_t wbuf[CYG_MAX_PATH];
+  DWORD n = GetCurrentDirectoryW (CYG_MAX_PATH, wbuf);
+  if (n == 0)
+    return 0;			// failed
+
+  DWORD necessary_size = u_wcstombs (NULL, wbuf, 0);
+  if (len < necessary_size)
+    return necessary_size;
+
+  DWORD written_size = u_wcstombs (buf, wbuf, len);
+  return written_size - 1;	// excluding the terminating null char.
+}
+
+int __stdcall
+GetFileSecurityU (const char* fname, SECURITY_INFORMATION info,
+		  SECURITY_DESCRIPTOR* buf, DWORD len, DWORD* len_needed)
+{
+  wchar_t wname[CYG_MAX_PATH];
+  if (!u_mbstowcs (wname, fname, CYG_MAX_PATH))
+    return 0;
+  return GetFileSecurityW (wname, info, buf, len, len_needed);
+}
+
+int __stdcall
+OemToCharBuffU (const char* src, char* dst, DWORD len)
+{
+  memmove (dst, src, len);
+  return 1;
+}
+
+void* __stdcall
+CreateMailslotU (const char* name, DWORD maxsize, DWORD timeout,
+		 SECURITY_ATTRIBUTES* attr)
+{
+  wchar_t wname[CYG_MAX_PATH];
+  if (!u_mbstowcs (wname, name, CYG_MAX_PATH))
+    return INVALID_HANDLE_VALUE;
+  return CreateMailslotW (wname, maxsize, timeout, attr);
+}
+
+int __stdcall
+DeleteFileU (const char* fname)
+{
+  wchar_t wname[CYG_MAX_PATH];
+  if (!u_mbstowcs (wname, fname, CYG_MAX_PATH))
+    return 0;
+  return DeleteFileW (wname);
+}
+
+int __stdcall
+MoveFileU (const char* oldname, const char* newname)
+{
+  wchar_t woldname[CYG_MAX_PATH];
+  wchar_t wnewname[CYG_MAX_PATH];
+  if (!u_mbstowcs (woldname, oldname, CYG_MAX_PATH))
+    return 0;
+  if (!u_mbstowcs (wnewname, newname, CYG_MAX_PATH))
+    return 0;
+  return MoveFileW (woldname, wnewname);
+}
+
+int __stdcall
+MoveFileExU (const char* oldname, const char* newname, DWORD flags)
+{
+  wchar_t woldname[CYG_MAX_PATH];
+  wchar_t wnewname[CYG_MAX_PATH];
+  if (!u_mbstowcs (woldname, oldname, CYG_MAX_PATH))
+    return 0;
+  if (!u_mbstowcs (wnewname, newname, CYG_MAX_PATH))
+    return 0;
+  return MoveFileExW (woldname, wnewname, flags);
+}
+
+void* __stdcall
+CreateNamedPipeU (const char* name, DWORD a, DWORD b, DWORD c, DWORD d,
+		  DWORD e, DWORD f, SECURITY_ATTRIBUTES* attr)
+{
+  int size = u_size_as_wcs (name);
+  wchar_t wname[size];
+  if (!u_mbstowcs (wname, name, size))
+    return INVALID_HANDLE_VALUE;
+  return CreateNamedPipeW (wname, a, b, c, d, e, f, attr);
+}
+
+int __stdcall
+CreateProcessU (const char* appname, char* commandline,
+		SECURITY_ATTRIBUTES* pattr, SECURITY_ATTRIBUTES* tattr,
+		int inherit, DWORD crflags, void* env, const char* cwd,
+		STARTUPINFOW* sinfo, PROCESS_INFORMATION *pinfo)
+{
+  int alen = (appname == NULL) ? 0 : u_size_as_wcs (appname);
+  wchar_t wappname[alen];
+  if (appname != NULL && !u_mbstowcs (wappname, appname, alen))
+    return 0;
+
+  int cllen = (commandline == NULL) ? 0 : u_size_as_wcs (commandline);
+  wchar_t wcommandline[cllen];
+  if (commandline != NULL && !u_mbstowcs (wcommandline, commandline, cllen))
+    return 0;
+
+  int cwlen = (cwd == NULL) ? 0 : u_size_as_wcs (cwd);
+  wchar_t wcwd[cwlen];
+  if (cwd != NULL && !u_mbstowcs (wcwd, cwd, cwlen))
+    return 0;
+
+  return CreateProcessW ((appname == NULL) ? NULL : wappname,
+			 (commandline == NULL) ? NULL : wcommandline,
+			 pattr, tattr, inherit, crflags, env,
+			 (cwd == NULL) ? NULL : wcwd,
+			 sinfo, pinfo);
+}
+
+int __stdcall
+CreateProcessAsUserU (void* handle,
+		      const char* appname, char* commandline,
+		      SECURITY_ATTRIBUTES* pattr, SECURITY_ATTRIBUTES* tattr,
+		      int inherit, DWORD crflags, void* env, const char* cwd,
+		      STARTUPINFOW* sinfo, PROCESS_INFORMATION *pinfo)
+{
+  int alen = (appname == NULL) ? 0 : u_size_as_wcs (appname);
+  wchar_t wappname[alen];
+  if (appname != NULL && !u_mbstowcs (wappname, appname, alen))
+    return 0;
+
+  int cllen = (commandline == NULL) ? 0 : u_size_as_wcs (commandline);
+  wchar_t wcommandline[cllen];
+  if (commandline != NULL && !u_mbstowcs (wcommandline, commandline, cllen))
+    return 0;
+
+  int cwlen = (cwd == NULL) ? 0 : u_size_as_wcs (cwd);
+  wchar_t wcwd[cwlen];
+  if (cwd != NULL && !u_mbstowcs (wcwd, cwd, cwlen))
+    return 0;
+
+  return CreateProcessAsUserW (handle,
+			       (appname == NULL) ? NULL : wappname,
+			       (commandline == NULL) ? NULL : wcommandline,
+			       pattr, tattr, inherit, crflags, env,
+			       (cwd == NULL) ? NULL : wcwd,
+			       sinfo, pinfo);
+}
+
+#undef GetCommandLineA
+char* __stdcall
+GetCommandLineU (void)
+{
+  static char line[35000];	// XXX
+  wchar_t* wline = GetCommandLineW ();
+  if (!u_wcstombs (line, wline, 35000))
+    return GetCommandLineA ();	// XXX
+  return line;
+}
+
+int __stdcall
+SetConsoleTitleU (const char* title)
+{
+  int size = u_size_as_wcs (title);
+  wchar_t wtitle[size];
+  if (!u_mbstowcs (wtitle, title, size))
+    return 0;
+  return SetConsoleTitleW (wtitle);
+}
+
+DWORD __stdcall
+GetConsoleTitleU (char* buf, DWORD len)
+{
+  wchar_t wbuf[len];
+  DWORD r = GetConsoleTitleW (wbuf, len);
+  u_wcstombs (buf, wbuf, len);
+  return r;
+}
+
+// ----------------------------------------------------------------------
+
+
 extern "C" int
 low_priority_sleep (DWORD secs)
 {
diff -rup ../../cygwin-1.5.20-1/winsup/cygwin/path.cc cygwin/path.cc
--- ../../cygwin-1.5.20-1/winsup/cygwin/path.cc	2006-06-27 01:10:51.000000000 +0900
+++ cygwin/path.cc	2006-07-05 13:57:35.374400000 +0900
@@ -158,6 +158,22 @@ struct win_shortcut_hdr
   (devn == FH_CYGDRIVE || devn == FH_PROC || devn == FH_REGISTRY \
    || devn == FH_PROCESS || devn == FH_NETDRIVE )
 
+// XXX
+static int
+store_path (UINT fromCP, const char* path, UINT toCP, char* dst,
+	    int maxlen = CYG_MAX_PATH)
+{
+  int wlen = (fromCP == CP_UTF8) ?
+    sys_mbstowcs (NULL, path, 0) :
+    MultiByteToWideChar (fromCP, 0, path, -1, NULL, 0);
+  wchar_t wpath[wlen];
+  (fromCP == CP_UTF8) ?
+    sys_mbstowcs (wpath, path, wlen):
+    MultiByteToWideChar (fromCP, 0, path, -1, wpath, wlen);
+  int len = WideCharToMultiByte (toCP, 0, wpath, -1, dst, maxlen, NULL, NULL);
+  return len - 1;		// exclude the byte for '\0'
+}
+
 /* Return non-zero if PATH1 is a prefix of PATH2.
    Both are assumed to be of the same path style and / vs \ usage.
    Neither may be "".
@@ -1999,7 +2015,16 @@ mount_info::read_mounts (reg_key& r)
       mount_flags = subkey.get_int ("flags", 0);
 
       /* Add mount_item corresponding to registry mount point. */
-      res = mount_table->add_item (native_path, posix_path, mount_flags, false);
+      //res = mount_table->add_item (native_path, posix_path, mount_flags, false);
+      // XXX <<<
+      char native_path2[CYG_MAX_PATH];
+      char posix_path2[CYG_MAX_PATH];
+      store_path (CP_ACP, native_path, CP_UTF8, native_path2);
+      store_path (CP_ACP, posix_path, CP_UTF8, posix_path2);
+      res = mount_table->add_item (native_path2, posix_path2, mount_flags,
+				   false);
+      // XX >>>
+
       if (res && get_errno () == EMFILE)
 	break; /* The number of entries exceeds MAX_MOUNTS */
     }
@@ -2037,6 +2062,15 @@ mount_info::from_registry ()
 int
 mount_info::add_reg_mount (const char *native_path, const char *posix_path, unsigned mountflags)
 {
+  // XXX <<<
+  char native_path2[CYG_MAX_PATH];
+  char posix_path2[CYG_MAX_PATH];
+  store_path (CP_UTF8, native_path, CP_ACP, native_path2);
+  store_path (CP_UTF8, posix_path, CP_ACP, posix_path2);
+  native_path = native_path2;
+  posix_path = posix_path2;
+  // XX >>>
+
   int res;
 
   /* Add the mount to the right registry location, depending on
@@ -2077,6 +2111,12 @@ mount_info::add_reg_mount (const char *n
 int
 mount_info::del_reg_mount (const char * posix_path, unsigned flags)
 {
+  // XXX <<<
+  char posix_path2[CYG_MAX_PATH];
+  store_path (CP_UTF8, posix_path, CP_ACP, posix_path2);
+  posix_path = posix_path2;
+  // XX >>>
+
   int res;
 
   reg_key reg (flags & MOUNT_SYSTEM, KEY_ALL_ACCESS,
@@ -2874,8 +2914,9 @@ symlink_worker (const char *oldpath, con
 	  hres = SHGetDesktopFolder (&psl);
 	  if (SUCCEEDED (hres))
 	    {
-	      MultiByteToWideChar (CP_ACP, 0, w32oldpath, -1, wc_path,
-				   CYG_MAX_PATH);
+	      //MultiByteToWideChar (CP_ACP, 0, w32oldpath, -1, wc_path,
+	      //		     CYG_MAX_PATH);
+	      sys_mbstowcs (wc_path, w32oldpath, CYG_MAX_PATH);	// XXX
 	      hres = psl->ParseDisplayName (NULL, NULL, wc_path, NULL,
 					    &pidl, NULL);
 	      if (SUCCEEDED (hres))
@@ -2893,21 +2934,29 @@ symlink_worker (const char *oldpath, con
 	      psl->Release ();
 	    }
 	  /* Creating a description */
-	  *(unsigned short *)cp = len = strlen (oldpath);
-	  memcpy (cp += 2, oldpath, len);
-	  cp += len;
+	  // *(unsigned short *)cp = len = strlen (oldpath);
+	  // memcpy (cp += 2, oldpath, len);
+	  // cp += len;
+	  len = store_path (CP_UTF8, oldpath, CP_ACP, cp + 2); // XXX
+	  *(unsigned short *)cp = len;                         // XXX
+	  cp += len + 2;                                       // XXX
 	  /* Creating a relpath */
 	  if (reloldpath[0])
 	    {
-	      *(unsigned short *)cp = len = strlen (reloldpath);
-	      memcpy (cp += 2, reloldpath, len);
+	      // *(unsigned short *)cp = len = strlen (reloldpath);
+	      // memcpy (cp += 2, reloldpath, len);
+	      len = store_path (CP_UTF8, reloldpath, CP_ACP, cp + 2); // XXX
+	      *(unsigned short *)cp = len;                            // XXX
 	    }
 	  else
 	    {
-	      *(unsigned short *)cp = len = strlen (w32oldpath);
-	      memcpy (cp += 2, w32oldpath, len);
+	      // *(unsigned short *)cp = len = strlen (w32oldpath);
+	      // memcpy (cp += 2, w32oldpath, len);
+	      len = store_path (CP_UTF8, w32oldpath, CP_ACP, cp + 2); // XXX
+	      *(unsigned short *)cp = len;                            // XXX
 	    }
-	  cp += len;
+	  // cp += len;
+	  cp += len + 2;	// XXX
 	  success = WriteFile (h, buf, cp - buf, &written, NULL)
 		    && written == (DWORD) (cp - buf);
 	}
@@ -3014,6 +3063,7 @@ file_not_symlink:
 
 close_it:
   CloseHandle (h);
+  store_path (CP_ACP, contents, CP_UTF8, contents, sizeof (contents)); // XXX
   return res;
 }
 
diff -rup ../../cygwin-1.5.20-1/winsup/cygwin/spawn.cc cygwin/spawn.cc
--- ../../cygwin-1.5.20-1/winsup/cygwin/spawn.cc	2006-06-27 01:10:52.000000000 +0900
+++ cygwin/spawn.cc	2006-07-05 13:55:47.178822400 +0900
@@ -520,8 +520,13 @@ loop:
       GetUserObjectInformation (hdsk, UOI_NAME, dskname, 1024, &n);
       strcat (wstname, "\\");
       strcat (wstname, dskname);
-      si.lpDesktop = wstname;
-
+      // ------------------------------------------------------------
+      int d_len = sys_mbstowcs (NULL, wstname, 0);
+      wchar_t wdesktop[d_len];
+      sys_mbstowcs (wdesktop, wstname, d_len);
+      si.lpDesktop = wdesktop;
+      // si.lpDesktop = wstname;
+      // ------------------------------------------------------------
       rc = CreateProcessAsUser (cygheap->user.primary_token (),
 		       runpath,		/* image name - with full path */
 		       one_line.buf,	/* what was passed to exec */
diff -rup ../../cygwin-1.5.20-1/winsup/cygwin/winsup.h cygwin/winsup.h
--- ../../cygwin-1.5.20-1/winsup/cygwin/winsup.h	2006-06-27 01:10:52.000000000 +0900
+++ cygwin/winsup.h	2006-07-05 13:55:54.399204800 +0900
@@ -121,6 +121,131 @@ int __stdcall sys_wcstombs(char *, int, 
 int __stdcall sys_mbstowcs(WCHAR *, const char *, int)
   __attribute__ ((regparm(3)));
 
+// ----------------------------------------------------------------------
+void* __stdcall CreateFileU (const char*, DWORD, DWORD, SECURITY_ATTRIBUTES*,
+			     DWORD, DWORD, void*);
+#undef CreateFile
+#define CreateFile CreateFileU
+#define CreateFileA CreateFileU
+
+HINSTANCE __stdcall LoadLibraryU (const char* filename);
+#undef LoadLibrary
+#define LoadLibrary LoadLibraryU
+
+void* __stdcall FindFirstFileU (const char* filename, WIN32_FIND_DATAA* buf);
+#undef FindFirstFile
+#define FindFirstFile FindFirstFileU
+#define FindFirstFileA FindFirstFileU
+
+int __stdcall FindNextFileU (void* handle, WIN32_FIND_DATAA* buf);
+#undef FindNextFile
+#define FindNextFile FindNextFileU
+#define FindNextFileA FindNextFileU
+
+int __stdcall SetFileAttributesU (const char* filename, DWORD attr);
+#undef SetFileAttributes
+#define SetFileAttributes SetFileAttributesU
+
+DWORD __stdcall GetFileAttributesU (const char* filename);
+#undef GetFileAttributes
+#define GetFileAttributes GetFileAttributesU
+
+int __stdcall CreateHardLinkU (const char*, const char*, SECURITY_ATTRIBUTES*);
+#undef CreateHardLink
+#define CreateHardLink CreateHardLinkU
+#define CreateHardLinkA CreateHardLinkU
+
+int __stdcall CopyFileU (const char* fname1, const char* fname2, int flag);
+#undef CopyFile
+#define CopyFile CopyFileU
+#define CopyFileA CopyFileU
+
+int __stdcall CreateDirectoryU (const char* fname, SECURITY_ATTRIBUTES*);
+#undef CreateDirectory
+#define CreateDirectory CreateDirectoryU
+#define CreateDirectoryA CreateDirectoryU
+
+int __stdcall RemoveDirectoryU (const char* fname);
+#undef RemoveDirectory
+#define RemoveDirectory RemoveDirectoryU
+#define RemoveDirectoryA RemoveDirectoryU
+
+int __stdcall SetCurrentDirectoryU (const char* fname);
+#undef SetCurrentDirectory
+#define SetCurrentDirectory SetCurrentDirectoryU
+
+DWORD __stdcall GetCurrentDirectoryU (DWORD len, char* buf);
+#undef GetCurrentDirectory
+#define GetCurrentDirectory GetCurrentDirectoryU
+#define GetCurrentDirectoryA GetCurrentDirectoryU
+
+int __stdcall GetFileSecurityU (const char*, SECURITY_INFORMATION,
+				SECURITY_DESCRIPTOR*, DWORD, DWORD*);
+#undef GetFileSecurity
+#define GetFileSecurity GetFileSecurityU
+
+int __stdcall OemToCharBuffU (const char* src, char* dst, DWORD len);
+#undef OemToCharBuff
+#define OemToCharBuff OemToCharBuffU
+
+void* __stdcall CreateMailslotU (const char* name, DWORD maxsize,
+				 DWORD timeout, SECURITY_ATTRIBUTES* attr);
+#undef CreateMailslot
+#define CreateMailslot CreateMailslotU
+
+int __stdcall DeleteFileU (const char* fname);
+#undef DeleteFile
+#define DeleteFile DeleteFileU
+#define DeleteFileA DeleteFileU
+
+int __stdcall MoveFileU (const char* oldname, const char* newname);
+#undef MoveFile
+#define MoveFile MoveFileU
+
+int __stdcall MoveFileExU (const char*, const char*, DWORD);
+#undef MoveFileEx
+#define MoveFileEx MoveFileExU
+
+void* __stdcall CreateNamedPipeU (const char* name, DWORD, DWORD, DWORD,
+				  DWORD, DWORD, DWORD, SECURITY_ATTRIBUTES*);
+#undef CreateNamedPipe
+#define CreateNamedPipe CreateNamedPipeU
+
+#undef STARTUPINFO
+#define STARTUPINFO STARTUPINFOW
+#undef GetStartupInfo
+#define GetStartupInfo GetStartupInfoW
+
+int __stdcall CreateProcessU (const char*, char*,
+			      SECURITY_ATTRIBUTES*, SECURITY_ATTRIBUTES*,
+			      int, DWORD, void*, const char*,
+			      STARTUPINFOW*, PROCESS_INFORMATION *);
+#undef CreateProcess
+#define CreateProcess CreateProcessU
+#define CreateProcessA CreateProcessU
+
+int __stdcall CreateProcessAsUserU (void*, const char*, char*,
+				    SECURITY_ATTRIBUTES*, SECURITY_ATTRIBUTES*,
+				    int, DWORD, void*, const char*,
+				    STARTUPINFOW*, PROCESS_INFORMATION *);
+#undef CreateProcessAsUser
+#define CreateProcessAsUser CreateProcessAsUserU
+
+char* __stdcall GetCommandLineU (void);
+#undef GetCommandLine
+#define GetCommandLine GetCommandLineU
+#define GetCommandLineA GetCommandLineU
+
+int __stdcall SetConsoleTitleU (const char* title);
+#undef SetConsoleTitle
+#define SetConsoleTitle SetConsoleTitleU
+
+DWORD __stdcall GetConsoleTitleU (char* buf, DWORD len);
+#undef GetConsoleTitle
+#define GetConsoleTitle GetConsoleTitleU
+
+// ----------------------------------------------------------------------
+
 /* Used to check if Cygwin DLL is dynamically loaded. */
 extern int dynamically_loaded;
 

--------------020008010707080703010708
Content-Type: text/plain; x-mac-type="0"; x-mac-creator="0";
 name="ChangeLog"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ChangeLog"
Content-length: 2435

2006-07-05  SUZUKI Hisao  <suzuki611@oki.com>

	* fhandler.h (class dev_console): Add utf8buf, utf8count and
	insert_spaces members.
	
	* fhandler_console.cc
	(fhandler_console::read): Replace ReadConsoleInput with
	ReadConsoleInputW and use WideCharToMultiByte to convert Unicode
	to UTF-8.
	(fhandler_console::open): Initialize utf8count.
	(check_for_utf8): New function.
	(fhandler_console::insert_spaces): New function.
	(mock_wcwidth): New function.
	(mock_wswidth): New function.
	(fhandler_console::write_normal): Write Unicode if UTF-8 is given.
	
	* miscfuncs.cc: Does not define _WIN32_WINNT here in order to let
	winsup.h define it as 0x0501.
	(sys_wcstombs): Use CP_UTF8.
	(u_wcstombs): New function.
	(sys_mbstowcs): Use CP_UTF8 and fall back to default code page.
	Handle combining characters (of Japanese, for now).
	(u_size_as_wcs): New function.
	(CreateFileU): New function.
	(LoadLibraryU): New function.
	(copy_find_dataw_to_dataa): New function.
	(FindFirstFileU): New function.
	(FindNextFileU): New function.
	(SetFileAttributesU): New function.
	(GetFileAttributesU): New function.
	(CreateHardLinkU): New function.
	(CopyFileU): New function.
	(CreateDirectoryU): New function.
	(RemoveDirectoryU): New function.
	(SetCurrentDirectoryU): New function.
	(GetCurrentDirectoryU): New function.
	(GetFileSecurityU): New function.
	(OemToCharBuffU): New function.
	(CreateMailslotU): New function.
	(DeleteFileU): New function.
	(MoveFileU): New function.
	(MoveFileExU): New function.
	(CreateNamedPipeU): New function.
	(CreateProcessU): New function.
	(CreateProcessAsUserU): New function.
	(GetCommandLineU): New function.
	(SetConsoleTitleU): New function.
	(GetConsoleTitleU): New function.  
	
	* path.cc (store_path): New function.
	(mount_info::read_mounts): Convert path in default code page to
	UTF-8.
	(mount_info::add_regmount): Convert path in UTF-8 to default code
	page.
	(mount_info::def_reg_mount): Convert path in UTF-8 to default code
	page.
	(symlink_worker): Replace MultiByteToWideChar with sys_mbstowcs in
	order to convert UTF-8 to Unicode.  Convert path in UTF-8 to
	default cope page to create link description and relpath.
	(symlink_info::check_shortcut): Convert path in default code page
	to UTF-8.
	
	* spawn.cc (spawn_guts): Convert name in UTF-8 to Unicode to set
	up lpDesktop member in STARTUPINFOW.

	* wisup.h: Redefine WIN32 API macros to use new functions in
	miscfuncs.cc.
	

--------------020008010707080703010708--
