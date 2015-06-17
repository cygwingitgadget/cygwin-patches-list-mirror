Return-Path: <cygwin-patches-return-8187-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13306 invoked by alias); 17 Jun 2015 12:37:48 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 13203 invoked by uid 89); 17 Jun 2015 12:37:47 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=0.4 required=5.0 tests=AWL,BAYES_50,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=no version=3.3.2
X-HELO: rgout05.bt.lon5.cpcloud.co.uk
Received: from rgout05.bt.lon5.cpcloud.co.uk (HELO rgout05.bt.lon5.cpcloud.co.uk) (65.20.0.182) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 17 Jun 2015 12:37:37 +0000
X-OWM-Source-IP: 86.141.128.210(GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-CTCH-RefID: str=0001.0A090204.55816A0F.029E,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-Junkmail-Premium-Raw: score=27/50,refid=2.7.2:2015.6.17.94516:17:27.888,ip=86.141.128.210,rules=__HAS_FROM, __TO_MALFORMED_2, __TO_NO_NAME, __SUBJ_ALPHA_END, __HAS_MSGID, __SANE_MSGID, __HAS_X_MAILER, __IN_REP_TO, __REFERENCES, __ANY_URI, __MAL_TELEKOM_URI, __CP_URI_IN_BODY, BODY_SIZE_10000_PLUS, __MIME_TEXT_ONLY, RDNS_GENERIC_POOLED, __URI_NS, SXL_IP_DYNAMIC[210.128.141.86.fur], HTML_00_01, HTML_00_10, RDNS_SUSP_GENERIC, RDNS_SUSP, REFERENCES
X-CTCH-Spam: Unknown
Received: from localhost.localdomain (86.141.128.210) by rgout05.bt.lon5.cpcloud.co.uk (8.6.122.06) (authenticated as jonturney@btinternet.com)        id 55814C5E00039B52; Wed, 17 Jun 2015 13:37:28 +0100
From: Jon TURNEY <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon TURNEY <jon.turney@dronecode.org.uk>
Subject: [PATCH 3/5] winsup/doc: Convert cygwin-api function documentation to refentry elements
Date: Wed, 17 Jun 2015 12:37:00 -0000
Message-Id: <1434544626-2516-4-git-send-email-jon.turney@dronecode.org.uk>
In-Reply-To: <1434544626-2516-1-git-send-email-jon.turney@dronecode.org.uk>
References: <1434544626-2516-1-git-send-email-jon.turney@dronecode.org.uk>
X-SW-Source: 2015-q2/txt/msg00089.txt.bz2

Convert cygwin-api from using a sect2 element to using a refentry element for
each function.  This makes it possible to generate manpage-style output for
those elements.

Note that the chunked html now generates a page for each function, rather than
one containing all functions.

Also:

Remove pointless and incorrect date

Move introductory paragraph from the first section to the start of the chapter

Add a funcsynopsisino element with the header file to be included to each
function prototype

Remove extern "C" which doesn't process into all formats successfully

2015-06-17  Jon Turney  <jon.turney@dronecode.org.uk>

	* cygwin-api.xml: Move introductory paragraph here.
	* logon-funcs.xml: Convert from using a sect2 element to using a
	refentry element for each function.
	* misc-funcs.xml: Ditto.
	* path.xml: Ditto.

Signed-off-by: Jon TURNEY <jon.turney@dronecode.org.uk>
---
 winsup/doc/ChangeLog       |   8 +++
 winsup/doc/cygwin-api.xml  |   6 +-
 winsup/doc/logon-funcs.xml |  59 +++++++++++++---
 winsup/doc/misc-funcs.xml  |  81 ++++++++++++++++-----
 winsup/doc/path.xml        | 172 ++++++++++++++++++++++++++++++++++-----------
 5 files changed, 258 insertions(+), 68 deletions(-)

diff --git a/winsup/doc/ChangeLog b/winsup/doc/ChangeLog
index 347adcb..ddee4e9 100644
--- a/winsup/doc/ChangeLog
+++ b/winsup/doc/ChangeLog
@@ -1,5 +1,13 @@
 2015-06-17  Jon Turney  <jon.turney@dronecode.org.uk>
 
+	* cygwin-api.xml: Move introductory paragraph here.
+	* logon-funcs.xml: Convert from using a sect2 element to using a
+	refentry element for each function.
+	* misc-funcs.xml: Ditto.
+	* path.xml: Ditto.
+
+2015-06-17  Jon Turney  <jon.turney@dronecode.org.uk>
+
 	* fo.xsl: Render funcsynopsis elements as ANSI style function
 	prototypes.
 	* html.xsl: Ditto.
diff --git a/winsup/doc/cygwin-api.xml b/winsup/doc/cygwin-api.xml
index ac98c00..7b831d9 100644
--- a/winsup/doc/cygwin-api.xml
+++ b/winsup/doc/cygwin-api.xml
@@ -5,7 +5,6 @@
 <book id="cygwin-api" xmlns:xi="http://www.w3.org/2001/XInclude">
 
   <bookinfo>
-    <date>1998-08-31</date>
     <title>Cygwin API Reference</title>
       <xi:include href="legal.xml"/>
   </bookinfo>
@@ -17,6 +16,11 @@
   <chapter id="cygwin-functions" xmlns:xi="http://www.w3.org/2001/XInclude">
   <title>Cygwin Functions</title>
 
+  <para>
+    These functions are specific to Cygwin itself, and probably won't be
+    found anywhere else.
+  </para>
+
     <xi:include href="path.xml"/>
     <xi:include href="logon-funcs.xml"/>
     <xi:include href="misc-funcs.xml"/>
diff --git a/winsup/doc/logon-funcs.xml b/winsup/doc/logon-funcs.xml
index 9e32ad6..084b0c7 100644
--- a/winsup/doc/logon-funcs.xml
+++ b/winsup/doc/logon-funcs.xml
@@ -5,52 +5,91 @@
 <sect1 id="func-cygwin-login">
 <title>Helper functions to change user context</title>
 
-<sect2 id="func-cygwin-logon_user">
-<title>cygwin_logon_user</title>
+<refentry id="func-cygwin-logon_user">
+  <refmeta>
+    <refentrytitle>cygwin_logon_user</refentrytitle>
+    <manvolnum>3</manvolnum>
+    <refmiscinfo class="manual">Cygwin API Reference</refmiscinfo>
+  </refmeta>
 
-<funcsynopsis><funcprototype>
-<funcdef>extern "C" HANDLE
+  <refnamediv>
+    <refname>cygwin_logon_user</refname>
+  </refnamediv>
+
+  <refsynopsisdiv>
+<funcsynopsis>
+<funcsynopsisinfo>
+#include &lt;sys/cygwin.h&gt;
+</funcsynopsisinfo>
+<funcprototype>
+<funcdef>HANDLE
 <function>cygwin_logon_user</function></funcdef>
 <paramdef>const struct passwd *<parameter>passwd_entry</parameter></paramdef>
 <paramdef>const char *<parameter>password</parameter></paramdef>
 </funcprototype></funcsynopsis>
+  </refsynopsisdiv>
 
+  <refsect1>
+    <title>Description</title>
 <para>Given a pointer to a passwd entry of a user and a cleartext password,
 returns a HANDLE to an impersonation token for this user which can be used
 in a subsequent call to <function>cygwin_set_impersonation_token</function>
 to impersonate that user.  This function can only be called from a process
 which has the required NT user rights to perform a logon.</para>
+  </refsect1>
 
+  <refsect1>
+    <title>See also</title>
 <para>See also the chapter
 <ulink url="../cygwin-ug-net/ntsec.html#ntsec-setuid-overview">Switching the user context</ulink>
 in the Cygwin User's guide.</para>
 
 <para>See also <link linkend="func-cygwin-set-impersonation-token">cygwin_set_impersonation_token</link></para>
+  </refsect1>
+</refentry>
 
-</sect2>
+<refentry id="func-cygwin-set-impersonation-token">
+  <refmeta>
+    <refentrytitle>cygwin_set_impersonation_token</refentrytitle>
+    <manvolnum>3</manvolnum>
+    <refmiscinfo class="manual">Cygwin API Reference</refmiscinfo>
+  </refmeta>
 
-<sect2 id="func-cygwin-set-impersonation-token">
-<title>cygwin_set_impersonation_token</title>
+  <refnamediv>
+    <refname>cygwin_set_impersonation_token</refname>
+  </refnamediv>
 
-<funcsynopsis><funcprototype>
-<funcdef>extern "C" void
+  <refsynopsisdiv>
+<funcsynopsis>
+<funcsynopsisinfo>
+#include &lt;sys/cygwin.h&gt;
+</funcsynopsisinfo>
+<funcprototype>
+<funcdef>void
 <function>cygwin_set_impersonation_token</function></funcdef>
 <paramdef>const HANDLE <parameter>token</parameter></paramdef>
 </funcprototype></funcsynopsis>
+  </refsynopsisdiv>
 
+  <refsect1>
+    <title>Description</title>
 <para>Use this function to enable the token given as parameter as
 impersonation token for the next call to <function>setuid</function> or
 <function>seteuid</function>.  Use
 <function>cygwin_set_impersonation_token</function> together with
 <function>cygwin_logon_user</function> to impersonate users using
 password authentication.</para>
+  </refsect1>
 
+  <refsect1>
+    <title>See also</title>
 <para>See also the chapter
 <ulink url="../cygwin-ug-net/ntsec.html#ntsec-setuid-overview">Switching the user context</ulink>
 in the Cygwin User's guide.</para>
 
 <para>See also <link linkend="func-cygwin-logon_user">cygwin_logon_user</link></para>
+  </refsect1>
 
-</sect2>
+</refentry>
 
 </sect1>
diff --git a/winsup/doc/misc-funcs.xml b/winsup/doc/misc-funcs.xml
index b164341..16b3d61 100644
--- a/winsup/doc/misc-funcs.xml
+++ b/winsup/doc/misc-funcs.xml
@@ -5,11 +5,24 @@
 <sect1 id="func-cygwin-misc">
 <title>Miscellaneous functions</title>
 
-<sect2 id="func-cygwin-attach-handle-to-fd">
-<title>cygwin_attach_handle_to_fd</title>
+<refentry id="func-cygwin-attach-handle-to-fd">
+  <refmeta>
+    <refentrytitle>cygwin_attach_handle_to_fd</refentrytitle>
+    <manvolnum>3</manvolnum>
+    <refmiscinfo class="manual">Cygwin API Reference</refmiscinfo>
+  </refmeta>
 
-<funcsynopsis><funcprototype>
-<funcdef>extern "C" int
+  <refnamediv>
+    <refname>cygwin_attach_handle_to_fd</refname>
+  </refnamediv>
+
+  <refsynopsisdiv>
+<funcsynopsis>
+<funcsynopsisinfo>
+#include &lt;sys/cygwin.h&gt;
+</funcsynopsisinfo>
+<funcprototype>
+<funcdef>int
 <function>cygwin_attach_handle_to_fd</function></funcdef>
 <paramdef>char *<parameter>name</parameter></paramdef>
 <paramdef>int <parameter>fd</parameter></paramdef>
@@ -17,7 +30,10 @@
 <paramdef>int <parameter>bin</parameter></paramdef>
 <paramdef>int <parameter>access</parameter></paramdef>
 </funcprototype></funcsynopsis>
+  </refsynopsisdiv>
 
+  <refsect1>
+    <title>Description</title>
 <para>This function can be used to turn a Win32 "handle" into a
 posix-style file handle. <parameter>fd</parameter> may be -1 to
 make cygwin allocate a handle; the actual handle is returned
@@ -27,38 +43,71 @@ in all cases.</para>
 underlying file or device.  It just tries to supply the typical file
 functions on a "best-effort" basis.  Use with care.  Don't expect too
 much.</para>
+  </refsect1>
+</refentry>
 
-</sect2>
+<refentry id="func-cygwin-internal">
+  <refmeta>
+    <refentrytitle>cygwin_internal</refentrytitle>
+    <manvolnum>3</manvolnum>
+    <refmiscinfo class="manual">Cygwin API Reference</refmiscinfo>
+  </refmeta>
 
-<sect2 id="func-cygwin-internal">
-<title>cygwin_internal</title>
+  <refnamediv>
+    <refname>cygwin_internal</refname>
+  </refnamediv>
 
-<funcsynopsis><funcprototype>
-<funcdef>extern "C" uintptr_t
+  <refsynopsisdiv>
+<funcsynopsis>
+<funcsynopsisinfo>
+#include &lt;sys/cygwin.h&gt;
+</funcsynopsisinfo>
+<funcprototype>
+<funcdef>uintptr_t
 <function>cygwin_internal</function></funcdef>
 <paramdef>cygwin_getinfo_types <parameter>t</parameter></paramdef>
 <paramdef><parameter>...</parameter></paramdef>
 </funcprototype></funcsynopsis>
+  </refsynopsisdiv>
 
+  <refsect1>
+    <title>Description</title>
 <para>This function gives you access to various internal data and functions.
 It takes two arguments.  The first argument is a type from the 'cygwin_getinfo_types'
 enum.  The second is an optional pointer.</para>
 <para>Stay away unless you know what you're doing.</para>
+  </refsect1>
+</refentry>
+
 
-</sect2>
+<refentry id="func-cygwin-stackdump">
+  <refmeta>
+    <refentrytitle>cygwin_stackdump</refentrytitle>
+    <manvolnum>3</manvolnum>
+    <refmiscinfo class="manual">Cygwin API Reference</refmiscinfo>
+  </refmeta>
 
-<sect2 id="func-cygwin-stackdump">
-<title>cygwin_stackdump</title>
+  <refnamediv>
+    <refname>cygwin_stackdump</refname>
+  </refnamediv>
 
-<funcsynopsis><funcprototype>
-<funcdef>extern "C" void
+  <refsynopsisdiv>
+<funcsynopsis>
+<funcsynopsisinfo>
+#include &lt;sys/cygwin.h&gt;
+</funcsynopsisinfo>
+<funcprototype>
+<funcdef>void
 <function>cygwin_stackdump</function></funcdef>
 <void />
 </funcprototype></funcsynopsis>
+  </refsynopsisdiv>
 
+  <refsect1>
+    <title>Description</title>
 <para> Outputs a stackdump to stderr from the called location.
 </para>
-
-</sect2>
+  </refsect1>
+</refentry>
 
 </sect1>
diff --git a/winsup/doc/path.xml b/winsup/doc/path.xml
index 06a252b..bea6798 100644
--- a/winsup/doc/path.xml
+++ b/winsup/doc/path.xml
@@ -5,21 +5,34 @@
 <sect1 id="func-cygwin-path">
 <title>Path conversion functions</title>
 
-<para>These functions are specific to Cygwin itself, and probably
-won't be found anywhere else.  </para>
-
-<sect2 id="func-cygwin-conv-path">
-<title>cygwin_conv_path</title>
-
-<funcsynopsis><funcprototype>
-<funcdef>extern "C" ssize_t
+<refentry id="func-cygwin-conv-path">
+  <refmeta>
+    <refentrytitle>cygwin_conv_path</refentrytitle>
+    <manvolnum>3</manvolnum>
+    <refmiscinfo class="manual">Cygwin API Reference</refmiscinfo>
+  </refmeta>
+
+  <refnamediv>
+    <refname>cygwin_conv_path</refname>
+  </refnamediv>
+
+  <refsynopsisdiv>
+<funcsynopsis>
+<funcsynopsisinfo>
+#include &lt;sys/cygwin.h&gt;
+</funcsynopsisinfo>
+<funcprototype>
+<funcdef>ssize_t
 <function>cygwin_conv_path</function></funcdef>
 <paramdef>cygwin_conv_path_t <parameter>what</parameter></paramdef>
 <paramdef>const void * <parameter>from</parameter></paramdef>
 <paramdef>void * <parameter>to</parameter></paramdef>
 <paramdef>size_t <parameter>size</parameter></paramdef>
 </funcprototype></funcsynopsis>
+  </refsynopsisdiv>
 
+  <refsect1>
+    <title>Description</title>
 <para>Use this function to convert POSIX paths in
 <parameter>from</parameter> to Win32 paths in <parameter>to</parameter>
 or, vice versa, Win32 paths in <parameter>from</parameter> to POSIX paths
@@ -58,7 +71,10 @@ error and errno is set to one of the below values.</para>
                   of what == CCP_POSIX_TO_WIN_A, longer than MAX_PATH.
     ENOSPC        size is less than required for the conversion.
 </programlisting>
+  </refsect1>
 
+  <refsect1>
+    <title>Example</title>
 <example>
 <title>Example use of cygwin_conv_path</title>
 <programlisting>
@@ -83,21 +99,37 @@ else
 ]]>
 </programlisting>
 </example>
