Return-Path: <cygwin-patches-return-4985-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6376 invoked by alias); 23 Sep 2004 07:19:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 6361 invoked from network); 23 Sep 2004 07:19:44 -0000
Message-ID: <n2m-g.ciu2h5.3vsgpvd.1@buzzy-box.bavag>
From: Bas van Gompel <cygwin-patches.buzz@bavag.tmfweb.nl>
Subject: Re: [Patch] Trailing spaces in cygcheck -cd or -s output.
References: <n2m-g.cibek2.3vvfqsr.1@buzzy-box.bavag> <20040922115453.GZ17670@cygbert.vinschen.de>
Reply-To: <cygwin-patches mailing-list <cygwin-patches#cygwin.com@green.qinip.net>
Organisation: Ehm...
User-Agent: slrn/0.9.8.0 (Win32) Hamster/2.0.5.5
To: cygwin-patches@cygwin.com
Date: Thu, 23 Sep 2004 07:19:00 -0000
X-SW-Source: 2004-q3/txt/msg00137.txt.bz2

Op Wed, 22 Sep 2004 13:54:53 +0200 schreef Corinna Vinschen
in <20040922115453.GZ17670@cygbert.vinschen.de>:
:  On Sep 16 07:26, Bas van Gompel wrote:

[dump_setup.cc (dump_setup): Avoid trailing spaces on package-list.]

:  Thanks for the patch.  I've applied the patch plus an additional patch which
:  adds an `if (check_files)' to simplify the expressions in (now two) printf's.

Thanks, that's much more readable.

Now one can eliminate a spurious ``strlen'', as well.

ChangeLog-entry:

2004-09-23  Bas van Gompel  <cygwin-patch.buzz@bavag.tmfweb.nl>

	* dump_setup.cc (dump_setup): Remove unneeded strlen when check_files
	is not set.

Patch:

--- src/winsup/utils/dump_setup.cc	22 Sep 2004 11:50:51 -0000	1.15
+++ src/winsup/utils/dump_setup.cc	23 Sep 2004 05:26:51 -0000
@@ -403,8 +403,8 @@ dump_setup (int verbose, char **argv, bo
 		check_package_files (verbose, packages[i].name)
 		  ? "     OK" : "     Incomplete");
       else
-	printf ("%-*s %-*s\n", package_len, packages[i].name,
-	      strlen(packages[i].ver), packages[i].ver);
+	printf ("%-*s %s\n", package_len, packages[i].name,
+	      packages[i].ver);
       fflush(stdout);
     }
 
L8r,

Buzz.
-- 
  ) |  | ---/ ---/  Yes, this | This message consists of true | I do not
--  |  |   /    /   really is |   and false bits entirely.    | mail for
  ) |  |  /    /    a 72 by 4 +-------------------------------+ any1 but
--  \--| /--- /---  .sigfile. |   |perl -pe "s.u(z)\1.as."    | me. 4^re
