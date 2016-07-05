Return-Path: <cygwin-patches-return-8593-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23405 invoked by alias); 5 Jul 2016 10:08:26 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 23358 invoked by uid 89); 5 Jul 2016 10:08:25 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-0.2 required=5.0 tests=AWL,BAYES_50,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW autolearn=no version=3.3.2 spammy=owners, HX-CTCH-RefID:1,fgs, HX-CTCH-RefID:0.000,reip, HX-CTCH-RefID:sk:0001.0A
X-HELO: rgout04.bt.lon5.cpcloud.co.uk
Received: from rgout04.bt.lon5.cpcloud.co.uk (HELO rgout04.bt.lon5.cpcloud.co.uk) (65.20.0.181) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 05 Jul 2016 10:08:15 +0000
X-OWM-Source-IP: 86.179.112.53 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-CTCH-RefID: str=0001.0A090203.577B870D.000B,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-Junkmail-Premium-Raw: score=27/50,refid=2.7.2:2016.7.4.165416:17:27.888,ip=86.179.112.53,rules=__HAS_FROM, __TO_MALFORMED_2, __TO_NO_NAME, __HAS_CC_HDR, __HAS_MSGID, __SANE_MSGID, __HAS_X_MAILER, __IN_REP_TO, __REFERENCES, __ANY_URI, __URI_NO_WWW, __FRAUD_MONEY_CURRENCY_DOLLAR, __SUBJ_ALPHA_NEGATE, BODY_SIZE_3000_3999, __MIME_TEXT_ONLY, RDNS_GENERIC_POOLED, __URI_NS, SXL_IP_DYNAMIC[53.112.179.86.fur], HTML_00_01, HTML_00_10, __FRAUD_MONEY_CURRENCY, BODY_SIZE_5000_LESS, RDNS_SUSP_GENERIC, MULTIPLE_RCPTS_RND, RDNS_SUSP, IN_REP_TO, REFERENCES, BODY_SIZE_7000_LESS, NO_URI_HTTPS, MSG_THREAD, LEGITIMATE_NEGATE
X-CTCH-Spam: Unknown
Received: from localhost.localdomain (86.179.112.53) by rgout04.bt.lon5.cpcloud.co.uk (8.6.122.06) (authenticated as jonturney@btinternet.com)        id 57764D230097E7FE; Tue, 5 Jul 2016 11:08:12 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 1/3] Use <example> tag at same level as <para>, not inside it
Date: Tue, 05 Jul 2016 10:08:00 -0000
Message-Id: <20160705100752.6684-2-jon.turney@dronecode.org.uk>
In-Reply-To: <20160705100752.6684-1-jon.turney@dronecode.org.uk>
References: <20160705100752.6684-1-jon.turney@dronecode.org.uk>
X-SW-Source: 2016-q3/txt/msg00001.txt.bz2

In Cygwin utils documentation, use the <example> tag at same level as
<para>, not inside it.

This improves the generated manpages.

Signed-off-by: Jon Turney <jon.turney@dronecode.org.uk>
---
 winsup/doc/utils.xml | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/winsup/doc/utils.xml b/winsup/doc/utils.xml
index 08a24f7..4853d92 100644
--- a/winsup/doc/utils.xml
+++ b/winsup/doc/utils.xml
@@ -102,7 +102,10 @@ Note: -c, -f, and -l only report on packages that are currently installed. To
     <para> The <literal>-f</literal> option helps you to track down which
       package a file came from, and <literal>-l</literal> lists all files in a
       package. For example, to find out about
-      <filename>/usr/bin/less</filename> and its package: <example
+      <filename>/usr/bin/less</filename> and its package:
+    </para>
+
+    <example
       id="utils-cygcheck-ex"><title>Example <command>cygcheck</command>
       usage</title>
       <screen>
@@ -116,7 +119,7 @@ $ cygcheck -l less
 /usr/man/man1/less.1
 /usr/man/man1/lesskey.1
 </screen>
-      </example> </para>
+      </example>
 
     <para>The <literal>-h</literal> option prints additional helpful messages
       in the report, at the beginning of each section. It also adds table
@@ -150,7 +153,9 @@ $ cygcheck -l less
 
     <para>For example, perhaps you are getting an error because you are missing
       a certain DLL and you want to know which package includes that file:
-      <example id="utils-search-ex"><title>Searching all packages for a
+    </para>
+
+    <example id="utils-search-ex"><title>Searching all packages for a
       file</title>
       <screen>
 $ cygcheck -p 'cygintl-2\.dll'
@@ -170,7 +175,7 @@ Found 2 matches for '/ls\.exe'.
 coreutils-5.2.1-5         GNU core utilities (includes fileutils, sh-utils and textutils)
 coreutils-5.3.0-6         GNU core utilities (includes fileutils, sh-utils and textutils)
 </screen>
-      </example> </para>
+      </example>
 
     <para>Note that this option takes a regular expression, not a glob or
       wildcard. This means that you need to use <literal>.*</literal> if you
@@ -1168,19 +1173,25 @@ on domain controllers and domain member machines.
       multiple domains) where the UIDs might match otherwise. The
       <literal>-p</literal> option causes <command>mkpasswd</command> to use
       the specified prefix instead of the account home dir or <literal>/home/
-      </literal>. For example, this command: <example id="utils-althome-ex"
+      </literal>. For example, this command:
+    </para>
+
+    <example id="utils-althome-ex"
       ><title>Using an alternate home root</title>
       <screen>
 <prompt>$</prompt> <userinput>mkpasswd -l -p "$(cygpath -H)" &gt; /etc/passwd</userinput>
 </screen>
-      </example> would put local users' home directories in the Windows
+    </example>
+
+    <para>
+      would put local users' home directories in the Windows
       'Profiles' directory. The <literal>-u</literal> option creates just an
       entry for the specified user. The <literal>-U</literal> option allows you
       to enumerate the standard UNIX users on a Samba machine. It's used
       together with <literal>-l samba-server</literal> or <literal>-L
       samba-server</literal>. The normal UNIX users are usually not enumerated,
       but they can show up as file owners in <command>ls -l</command> output.
-      </para>
+    </para>
     </refsect1>
   </refentry>
 
-- 
2.8.3