-
-</sect2>
-
-<sect2 id="func-cygwin-conv-path-list">
-<title>cygwin_conv_path_list</title>
-
-<funcsynopsis><funcprototype>
-<funcdef>extern "C" ssize_t
+  </refsect1>
+</refentry>
+
+<refentry id="func-cygwin-conv-path-list">
+  <refmeta>
+    <refentrytitle>cygwin_conv_path_list</refentrytitle>
+    <manvolnum>3</manvolnum>
+    <refmiscinfo class="manual">Cygwin API Reference</refmiscinfo>
+  </refmeta>
+
+  <refnamediv>
+    <refname>cygwin_conv_path_list</refname>
+  </refnamediv>
+
+  <refsynopsisdiv>
+<funcsynopsis>
+<funcsynopsisinfo>
+#include &lt;sys/cygwin.h&gt;
+</funcsynopsisinfo>
+<funcprototype>
+<funcdef>ssize_t
 <function>cygwin_conv_path_list</function></funcdef>
 <paramdef>cygwin_conv_path_t <parameter>what</parameter></paramdef>
 <paramdef>const void * <parameter>from</parameter></paramdef>
 <paramdef>void * <parameter>to</parameter></paramdef>
 <paramdef>size_t <parameter>size</parameter></paramdef>
 </funcprototype></funcsynopsis>
