Return-Path: <cygwin-patches-return-3881-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6114 invoked by alias); 24 May 2003 13:41:57 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 6042 invoked from network); 24 May 2003 13:41:56 -0000
X-Originating-IP: [62.21.237.84]
X-Originating-Email: [mdvpost@hotmail.com]
From: "Micha Nelissen" <mdvpost@hotmail.com>
To: "Corinna Vinschen" <cygwin-patches@cygwin.com>
Subject: End of buffer suppress scroll
Date: Sat, 24 May 2003 13:41:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_013F_01C3220A.FFED1250"
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Message-ID: <BAY1-DAV408dRYtEcNi00028051@hotmail.com>
X-OriginalArrivalTime: 24 May 2003 13:41:55.0577 (UTC) FILETIME=[3D9D5E90:01C321FA]
X-SW-Source: 2003-q2/txt/msg00108.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_013F_01C3220A.FFED1250
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 454

Hi,

This scroll is not with scrollbar, but when adding a line. When a character
is written in right bottom cell, all of buffer is scrolled. With this patch,
the cursor can be 'out of range' while waiting for the first character on
the new line to be written. I have also tried to explain it on my previous
big patch, but it is hard to explain, however easy to see when you've
applied the patch.

Fixes: ssh linux box -> screen -> split screen.

Micha.


------=_NextPart_000_013F_01C3220A.FFED1250
Content-Type: application/octet-stream;
	name="cygwin_eob.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="cygwin_eob.patch"
Content-length: 3484

Index: fhandler.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/fhandler.h,v=0A=
retrieving revision 1.162=0A=
diff -u -p -r1.162 fhandler.h=0A=
--- fhandler.h	12 May 2003 11:06:25 -0000	1.162=0A=
+++ fhandler.h	21 May 2003 14:14:39 -0000=0A=
@@ -754,7 +754,9 @@ class dev_console=0A=
   unsigned rarg;=0A=
   bool saw_question_mark;=0A=
=0A=
+  unsigned char cursor_eob_flag;=0A=
+  DWORD         cursor_eob_mode;=0A=
=0A=
   WORD current_win32_attr;=0A=
   ansi_intensity intensity;=0A=
Index: fhandler_console.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/fhandler_console.cc,v=0A=
retrieving revision 1.110=0A=
diff -u -p -r1.110 fhandler_console.cc=0A=
--- fhandler_console.cc	8 Apr 2003 21:19:33 -0000	1.110=0A=
+++ fhandler_console.cc	21 May 2003 14:14:41 -0000=0A=
@@ -1392,10 +1422,15 @@ fhandler_console::write_normal (const un=0A=
   if (found !=3D src)=0A=
     {=0A=
       DWORD len =3D found - src;=0A=
+      debug_printf("writing %d characters first=3D%d(%c)", len, *src, ispr=
int(*src) ? *src : 32);=0A=
       do=0A=
 	{=0A=
 	  DWORD buf_len;=0A=
 	  char buf[CONVERT_LIMIT];=0A=
+          int x, y;=0A=
+=0A=
+          cursor_get (&x, &y);=0A=
+=0A=
 	  done =3D buf_len =3D min (sizeof (buf), len);=0A=
 	  if (!str_to_con (buf, (const char *) src, buf_len))=0A=
 	    {=0A=
@@ -1407,11 +1442,37 @@ fhandler_console::write_normal (const un=0A=
=0A=
 	  if (dev_state->insert_mode)=0A=
 	    {=0A=
-	      int x, y;=0A=
-	      cursor_get (&x, &y);=0A=
 	      scroll_screen (x, y, -1, y, x + buf_len, y);=0A=
 	    }=0A=
=0A=
+=0A=
+          /* about to scroll? */=0A=
+          if (x + ((signed)buf_len) =3D=3D dev_state->info.dwBufferSize.X =
&&=0A=
+              y + 1 =3D=3D dev_state->info.dwBufferSize.Y)=0A=
+            {=0A=
+              debug_printf ("end of buffer reached, disable WRAP EOL");=0A=
+              dev_state->cursor_eob_flag =3D 1;=0A=
+              GetConsoleMode(get_output_handle(), &dev_state->cursor_eob_m=
ode);=0A=
+              SetConsoleMode(get_output_handle(), dev_state->cursor_eob_mo=
de & ~ENABLE_WRAP_AT_EOL_OUTPUT);=0A=
+            }=0A=
+          else=0A=
+          if (dev_state->cursor_eob_flag =3D=3D 1)=0A=
+            {=0A=
+              debug_printf ("leave end of buffer state, restore WRAP EOL")=
;=0A=
+              dev_state->cursor_eob_flag =3D 0;=0A=
+              SetConsoleMode(get_output_handle(), dev_state->cursor_eob_mo=
de);=0A=
+              /* cursor pos still at end of buffer? then scroll on! */=0A=
+              if (x + 1 =3D=3D dev_state->info.dwBufferSize.X && y + 1 =3D=
=3D dev_state->info.dwBufferSize.Y)=0A=
+              {=0A=
+                unsigned char c[2];=0A=
+                DWORD len;=0A=
+=0A=
+                c[0] =3D '\r';=0A=
+                c[1] =3D '\n';=0A=
+                WriteFile(get_output_handle(), c, 2, &len, NULL);=0A=
+              }=0A=
+            }=0A=
+=0A=
 	  if (!WriteFile (get_output_handle (), buf, buf_len, &done, 0))=0A=
 	    {=0A=
 	      debug_printf ("write failed, handle %p", get_output_handle ());=0A=

------=_NextPart_000_013F_01C3220A.FFED1250
Content-Type: application/octet-stream;
	name="cygwin_eob.changelog"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="cygwin_eob.changelog"
Content-length: 258

2003-05-21  Micha Nelissen  <mdvpost@hotmail.com>=0A=
=0A=
* fhandler.h (dev_console): add cursor end-of-buffer variables.=0A=
=0A=
* fhandler_console.cc (write_normal): end of buffer check moves cursor out =
of=0A=
range without it going to the next line.=

------=_NextPart_000_013F_01C3220A.FFED1250--
