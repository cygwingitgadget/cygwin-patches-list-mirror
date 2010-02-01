Return-Path: <cygwin-patches-return-6936-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3679 invoked by alias); 1 Feb 2010 20:52:00 -0000
Received: (qmail 3669 invoked by uid 22791); 1 Feb 2010 20:51:59 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0 	tests=AWL,BAYES_00,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from qw-out-1920.google.com (HELO qw-out-1920.google.com) (74.125.92.144)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 01 Feb 2010 20:51:46 +0000
Received: by qw-out-1920.google.com with SMTP id 4so568989qwk.20         for <cygwin-patches@cygwin.com>; Mon, 01 Feb 2010 12:51:42 -0800 (PST)
Received: by 10.224.87.19 with SMTP id u19mr1811273qal.8.1265057501853;         Mon, 01 Feb 2010 12:51:41 -0800 (PST)
Received: from ?192.168.0.101? (S010600112f237275.wp.shawcable.net [24.76.241.98])         by mx.google.com with ESMTPS id 20sm4048962qyk.1.2010.02.01.12.51.41         (version=TLSv1/SSLv3 cipher=RC4-MD5);         Mon, 01 Feb 2010 12:51:41 -0800 (PST)
Message-ID: <4B673EE3.6040109@users.sourceforge.net>
Date: Mon, 01 Feb 2010 20:52:00 -0000
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.1.7) Gecko/20100111 Thunderbird/3.0.1
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [PATCH] winsup/doc/README: docbook-utils
Content-Type: multipart/mixed;  boundary="------------020900060206030707020804"
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2010-q1/txt/msg00052.txt.bz2

This is a multi-part message in MIME format.
--------------020900060206030707020804
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 440

This patch updates winsup/doc/README for the new docbook-utils package, 
which provides the docbook2pdf command for building the PDFs.

As for the note about docbook2X (which is a separate package not 
included in today's additions) for info pages, I missed that until now 
because it is not part of the Makefile.  If someone could give me some 
details on what has been done until now, I'll see what I can do about 
that as well.


Yaakov

--------------020900060206030707020804
Content-Type: text/x-patch;
 name="doc-docbook-reqs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="doc-docbook-reqs.patch"
Content-length: 1032

2010-Feb-01  Yaakov Selkowitz  <yselkowitz@cygwin.com>

	* README: Update for Cygwin docbook-utils package.

Index: README
===================================================================
RCS file: /cvs/src/src/winsup/doc/README,v
retrieving revision 1.1
diff -u -r1.1 README
--- README	24 Feb 2005 05:26:33 -0000	1.1
+++ README	1 Feb 2010 20:43:57 -0000
@@ -3,10 +3,11 @@
 
 BUILD REQUIREMENTS:
 
-ash
+bash
 bzip2
 coreutils
 cygwin
+docbook-utils
 docbook-xml42
 docbook-xsl
 gzip
@@ -20,9 +21,7 @@
 
 You may use docbook2X to convert the DocBook files into info pages.
 I have not been able to get a working docbook2X installation on Cygwin,
-so currently I convert the files on a machine running GNU/Linux. PDF
-generation is also problematic; I use 'jw -b pdf' right now but have
-also used 'xmlto pdf' and jade.
+so currently I convert the files on a machine running GNU/Linux.
 
 A few handmade files (cygwin.texi, intro.3, etc.) are found in the
 cygwin-doc-x.y-z-src.tar.bz2 package. It also contains the utilities for

--------------020900060206030707020804--
