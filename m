Return-Path: <cygwin-patches-return-7925-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29047 invoked by alias); 31 Dec 2013 05:35:31 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 29034 invoked by uid 89); 31 Dec 2013 05:35:30 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=2.2 required=5.0 tests=AWL,BAYES_05 autolearn=ham version=3.3.2
X-HELO: m0.truegem.net
Received: from m0.truegem.net (HELO m0.truegem.net) (69.55.228.47) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-SHA encrypted) ESMTPS; Tue, 31 Dec 2013 05:35:28 +0000
Received: from localhost (mark@localhost)	by m0.truegem.net (8.12.11/8.12.11) with ESMTP id rBV5ZQiV033106	for <cygwin-patches@cygwin.com>; Mon, 30 Dec 2013 21:35:27 -0800 (PST)	(envelope-from mark@maxrnd.com)
Date: Tue, 31 Dec 2013 05:35:00 -0000
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] FAQ update: packages needed to build Cygwin
Message-ID: <Pine.BSF.4.63.1312302123390.16595@m0.truegem.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-IsSubscribed: yes
X-SW-Source: 2013-q4/txt/msg00021.txt.bz2

Hope I'm doing this correctly.  Here is the ChangeLog entry followed by 
the patch.  I wasn't sure if patch originator or patch committer, if 
different, gets their name in the ChangeLog entry.  Patch rationale 
available on request.
Cheers,

..mark

====

2013-12-31  Mark Geisert  <mark@maxrnd.com>

 	* faq-programming.xml: Update packages needed to build Cygwin.

====

Index: faq-programming.xml
===================================================================
RCS file: /cvs/src/src/winsup/doc/faq-programming.xml,v
retrieving revision 1.27
diff -u -r1.27 faq-programming.xml
--- faq-programming.xml 5 Jun 2013 07:57:39 -0000       1.27
+++ faq-programming.xml 31 Dec 2013 05:25:33 -0000
@@ -693,11 +693,19 @@
  <answer>

  <para>First, you need to make sure you have the necessary build tools
-installed; you at least need <literal>gcc</literal>, <literal>make</literal>,
-<literal>perl</literal>, and <literal>cocom</literal>. If you want to run
-the tests, <literal>dejagnu</literal> is also required.
+installed; you at least need <literal>g++</literal>, <literal>make</literal>,
+<literal>perl</literal>, <literal>cocom</literal>, <literal>gettext</literal>,
+and <literal>zlib-devel</literal>.
+Building for 32-bit Cygwin also requires <literal>libiconv</literal>,
+<literal>mingw64-i686-gcc-g++</literal>, <literal>mingw64-i686-zlib</literal>,
+and <literal>mingw64-x86_64-gcc-core</literal>.
+Building for 64-bit Cygwin also requires <literal>libiconv-devel</literal>,
+<literal>mingw64-x86_64-gcc-g++</literal>, and
+<literal>mingw64-x86_64-zlib</literal>.
+If you want to run the tests, <literal>dejagnu</literal> is also required.
  Normally, building ignores any errors in building the documentation,
-which requires the <literal>dblatex</literal>, <literal>docbook-xml45</literal>, <literal>docbook-xsl</literal>, and
+which requires the <literal>dblatex</literal>,
+<literal>docbook-xml45</literal>, <literal>docbook-xsl</literal>, and
  <literal>xmlto</literal> packages.  For more information on building the
  documentation, see the README included in the <literal>cygwin-doc</literal> package.
  </para>
