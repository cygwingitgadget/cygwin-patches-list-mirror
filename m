Return-Path: <cygwin-patches-return-3864-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1988 invoked by alias); 21 May 2003 15:32:36 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1933 invoked from network); 21 May 2003 15:32:35 -0000
X-Originating-IP: [62.21.237.84]
X-Originating-Email: [mdvpost@hotmail.com]
From: "Micha Nelissen" <mdvpost@hotmail.com>
To: <cygwin-patches@cygwin.com>
Subject: Patch for line draw characters problem & screen scrolling
Date: Wed, 21 May 2003 15:32:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0026_01C31FBE.F6786B00"
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Message-ID: <BAY1-DAV24HHGNZ4mF100020af2@hotmail.com>
X-OriginalArrivalTime: 21 May 2003 15:32:33.0914 (UTC) FILETIME=[3321F5A0:01C31FAE]
X-SW-Source: 2003-q2/txt/msg00091.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_0026_01C31FBE.F6786B00
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 386

Hi,

Several problems encountered and tried to fix:

1) line draw characters not showing up in combination Command Prompt with
bash.
2) screen scrolling fixed for termcap entry 'cs' -> screen split is very
fast and cool.
3) end-of-buffer cursor out of range; see changelog for more details.

This is my first patch, so please don't flame ;). I am open to suggestions.

Regards,

Micha.

------=_NextPart_000_0026_01C31FBE.F6786B00
Content-Type: application/octet-stream;
	name="cygwin.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="cygwin.patch"
Content-length: 12439

Index: fhandler.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/fhandler.h,v=0A=
retrieving revision 1.162=0A=
diff -u -p -r1.162 fhandler.h=0A=
--- fhandler.h	12 May 2003 11:06:25 -0000	1.162=0A=
+++ fhandler.h	21 May 2003 14:14:39 -0000=0A=
@@ -754,7 +754,11 @@ class dev_console=0A=
   unsigned rarg;=0A=
   bool saw_question_mark;=0A=
=20=0A=
+  int prev_title_len;=0A=
   char my_title_buf [TITLESIZE + 1];=0A=
+=0A=
+  unsigned char cursor_eob_flag;=0A=
+  DWORD         cursor_eob_mode;=0A=
=20=0A=
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
@@ -78,8 +78,10 @@ str_to_con (char *d, const char *s, DWOR=0A=
  * Negative values represents current screen dimensions=0A=
  */=0A=
=20=0A=
-#define srTop (dev_state->info.winTop + dev_state->scroll_region.Top)=0A=
-#define srBottom ((dev_state->scroll_region.Bottom < 0) ? dev_state->info.=
winBottom : dev_state->info.winTop + dev_state->scroll_region.Bottom)=0A=
+//#define srTop (dev_state->info.winTop + dev_state->scroll_region.Top)=0A=
+//#define srBottom ((dev_state->scroll_region.Bottom < 0) ? dev_state->inf=
o.winBottom : dev_state->info.winTop + dev_state->scroll_region.Bottom)=0A=
+#define srTop (dev_state->scroll_region.Top)=0A=
+#define srBottom ((dev_state->scroll_region.Bottom < 0) ? dev_state->info.=
winBottom : dev_state->scroll_region.Bottom)=0A=
=20=0A=
 #define use_tty ISSTATE (myself, PID_USETTY)=0A=
