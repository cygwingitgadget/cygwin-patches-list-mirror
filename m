Return-Path: <cygwin-patches-return-4302-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13049 invoked by alias); 15 Oct 2003 18:47:32 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13025 invoked from network); 15 Oct 2003 18:47:31 -0000
Message-ID: <3F8D9621.50601@student.tue.nl>
Date: Wed, 15 Oct 2003 18:47:00 -0000
From: Micha Nelissen <M.Nelissen@student.tue.nl>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5) Gecko/20030924 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: Re: [Patch]: Ncurses frame drawing
References: <20031015082724.GJ14344@cygbert.vinschen.de>
In-Reply-To: <20031015082724.GJ14344@cygbert.vinschen.de>
Content-Type: multipart/mixed;
 boundary="------------010705080101010404050403"
X-SW-Source: 2003-q4/txt/msg00021.txt.bz2

This is a multi-part message in MIME format.
--------------010705080101010404050403
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 829

Corinna Vinschen wrote:

> On Wed, Oct 15, 2003 at 08:50:09AM +0200, Micha Nelissen wrote:
> 
>>Pierre A. Humblet wrote:
>>
>>>FWIW, wouldn't it be cleaner to make "alternate_charset_active" a 
>>>member of dev_state instead of introducing a new global variable?
>>
>>1) that alternate_charset check which currently is in str_to_con 
>>(centralized), needs to dispersed over all calls to str_to_con. 
>>(Currently, 1, AFAICS). Prone to bugs, if you ask me because this could 
>>be forgotten in the future, unless this one call will remain the only one.
>>2) str_to_con has to become a member of dev_state too.
> 
> 
> Point 2 has some merits.  Are you interested to do that change, Micha?
> Of course, con_to_str should become a dev_state member then, too.

Ok, attached is a patch with the requested changes.

Regards,

Micha.


--------------010705080101010404050403
Content-Type: text/plain;
 name="charset2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="charset2.patch"
Content-length: 4513

Index: dcrt0.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/dcrt0.cc,v
retrieving revision 1.188
diff -u -r1.188 dcrt0.cc
--- dcrt0.cc	15 Oct 2003 08:23:26 -0000	1.188
+++ dcrt0.cc	15 Oct 2003 18:28:00 -0000
@@ -57,7 +57,6 @@
 bool strip_title_path;
 bool allow_glob = TRUE;
 codepage_type current_codepage = ansi_cp;
-bool alternate_charset_active;
 
 int cygwin_finished_initializing;
 
Index: fhandler.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler.h,v
retrieving revision 1.170
diff -u -r1.170 fhandler.h
--- fhandler.h	1 Oct 2003 12:36:39 -0000	1.170
+++ fhandler.h	15 Oct 2003 18:28:00 -0000
@@ -752,6 +752,7 @@
   int nargs_;
   unsigned rarg;
   bool saw_question_mark;
+  bool alternate_charset_active;
 
   char my_title_buf [TITLESIZE + 1];
 
@@ -788,6 +789,10 @@
   bool insert_mode;
   bool use_mouse;
   bool raw_win32_keyboard_mode;
+
+  BOOL con_to_str (char *d, const char *s, DWORD sz);
+  BOOL str_to_con (char *d, const char *s, DWORD sz);
+
   friend class fhandler_console;
 };
 
Index: fhandler_console.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_console.cc,v
retrieving revision 1.116
diff -u -r1.116 fhandler_console.cc
--- fhandler_console.cc	15 Oct 2003 08:23:26 -0000	1.116
+++ fhandler_console.cc	15 Oct 2003 18:28:03 -0000
@@ -54,27 +54,6 @@
   return TRUE;
 }
 
