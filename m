Return-Path: <cygwin-patches-return-4296-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19458 invoked by alias); 14 Oct 2003 20:26:33 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19443 invoked from network); 14 Oct 2003 20:26:29 -0000
Message-ID: <3F8C5BF3.4050200@student.tue.nl>
Date: Tue, 14 Oct 2003 20:26:00 -0000
From: Micha Nelissen <M.Nelissen@student.tue.nl>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5) Gecko/20030924 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: [Patch]: Ncurses frame drawing
References: <20031014145507.GC14344@cygbert.vinschen.de>
In-Reply-To: <20031014145507.GC14344@cygbert.vinschen.de>
Content-Type: multipart/mixed;
 boundary="------------020401010707040608050908"
X-SW-Source: 2003-q4/txt/msg00015.txt.bz2

This is a multi-part message in MIME format.
--------------020401010707040608050908
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 1046

Corinna Vinschen wrote:

> Erm... I was still mulling over this code since I thought there's
> something wrong.  It took some time until it occured to me that this
> implementation overrides the original value of current_codepage, if
> the application accidentally happens to send \E[11m twice.  That
> shouldn't be possible.
> 
> I'd prefer if the value of original_codepage is set to the same value
> as current_codepage in environ.cc (codepage_init).  It should not
> be manipulated in fhandler_console.cc (char_command).

While thinking about the problem to solve, I now took a slightly 
different approach. See, those ncurses actually need to 'disable' 
translation from ansi to oem because that screws up the frame 
characters. So instead of original_codepage variable, I introduced a 
bool alternate_charset_active that states if an alternate charset is 
active. If so, it disables translation. Works perfectly for me and I 
think is a cleaner approach. No messing with remembering / initializing 
  / faking codepages.

Regards,

Micha.


--------------020401010707040608050908
Content-Type: text/plain;
 name="charset.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="charset.patch"
Content-length: 1949

Index: dcrt0.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/dcrt0.cc,v
retrieving revision 1.187
diff -u -w -r1.187 dcrt0.cc
--- dcrt0.cc	8 Oct 2003 21:40:33 -0000	1.187
+++ dcrt0.cc	14 Oct 2003 20:20:51 -0000
@@ -57,6 +57,7 @@
 bool strip_title_path;
 bool allow_glob = TRUE;
 codepage_type current_codepage = ansi_cp;
+bool alternate_charset_active;
 
 int cygwin_finished_initializing;
 
Index: fhandler_console.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_console.cc,v
retrieving revision 1.115
diff -u -w -r1.115 fhandler_console.cc
--- fhandler_console.cc	27 Sep 2003 02:36:50 -0000	1.115
+++ fhandler_console.cc	14 Oct 2003 20:20:51 -0000
@@ -66,6 +66,13 @@
 inline BOOL
 str_to_con (char *d, const char *s, DWORD sz)
 {
+  if (alternate_charset_active)
+    {
+      /* no translation when alternate charset is active */
+      memcpy(d, s, sz);
+      return TRUE;
+    }
+  else
   return cp_convert (GetConsoleOutputCP (), d, get_cp (), s, sz);
 }
 
@@ -1110,6 +1117,12 @@
 	       break;
 	     case 9:    /* dim */
 	       dev_state->intensity = INTENSITY_DIM;
+	       break;
+             case 10:   /* end alternate charset */
+               alternate_charset_active = FALSE;
+	       break;
+             case 11:   /* start alternate charset */
+               alternate_charset_active = TRUE;
 	       break;
 	     case 24:
 	       dev_state->underline = FALSE;
Index: winsup.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/winsup.h,v
retrieving revision 1.119
diff -u -w -r1.119 winsup.h
--- winsup.h	25 Sep 2003 00:37:17 -0000	1.119
+++ winsup.h	14 Oct 2003 20:20:51 -0000
@@ -90,6 +90,7 @@
 
 enum codepage_type {ansi_cp, oem_cp};
 extern codepage_type current_codepage;
+extern bool alternate_charset_active;
 
 UINT get_cp ();
 

--------------020401010707040608050908
Content-Type: text/plain;
 name="charset.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="charset.log"
Content-length: 349

2003-10-13  Micha Nelissen  <M.Nelissen@student.tue.nl>

        * fhandler_console.cc (char_command): Add escape sequence for codepage
        ansi <-> oem switching for ncurses frame drawing capabilities.

        * dcrt0.cc: Add local variable alternate_charset_active.

        * winsup.h: Add global external variable alternate_charset_active.

--------------020401010707040608050908--
