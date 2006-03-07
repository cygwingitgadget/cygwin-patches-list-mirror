Return-Path: <cygwin-patches-return-5803-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13576 invoked by alias); 7 Mar 2006 05:59:22 -0000
Received: (qmail 13564 invoked by uid 22791); 7 Mar 2006 05:59:22 -0000
X-Spam-Check-By: sourceware.org
Received: from green.qinip.net (HELO green.qinip.net) (62.100.30.36)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Tue, 07 Mar 2006 05:59:20 +0000
Received: from buzzy-box (hmm-dca-ap03-d10-147.dial.freesurf.nl [62.100.9.147]) 	by green.qinip.net (Postfix) with SMTP id 8D9C6425E; 	Tue,  7 Mar 2006 06:59:15 +0100 (MET)
Message-ID: <n2m-g.duja17.3vsg5gf.1@buzzy-box.bavag>
From: "Buzz" <cygwin-patches.buzz@bavag.tmfweb.nl>
Subject: [Patch] cygwinenv.sgml: Missing </para>.
Reply-To: cygwin-patches mailing-list <cygwin-patches@cygwin.com>
Organisation: Ehm...
User-Agent: slrn/0.9.8.1 (Win32) Hamster/2.1.0.0 KorrNews/4.2.1
To: cygwin-patches@cygwin.com
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="pau-mi"
Date: Tue, 07 Mar 2006 05:59:00 -0000
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q1/txt/msg00112.txt.bz2

--pau-mi
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8Bit
Content-length: 514

Hi,

Doc won't build...


ChangeLog-entry (You know, please fix the <at>.):

2006-03-07  Bas van Gompel  <cygwin-patch.buzz<at>bavag.tmfweb.nl>

	* cygwinenv.sgml: Add missing </para> at transparent_exe.


L8r,

Buzz.
-- 
  ) |  | ---/ ---/  Yes, this | This message consists of true | I do not
--  |  |   /    /   really is |   and false bits entirely.    | mail for
  ) |  |  /    /    a 72 by 4 +-------------------------------+ any1 but
--  \--| /--- /---  .sigfile. |   |perl -pe "s.u(z)\1.as."    | me. 4^re

--pau-mi
Content-Type: text/plain; name="cygwin-doc-env1.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="cygwin-doc-env1.patch"
Content-length: 536

--- src/winsup/doc/cygwinenv.sgml	2006-02-05 20:23:44.000000000 +0100
+++ src/winsup/doc/cygwinenv.sgml	2006-02-27 23:13:52.000000000 +0100
@@ -177,7 +177,7 @@ suffix transparently.  These functions a
 treated as too dangerous to act on files with .exe suffix if the .exe
 suffix wasn't given explicitely in the file name argument, and this is
 still the case if the transparent_exe option is not set.  Default is not
-set.
+set.</para>
 </listitem>
 <listitem>
 <para><envar>(no)traverse</envar> - This option only affects NT systems.

--pau-mi--
