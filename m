Return-Path: <cygwin-patches-return-3344-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19772 invoked by alias); 19 Dec 2002 23:29:31 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19763 invoked from network); 19 Dec 2002 23:29:30 -0000
Message-Id: <3.0.5.32.20021219182916.00824490@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com
Date: Thu, 19 Dec 2002 15:29:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: grep on Win9x directories
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2002-q4/txt/msg00295.txt.bz2



2002-12-19  Pierre Humblet <pierre.humblet@ieee.org>

	* fhandler.cc (fhandler_base::open): Use "flags" rather than "mode" in 
	Win9X directory code.

Index: fhandler.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler.cc,v
retrieving revision 1.142
diff -u -p -r1.142 fhandler.cc
--- fhandler.cc 14 Dec 2002 19:11:42 -0000      1.142
+++ fhandler.cc 19 Dec 2002 23:20:53 -0000
@@ -463,9 +463,9 @@ fhandler_base::open (path_conv *pc, int 
     {
       if (!wincap.can_open_directories () && pc && pc->isdir ())
        {
-         if (mode & (O_CREAT | O_EXCL) == (O_CREAT | O_EXCL))
+         if (flags & (O_CREAT | O_EXCL) == (O_CREAT | O_EXCL))
            set_errno (EEXIST);
-         else if (mode & (O_WRONLY | O_RDWR))
+         else if (flags & (O_WRONLY | O_RDWR))
            set_errno (EISDIR);
          else
            set_nohandle (true);
