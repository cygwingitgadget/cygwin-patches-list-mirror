From: "Michael A. Chase" <mchase@ix.netcom.com>
To: <cygwin-patches@cygwin.com>
Subject: [PATCH]choose:cc: Incorrect copy in _Info::_Info
Date: Sat, 16 Jun 2001 11:39:00 -0000
Message-id: <019401c0f693$60861800$6464648a@ca.boeing.com>
X-SW-Source: 2001-q2/msg00313.html

I'm reading through the sources to setup.exe to get ready to make some
suggestions.

The part of _Info::_Info in choose.cc that copies the source file name is
using 'source' where is should be using '_source'.
--
Mac :})
Give a hobbit a fish and he'll eat fish for a day.
Give a hobbit a ring and he'll eat fish for an age.

ChangeLog:

Sat Jun 16 11:33:51  2001  Michael A Chase <mchase@ix.netcom.com>

        * choose.cc (_Info::_Info): Use correct parameter for source file
name.

$ diff -up choose.cc-orig choose.cc
--- choose.cc-orig   Fri Jun 15 03:48:52 2001
+++ choose.cc Sat Jun 16 10:13:35 2001
@@ -844,9 +844,9 @@ _Info::_Info (const char *_install, cons
   install = strdup (_install);
   version = strdup (_version);
   install_size = _install_size;
-  if (source)
+  if (_source)
     {
-      source = strdup (source);
+      source = strdup (_source);
       source_size = _source_size;
     }
 }

