Return-Path: <cygwin-patches-return-1843-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 17113 invoked by alias); 6 Feb 2002 18:03:09 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 16999 invoked from network); 6 Feb 2002 18:03:03 -0000
Date: Wed, 06 Feb 2002 10:10:00 -0000
From: Jason Tishler <jason@tishler.net>
Subject: connect patch
To: Cygwin-Patches <cygwin-patches@sources.redhat.com>
Mail-followup-to: Cygwin-Patches <cygwin-patches@sources.redhat.com>
Message-id: <20020206180727.GA504@dothill.com>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_aaefCMFJZ9V5NxgBM0Vq+Q)"
User-Agent: Mutt/1.3.24i
X-SW-Source: 2002-q1/txt/msg00200.txt.bz2


--Boundary_(ID_aaefCMFJZ9V5NxgBM0Vq+Q)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
Content-length: 367

The attached patch fixes a SEGV when getsockname () is called.  This
problem can be tickled by the PostgreSQL 7.2 version of psql:

    http://archives.postgresql.org/pgsql-cygwin/2002-02/msg00012.php

Note that I essentially plagiarized the following commit:

    http://cygwin.com/ml/cygwin-cvs/2002-q1/msg00028.html

Was this the right thing to do?

Thanks,
Jason

--Boundary_(ID_aaefCMFJZ9V5NxgBM0Vq+Q)
Content-type: text/plain; charset=us-ascii; NAME=net.cc.diff
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=net.cc.diff
Content-length: 533

Index: net.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/net.cc,v
retrieving revision 1.99
diff -u -p -r1.99 net.cc
--- net.cc	2002/01/29 13:39:41	1.99
+++ net.cc	2002/02/06 17:52:16
@@ -557,6 +557,8 @@ cygwin_socket (int af, int type, int pro
 	name = (type == SOCK_STREAM ? "/dev/streamsocket" : "/dev/dgsocket");
 
       fdsock (fd, name, soc)->set_addr_family (af);
+      if (af == AF_LOCAL)
+	fdsock (fd, name, soc)->set_sun_path (name);
       res = fd;
     }
 

--Boundary_(ID_aaefCMFJZ9V5NxgBM0Vq+Q)
Content-type: text/plain; charset=us-ascii; NAME=net.cc.ChangeLog
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=net.cc.ChangeLog
Content-length: 116

2002-02-06  Jason Tishler  <jason@tishler.net>

	* net.cc (cygwin_socket): Set sun_path for newly connected socket.

--Boundary_(ID_aaefCMFJZ9V5NxgBM0Vq+Q)--
