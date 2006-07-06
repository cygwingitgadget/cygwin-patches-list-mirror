Return-Path: <cygwin-patches-return-5916-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18767 invoked by alias); 6 Jul 2006 12:12:42 -0000
Received: (qmail 18756 invoked by uid 22791); 6 Jul 2006 12:12:39 -0000
X-Spam-Check-By: sourceware.org
Received: from mail.artimi.com (HELO mail.artimi.com) (194.72.81.2)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 06 Jul 2006 12:12:34 +0000
Received: from mail.artimi.com ([192.168.1.3]) by mail.artimi.com with Microsoft SMTPSVC(6.0.3790.1830); 	 Thu, 6 Jul 2006 13:12:31 +0100
Received: from rainbow ([192.168.1.165]) by mail.artimi.com with Microsoft SMTPSVC(6.0.3790.1830); 	 Thu, 6 Jul 2006 13:12:31 +0100
From: "Dave Korn" <dave.korn@artimi.com>
To: <cygwin-patches@cygwin.com>
Subject: RE: UTF-8 Cygwin
Date: Thu, 06 Jul 2006 12:12:00 -0000
Message-ID: <037101c6a0f5$749bb130$a501a8c0@CAM.ARTIMI.COM>
MIME-Version: 1.0
Content-Type: multipart/mixed; 	boundary="----=_NextPart_000_0372_01C6A0FD.D6601930"
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <44ACAD7A.403@oki.com>
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q3/txt/msg00011.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_0372_01C6A0FD.D6601930
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 778

On 06 July 2006 07:28, SUZUKI Hisao wrote:


> Sorry, but I cannot access to CVS server because of firewall.  So the
> patch file was made from the cygwin-1.5.20-1-src.

  Here it is, blindly applied to current CVS and then regenerated.  I've
checked that it still builds and I've installed and started running with it.
I'll report any quirks I find, but I'm not likely to be using the UTF-8
features; I'll just look out for any possible breakage of existing stuff.

  Just a couple of comments that I noticed straight away: there's lots of
commented out blocks that should be removed if they aren't going to be used,
and there's a worrying number of XXX tags that suggest some work remains to be
done....?

    cheers,
      DaveK
-- 
Can't think of a witty .sigline today....

------=_NextPart_000_0372_01C6A0FD.D6601930
Content-Type: text/plain;
	name="utf-8-patch-vs-cvs.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="utf-8-patch-vs-cvs.txt"
Content-length: 31978

