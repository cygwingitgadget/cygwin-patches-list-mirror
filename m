Return-Path: <cygwin-patches-return-5171-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2506 invoked by alias); 28 Nov 2004 18:40:36 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 2458 invoked from network); 28 Nov 2004 18:40:25 -0000
Received: from unknown (HELO mailout09.sul.t-online.com) (194.25.134.84)
  by sourceware.org with SMTP; 28 Nov 2004 18:40:25 -0000
Received: from fwd03.aul.t-online.de 
	by mailout09.sul.t-online.com with smtp 
	id 1CYTyB-0002W9-03; Sun, 28 Nov 2004 19:40:23 +0100
Received: from workhorse (VOKuByZHgezS5DJC-pMP9qRG92Um58m4cprWlUfe-4Wis9GylVxdQ4@[80.131.30.190]) by fwd03.sul.t-online.com
	with smtp id 1CYTxv-28ZlwG0; Sun, 28 Nov 2004 19:40:07 +0100
Received: by localhost with Microsoft MAPI; Sun, 28 Nov 2004 19:40:19 +0100
Message-ID: <01C4D582.180CE6E0.Gerd.Spalink@t-online.de>
From: Gerd.Spalink@t-online.de (Gerd Spalink)
Reply-To: "Gerd.Spalink@t-online.de" <Gerd.Spalink@t-online.de>
To: "'cygwin-patches@cygwin.com'" <cygwin-patches@cygwin.com>
Subject: Update of fhandler-tut.txt
Date: Sun, 28 Nov 2004 18:40:00 -0000
Organization: privat
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-ID: VOKuByZHgezS5DJC-pMP9qRG92Um58m4cprWlUfe-4Wis9GylVxdQ4
X-TOI-MSGID: d46ae2ba-0f56-4dac-bf00-552da469151f
X-SW-Source: 2004-q4/txt/msg00172.txt.bz2

When trying to add an experimental /dev/mixer, I found that
the fhandler tutorial was obsolete. This patch brings it up-to-date.


ChangeLog Entry:


2004-11-28  Gerd Spalink  <Gerd.Spalink@t-online.de>

        * fhandler-tut.txt: Update description to cygwin 1.5.13


Patch:


Index: fhandler-tut.txt
===================================================================
RCS file: /cvs/src/src/winsup/doc/fhandler-tut.txt,v
retrieving revision 1.2
diff -p -u -r1.2 fhandler-tut.txt
--- fhandler-tut.txt    18 Aug 2000 19:52:31 -0000      1.2
+++ fhandler-tut.txt    28 Nov 2004 18:38:47 -0000
@@ -6,7 +6,7 @@ showing an example of /dev/zero.
 Files to note:

 fhandler.h - must define a new derived class here and FH_*
-path.cc - to notice "/dev/zero" and mark it
+devices.in - to notice "/dev/zero" and mark it
 fhandler_zero.cc - new
 dtable.cc - to create the fhandler instance

@@ -27,23 +27,38 @@ simulating everything.  Thus:
   handle of -1, which (1) maps swap memory, and (2) zeros it out for
   us (at least, on NT).

-OK, let's start with fhandler.h.
+OK, let's start with devices.h.

-First, update the comment about which files are where.  We're adding
-fhandler_dev_zero as FH_DEV_ZERO.  We're adding this as a "fast"
-device (it will never block) so we have to adjust FH_NDEV also.
+We have to create a new entry in the enum fh_devices.  The new
+devices must get a major and a minor ID.  As a rule of thumb, just
+copy the ones that are used on a linux system.

-Later in that file, we'll copy fhandler_dev_null and edit it to be
+Now, let's continue with fhandler.h.
+
+First, update the fhandler_union near the end of the file with a
+line for the new device.  Use existing members, in this case __dev_null
+as a template.  This union is sorted alphabetically.
+
+Earlier in that file, we'll copy fhandler_dev_null and edit it to be
 fhandler_dev_zero.  I chose that one because it's small, but we'll add
 more members as we go (since we're simulating the whole thing).  In
 fact, let's copy the I/O methods from fhandler_windows since we'll
 need all those anyway, even though we'll go through the full list
 later.

-OK, next we need to edit path.cc to recognize when the user is trying
-to open "/dev/zero".  Look in get_device_number; there's a long list
-of cases, just add one (I added one after "null").  Also remember to
-add an entry to the windows_device_names list in the right spot.
+OK, next we need to edit devices.in.  There is a section where each device
+is listed with its cygwin path, its structure and its windows path.
+"/dev/zero", FH_ZERO, "\\dev\\zero"
+This is needed to recognize when the user is trying to open "/dev/zero".
+You have to build devices.cc from devices.in now.
+There is a script 'gendevices' in the winsup/cygwin directory which may
+be called at some time in the future if you use 'make' to build the DLL.
+However, I had to type
+make /cygdrive/c/sw/cygwin_dev/src/winsup/cygwin/devices.cc
+in the directory /cygdrive/c/sw/cygwin_dev/obj/i686-pc-cygwin/winsup/cygwin
+to achieve this.  Note the absolute path names here.
+You have to have shilka available to do that; this is part of the
+cygwin cocom package.

 To go along with that change, we'll need to change dtable.cc.  Look for
 FH_NULL and add a case for FH_ZERO as well.
