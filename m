Return-Path: <cygwin-patches-return-7036-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27893 invoked by alias); 25 Jun 2010 19:38:29 -0000
Received: (qmail 27878 invoked by uid 22791); 25 Jun 2010 19:38:28 -0000
X-SWARE-Spam-Status: No, hits=-50.9 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,T_TO_NO_BRKTS_FREEMAIL
X-Spam-Check-By: sourceware.org
Received: from mail-pz0-f43.google.com (HELO mail-pz0-f43.google.com) (209.85.210.43)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 25 Jun 2010 19:38:17 +0000
Received: by pzk32 with SMTP id 32so2025536pzk.2        for <cygwin-patches@cygwin.com>; Fri, 25 Jun 2010 12:38:16 -0700 (PDT)
Received: by 10.142.74.1 with SMTP id w1mr1534081wfa.258.1277494696119;        Fri, 25 Jun 2010 12:38:16 -0700 (PDT)
Received: from [127.0.0.1] (S0106000cf16f58b1.wp.shawcable.net [24.76.240.202])        by mx.google.com with ESMTPS id h11sm842860rvm.8.2010.06.25.12.38.15        (version=SSLv3 cipher=RC4-MD5);        Fri, 25 Jun 2010 12:38:15 -0700 (PDT)
Subject: doc: use xmlto pdf
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
To: cygwin-patches@cygwin.com
Content-Type: multipart/mixed; boundary="=-YCjILA1KjmQYtuuRRjou"
Date: Fri, 25 Jun 2010 19:38:00 -0000
Message-ID: <1277494710.9108.37.camel@YAAKOV04>
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
X-SW-Source: 2010-q2/txt/msg00019.txt.bz2


--=-YCjILA1KjmQYtuuRRjou
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 939

As reported recently on the list[1], openjade cannot handle the ISO
encodings shipped with docbook-xml45.  While I need to look into a fix,
in this case there is a simple workaround.  Since we already use xmlto
to build the HTML, we can also use it to build the PDFs.

Note that this does require the appropriate backend to be installed.  On
Linux, xmlto has used PassiveTeX as a DVI/PDF/PS backend since at least
0.0.18; later versions also support dblatex and fop.  On Cygwin, I just
adopted xmlto[2] and updated it to use dblatex as the DVI/PDF/PS
backend, as that is the only backend currently in the distro.  (fop is
in Ports but requires its GNU Classpath environment plus a bunch of Java
libraries, and neither passivetex nor its dependency xmltex are
currently available.)

Patch attached; please test.


Yaakov

[1] http://cygwin.com/ml/cygwin/2010-06/msg00448.html
[2] http://cygwin.com/ml/cygwin-announce/2010-06/msg00041.html


--=-YCjILA1KjmQYtuuRRjou
Content-Disposition: attachment; filename="doc-xmlto-pdf.patch"
Content-Type: text/x-patch; name="doc-xmlto-pdf.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 2396

2010-06-25  Yaakov Selkowitz  <yselkowitz@users.sourceforge.net>

	* Makefile.in: Use "xmlto pdf" instead of docbook2pdf.
	* README: Remove docbook-utils and update docbook-xml deps.
	* faq-programming.xml: Ditto.

Index: Makefile.in
===================================================================
RCS file: /cvs/src/src/winsup/doc/Makefile.in,v
retrieving revision 1.26
diff -u -r1.26 Makefile.in
--- Makefile.in	26 Jan 2010 16:16:19 -0000	1.26
+++ Makefile.in	25 Jun 2010 19:24:52 -0000
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

--=-YCjILA1KjmQYtuuRRjou--
