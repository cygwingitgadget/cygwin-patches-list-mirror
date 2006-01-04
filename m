Return-Path: <cygwin-patches-return-5693-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30400 invoked by alias); 4 Jan 2006 16:09:42 -0000
Received: (qmail 30384 invoked by uid 22791); 4 Jan 2006 16:09:41 -0000
X-Spam-Check-By: sourceware.org
Received: from main.gmane.org (HELO ciao.gmane.org) (80.91.229.2)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Wed, 04 Jan 2006 16:09:38 +0000
Received: from list by ciao.gmane.org with local (Exim 4.43) 	id 1EuBCW-0000Kv-9K 	for cygwin-patches@cygwin.com; Wed, 04 Jan 2006 17:09:24 +0100
Received: from eblake.csw.L-3com.com ([128.170.36.44])         by main.gmane.org with esmtp (Gmexim 0.1 (Debian))         id 1AlnuQ-0007hv-00         for <cygwin-patches@cygwin.com>; Wed, 04 Jan 2006 17:09:24 +0100
Received: from ebb9 by eblake.csw.L-3com.com with local (Gmexim 0.1 (Debian))         id 1AlnuQ-0007hv-00         for <cygwin-patches@cygwin.com>; Wed, 04 Jan 2006 17:09:24 +0100
To: cygwin-patches@cygwin.com
From:  Eric Blake <ebb9@byu.net>
Subject:  managed mounts and "
Date: Wed, 04 Jan 2006 16:09:00 -0000
Message-ID:  <loom.20060104T170724-189@post.gmane.org>
Mime-Version:  1.0
Content-Type:  text/plain; charset=us-ascii
Content-Transfer-Encoding:  7bit
User-Agent: Loom/3.14 (http://gmane.org/)
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q1/txt/msg00002.txt.bz2

I found it annoying that managed mounts can handle non-printing
characters, but not several of the remaining Windows' forbidden
characters, such as double quotes.

$ cd managed
$ touch `printf '\a'`
$ touch `printf '"'`
touch: cannot touch `"': No such file or directory

2006-01-04  Eric Blake  <ebb9@byu.net>

	* path.cc (dot_special_chars): Add ", <, >, and |.

Index: path.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/path.cc,v
retrieving revision 1.398
diff -u -r1.398 path.cc
--- path.cc     27 Dec 2005 18:10:49 -0000      1.398
+++ path.cc     4 Jan 2006 15:58:41 -0000
@@ -1,6 +1,6 @@
 /* path.cc: path support.
 
-   Copyright 1996, 1997, 1998, 1999, 2000, 2001, 2002, 2003, 2004, 2005 Red 
Hat, Inc.
+   Copyright 1996, 1997, 1998, 1999, 2000, 2001, 2002, 2003, 2004, 2005, 2006 
Red Hat, Inc.
 
 This file is part of Cygwin.
 
@@ -1331,6 +1331,7 @@
     "\021" "\022" "\023" "\024" "\025" "\026" "\027" "\030"
     "\031" "\032" "\033" "\034" "\035" "\036" "\037"
     ":"    "\\"   "*"    "?"    "%"
+    "\""   "<"    ">"    "|"
     "A"    "B"    "C"    "D"    "E"    "F"    "G"    "H"
     "I"    "J"    "K"    "L"    "M"    "N"    "O"    "P"
     "Q"    "R"    "S"    "T"    "U"    "V"    "W"    "X"


--
Eric Blake