+  </refsynopsisdiv>
 
+  <refsect1>
+    <title>Description</title>
 <para>This is the same as <function>cygwin_conv_path</function>, but the
 input is treated as a path list in $PATH or %PATH% notation.</para>
 <para>If <parameter>what</parameter> is CCP_POSIX_TO_WIN_A or
@@ -108,21 +140,40 @@ CCP_WIN_W_TO_POSIX, given a Win32 %PATH%-style string (i.e. d:\;e:\bar)
 convert it to the equivalent POSIX $PATH-style string (i.e. /foo:/bar).</para>
 <para><parameter>size</parameter> is the size of the buffer pointed to by
 <parameter>to</parameter> in bytes.</para>
+  </refsect1>
 
+<refsect1>
+  <title>See also</title>
 <para>See also <link linkend="func-cygwin-conv-path">cygwin_conv_path</link></para>
-
-</sect2>
-
-<sect2 id="func-cygwin-create-path">
-<title>cygwin_create_path</title>
-
-<funcsynopsis><funcprototype>
-<funcdef>extern "C" void *
+  </refsect1>
+</refentry>
+
+<refentry id="func-cygwin-create-path">
+  <refmeta>
+    <refentrytitle>cygwin_create_path</refentrytitle>
+    <manvolnum>3</manvolnum>
+    <refmiscinfo class="manual">Cygwin API Reference</refmiscinfo>
+  </refmeta>
+
+  <refnamediv>
+    <refname>cygwin_create_path</refname>
+  </refnamediv>
+
+  <refsynopsisdiv>
+<funcsynopsis>
+<funcsynopsisinfo>
+#include &lt;sys/cygwin.h&gt;
+</funcsynopsisinfo>
+<funcprototype>
+<funcdef>void *
 <function>cygwin_create_path</function></funcdef>
 <paramdef>cygwin_conv_path_t <parameter>what</parameter></paramdef>
 <paramdef>const void * <parameter>from</parameter></paramdef>
 </funcprototype></funcsynopsis>
