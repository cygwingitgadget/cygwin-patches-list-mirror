Return-Path: <cygwin-patches-return-8690-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19934 invoked by alias); 5 Feb 2017 13:45:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 19659 invoked by uid 89); 5 Feb 2017 13:45:37 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=1.0 required=5.0 tests=BAYES_20,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=no version=3.3.2 spammy=passwords, notation, ids, 1037
X-HELO: rgout0806.bt.lon5.cpcloud.co.uk
Received: from rgout0806.bt.lon5.cpcloud.co.uk (HELO rgout0806.bt.lon5.cpcloud.co.uk) (65.20.0.153) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 05 Feb 2017 13:45:27 +0000
X-OWM-Source-IP: 86.184.210.45 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-Junkmail-Premium-Raw: score=7/50,refid=2.7.2:2017.2.5.131215:17:7.944,ip=,rules=__HAS_FROM, __TO_MALFORMED_2, __TO_NO_NAME, __HAS_CC_HDR, __CC_NAME, __CC_NAME_DIFF_FROM_ACC, __HAS_MSGID, __SANE_MSGID, __HAS_X_MAILER, __FROM_DOMAIN_IN_ANY_CC1, __ANY_URI, __URI_NO_WWW, __FRAUD_MONEY_CURRENCY_DOLLAR, __SUBJ_ALPHA_NEGATE, BODY_SIZE_10000_PLUS, __MIME_TEXT_P1, __MIME_TEXT_ONLY, __URI_NS, HTML_00_01, HTML_00_10, __FRAUD_MONEY_CURRENCY, __FROM_DOMAIN_IN_RCPT, __MIME_TEXT_P, __CC_REAL_NAMES, MULTIPLE_REAL_RCPTS, LEGITIMATE_SIGNS, NO_URI_HTTPS
Received: from localhost.localdomain (86.184.210.45) by rgout08.bt.lon5.cpcloud.co.uk (9.0.019.13-1) (authenticated as jonturney@btinternet.com)        id 584830E3054E19E3; Sun, 5 Feb 2017 13:45:24 +0000
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH] Make anchors stable in generated Cygwin HTML documentation
Date: Sun, 05 Feb 2017 13:45:00 -0000
Message-Id: <20170205134508.150092-1-jon.turney@dronecode.org.uk>
X-SW-Source: 2017-q1/txt/msg00031.txt.bz2

Give more elements ids, so random ids aren't assigned to them, so anchors
are stable between builds.

Signed-off-by: Jon Turney <jon.turney@dronecode.org.uk>
---
 winsup/doc/logon-funcs.xml |  8 ++---
 winsup/doc/misc-funcs.xml  |  6 ++--
 winsup/doc/path.xml        | 22 ++++++------
 winsup/doc/utils.xml       | 90 +++++++++++++++++++++++-----------------------
 4 files changed, 63 insertions(+), 63 deletions(-)

diff --git a/winsup/doc/logon-funcs.xml b/winsup/doc/logon-funcs.xml
index 084b0c7..31da4be 100644
--- a/winsup/doc/logon-funcs.xml
+++ b/winsup/doc/logon-funcs.xml
@@ -29,7 +29,7 @@
 </funcprototype></funcsynopsis>
   </refsynopsisdiv>
 
-  <refsect1>
+  <refsect1 id="func-cygwin-logon_user-desc">
     <title>Description</title>
 <para>Given a pointer to a passwd entry of a user and a cleartext password,
 returns a HANDLE to an impersonation token for this user which can be used
@@ -38,7 +38,7 @@ to impersonate that user.  This function can only be called from a process
 which has the required NT user rights to perform a logon.</para>
   </refsect1>
 
-  <refsect1>
+  <refsect1 id="func-cygwin-logon_user-also">
     <title>See also</title>
 <para>See also the chapter
 <ulink url="../cygwin-ug-net/ntsec.html#ntsec-setuid-overview">Switching the user context</ulink>
