Return-Path: <cygwin-patches-return-5082-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17262 invoked by alias); 26 Oct 2004 21:34:20 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 16335 invoked from network); 26 Oct 2004 21:34:15 -0000
Message-ID: <n2m-g.clmmgp.3vvbk61.1@buzzy-box.bavag>
From: Bas van Gompel <cygwin-patches.buzz@bavag.tmfweb.nl>
Subject: [Patch] cygcheck: Warn about multiple or missing cygwin1.dlls.
Reply-To: cygwin-patches mailing-list <cygwin-patches@cygwin.com>
Organisation: Ehm...
User-Agent: slrn/0.9.8.1 (Win32) Hamster/2.0.6.0 Korrnews/4.2
To: cygwin-patches@cygwin.com
Date: Tue, 26 Oct 2004 21:34:00 -0000
X-SW-Source: 2004-q4/txt/msg00083.txt.bz2

Hi,

Another (trivial, I think) patch, this time to warn about one of the
more common pitfalls: multiple or missing cygwin1.dlls.

2004-10-26  Bas van Gompel  <cygwin-patch.buzz@bavag.tmfweb.nl>

	* cygcheck.cc (dump_sysinfo): Warn about missing or multiple cygwin1
	dlls.


--- src/winsup/utils-3/cygcheck.cc	25 Oct 2004 16:11:41 -0000	1.57
+++ src/winsup/utils-3/cygcheck.cc	26 Oct 2004 20:50:24 -0000
@@ -1222,6 +1222,7 @@ dump_sysinfo ()
 
   if (givehelp)
     printf ("Looking for various Cygnus DLLs...  (-v gives version info)\n");
+  int cygwin_dll_count = 0;
   for (i = 0; i < num_paths; i++)
     {
       WIN32_FIND_DATA ffinfo;
@@ -1238,7 +1239,10 @@ dump_sysinfo ()
 		{
 		  sprintf (tmp, "%s\\%s", paths[i], f);
 		  if (strcasecmp (f, "cygwin1.dll") == 0)
-		    found_cygwin_dll = strdup (tmp);
+		    {
+		      cygwin_dll_count++;
+		      found_cygwin_dll = strdup (tmp);
+		    }
 		  else
 		    ls (tmp);
 		}
@@ -1253,6 +1257,10 @@ dump_sysinfo ()
 
       FindClose (ff);
     }
+  if (cygwin_dll_count > 1)
+    puts ("Warning: There are multiple cygwin1.dlls on your path");
+  if (!cygwin_dll_count)
+    puts ("Warning: cygwin1.dll not found on your path");
 }
 
 static int



L8r,

Buzz.
-- 
  ) |  | ---/ ---/  Yes, this | This message consists of true | I do not
--  |  |   /    /   really is |   and false bits entirely.    | mail for
  ) |  |  /    /    a 72 by 4 +-------------------------------+ any1 but
--  \--| /--- /---  .sigfile. |   |perl -pe "s.u(z)\1.as."    | me. 4^re
