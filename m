Return-Path: <cygwin-patches-return-1707-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 24831 invoked by alias); 15 Jan 2002 16:46:31 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24814 invoked from network); 15 Jan 2002 16:46:25 -0000
Date: Tue, 15 Jan 2002 08:46:00 -0000
From: Dennis Vshivkov <walrus@amur.ru>
To: cygwin-patches@cygwin.com
Subject: [PATCH] No codepage translation in cygwin console
Message-ID: <20020115194622.A3962@amur.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="NDin8bjvE/0mNLFQ"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-SW-Source: 2002-q1/txt/msg00064.txt.bz2


--NDin8bjvE/0mNLFQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-length: 814

    Hello.

    There are times when it's very convenient to change Windows console
codepage using chcp.com, for example, an interactive ssh session to a host
with a different codepage used.  Unfortunately, the current release of cygwin
enforces either of the two main codepages, ansi or oem, to be used, mainly
because of considerations of their importance for filename and clipboard
conversions, etc.  There's a patch attached, it extends functionality of the
`codepage' option, set in CYGWIN environment variable, to allow for setting no
codepage translation of console input and output.

    The way the option should look now is

    codepage=ansi|oem[:con-asis]

    If con-asis suboption is specified, console input and output goes
unchanged.  Hope this helps someone.

-- 
/Awesome Walrus <walrus@amur.ru>

--NDin8bjvE/0mNLFQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="Cygwin console as-is codepage passing.ChangeLog"
Content-length: 320

2002-01-15  Awesome Walrus  <walrus@amur.ru>

	* winsup/cygwin:
	    dcrt0.cc (console_asis),
	    environ.cc (codepage_init),
	    fhandler_console.cc (cp_convert),
	    winsup.h (console_asis):
	  allow for no codepage translation in cygwin console using
	  :con-asis suboption of CYGWIN env variable's codepage= part

--NDin8bjvE/0mNLFQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="Cygwin console as-is codepage passing.patch"
Content-length: 2247

diff -ur cygwin-1.3.6-6.orig/winsup/cygwin/dcrt0.cc cygwin-1.3.6-6/winsup/cygwin/dcrt0.cc
--- cygwin-1.3.6-6.orig/winsup/cygwin/dcrt0.cc	Sun Dec  2 18:54:02 2001
+++ cygwin-1.3.6-6/winsup/cygwin/dcrt0.cc	Tue Jan 15 16:18:23 2002
@@ -58,6 +58,7 @@
 BOOL strip_title_path;
 BOOL allow_glob = TRUE;
 codepage_type current_codepage = ansi_cp;
+BOOL console_asis = FALSE;
 
 int cygwin_finished_initializing;
 
diff -ur cygwin-1.3.6-6.orig/winsup/cygwin/environ.cc cygwin-1.3.6-6/winsup/cygwin/environ.cc
--- cygwin-1.3.6-6.orig/winsup/cygwin/environ.cc	Thu Nov  1 00:30:03 2001
+++ cygwin-1.3.6-6/winsup/cygwin/environ.cc	Tue Jan 15 16:18:23 2002
@@ -449,12 +449,24 @@
   if (!buf || !*buf)
     return;
 
-  if (strcmp (buf, "oem")== 0)
+  const char *colon = strchr(buf, ':');
+  if (colon)
+    {
+      if (strcmp(colon + 1, "con-asis") != 0)
+	{
+	  debug_printf ("Wrong codepage suboption: %s", colon + 1);
+	  return;
+	}
+
+      console_asis = TRUE;
+    }
+
+  if (strncmp(buf, "oem", colon ? colon - buf : sizeof("oem") - 1) == 0)
     {
       current_codepage = oem_cp;
       set_file_api_mode (current_codepage);
     }
-  else if (strcmp (buf, "ansi")== 0)
+  else if (strncmp(buf, "ansi", colon ? colon - buf : sizeof("ansi") - 1) == 0)
     {
       current_codepage = ansi_cp;
       set_file_api_mode (current_codepage);
diff -ur cygwin-1.3.6-6.orig/winsup/cygwin/fhandler_console.cc cygwin-1.3.6-6/winsup/cygwin/fhandler_console.cc
--- cygwin-1.3.6-6.orig/winsup/cygwin/fhandler_console.cc	Sun Dec  2 18:54:02 2001
+++ cygwin-1.3.6-6/winsup/cygwin/fhandler_console.cc	Tue Jan 15 16:18:23 2002
@@ -47,7 +47,7 @@
 {
   if (!size)
     /* no action */;
-  else if (destcp == srccp)
+  else if (console_asis || destcp == srccp)
     {
       if (dest != src)
 	memcpy (dest, src, size);
diff -ur cygwin-1.3.6-6.orig/winsup/cygwin/winsup.h cygwin-1.3.6-6/winsup/cygwin/winsup.h
--- cygwin-1.3.6-6.orig/winsup/cygwin/winsup.h	Sun Dec  2 19:52:10 2001
+++ cygwin-1.3.6-6/winsup/cygwin/winsup.h	Tue Jan 15 16:18:23 2002
@@ -74,6 +74,7 @@
 
 enum codepage_type {ansi_cp, oem_cp};
 extern codepage_type current_codepage;
+extern BOOL console_asis;
 
 /* Used to check if Cygwin DLL is dynamically loaded. */
 extern int dynamically_loaded;

--NDin8bjvE/0mNLFQ--
