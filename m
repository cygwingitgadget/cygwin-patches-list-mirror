Return-Path: <cygwin-patches-return-1995-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 31675 invoked by alias); 19 Mar 2002 17:13:06 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 31578 invoked from network); 19 Mar 2002 17:13:00 -0000
Date: Tue, 19 Mar 2002 17:33:00 -0000
From: Dennis Vshivkov <walrus@amur.ru>
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] No codepage translation in cygwin console
Message-ID: <20020319201257.A21208@amur.ru>
References: <20020115194622.A3962@amur.ru> <20020119002711.A24934@cygbert.vinschen.de> <20020121174058.B31464@amur.ru> <20020121192855.O11608@cygbert.vinschen.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020121192855.O11608@cygbert.vinschen.de>; from cygwin-patches@cygwin.com on Mon, Jan 21, 2002 at 07:28:55PM +0100
X-SW-Source: 2002-q1/txt/msg00352.txt.bz2


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-length: 1382

On Mon, Jan 21, 2002 at 07:28:55PM +0100, Corinna Vinschen wrote:

> On Mon, Jan 21, 2002 at 05:40:58PM +0300, Dennis Vshivkov wrote:
> > > >     If con-asis suboption is specified, console input and output goes
> > > > unchanged.  Hope this helps someone.
> > > 
> > > actually your patch seems to be useful when having to switch
> > > between different codepages.
> > > 
> > > But I have two problems with that patch:
> > > 
> > > - First of all, your patch isn't `trivial' enough so that we
> > >   can incorporate it without getting a signed copyright assignment
> > >   form from you as described on http://cygwin.com/contrib.html.
> > >   Please send us the signed form via snail mail.  As soon as we
> > >   received it we can use your patch.
> > 
> >     Ok, I've printed the assignment and will send it ASAP.
> > 
> > > - Your ChangeLog entry isn't correctly indented.  And please use
> > >   your real name, not a pseudonym.
> > 
> >     Ok.  Do I have to correct and resend it right away or it's better to wait
> > until the assignment is received?
> 
> Just send it again when you like.  However, snail mail to US is somewhat,
> say, weird.  It could take two or three weeks.

    Having received the signed assignment back from Red Hat, I'm resending the
patch (updated to match 1.3.10-1) along with the corrected ChangeLog entry.

-- 
/Awesome Walrus <walrus@amur.ru>

--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="Cygwin console as-is codepage passing.ChangeLog"
Content-length: 527

2002-03-19  Dennis Vshivkov  <walrus@amur.ru>

	* winsup/cygwin/dcrt0.cc:
	  New BOOL console_asis, indicating passing console output as it is.
	* winsup/cygwin/environ.cc (codepage_init) <con-asis>:
	  Processing :con-asis suboption, setting BOOL console_asis to TRUE
	  if it's present in codepage= option of CYGWIN environment variable.
	* winsup/cygwin/fhandler_console.cc (cp_convert):
	  No codepage conversion if console_asis is TRUE.
	* winsup/cygwin/winsup.h:
	  External declaration of newly added BOOL console_asis.

--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="Cygwin console as-is codepage passing.patch"
Content-length: 2263

diff -ur cygwin-1.3.10-1.orig/winsup/cygwin/dcrt0.cc cygwin-1.3.10-1/winsup/cygwin/dcrt0.cc
--- cygwin-1.3.10-1.orig/winsup/cygwin/dcrt0.cc	Tue Mar 19 16:56:15 2002
+++ cygwin-1.3.10-1/winsup/cygwin/dcrt0.cc	Tue Mar 19 10:34:53 2002
@@ -58,6 +58,7 @@
 BOOL strip_title_path;
 BOOL allow_glob = TRUE;
 codepage_type current_codepage = ansi_cp;
+BOOL console_asis = FALSE;
 
 int cygwin_finished_initializing;
 
diff -ur cygwin-1.3.10-1.orig/winsup/cygwin/environ.cc cygwin-1.3.10-1/winsup/cygwin/environ.cc
--- cygwin-1.3.10-1.orig/winsup/cygwin/environ.cc	Tue Mar 19 16:56:15 2002
+++ cygwin-1.3.10-1/winsup/cygwin/environ.cc	Tue Mar 19 10:34:53 2002
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
diff -ur cygwin-1.3.10-1.orig/winsup/cygwin/fhandler_console.cc cygwin-1.3.10-1/winsup/cygwin/fhandler_console.cc
--- cygwin-1.3.10-1.orig/winsup/cygwin/fhandler_console.cc	Tue Mar 19 16:56:15 2002
+++ cygwin-1.3.10-1/winsup/cygwin/fhandler_console.cc	Tue Mar 19 10:34:53 2002
@@ -47,7 +47,7 @@
 {
   if (!size)
     /* no action */;
-  else if (destcp == srccp)
+  else if (console_asis || destcp == srccp)
     {
       if (dest != src)
 	memcpy (dest, src, size);
diff -ur cygwin-1.3.10-1.orig/winsup/cygwin/winsup.h cygwin-1.3.10-1/winsup/cygwin/winsup.h
--- cygwin-1.3.10-1.orig/winsup/cygwin/winsup.h	Tue Mar 19 16:56:15 2002
+++ cygwin-1.3.10-1/winsup/cygwin/winsup.h	Tue Mar 19 15:36:01 2002
@@ -76,6 +76,7 @@
 
 enum codepage_type {ansi_cp, oem_cp};
 extern codepage_type current_codepage;
+extern BOOL console_asis;
 
 /* Used to check if Cygwin DLL is dynamically loaded. */
 extern int dynamically_loaded;

--VbJkn9YxBvnuCH5J--
