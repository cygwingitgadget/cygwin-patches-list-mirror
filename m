Return-Path: <cygwin-patches-return-5101-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1867 invoked by alias); 30 Oct 2004 21:32:37 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1852 invoked from network); 30 Oct 2004 21:32:35 -0000
Received: from unknown (HELO green.qinip.net) (62.100.30.36)
  by sourceware.org with SMTP; 30 Oct 2004 21:32:35 -0000
Received: from buzzy-box (hmm-dca-ap03-d07-005.dial.freesurf.nl [62.100.6.5])
	by green.qinip.net (Postfix) with SMTP
	id 69D8A4459; Sat, 30 Oct 2004 23:32:27 +0200 (MET DST)
Message-ID: <n2m-g.clva3u.3vvcmfh.1@buzzy-box.bavag>
From: Bas van Gompel <cygwin-patches.buzz@bavag.tmfweb.nl>
Subject: Re: [Patch] cygcheck: Don't use keyeprint if GetLastError is irrelevant.
References: <n2m-g.clsnoj.3vvasbt.1@buzzy-box.bavag> <20041029152238.GG29869@trixie.casa.cgf.cx>
Reply-To: cygwin-patches mailing-list <cygwin-patches@cygwin.com>
Organisation: Ehm...
User-Agent: slrn/0.9.8.1 (Win32) Hamster/2.0.6.0 Korrnews/4.2
To: cygwin-patches@cygwin.com
In-Reply-To: <20041029152238.GG29869@trixie.casa.cgf.cx>
Date: Sat, 30 Oct 2004 21:32:00 -0000
X-SW-Source: 2004-q4/txt/msg00102.txt.bz2

Op Fri, 29 Oct 2004 11:22:38 -0400 schreef Christopher Faylor
in <20041029152238.GG29869@trixie.casa.cgf.cx>:
:  On Fri, Oct 29, 2004 at 06:31:11AM +0200, Bas van Gompel wrote:
: > Following (trivial, once more, I hope) patch cleans up some of the
: > (IMO) inappropriate ``keyeprint'' usage in cygcheck. It (keyeprint)
: > should not be used when GetLastError does not apply, I think. Also the
: > format ending in ``failed'' can cause strange messages like ``NULL
: > pointer for file failed''.
:
:   If malloc failed, it is not inconceivable that there is a system error.

Ok.

:  Since the point of keyeprint is to print error messages, reverting to
:  using raw puts is a step backwards.  If it is really known that there is
:  not a remote possibility that GetLastError will be useful, then an
:  option to keyeprint should be added.

I thought so too, at first. I'll admit my solution wasn't pretty
either. Maybe a new function sh/could be added to print messages on
stderr, but without the ``failed'' suffix and the LastError output.
(This could then be called from keyeprint as well.)

:  I'd rather regularize error output
:  throughout cygcheck (which may be a bigger job than your current assignment
:  status will allow) than sprinkle fputs's, and fprints's around the code.

I hope a step-by-step approach will work...
[...]

: > While doing this I caught a typo in get_dword.

I'll start by trying to fix that one (and some more).
(The ones in track_down don't look like they can ever really
get triggered.)


ChangeLog-entry:

2004-10-28  Bas van Gompel  <cygwin-patch.buzz@bavag.tmfweb.nl>

	* cygcheck.cc (get_dword): Fix errormessage.
	(cygwin_info): Ditto.
	(track_down): Ditto.
	(check_keys): Ditto.


--- src/winsup/utils-keye-usage-p0/cygcheck.cc	27 Oct 2004 01:28:07 -0000	1.58
+++ src/winsup/utils-keye-usage-p0/cygcheck.cc	30 Oct 2004 03:16:07 -0000
@@ -276,7 +276,7 @@ get_dword (HANDLE fh, int offset)
 
   if (SetFilePointer (fh, offset, 0, FILE_BEGIN) == INVALID_SET_FILE_POINTER
       && GetLastError () != NO_ERROR)
-    keyeprint ("get_word: SetFilePointer()");
+    keyeprint ("get_dword: SetFilePointer()");
 
   if (!ReadFile (fh, &rv, 4, (DWORD *) &r, 0))
     keyeprint ("get_dword: Readfile()");
@@ -359,7 +359,7 @@ cygwin_info (HANDLE h)
   buf_start = buf = (char *) calloc (1, size + 1);
   if (buf == NULL)
     {
-      keyeprint ("cygwin_info: malloc()");
+      keyeprint ("cygwin_info: calloc()");
       return;
     }
 
@@ -537,13 +537,13 @@ track_down (char *file, char *suffix, in
 {
   if (file == NULL)
     {
-      keyeprint ("track_down: malloc()");
+      keyeprint ("track_down: NULL passed for file");
       return;
     }
 
   if (suffix == NULL)
     {
-      keyeprint ("track_down: malloc()");
+      keyeprint ("track_down: NULL passed for suffix");
       return;
     }
 
@@ -1271,7 +1271,7 @@ check_keys ()
 			  OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL);
 
   if (h == INVALID_HANDLE_VALUE || h == NULL)
-    return (keyeprint ("check_key: Opening CONIN$"));
+    return (keyeprint ("check_keys: Opening CONIN$"));
 
   DWORD mode;
 
@@ -1281,7 +1281,7 @@ check_keys ()
     {
       mode &= ~ENABLE_PROCESSED_INPUT;
       if (!SetConsoleMode (h, mode))
-	keyeprint ("check_keys: GetConsoleMode()");
+	keyeprint ("check_keys: SetConsoleMode()");
     }
 
   fputs ("\nThis key check works only in a console window,", stderr);
@@ -1300,7 +1300,7 @@ check_keys ()
     {
       prev_in = in;
       if (!ReadConsoleInput (h, &in, 1, &mode))
-	keyeprint ("ReadConsoleInput");
+	keyeprint ("check_keys: ReadConsoleInput()");
 
       if (!memcmp (&in, &prev_in, sizeof in))
 	continue;


L8r,

Buzz.
-- 
  ) |  | ---/ ---/  Yes, this | This message consists of true | I do not
--  |  |   /    /   really is |   and false bits entirely.    | mail for
  ) |  |  /    /    a 72 by 4 +-------------------------------+ any1 but
--  \--| /--- /---  .sigfile. |   |perl -pe "s.u(z)\1.as."    | me. 4^re