=20=0A=
@@ -112,6 +114,10 @@ fhandler_console::get_tty_stuff (int fla=0A=
       shared_console_info->tty_min_state.setsid (myself->sid);=0A=
       shared_console_info->tty_min_state.set_ctty (TTY_CONSOLE, flags);=0A=
=20=0A=
+      GetConsoleTitle(dev_state->my_title_buf, TITLESIZE);=0A=
+      dev_state->prev_title_len =3D strlen(dev_state->my_title_buf);=0A=
+      strcpy(dev_state->my_title_buf+dev_state->prev_title_len, " | ");=0A=
+      dev_state->prev_title_len +=3D 3;=0A=
       dev_state->scroll_region.Bottom =3D -1;=0A=
       dev_state->dwLastCursorPosition.X =3D -1;=0A=
       dev_state->dwLastCursorPosition.Y =3D -1;=0A=
@@ -554,44 +560,59 @@ fhandler_console::fillin_info (void)=0A=
 void=0A=
 fhandler_console::scroll_screen (int x1, int y1, int x2, int y2, int xn, i=
nt yn)=0A=
 {=0A=
-  SMALL_RECT sr1, sr2;=0A=
+  SMALL_RECT srScroll, srClip;=0A=
   CHAR_INFO fill;=0A=
   COORD dest;=0A=
=20=0A=
   (void) fillin_info ();=0A=
-  sr1.Left =3D x1 >=3D 0 ? x1 : dev_state->info.dwWinSize.X - 1;=0A=
+  srScroll.Left  =3D x1 >=3D 0 ? x1 : dev_state->info.dwWinSize.X - 1;=0A=
+  srScroll.Right =3D x2 >=3D 0 ? x2 : dev_state->info.dwWinSize.X - 1;=0A=
   if (y1 =3D=3D 0)=0A=
-    sr1.Top =3D dev_state->info.winTop;=0A=
+    srScroll.Top =3D dev_state->info.winTop;=0A=
   else=0A=
-    sr1.Top =3D y1 > 0 ? y1 : dev_state->info.winBottom;=0A=
-  sr1.Right =3D x2 >=3D 0 ? x2 : dev_state->info.dwWinSize.X - 1;=0A=
+  if (y1 <  0)=0A=
+    srScroll.Top =3D dev_state->info.winBottom;=0A=
+  else=0A=
+    srScroll.Top =3D y1;=0A=
   if (y2 =3D=3D 0)=0A=
-    sr1.Bottom =3D dev_state->info.winTop;=0A=
+    srScroll.Bottom =3D dev_state->info.winTop;=0A=
+  else=0A=
+  if (y2 <  0)=0A=
+    srScroll.Bottom =3D dev_state->info.winBottom;=0A=
   else=0A=
-    sr1.Bottom =3D y2 > 0 ? y2 : dev_state->info.winBottom;=0A=
-  sr2.Top =3D srTop;=0A=
-  sr2.Left =3D 0;=0A=
-  sr2.Bottom =3D srBottom;=0A=
-  sr2.Right =3D dev_state->info.dwWinSize.X - 1;=0A=
-  if (sr1.Bottom > sr2.Bottom && sr1.Top <=3D sr2.Bottom)=0A=
-    sr1.Bottom =3D sr2.Bottom;=0A=
+    srScroll.Bottom =3D y2;=0A=
+  srClip.Top =3D srTop;=0A=
+  srClip.Left =3D 0;=0A=
+  srClip.Bottom =3D srBottom;=0A=
+  srClip.Right =3D dev_state->info.dwWinSize.X - 1;=0A=
+  if (srScroll.Top    < srClip.Top    && srScroll.Bottom >=3D srClip.Botto=
m)=0A=
+    srScroll.Top =3D srClip.Top;=0A=
+  if (srScroll.Bottom > srClip.Bottom && srScroll.Top    <=3D srClip.Botto=
m)=0A=
+    srScroll.Bottom =3D srClip.Bottom;=0A=
   dest.X =3D xn >=3D 0 ? xn : dev_state->info.dwWinSize.X - 1;=0A=
   if (yn =3D=3D 0)=0A=
     dest.Y =3D dev_state->info.winTop;=0A=
   else=0A=
-    dest.Y =3D yn > 0 ? yn : dev_state->info.winBottom;=0A=
+  if (yn <  0)=0A=
+    dest.Y =3D dev_state->info.winBottom;=0A=
+  else=0A=
+    dest.Y =3D yn;=0A=
   fill.Char.AsciiChar =3D ' ';=0A=
   fill.Attributes =3D dev_state->current_win32_attr;=0A=
-  ScrollConsoleScreenBuffer (get_output_handle (), &sr1, &sr2, dest, &fill=
);=0A=
+=0A=
+  debug_printf("screen_scroll with parameters: ul=3D%d,%d br=3D%d,%d nul=
=3D%d,%d scroll=3D%d,%d;%d,%d clip=3D%d,%d;%d,%d dest=3D%d,%d",=0A=
+    x1,y1,x2,y2,xn,yn,srScroll.Left,srScroll.Top,srScroll.Right,srScroll.B=
ottom,srClip.Left,srClip.Top,srClip.Right,srClip.Bottom,dest.X,dest.Y);=0A=
+=0A=
+  ScrollConsoleScreenBuffer (get_output_handle (), &srScroll, &srClip, des=
t, &fill);=0A=
=20=0A=
   /* ScrollConsoleScreenBuffer on Windows 95 is buggy - when scroll distan=
ce=0A=
    * is more than half of screen, filling doesn't work as expected */=0A=
=20=0A=
-  if (sr1.Top !=3D sr1.Bottom)=0A=
-    if (dest.Y <=3D sr1.Top)	/* forward scroll */=0A=
-      clear_screen (0, 1 + dest.Y + sr1.Bottom - sr1.Top, sr2.Right, sr2.B=
ottom);=0A=
+  if (srScroll.Top !=3D srScroll.Bottom)=0A=
+    if (dest.Y <=3D srScroll.Top)	/* forward scroll */=0A=
+      clear_screen (0, 1 + dest.Y + srScroll.Bottom - srScroll.Top, srClip=
.Right, srClip.Bottom);=0A=
     else			/* reverse scroll */=0A=
-      clear_screen (0, sr1.Top, sr2.Right, dest.Y - 1);=0A=
+      clear_screen (0, srScroll.Top, srClip.Right, dest.Y - 1);=0A=
 }=0A=
=20=0A=
 int=0A=
@@ -1023,7 +1044,7 @@ static const char base_chars[256] =3D=0A=
 /*10 11 12 13 14 15 16 17 */ NOR, NOR, ERR, ERR, ERR, ERR, ERR, ERR,=0A=
 /*18 19 1A 1B 1C 1D 1E 1F */ NOR, NOR, ERR, ESC, ERR, ERR, ERR, ERR,=0A=
 /*   !  "  #  $  %  &  '  */ NOR, NOR, NOR, NOR, NOR, NOR, NOR, NOR,=0A=
-/*()  *  +  ,  -  .  /  */ NOR, NOR, NOR, NOR, NOR, NOR, NOR, NOR,=0A=
+/*(  )  *  +  ,  -  .  /  */ NOR, NOR, NOR, NOR, NOR, NOR, NOR, NOR,=0A=
 /*0  1  2  3  4  5  6  7  */ NOR, NOR, NOR, NOR, NOR, NOR, NOR, NOR,=0A=
 /*8  9  :  ;  <  =3D  >  ?  */ NOR, NOR, NOR, NOR, NOR, NOR, NOR, NOR,=0A=
 /*@  A  B  C  D  E  F  G  */ NOR, NOR, NOR, NOR, NOR, NOR, NOR, NOR,=0A=
@@ -1361,12 +1382,21 @@ fhandler_console::char_command (char c)=0A=
 	}=0A=
       break;=0A=
     case 'r':				/* Set Scroll region */=0A=
