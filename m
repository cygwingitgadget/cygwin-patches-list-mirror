Return-Path: <jon.turney@dronecode.org.uk>
Received: from re-prd-fep-045.btinternet.com (mailomta23-re.btinternet.com
 [213.120.69.116])
 by sourceware.org (Postfix) with ESMTPS id 6EB9E393A439
 for <cygwin-patches@cygwin.com>; Wed, 16 Jun 2021 16:20:15 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 6EB9E393A439
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=dronecode.org.uk
Received: from re-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.54.5])
 by re-prd-fep-045.btinternet.com with ESMTP id
 <20210616162014.IRPB16557.re-prd-fep-045.btinternet.com@re-prd-rgout-002.btmx-prd.synchronoss.net>;
 Wed, 16 Jun 2021 17:20:14 +0100
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 5ED9C0CC37B36E1C
X-Originating-IP: [86.139.156.26]
X-OWM-Source-IP: 86.139.156.26 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduledrfedvledgleekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeefieduveehgfffffeuueehleefgeevfedvffeljeefheduteelteelvdettefhvdenucfkphepkeeirddufeelrdduheeirddvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddufeelrdduheeirddviedpmhgrihhlfhhrohhmpeeojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqpdhrtghpthhtohepoegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmqedprhgtphhtthhopeeojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.139.156.26) by
 re-prd-rgout-002.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9C0CC37B36E1C; Wed, 16 Jun 2021 17:20:14 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 1/2] Cygwin: Various minor fixes to utils documentation
Date: Wed, 16 Jun 2021 17:19:17 +0100
Message-Id: <20210616161918.41015-2-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210616161918.41015-1-jon.turney@dronecode.org.uk>
References: <20210616161918.41015-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1198.7 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 GIT_PATCH_0, KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY,
 RCVD_IN_BARRACUDACENTRAL, RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H4,
 RCVD_IN_MSPIKE_WL, SPF_HELO_PASS, SPF_NONE,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Wed, 16 Jun 2021 16:20:17 -0000

* Drop duplicate 'Options:' headers (mkgroup, mkpassword)
* Add missing indication that MACHINE is optional with -L (mkgroup, mkpassword)
* Tweak some <refpurpose> which try to be a synopsis, rather than a decription (passwd, ssp)
* Drop some stray '\n' in setfacl options
* Move 'Original Author' note in ssp to an AUTHORS section
* Use <para> to improve formatting of tzset manpage
---
 winsup/doc/utils.xml | 51 +++++++++++++++++++++++---------------------
 1 file changed, 27 insertions(+), 24 deletions(-)

diff --git a/winsup/doc/utils.xml b/winsup/doc/utils.xml
index 82069edc7..55594ef5f 100644
--- a/winsup/doc/utils.xml
+++ b/winsup/doc/utils.xml
@@ -1167,13 +1167,11 @@ mkgroup [OPTION]...
     <refsect1 id="mkgroup-options">
       <title>Options</title>
       <screen>
-Options:
-
    -l,--local [machine]    Print local group accounts of \"machine\",
                            from local machine if no machine specified.
                            Automatically adding machine prefix for local
                            machine depends on settings in /etc/nsswitch.conf.
-   -L,--Local machine      Ditto, but generate groupname with machine prefix.
+   -L,--Local [machine]    Ditto, but generate groupname with machine prefix.
    -d,--domain [domain]    Print domain groups,
                            from current domain if no domain specified.
    -c,--current            Print current group.
@@ -1271,13 +1269,11 @@ mkpasswd [OPTIONS]...
     <refsect1 id="mkpasswd-options">
       <title>Options</title>
       <screen>
-    Options:
-
    -l,--local [machine]    Print local user accounts of \"machine\",
                            from local machine if no machine specified.
                            Automatically adding machine prefix for local
                            machine depends on settings in /etc/nsswitch.conf.
-   -L,--Local machine      Ditto, but generate username with machine prefix.
+   -L,--Local [machine]    Ditto, but generate username with machine prefix.
    -d,--domain [domain]    Print domain accounts,
                            from current domain if no domain specified.
    -c,--current            Print current user.
@@ -1637,7 +1633,7 @@ D: on /d type fat (binary,user,noumount)
 
     <refnamediv>
       <refname>passwd</refname>
-      <refpurpose>Change USER's password or password attributes.</refpurpose>
+      <refpurpose>Change password or password attributes</refpurpose>
     </refnamediv>
 
     <refsynopsisdiv>
@@ -2111,19 +2107,19 @@ setfacl [-n] {[-bk]|[-x acl_entries] [-m acl_entries]} FILE...
     <refsect1 id="setfacl-options">
       <title>Options</title>
       <screen>
-  -b, --remove-all       remove all extended ACL entries\n"
-  -x, --delete           delete one or more specified ACL entries\n"
-  -f, --set-file         set ACL entries for FILE to ACL entries read\n"
-                         from ACL_FILE\n"
-  -k, --remove-default   remove all default ACL entries\n"
-  -m, --modify           modify one or more specified ACL entries\n"
-  -n, --no-mask          don't recalculate the effective rights mask\n"
-      --mask             do recalculate the effective rights mask\n"
-  -s, --set              set specified ACL entries on FILE\n"
-  -V, --version          print version and exit\n"
-  -h, --help             this help text\n"
-
-At least one of (-b, -x, -f, -k, -m, -s) must be specified\n"
+  -b, --remove-all       remove all extended ACL entries
+  -x, --delete           delete one or more specified ACL entries
+  -f, --set-file         set ACL entries for FILE to ACL entries read
+                         from ACL_FILE
+  -k, --remove-default   remove all default ACL entries
+  -m, --modify           modify one or more specified ACL entries
+  -n, --no-mask          don't recalculate the effective rights mask
+      --mask             do recalculate the effective rights mask
+  -s, --set              set specified ACL entries on FILE
+  -V, --version          print version and exit
+  -h, --help             this help text
+
+At least one of (-b, -x, -f, -k, -m, -s) must be specified
 </screen>
     </refsect1>
 
@@ -2285,9 +2281,17 @@ Other options:
       <refmiscinfo class="manual">Cygwin Utilities</refmiscinfo>
     </refmeta>
 
+    <refentryinfo>
+      <author>
+	<firstname>DJ</firstname>
+	<surname>Delorie</surname>
+	<contrib>Original Author</contrib>
+      </author>
+    </refentryinfo>
+
     <refnamediv>
       <refname>ssp</refname>
-      <refpurpose>Single-step profile COMMAND</refpurpose>
+      <refpurpose>The Single Step Profiler</refpurpose>
     </refnamediv>
 
     <refsynopsisdiv>
@@ -2320,9 +2324,6 @@ Example: ssp 0x401000 0x403000 hello.exe
 
     <refsect1 id="ssp-desc">
       <title>Description</title>
-    <para> SSP - The Single Step Profiler </para>
-
-    <para> Original Author: DJ Delorie </para>
 
     <para> The SSP is a program that uses the Win32 debug API to run a program
       one ASM instruction at a time. It records the location of each
@@ -2576,6 +2577,7 @@ Options:
 
     <refsect1 id="tzset-desc">
       <title>Description</title>
+      <para>
       Use tzset to set your TZ variable. In POSIX-compatible shells like bash,
       dash, mksh, or zsh:
       <screen>
@@ -2585,6 +2587,7 @@ export TZ=$(tzset)
       <screen>
 setenv TZ `tzset`
       </screen>
+      </para>
 
     <para>The <command>tzset</command> tool reads the current timezone from
       Windows and generates a POSIX-compatible timezone information for the TZ
-- 
2.31.1