+  </refsynopsisdiv>
 
+  <refsect1>
+    <title>Description</title>
 <para>This is equivalent to the <function>cygwin_conv_path</function>, except
 that <function>cygwin_create_path</function> does not take a buffer pointer
 for the result of the conversion as input.  Rather it allocates the buffer
@@ -137,20 +188,39 @@ errno can be set to the below value.</para>
 
 <para>When you don't need the returned buffer anymore, use
 <function>free</function>(3) to deallocate it.</para>
+  </refsect1>
 
+<refsect1>
+  <title>See also</title>
 <para>See also <link linkend="func-cygwin-conv-path">cygwin_conv_path</link></para>
-
-</sect2>
-
-<sect2 id="func-cygwin-posix-path-list-p">
-<title>cygwin_posix_path_list_p</title>
-
-<funcsynopsis><funcprototype>
-<funcdef>extern "C" int
+  </refsect1>
+</refentry>
+
+<refentry id="func-cygwin-posix-path-list-p">
+  <refmeta>
+    <refentrytitle>cygwin_posix_path_list_p</refentrytitle>
+    <manvolnum>3</manvolnum>
+    <refmiscinfo class="manual">Cygwin API Reference</refmiscinfo>
+  </refmeta>
+
+  <refnamediv>
+    <refname>cygwin_posix_path_list_p</refname>
+  </refnamediv>
+
+  <refsynopsisdiv>
+<funcsynopsis>
+<funcsynopsisinfo>
+#include &lt;sys/cygwin.h&gt;
+</funcsynopsisinfo>
+<funcprototype>
+<funcdef>int
 <function>cygwin_posix_path_list_p</function></funcdef>
 <paramdef>const char *<parameter>path</parameter></paramdef>
 </funcprototype></funcsynopsis>