@@ -71,7 +71,7 @@ in the Cygwin User's guide.</para>
 </funcprototype></funcsynopsis>
   </refsynopsisdiv>
 
-  <refsect1>
+  <refsect1 id="func-cygwin-set-impersonation-token-desc">
     <title>Description</title>
 <para>Use this function to enable the token given as parameter as
 impersonation token for the next call to <function>setuid</function> or
@@ -81,7 +81,7 @@ impersonation token for the next call to <function>setuid</function> or
 password authentication.</para>
   </refsect1>
 
-  <refsect1>
+  <refsect1 id="func-cygwin-set-impersonation-token-also">
     <title>See also</title>
 <para>See also the chapter
 <ulink url="../cygwin-ug-net/ntsec.html#ntsec-setuid-overview">Switching the user context</ulink>
diff --git a/winsup/doc/misc-funcs.xml b/winsup/doc/misc-funcs.xml
index 16b3d61..7463942 100644
--- a/winsup/doc/misc-funcs.xml
+++ b/winsup/doc/misc-funcs.xml
@@ -32,7 +32,7 @@
 </funcprototype></funcsynopsis>
   </refsynopsisdiv>
 
-  <refsect1>
+  <refsect1 id="func-cygwin-attach-handle-to-fd-desc">
     <title>Description</title>
 <para>This function can be used to turn a Win32 "handle" into a
 posix-style file handle. <parameter>fd</parameter> may be -1 to
@@ -70,7 +70,7 @@ much.</para>
 </funcprototype></funcsynopsis>
   </refsynopsisdiv>
 
-  <refsect1>
+  <refsect1 id="func-cygwin-internal-desc">
     <title>Description</title>
 <para>This function gives you access to various internal data and functions.
 It takes two arguments.  The first argument is a type from the 'cygwin_getinfo_types'
@@ -103,7 +103,7 @@ enum.  The second is an optional pointer.</para>
 </funcprototype></funcsynopsis>
   </refsynopsisdiv>
 
-  <refsect1>
+  <refsect1 id="func-cygwin-stackdump-desc">
     <title>Description</title>
 <para> Outputs a stackdump to stderr from the called location.
 </para>
diff --git a/winsup/doc/path.xml b/winsup/doc/path.xml
index 81d4c3f..f56614b 100644
--- a/winsup/doc/path.xml
+++ b/winsup/doc/path.xml
@@ -31,7 +31,7 @@
 </funcprototype></funcsynopsis>
   </refsynopsisdiv>
 
-  <refsect1>
+  <refsect1 id="func-cygwin-conv-path-desc">
     <title>Description</title>
 <para>Use this function to convert POSIX paths in
 <parameter>from</parameter> to Win32 paths in <parameter>to</parameter>
@@ -75,9 +75,9 @@ error and errno is set to one of the below values.</para>
 </programlisting>
   </refsect1>
 
-  <refsect1>
+  <refsect1 id="func-cygwin-conv-path-example">
     <title>Example</title>
