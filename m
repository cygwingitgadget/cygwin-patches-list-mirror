Return-Path: <cygwin-patches-return-4098-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8596 invoked by alias); 17 Aug 2003 14:52:04 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8587 invoked from network); 17 Aug 2003 14:52:02 -0000
Message-Id: <3.0.5.32.20030817105058.007e9b40@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com (Unverified)
Date: Sun, 17 Aug 2003 14:52:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: RE: [PATCH] pwdgrp::read_group(): Don't call free() twice with
  the same address 
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2003-q3/txt/msg00114.txt.bz2

While Dave Rothenberger has correctly localized the problem
described in
<http://www.cygwin.com/ml/cygwin/2003-08/msg00364.html>
the patch 
<http://cygwin.com/ml/cygwin-patches/2003-q3/msg00062.html>
only fixes the symptom of the bug but not the root cause.

Setting gr_mem to &null_ptr below should not be necessary
because the subsequent load() should reset curr_lines to 0
and call pwdgrp::parse_group (), which sets gr_mem to &null_ptr.
Thus free() should never be called twice. 
******
  for (int i = 0; i < gr.curr_lines; i++)
    if ((*group_buf)[i].gr_mem != &null_ptr)
      {
        free ((*group_buf)[i].gr_mem);
        (*group_buf)[i].gr_mem = &null_ptr;
      }

  load ("/etc/group");
******

The original bug report mentions that the problem only occurs 
when /etc is absent. In that case curr_lines is NOT reset by 
pwdgrp::load, although it is incremented when the default entries
(the ones with "mkpasswd" and "????????") are added to the internal 
group file. 
When /etc does not exist, the default entries are added repeatedly 
and the internal group file keeps growing (ditto for passwd).

I believe that reverting the original patch and applying the one 
below fixes the root bug.

Pierre


2003-08-17  Pierre Humblet  <pierre.humblet@ieee.org>

	* grp.cc (read_group): Revert previous change.
	* uinfo.cc (pwdgrp::load): Always reset curr_lines.



Index: grp.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/grp.cc,v
retrieving revision 1.82
diff -u -p -r1.82 grp.cc
--- grp.cc      8 Aug 2003 19:28:34 -0000       1.82
+++ grp.cc      17 Aug 2003 14:30:56 -0000
@@ -75,10 +75,7 @@ pwdgrp::read_group ()
 {
   for (int i = 0; i < gr.curr_lines; i++)
     if ((*group_buf)[i].gr_mem != &null_ptr)
-      {
-        free ((*group_buf)[i].gr_mem);
-        (*group_buf)[i].gr_mem = &null_ptr;
-      }
+      free ((*group_buf)[i].gr_mem);
 
   load ("/etc/group");
 
Index: uinfo.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/uinfo.cc,v
retrieving revision 1.116
diff -u -p -r1.116 uinfo.cc
--- uinfo.cc    14 Jul 2003 17:04:21 -0000      1.116
+++ uinfo.cc    17 Aug 2003 14:30:57 -0000
@@ -458,6 +458,7 @@ pwdgrp::load (const char *posix_fname)
   if (buf)
     free (buf);
   buf = NULL;
+  curr_lines = 0;
 
   pc.check (posix_fname);
   etc_ix = etc::init (etc_ix, pc);
@@ -496,7 +497,6 @@ pwdgrp::load (const char *posix_fname)
              CloseHandle (fh);
              buf[read_bytes] = '\0';
              char *eptr = buf;
-             curr_lines = 0;
              while ((eptr = add_line (eptr)))
                continue;
              debug_printf ("%s curr_lines %d", posix_fname, curr_lines);


 
 