+  </refsynopsisdiv>
 
+  <refsect1>
+    <title>Description</title>
 <para>This function tells you if the supplied
 <parameter>path</parameter> is a POSIX-style path (i.e. posix names,
 forward slashes, colon delimiters) or a Win32-style path (drive
@@ -158,25 +228,44 @@ letters, reverse slashes, semicolon delimiters.  The return value is
 true if the path is a POSIX path.  Note that "_p" means "predicate", a
 lisp term meaning that the function tells you something about the
 parameter.</para>
-
-</sect2>
-
-<sect2 id="func-cygwin-split-path">
-<title>cygwin_split_path</title>
-
-<funcsynopsis><funcprototype>
-<funcdef>extern "C" void
+  </refsect1>
+</refentry>
+
+<refentry id="func-cygwin-split-path">
+  <refmeta>
+    <refentrytitle>cygwin_split_path</refentrytitle>
+    <manvolnum>3</manvolnum>
+    <refmiscinfo class="manual">Cygwin API Reference</refmiscinfo>
+  </refmeta>
+
+  <refnamediv>
+    <refname>cygwin_split_path</refname>
+  </refnamediv>
+
+  <refsynopsisdiv>
+<funcsynopsis>
+<funcsynopsisinfo>
+#include &lt;sys/cygwin.h&gt;
+</funcsynopsisinfo>
+<funcprototype>
+<funcdef>void
 <function>cygwin_split_path</function>
 </funcdef>
 <paramdef>const char * <parameter>path</parameter></paramdef>
 <paramdef>char * <parameter>dir</parameter></paramdef>
 <paramdef>char * <parameter>file</parameter></paramdef>
 </funcprototype></funcsynopsis>
+  </refsynopsisdiv>
 
+  <refsect1>
+    <title>Description</title>
 <para>Split a path into the directory and the file portions.  Both
 <parameter>dir</parameter> and <parameter>file</parameter> are
 expected to point to buffers of sufficient size.  </para>
+  </refsect1>
 
+  <refsect1>
+    <title>Example</title>
 <example>
 <title>Example use of cygwin_split_path</title>
 <programlisting>
@@ -185,6 +274,7 @@ cygwin_split_path("c:/foo/bar.c", dir, file);
 printf("dir=%s, file=%s\n", dir, file);
 </programlisting>
 </example>
-</sect2>
+  </refsect1>
+</refentry>
 
 </sect1>
-- 
2.1.4
