Return-Path: <cygwin-patches-return-3882-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10151 invoked by alias); 24 May 2003 13:43:49 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 10079 invoked from network); 24 May 2003 13:43:48 -0000
X-Originating-IP: [62.21.237.84]
X-Originating-Email: [mdvpost@hotmail.com]
From: "Micha Nelissen" <mdvpost@hotmail.com>
To: "Corinna Vinschen" <cygwin-patches@cygwin.com>
Subject: Console title
Date: Sat, 24 May 2003 13:43:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0147_01C3220B.433BC100"
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Message-ID: <BAY1-DAV43h4VGXTnKP000049e0@hotmail.com>
X-OriginalArrivalTime: 24 May 2003 13:43:48.0360 (UTC) FILETIME=[80D6B080:01C321FA]
X-SW-Source: 2003-q2/txt/msg00109.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_0147_01C3220B.433BC100
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 259

Hi,

This makes the set title go after the current title, instead of replacing
it. You need to enable hardstatus support in termcap to be able to notice
the difference. In particular the entries 'hs', 'fs', 'ts' and 'ds' are
needed. See 'man screen'.

Micha.

------=_NextPart_000_0147_01C3220B.433BC100
Content-Type: application/octet-stream;
	name="cygwin_title.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="cygwin_title.patch"
Content-length: 3446

Index: fhandler.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/fhandler.h,v=0A=
retrieving revision 1.162=0A=
diff -u -p -r1.162 fhandler.h=0A=
--- fhandler.h	12 May 2003 11:06:25 -0000	1.162=0A=
+++ fhandler.h	21 May 2003 14:14:39 -0000=0A=
@@ -754,7 +754,8 @@ class dev_console=0A=
   unsigned rarg;=0A=
   bool saw_question_mark;=0A=
=0A=
+  int prev_title_len;=0A=
   char my_title_buf [TITLESIZE + 1];=0A=
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
@@ -78,8 +78,10 @@ str_to_con (char *d, const char *s, DWOR=0A=
  * Negative values represents current screen dimensions=0A=
  */=0A=
=0A=
-#define srTop (dev_state->info.winTop + dev_state->scroll_region.Top)=0A=
-#define srBottom ((dev_state->scroll_region.Bottom < 0) ? dev_state->info.=
winBottom : dev_state->info.winTop + dev_state->scroll_region.Bottom)=0A=
+#define srTop (dev_state->scroll_region.Top)=0A=
+#define srBottom ((dev_state->scroll_region.Bottom < 0) ? dev_state->info.=
winBottom : dev_state->scroll_region.Bottom)=0A=
=0A=
 #define use_tty ISSTATE (myself, PID_USETTY)=0A=
=0A=
@@ -112,6 +114,10 @@ fhandler_console::get_tty_stuff (int fla=0A=
       shared_console_info->tty_min_state.setsid (myself->sid);=0A=
       shared_console_info->tty_min_state.set_ctty (TTY_CONSOLE, flags);=0A=
=0A=
+      GetConsoleTitle(dev_state->my_title_buf, TITLESIZE);=0A=
+      dev_state->prev_title_len =3D strlen(dev_state->my_title_buf);=0A=
+      strcpy(dev_state->my_title_buf+dev_state->prev_title_len, " | ");=0A=
+      dev_state->prev_title_len +=3D 3;=0A=
       dev_state->scroll_region.Bottom =3D -1;=0A=
       dev_state->dwLastCursorPosition.X =3D -1;=0A=
       dev_state->dwLastCursorPosition.Y =3D -1;=0A=
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

------=_NextPart_000_0147_01C3220B.433BC100
Content-Type: application/octet-stream;
	name="cygwin_title.changelog"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="cygwin_title.changelog"
Content-length: 310

2003-05-21  Micha Nelissen  <mdvpost@hotmail.com>=0A=
=0A=
* fhandler.h (dev_console): add title state variables.=0A=
=0A=
* fhandler_console.cc (get_tty_stuff): save old console title.=0A=
(write): console title is added after current console title=0A=
(write): if `user' clears title, then don't add `|'=0A=

------=_NextPart_000_0147_01C3220B.433BC100--
