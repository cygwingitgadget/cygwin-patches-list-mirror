Return-Path: <cygwin-patches-return-5056-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23330 invoked by alias); 14 Oct 2004 15:31:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 23309 invoked from network); 14 Oct 2004 15:31:40 -0000
Message-ID: <n2m-g.ckmcqg.3vvbujf.1@buzzy-box.bavag>
From: Bas van Gompel <cygwin-patches.buzz@bavag.tmfweb.nl>
Subject: [Patch] testsuite and newlib's signal.h.
Reply-To: cygwin-patches mailing-list <cygwin-patches@cygwin.com>
Organisation: Ehm...
To: cygwin-patches@cygwin.com
Date: Thu, 14 Oct 2004 15:31:00 -0000
X-SW-Source: 2004-q4/txt/msg00057.txt.bz2

Hi,

Another trivial patch, a bit kludgy...

ATM the testsuite does not build, because
newlib/libc/include/sys/signal.h includes newlib/libc/include/signal.h.

Messages:
gcc -L/d/Langs/C/cygwin-src/src/.build/i686-pc-cygwin/winsup -L/d/Langs/C/cygwin-src/src/.build/i686-pc-cygwin/winsup/cygwin -L/d/Langs/C/cygwin-src/src/.build/i686-pc-cygwin/winsup/w32api/lib -isystem /d/Langs/C/cygwin-src/src/winsup/include -isystem /d/Langs/C/cygwin-src/src/winsup/cygwin/include -isystem /d/Langs/C/cygwin-src/src/winsup/w32api/include -B/d/Langs/C/cygwin-src/src/.build/i686-pc-cygwin/newlib/ -isystem /d/Langs/C/cygwin-src/src/.build/i686-pc-cygwin/newlib/targ-include -isystem /d/Langs/C/cygwin-src/src/newlib/libc/include -L/d/Langs/C/cygwin-src/src/.build/ld -I/usr/lib/gcc-lib/i686-pc-cygwin/3.3.3/include -c -nostdinc -MD -I../../../../winsup/testsuite/libltp/include -Wall -Wwrite-strings -fno-common -pipe -fbuiltin -fmessage-length=0 -I. -I/d/Langs/C/cygwin-src/src/winsup/cygwin -I/usr/lib/gcc-lib/i686-pc-cygwin/3.3.3/include -o ./parse_opts.o ../../../../winsup/testsuite/libltp/lib/parse_opts.c
In file included from /d/Langs/C/cygwin-src/src/newlib/libc/include/sys/signal.h:9,
                 from ../../../../winsup/testsuite/libltp/lib/parse_opts.c:74:
/d/Langs/C/cygwin-src/src/newlib/libc/include/signal.h:17: error: parse error before "_signal_r"
/d/Langs/C/cygwin-src/src/newlib/libc/include/signal.h:21: error: parse error before "signal"
In file included from /d/Langs/C/cygwin-src/src/newlib/libc/include/sys/signal.h:114,
                 from ../../../../winsup/testsuite/libltp/lib/parse_opts.c:74:
/d/Langs/C/cygwin-src/src/winsup/cygwin/include/cygwin/signal.h:145: error: `_sig_func_ptr' redeclared as different kind of symbol
/d/Langs/C/cygwin-src/src/newlib/libc/include/signal.h:21: error: previous declaration of `_sig_func_ptr'
../../../../winsup/testsuite/libltp/lib/parse_opts.c: In function `usc_global_setup_hook':
../../../../winsup/testsuite/libltp/lib/parse_opts.c:634: warning: implicit declaration of function `signal'

(Somehow I think there is some irony in this.)


ChangeLog-entry:

2004-10-14  Bas van Gompel  <cygwin-patch.buzz@bavag.tmfweb.nl>

	* lib/parse_opts.c: Define _SIGNAL_H_ to prevent inclusion of
	newlib/libc/include/signal.h.


--- src/winsup/testsuite/libltp/lib/parse_opts.c	8 Feb 2003 02:56:48 -0000	1.4
+++ src/winsup/testsuite/libltp/lib/parse_opts.c	14 Oct 2004 12:44:08 -0000
@@ -71,6 +71,8 @@
 #include <errno.h>
 #include <string.h>
 #include <sys/param.h>
+
+#define _SIGNAL_H_
 #include <sys/signal.h>
 #include <sys/types.h>
 #include <sys/time.h>


L8r,

Buzz.
-- 
  ) |  | ---/ ---/  Yes, this | This message consists of true | I do not
--  |  |   /    /   really is |   and false bits entirely.    | mail for
  ) |  |  /    /    a 72 by 4 +-------------------------------+ any1 but
--  \--| /--- /---  .sigfile. |   |perl -pe "s.u(z)\1.as."    | me. 4^re
