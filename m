Return-Path: <cygwin-patches-return-3093-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 25109 invoked by alias); 1 Nov 2002 00:22:10 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 25075 invoked from network); 1 Nov 2002 00:22:09 -0000
Message-Id: <3.0.5.32.20021031192006.00826c90@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com
Date: Thu, 31 Oct 2002 16:22:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: Re: open() not handling previously opened serial port
  gracefully? 
Cc: Troy Curtiss <tcurtiss@qcpi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2002-q4/txt/msg00044.txt.bz2

This fixes 
http://sources.redhat.com/ml/cygwin/2002-10/msg01792.html

Pierre

2002-10-31  Pierre Humblet <pierre.humblet@ieee.org>

	* fhandler.cc (fhandler_base::open): Verify pc isn't NULL.

--- fhandler.cc.orig    2002-10-31 18:46:24.000000000 -0500
+++ fhandler.cc 2002-10-31 18:47:38.000000000 -0500
@@ -442,7 +442,7 @@ fhandler_base::open (path_conv *pc, int 
 
   if (x == INVALID_HANDLE_VALUE)
     {
-      if (pc->isdir () && !wincap.can_open_directories ())
+      if (!wincap.can_open_directories () && pc && pc->isdir ())
        {
          if (mode & (O_CREAT | O_EXCL) == (O_CREAT | O_EXCL))
            set_errno (EEXIST);