-<example>
+<example id="func-cygwin-conv-path-example-example">
 <title>Example use of cygwin_conv_path</title>
 <programlisting>
 <![CDATA[
@@ -130,7 +130,7 @@ else
 </funcprototype></funcsynopsis>
   </refsynopsisdiv>
 
-  <refsect1>
+  <refsect1 id="func-cygwin-conv-path-list-desc">
     <title>Description</title>
 <para>This is the same as <function>cygwin_conv_path</function>, but the
 input is treated as a path list in $PATH or %PATH% notation.</para>
@@ -144,7 +144,7 @@ convert it to the equivalent POSIX $PATH-style string (i.e. /foo:/bar).</para>
 <parameter>to</parameter> in bytes.</para>
   </refsect1>
 
-<refsect1>
+<refsect1 id="func-cygwin-conv-path-list-also">
   <title>See also</title>
 <para>See also <link linkend="func-cygwin-conv-path">cygwin_conv_path</link></para>
   </refsect1>
@@ -174,7 +174,7 @@ convert it to the equivalent POSIX $PATH-style string (i.e. /foo:/bar).</para>
 </funcprototype></funcsynopsis>
   </refsynopsisdiv>
 
-  <refsect1>
+  <refsect1 id="func-cygwin-create-path-desc">
     <title>Description</title>
 <para>This is equivalent to the <function>cygwin_conv_path</function>, except
 that <function>cygwin_create_path</function> does not take a buffer pointer
@@ -192,7 +192,7 @@ errno can be set to the below value.</para>
 <function>free</function>(3) to deallocate it.</para>
   </refsect1>
 
-<refsect1>
+<refsect1 id="func-cygwin-create-path-also">
   <title>See also</title>
 <para>See also <link linkend="func-cygwin-conv-path">cygwin_conv_path</link></para>
   </refsect1>
@@ -221,7 +221,7 @@ errno can be set to the below value.</para>
 </funcprototype></funcsynopsis>
   </refsynopsisdiv>
 
-  <refsect1>
+  <refsect1 id="func-cygwin-posix-path-list-p-desc">
     <title>Description</title>
 <para>This function tells you if the supplied
 <parameter>path</parameter> is a POSIX-style path (i.e. posix names,
@@ -259,16 +259,16 @@ parameter.</para>
 </funcprototype></funcsynopsis>
   </refsynopsisdiv>
 
-  <refsect1>
+  <refsect1 id="func-cygwin-split-path-desc">
     <title>Description</title>
 <para>Split a path into the directory and the file portions.  Both
 <parameter>dir</parameter> and <parameter>file</parameter> are
 expected to point to buffers of sufficient size.  </para>
   </refsect1>
 
-  <refsect1>
+  <refsect1 id="func-cygwin-split-path-example">
     <title>Example</title>
-<example>
+<example id="func-cygwin-split-path-example-example">
 <title>Example use of cygwin_split_path</title>
 <programlisting>
 char dir[200], file[100];
diff --git a/winsup/doc/utils.xml b/winsup/doc/utils.xml
index 4af6583..948db58 100644
--- a/winsup/doc/utils.xml
+++ b/winsup/doc/utils.xml
@@ -39,7 +39,7 @@ cygcheck -h
 	</screen>
       </refsynopsisdiv>
 
-      <refsect1>
+      <refsect1 id="cygcheck-options">
 	<title>Options</title>
 	<screen>
 At least one command option or a PROGRAM is required, as shown above.
@@ -71,7 +71,7 @@ Note: -c, -f, and -l only report on packages that are currently installed. To
 </screen>
       </refsect1>
 
-<refsect1>
+<refsect1 id="cygcheck-desc">
   <title>Description</title>
     <para> The <command>cygcheck</command> program is a diagnostic utility for
       dealing with Cygwin programs. If you are familiar with
@@ -245,7 +245,7 @@ cygpath [-F ID]
     </screen>
     </refsynopsisdiv>
 
-    <refsect1>
+    <refsect1 id="cygpath-options">
       <title>Options</title>
     <screen>
 Output type options:
@@ -293,7 +293,7 @@ Other options:
 </screen>
     </refsect1>
 
-    <refsect1>
+    <refsect1 id="cygpath-desc">
       <title>Description</title>
     <para>The <command>cygpath</command> program is a utility that converts
       Windows native filenames to Cygwin POSIX-style pathnames and vice versa.
@@ -429,7 +429,7 @@ dumper [OPTION] FILENAME WIN32PID
       </screen>
     </refsynopsisdiv>
 
-    <refsect1>
+    <refsect1 id="dumper-options">
       <title>Options</title>
       <screen>
 -d, --verbose  be verbose while dumping
@@ -439,7 +439,7 @@ dumper [OPTION] FILENAME WIN32PID
 </screen>
     </refsect1>
 
-    <refsect1>
+    <refsect1 id="dumper-desc">
       <title>Description</title>
     <para>The <command>dumper</command> utility can be used to create a core
       dump of running Windows process. This core dump can be later loaded to
@@ -490,7 +490,7 @@ getconf -a [pathname]
       </screen>
     </refsynopsisdiv>
 
-    <refsect1>
+    <refsect1 id="getconf-options">
       <title>Options</title>
       <screen>
   -v specification     Indicate specific version for which configuration
@@ -504,7 +504,7 @@ Other options:
 </screen>
     </refsect1>
 
-    <refsect1>
+    <refsect1 id="getconf-desc">
       <title>Description</title>
     <para>The <command>getconf</command> utility prints the value of the
       configuration variable specified by <literal>variable_name</literal>. If
@@ -553,7 +553,7 @@ getfacl [-adceEn] FILE [FILE2...]
       </screen>
     </refsynopsisdiv>
 
-    <refsect1>
+    <refsect1 id="getfacl-options">
       <title>Options</title>
       <screen>
   -a, --access        display the file access control list only
@@ -570,7 +570,7 @@ line separates the ACLs for each file.
 </screen>
     </refsect1>
 
-    <refsect1>
+    <refsect1 id="getfacl-desc">
       <title>Description</title>
     <para> For each argument that is a regular file, special file or directory,
       <command>getfacl</command> displays the owner, the group, and the ACL.
@@ -622,7 +622,7 @@ kill -l [signal]
       </screen>
     </refsynopsisdiv>
 
-    <refsect1>
+    <refsect1 id="kill-options">
       <title>Options</title>
       <screen>
  -f, --force     force, using win32 interface if necessary
@@ -633,7 +633,7 @@ kill -l [signal]
 </screen>
     </refsect1>
 
-    <refsect1>
+    <refsect1 id="kill-desc">
       <title>Description</title>
     <para>The <command>kill</command> program allows you to send arbitrary
       signals to other Cygwin programs. The usual purpose is to end a running
@@ -739,7 +739,7 @@ ldd [OPTION]... FILE...
       </screen>
     </refsynopsisdiv>
 
-    <refsect1>
+    <refsect1 id="ldd-options">
       <title>Options</title>
       <screen>
   -h, --help              print this help and exit
@@ -753,12 +753,12 @@ ldd [OPTION]... FILE...
 </screen>
     </refsect1>
 
-    <refsect1>
+    <refsect1 id="ldd-desc">
       <title>Description</title>
       <para><command>ldd</command> prints the shared libraries (DLLs) loaded
       when running an executable or DLL.</para>
 
-    <refsect2>
+    <refsect2 id="ldd-desc-security">
       <title>Security</title>
       <para>
 	<command>ldd</command> invokes the Windows loader on the file specified,
@@ -791,7 +791,7 @@ locale [-iusfnU]
       </screen>
     </refsynopsisdiv>
 
-    <refsect1>
+    <refsect1  id="locale-options">
       <title>Options</title>
       <screen>
 System information:
@@ -822,7 +822,7 @@ Other options:
 </screen>
     </refsect1>
 
-    <refsect1>
+    <refsect1 id="locale-desc">
       <title>Description</title>
     <para><command>locale</command> without parameters prints information about
       the current locale environment settings.</para>
@@ -969,7 +969,7 @@ minidumper [OPTION] FILENAME WIN32PID
       </screen>
     </refsynopsisdiv>
 
-    <refsect1>
+    <refsect1 id="minidumper-options">
       <title>Options</title>
       <screen>
 -t, --type     minidump type flags
@@ -981,7 +981,7 @@ minidumper [OPTION] FILENAME WIN32PID
   </screen>
     </refsect1>
 
-    <refsect1>
+    <refsect1 id="minidumper-desc">
       <title>Description</title>
   <para>
     The <command>minidumper</command> utility can be used to create a
@@ -1022,7 +1022,7 @@ mkgroup [OPTION]...
       </screen>
     </refsynopsisdiv>
 
-    <refsect1>
+    <refsect1 id="mkgroup-options">
       <title>Options</title>
       <screen>
 Options:
@@ -1053,7 +1053,7 @@ groups on domain controllers and domain member machines.
 </screen>
     </refsect1>
 
-    <refsect1>
+    <refsect1 id="mkgroup-desc">
       <title>Description</title>
      <para>Don't use this command to generate a local /etc/group file, unless you
      really need one.  See the Cygwin User's Guide for more information.
@@ -1126,7 +1126,7 @@ mkpasswd [OPTIONS]...
       </screen>
     </refsynopsisdiv>
 
-    <refsect1>
+    <refsect1 id="mkpasswd-options">
       <title>Options</title>
       <screen>
     Options:
@@ -1160,7 +1160,7 @@ on domain controllers and domain member machines.
 </screen>
     </refsect1>
 
-    <refsect1>
+    <refsect1 id="mkpasswd-desc">
       <title>Description</title>
     <para>Don't use this command to generate a local /etc/passwd file, unless you
     really need one.  See the Cygwin User's Guide for more information.</para>
@@ -1240,7 +1240,7 @@ mount &lt;posixpath&gt;
       </screen>
      </refsynopsisdiv>
 
-    <refsect1>
+    <refsect1 id="mount-options">
       <title>Options</title>
     <screen>
   -a, --all                     mount all filesystems mentioned in fstab
@@ -1256,7 +1256,7 @@ mount &lt;posixpath&gt;
 </screen>
     </refsect1>
 
-    <refsect1>
+    <refsect1 id="mount-desc">
       <title>Description</title>
     <para>The <command>mount</command> program is used to map your drives and
       shares onto Cygwin's simulated POSIX directory tree, much like as is done
@@ -1504,7 +1504,7 @@ passwd [OPTION] [USER]
       </screen>
     </refsynopsisdiv>
 
-    <refsect1>
+    <refsect1 id="passwd-options">
       <title>Options</title>
       <screen>
 User operations:
@@ -1550,7 +1550,7 @@ specifying an empty password.
 </screen>
     </refsect1>
 
-    <refsect1>
+    <refsect1 id="passwd-desc">
       <title>Description</title>
     <para> <command>passwd</command> changes passwords for user accounts. A
       normal user may only change the password for their own account, but
@@ -1665,7 +1665,7 @@ pldd [OPTION...] PID
       </screen>
     </refsynopsisdiv>
 
-    <refsect1>
+    <refsect1 id="pldd-options">
       <title>Options</title>
       <screen>
   -?, --help                 Give this help list
@@ -1674,7 +1674,7 @@ pldd [OPTION...] PID
 </screen>
     </refsect1>
 
-    <refsect1>
+    <refsect1 id="pldd-desc">
       <title>Description</title>
     <para><command>pldd</command> prints the shared libraries (DLLs) loaded by
       the process with the given PID.</para>
@@ -1699,7 +1699,7 @@ ps [-aefls] [-u UID]
       </screen>
     </refsynopsisdiv>
 
-    <refsect1>
+    <refsect1 id="ps-options">
       <title>Options</title>
       <screen>
  -a, --all       show processes of all users
@@ -1716,7 +1716,7 @@ With no options, ps outputs the long format by default
 </screen>
     </refsect1>
 
-    <refsect1>
+    <refsect1 id="ps-desc">
       <title>Description</title>
     <para>The <command>ps</command> program gives the status of all the Cygwin
       processes running on the system (ps = "process status"). Due to the
@@ -1772,7 +1772,7 @@ regtool [OPTION] (add|check|get|list|remove|unset|load|unload|save) KEY
       </screen>
     </refsynopsisdiv>
 
-    <refsect1>
+    <refsect1 id="regtool-options">
       <title>Options</title>
       <screen>
 Actions:
@@ -1844,7 +1844,7 @@ Example: regtool get '\user\software\Microsoft\Clock\iFormat'
 </screen>
     </refsect1>
 
-    <refsect1>
+    <refsect1 id="regtool-desc">
       <title>Description</title>
     <para>The <command>regtool</command> program allows shell scripts to access
       and modify the Windows registry. Note that modifying the Windows registry
@@ -1963,7 +1963,7 @@ setfacl [-n] {[-bk]|[-x acl_entries] [-m acl_entries]} FILE...
       </screen>
      </refsynopsisdiv>
 
-    <refsect1>
+    <refsect1 id="setfacl-options">
       <title>Options</title>
       <screen>
   -b, --remove-all       remove all extended ACL entries\n"
@@ -1982,7 +1982,7 @@ At least one of (-b, -x, -f, -k, -m, -s) must be specified\n"
 </screen>
     </refsect1>
 
-    <refsect1>
+    <refsect1 id="setfacl-desc">
       <title>Description</title>
     <para> For each file given as parameter, <command>setfacl</command> will
       either replace its complete ACL (<literal>-s</literal>,
@@ -2111,7 +2111,7 @@ setmetamode [metabit|escprefix]
       </screen>
     </refsynopsisdiv>
 
-    <refsect1>
+    <refsect1 id="setmetamode-options">
       <title>Options</title>
       <screen>
   Without argument, it shows the current meta key mode.
@@ -2126,7 +2126,7 @@ Other options:
 </screen>
     </refsect1>
 
-    <refsect1>
+    <refsect1 id="setmetamode-desc">
       <title>Description</title>
     <para><command>setmetamode</command> can be used to determine and set the
       key code sent by the meta (aka <literal>Alt</literal>) key.</para>
@@ -2151,7 +2151,7 @@ ssp [options] low_pc high_pc command...
       </screen>
     </refsynopsisdiv>
 
-    <refsect1>
+    <refsect1 id="ssp-options">
       <title>Options</title>
       <screen>
  -c, --console-trace  trace every EIP value to the console. *Lots* slower.
@@ -2173,7 +2173,7 @@ Example: ssp 0x401000 0x403000 hello.exe
 </screen>
     </refsect1>
 
-    <refsect1>
+    <refsect1 id="ssp-desc">
       <title>Description</title>
     <para> SSP - The Single Step Profiler </para>
 
@@ -2326,7 +2326,7 @@ strace [OPTIONS] -p &lt;pid&gt;
       </screen>
     </refsynopsisdiv>
 
-    <refsect1>
+    <refsect1  id="strace-options">
       <title>Options</title>
       <screen>
   -b, --buffer-size=SIZE       set size of output file buffer
@@ -2381,7 +2381,7 @@ strace [OPTIONS] -p &lt;pid&gt;
 </screen>
     </refsect1>
 
-    <refsect1>
+    <refsect1  id="strace-desc">
       <title>Description</title>
     <para>The <command>strace</command> program executes a program, and
       optionally the children of the program, reporting any Cygwin DLL output
@@ -2420,7 +2420,7 @@ tzset [OPTION]
       </screen>
     </refsynopsisdiv>
 
-    <refsect1>
+    <refsect1 id="tzset-options">
       <title>Options</title>
       <screen>
 Options:
@@ -2429,7 +2429,7 @@ Options:
       </screen>
     </refsect1>
 
-    <refsect1>
+    <refsect1 id="tzset-desc">
       <title>Description</title>
       Use tzset to set your TZ variable. In POSIX-compatible shells like bash,
       dash, mksh, or zsh:
@@ -2466,7 +2466,7 @@ umount [OPTION] [&lt;posixpath&gt;]
       </screen>
     </refsynopsisdiv>
 
-    <refsect1>
+    <refsect1 id="umount-options">
       <title>Options</title>
       <screen>
   -h, --help                    output usage information and exit
@@ -2475,7 +2475,7 @@ umount [OPTION] [&lt;posixpath&gt;]
 </screen>
     </refsect1>
 
-    <refsect1>
+    <refsect1 id="umount-desc">
       <title>Description</title>
     <para>The <command>umount</command> program removes mounts from the mount
       table in the current session. If you specify a POSIX path that
-- 
2.8.3
