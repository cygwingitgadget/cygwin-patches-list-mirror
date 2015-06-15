Return-Path: <cygwin-patches-return-8155-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 112635 invoked by alias); 15 Jun 2015 12:37:09 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 112510 invoked by uid 89); 15 Jun 2015 12:37:08 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=0.1 required=5.0 tests=AWL,BAYES_50,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=no version=3.3.2
X-HELO: rgout06.bt.lon5.cpcloud.co.uk
Received: from rgout06.bt.lon5.cpcloud.co.uk (HELO rgout06.bt.lon5.cpcloud.co.uk) (65.20.0.183) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 15 Jun 2015 12:37:02 +0000
X-OWM-Source-IP: 86.141.128.210(GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-CTCH-RefID: str=0001.0A090204.557EC6EC.0072,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-Junkmail-Premium-Raw: score=27/50,refid=2.7.2:2015.6.15.101816:17:27.888,ip=86.141.128.210,rules=__HAS_FROM, __TO_MALFORMED_2, __TO_NO_NAME, __SUBJ_ALPHA_END, __HAS_MSGID, __SANE_MSGID, __HAS_X_MAILER, __IN_REP_TO, __REFERENCES, __ANY_URI, __MAL_TELEKOM_URI, __PHISH_SPEAR_PASSWORD_2, __OEM_PHRASE, __FRAUD_CONTACT_NAME, __CP_URI_IN_BODY, __SUBJ_ALPHA_NEGATE, BODY_SIZE_10000_PLUS, __MIME_TEXT_ONLY, RDNS_GENERIC_POOLED, __URI_NS, SXL_IP_DYNAMIC[210.128.141.86.fur], HTML_00_01, HTML_00_10, RDNS_SUSP_GENERIC, RDNS_SUSP, REFERENCES
X-CTCH-Spam: Unknown
Received: from localhost.localdomain (86.141.128.210) by rgout06.bt.lon5.cpcloud.co.uk (8.6.122.06) (authenticated as jonturney@btinternet.com)        id 557EACF6000502FC; Mon, 15 Jun 2015 13:37:00 +0100
From: Jon TURNEY <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon TURNEY <jon.turney@dronecode.org.uk>
Subject: [PATCH 3/8] winsup/doc: Some preparatory XML fixes
Date: Mon, 15 Jun 2015 12:37:00 -0000
Message-Id: <1434371793-3980-4-git-send-email-jon.turney@dronecode.org.uk>
In-Reply-To: <1434371793-3980-1-git-send-email-jon.turney@dronecode.org.uk>
References: <1434371793-3980-1-git-send-email-jon.turney@dronecode.org.uk>
X-SW-Source: 2015-q2/txt/msg00057.txt.bz2

Remove the inconsistent .exe suffix in strace and umount usage lines.

Consistently refer to cross-references outside utils.xml as being in the Cygwin
User's Guide.  This helps to generate sensible looking references in generated
manpages.

Tidy up some trailing whitespace.

Tabs inside <screen> are not consistently formatted by all formatters, replace
with spaces.

Remove pointlesss and incorrect date

2015-06-12  Jon Turney  <jon.turney@dronecode.org.uk>

	* cygwin-ug-net.xml: Remove incorrect unused date.
	* utils.xml : Remove .exe suffix inconsistently added in a few
	places.  Consistently refer to cross-references outside this file
	as in the Cygwin User's Guide.  Tidy up some trailing whitespace.

Signed-off-by: Jon TURNEY <jon.turney@dronecode.org.uk>
---
 winsup/doc/ChangeLog         |  7 +++++
 winsup/doc/cygwin-ug-net.xml |  1 -
 winsup/doc/utils.xml         | 74 +++++++++++++++++++++++---------------------
 3 files changed, 45 insertions(+), 37 deletions(-)

diff --git a/winsup/doc/ChangeLog b/winsup/doc/ChangeLog
index aac7b3d..46a7908 100644
--- a/winsup/doc/ChangeLog
+++ b/winsup/doc/ChangeLog
@@ -1,5 +1,12 @@
 2015-06-12  Jon Turney  <jon.turney@dronecode.org.uk>
 
+	* cygwin-ug-net.xml: Remove incorrect unused date.
+	* utils.xml : Remove .exe suffix inconsistently added in a few
+	places.  Consistently refer to cross-references outside this file
+	as in the Cygwin User's Guide.  Tidy up some trailing whitespace.
+
+2015-06-12  Jon Turney  <jon.turney@dronecode.org.uk>
+
 	* xidepend: Fix to handle relative pathnames.
 
 2015-06-12  Jon Turney  <jon.turney@dronecode.org.uk>
diff --git a/winsup/doc/cygwin-ug-net.xml b/winsup/doc/cygwin-ug-net.xml
index 89526d7..f8b40e6 100644
--- a/winsup/doc/cygwin-ug-net.xml
+++ b/winsup/doc/cygwin-ug-net.xml
@@ -4,7 +4,6 @@
 
 <book id="cygwin-ug-net" xmlns:xi="http://www.w3.org/2001/XInclude">
   <bookinfo>
-    <date>2009-03-18</date>
     <title>Cygwin User's Guide</title>
 		<xi:include href="legal.xml"/>
   </bookinfo>
diff --git a/winsup/doc/utils.xml b/winsup/doc/utils.xml
index 673da3b..fcecd11 100644
--- a/winsup/doc/utils.xml
+++ b/winsup/doc/utils.xml
@@ -74,8 +74,8 @@ Note: -c, -f, and -l only report on packages that are currently installed. To
       <command>dpkg</command> or <command>rpm</command>,
       <command>cygcheck</command> is similar in many ways. (The major
       difference is that <command>setup.exe</command> handles installing and
-      uninstalling packages; see <xref linkend="internet-setup"/> for more
-      information.) </para>
+      uninstalling packages; see <xref linkend="internet-setup"/> in the Cygwin
+      User's Guide for more information.) </para>
     <para> The <literal>-c</literal> option checks the version and status of
       installed Cygwin packages. If you specify one or more package names,
       <command>cygcheck</command> will limit its output to those packages, or
@@ -265,9 +265,9 @@ are unable to find another Cygwin DLL.
 
     <screen>
 Usage: cygpath (-d|-m|-u|-w|-t TYPE) [-f FILE] [OPTION]... NAME...
-       cygpath [-c HANDLE] 
-       cygpath [-ADHOPSW] 
-       cygpath [-F ID] 
+       cygpath [-c HANDLE]
+       cygpath [-ADHOPSW]
+       cygpath [-F ID]
 
 Convert Unix and Windows format paths, or output system path information
 
@@ -340,7 +340,8 @@ Other options:
       options. The default is to use the character set of the current locale
       defined by one of the internationalization environment variables
       <envar>LC_ALL</envar>, <envar>LC_CTYPE</envar>, or <envar>LANG</envar>,
-      see <xref linkend="setup-locale"/>. This is sometimes not sufficient for
+      (See <xref linkend="setup-locale"/> in the Cygwin User's Guide).
+      This is sometimes not sufficient for
       interaction with native Windows tools, which might expect native,
       non-ASCII characters in a specific Windows codepage. Console tools, for
       instance, might expect pathnames in the current OEM codepage, while
@@ -518,7 +519,7 @@ Other options:
 Usage: getfacl [-adn] FILE [FILE2...]
 
 Display file and directory access control lists (ACLs).
- 
+
   -a, --access   display the file access control list
   -d, --default  display the default access control list
   -h, --help     print help explaining the command line options
@@ -928,7 +929,7 @@ groups on domain controllers and domain member machines.
       of your current account apply.  The <literal>-l/-L</literal> when used
       with a machine name, tries to contact that machine to enumerate local
       groups of other machines, typically outside of domains.  This scenario
-      cannot be covered by Cygwin's account automatism.  If you want to use 
+      cannot be covered by Cygwin's account automatism.  If you want to use
       the <literal>-L</literal> option, but you don't like the default
       domain/group separator from <filename>/etc/nsswitch.conf</filename>,
       you can specify another separator using the <literal>-S</literal> option,
@@ -1025,7 +1026,7 @@ on domain controllers and domain member machines.
 
     <para>For very simple needs, an entry for the current user can be created
       by using the option <literal>-c</literal>.</para>
-      
+
     <para>The <literal>-o</literal> option allows for special cases (such as
       multiple domains) where the UIDs might match otherwise. The
       <literal>-p</literal> option causes <command>mkpasswd</command> to use
@@ -1074,7 +1075,8 @@ Display information about mounted filesystems, or mount a filesystem
       points given in <filename>/etc/fstab</filename>, mount points created or
       changed with <command>mount</command> are not persistent. They disappear
       immediately after the last process of the current user exited. Please see
-      <xref linkend="mount-table"/> for more information on the concepts behind
+      <xref linkend="mount-table"/> in the Cygwin User's Guide for more
+      information on the concepts behind
       the Cygwin POSIX file system and strategies for using mounts. To remove
       mounts temporarily, use <command>umount</command></para>
 
@@ -1144,22 +1146,22 @@ D: on /d type fat (binary,user,noumount)
                implement real POSIX permissions (default).
   binary     - Files default to binary mode (default).
   bind       - Allows to remount part of the file hierarchy somewhere else.
-               Different from other mount calls, the first argument 
-	       specifies an absolute POSIX path, rather than a Win32 path.
-	       This POSIX path is remounted to the POSIX path specified as
-	       the second parameter.  The conversion to a Win32 path is done
-	       within Cygwin immediately at the time of the call.  Note that
-	       symlinks are ignored while performing this path conversion.
+               Different from other mount calls, the first argument
+               specifies an absolute POSIX path, rather than a Win32 path.
+               This POSIX path is remounted to the POSIX path specified as
+               the second parameter.  The conversion to a Win32 path is done
+               within Cygwin immediately at the time of the call.  Note that
+               symlinks are ignored while performing this path conversion.
   cygexec    - Treat all files below mount point as cygwin executables.
   dos        - Always convert leading spaces and trailing dots and spaces to
-	       characters in the UNICODE private use area.  This allows to use
-	       broken filesystems which only allow DOS filenames, even if they
-	       are not recognized as such by Cygwin.
+               characters in the UNICODE private use area.  This allows to use
+               broken filesystems which only allow DOS filenames, even if they
+               are not recognized as such by Cygwin.
   exec       - Treat all files below mount point as executable.
   ihash      - Always fake inode numbers rather than using the ones returned
-	       by the filesystem.  This allows to use broken filesystems which
-	       don't return unambiguous inode numbers, even if they are not
-	       recognized as such by Cygwin.
+               by the filesystem.  This allows to use broken filesystems which
+               don't return unambiguous inode numbers, even if they are not
+               recognized as such by Cygwin.
   noacl      - Ignore ACLs and fake POSIX permissions.
   nosuid     - No suid files are allowed (currently unimplemented)
   notexec    - Treat all files below mount point as not executable.
@@ -1168,13 +1170,13 @@ D: on /d type fat (binary,user,noumount)
   posix=1    - Switch on case sensitivity for paths under this mount point
                (default).
   sparse     - Switch on support for sparse files.  This option only makes
-	       sense on NTFS and then only if you really need sparse files.
+               sense on NTFS and then only if you really need sparse files.
   text       - Files default to CRLF text mode line endings.
 </screen>
 
       <para>For a more complete description of the mount options and the
         <filename>/etc/fstab</filename> file, see <xref linkend="mount-table"
-        />.</para>
+        />in the Cygwin User's Guide.</para>
 
       <para>Note that all mount points added with <command>mount</command> are
         user mount points. System mount points can only be specified in the
@@ -1336,7 +1338,7 @@ Other options:
 
 If no option is given, change USER's password.  If no user name is given,
 operate on current user.  System operations must not be mixed with user
-operations.  Don't specify a USER when triggering a system operation. 
+operations.  Don't specify a USER when triggering a system operation.
 
 Don't specify a user or any other option together with the -R option.
 Non-Admin users can only store their password if cygserver is running.
@@ -1424,7 +1426,7 @@ specifying an empty password.
       with public key authentication and get a full qualified user token with
       all credentials for network access. However, the method has some
       drawbacks security-wise. This is explained in more detail in <xref
-      linkend="ntsec"/>.</para>
+      linkend="ntsec"/> in the Cygwin User's Guide.</para>
 
     <para>Please note that storing passwords in that registry area is a
       privileged operation which only administrative accounts are allowed to
@@ -1590,7 +1592,7 @@ remote host in either \\hostname or hostname: format and prefix is any of:
 
 You can use forward slash ('/') as a separator instead of backslash, in
 that case backslash is treated as escape character
-Example: regtool.exe get '\user\software\Microsoft\Clock\iFormat'
+Example: regtool get '\user\software\Microsoft\Clock\iFormat'
 </screen>
 
     <para>The <command>regtool</command> program allows shell scripts to access
@@ -1706,7 +1708,7 @@ Modify file and directory access control lists (ACLs)
   -f, --file       set ACL entries for FILE to ACL entries read
                    from a ACL_FILE
   -k, --remove-default
-		   remove all default ACL entries
+                   remove all default ACL entries
   -m, --modify     modify one or more specified ACL entries
   -r, --replace    replace mask entry with maximum permissions
                    needed for the file group class
@@ -1759,7 +1761,7 @@ At least one of (-b, -d, -f, -k, -m, -s) must be specified
       <screen>
          u[ser]:uid[:]
          g[roup]:gid[:]
-	 m[ask][:]
+         m[ask][:]
          d[efault]:u[ser][:uid]
          d[efault]:g[roup][:gid]
          d[efault]:m[ask][:]
@@ -1995,8 +1997,8 @@ $ ssp <literal>-v</literal> <literal>-s</literal> <literal>-l</literal> <literal
     <title>strace</title>
 
     <screen>
-Usage: strace.exe [OPTIONS] &lt;command-line&gt;
-Usage: strace.exe [OPTIONS] -p &lt;pid&gt;
+Usage: strace [OPTIONS] &lt;command-line&gt;
+Usage: strace [OPTIONS] -p &lt;pid&gt;
 
 Trace system calls and signals
 
@@ -2013,7 +2015,7 @@ Trace system calls and signals
   -q, --quiet                  toggle "quiet" flag.  Defaults to on if "-p",
                                off otherwise.
   -S, --flush-period=PERIOD    flush buffered strace output every PERIOD secs
-  -t, --timestamp              use an absolute hh:mm:ss timestamp insted of 
+  -t, --timestamp              use an absolute hh:mm:ss timestamp insted of
                                the default microsecond timestamp.  Implies -d
   -T, --toggle                 toggle tracing in a process already being
                                traced. Requires -p &lt;pid&gt;
@@ -2034,7 +2036,7 @@ Trace system calls and signals
     uhoh     0x000008 (_STRACE_UHOH)     Unusual or weird phenomenon.
     syscall  0x000010 (_STRACE_SYSCALL)  System calls.
     startup  0x000020 (_STRACE_STARTUP)  argc/envp printout at startup.
-    debug    0x000040 (_STRACE_DEBUG)    Info to help debugging. 
+    debug    0x000040 (_STRACE_DEBUG)    Info to help debugging.
     paranoid 0x000080 (_STRACE_PARANOID) Paranoid info.
     termios  0x000100 (_STRACE_TERMIOS)  Info for debugging termios stuff.
     select   0x000200 (_STRACE_SELECT)   Info on ugly select internals.
@@ -2103,7 +2105,7 @@ In csh-compatible shells like tcsh:
     <title>umount</title>
 
     <screen>
-Usage: umount.exe [OPTION] [&lt;posixpath&gt;]
+Usage: umount [OPTION] [&lt;posixpath&gt;]
 
 Unmount filesystems
 
@@ -2119,8 +2121,8 @@ Unmount filesystems
       user mount points. The <literal>-U</literal> flag may be used to specify
       removing all user mount points from the current user session.</para>
 
-    <para>See <xref linkend="mount-table"/> for more information on the mount
-      table.</para>
+    <para>See <xref linkend="mount-table"/> in the Cygwin User's Guide for more
+      information on the mount table.</para>
   </sect2>
 
 </sect1>
-- 
2.1.4
