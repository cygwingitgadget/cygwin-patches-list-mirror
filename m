Return-Path: <cygwin-patches-return-8160-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 115298 invoked by alias); 15 Jun 2015 12:37:36 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 115285 invoked by uid 89); 15 Jun 2015 12:37:35 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=0.4 required=5.0 tests=AWL,BAYES_50,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=no version=3.3.2
X-HELO: rgout06.bt.lon5.cpcloud.co.uk
Received: from rgout06.bt.lon5.cpcloud.co.uk (HELO rgout06.bt.lon5.cpcloud.co.uk) (65.20.0.183) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 15 Jun 2015 12:37:10 +0000
X-OWM-Source-IP: 86.141.128.210(GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-CTCH-RefID: str=0001.0A090201.557EC6F3.0084,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-Junkmail-Premium-Raw: score=27/50,refid=2.7.2:2015.6.15.101816:17:27.888,ip=86.141.128.210,rules=__HAS_FROM, __TO_MALFORMED_2, __TO_NO_NAME, __SUBJ_ALPHA_END, __HAS_MSGID, __SANE_MSGID, __HAS_X_MAILER, __IN_REP_TO, __REFERENCES, __ANY_URI, __URI_NO_WWW, __URI_NO_PATH, __FRAUD_CONTACT_NAME, __SUBJ_ALPHA_NEGATE, BODY_SIZE_10000_PLUS, __MIME_TEXT_ONLY, RDNS_GENERIC_POOLED, __URI_NS, SXL_IP_DYNAMIC[210.128.141.86.fur], HTML_00_01, HTML_00_10, RDNS_SUSP_GENERIC, RDNS_SUSP, REFERENCES
X-CTCH-Spam: Unknown
Received: from localhost.localdomain (86.141.128.210) by rgout06.bt.lon5.cpcloud.co.uk (8.6.122.06) (authenticated as jonturney@btinternet.com)        id 557EACF60005043F; Mon, 15 Jun 2015 13:37:07 +0100
From: Jon TURNEY <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon TURNEY <jon.turney@dronecode.org.uk>
Subject: [PATCH 5/8] winsup/doc: Convert utils.xml to using refentry
Date: Mon, 15 Jun 2015 12:37:00 -0000
Message-Id: <1434371793-3980-6-git-send-email-jon.turney@dronecode.org.uk>
In-Reply-To: <1434371793-3980-1-git-send-email-jon.turney@dronecode.org.uk>
References: <1434371793-3980-1-git-send-email-jon.turney@dronecode.org.uk>
X-SW-Source: 2015-q2/txt/msg00061.txt.bz2

Convert utils.xml from using a sect2 to using a refentry for each utility
program.

Unfortunately, using refentry seems to tickle a bug in dblatex when generating
pdf, which appears to not escape \ properly in the latex for refentry, so use
fop instead.

Note that the chunked html now generates a page for each utility, rather than
one containing all utilities.

A small customization to TOC generation for HTML and PDF is needed to ensure
that it appears as before, containing an entry for each utility command.

Future work: synopsis and options sections could use more detailed markup than
just wrapping the whole thing in <screen>

2015-06-12  Jon Turney  <jon.turney@dronecode.org.uk>

	* Makefile.in (XMLTO): Switch from dblatex to fop.
	* utils.xml : Convert from using a sect2 to using a refentry for
	each utility program.
	* cygwin.xsl: Customize autotoc to include refentries.
	* fo.xsl: Ditto.

Signed-off-by: Jon TURNEY <jon.turney@dronecode.org.uk>
---
 winsup/doc/ChangeLog   |   8 +
 winsup/doc/Makefile.in |   2 +-
 winsup/doc/cygwin.xsl  |  13 +
 winsup/doc/fo.xsl      |  36 +++
 winsup/doc/utils.xml   | 778 ++++++++++++++++++++++++++++++++++++-------------
 5 files changed, 627 insertions(+), 210 deletions(-)

diff --git a/winsup/doc/ChangeLog b/winsup/doc/ChangeLog
index a73326a..7b15a5d 100644
--- a/winsup/doc/ChangeLog
+++ b/winsup/doc/ChangeLog
@@ -1,5 +1,13 @@
 2015-06-12  Jon Turney  <jon.turney@dronecode.org.uk>
 
+	* Makefile.in (XMLTO): Switch from dblatex to fop.
+	* utils.xml : Convert from using a sect2 to using a refentry for
+	each utility program.
+	* cygwin.xsl: Customize autotoc to include refentries.
+	* fo.xsl: Ditto.
+
+2015-06-12  Jon Turney  <jon.turney@dronecode.org.uk>
+
 	* Makefile.in (cygwin-ug-net/cygwin-ug-net.pdf)
 	(cygwin-api/cygwin-api.pdf): Use fo.xsl to customized DocBook
 	XML->PDF conversion.
diff --git a/winsup/doc/Makefile.in b/winsup/doc/Makefile.in
index 2d71728..bcc32e4 100644
--- a/winsup/doc/Makefile.in
+++ b/winsup/doc/Makefile.in
@@ -25,7 +25,7 @@ MKDIRP:=$(INSTALL) -m 755 -d
 CC:=@CC@
 CC_FOR_TARGET:=@CC@
 
-XMLTO:=xmlto --skip-validation --with-dblatex
+XMLTO:=xmlto --skip-validation --with-fop
 
 include $(srcdir)/../Makefile.common
 
diff --git a/winsup/doc/cygwin.xsl b/winsup/doc/cygwin.xsl
index 99ec5d0..df12555 100644
--- a/winsup/doc/cygwin.xsl
+++ b/winsup/doc/cygwin.xsl
@@ -10,4 +10,17 @@
 <xsl:param name="root.filename" select="@id" />
 <xsl:param name="toc.section.depth" select="4" />
 
+<!-- autotoc.xsl customization to make refentry in sect1 appear in toc -->
+<xsl:template match="sect1" mode="toc">
+  <xsl:param name="toc-context" select="."/>
+  <xsl:call-template name="subtoc">
+    <xsl:with-param name="toc-context" select="$toc-context"/>
+    <xsl:with-param name="nodes" select="sect2|refentry
+                                         |bridgehead[$bridgehead.in.toc != 0]"/>
+  </xsl:call-template>
+</xsl:template>
+
+<!-- suppress refentry in toc being annotated with refpurpose -->
+<xsl:param name="annotate.toc" select="0" />
+
 </xsl:stylesheet>
diff --git a/winsup/doc/fo.xsl b/winsup/doc/fo.xsl
index 4bc255c..ba8e191 100644
--- a/winsup/doc/fo.xsl
+++ b/winsup/doc/fo.xsl
@@ -29,4 +29,40 @@
 	<!-- Inform the DocBook stylesheets that it's safe to use FOP
 	     specific extensions. -->
 	<xsl:param name="fop1.extensions" select="1"/>
+
+	<!-- autotoc.xsl customization to make refentry in sect1 appear in toc -->
+<xsl:template match="sect1" mode="toc">
+  <xsl:param name="toc-context" select="."/>
+
+  <xsl:variable name="id">
+    <xsl:call-template name="object.id"/>
+  </xsl:variable>
+
+  <xsl:variable name="cid">
+    <xsl:call-template name="object.id">
+      <xsl:with-param name="object" select="$toc-context"/>
+    </xsl:call-template>
+  </xsl:variable>
+
+  <xsl:call-template name="toc.line">
+    <xsl:with-param name="toc-context" select="$toc-context"/>
+  </xsl:call-template>
+
+  <xsl:variable name="depth.from.context" select="count(ancestor::*)-count($toc-context/ancestor::*)"/>
+
+  <xsl:if test="$toc.section.depth > 1
+                and $toc.max.depth > $depth.from.context">
+    <fo:block id="toc.{$cid}.{$id}">
+      <xsl:attribute name="margin-{$direction.align.start}">
+        <xsl:call-template name="set.toc.indent"/>
+      </xsl:attribute>
+
+      <xsl:apply-templates select="refentry|sect2|qandaset[$qanda.in.toc != 0]"
+                           mode="toc">
+        <xsl:with-param name="toc-context" select="$toc-context"/>
+      </xsl:apply-templates>
+    </fo:block>
+  </xsl:if>
+</xsl:template>
+
 </xsl:stylesheet>
diff --git a/winsup/doc/utils.xml b/winsup/doc/utils.xml
index fcecd11..a3d7da8 100644
--- a/winsup/doc/utils.xml
+++ b/winsup/doc/utils.xml
@@ -13,10 +13,20 @@
     identically. All of the Cygwin command-line utilities support the
     <literal>--help</literal> and <literal>--version</literal> options. </para>
 
-  <sect2 id="cygcheck">
-    <title>cygcheck</title>
-
-    <screen>
+    <refentry id="cygcheck">
+      <refmeta>
+	<refentrytitle>cygcheck</refentrytitle>
+	<manvolnum>1</manvolnum>
+	<refmiscinfo class="manual">Cygwin Utilities</refmiscinfo>
+      </refmeta>
+
+      <refnamediv>
+	<refname>cygcheck</refname>
+	<refpurpose>List system information, check installed packages, or query package database</refpurpose>
+      </refnamediv>
+
+      <refsynopsisdiv>
+	<screen>
 Usage: cygcheck [-v] [-h] PROGRAM
        cygcheck -c [-d] [PACKAGE]
        cygcheck -s [-r] [-v] [-h]
@@ -29,9 +39,12 @@ Usage: cygcheck [-v] [-h] PROGRAM
        cygcheck --disable-unique-object-names Cygwin-DLL
        cygcheck --show-unique-object-names Cygwin-DLL
        cygcheck -h
+	</screen>
+      </refsynopsisdiv>
 
-List system information, check installed packages, or query package database.
-
+      <refsect1>
+	<title>Options</title>
+	<screen>
 At least one command option or a PROGRAM is required, as shown above.
 
   PROGRAM              list library (DLL) dependencies of PROGRAM
@@ -68,7 +81,10 @@ Note: -c, -f, and -l only report on packages that are currently installed. To
   search all official Cygwin packages use -p instead.  The -p REGEXP matches
   package names, descriptions, and names of files/paths within all packages.
 </screen>
+      </refsect1>
 
+<refsect1>
+  <title>Description</title>
     <para> The <command>cygcheck</command> program is a diagnostic utility for
       dealing with Cygwin programs. If you are familiar with
       <command>dpkg</command> or <command>rpm</command>,
@@ -257,20 +273,34 @@ are unable to find another Cygwin DLL.
       and <literal>--enable-...</literal> options, the
       <literal>--show-unique-object-names</literal> option also works for
       Cygwin DLLs which are currently in use.</para>
+  </refsect1>
 
-  </sect2>
+  </refentry>
 
-  <sect2 id="cygpath">
-    <title>cygpath</title>
+  <refentry id="cygpath">
+    <refmeta>
+      <refentrytitle>cygpath</refentrytitle>
+      <manvolnum>1</manvolnum>
+      <refmiscinfo class="manual">Cygwin Utilities</refmiscinfo>
+    </refmeta>
 
+    <refnamediv>
+      <refname>cygpath</refname>
+      <refpurpose>Convert Unix and Windows format paths, or output system path information</refpurpose>
+    </refnamediv>
+
+    <refsynopsisdiv>
     <screen>
 Usage: cygpath (-d|-m|-u|-w|-t TYPE) [-f FILE] [OPTION]... NAME...
        cygpath [-c HANDLE]
        cygpath [-ADHOPSW]
        cygpath [-F ID]
+    </screen>
+    </refsynopsisdiv>
 
-Convert Unix and Windows format paths, or output system path information
-
+    <refsect1>
+      <title>Options</title>
+    <screen>
 Output type options:
 
   -d, --dos             print DOS (short) form of NAMEs (C:\PROGRA~1\)
@@ -312,7 +342,10 @@ Other options:
   -h, --help            output usage information and exit
   -V, --version         output version information and exit
 </screen>
+    </refsect1>
 
+    <refsect1>
+      <title>Description</title>
     <para>The <command>cygpath</command> program is a utility that converts
       Windows native filenames to Cygwin POSIX-style pathnames and vice versa.
       It can be used when a Cygwin program needs to pass a file name to a
@@ -417,23 +450,39 @@ explorer $XPATH &
       (CDBurn area). By default the output is in UNIX (POSIX) format; use the
       <literal>-w</literal> or <literal>-d</literal> options to get other
       formats.</para>
-
-  </sect2>
-
-  <sect2 id="dumper">
-    <title>dumper</title>
-
-    <screen>
+    </refsect1>
+  </refentry>
+
+  <refentry id="dumper">
+    <refmeta>
+      <refentrytitle>dumper</refentrytitle>
+      <manvolnum>1</manvolnum>
+      <refmiscinfo class="manual">Cygwin Utilities</refmiscinfo>
+    </refmeta>
+
+    <refnamediv>
+      <refname>dumper</refname>
+      <refpurpose>Dump core from WIN32PID to FILENAME.core</refpurpose>
+    </refnamediv>
+
+    <refsynopsisdiv>
+      <screen>
 Usage: dumper [OPTION] FILENAME WIN32PID
+      </screen>
+    </refsynopsisdiv>
 
-Dump core from WIN32PID to FILENAME.core
-
+    <refsect1>
+      <title>Options</title>
+      <screen>
 -d, --verbose  be verbose while dumping
 -h, --help     output help information and exit
 -q, --quiet    be quiet while dumping (default)
 -V, --version  output version information and exit
 </screen>
+    </refsect1>
 
+    <refsect1>
+      <title>Description</title>
     <para>The <command>dumper</command> utility can be used to create a core
       dump of running Windows process. This core dump can be later loaded to
       <command>gdb</command> and analyzed. One common way to use
@@ -461,18 +510,31 @@ error_start=x:\path\to\dumper.exe
       dump on one machine and try to debug it on another, you'll need to place
       identical copies of the executable and dlls in the same directories as on
       the machine where the core dump was created. </para>
-
-  </sect2>
-
-  <sect2 id="getconf">
-    <title>getconf</title>
-
-    <screen>
+    </refsect1>
+  </refentry>
+
+  <refentry id="getconf">
+    <refmeta>
+      <refentrytitle>getconf</refentrytitle>
+      <manvolnum>1</manvolnum>
+      <refmiscinfo class="manual">Cygwin Utilities</refmiscinfo>
+    </refmeta>
+
+    <refnamediv>
+      <refname>getconf</refname>
+      <refpurpose>Get configuration values</refpurpose>
+    </refnamediv>
+
+    <refsynopsisdiv>
+      <screen>
 Usage: getconf [-v specification] variable_name [pathname]
        getconf -a [pathname]
+      </screen>
+    </refsynopsisdiv>
 
-Get configuration values
-
+    <refsect1>
+      <title>Options</title>
+      <screen>
   -v specification     Indicate specific version for which configuration
                        values shall be fetched.
   -a, --all            Print all known configuration values
@@ -482,7 +544,10 @@ Other options:
   -h, --help           This text
   -V, --version        Print program version and exit
 </screen>
+    </refsect1>
 
+    <refsect1>
+      <title>Description</title>
     <para>The <command>getconf</command> utility prints the value of the
       configuration variable specified by <literal>variable_name</literal>. If
       no <literal>pathname</literal> is given, <command>getconf</command>
@@ -509,17 +574,30 @@ Other options:
     <para>Use the <literal>-a</literal> option to print a list of all available
       configuration variables for the system, or given
       <literal>pathname</literal>, and their values.</para>
-
-  </sect2>
-
-  <sect2 id="getfacl">
-    <title>getfacl</title>
-
-    <screen>
+    </refsect1>
+  </refentry>
+
+  <refentry id="getfacl">
+    <refmeta>
+      <refentrytitle>getfacl</refentrytitle>
+      <manvolnum>1</manvolnum>
+      <refmiscinfo class="manual">Cygwin Utilities</refmiscinfo>
+    </refmeta>
+
+    <refnamediv>
+      <refname>getfacl</refname>
+      <refpurpose>Display file and directory access control lists (ACLs)</refpurpose>
+    </refnamediv>
+
+    <refsynopsisdiv>
+      <screen>
 Usage: getfacl [-adn] FILE [FILE2...]
+      </screen>
+    </refsynopsisdiv>
 
-Display file and directory access control lists (ACLs).
-
+    <refsect1>
+      <title>Options</title>
+      <screen>
   -a, --access   display the file access control list
   -d, --default  display the default access control list
   -h, --help     print help explaining the command line options
@@ -529,7 +607,10 @@ Display file and directory access control lists (ACLs).
 When multiple files are specified on the command line, a blank
 line separates the ACLs for each file.
 </screen>
+    </refsect1>
 
+    <refsect1>
+      <title>Description</title>
     <para> For each argument that is a regular file, special file or directory,
       <command>getfacl</command> displays the owner, the group, and the ACL.
       For directories <command>getfacl</command> displays additionally the
@@ -558,24 +639,41 @@ line separates the ACLs for each file.
      default:other:perm
 </screen>
     </para>
-  </sect2>
-
-  <sect2 id="kill">
-    <title>kill</title>
-
-    <screen>
+    </refsect1>
+  </refentry>
+
+  <refentry id="kill">
+    <refmeta>
+      <refentrytitle>kill</refentrytitle>
+      <manvolnum>1</manvolnum>
+      <refmiscinfo class="manual">Cygwin Utilities</refmiscinfo>
+    </refmeta>
+
+    <refnamediv>
+      <refname>kill</refname>
+      <refpurpose>Send signals to processes</refpurpose>
+    </refnamediv>
+
+    <refsynopsisdiv>
+      <screen>
 Usage: kill [-f] [-signal] [-s signal] pid1 [pid2 ...]
        kill -l [signal]
+      </screen>
+    </refsynopsisdiv>
 
-Send signals to processes
-
+    <refsect1>
+      <title>Options</title>
+      <screen>
  -f, --force     force, using win32 interface if necessary
  -l, --list      print a list of signal names
  -s, --signal    send signal (use kill --list for a list)
  -h, --help      output usage information and exit
  -V, --version   output version information and exit
 </screen>
+    </refsect1>
 
+    <refsect1>
+      <title>Description</title>
     <para>The <command>kill</command> program allows you to send arbitrary
       signals to other Cygwin programs. The usual purpose is to end a running
       program from some other window when ^C won't work, but you can also send
@@ -658,17 +756,30 @@ SIGPWR      29    power failure
 SIGUSR1     30    user defined signal 1
 SIGUSR2     31    user defined signal 2
 </screen>
-
-  </sect2>
-
-  <sect2 id="ldd">
-    <title>ldd</title>
-
-    <screen>
+    </refsect1>
+  </refentry>
+
+  <refentry id="ldd">
+    <refmeta>
+      <refentrytitle>ldd</refentrytitle>
+      <manvolnum>1</manvolnum>
+      <refmiscinfo class="manual">Cygwin Utilities</refmiscinfo>
+    </refmeta>
+
+    <refnamediv>
+      <refname>ldd</refname>
+      <refpurpose>Print shared library dependencies</refpurpose>
+    </refnamediv>
+
+    <refsynopsisdiv>
+      <screen>
 Usage: ldd [OPTION]... FILE...
+      </screen>
+    </refsynopsisdiv>
 
-Print shared library dependencies
-
+    <refsect1>
+      <title>Options</title>
+      <screen>
   -h, --help              print this help and exit
   -V, --version           print version information and exit
   -r, --function-relocs   process data and function relocations
@@ -678,23 +789,39 @@ Print shared library dependencies
   -v, --verbose           print all information
                           (currently unimplemented)
 </screen>
+    </refsect1>
 
+    <refsect1>
+      <title>Description</title>
     <para><command>ldd</command> prints the shared libraries (DLLs) an
       executable or DLL is linked against. No modifying option is implemented
       yet.</para>
-
-  </sect2>
-
-  <sect2 id="locale">
-    <title>locale</title>
-
-    <screen>
+    </refsect1>
+  </refentry>
+
+  <refentry id="locale">
+    <refmeta>
+      <refentrytitle>locale</refentrytitle>
+      <manvolnum>1</manvolnum>
+      <refmiscinfo class="manual">Cygwin Utilities</refmiscinfo>
+    </refmeta>
+
+    <refnamediv>
+      <refname>locale</refname>
+      <refpurpose>Get locale-specific information</refpurpose>
+    </refnamediv>
+
+    <refsynopsisdiv>
+      <screen>
 Usage: locale [-amvhV]
    or: locale [-ck] NAME
    or: locale [-usfnU]
+      </screen>
+    </refsynopsisdiv>
 
-Get locale-specific information.
-
+    <refsect1>
+      <title>Options</title>
+      <screen>
 System information:
 
   -a, --all-locales    List all available supported locales
@@ -720,7 +847,10 @@ Other options:
   -h, --help           This text
   -V, --version        Print program version and exit
 </screen>
+    </refsect1>
 
+    <refsect1>
+      <title>Description</title>
     <para><command>locale</command> without parameters prints information about
       the current locale environment settings.</para>
 
@@ -830,17 +960,31 @@ nostr="no"
 messages-codeset="UTF-8"
 bash$ locale noexpr
 ^[nN]
-</screen>
-
-  </sect2>
-
-  <sect2 id="minidumper"><title>minidumper</title>
-
-  <screen>
+    </screen>
+    </refsect1>
+  </refentry>
+
+  <refentry id="minidumper">
+      <refmeta>
+      <refentrytitle>minidumper</refentrytitle>
+      <manvolnum>1</manvolnum>
+      <refmiscinfo class="manual">Cygwin Utilities</refmiscinfo>
+      </refmeta>
+
+    <refnamediv>
+      <refname>minidumper</refname>
+      <refpurpose>Write minidump from WIN32PID to FILENAME.dmp</refpurpose>
+    </refnamediv>
+
+    <refsynopsisdiv>
+      <screen>
 Usage: minidumper [OPTION] FILENAME WIN32PID
+      </screen>
+    </refsynopsisdiv>
 
-Write minidump from WIN32PID to FILENAME.dmp
-
+    <refsect1>
+      <title>Options</title>
+      <screen>
 -t, --type     minidump type flags
 -n, --nokill   don't terminate the dumped process
 -d, --verbose  be verbose while dumping
@@ -848,7 +992,10 @@ Write minidump from WIN32PID to FILENAME.dmp
 -q, --quiet    be quiet while dumping (default)
 -V, --version  output version information and exit
   </screen>
+    </refsect1>
 
+    <refsect1>
+      <title>Description</title>
   <para>
     The <command>minidumper</command> utility can be used to create a
     minidump of a running Windows process.  This minidump can be later
@@ -867,20 +1014,30 @@ Write minidump from WIN32PID to FILENAME.dmp
     <command>dumper</command> the target process is terminated after dumping
     unless the <literal>-n</literal> option is given.
   </para>
-
-  </sect2>
-
-  <sect2 id="mkgroup">
-    <title>mkgroup</title>
-
-    <screen>
+    </refsect1>
+  </refentry>
+
+  <refentry id="mkgroup">
+    <refmeta>
+      <refentrytitle>mkgroup</refentrytitle>
+      <manvolnum>1</manvolnum>
+      <refmiscinfo class="manual">Cygwin Utilities</refmiscinfo>
+    </refmeta>
+
+    <refnamediv>
+      <refname>mkgroup</refname>
+      <refpurpose>Write /etc/group-like output to stdout</refpurpose>
+    </refnamediv>
+
+    <refsynopsisdiv>
+      <screen>
 Usage: mkgroup [OPTION]...
+      </screen>
+    </refsynopsisdiv>
 
-Write /etc/group-like output to stdout
-
-Don't use this command to generate a local /etc/group file, unless you
-really need one.  See the Cygwin User's Guide for more information.
-
+    <refsect1>
+      <title>Options</title>
+      <screen>
 Options:
 
    -l,--local [machine]    Print local group accounts of \"machine\",
@@ -907,6 +1064,13 @@ Options:
 Default is to print local groups on stand-alone machines, plus domain
 groups on domain controllers and domain member machines.
 </screen>
+    </refsect1>
+
+    <refsect1>
+      <title>Description</title>
+     <para>Don't use this command to generate a local /etc/group file, unless you
+     really need one.  See the Cygwin User's Guide for more information.
+     </para>
 
     <para>The <command>mkgroup</command> program can be used to create a local
       <filename>/etc/group</filename> file.  Cygwin doesn't need this file,
@@ -954,21 +1118,31 @@ groups on domain controllers and domain member machines.
       samba-server</literal> or <literal>-L samba-server</literal>. The normal
       UNIX groups are usually not enumerated, but they can show up as a group
       in <command>ls -l</command> output. </para>
-
-  </sect2>
-
-  <sect2 id="mkpasswd">
-    <title>mkpasswd</title>
-
-    <screen>
+    </refsect1>
+  </refentry>
+
+  <refentry id="mkpasswd">
+    <refmeta>
+      <refentrytitle>mkpasswd</refentrytitle>
+      <manvolnum>1</manvolnum>
+      <refmiscinfo class="manual">Cygwin Utilities</refmiscinfo>
+    </refmeta>
+
+    <refnamediv>
+      <refname>mkpasswd</refname>
+      <refpurpose>Write /etc/passwd-like output to stdout</refpurpose>
+    </refnamediv>
+
+    <refsynopsisdiv>
+      <screen>
 Usage: mkpasswd [OPTIONS]...
+      </screen>
+    </refsynopsisdiv>
 
-Write /etc/passwd-like output to stdout
-
-Don't use this command to generate a local /etc/passwd file, unless you
-really need one.  See the Cygwin User's Guide for more information.
-
-Options:
+    <refsect1>
+      <title>Options</title>
+      <screen>
+    Options:
 
    -l,--local [machine]    Print local user accounts of \"machine\",
                            from local machine if no machine specified.
@@ -997,6 +1171,12 @@ Options:
 Default is to print local accounts on stand-alone machines, domain accounts
 on domain controllers and domain member machines.
 </screen>
+    </refsect1>
+
+    <refsect1>
+      <title>Description</title>
+    <para>Don't use this command to generate a local /etc/passwd file, unless you
+    really need one.  See the Cygwin User's Guide for more information.</para>
 
     <para>The <command>mkpasswd</command> program can be used to create a
       <filename>/etc/passwd</filename> file.  Cygwin doesn't need this file,
@@ -1044,19 +1224,32 @@ on domain controllers and domain member machines.
       samba-server</literal>. The normal UNIX users are usually not enumerated,
       but they can show up as file owners in <command>ls -l</command> output.
       </para>
-
-  </sect2>
-
-  <sect2 id="mount">
-    <title>mount</title>
-
-    <screen>
+    </refsect1>
+  </refentry>
+
+  <refentry id="mount">
+    <refmeta>
+      <refentrytitle>mount</refentrytitle>
+      <manvolnum>1</manvolnum>
+      <refmiscinfo class="manual">Cygwin Utilities</refmiscinfo>
+    </refmeta>
+
+    <refnamediv>
+      <refname>mount</refname>
+      <refpurpose>Display information about mounted filesystems, or mount a filesystem</refpurpose>
+    </refnamediv>
+
+    <refsynopsisdiv>
+      <screen>
 Usage: mount [OPTION] [&lt;win32path&gt; &lt;posixpath&gt;]
        mount -a
        mount &lt;posixpath&gt;
+      </screen>
+     </refsynopsisdiv>
 
-Display information about mounted filesystems, or mount a filesystem
-
+    <refsect1>
+      <title>Options</title>
+    <screen>
   -a, --all                     mount all filesystems mentioned in fstab
   -c, --change-cygdrive-prefix  change the cygdrive path prefix to &lt;posixpath&gt;
   -f, --force                   force mount, don't warn about missing mount
@@ -1068,7 +1261,10 @@ Display information about mounted filesystems, or mount a filesystem
   -p, --show-cygdrive-prefix    show user and/or system cygdrive path prefix
   -V, --version                 output version information and exit
 </screen>
+    </refsect1>
 
+    <refsect1>
+      <title>Description</title>
     <para>The <command>mount</command> program is used to map your drives and
       shares onto Cygwin's simulated POSIX directory tree, much like as is done
       by mount commands on typical UNIX systems. However, in contrast to mount
@@ -1080,7 +1276,7 @@ Display information about mounted filesystems, or mount a filesystem
       the Cygwin POSIX file system and strategies for using mounts. To remove
       mounts temporarily, use <command>umount</command></para>
 
-    <sect3 id="utils-mount">
+    <refsect2 id="utils-mount">
       <title>Using mount</title>
 
       <para>If you just type <command>mount</command> with no parameters, it
@@ -1225,9 +1421,9 @@ D: on /d type fat (binary,user,noumount)
         <filename>/etc/fstab</filename> to restore the old state. It also makes
         moving your settings to a different machine much easier.</para>
 
-    </sect3>
+    </refsect2>
 
-    <sect3 id="utils-cygdrive">
+    <refsect2 id="utils-cygdrive">
       <title>Cygdrive mount points</title>
 
       <para>Whenever Cygwin cannot use any of the existing mounts to convert
@@ -1266,9 +1462,9 @@ D: on /d type fat (binary,user,noumount)
       </example>
 
 
-    </sect3>
+    </refsect2>
 
-    <sect3 id="utils-limitations">
+    <refsect2 id="utils-limitations">
       <title>Limitations</title>
 
       <para>Limitations: there is a hard-coded limit of 64 mount points (up to
@@ -1295,18 +1491,31 @@ D: on /d type fat (binary,user,noumount)
         or <command>echo *</command> command and <command>find .</command> will
         not find <filename>mtpt</filename>. </para>
 
-    </sect3>
+    </refsect2>
+    </refsect1>
+  </refentry>
 
-  </sect2>
+  <refentry id="passwd">
+    <refmeta>
+      <refentrytitle>passwd</refentrytitle>
+      <manvolnum>1</manvolnum>
+      <refmiscinfo class="manual">Cygwin Utilities</refmiscinfo>
+    </refmeta>
 
-  <sect2 id="passwd">
-    <title>passwd</title>
+    <refnamediv>
+      <refname>passwd</refname>
+      <refpurpose>Change USER's password or password attributes.</refpurpose>
+    </refnamediv>
 
-    <screen>
+    <refsynopsisdiv>
+      <screen>
 Usage: passwd [OPTION] [USER]
+      </screen>
+    </refsynopsisdiv>
 
-Change USER's password or password attributes.
-
+    <refsect1>
+      <title>Options</title>
+      <screen>
 User operations:
   -l, --lock               lock USER's account.
   -u, --unlock             unlock USER's account.
@@ -1348,7 +1557,10 @@ Don't use this feature if you don't need network access within a remote
 session.  You can delete your stored password by using `passwd -R' and
 specifying an empty password.
 </screen>
+    </refsect1>
 
+    <refsect1>
+      <title>Description</title>
     <para> <command>passwd</command> changes passwords for user accounts. A
       normal user may only change the password for their own account, but
       administrators may change passwords on any account.
@@ -1441,35 +1653,64 @@ specifying an empty password.
 
     <para>Limitations: Users may not be able to change their password on some
       systems.</para>
-
-  </sect2>
-
-  <sect2 id="pldd">
-    <title>pldd</title>
-
-    <screen>
+    </refsect1>
+  </refentry>
+
+  <refentry id="pldd">
+    <refmeta>
+      <refentrytitle>pldd</refentrytitle>
+      <manvolnum>1</manvolnum>
+      <refmiscinfo class="manual">Cygwin Utilities</refmiscinfo>
+    </refmeta>
+
+    <refnamediv>
+      <refname>pldd</refname>
+      <refpurpose>List dynamic shared objects loaded into a process</refpurpose>
+    </refnamediv>
+
+    <refsynopsisdiv>
+      <screen>
 Usage: pldd [OPTION...] PID
+      </screen>
+    </refsynopsisdiv>
 
-List dynamic shared objects loaded into a process.
-
+    <refsect1>
+      <title>Options</title>
+      <screen>
   -?, --help                 Give this help list
       --usage                Give a short usage message
   -V, --version              Print program version
 </screen>
+    </refsect1>
 
+    <refsect1>
+      <title>Description</title>
     <para><command>pldd</command> prints the shared libraries (DLLs) loaded by
       the process with the given PID.</para>
-
-  </sect2>
-
-  <sect2 id="ps">
-    <title>ps</title>
-
-    <screen>
+    </refsect1>
+  </refentry>
+
+  <refentry id="ps">
+    <refmeta>
+      <refentrytitle>ps</refentrytitle>
+      <manvolnum>1</manvolnum>
+      <refmiscinfo class="manual">Cygwin Utilities</refmiscinfo>
+    </refmeta>
+
+    <refnamediv>
+      <refname>ps</refname>
+      <refpurpose>Report process status</refpurpose>
+    </refnamediv>
+
+    <refsynopsisdiv>
+      <screen>
 Usage: ps [-aefls] [-u UID]
+      </screen>
+    </refsynopsisdiv>
 
-Report process status
-
+    <refsect1>
+      <title>Options</title>
+      <screen>
  -a, --all       show processes of all users
  -e, --everyone  show processes of all users
  -f, --full      show process uids, ppids
@@ -1482,7 +1723,10 @@ Report process status
  -W, --windows   show windows as well as cygwin processes
 With no options, ps outputs the long format by default
 </screen>
+    </refsect1>
 
+    <refsect1>
+      <title>Description</title>
     <para>The <command>ps</command> program gives the status of all the Cygwin
       processes running on the system (ps = "process status"). Due to the
       limitations of simulating a POSIX environment under Windows, there is
@@ -1516,17 +1760,30 @@ With no options, ps outputs the long format by default
       non-Cygwin Windows processes as well as Cygwin processes. The WINPID is
       also the PID, and they can be killed with the Cygwin
       <command>kill</command> command's <literal>-f</literal> option. </para>
-
-  </sect2>
-
-  <sect2 id="regtool">
-    <title>regtool</title>
-
-    <screen>
+    </refsect1>
+  </refentry>
+
+  <refentry id="regtool">
+    <refmeta>
+      <refentrytitle>regtool</refentrytitle>
+      <manvolnum>1</manvolnum>
+      <refmiscinfo class="manual">Cygwin Utilities</refmiscinfo>
+    </refmeta>
+
+    <refnamediv>
+      <refname>regtool</refname>
+      <refpurpose>View or edit the Windows registry</refpurpose>
+    </refnamediv>
+
+    <refsynopsisdiv>
+      <screen>
 Usage: regtool [OPTION] (add|check|get|list|remove|unset|load|unload|save) KEY
+      </screen>
+    </refsynopsisdiv>
 
-View or edit the Win32 registry
-
+    <refsect1>
+      <title>Options</title>
+      <screen>
 Actions:
 
  add KEY\SUBKEY             add new SUBKEY
@@ -1594,7 +1851,10 @@ You can use forward slash ('/') as a separator instead of backslash, in
 that case backslash is treated as escape character
 Example: regtool get '\user\software\Microsoft\Clock\iFormat'
 </screen>
+    </refsect1>
 
+    <refsect1>
+      <title>Description</title>
     <para>The <command>regtool</command> program allows shell scripts to access
       and modify the Windows registry. Note that modifying the Windows registry
       is dangerous, and carelessness here can result in an unusable system. Be
@@ -1690,19 +1950,31 @@ Example: regtool get '\user\software\Microsoft\Clock\iFormat'
     <para> By default, the last "\" or "/" is assumed to be the separator
       between the key and the value. You can use the <literal>-K</literal>
       option to provide an alternate key/value separator character. </para>
-
-  </sect2>
-
-  <sect2 id="setfacl">
-    <title>setfacl</title>
-
-    <screen>
+    </refsect1>
+  </refentry>
+
+  <refentry id="setfacl">
+    <refmeta>
+      <refentrytitle>setfacl</refentrytitle>
+      <manvolnum>1</manvolnum>
+      <refmiscinfo class="manual">Cygwin Utilities</refmiscinfo>
+    </refmeta>
+
+    <refnamediv>
+      <refname>setfacl</refname>
+      <refpurpose>Modify file and directory access control lists (ACLs)</refpurpose>
+    </refnamediv>
+
+    <refsynopsisdiv>
+      <screen>
 Usage: setfacl [-r] {-f ACL_FILE | -s acl_entries} FILE...
        setfacl [-r] {-b|[-d acl_entries] [-m acl_entries]} FILE...
+      </screen>
+     </refsynopsisdiv>
 
-
-Modify file and directory access control lists (ACLs)
-
+    <refsect1>
+      <title>Options</title>
+      <screen>
   -b, --remove-all remove all extended ACL entries
   -d, --delete     delete one or more specified ACL entries
   -f, --file       set ACL entries for FILE to ACL entries read
@@ -1719,7 +1991,10 @@ Modify file and directory access control lists (ACLs)
 
 At least one of (-b, -d, -f, -k, -m, -s) must be specified
 </screen>
+    </refsect1>
 
+    <refsect1>
+      <title>Description</title>
     <para> For each file given as parameter, <command>setfacl</command> will
       either replace its complete ACL (<literal>-s</literal>,
       <literal>-f</literal>), or it will add, modify, or delete ACL entries.
@@ -1811,17 +2086,32 @@ $ getfacl source_file | setfacl -f - target_file
       directory that contains default ACL entries will have permissions
       according to the combination of the current umask, the explicit
       permissions requested and the default ACL entries </para>
-  </sect2>
-
-  <sect2 id="setmetamode">
-    <title>setmetamode</title>
-
-    <screen>
+    </refsect1>
+  </refentry>
+
+  <refentry id="setmetamode">
+    <refmeta>
+      <refentrytitle>setmetamode</refentrytitle>
+      <manvolnum>1</manvolnum>
+      <refmiscinfo class="manual">Cygwin Utilities</refmiscinfo>
+    </refmeta>
+
+    <refnamediv>
+      <refname>setmetamode</refname>
+      <refpurpose>Get or set keyboard meta mode</refpurpose>
+    </refnamediv>
+
+    <refsynopsisdiv>
+      <screen>
 Usage: setmetamode [metabit|escprefix]
+      </screen>
+    </refsynopsisdiv>
 
-Get or set keyboard meta mode
-
+    <refsect1>
+      <title>Options</title>
+      <screen>
   Without argument, it shows the current meta key mode.
+
   metabit|meta|bit     The meta key sets the top bit of the character.
   escprefix|esc|prefix The meta key sends an escape prefix.
 
@@ -1830,20 +2120,36 @@ Other options:
   -h, --help           This text
   -V, --version        Print program version and exit
 </screen>
+    </refsect1>
 
+    <refsect1>
+      <title>Description</title>
     <para><command>setmetamode</command> can be used to determine and set the
       key code sent by the meta (aka <literal>Alt</literal>) key.</para>
-
-  </sect2>
-
-  <sect2 id="ssp">
-    <title>ssp</title>
-
-    <screen>
+    </refsect1>
+  </refentry>
+
+  <refentry id="ssp">
+    <refmeta>
+      <refentrytitle>ssp</refentrytitle>
+      <manvolnum>1</manvolnum>
+      <refmiscinfo class="manual">Cygwin Utilities</refmiscinfo>
+    </refmeta>
+
+    <refnamediv>
+      <refname>ssp</refname>
+      <refpurpose>Single-step profile COMMAND</refpurpose>
+    </refnamediv>
+
+    <refsynopsisdiv>
+      <screen>
 Usage: ssp [options] low_pc high_pc command...
+      </screen>
+    </refsynopsisdiv>
 
-Single-step profile COMMAND
-
+    <refsect1>
+      <title>Options</title>
+      <screen>
  -c, --console-trace  trace every EIP value to the console. *Lots* slower.
  -d, --disable        disable single-stepping by default; use
                       OutputDebugString ("ssp on") to enable stepping
@@ -1861,7 +2167,10 @@ Single-step profile COMMAND
 
 Example: ssp 0x401000 0x403000 hello.exe
 </screen>
+    </refsect1>
 
+    <refsect1>
+      <title>Description</title>
     <para> SSP - The Single Step Profiler </para>
 
     <para> Original Author: DJ Delorie </para>
@@ -1991,17 +2300,31 @@ Each sample counts as 0.01 seconds.
 $ ssp <literal>-v</literal> <literal>-s</literal> <literal>-l</literal> <literal>-d</literal> 0x61001000 0x61080000 hello.exe
 </screen>
     </para>
-  </sect2>
-
-  <sect2 id="strace">
-    <title>strace</title>
-
-    <screen>
+  </refsect1>
+  </refentry>
+
+  <refentry id="strace">
+    <refmeta>
+      <refentrytitle>strace</refentrytitle>
+      <manvolnum>1</manvolnum>
+      <refmiscinfo class="manual">Cygwin Utilities</refmiscinfo>
+    </refmeta>
+
+    <refnamediv>
+      <refname>strace</refname>
+      <refpurpose>Trace system calls and signals</refpurpose>
+    </refnamediv>
+
+    <refsynopsisdiv>
+      <screen>
 Usage: strace [OPTIONS] &lt;command-line&gt;
 Usage: strace [OPTIONS] -p &lt;pid&gt;
+      </screen>
+    </refsynopsisdiv>
 
-Trace system calls and signals
-
+    <refsect1>
+      <title>Options</title>
+      <screen>
   -b, --buffer-size=SIZE       set size of output file buffer
   -d, --no-delta               don't display the delta-t microsecond timestamp
   -e, --events                 log all Windows DEBUG_EVENTS (toggle - default true)
@@ -2052,7 +2375,10 @@ Trace system calls and signals
     special  0x100000 (_STRACE_SPECIAL)  Special debugging printfs for
                                          non-checked-in code
 </screen>
+    </refsect1>
 
+    <refsect1>
+      <title>Description</title>
     <para>The <command>strace</command> program executes a program, and
       optionally the children of the program, reporting any Cygwin DLL output
       from the program(s) to stdout, or to a file with the
@@ -2069,51 +2395,84 @@ $ strace -o tracing_output -w sh -c 'while true; do echo "tracing..."; done' &am
       <command>cygcheck</command>). As a result it does not understand
       symlinks. This program is mainly useful for debugging the Cygwin DLL
       itself.</para>
-
-  </sect2>
-
-  <sect2 id="tzset">
-    <title>tzset</title>
-
-    <screen>
+    </refsect1>
+  </refentry>
+
+  <refentry id="tzset">
+    <refmeta>
+      <refentrytitle>tzset</refentrytitle>
+      <manvolnum>1</manvolnum>
+      <refmiscinfo class="manual">Cygwin Utilities</refmiscinfo>
+    </refmeta>
+
+    <refnamediv>
+      <refname>tzset</refname>
+      <refpurpose>Print POSIX-compatible timezone ID from current Windows timezone setting</refpurpose>
+    </refnamediv>
+
+    <refsynopsisdiv>
+      <screen>
 Usage: tzset [OPTION]
+      </screen>
+    </refsynopsisdiv>
 
-Print POSIX-compatible timezone ID from current Windows timezone setting
-
+    <refsect1>
+      <title>Options</title>
+      <screen>
 Options:
   -h, --help               output usage information and exit.
   -V, --version            output version information and exit.
+      </screen>
+    </refsect1>
 
-Use tzset to set your TZ variable. In POSIX-compatible shells like bash,
-dash, mksh, or zsh:
-
-      export TZ=$(tzset)
-
-In csh-compatible shells like tcsh:
-
-      setenv TZ `tzset`
-</screen>
+    <refsect1>
+      <title>Description</title>
+      Use tzset to set your TZ variable. In POSIX-compatible shells like bash,
+      dash, mksh, or zsh:
+      <screen>
+export TZ=$(tzset)
+      </screen>
+      In csh-compatible shells like tcsh:
+      <screen>
+setenv TZ `tzset`
+      </screen>
 
     <para>The <command>tzset</command> tool reads the current timezone from
       Windows and generates a POSIX-compatible timezone information for the TZ
       environment variable from that information. That's all there is to it.
       For the way how to use it, see the above usage information.</para>
-
-  </sect2>
-
-  <sect2 id="umount">
-    <title>umount</title>
-
-    <screen>
+    </refsect1>
+  </refentry>
+
+  <refentry id="umount">
+    <refmeta>
+      <refentrytitle>umount</refentrytitle>
+      <manvolnum>1</manvolnum>
+      <refmiscinfo class="manual">Cygwin Utilities</refmiscinfo>
+    </refmeta>
+
+    <refnamediv>
+      <refname>umount</refname>
+      <refpurpose>Unmount filesystems</refpurpose>
+    </refnamediv>
+
+    <refsynopsisdiv>
+      <screen>
 Usage: umount [OPTION] [&lt;posixpath&gt;]
+      </screen>
+    </refsynopsisdiv>
 
-Unmount filesystems
-
+    <refsect1>
+      <title>Options</title>
+      <screen>
   -h, --help                    output usage information and exit
   -U, --remove-user-mounts      remove all user mounts
   -V, --version                 output version information and exit
 </screen>
+    </refsect1>
 
+    <refsect1>
+      <title>Description</title>
     <para>The <command>umount</command> program removes mounts from the mount
       table in the current session. If you specify a POSIX path that
       corresponds to a current mount point, <command>umount</command> will
@@ -2123,6 +2482,7 @@ Unmount filesystems
 
     <para>See <xref linkend="mount-table"/> in the Cygwin User's Guide for more
       information on the mount table.</para>
-  </sect2>
+    </refsect1>
+  </refentry>
 
 </sect1>
-- 
2.1.4
