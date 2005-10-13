Return-Path: <cygwin-patches-return-5660-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15497 invoked by alias); 13 Oct 2005 20:42:40 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 15481 invoked by uid 22791); 13 Oct 2005 20:42:34 -0000
Received: from vms046pub.verizon.net (HELO vms046pub.verizon.net) (206.46.252.46)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Thu, 13 Oct 2005 20:42:33 +0000
Received: from [127.0.0.1] ([71.112.123.27])
 by vms046.mailsrvcs.net (Sun Java System Messaging Server 6.2 HotFix 0.04
 (built Dec 24 2004)) with ESMTPA id <0IOB00AJMG3Q6EF1@vms046.mailsrvcs.net> for
 cygwin-patches@cygwin.com; Thu, 13 Oct 2005 15:40:40 -0500 (CDT)
Date: Thu, 13 Oct 2005 20:42:00 -0000
From: David Rothenberger <daveroth@acm.org>
Subject: [patch] Create directories with 755 instead of 644.
To: cygwin-patches@cygwin.com
Reply-to: cygwin-patches@cygwin.com
Message-id: <434EC646.2070800@acm.org>
MIME-version: 1.0
Content-type: multipart/mixed; boundary=------------090609040208030306010508
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-SW-Source: 2005-q4/txt/msg00002.txt.bz2

This is a multi-part message in MIME format.
--------------090609040208030306010508
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 663

I attempted to build the Cygwin DLL from CVS today and encountered 
permission denied errors from the install target in winsup/cygwin. The 
problem appears to be that directories are precreated using "install -m 
644". With 644 permissions, subsequent install calls to copy files to 
those directories fail.

The following patch fixed the problem for me.

ChangeLog for winsup/cygwin:

2005-10-13  David Rothenberger <daveroth@acm.org>

	* Makefile.in:  Create directories with 755 permissions.

-- 
David Rothenberger                spammer? -> spam@daveroth.dyndns.org
GPG/PGP: 0x7F67E734, C233 365A 25EF 2C5F C8E1 43DF B44F BA26 7F67 E734

Klatu barada nikto.

--------------090609040208030306010508
Content-Type: text/plain;
 name="Makefile.in.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Makefile.in.patch"
Content-length: 500

Index: Makefile.in
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/Makefile.in,v
retrieving revision 1.181
diff -u -p -r1.181 Makefile.in
--- Makefile.in	11 Oct 2005 18:27:05 -0000	1.181
+++ Makefile.in	13 Oct 2005 20:35:25 -0000
@@ -69,7 +69,7 @@ OBJCOPY:=@OBJCOPY@
 OBJDUMP:=@OBJDUMP@
 STRIP:=@STRIP@
 LDSCRIPT:=cygwin.sc
-MKDIRP:=$(INSTALL_DATA) -d
+MKDIRP:=$(INSTALL_DATA) -d -m 755
 
 #
 # Include common definitions for winsup directory

--------------090609040208030306010508--
