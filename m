Return-Path: <cygwin-patches-return-4997-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 368 invoked by alias); 29 Sep 2004 00:56:55 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 359 invoked from network); 29 Sep 2004 00:56:54 -0000
Message-ID: <n2m-g.cjd7tg.3vvc92r.1@buzzy-box.bavag>
From: Bas van Gompel <cygwin-patches.buzz@bavag.tmfweb.nl>
Subject: [Patch] cygcheck: ``pclose'' what was ``popen''ed.
Reply-To: cygwin-patches mailing-list <cygwin-patches@cygwin.com>
Organisation: Ehm...
User-Agent: slrn/0.9.8.0 (Win32) Hamster/2.0.5.5
To: cygwin-patches@cygwin.com
Date: Wed, 29 Sep 2004 00:56:00 -0000
X-SW-Source: 2004-q3/txt/msg00149.txt.bz2

Hi,

Another trivial (IMO) patch. What was opened by ``popen'', needs
closing by ``pclose''.


ChangeLog-entry:

2004-09-29  Bas van Gompel  <cygwin-patch.buzz@bavag.tmfweb.nl>

	* cygcheck.cc (pretty_id): Close pipe.


--- src/winsup/utils/cygcheck.cc	21 Mar 2004 17:58:14 -0000	1.43
+++ src/winsup/utils/cygcheck.cc	28 Sep 2004 20:42:32 -0000
@@ -793,6 +793,7 @@ pretty_id (const char *s, char *cygwin, 
   static char empty[] = "";
   buf[0] = '\0';
   fgets (buf, sizeof (buf), f);
+  pclose(f);
   char *uid = strtok (buf, ")");
   if (uid)
     uid += strlen ("uid=");


L8r.

Buzz.
-- 
  ) |  | ---/ ---/  Yes, this | This message consists of true | I do not
--  |  |   /    /   really is |   and false bits entirely.    | mail for
  ) |  |  /    /    a 72 by 4 +-------------------------------+ any1 but
--  \--| /--- /---  .sigfile. |   |perl -pe "s.u(z)\1.as."    | me. 4^re
