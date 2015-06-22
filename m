Return-Path: <cygwin-patches-return-8204-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 127725 invoked by alias); 22 Jun 2015 14:40:37 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 127714 invoked by uid 89); 22 Jun 2015 14:40:36 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=0.5 required=5.0 tests=AWL,BAYES_50,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=no version=3.3.2
X-HELO: rgout0207.bt.lon5.cpcloud.co.uk
Received: from rgout0207.bt.lon5.cpcloud.co.uk (HELO rgout0207.bt.lon5.cpcloud.co.uk) (65.20.0.206) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 22 Jun 2015 14:40:33 +0000
X-OWM-Source-IP: 86.141.128.210(GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-CTCH-RefID: str=0001.0A090203.55881E5E.0014,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-Junkmail-Premium-Raw: score=27/50,refid=2.7.2:2015.6.17.153616:17:27.888,ip=86.141.128.210,rules=__HAS_FROM, __TO_MALFORMED_2, __TO_NO_NAME, __SUBJ_ALPHA_END, __HAS_MSGID, __SANE_MSGID, __HAS_X_MAILER, __IN_REP_TO, __REFERENCES, __ANY_URI, __URI_NO_WWW, __URI_NO_PATH, __PHISH_SPEAR_PASSWORD_2, __FRAUD_CONTACT_NAME, __MIME_TEXT_ONLY, RDNS_GENERIC_POOLED, __URI_NS, SXL_IP_DYNAMIC[210.128.141.86.fur], HTML_00_01, HTML_00_10, RDNS_SUSP_GENERIC, RDNS_SUSP, REFERENCES
X-CTCH-Spam: Unknown
Received: from localhost.localdomain (86.141.128.210) by rgout02.bt.lon5.cpcloud.co.uk (8.6.122.06) (authenticated as jonturney@btinternet.com)        id 5581A14B00BE5B53; Mon, 22 Jun 2015 15:40:29 +0100
From: Jon TURNEY <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon TURNEY <jon.turney@dronecode.org.uk>
Subject: [PATCH 3/5] winsup/doc: Remove 'Usage' prefix from synopses
Date: Mon, 22 Jun 2015 14:40:00 -0000
Message-Id: <1434983976-3612-4-git-send-email-jon.turney@dronecode.org.uk>
In-Reply-To: <1434983976-3612-1-git-send-email-jon.turney@dronecode.org.uk>
References: <1434983976-3612-1-git-send-email-jon.turney@dronecode.org.uk>
X-SW-Source: 2015-q2/txt/msg00105.txt.bz2

Remove redundant 'Usage' prefix from synopses.

2015-06-22  Jon Turney  <jon.turney@dronecode.org.uk>

	* utils.xml: Remove 'Usage' prefix from synopses.

Signed-off-by: Jon TURNEY <jon.turney@dronecode.org.uk>
---
 winsup/doc/ChangeLog |  4 +++
 winsup/doc/utils.xml | 88 ++++++++++++++++++++++++++--------------------------
 2 files changed, 48 insertions(+), 44 deletions(-)

diff --git a/winsup/doc/ChangeLog b/winsup/doc/ChangeLog
index 1c944ad..ca3bac6 100644
--- a/winsup/doc/ChangeLog
+++ b/winsup/doc/ChangeLog
@@ -1,5 +1,9 @@
 2015-06-22  Jon Turney  <jon.turney@dronecode.org.uk>
 
+	* utils.xml: Remove 'Usage' prefix from synopses.
+
+2015-06-22  Jon Turney  <jon.turney@dronecode.org.uk>
+
 	* Makefile.in (intro2man.stamp): Add.
 	* intro.xml: New file.
 
diff --git a/winsup/doc/utils.xml b/winsup/doc/utils.xml
index efadbba..5d3df69 100644
--- a/winsup/doc/utils.xml
+++ b/winsup/doc/utils.xml
@@ -27,18 +27,18 @@
 
       <refsynopsisdiv>
 	<screen>
-Usage: cygcheck [-v] [-h] PROGRAM
-       cygcheck -c [-d] [PACKAGE]
-       cygcheck -s [-r] [-v] [-h]
-       cygcheck -k
-       cygcheck -f FILE [FILE]...
-       cygcheck -l [PACKAGE]...
-       cygcheck -p REGEXP
-       cygcheck --delete-orphaned-installation-keys
-       cygcheck --enable-unique-object-names Cygwin-DLL
-       cygcheck --disable-unique-object-names Cygwin-DLL
-       cygcheck --show-unique-object-names Cygwin-DLL
-       cygcheck -h
+cygcheck [-v] [-h] PROGRAM
+cygcheck -c [-d] [PACKAGE]
+cygcheck -s [-r] [-v] [-h]
+cygcheck -k
+cygcheck -f FILE [FILE]...
+cygcheck -l [PACKAGE]...
+cygcheck -p REGEXP
+cygcheck --delete-orphaned-installation-keys
+cygcheck --enable-unique-object-names Cygwin-DLL
+cygcheck --disable-unique-object-names Cygwin-DLL
+cygcheck --show-unique-object-names Cygwin-DLL
+cygcheck -h
 	</screen>
       </refsynopsisdiv>
 
@@ -291,10 +291,10 @@ are unable to find another Cygwin DLL.
 
     <refsynopsisdiv>
     <screen>
-Usage: cygpath (-d|-m|-u|-w|-t TYPE) [-f FILE] [OPTION]... NAME...
-       cygpath [-c HANDLE]
-       cygpath [-ADHOPSW]
-       cygpath [-F ID]
+cygpath (-d|-m|-u|-w|-t TYPE) [-f FILE] [OPTION]... NAME...
+cygpath [-c HANDLE]
+cygpath [-ADHOPSW]
+cygpath [-F ID]
     </screen>
     </refsynopsisdiv>
 
@@ -466,7 +466,7 @@ explorer $XPATH &
 
     <refsynopsisdiv>
       <screen>
-Usage: dumper [OPTION] FILENAME WIN32PID
+dumper [OPTION] FILENAME WIN32PID
       </screen>
     </refsynopsisdiv>
 
@@ -526,8 +526,8 @@ error_start=x:\path\to\dumper.exe
 
     <refsynopsisdiv>
       <screen>
-Usage: getconf [-v specification] variable_name [pathname]
-       getconf -a [pathname]
+getconf [-v specification] variable_name [pathname]
+getconf -a [pathname]
       </screen>
     </refsynopsisdiv>
 
@@ -590,7 +590,7 @@ Other options:
 
     <refsynopsisdiv>
       <screen>
-Usage: getfacl [-adn] FILE [FILE2...]
+getfacl [-adn] FILE [FILE2...]
       </screen>
     </refsynopsisdiv>
 
@@ -655,8 +655,8 @@ line separates the ACLs for each file.
 
     <refsynopsisdiv>
       <screen>
-Usage: kill [-f] [-signal] [-s signal] pid1 [pid2 ...]
-       kill -l [signal]
+kill [-f] [-signal] [-s signal] pid1 [pid2 ...]
+kill -l [signal]
       </screen>
     </refsynopsisdiv>
 
@@ -772,7 +772,7 @@ SIGUSR2     31    user defined signal 2
 
     <refsynopsisdiv>
       <screen>
-Usage: ldd [OPTION]... FILE...
+ldd [OPTION]... FILE...
       </screen>
     </refsynopsisdiv>
 
@@ -812,9 +812,9 @@ Usage: ldd [OPTION]... FILE...
 
     <refsynopsisdiv>
       <screen>
-Usage: locale [-amvhV]
-   or: locale [-ck] NAME
-   or: locale [-usfnU]
+locale [-amvhV]
+locale [-ck] NAME
+locale [-usfnU]
       </screen>
     </refsynopsisdiv>
 
@@ -977,7 +977,7 @@ bash$ locale noexpr
 
     <refsynopsisdiv>
       <screen>
-Usage: minidumper [OPTION] FILENAME WIN32PID
+minidumper [OPTION] FILENAME WIN32PID
       </screen>
     </refsynopsisdiv>
 
@@ -1030,7 +1030,7 @@ Usage: minidumper [OPTION] FILENAME WIN32PID
 
     <refsynopsisdiv>
       <screen>
-Usage: mkgroup [OPTION]...
+mkgroup [OPTION]...
       </screen>
     </refsynopsisdiv>
 
@@ -1134,7 +1134,7 @@ groups on domain controllers and domain member machines.
 
     <refsynopsisdiv>
       <screen>
-Usage: mkpasswd [OPTIONS]...
+mkpasswd [OPTIONS]...
       </screen>
     </refsynopsisdiv>
 
@@ -1240,9 +1240,9 @@ on domain controllers and domain member machines.
 
     <refsynopsisdiv>
       <screen>
-Usage: mount [OPTION] [&lt;win32path&gt; &lt;posixpath&gt;]
-       mount -a
-       mount &lt;posixpath&gt;
+mount [OPTION] [&lt;win32path&gt; &lt;posixpath&gt;]
+mount -a
+mount &lt;posixpath&gt;
       </screen>
      </refsynopsisdiv>
 
@@ -1507,7 +1507,7 @@ D: on /d type fat (binary,user,noumount)
 
     <refsynopsisdiv>
       <screen>
-Usage: passwd [OPTION] [USER]
+passwd [OPTION] [USER]
       </screen>
     </refsynopsisdiv>
 
@@ -1668,7 +1668,7 @@ specifying an empty password.
 
     <refsynopsisdiv>
       <screen>
-Usage: pldd [OPTION...] PID
+pldd [OPTION...] PID
       </screen>
     </refsynopsisdiv>
 
@@ -1702,7 +1702,7 @@ Usage: pldd [OPTION...] PID
 
     <refsynopsisdiv>
       <screen>
-Usage: ps [-aefls] [-u UID]
+ps [-aefls] [-u UID]
       </screen>
     </refsynopsisdiv>
 
@@ -1775,7 +1775,7 @@ With no options, ps outputs the long format by default
 
     <refsynopsisdiv>
       <screen>
-Usage: regtool [OPTION] (add|check|get|list|remove|unset|load|unload|save) KEY
+regtool [OPTION] (add|check|get|list|remove|unset|load|unload|save) KEY
       </screen>
     </refsynopsisdiv>
 
@@ -1965,8 +1965,8 @@ Example: regtool get '\user\software\Microsoft\Clock\iFormat'
 
     <refsynopsisdiv>
       <screen>
-Usage: setfacl [-r] {-f ACL_FILE | -s acl_entries} FILE...
-       setfacl [-r] {-b|[-d acl_entries] [-m acl_entries]} FILE...
+setfacl [-r] {-f ACL_FILE | -s acl_entries} FILE...
+setfacl [-r] {-b|[-d acl_entries] [-m acl_entries]} FILE...
       </screen>
      </refsynopsisdiv>
 
@@ -2101,7 +2101,7 @@ $ getfacl source_file | setfacl -f - target_file
 
     <refsynopsisdiv>
       <screen>
-Usage: setmetamode [metabit|escprefix]
+setmetamode [metabit|escprefix]
       </screen>
     </refsynopsisdiv>
 
@@ -2141,7 +2141,7 @@ Other options:
 
     <refsynopsisdiv>
       <screen>
-Usage: ssp [options] low_pc high_pc command...
+ssp [options] low_pc high_pc command...
       </screen>
     </refsynopsisdiv>
 
@@ -2315,8 +2315,8 @@ $ ssp <literal>-v</literal> <literal>-s</literal> <literal>-l</literal> <literal
 
     <refsynopsisdiv>
       <screen>
-Usage: strace [OPTIONS] &lt;command-line&gt;
-Usage: strace [OPTIONS] -p &lt;pid&gt;
+strace [OPTIONS] &lt;command-line&gt;
+strace [OPTIONS] -p &lt;pid&gt;
       </screen>
     </refsynopsisdiv>
 
@@ -2410,7 +2410,7 @@ $ strace -o tracing_output -w sh -c 'while true; do echo "tracing..."; done' &am
 
     <refsynopsisdiv>
       <screen>
-Usage: tzset [OPTION]
+tzset [OPTION]
       </screen>
     </refsynopsisdiv>
 
@@ -2456,7 +2456,7 @@ setenv TZ `tzset`
 
     <refsynopsisdiv>
       <screen>
-Usage: umount [OPTION] [&lt;posixpath&gt;]
+umount [OPTION] [&lt;posixpath&gt;]
       </screen>
     </refsynopsisdiv>
 
-- 
2.1.4