-      dev_state->scroll_region.Top =3D dev_state->args_[0] ? dev_state->ar=
gs_[0] - 1 : 0;=0A=
-      dev_state->scroll_region.Bottom =3D dev_state->args_[1] ? dev_state-=
>args_[1] - 1 : -1;=0A=
+      fillin_info();=0A=
+      dev_state->scroll_region.Top =3D dev_state->args_[0] ? dev_state->in=
fo.winTop + dev_state->args_[0] - 1 : 0;=0A=
+      dev_state->scroll_region.Bottom =3D dev_state->args_[1] ? dev_state-=
>info.winTop + dev_state->args_[1] - 1 : -1;=0A=
+      debug_printf("setting scroll region to line: %d to %d (0 based)",=0A=
+        dev_state->scroll_region.Top, dev_state->scroll_region.Bottom);=0A=
       cursor_set (TRUE, 0, 0);=0A=
       break;=0A=
     case 'g':				/* TAB set/clear */=0A=
       break;=0A=
+    case 'y':=0A=
+        current_codepage =3D oem_cp;=0A=
+        break;=0A=
+    case 'z':=0A=
+        current_codepage =3D ansi_cp;=0A=
+        break;=0A=
     default:=0A=
 bad_escape:=0A=
       break;=0A=
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
=20=0A=
 	  if (dev_state->insert_mode)=0A=
 	    {=0A=
-	      int x, y;=0A=
-	      cursor_get (&x, &y);=0A=
 	      scroll_screen (x, y, -1, y, x + buf_len, y);=0A=
 	    }=0A=