Index: winsup/cygwin/fhandler.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/fhandler.h,v
retrieving revision 1.297
diff -p -u -r1.297 fhandler.h
--- winsup/cygwin/fhandler.h	5 Jul 2006 15:39:08 -0000	1.297
+++ winsup/cygwin/fhandler.h	6 Jul 2006 09:30:17 -0000
@@ -872,10 +872,13 @@ class dev_console
 class fhandler_console: public fhandler_termios
 {
  private:
+  char utf8buf[4];		// XXX
+  int utf8count;		// XXX
   static dev_console *dev_state;
   static bool invisible_console;
=20
 /* Output calls */
+  void insert_spaces (int);	// XXX
   void set_default_attr ();
=20
   void clear_screen (int, int, int, int);
Index: winsup/cygwin/fhandler_console.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/fhandler_console.cc,v
retrieving revision 1.165
diff -p -u -r1.165 fhandler_console.cc
--- winsup/cygwin/fhandler_console.cc	3 Jul 2006 15:29:10 -0000	1.165
+++ winsup/cygwin/fhandler_console.cc	6 Jul 2006 09:30:17 -0000
@@ -292,7 +292,8 @@ fhandler_console::read (void *pv, size_t
       INPUT_RECORD input_rec;
       const char *toadd =3D NULL;
=20
-      if (!ReadConsoleInput (h, &input_rec, 1, &nread))
+      // if (!ReadConsoleInput (h, &input_rec, 1, &nread))
+      if (!ReadConsoleInputW (h, &input_rec, 1, &nread)) // XXX
 	{
 	  syscall_printf ("ReadConsoleInput failed, %E");
 	  goto err;		/* seems to be failure */
@@ -376,11 +377,13 @@ fhandler_console::read (void *pv, size_t
 	    }
 	  else
 	    {
-	      tmp[1] =3D ich;
+	      // XXX tmp[1] =3D ich;
+	      nread =3D WideCharToMultiByte (CP_UTF8, 0, &wch, 1,
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
@@ -643,6 +646,7 @@ fhandler_console::open (int flags, mode_
 {
   HANDLE h;
=20
+  utf8count =3D 0;		// XXX
   tcinit (get_tty_stuff (flags));
=20
   set_io_handle (NULL);
@@ -1453,6 +1457,68 @@ beep ()
   MessageBeep (MB_OK);
 }
=20
+static int
+check_for_utf8(const char* buf, int count) // XXX
+{
+  if (count > 0)
+    {
+      int ch =3D buf[0];
+      int size =3D 0;
+      if ((ch & 0x80) =3D=3D 0x00)	// 0xxx_xxxx
+	size =3D 1;
+      else if ((ch & 0xE0) =3D=3D 0xC0) // 110x_xxxx 10xx_xxxx
+	size =3D 2;
+      else if ((ch & 0xF0) =3D=3D 0xE0) // 1110_xxxx (10xx_xxxx)* 2
+	size =3D 3;
+      else if ((ch & 0xF8) =3D=3D 0xF0) // 1111_0xxx (10xx_xxxx) * 3
+	size =3D 4;
+      else
+	return -1;		// Not UTF-8
+      int rest =3D size - 1;
+      for (int i =3D 1; i < count && 0 < rest; i++, rest--)
+	{
+	  if ((buf[i] & 0xC0) !=3D 0x80)
+	    return -1;		// Not UTF-8
+	}
+      if (rest =3D=3D 0)
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
+  if ((0x2E80 <=3D w && w <=3D 0xFAFF) ||
+      (0xFE30 <=3D w && w <=3D 0xFE4F) ||
+      (0xFF00 <=3D w && w <=3D 0xFF60))
+    return 2;
+  else
+    return 1;
+}
+
+static int
+mock_wswidth (wchar_t* ws, int len) // XXX
+{
+  int sum =3D 0;
+  for (int i =3D 0; i < len; i++)
+    sum +=3D mock_wcwidth (ws[i]);
+  return sum;
+}
+
 const unsigned char *
 fhandler_console::write_normal (const unsigned char *src,
 				const unsigned char *end)
@@ -1478,22 +1544,86 @@ fhandler_console::write_normal (const un
 	  DWORD buf_len;
 	  char buf[CONVERT_LIMIT];
 	  done =3D buf_len =3D min (sizeof (buf), len);
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
+	  void* oh =3D get_output_handle ();
+	  DWORD dummy;
+	  int r =3D 1;
+	  if (utf8count > 0)
+	    {
+	      utf8buf[utf8count++] =3D buf[0];
+	      done =3D 1;
+	      int i =3D check_for_utf8 (utf8buf, utf8count);
+	      if (i < 0)	// not utf-8
+		{
+		  insert_spaces (utf8count);
+		  r =3D WriteFile (oh, utf8buf, utf8count, &dummy, 0);
+		  utf8count =3D 0;
+		}
+	      else if (i > 0)	// a complete utf-8 bytes
+		{
+		  wchar_t wch =3D L'_';
+		  MultiByteToWideChar (CP_UTF8, 0, utf8buf, i, &wch, 1);
+		  insert_spaces (mock_wcwidth (wch));
+		  r =3D WriteConsoleW (oh, &wch, 1, &dummy, 0);
+		  utf8count =3D 0;
+		}
 	    }
-
-	  if (dev_state->insert_mode)
+	  else
 	    {
-	      int x, y;
-	      cursor_get (&x, &y);
-	      scroll_screen (x, y, -1, y, x + buf_len, y);
+	      r =3D MultiByteToWideChar (CP_UTF8, MB_ERR_INVALID_CHARS,
+				       buf, buf_len, 0, 0);
+	      if (r =3D=3D 0)
+		{
+		  int i =3D check_for_utf8 (buf, buf_len);
+		  if (i > 0)
+		    {
+		      done =3D i;
+		      wchar_t wch =3D L'o';
+		      MultiByteToWideChar (CP_UTF8, 0, buf, i, &wch, 1);
+		      insert_spaces (mock_wcwidth (wch));
+		      r =3D WriteConsoleW (oh, &wch, 1, &dummy, 0);
+		    }
+		  else if (i =3D=3D 0)
+		    {
+		      utf8buf[utf8count++] =3D buf[0];
+		      done =3D 1;
+		      r =3D 1;
+		    }
+		  else
+		    {
+		      insert_spaces (buf_len);
+		      r =3D WriteFile (oh, buf, buf_len, &done, 0);
+		    }
+		}
+	      else
+		{
+		  wchar_t wbuf[r];
+		  MultiByteToWideChar (CP_UTF8, 0, buf, buf_len, wbuf, r);=20
+		  insert_spaces (mock_wswidth (wbuf, r));
+		  r =3D WriteConsoleW (oh, wbuf, r, &done, 0);
+		  // Now, "done" equals to the number of chars written.
+		  done =3D WideCharToMultiByte (CP_UTF8, 0, wbuf, done,
+					      0, 0, 0, 0);
+		}
 	    }
-
-	  if (!WriteFile (get_output_handle (), buf, buf_len, &done, 0))
+	  if (r =3D=3D 0)
+	  // XXX >>
 	    {
 	      debug_printf ("write failed, handle %p", get_output_handle ());
 	      __seterrno ();
@@ -1508,6 +1638,7 @@ fhandler_console::write_normal (const un
   if (src < end)
     {
       int x, y;
+      utf8count =3D 0;		// XXX
       switch (base_chars[*src])
 	{
 	case BEL:
Index: winsup/cygwin/miscfuncs.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/miscfuncs.cc,v
retrieving revision 1.41
diff -p -u -r1.41 miscfuncs.cc
--- winsup/cygwin/miscfuncs.cc	28 May 2006 15:50:14 -0000	1.41
+++ winsup/cygwin/miscfuncs.cc	6 Jul 2006 09:30:17 -0000
@@ -9,7 +9,7 @@ This software is a copyrighted work lice
 Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
 details. */
=20
-#define _WIN32_WINNT 0x400
+//#define _WIN32_WINNT 0x400
 #include "winsup.h"
 #include "cygerrno.h"
 #include <sys/errno.h>
@@ -210,29 +210,430 @@ get_cp ()
   return current_codepage =3D=3D ansi_cp ? GetACP() : GetOEMCP();
 }
=20
+=0C
+// ----------------------------------------------------------------------
 /* tlen is always treated as the maximum buffer size, including the '\0'
    character.  sys_wcstombs will always return a 0-terminated result, no
    matter what. */
 int __stdcall
 sys_wcstombs (char *tgt, int tlen, const WCHAR *src, int slen)
 {
-  int ret;
-
-  ret =3D WideCharToMultiByte (get_cp (), 0, src, slen, tgt, tlen, NULL, N=
ULL);
+  int ret =3D WideCharToMultiByte (CP_UTF8, 0, src, slen, tgt, tlen, NULL,=
 NULL);
   if (ret)
-    tgt[ret < tlen ? ret : tlen - 1] =3D '\0';
+    tgt[(ret < tlen) ? ret : tlen - 1] =3D '\0';
   return ret;
 }
=20
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
+  int r =3D MultiByteToWideChar (CP_UTF8, MB_ERR_INVALID_CHARS,
+			       src, -1, tgt, len);
+  if (r =3D=3D 0)			// fall back to default cp.
+    {
+      r =3D MultiByteToWideChar (get_cp (), 0, src, -1, tgt, len);
+      if (r =3D=3D 0)
+	debug_printf ("MultiByteToWideChar %E");
+    }
+  else if (len > 0)
+    {			      // for COMBINING KANA (SEMI-)VOICED MARK
+      wchar_t* p =3D tgt;
+      wchar_t* q =3D tgt;
+      wchar_t c0 =3D *p++;
+      for (;;)
+	{
+	  if (c0 =3D=3D 0)
+	    {
+	      *q =3D 0x0000;
+	      break;
+	    }
+	  wchar_t c1 =3D *p++;
+	  if (c1 =3D=3D 0x3099)	// combining kana voiced mark
+	    {
+	      if (c0 =3D=3D 0x3046) // hiragana "U"
+		c0 =3D 0x3094;
+	      if (c0 =3D=3D 0x30a6) // katakana "U"
+		c0 =3D 0x30f4;
+	      else if (0x30ef <=3D c0 && c0 <=3D 0x30f2) //  katakana "WA" - "WO"
+		c0 +=3D 8;
+	      else if (0x3031 <=3D c0 && c0 <=3D 0x30ff) // XXX
+		c0 +=3D 1;
+	      else		// XXX
+		{
+		  *q++ =3D c0;
+		  c0 =3D 0x309b;	// kana voiced mark
+		  r++;
+		}
+	      r--;
+	      *q++ =3D c0;
+	      c0 =3D *p++;
+	    }
+	  else if (c1 =3D=3D 0x309a)
+	    {			// XXX
+	      if ((0x306f <=3D c0 && c0 <=3D 0x307b) || // hiragana "HA" - "HO"
+		  (0x30cf <=3D c0 && c0 <=3D 0x30db)) // katakana "HA" - "HO"
+		c0 +=3D 2;
+	      else
+		{
+		  *q++ =3D c0;
+		  c0 =3D 0x309c;	// kana semi-voiced mark
+		  r++;
+		}
+	      r--;
+	      *q++ =3D c0;
+	      c0 =3D *p++;
+	    }
+	  else			// XXX combining grave, acute etc?
+	    {
+	      *q++ =3D c0;
+	      c0 =3D c1;
+	    }
+	}
+    }
+  return r;
+}
+
+static int
+u_size_as_wcs (const char* src)
+{
+  int r =3D MultiByteToWideChar (CP_UTF8, MB_ERR_INVALID_CHARS,
+			       src, -1, NULL, 0);
+  if (r =3D=3D 0)			// fall back to default cp.
+    r =3D MultiByteToWideChar (get_cp (), 0, src, -1, NULL, 0);
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
+=20=20=20=20
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
+copy_find_dataw_to_dataa (const WIN32_FIND_DATAW* wbuf, WIN32_FIND_DATAA* =
buf)
+{
+  buf->dwFileAttributes =3D wbuf->dwFileAttributes;
+  buf->ftCreationTime =3D wbuf->ftCreationTime;
+  buf->ftLastAccessTime =3D wbuf->ftLastAccessTime;
+  buf->ftLastWriteTime =3D wbuf->ftLastWriteTime;
+  buf->nFileSizeHigh =3D wbuf->nFileSizeHigh;
+  buf->nFileSizeLow =3D wbuf->nFileSizeLow;
+  buf->dwReserved0 =3D wbuf->dwReserved0;
+  buf->dwReserved1 =3D wbuf->dwReserved1;
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
+      void* r =3D FindFirstFileW (wname, &wbuf);
+      if (r !=3D INVALID_HANDLE_VALUE)
+	copy_find_dataw_to_dataa (&wbuf, buf);
+      return r;
+    }
+}
+
+int __stdcall
+FindNextFileU (void* handle, WIN32_FIND_DATAA* buf)
+{
+  WIN32_FIND_DATAW wbuf;
+  wbuf.dwFileAttributes =3D buf->dwFileAttributes;
+  wbuf.ftCreationTime =3D buf->ftCreationTime;
+  wbuf.ftLastAccessTime =3D buf->ftLastAccessTime;
+  wbuf.ftLastWriteTime =3D buf->ftLastWriteTime;
+  wbuf.nFileSizeHigh =3D buf->nFileSizeHigh;
+  wbuf.nFileSizeLow =3D buf->nFileSizeLow;
+  wbuf.dwReserved0 =3D buf->dwReserved0;
+  wbuf.dwReserved1 =3D buf->dwReserved1;
+  u_mbstowcs (wbuf.cFileName, buf->cFileName, MAX_PATH);
+  MultiByteToWideChar (get_cp(), 0, buf->cAlternateFileName, -1,
+		       wbuf.cAlternateFileName, 14);
+  int r =3D FindNextFileW (handle, &wbuf);
+  if (r !=3D 0)
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
-  int res =3D MultiByteToWideChar (get_cp (), 0, src, -1, tgt, len);
-  if (!res)
-    debug_printf ("MultiByteToWideChar %E");
-  return res;
+  wchar_t wname[CYG_MAX_PATH];
+  if (!u_mbstowcs (wname, fname, CYG_MAX_PATH))
+    return 0;
+  return CreateDirectoryW (wname, attr);
 }
=20
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
+  DWORD n =3D GetCurrentDirectoryW (CYG_MAX_PATH, wbuf);
+  if (n =3D=3D 0)
+    return 0;			// failed
+
+  DWORD necessary_size =3D u_wcstombs (NULL, wbuf, 0);
+  if (len < necessary_size)
+    return necessary_size;
+
+  DWORD written_size =3D u_wcstombs (buf, wbuf, len);
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
+  int size =3D u_size_as_wcs (name);
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
+  int alen =3D (appname =3D=3D NULL) ? 0 : u_size_as_wcs (appname);
+  wchar_t wappname[alen];
+  if (appname !=3D NULL && !u_mbstowcs (wappname, appname, alen))
+    return 0;
+
+  int cllen =3D (commandline =3D=3D NULL) ? 0 : u_size_as_wcs (commandline=
);
+  wchar_t wcommandline[cllen];
+  if (commandline !=3D NULL && !u_mbstowcs (wcommandline, commandline, cll=
en))
+    return 0;
+
+  int cwlen =3D (cwd =3D=3D NULL) ? 0 : u_size_as_wcs (cwd);
+  wchar_t wcwd[cwlen];
+  if (cwd !=3D NULL && !u_mbstowcs (wcwd, cwd, cwlen))
+    return 0;
+
+  return CreateProcessW ((appname =3D=3D NULL) ? NULL : wappname,
+			 (commandline =3D=3D NULL) ? NULL : wcommandline,
+			 pattr, tattr, inherit, crflags, env,
+			 (cwd =3D=3D NULL) ? NULL : wcwd,
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
+  int alen =3D (appname =3D=3D NULL) ? 0 : u_size_as_wcs (appname);
+  wchar_t wappname[alen];
+  if (appname !=3D NULL && !u_mbstowcs (wappname, appname, alen))
+    return 0;
+
+  int cllen =3D (commandline =3D=3D NULL) ? 0 : u_size_as_wcs (commandline=
);
+  wchar_t wcommandline[cllen];
+  if (commandline !=3D NULL && !u_mbstowcs (wcommandline, commandline, cll=
en))
+    return 0;
+
+  int cwlen =3D (cwd =3D=3D NULL) ? 0 : u_size_as_wcs (cwd);
+  wchar_t wcwd[cwlen];
+  if (cwd !=3D NULL && !u_mbstowcs (wcwd, cwd, cwlen))
+    return 0;
+
+  return CreateProcessAsUserW (handle,
+			       (appname =3D=3D NULL) ? NULL : wappname,
+			       (commandline =3D=3D NULL) ? NULL : wcommandline,
+			       pattr, tattr, inherit, crflags, env,
+			       (cwd =3D=3D NULL) ? NULL : wcwd,
+			       sinfo, pinfo);
+}
+
+#undef GetCommandLineA
+char* __stdcall
+GetCommandLineU (void)
+{
+  static char line[35000];	// XXX
+  wchar_t* wline =3D GetCommandLineW ();
+  if (!u_wcstombs (line, wline, 35000))
+    return GetCommandLineA ();	// XXX
+  return line;
+}
+
+int __stdcall
+SetConsoleTitleU (const char* title)
+{
+  int size =3D u_size_as_wcs (title);
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
+  DWORD r =3D GetConsoleTitleW (wbuf, len);
+  u_wcstombs (buf, wbuf, len);
+  return r;
+}
+
+// ----------------------------------------------------------------------
+=0C
+
 extern "C" int
 low_priority_sleep (DWORD secs)
 {
Index: winsup/cygwin/path.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/path.cc,v
retrieving revision 1.411
diff -p -u -r1.411 path.cc
--- winsup/cygwin/path.cc	5 Jul 2006 08:35:51 -0000	1.411
+++ winsup/cygwin/path.cc	6 Jul 2006 09:30:18 -0000
@@ -158,6 +158,22 @@ struct win_shortcut_hdr
   (devn =3D=3D FH_CYGDRIVE || devn =3D=3D FH_PROC || devn =3D=3D FH_REGIST=
RY \
    || devn =3D=3D FH_PROCESS || devn =3D=3D FH_NETDRIVE )
=20
+// XXX
+static int
+store_path (UINT fromCP, const char* path, UINT toCP, char* dst,
+	    int maxlen =3D CYG_MAX_PATH)
+{
+  int wlen =3D (fromCP =3D=3D CP_UTF8) ?
+    sys_mbstowcs (NULL, path, 0) :
+    MultiByteToWideChar (fromCP, 0, path, -1, NULL, 0);
+  wchar_t wpath[wlen];
+  (fromCP =3D=3D CP_UTF8) ?
+    sys_mbstowcs (wpath, path, wlen):
+    MultiByteToWideChar (fromCP, 0, path, -1, wpath, wlen);
+  int len =3D WideCharToMultiByte (toCP, 0, wpath, -1, dst, maxlen, NULL, =
NULL);
+  return len - 1;		// exclude the byte for '\0'
+}
+
 /* Return non-zero if PATH1 is a prefix of PATH2.
    Both are assumed to be of the same path style and / vs \ usage.
    Neither may be "".
@@ -1999,7 +2015,16 @@ mount_info::read_mounts (reg_key& r)
       mount_flags =3D subkey.get_int ("flags", 0);
=20
       /* Add mount_item corresponding to registry mount point. */
-      res =3D mount_table->add_item (native_path, posix_path, mount_flags,=
 false);
+      //res =3D mount_table->add_item (native_path, posix_path, mount_flag=
s, false);
+      // XXX <<<
+      char native_path2[CYG_MAX_PATH];
+      char posix_path2[CYG_MAX_PATH];
+      store_path (CP_ACP, native_path, CP_UTF8, native_path2);
+      store_path (CP_ACP, posix_path, CP_UTF8, posix_path2);
+      res =3D mount_table->add_item (native_path2, posix_path2, mount_flag=
s,
+				   false);
+      // XX >>>
+
       if (res && get_errno () =3D=3D EMFILE)
 	break; /* The number of entries exceeds MAX_MOUNTS */
     }
@@ -2037,6 +2062,15 @@ mount_info::from_registry ()
 int
 mount_info::add_reg_mount (const char *native_path, const char *posix_path=
, unsigned mountflags)
 {
+  // XXX <<<
+  char native_path2[CYG_MAX_PATH];
+  char posix_path2[CYG_MAX_PATH];
+  store_path (CP_UTF8, native_path, CP_ACP, native_path2);
+  store_path (CP_UTF8, posix_path, CP_ACP, posix_path2);
+  native_path =3D native_path2;
+  posix_path =3D posix_path2;
+  // XX >>>
+
   int res;
=20
   /* Add the mount to the right registry location, depending on
@@ -2077,6 +2111,12 @@ mount_info::add_reg_mount (const char *n
 int
 mount_info::del_reg_mount (const char * posix_path, unsigned flags)
 {
+  // XXX <<<
+  char posix_path2[CYG_MAX_PATH];
+  store_path (CP_UTF8, posix_path, CP_ACP, posix_path2);
+  posix_path =3D posix_path2;
+  // XX >>>
+
   int res;
=20
   reg_key reg (flags & MOUNT_SYSTEM, KEY_ALL_ACCESS,
@@ -2852,8 +2892,9 @@ symlink_worker (const char *oldpath, con
 	  hres =3D SHGetDesktopFolder (&psl);
 	  if (SUCCEEDED (hres))
 	    {
-	      MultiByteToWideChar (CP_ACP, 0, w32oldpath, -1, wc_path,
-				   CYG_MAX_PATH);
+	      //MultiByteToWideChar (CP_ACP, 0, w32oldpath, -1, wc_path,
+	      //		     CYG_MAX_PATH);
+	      sys_mbstowcs (wc_path, w32oldpath, CYG_MAX_PATH);	// XXX
 	      hres =3D psl->ParseDisplayName (NULL, NULL, wc_path, NULL,
 					    &pidl, NULL);
 	      if (SUCCEEDED (hres))
@@ -2871,21 +2912,29 @@ symlink_worker (const char *oldpath, con
 	      psl->Release ();
 	    }
 	  /* Creating a description */
-	  *(unsigned short *)cp =3D len =3D strlen (oldpath);
-	  memcpy (cp +=3D 2, oldpath, len);
-	  cp +=3D len;
+	  // *(unsigned short *)cp =3D len =3D strlen (oldpath);
+	  // memcpy (cp +=3D 2, oldpath, len);
+	  // cp +=3D len;
+	  len =3D store_path (CP_UTF8, oldpath, CP_ACP, cp + 2); // XXX
+	  *(unsigned short *)cp =3D len;                         // XXX
+	  cp +=3D len + 2;                                       // XXX
 	  /* Creating a relpath */
 	  if (reloldpath[0])
 	    {
-	      *(unsigned short *)cp =3D len =3D strlen (reloldpath);
-	      memcpy (cp +=3D 2, reloldpath, len);
+	      // *(unsigned short *)cp =3D len =3D strlen (reloldpath);
+	      // memcpy (cp +=3D 2, reloldpath, len);
+	      len =3D store_path (CP_UTF8, reloldpath, CP_ACP, cp + 2); // XXX
+	      *(unsigned short *)cp =3D len;                            // XXX
 	    }
 	  else
 	    {
-	      *(unsigned short *)cp =3D len =3D strlen (w32oldpath);
-	      memcpy (cp +=3D 2, w32oldpath, len);
+	      // *(unsigned short *)cp =3D len =3D strlen (w32oldpath);
+	      // memcpy (cp +=3D 2, w32oldpath, len);
+	      len =3D store_path (CP_UTF8, w32oldpath, CP_ACP, cp + 2); // XXX
+	      *(unsigned short *)cp =3D len;                            // XXX
 	    }
-	  cp +=3D len;
+	  // cp +=3D len;
+	  cp +=3D len + 2;	// XXX
 	  success =3D WriteFile (h, buf, cp - buf, &written, NULL)
 		    && written =3D=3D (DWORD) (cp - buf);
 	}
@@ -2990,6 +3039,7 @@ file_not_symlink:
=20
 close_it:
   CloseHandle (h);
+  store_path (CP_ACP, contents, CP_UTF8, contents, sizeof (contents)); // =
XXX
   return res;
 }
=20
Index: winsup/cygwin/spawn.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/spawn.cc,v
retrieving revision 1.232
diff -p -u -r1.232 spawn.cc
--- winsup/cygwin/spawn.cc	28 May 2006 15:50:14 -0000	1.232
+++ winsup/cygwin/spawn.cc	6 Jul 2006 09:30:18 -0000
@@ -520,8 +520,13 @@ loop:
       GetUserObjectInformation (hdsk, UOI_NAME, dskname, 1024, &n);
       strcat (wstname, "\\");
       strcat (wstname, dskname);
-      si.lpDesktop =3D wstname;
-
+      // ------------------------------------------------------------
+      int d_len =3D sys_mbstowcs (NULL, wstname, 0);
+      wchar_t wdesktop[d_len];
+      sys_mbstowcs (wdesktop, wstname, d_len);
+      si.lpDesktop =3D wdesktop;
+      // si.lpDesktop =3D wstname;
+      // ------------------------------------------------------------
       rc =3D CreateProcessAsUser (cygheap->user.primary_token (),
 		       runpath,		/* image name - with full path */
 		       one_line.buf,	/* what was passed to exec */
Index: winsup/cygwin/winsup.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/winsup.h,v
retrieving revision 1.188
diff -p -u -r1.188 winsup.h
--- winsup/cygwin/winsup.h	2 Jun 2006 00:09:50 -0000	1.188
+++ winsup/cygwin/winsup.h	6 Jul 2006 09:30:18 -0000
@@ -121,6 +121,131 @@ int __stdcall sys_wcstombs(char *, int,=20
 int __stdcall sys_mbstowcs(WCHAR *, const char *, int)
   __attribute__ ((regparm(3)));
=20
+// ----------------------------------------------------------------------
+void* __stdcall CreateFileU (const char*, DWORD, DWORD, SECURITY_ATTRIBUTE=
S*,
+			     DWORD, DWORD, void*);
+#undef CreateFile
+#define CreateFile CreateFileU
+#define CreateFileA CreateFileU
+
+HINSTANCE __stdcall LoadLibraryU (const char* filename);
+#undef LoadLibrary
+#define LoadLibrary LoadLibraryU
+
+void* __stdcall FindFirstFileU (const char* filename, WIN32_FIND_DATAA* bu=
f);
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
+int __stdcall CreateHardLinkU (const char*, const char*, SECURITY_ATTRIBUT=
ES*);
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
=20

------=_NextPart_000_0372_01C6A0FD.D6601930--
