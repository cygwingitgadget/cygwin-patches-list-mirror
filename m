Return-Path: <cygwin-patches-return-2417-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 8933 invoked by alias); 13 Jun 2002 17:11:53 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8910 invoked from network); 13 Jun 2002 17:11:52 -0000
Message-ID: <3D08D0E6.2090105@netscape.net>
Date: Thu, 13 Jun 2002 10:11:00 -0000
From: Nicholas Wourms <nwourms@netscape.net>
User-Agent: Mozilla/5.0 (Windows; U; Win 9x 4.90; en-US; rv:1.0rc2) Gecko/20020512 Netscape/7.0b1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Small Patch
Content-Type: multipart/mixed;
 boundary="------------040901020703010805040807"
X-SW-Source: 2002-q2/txt/msg00400.txt.bz2


--------------040901020703010805040807
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 1567

Hi all,

This is a patch to a few files to update the copyright year and fix a 
minor spelling error.  In winver.rc, I also formatted the DBA name in 
the same format as it appears throughout the rest of the source code.  I 
assume this will not require a copyright assignment, since it is only 13 
changes, 12 of which are only changes to comments.  If an assignment is 
required, then I will comply, just let me know.  As this is my first 
patch, I wasn't sure if "Ditto" was appropriate for patch comments, so 
forgive my ignorance.  I followed Joshua Franklin's formatting, as this 
was suggested by CGF in an earlier e-mail.  I also am using the same 
wording used by Corinna in a similar change.

ChangeLog:
2002-06-05  Nicholas S. Wourms <nwourms@netscape.net>

         * shared_info.h: Change copyright to include 2002.
         * shortcut.c: Change copyright to include 2002.
         * shortcut.h: Correct spelling error and changed copyright to 
include
         2002.
         * smallprint.c: Change copyright to include 2002.
         * string.h: Change copyright to include 2002.
         * sync.h: Change copyright to include 2002.
         * syslog.cc: Change copyright to include 2002.
         * textmode.c: Change copyright to include 2002.
         * thread.h: Removed duplicate copyright entry.
         * threaded_queue.h: Change copyright to include 2002.
         * wincap.h: Change copyright to include 2002.
         * winver.rc (LegalCopyright): Change copyright to include 
RedHat's full
         DBA name and to include 2002.

         

--------------040901020703010805040807
Content-Type: text/plain;
 name="formatting.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="formatting.diff"
Content-length: 6143

