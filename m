Return-Path: <cygwin-patches-return-5096-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28990 invoked by alias); 29 Oct 2004 04:31:16 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 28980 invoked from network); 29 Oct 2004 04:31:14 -0000
Received: from unknown (HELO green.qinip.net) (62.100.30.36)
  by sourceware.org with SMTP; 29 Oct 2004 04:31:14 -0000
Received: from buzzy-box (hmm-dca-ap03-d11-081.dial.freesurf.nl [62.100.10.81])
	by green.qinip.net (Postfix) with SMTP
	id CAEFB428C; Fri, 29 Oct 2004 06:31:11 +0200 (MET DST)
Message-ID: <n2m-g.clsnoj.3vvasbt.1@buzzy-box.bavag>
From: Bas van Gompel <cygwin-patches.buzz@bavag.tmfweb.nl>
Subject: [Patch] cygcheck: Don't use keyeprint if GetLastError is irrelevant.
Reply-To: cygwin-patches mailing-list <cygwin-patches@cygwin.com>
Organisation: Ehm...
User-Agent: slrn/0.9.8.1 (Win32) Hamster/2.0.6.0 Korrnews/4.2
To: cygwin-patches@cygwin.com
Date: Fri, 29 Oct 2004 04:31:00 -0000
X-SW-Source: 2004-q4/txt/msg00097.txt.bz2

Hi,

Following (trivial, once more, I hope) patch cleans up some of the
(IMO) inappropriate ``keyeprint'' usage in cygcheck. It (keyeprint)
should not be used when GetLastError does not apply, I think. Also the
format ending in ``failed'' can cause strange messages like ``NULL
pointer for file failed''.

While doing this I caught a typo in get_dword.


ChangeLog-entry:

2004-10-28  Bas van Gompel  <cygwin-patch.buzz@bavag.tmfweb.nl>

	* cygcheck.cc (add_path): Don't use keyeprint when GetLastError is
	irrelevant.
	(find_on_path): Ditto.
	(rva_to_offset): Ditto.
	(cygwin_info): Ditto.
	(get_dword): Fix typo in errormessage.


--- src/winsup/utils/cygcheck.cc	27 Oct 2004 01:28:07 -0000	1.58
+++ src/winsup/utils/cygcheck.cc	29 Oct 2004 03:34:15 -0000
@@ -122,7 +122,7 @@ add_path (char *s, int maxlen)
   paths[num_paths] = (char *) malloc (maxlen + 1);
   if (paths[num_paths] == NULL)
     {
-      keyeprint ("add_path: malloc()");
+      fputs ("cygcheck: add_path: malloc() failed", stderr);
       return;
     }
   memcpy (paths[num_paths], s, maxlen);
@@ -185,13 +185,14 @@ find_on_path (char *file, char *default_
 
   if (!file)
     {
-      keyeprint ("find_on_path: NULL pointer for file");
+      fputs ("cygcheck: find_on_path: NULL pointer for file", stderr);
       return 0;
     }
 
   if (default_extension == NULL)
     {
-      keyeprint ("find_on_path: NULL pointer for default_extension");
+      fputs ("cygcheck: find_on_path: NULL pointer for default_extension",
+	    stderr);
       return 0;
     }
 
@@ -276,7 +277,7 @@ get_dword (HANDLE fh, int offset)
 
   if (SetFilePointer (fh, offset, 0, FILE_BEGIN) == INVALID_SET_FILE_POINTER
       && GetLastError () != NO_ERROR)
-    keyeprint ("get_word: SetFilePointer()");
+    keyeprint ("get_dword: SetFilePointer()");
 
   if (!ReadFile (fh, &rv, 4, (DWORD *) &r, 0))
     keyeprint ("get_dword: Readfile()");
@@ -300,7 +301,7 @@ rva_to_offset (int rva, char *sections, 
 
   if (sections == NULL)
     {
-      keyeprint ("rva_to_offset: NULL passed for sections");
+      fputs ("cygcheck: rva_to_offset: NULL passed for sections", stderr);
       return 0;
     }
 
@@ -359,7 +360,7 @@ cygwin_info (HANDLE h)
   buf_start = buf = (char *) calloc (1, size + 1);
   if (buf == NULL)
     {
-      keyeprint ("cygwin_info: malloc()");
+      fputs ("cygcheck: cygwin_info: calloc() failed", stderr);
       return;
     }
 


L8r,

Buzz.
-- 
  ) |  | ---/ ---/  Yes, this | This message consists of true | I do not
--  |  |   /    /   really is |   and false bits entirely.    | mail for
  ) |  |  /    /    a 72 by 4 +-------------------------------+ any1 but
--  \--| /--- /---  .sigfile. |   |perl -pe "s.u(z)\1.as."    | me. 4^re
