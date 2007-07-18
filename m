Return-Path: <cygwin-patches-return-6127-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10020 invoked by alias); 18 Jul 2007 15:06:51 -0000
Received: (qmail 10006 invoked by uid 22791); 18 Jul 2007 15:06:50 -0000
X-Spam-Check-By: sourceware.org
Received: from dessent.net (HELO dessent.net) (69.60.119.225)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Wed, 18 Jul 2007 15:06:42 +0000
Received: from localhost ([127.0.0.1] helo=dessent.net) 	by dessent.net with esmtp (Exim 4.50) 	id 1IBB6u-0007rw-J0 	for cygwin-patches@cygwin.com; Wed, 18 Jul 2007 15:06:40 +0000
Message-ID: <469E2C57.3A8BD304@dessent.net>
Date: Wed, 18 Jul 2007 15:06:00 -0000
From: Brian Dessent <brian@dessent.net>
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Doc change request
References: <20070717040309.GA29644@trixie.casa.cgf.cx>
Content-Type: multipart/mixed;  boundary="------------40C045C12B0B037127C79B95"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q3/txt/msg00002.txt.bz2

This is a multi-part message in MIME format.
--------------40C045C12B0B037127C79B95
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-length: 1313

Christopher Faylor wrote:

> Could I ask someone to do a search and replace on the docs and
> change all occurrences of /usr/man and /usr/doc to /usr/share/man
> and /usr/share/doc?
> 
> Brian, do you have time to do this?  I think you touched the
> documentation list so you're "it".

I can only find a total of three references to either directory,
and two of them mention it the context of "this was the old location":

faq-resources.xml-15-list what man pages the package includes.)  Some older packages still keep
faq-resources.xml:16:their documentation in <literal>/usr/doc/</literal>
faq-resources.xml-17-instead of <literal>/usr/share/doc/</literal>.

setup-net.sgml:235:Relevant documentation can be found in the <literal>/usr/doc/Cygwin/</literal> 
setup-net.sgml-236-or <literal>/usr/share/doc/Cygwin/</literal> directory.

The only remaining one is a glancing reference in the FAQ to rxvt,
and it needs cleaning up anyway as it refers to ash.  If the attached
fix is OK I will update the htdocs copy too.

faq-using.xml-864-<para>Don't invoke as simply ``rxvt'' because that will run /bin/sh (really
faq-using.xml-865-ash) which is not a good interactive shell.  For details see
faq-using.xml:866:<literal>/usr/doc/Cygwin/rxvt-&lt;ver&gt;.README</literal>.

Unless my grep-fu failed that's it.

Brian
--------------40C045C12B0B037127C79B95
Content-Type: text/plain; charset=us-ascii;
 name="faq-rxvt-readme-path.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="faq-rxvt-readme-path.patch"
Content-length: 1118

2007-07-18  Brian Dessent  <brian@dessent.net>

	* faq-using.xml (faq.using.console-window): Mention FHS location of
	docs and remove outdated reference to ash.

Index: faq-using.xml
===================================================================
RCS file: /cvs/src/src/winsup/doc/faq-using.xml,v
retrieving revision 1.6
diff -u -p -r1.6 faq-using.xml
--- faq-using.xml	26 Aug 2006 19:11:00 -0000	1.6
+++ faq-using.xml	18 Jul 2007 14:59:31 -0000
@@ -859,11 +859,8 @@ this message from the Cygwin mailing lis
 You can use it with or without X11.  You can resize it easily by
 dragging an edge or corner.  Copy and paste is easy with the left and
 middle mouse buttons, respectively.  It will honor settings in your
-~/.Xdefaults file, even without X.
-</para>
-<para>Don't invoke as simply ``rxvt'' because that will run /bin/sh (really
-ash) which is not a good interactive shell.  For details see
-<literal>/usr/doc/Cygwin/rxvt-&lt;ver&gt;.README</literal>.
+~/.Xdefaults file, even without X.  For details see
+<literal>/usr/share/doc/Cygwin/rxvt-&lt;ver&gt;.README</literal>.
 </para>
 </answer></qandaentry>
 

--------------40C045C12B0B037127C79B95--