Index: shared_info.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/shared_info.h,v
retrieving revision 1.21
diff -u -3 -p -u -p -r1.21 shared_info.h
--- shared_info.h   9 Jun 2002 00:48:38 -0000   1.21
+++ shared_info.h   13 Jun 2002 16:20:55 -0000
@@ -1,6 +1,6 @@
 /* shared_info.h: shared info for cygwin
 
-   Copyright 2000, 2001 Red Hat, Inc.
+   Copyright 2000, 2001, 2002 Red Hat, Inc.
 
 This file is part of Cygwin.
 
Index: shortcut.c
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/shortcut.c,v
retrieving revision 1.15
diff -u -3 -p -u -p -r1.15 shortcut.c
--- shortcut.c  28 Nov 2001 02:36:32 -0000  1.15
+++ shortcut.c  13 Jun 2002 16:20:56 -0000
@@ -2,7 +2,7 @@
           the C++ interface to COM doesn't work without -fvtable-thunk
           which is too dangerous to use.
 
-   Copyright 2001 Red Hat, Inc.
+   Copyright 2001, 2002 Red Hat, Inc.
 
 This file is part of Cygwin.
 
Index: shortcut.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/shortcut.h,v
retrieving revision 1.2
diff -u -3 -p -u -p -r1.2 shortcut.h
--- shortcut.h  24 Jun 2001 22:26:52 -0000  1.2
+++ shortcut.h  13 Jun 2002 16:20:56 -0000
@@ -1,6 +1,6 @@
-/* shortcut.h: Hader file for shortcut.c
+/* shortcut.h: Header file for shortcut.c
 
-   Copyright 2001 Red Hat, Inc.
+   Copyright 2001, 2002 Red Hat, Inc.
 
 This file is part of Cygwin.
 
Index: smallprint.c
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/smallprint.c,v
retrieving revision 1.11
diff -u -3 -p -u -p -r1.11 smallprint.c
--- smallprint.c    23 May 2002 06:00:49 -0000  1.11
+++ smallprint.c    13 Jun 2002 16:20:56 -0000
@@ -1,6 +1,6 @@
 /* smallprint.c: small print routines for WIN32
 
-   Copyright 1996, 1998, 2000, 2001 Red Hat, Inc.
+   Copyright 1996, 1998, 2000, 2001, 2002 Red Hat, Inc.
 
 This file is part of Cygwin.
 
Index: string.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/string.h,v
retrieving revision 1.4
diff -u -3 -p -u -p -r1.4 string.h
--- string.h    24 Jun 2001 22:26:52 -0000  1.4
+++ string.h    13 Jun 2002 16:20:56 -0000
@@ -1,6 +1,6 @@
 /* string.h: Extra string defs
 
-   Copyright 2001 Red Hat, Inc.
+   Copyright 2001, 2002 Red Hat, Inc.
 
 This file is part of Cygwin.
 
Index: sync.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/sync.h,v
retrieving revision 1.20
diff -u -3 -p -u -p -r1.20 sync.h
--- sync.h  22 Feb 2002 19:33:41 -0000  1.20
+++ sync.h  13 Jun 2002 16:20:56 -0000
@@ -1,6 +1,6 @@
 /* sync.h: Header file for cygwin synchronization primitives.
 
-   Copyright 1999, 2000, 2001 Red Hat, Inc.
+   Copyright 1999, 2000, 2001, 2002 Red Hat, Inc.
 
    Written by Christopher Faylor <cgf@cygnus.com>
 
Index: syslog.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/syslog.cc,v
retrieving revision 1.20
diff -u -3 -p -u -p -r1.20 syslog.cc
--- syslog.cc   15 Oct 2001 23:39:33 -0000  1.20
+++ syslog.cc   13 Jun 2002 16:20:56 -0000
@@ -1,6 +1,6 @@
 /* syslog.cc
 
-   Copyright 1996, 1997, 1998, 1999, 2000, 2001 Red Hat, Inc.
+   Copyright 1996, 1997, 1998, 1999, 2000, 2001, 2002 Red Hat, Inc.
 
 This file is part of Cygwin.
 
Index: textmode.c
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/textmode.c,v
retrieving revision 1.5
diff -u -3 -p -u -p -r1.5 textmode.c
--- textmode.c  24 Jun 2001 22:26:53 -0000  1.5
+++ textmode.c  13 Jun 2002 16:20:56 -0000
@@ -1,6 +1,6 @@
 /* binmode.c
 
-   Copyright 2000 Red Hat, Inc.
+   Copyright 2000, 2001, 2002 Red Hat, Inc.
 
 This file is part of Cygwin.
 
Index: thread.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/thread.h,v
retrieving revision 1.37
diff -u -3 -p -u -p -r1.37 thread.h
--- thread.h    11 Jun 2002 16:06:16 -0000  1.37
+++ thread.h    13 Jun 2002 16:20:56 -0000
@@ -1,7 +1,6 @@
 /* thread.h: Locking and threading module definitions
 
    Copyright 1998, 1999, 2000, 2001, 2002 Red Hat, Inc.
-   Copyright 2001 Red Hat, Inc.
 
    Written by Marco Fuykschot <marco@ddi.nl>
    Major update 2001 Robert Collins <rbtcollins@hotmail.com>
Index: threaded_queue.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/threaded_queue.h,v
retrieving revision 1.2
diff -u -3 -p -u -p -r1.2 threaded_queue.h
--- threaded_queue.h    28 Feb 2002 14:30:29 -0000  1.2
+++ threaded_queue.h    13 Jun 2002 16:20:56 -0000
@@ -1,6 +1,6 @@
 /* threaded_queue.h
 
-   Copyright 2001 Red Hat Inc.
+   Copyright 2001, 2002 Red Hat Inc.
 
    Written by Robert Collins <rbtcollins@hotmail.com>
 
Index: wincap.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/wincap.h,v
retrieving revision 1.10
diff -u -3 -p -u -p -r1.10 wincap.h
--- wincap.h    10 Jun 2002 17:08:09 -0000  1.10
+++ wincap.h    13 Jun 2002 16:20:56 -0000
@@ -1,6 +1,6 @@
 /* wincap.h: Header for OS capability class.
 
-   Copyright 2001 Red Hat, Inc.
+   Copyright 2001, 2002 Red Hat, Inc.
 
 This file is part of Cygwin.
 
Index: winver.rc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/winver.rc,v
retrieving revision 1.4
diff -u -3 -p -u -p -r1.4 winver.rc
--- winver.rc   5 Sep 2001 19:36:49 -0000   1.4
+++ winver.rc   13 Jun 2002 16:20:56 -0000
@@ -36,7 +36,7 @@ BEGIN
       VALUE "FileDescription", "Cygwin\256 POSIX Emulation DLL"
       VALUE "FileVersion", STRINGIFY(CYGWIN_VERSION)
       VALUE "InternalName", CYGWIN_DLL_NAME
-      VALUE "LegalCopyright", "Copyright \251 Red Hat. 1996-2001"
+      VALUE "LegalCopyright", "Copyright \251 Red Hat, Inc. 1996-2002"
       VALUE "OriginalFilename", CYGWIN_DLL_NAME
       VALUE "ProductName", "Cygwin"
       VALUE "ProductVersion", STRINGIFY(CYGWIN_VERSION)

--------------040901020703010805040807--
