Return-Path: <cygwin-patches-return-5357-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19013 invoked by alias); 23 Feb 2005 17:07:37 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18240 invoked from network); 23 Feb 2005 17:07:33 -0000
Received: from unknown (HELO ciao.gmane.org) (80.91.229.2)
  by sourceware.org with SMTP; 23 Feb 2005 17:07:33 -0000
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1D3zuz-0008Qy-7C
	for cygwin-patches@cygwin.com; Wed, 23 Feb 2005 18:03:26 +0100
Received: from eblake.csw.L-3com.com ([128.170.36.44])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <cygwin-patches@cygwin.com>; Wed, 23 Feb 2005 18:03:21 +0100
Received: from ebb9 by eblake.csw.L-3com.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <cygwin-patches@cygwin.com>; Wed, 23 Feb 2005 18:03:21 +0100
To: cygwin-patches@cygwin.com
From: Eric Blake <ebb9@byu.net>
Subject: patch for devices.in
Date: Wed, 23 Feb 2005 17:07:00 -0000
Message-ID: <loom.20050223T175658-904@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 128.170.36.44 (Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0; .NET CLR 1.1.4322))
X-Gmane-MailScanner: Found to be clean
X-Gmane-MailScanner: Found to be clean
X-MailScanner-From: gocp-cygwin-patches@m.gmane.org
X-MailScanner-To: cygwin-patches@cygwin.com
X-SW-Source: 2005-q1/txt/msg00060.txt.bz2

Found this when reviewing the change to add /dev/full

2005-02-23  Eric Blake  <ebb9@byu.net>  (tiny change)

	* devices.in (parsedisk): Fix typo.

Index: cygwin/devices.in
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/devices.in,v
retrieving revision 1.7
diff -u -r1.7 devices.in
--- cygwin/devices.in   23 Feb 2005 12:30:31 -0000      1.7
+++ cygwin/devices.in   23 Feb 2005 17:02:44 -0000
@@ -140,7 +140,7 @@
   else
     {
       base = DEV_SD1_MAJOR;
-      drive -= 'q' - 'q';
+      drive -= 'q' - 'a';
     }
   parse (base, part + (drive * 16));
 }

