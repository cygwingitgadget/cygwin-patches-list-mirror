Return-Path: <cygwin-patches-return-5071-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10014 invoked by alias); 21 Oct 2004 23:52:50 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 10003 invoked from network); 21 Oct 2004 23:52:48 -0000
Message-ID: <n2m-g.cl9oca.3vve76d.1@buzzy-box.bavag>
From: Bas van Gompel <cygwin-patches.buzz@bavag.tmfweb.nl>
Subject: [Patch] cygcheck: More complete helptext on drive-list.
Reply-To: cygwin-patches mailing-list <cygwin-patches@cygwin.com>
Organisation: Ehm...
User-Agent: slrn/0.9.8.1 (Win32) Hamster/2.0.6.0
To: cygwin-patches@cygwin.com
Date: Thu, 21 Oct 2004 23:52:00 -0000
X-SW-Source: 2004-q4/txt/msg00072.txt.bz2

Hi,

Another (trivial IMO) patch, this time mostly cosmetic (again).


ChangeLog-entry:

2004-10-22  Bas van Gompel  <cygwin-patch.buzz@bavag.tmfweb.nl>

	* cygcheck.cc (dump_sysinfo): In legend for drive-list: Add ``ram'' and
	``unk''; Use single puts; Add leading newline; Line up equal-signs.


--- src/winsup/utils/cygcheck.cc	21 Oct 2004 00:06:37 -0000	1.54
+++ src/winsup/utils/cygcheck.cc	21 Oct 2004 21:12:17 -0000
@@ -1160,10 +1160,11 @@ dump_sysinfo ()
   SetErrorMode (prev_mode);
   if (givehelp)
     {
-      printf ("fd=floppy, hd=hard drive, cd=CD-ROM, net=Network Share\n");
-      printf ("CP=Case Preserving, CS=Case Sensitive, UN=Unicode\n");
-      printf
-	("PA=Persistent ACLS, FC=File Compression, VC=Volume Compression\n");
+      puts ("\n"
+	  "fd = floppy,          hd = hard drive,       cd = CD-ROM\n"
+	  "net= Network Share,   ram= RAM drive,        unk= Unknown\n"
+	  "CP = Case Preserving, CS = Case Sensitive,   UN = Unicode\n"
+	  "PA = Persistent ACLS, FC = File Compression, VC = Volume Compression");
     }
   printf ("\n");
 


L8r,

Buzz.
-- 
  ) |  | ---/ ---/  Yes, this | This message consists of true | I do not
--  |  |   /    /   really is |   and false bits entirely.    | mail for
  ) |  |  /    /    a 72 by 4 +-------------------------------+ any1 but
--  \--| /--- /---  .sigfile. |   |perl -pe "s.u(z)\1.as."    | me. 4^re
