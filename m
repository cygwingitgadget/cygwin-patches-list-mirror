Return-Path: <cygwin-patches-return-3085-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 17518 invoked by alias); 24 Oct 2002 04:28:50 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 17505 invoked from network); 24 Oct 2002 04:28:49 -0000
Message-Id: <3.0.5.32.20021024002430.00824210@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com
Date: Wed, 23 Oct 2002 21:28:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: CreateFile in pwdgrp.h 
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2002-q4/txt/msg00036.txt.bz2


2002-10-24  Pierre Humblet <pierre.humblet@ieee.org>

	* pwdgrp.h (pwdgrp_read::open): Compare fh to INVALID_HANDLE_VALUE.

--- pwdgrp.h.orig       2002-10-24 00:04:06.000000000 -0400
+++ pwdgrp.h    2002-10-24 00:04:38.000000000 -0400
@@ -71,7 +71,7 @@ public:
 
     fh = CreateFile (pc, GENERIC_READ, wincap.shared (), NULL, OPEN_EXISTING,
                     FILE_ATTRIBUTE_NORMAL, 0);
-    if (fh)
+    if (fh != INVALID_HANDLE_VALUE)
       {
        DWORD size = GetFileSize (fh, NULL), read_bytes;
        buf = (char *) malloc (size + 1);
