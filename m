Return-Path: <cygwin-patches-return-4046-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4303 invoked by alias); 8 Aug 2003 19:25:34 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4293 invoked from network); 8 Aug 2003 19:25:33 -0000
From: David Rothenberger <daveroth@acm.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Rdn0uem9Bc"
Content-Transfer-Encoding: 7bit
Message-ID: <16179.63786.774532.138718@phish.entomo.com>
Date: Fri, 08 Aug 2003 19:25:00 -0000
To: cygwin-patches@cygwin.com
Subject: [PATCH] pwdgrp::read_group(): Don't call free() twice with the same address
Reply-To: cygwin-patches@cygwin.com
X-SW-Source: 2003-q3/txt/msg00062.txt.bz2


--Rdn0uem9Bc
Content-Type: text/plain; charset=us-ascii
Content-Description: message body text
Content-Transfer-Encoding: 7bit
Content-length: 761

Hi,

This patch avoids the heap corruption that was causing the problem
described in
<http://www.cygwin.com/ml/cygwin/2003-08/msg00364.html>.

In pwdgrp::read_group(), there is loop to free allocated gr_mem
buffers.  That loop checks to see if gr_mem != &null_ptr, but does
not set gr_mem to &null_ptr after free() is called.  Subsequent
calls then attempt to free the same address again, corrupting the
malloc structures.

The tar test case triggers this behavior if there is no /etc
directory available, for some reason.

Dave

======================================================================
ChangeLog:
2003-08-08  David Rothenberger  <daveroth@acm.org>

	* grp.cc (read_group): Set __group32.gr_mem pointer back to
	&null_ptr after free() is called.


--Rdn0uem9Bc
Content-Type: text/plain
Content-Disposition: attachment;
	filename="grp.patch"
Content-Transfer-Encoding: 7bit
Content-length: 584

Index: cygwin/grp.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/grp.cc,v
retrieving revision 1.81
diff -u -u -p -r1.81 grp.cc
--- cygwin/grp.cc	30 Jun 2003 13:07:36 -0000	1.81
+++ cygwin/grp.cc	8 Aug 2003 18:29:44 -0000
@@ -75,7 +75,10 @@ pwdgrp::read_group ()
 {
   for (int i = 0; i < gr.curr_lines; i++)
     if ((*group_buf)[i].gr_mem != &null_ptr)
-      free ((*group_buf)[i].gr_mem);
+      {
+        free ((*group_buf)[i].gr_mem);
+        (*group_buf)[i].gr_mem = &null_ptr;
+      }
 
   load ("/etc/group");
 

--Rdn0uem9Bc--