=20=0A=
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
@@ -1439,13 +1500,13 @@ fhandler_console::write_normal (const un=0A=
 	  cursor_get (&x, &y);=0A=
 	  if (y >=3D srBottom)=0A=
 	    {=0A=
-	      if (y >=3D dev_state->info.winBottom && !dev_state->scroll_region.T=
op)=0A=
-		WriteFile (get_output_handle (), "\n", 1, &done, 0);=0A=
-	      else=0A=
-		{=0A=
+//	      if (y >=3D dev_state->info.winBottom && !dev_state->scroll_region=
.Top)=0A=
+//		WriteFile (get_output_handle (), "\n", 1, &done, 0);=0A=
+//	      else=0A=
+//		{=0A=
 		  scroll_screen (0, srTop + 1, -1, srBottom, 0, srTop);=0A=
 		  y--;=0A=
-		}=0A=
+//		}=0A=
 	    }=0A=
 	  cursor_set (FALSE, ((tc->ti.c_oflag & ONLCR) ? 0 : x), y + 1);=0A=
 	  break;=0A=
@@ -1483,7 +1544,7 @@ fhandler_console::write (const void *vsr=0A=
=20=0A=
   while (src < end)=0A=
     {=0A=
-      debug_printf ("at %d(%c) state is %d", *src, isprint (*src) ? *src :=
 ' ',=0A=
+      debug_printf ("at index=3D%2d char=3D%3d(%c) state=3D%d", src-((unsi=
gned char*)vsrc), *src, isprint (*src) ? *src : 32,=0A=
 		    dev_state->state_);=0A=
       switch (dev_state->state_)=0A=
 	{=0A=
@@ -1504,7 +1565,8 @@ fhandler_console::write (const void *vsr=0A=
 	  else if (*src =3D=3D ']')=0A=
 	    {=0A=
 	      dev_state->rarg =3D 0;=0A=
-	      dev_state->my_title_buf[0] =3D '\0';=0A=
+	      dev_state->my_title_buf[dev_state->prev_title_len-3] =3D ' ';=0A=
+	      dev_state->my_title_buf[dev_state->prev_title_len]   =3D '\0';=0A=
 	      dev_state->state_ =3D gotrsquare;=0A=
 	    }=0A=
 	  else if (*src =3D=3D 'M')		/* Reverse Index */=0A=
@@ -1578,6 +1640,12 @@ fhandler_console::write (const void *vsr=0A=
 	      {=0A=
 		if (*src =3D=3D '\007' && dev_state->state_ =3D=3D gettitle)=0A=
 		  {=0A=
+                  if (n =3D=3D dev_state->prev_title_len)=0A=
+                    {=0A=
+                      /* 3 =3D=3D length " | " */=0A=
+                      n -=3D 3;=0A=
+                      dev_state->my_title_buf[n] =3D '\0';=0A=
+                    }=0A=
 		    if (old_title)=0A=
 		      strcpy (old_title, dev_state->my_title_buf);=0A=
 		    set_console_title (dev_state->my_title_buf);=0A=

------=_NextPart_000_0026_01C31FBE.F6786B00
Content-Type: application/octet-stream;
	name="changelog"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="changelog"
Content-length: 1349

2003-05-21  Micha Nelissen  <mdvpost@hotmail.com>=0A=
=0A=
* fhandler.h (dev_console): add title state variables.=0A=
* fhandler.h (dev_console): add cursor end-of-buffer variables.=0A=
=0A=
* fhandler_console.cc (macro: srTop, srBottom; char_command): scroll_region=
 is=0A=
not relative to window top.=0A=
=0A=
* fhandler_console.cc (get_tty_stuff): save old console title.=0A=
=0A=
* fhandler_console.cc (scroll_screen): renamed variables sr1, sr2 to srScro=
ll,=0A=
srClip respectively which is clearer.=0A=
* fhandler_console.cc (scroll_screen): added clipping counterpart for top <=
=0A=
clip.top.=0A=
=0A=
* fhandler_console.cc (scroll_screen, char_command, write_normal): more deb=
ug=0A=
info.=0A=
=0A=
* fhandler_console.cc (char_command): added escape sequence for codepage=0A=
switching to enable line drawing characters.=0A=
=0A=
* fhandler_console.cc (write_normal): end of buffer check enables cursor to=
 be=0A=
out of range; it better emulates *nix terminal behaviour; ie. it is now=0A=
possible to write a single character at right bottom of console buffer with=
out=0A=
the console scrolling the buffer.=0A=
=0A=
* fhandler_console.cc (write_normal): cancelled premature optimization, do=
=0A=
always use scroll_screen instead of '\n' sometimes=0A=
=0A=
* fhandler_write.cc (write): if `user' clears title, then don't add `|'=0A=

------=_NextPart_000_0026_01C31FBE.F6786B00--
