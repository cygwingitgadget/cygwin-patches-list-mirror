Return-Path: <cygwin-patches-return-2022-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 11414 invoked by alias); 4 Apr 2002 04:39:52 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11400 invoked from network); 4 Apr 2002 04:39:51 -0000
Message-ID: <20020404043951.19820.qmail@web20010.mail.yahoo.com>
Date: Wed, 03 Apr 2002 20:39:00 -0000
From: Joshua Daniel Franklin <joshuadfranklin@yahoo.com>
Subject: stackdump.sgml new file
To: cygwin-patches@cygwin.com
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-162781151-1017895191=:17861"
X-SW-Source: 2002-q2/txt/msg00006.txt.bz2

--0-162781151-1017895191=:17861
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-length: 1223

I was thinking about writing some updated documentation as requested
lately on the mailing list
(http://www.cygwin.com/ml/cygwin/2002-03/msg01633.html)
I've started by writing a new file to document the existance of the 
cygwin_stackdump() function. ChangeLog:

2001-04-03  Joshua Daniel Franklin <joshuadfranklin@yahoo.com>
	* stackdump.sgml: New file. Document cygwin_stackdump() function.

The function is described as "Temporary?" when first mentioned in the
ChangeLog, but since it appears to have been around since the first
net-release:
http://www.cygwin.com/ml/cygwin-announce/2000/msg00000.html
I thought it's probably permanent enough to have its own sgml file.

I'm not abandoning my quest to add --help and --version options to all
the utils, but I've got two patches out right now and would like to wait on 
these to keep it all managable in my thought. For reference, the patches are
for mkpasswd (similar to the applied mkgroup patch):
http://cygwin.com/ml/cygwin-patches/2002-q1/msg00352.html

and for kill.cc:
http://cygwin.com/ml/cygwin-patches/2002-q1/msg00339.html

__________________________________________________
Do You Yahoo!?
Yahoo! Tax Center - online filing with TurboTax
http://taxes.yahoo.com/
--0-162781151-1017895191=:17861
Content-Type: text/html; name="stackdump.sgml-patch"
Content-Description: stackdump.sgml-patch
Content-Disposition: inline; filename="stackdump.sgml-patch"
Content-length: 375

--- stackdump.sgml-orig	Wed Apr  3 21:36:00 2002
+++ stackdump.sgml	Wed Apr  3 20:57:07 2002
@@ -0,0 +1,14 @@
+
+<sect1 id="func-cygwin-stackdump">
+<title>cygwin_stackdump</title>
+
+<funcsynopsis>
+<funcdef>extern "C" void
+<function>cygwin_stackdump</function></funcdef>
+<void>
+</funcsynopsis>
+
+<para> Produce a stackdump from the called location
+</para>
+
+</sect1>

--0-162781151-1017895191=:17861--
