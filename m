Return-Path: <cygwin-patches-return-7038-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27767 invoked by alias); 26 Jun 2010 00:02:42 -0000
Received: (qmail 27657 invoked by uid 22791); 26 Jun 2010 00:02:40 -0000
X-SWARE-Spam-Status: No, hits=-50.9 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE
X-Spam-Check-By: sourceware.org
Received: from mail-pv0-f171.google.com (HELO mail-pv0-f171.google.com) (74.125.83.171)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sat, 26 Jun 2010 00:02:34 +0000
Received: by pvg4 with SMTP id 4so1475770pvg.2        for <cygwin-patches@cygwin.com>; Fri, 25 Jun 2010 17:02:33 -0700 (PDT)
Received: by 10.142.59.2 with SMTP id h2mr234531wfa.349.1277510553003;        Fri, 25 Jun 2010 17:02:33 -0700 (PDT)
Received: from [127.0.0.1] (S0106000cf16f58b1.wp.shawcable.net [24.76.240.202])        by mx.google.com with ESMTPS id l10sm757938rvh.21.2010.06.25.17.02.32        (version=SSLv3 cipher=RC4-MD5);        Fri, 25 Jun 2010 17:02:32 -0700 (PDT)
Subject: Re: doc: use xmlto pdf
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
To: cygwin-patches <cygwin-patches@cygwin.com>
In-Reply-To: <20100625211413.GA2341@calimero.vinschen.de>
References: <1277494710.9108.37.camel@YAAKOV04>	 <20100625211413.GA2341@calimero.vinschen.de>
Content-Type: multipart/mixed; boundary="=-nzBxgq4M0H2qCL6JgGbE"
Date: Sat, 26 Jun 2010 00:02:00 -0000
Message-ID: <1277510567.7536.18.camel@YAAKOV04>
Mime-Version: 1.0
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2010-q2/txt/msg00021.txt.bz2


--=-nzBxgq4M0H2qCL6JgGbE
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 755

On Fri, 2010-06-25 at 23:14 +0200, Corinna Vinschen wrote:
> The reason that I changed that to docbook2pdf at one point was that
> creating a PDF from the docs never worked for me before.
> 
> And with your patch it also doesn't work for me on two different Linux
> systems with different xmlto versions (0.0.18 and 0.0.23).  Here's what
> happens on Fedora 13, the result is practically the same on the older
> system.  Maybe you know a solution?

I was able to duplicate this on a linux VM; it appears to be a problem
with the passivetex backend.  If I force the dblatex backend, then it
works, but requires xmlto >= 0.0.21[1].  Could you try the attached
patch instead?


Yaakov

[1] 0.0.21 is shipped in F-10, Debian squeeze, Ubuntu 9.10, and newer.


--=-nzBxgq4M0H2qCL6JgGbE
Content-Disposition: attachment; filename="doc-xmlto-pdf.patch"
Content-Type: text/x-patch; name="doc-xmlto-pdf.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 2651

2010-06-25  Yaakov Selkowitz  <yselkowitz@users.sourceforge.net>

	* Makefile.in: Use "xmlto pdf" instead of docbook2pdf.
	Force the dblatex backend, as the default passivetex does not work.
	* README: Remove docbook-utils and update docbook-xml deps.
	* faq-programming.xml: Ditto.

Index: Makefile.in
===================================================================
RCS file: /cvs/src/src/winsup/doc/Makefile.in,v
retrieving revision 1.26
diff -u -r1.26 Makefile.in
--- Makefile.in	26 Jan 2010 16:16:19 -0000	1.26
+++ Makefile.in	25 Jun 2010 19:24:52 -0000
@@ -17,7 +17,7 @@
 CC_FOR_TARGET:=@CC@
 exeext:=@build_exeext@
 
-XMLTO:=xmlto --skip-validation
+XMLTO:=xmlto --skip-validation --with-dblatex
 
 include $(srcdir)/../Makefile.common
 
@@ -56,7 +56,7 @@
 
 # Some versions of jw hang with the -o option
 cygwin-ug-net/cygwin-ug-net.pdf : cygwin-ug-net.sgml
-	-cd cygwin-ug-net && docbook2pdf ../$<
+	-${XMLTO} pdf -o cygwin-ug-net/ $<
 
 cygwin-ug-net.sgml : cygwin-ug-net.in.sgml ./doctool Makefile
 	-./doctool -m $(SGMLDIRS) -s $(srcdir) -o $@ $<
@@ -65,7 +65,7 @@
 	-${XMLTO} html -o cygwin-api/ -m $(srcdir)/cygwin.dsl $<
 
 cygwin-api/cygwin-api.pdf : cygwin-api.sgml
-	-cd cygwin-api && docbook2pdf ../$<
+	-${XMLTO} pdf -o cygwin-api/ $<
 
 cygwin-api.sgml : cygwin-api.in.sgml ./doctool Makefile
 	-./doctool -m $(SGMLDIRS) -s $(srcdir) -o $@ $<
Index: README
===================================================================
RCS file: /cvs/src/src/winsup/doc/README,v
retrieving revision 1.2
diff -u -r1.2 README
--- README	2 Feb 2010 01:02:49 -0000	1.2
+++ README	25 Jun 2010 19:24:52 -0000
@@ -7,8 +7,7 @@
 bzip2
 coreutils
 cygwin
-docbook-utils
-docbook-xml42
+docbook-xml45
 docbook-xsl
 gzip
 make
Index: faq-programming.xml
===================================================================
RCS file: /cvs/src/src/winsup/doc/faq-programming.xml,v
retrieving revision 1.15
diff -u -r1.15 faq-programming.xml
--- faq-programming.xml	2 Feb 2010 01:18:03 -0000	1.15
+++ faq-programming.xml	25 Jun 2010 19:24:53 -0000
@@ -420,7 +420,7 @@
 <literal>perl</literal>, and <literal>cocom</literal>. If you want to run 
 the tests, <literal>dejagnu</literal> is also required.
 Normally, building ignores any errors in building the documentation,
-which requires the <literal>docbook-utils</literal>, <literal>docbook-xml42</literal>, <literal>docbook-xsl</literal>, and
+which requires the <literal>docbook-xml45</literal>, <literal>docbook-xsl</literal>, and
 <literal>xmlto</literal> packages.  For more information on building the
 documentation, see the README included in the <literal>cygwin-doc</literal> package.
 </para>

--=-nzBxgq4M0H2qCL6JgGbE--
