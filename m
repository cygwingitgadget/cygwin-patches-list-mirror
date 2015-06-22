Return-Path: <cygwin-patches-return-8214-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 50379 invoked by alias); 22 Jun 2015 17:47:24 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 50366 invoked by uid 89); 22 Jun 2015 17:47:24 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=0.5 required=5.0 tests=AWL,BAYES_50,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=no version=3.3.2
X-HELO: rgout01.bt.lon5.cpcloud.co.uk
Received: from rgout01.bt.lon5.cpcloud.co.uk (HELO rgout01.bt.lon5.cpcloud.co.uk) (65.20.0.178) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 22 Jun 2015 17:47:22 +0000
X-OWM-Source-IP: 86.141.128.210(GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-CTCH-RefID: str=0001.0A090202.55884A26.0075,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-Junkmail-Premium-Raw: score=27/50,refid=2.7.2:2015.6.18.70615:17:27.888,ip=86.141.128.210,rules=__HAS_FROM, __TO_MALFORMED_2, __TO_NO_NAME, __SUBJ_ALPHA_END, __HAS_MSGID, __SANE_MSGID, __HAS_X_MAILER, __IN_REP_TO, __REFERENCES, __ANY_URI, URI_ENDS_IN_HTML, INFO_TLD, __MAL_TELEKOM_URI, __CP_URI_IN_BODY, __C230066_P5, BODY_SIZE_10000_PLUS, __MIME_TEXT_ONLY, RDNS_GENERIC_POOLED, __URI_NS, __URI_NS_NXDOMAIN, SXL_IP_DYNAMIC[210.128.141.86.fur], HTML_00_01, HTML_00_10, RDNS_SUSP_GENERIC, RDNS_SUSP, REFERENCES, NO_URI_HTTPS
X-CTCH-Spam: Unknown
Received: from localhost.localdomain (86.141.128.210) by rgout01.bt.lon5.cpcloud.co.uk (8.6.122.06) (authenticated as jonturney@btinternet.com)        id 55827E2F00A83786; Mon, 22 Jun 2015 18:47:18 +0100
From: Jon TURNEY <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon TURNEY <jon.turney@dronecode.org.uk>
Subject: [PATCH 2/5] winsup/doc: Add intro man pages from cygwin-doc
Date: Mon, 22 Jun 2015 17:47:00 -0000
Message-Id: <1434995222-7256-1-git-send-email-jon.turney@dronecode.org.uk>
In-Reply-To: <55884387.90405@dronecode.org.uk>
References: <55884387.90405@dronecode.org.uk>
X-SW-Source: 2015-q2/txt/msg00115.txt.bz2

v2:
intro.1 and cygwin.1 are identical. Make cygwin.1 a link to intro.1
Update dates in static man pages

v3:
Use doclifter to convert intro.[13] to DocBook XML
Clean up markup and fix a couple of spelling mistakes.
Build and install manpages from XML

v4:
Update to refer to GPLv3+, SUSv4

2015-06-22  Jon Turney  <jon.turney@dronecode.org.uk>

	* Makefile.in (intro2man.stamp): Add.
	* intro.xml: New file.

Signed-off-by: Jon TURNEY <jon.turney@dronecode.org.uk>
---
 winsup/doc/ChangeLog   |   5 ++
 winsup/doc/Makefile.in |   8 +-
 winsup/doc/intro.xml   | 198 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 210 insertions(+), 1 deletion(-)
 create mode 100644 winsup/doc/intro.xml

diff --git a/winsup/doc/ChangeLog b/winsup/doc/ChangeLog
index 0a23870..1c944ad 100644
--- a/winsup/doc/ChangeLog
+++ b/winsup/doc/ChangeLog
@@ -1,5 +1,10 @@
 2015-06-22  Jon Turney  <jon.turney@dronecode.org.uk>
 
+	* Makefile.in (intro2man.stamp): Add.
+	* intro.xml: New file.
+
+2015-06-22  Jon Turney  <jon.turney@dronecode.org.uk>
+
 	* Makefile.in (install-info, cygwin-ug-net.info)
 	(cygwin-api.info): Add.
 	* cygwin-ug-net.xml: Add texinfo-node.
diff --git a/winsup/doc/Makefile.in b/winsup/doc/Makefile.in
index 9f6774b..e215580 100644
--- a/winsup/doc/Makefile.in
+++ b/winsup/doc/Makefile.in
@@ -54,6 +54,7 @@ all: Makefile Makefile.dep \
 	cygwin-api/cygwin-api.pdf \
 	utils2man.stamp \
 	api2man.stamp \
+	intro2man.stamp \
 	cygwin-ug-net.info cygwin-api.info
 
 Makefile: $(srcdir)/Makefile.in
@@ -83,7 +84,7 @@ install-html: cygwin-ug-net/cygwin-ug-net.html cygwin-api/cygwin-api.html
 	$(INSTALL_DATA) cygwin-api/*.html $(DESTDIR)$(htmldir)/cygwin-api
 	$(INSTALL_DATA) cygwin-api/cygwin-api.html $(DESTDIR)$(htmldir)/cygwin-api/index.html
 
-install-man: utils2man.stamp api2man.stamp
+install-man: utils2man.stamp api2man.stamp intro2man.stamp
 	@$(MKDIRP) $(DESTDIR)$(man1dir)
 	$(INSTALL_DATA) *.1 $(DESTDIR)$(man1dir)
 	@$(MKDIRP) $(DESTDIR)$(man3dir)
@@ -131,6 +132,11 @@ charmap:
 	cp /usr/share/docbook2X/charmaps/texi.charmap charmap
 	echo "ae (R)" >>charmap
 
+intro2man.stamp: intro.xml man.xsl
+	-$(XMLTO) man -m ${srcdir}/man.xsl $<
+	@echo ".so intro.1" >cygwin.1
+	@touch $@
+
 faq/faq.html : $(FAQ_SOURCES)
 	-$(XMLTO) html -o faq -m $(srcdir)/html.xsl $(srcdir)/faq.xml
 	-sed -i 's;<a name="id[mp][0-9]*"></a>;;g' faq/faq.html
diff --git a/winsup/doc/intro.xml b/winsup/doc/intro.xml
new file mode 100644
index 0000000..e76d9de
--- /dev/null
+++ b/winsup/doc/intro.xml
@@ -0,0 +1,198 @@
+<?xml version="1.0" encoding="UTF-8"?>
+<!DOCTYPE reference PUBLIC "-//OASIS//DTD DocBook V4.5//EN" "http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd">
+
+<reference id="intro" xmlns:xi="http://www.w3.org/2001/XInclude">
+  <referenceinfo>
+    <xi:include href="legal.xml"/>
+  </referenceinfo>
+  <title>Cygwin</title>
+  <refentry id="intro1">
+    <refmeta>
+      <refentrytitle>intro</refentrytitle>
+      <manvolnum>1</manvolnum>
+      <refmiscinfo class="manual">Cygwin</refmiscinfo>
+    </refmeta>
+    <refnamediv>
+      <refname>intro</refname>
+      <refpurpose>Introduction to the Cygwin Environment</refpurpose>
+    </refnamediv>
+    <refsect1>
+      <title>DESCRIPTION</title>
+      <para><emphasis>Cygwin</emphasis> is a Linux-like environment for
+      Windows. It consists of two parts:</para>
+      <para>A DLL (<filename>cygwin1.dll</filename>) which acts as a POSIX API
+      emulation layer providing substantial POSIX API functionality, modelled
+      after the GNU/Linux operating system. The
+      <citerefentry><refentrytitle>intro</refentrytitle><manvolnum>3</manvolnum></citerefentry>
+      man page gives an introduction to this API.</para>
+      <para>A collection of tools which provide Linux look and feel.  This man
+      page describes the user environment.</para>
+    </refsect1>
+    <refsect1>
+      <title>AVAILABILITY</title>
+      <para><emphasis>Cygwin</emphasis> is developed by volunteers collaborating
+      over the Internet. It is distributed through the website <ulink
+      url="http://cygwin.com">http://cygwin.com</ulink>, where you can find
+      extensive documentation, including FAQ, User's Guide, and API
+      Reference. The <emphasis>Cygwin</emphasis> website should be considered
+      the authoritative source of information. The source code, released under
+      the <emphasis>GNU General Public License, Version 3 (GPLv3+)</emphasis>,
+      is also available from the website or one of the mirrors.</para>
+    </refsect1>
+    <refsect1>
+      <title>COMPATIBILITY</title>
+      <para><emphasis>Cygwin</emphasis> uses the GNU versions of many of the
+      standard UNIX command-line utilities (<command>sed</command>,
+      <command>awk</command>, etc.), so the user environment is more similar to
+      a Linux system than, for example, Sun Solaris.</para>
+      <para>The default login shell and <command>/bin/sh</command> for
+      <emphasis>Cygwin</emphasis> is <command>bash</command>, the GNU
+      "Bourne-Again Shell", but other shells such as <command>tcsh</command>
+      (an improved <command>csh</command>) are also available and can be
+      installed using <emphasis>Cygwin</emphasis>'s setup.</para>
+    </refsect1>
+    <refsect1>
+      <title>NOTES</title>
+      <para>To port applications you will need to install the development tools,
+      which you can do by selecting <package>gcc</package> in
+      <emphasis>setup.exe</emphasis> (dependencies are automatically handled).
+      If you need a specific program or library, you can search for a
+      <emphasis>Cygwin</emphasis> package containing it at:</para>
+      <para>
+	<ulink url="http://cygwin.com/packages/">http://cygwin.com/packages/</ulink>
+      </para>
+      <para>If you are a UNIX veteran who plans to use
+      <emphasis>Cygwin</emphasis> extensively, you will probably find it worth
+      your while to learn to use <emphasis>Cygwin</emphasis>-specific tools that
+      provide a UNIX-like interface to common operations. For example,
+      <command>cygpath</command> converts between UNIX and Win32-style
+      pathnames. The full documentation for these utilities is at:</para>
+      <para>
+	<ulink url="http://cygwin.com/cygwin-ug-net/using-utils.html">http://cygwin.com/cygwin-ug-net/using-utils.html</ulink>
+      </para>
+      <para>The optional <package>cygutils</package> package also contains
+      utilities that help with common problems, such as
+      <command>dos2unix</command> and <command>unix2dos</command> for the
+      CRLF issue.</para>
+    </refsect1>
+    <refsect1>
+      <title>DOCUMENTATION</title>
+      <para>In addition to man pages and texinfo documentation, many
+      <emphasis>Cygwin</emphasis> packages provide system-independent
+      documentation in the <filename>/usr/share/doc/</filename> directory and
+      <emphasis>Cygwin</emphasis>-specific documentation in
+      <filename>/usr/share/doc/Cygwin/</filename></para>
+      <para>For example, if you have both <command>less</command> and
+      <command>cron</command> installed, the command <command>less
+      /usr/share/doc/Cygwin/cron.README</command> would display the instructions
+      to set up <command>cron</command> on your system.</para>
+    </refsect1>
+    <refsect1>
+      <title>REPORTING BUGS</title>
+      <para>If you find a bug in <emphasis>Cygwin</emphasis>, please read</para>
+      <para>
+	<ulink url="http://cygwin.com/bugs.html">http://cygwin.com/bugs.html</ulink>
+      </para>
+      <para>and follow the instructions for reporting found there.  If you are
+      able to track down the source of the bug and can provide a fix, there are
+      instructions for contributing patches at:</para>
+      <para>
+	<ulink url="http://cygwin.com/contrib.html">http://cygwin.com/contrib.html</ulink>
+      </para>
+    </refsect1>
+    <refsect1>
+      <title>SEE ALSO</title>
+      <para>
+	<citerefentry>
+	  <refentrytitle>intro</refentrytitle>
+	  <manvolnum>3</manvolnum>
+	</citerefentry>
+      </para>
+    </refsect1>
+  </refentry>
+
+  <refentry id="intro3">
+    <refmeta>
+      <refentrytitle>intro</refentrytitle>
+      <manvolnum>3</manvolnum>
+      <refmiscinfo class="manual">Cygwin</refmiscinfo>
+    </refmeta>
+    <refnamediv>
+      <refname>intro</refname>
+      <refpurpose>Introduction to the Cygwin API</refpurpose>
+    </refnamediv>
+    <refsect1>
+      <title>DESCRIPTION</title>
+      <para><emphasis>Cygwin</emphasis> is a Linux-like environment for
+      Windows. It consists of two parts:</para>
+      <para>A DLL (<filename>cygwin1.dll</filename>) which acts as a POSIX API
+      emulation layer providing substantial POSIX API functionality, modelled
+      after the GNU/Linux operating system. This page describes the API provided
+      by the DLL.
+      </para>
+      <para>A collection of tools which provide Linux look and feel.  This
+      environment is described in the
+      <citerefentry><refentrytitle>intro</refentrytitle><manvolnum>1</manvolnum></citerefentry>
+      man page.</para>
+    </refsect1>
+    <refsect1>
+      <title>AVAILABILITY</title>
+      <para><emphasis>Cygwin</emphasis> is developed by volunteers collaborating
+      over the Internet. It is distributed through the website <ulink
+      url="http://cygwin.com">http://cygwin.com</ulink>. The website has
+      extensive documentation, including FAQ, User's Guide, and API
+      Reference. It should be considered the authoritative source of
+      information. The source code, released under the <emphasis>GNU General
+      Public License, Version 3 (GPLv3+)</emphasis>, is also available from the
+      website or one of the mirrors.</para>
+    </refsect1>
+    <refsect1>
+      <title>COMPATIBILITY</title>
+      <para><emphasis>Cygwin</emphasis> policy is to attempt to adhere to
+      <emphasis>POSIX.1-2008/SUSv4</emphasis> (Portable Operating System
+      Interface for UNIX / The Single UNIX Specification, Version 4) where
+      possible.</para>
+      <para><emphasis>SUSv4</emphasis> is available online at:</para>
+      <para>
+	<ulink url="http://pubs.opengroup.org/onlinepubs/9699919799/">http://pubs.opengroup.org/onlinepubs/9699919799/</ulink>
+      </para>
+      <para>For compatibility information about specific functions, see the API
+      Reference at:</para>
+      <para>
+	<ulink url="http://cygwin.com/cygwin-api/cygwin-api.html">http://cygwin.com/cygwin-api/cygwin-api.html</ulink>
+      </para>
+      <para>Where these standards are ambiguous, Cygwin tries to mimic
+      <emphasis>Linux</emphasis>.  However, <emphasis>Cygwin</emphasis> uses
+      <emphasis>newlib</emphasis> instead of <emphasis>glibc</emphasis> as its C
+      Library, available at:</para>
+      <para>
+	<ulink url="http://sources.redhat.com/newlib/">http://sources.redhat.com/newlib/</ulink>
+      </para>
+      <para>Keep in mind that there are many underlying differences between UNIX
+      and Win32 making complete compatibility an ongoing challenge.</para>
+    </refsect1>
+    <refsect1>
+      <title>REPORTING BUGS</title>
+      <para>If you find a bug in <emphasis>Cygwin</emphasis>, please read</para>
+      <para>
+	<ulink url="http://cygwin.com/bugs.html">http://cygwin.com/bugs.html</ulink>
+      </para>
+      <para>and follow the instructions for reporting found there.  If you are
+      able to track down the source of the bug and can provide a fix, there are
+      instructions for contributing patches at:</para>
+      <para>
+	<ulink url="http://cygwin.com/contrib.html">http://cygwin.com/contrib.html</ulink>
+      </para>
+    </refsect1>
+    <refsect1>
+      <title>SEE ALSO</title>
+      <para>
+	<citerefentry>
+	  <refentrytitle>intro</refentrytitle>
+	  <manvolnum>1</manvolnum>
+	</citerefentry>
+      </para>
+    </refsect1>
+  </refentry>
+
+</reference>
-- 
2.1.4
