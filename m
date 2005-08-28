Return-Path: <cygwin-patches-return-5633-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11725 invoked by alias); 28 Aug 2005 20:49:48 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11713 invoked by uid 22791); 28 Aug 2005 20:49:43 -0000
Received: from green.qinip.net (HELO green.qinip.net) (62.100.30.36)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Sun, 28 Aug 2005 20:49:43 +0000
Received: from buzzy-box (hmm-dca-ap03-d13-219.dial.freesurf.nl [62.100.12.219])
	by green.qinip.net (Postfix) with SMTP
	id 739BD4474; Sun, 28 Aug 2005 22:49:39 +0200 (MET DST)
Message-ID: <n2m-g.detf2n.3vv9c19.1@buzzy-box.bavag>
From: Bas van Gompel <cygwin-patches.buzz@bavag.tmfweb.nl>
Subject: [patch] Don't append extra NUL to registry-strings.
Reply-To: cygwin-patches mailing-list <cygwin-patches@cygwin.com>
Organisation: Ehm...
User-Agent: slrn/0.9.8.1 (Win32) Hamster/2.0.7.0 KorrNews/4.2
To: cygwin-patches@cygwin.com
Date: Sun, 28 Aug 2005 20:49:00 -0000
X-SW-Source: 2005-q3/txt/msg00088.txt.bz2

Hi,

When RegQueryValueEx returns a string-type, the final NUL is included
in the returned size. I suggest dropping it.


A ChangeLog-entry?

2005-08-28  Bas van Gompel  <cygwin-patch.buzz@bavag.tmfweb.nl>

	*fhandler_registry.cc	(fhandler_registry::fill_filebuf): Don't
	keep terminating null-character on string-types.


diff -u -p -r1.33 fhandler_registry.cc
--- src/winsup/cygwin/fhandler_registry.cc	24 Aug 2005 04:38:39 -0000	1.33
+++ src/winsup/cygwin/fhandler_registry.cc	28 Aug 2005 17:38:18 -0000
@@ -599,6 +599,8 @@ fhandler_registry::fill_filebuf ()
       while (error == ERROR_MORE_DATA);
       filesize = size;
     }
+  if (type == REG_SZ || type == REG_MULTI_SZ || type == REG_EXPAND_SZ)
+    filesize--;
   return true;
 value_not_found:
   DWORD buf_size = CYG_MAX_PATH;


L8r,

Buzz.
-- 
  ) |  | ---/ ---/  Yes, this | This message consists of true | I do not
--  |  |   /    /   really is |   and false bits entirely.    | mail for
  ) |  |  /    /    a 72 by 4 +-------------------------------+ any1 but
--  \--| /--- /---  .sigfile. |   |perl -pe "s.u(z)\1.as."    | me. 4^re