-/* The results of GetConsoleCP() and GetConsoleOutputCP() cannot be
-   cached, because a program or the user can change these values at
-   any time. */
-inline BOOL
-con_to_str (char *d, const char *s, DWORD sz)
-{
-  return cp_convert (get_cp (), d, GetConsoleCP (), s, sz);
-}
-
-inline BOOL
-str_to_con (char *d, const char *s, DWORD sz)
-{
-  if (alternate_charset_active)
-    {
-      /* no translation when alternate charset is active */
-      memcpy(d, s, sz);
-      return TRUE;
-    }
-  return cp_convert (GetConsoleOutputCP (), d, get_cp (), s, sz);
-}
-
 /*
  * Scroll the screen context.
  * x1, y1 - ul corner
@@ -187,6 +166,27 @@
   return 1;
 }
 
+/* The results of GetConsoleCP() and GetConsoleOutputCP() cannot be
+   cached, because a program or the user can change these values at
+   any time. */
+inline BOOL
+dev_console::con_to_str (char *d, const char *s, DWORD sz)
+{
+  return cp_convert (get_cp (), d, GetConsoleCP (), s, sz);
+}
+
+inline BOOL
+dev_console::str_to_con (char *d, const char *s, DWORD sz)
+{
+  if (alternate_charset_active)
+    {
+      /* no translation when alternate charset is active */
+      memcpy(d, s, sz);
+      return TRUE;
+    }
+  return cp_convert (GetConsoleOutputCP (), d, get_cp (), s, sz);
+}
+
 BOOL
 fhandler_console::set_raw_win32_keyboard_mode (BOOL new_mode)
 {
@@ -375,7 +375,7 @@
 	      /* Need this check since US code page seems to have a bug when
 		 converting a CTRL-U. */
 	      if ((unsigned char) ich > 0x7f)
-		con_to_str (tmp + 1, tmp + 1, 1);
+		dev_state->con_to_str (tmp + 1, tmp + 1, 1);
 	      /* Determine if the keystroke is modified by META.  The tricky
 		 part is to distinguish whether the right Alt key should be
 		 recognized as Alt, or as AltGr. */
@@ -1118,10 +1118,10 @@
 	       dev_state->intensity = INTENSITY_DIM;
 	       break;
              case 10:   /* end alternate charset */
-               alternate_charset_active = FALSE;
+               dev_state->alternate_charset_active = FALSE;
 	       break;
              case 11:   /* start alternate charset */
-               alternate_charset_active = TRUE;
+               dev_state->alternate_charset_active = TRUE;
 	       break;
 	     case 24:
 	       dev_state->underline = FALSE;
@@ -1434,7 +1434,7 @@
 	  DWORD buf_len;
 	  char buf[CONVERT_LIMIT];
 	  done = buf_len = min (sizeof (buf), len);
-	  if (!str_to_con (buf, (const char *) src, buf_len))
+	  if (!dev_state->str_to_con (buf, (const char *) src, buf_len))
 	    {
 	      debug_printf ("conversion error, handle %p",
 			    get_output_handle ());
Index: winsup.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/winsup.h,v
retrieving revision 1.121
diff -u -r1.121 winsup.h
--- winsup.h	15 Oct 2003 08:23:26 -0000	1.121
+++ winsup.h	15 Oct 2003 18:28:04 -0000
@@ -90,7 +90,6 @@
 
 enum codepage_type {ansi_cp, oem_cp};
 extern codepage_type current_codepage;
-extern bool alternate_charset_active;
 
 UINT get_cp ();
 

--------------010705080101010404050403
Content-Type: text/plain;
 name="charset2.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="charset2.log"
Content-length: 629

2003-10-15  Micha Nelissen  <M.Nelissen@student.tue.nl>

        * dcrt0.cc: Remove local variable alternate_charset_active.
        * fhandler.h: Add variable alternate_charset_active, functions
        str_to_con, con_to_str to dev_console structure.
        * fhandler_console.cc (con_to_str, str_to_con): Move functions to
        into dev_console class.
        (read): Call con_to_str on dev_state.
        (write_normal): Call str_to_con on dev_state.
        (char_command): Change active_charset_active assignment to be on
        dev_state.
        * winsup.h: Remove global external variable alternate_charset_active.

--------------010705080101010404050403--
