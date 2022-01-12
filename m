Return-Path: <jon.turney@dronecode.org.uk>
Received: from re-prd-fep-045.btinternet.com (mailomta17-re.btinternet.com
 [213.120.69.110])
 by sourceware.org (Postfix) with ESMTPS id A8B2B3857C5C
 for <cygwin-patches@cygwin.com>; Wed, 12 Jan 2022 15:53:07 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org A8B2B3857C5C
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=dronecode.org.uk
Received: from re-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.54.5])
 by re-prd-fep-045.btinternet.com with ESMTP id
 <20220112155306.ZYUU16557.re-prd-fep-045.btinternet.com@re-prd-rgout-002.btmx-prd.synchronoss.net>;
 Wed, 12 Jan 2022 15:53:06 +0000
Authentication-Results: btinternet.com;
 auth=pass (LOGIN) smtp.auth=jonturney@btinternet.com;
 bimi=skipped
X-SNCR-Rigid: 613A8DE8103BFFDB
X-Originating-IP: [81.129.146.209]
X-OWM-Source-IP: 81.129.146.209 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvvddrtddugdehiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepfeeiieettedvfeekffdtleettdeuhfegvdefhfduvdefheffvdejueevfeelheeknecuffhomhgrihhnpegthihgfihinhdrtghomhdpshhouhhrtggvfigrrhgvrdhorhhgpdhgohhoghhlvgdrtghomhenucfkphepkedurdduvdelrddugeeirddvtdelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekuddruddvledrudegiedrvddtledpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomhdprhgtphhtthhopehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhk
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (81.129.146.209) by
 re-prd-rgout-002.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as
 jonturney@btinternet.com)
 id 613A8DE8103BFFDB; Wed, 12 Jan 2022 15:53:06 +0000
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH] Cygwin: doc: drop mention of 32-bit installer
Date: Wed, 12 Jan 2022 15:52:41 +0000
Message-Id: <20220112155241.1635-1-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1197.9 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 GIT_PATCH_0, KAM_DMARC_STATUS, KAM_EXEURI, KAM_LAZY_DOMAIN_SECURITY,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H3, RCVD_IN_MSPIKE_WL, SPF_HELO_PASS,
 SPF_NONE, TXREP autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
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
X-List-Received-Date: Wed, 12 Jan 2022 15:53:10 -0000

Drop mention of 32-bit installer, since it's offically discouraged, and
planned to be dropped soon.

Adjust various references to be something more generic, like 'the Cygwin
Setup program' to accomodate this.
---
 winsup/doc/faq-setup.xml | 12 +++----
 winsup/doc/setup-net.xml | 74 ++++++++++++++++------------------------
 2 files changed, 34 insertions(+), 52 deletions(-)

diff --git a/winsup/doc/faq-setup.xml b/winsup/doc/faq-setup.xml
index c04ffe9a5..740c6fefb 100644
--- a/winsup/doc/faq-setup.xml
+++ b/winsup/doc/faq-setup.xml
@@ -12,9 +12,8 @@
 
 <para>
 There is only one recommended way to install Cygwin, which is to use the
-Cygwin Setup program, a GUI installer named
-<command>setup-x86_64.exe</command> for 64 bit Windows, or
-<command>setup-x86.exe</command> for 32 bit Windows. It is flexible and easy to use.
+Cygwin Setup program, a GUI installer.
+It is flexible and easy to use.
 You can pick and choose the packages you wish to install, and update
 them individually.  Full source code is available for all packages and
 tools.
@@ -191,7 +190,6 @@ Here is how Cygwin secures the installation and update process to counter
 
 <orderedlist>
 <listitem><para>The Cygwin website provides the Cygwin Setup program
-(<literal>setup-x86.exe</literal> or <literal>setup-x86_64.exe</literal>)
 using HTTPS (SSL/TLS).
 This authenticates that the Cygwin Setup program
 came from the Cygwin website
@@ -261,8 +259,7 @@ widely-used SHA-2 suite of cryptographic hashes).
 
 <para>
 To best secure your installation and update process, download
-the Cygwin Setup program <filename>setup-x86_64.exe</filename> (64-bit) or
-<filename>setup-x86.exe</filename> (32-bit), and then
+the Cygwin Setup program, and then
 check its signature (using a signature-checking tool you trust)
 using the Cygwin public key
 (<ulink url="https://cygwin.com/key/pubring.asc"/>).
@@ -318,8 +315,7 @@ archives.  If this happens to you, consider disabling your anti-virus
 software when running the Cygwin Setup program.  The following procedure should be
 a fairly safe way to do that:
 </para>
-<orderedlist><listitem><para>Download <filename>setup-x86_64.exe</filename> or
-<filename>setup-x86.exe</filename> and scan it explicitly.
+<orderedlist><listitem><para>Download the Cygwin Setup program and scan it explicitly.
 </para>
 </listitem>
 <listitem><para>Turn off the anti-virus software.
diff --git a/winsup/doc/setup-net.xml b/winsup/doc/setup-net.xml
index 82b1e0dc9..db39bb66c 100644
--- a/winsup/doc/setup-net.xml
+++ b/winsup/doc/setup-net.xml
@@ -8,9 +8,7 @@
 <sect1 id="internet-setup">
 <title>Internet Setup</title>
 <para>To install the Cygwin net release, go to <ulink
-url="https://cygwin.com/"/> and run either
-<ulink url="https://cygwin.com/setup-x86.exe">setup-x86.exe</ulink>
-to install the 32 bit version of Cygwin, or
+url="https://cygwin.com/"/> and run
 <ulink url="https://cygwin.com/setup-x86_64.exe">setup-x86_64.exe</ulink>
 to install the 64 bit version of Cygwin.  This will download a GUI
 installer which can be run to download a complete cygwin installation
@@ -18,33 +16,21 @@ via the internet.  Follow the instructions on each screen to install Cygwin.
 </para>
 
 <para>
-<note>
-For easier reading the installer is called <command>setup.exe</command>
-throughout the following sections.  This refers likewise to both
-installer applications,
-<ulink url="https://cygwin.com/setup-x86.exe">setup-x86.exe</ulink>
-for 32 bit, as well as
-<ulink url="https://cygwin.com/setup-x86_64.exe">setup-x86_64.exe</ulink>
-for 64 bit.  Apart from the target architecture they are the same thing.
-</note>
-</para>
-
-<para>
-The <command>setup.exe</command> installer is designed to be easy
+The <command>setup</command> installer is designed to be easy
 for new users to understand while remaining flexible for the 
 experienced. The volunteer development team is constantly working
-on <command>setup.exe</command>; before requesting a new feature,
+on <command>setup</command>; before requesting a new feature,
 check the wishlist in the
 <ulink url="https://sourceware.org/git/gitweb.cgi?p=cygwin-setup.git;a=blob_plain;f=README;hb=HEAD">Git <literal>README</literal>
 </ulink>. It may already be present in the Git version!
 </para>
 
 <para>
-On Windows Vista and later, <command>setup.exe</command> will check by
+On Windows Vista and later, <command>setup</command> will check by
 default if it runs with administrative privileges and, if not, will try 
 to elevate the process.  If you want to avoid this behaviour and install
 under an unprivileged account just for your own usage, run
-<command>setup.exe</command> with the <literal>--no-admin</literal> option.
+<command>setup</command> with the <literal>--no-admin</literal> option.
 </para>
 
 <para>
@@ -54,7 +40,7 @@ installed by simply clicking the <literal>Next</literal> button
 at each page. The only exception to this is choosing a Cygwin mirror,
 which you can choose by experimenting with those listed at
 <ulink url="https://cygwin.com/mirrors.html"/>. For more details about each of page of the 
-<command>setup.exe</command> installation, read on below.
+<command>setup</command> installation, read on below.
 Please note that this guide assumes that you have a basic understanding
 of Unix (or a Unix-like OS). If you are new to Unix, you will also want 
 to make use of <ulink url="http://www.google.com/search?q=new+to+unix">
@@ -65,7 +51,7 @@ other resources</ulink>.
 <para>
 Cygwin uses packages to manage installing various software. When
 the default <literal>Install from Internet</literal> option is chosen,
-<command>setup.exe</command> creates a local directory to store
+<command>setup</command> creates a local directory to store
 the packages before actually installing the contents. 
 <literal>Download from Internet</literal> performs only the first
 part (storing the packages locally), while 
@@ -79,8 +65,8 @@ installation on several machines with
 <literal>Install from Local Directory</literal>; copy the
 entire local package tree to another machine with the directory
 tree intact. For example, you might create a <literal>C:\cache\</literal>
-directory and place <command>setup.exe</command> in it. Run 
-<command>setup.exe</command> to <literal>Install from Internet</literal>
+directory and place <command>setup</command> in it. Run
+<command>setup</command> to <literal>Install from Internet</literal>
 or <literal>Download from Internet</literal>, then copy the whole
 <literal>C:\cache\</literal> to each machine and instead choose
 <literal>Install from Local Directory</literal>.
@@ -119,10 +105,10 @@ programs, consult the Cygwin mailing list archives about others' experiences.
 <sect2 id="setup-localdir"><title>Local Package Directory</title>
 <para>
 The <literal>Local Package Directory</literal> is the cache where 
-<command>setup.exe</command> stores the packages before they are
+<command>setup</command> stores the packages before they are
 installed. The cache must not be the same folder as the Cygwin
 root. Within the cache, a separate directory is created for each
-Cygwin mirror, which allows <command>setup.exe</command> to use 
+Cygwin mirror, which allows <command>setup</command> to use
 multiple mirrors and custom packages. After installing Cygwin,
 the cache is no longer necessary, but you may want to retain the
 packages as backups, for installing Cygwin to another system,
@@ -155,30 +141,30 @@ mirror) you can add it.
 
 <sect2 id="setup-packages"><title>Choosing Packages</title>
 <para>
-For each selected mirror site, <command>setup.exe</command> downloads a 
+For each selected mirror site, <command>setup</command> downloads a
 small text file called <literal>setup.bz2</literal> that contains a list
 of packages available from that site along with some basic information about
-each package which <command>setup.exe</command> parses and uses to create the 
+each package which <command>setup</command> parses and uses to create the
 chooser window. For details about the format of this file, see the
-<ulink url="https://sourceware.org/cygwin-apps/setup.html">setup.exe homepage</ulink>.
+<ulink url="https://sourceware.org/cygwin-apps/setup.html">setup homepage</ulink>.
 </para>
 <para>
-The chooser is the most complex part of <command>setup.exe</command>. 
+The chooser is the most complex part of <command>setup</command>.
 Packages are grouped into categories, and one package may belong to multiple 
 categories (assigned by the volunteer package maintainer). Each package
 can be found under any of those categories in the hierarchical chooser view.
-By default, <command>setup.exe</command>
+By default, <command>setup</command>
 will install only the packages in the <literal>Base</literal> category
 and their dependencies, resulting in a minimal Cygwin installation.
 However, this will not include many commonly used tools such as 
 <command>gcc</command> (which you will find in the <literal>Devel</literal> 
-category).  Since <command>setup.exe</command> automatically selects
+category).  Since <command>setup</command> automatically selects
 dependencies, be careful not to unselect any required packages. In 
 particular, everything in the <literal>Base</literal> category is
 required.
 </para>
 <para>
-You can change <command>setup.exe</command>'s view style, which is helpful
+You can change <command>setup</command>'s view style, which is helpful
 if you know the name of a package you want to install but not which 
 category it is in. 
 Click on the <literal>View</literal> button and it will rotate between 
@@ -189,12 +175,12 @@ If you are familiar with Unix, you will probably want to at least glance
 through the <literal>Full</literal> listing for your favorite tools.
 </para>
 <para>
-Once you have an existing Cygwin installation, the <command>setup.exe</command>
+Once you have an existing Cygwin installation, the <command>setup</command>
 chooser is also used to manage your Cygwin installation. 
 Information on installed packages is kept in the
 <literal>/etc/setup/</literal> directory of your Cygwin installation; if 
-<command>setup.exe</command> cannot find this directory it will act as if
-you have no Cygwin installation.  If <command>setup.exe</command>
+<command>setup</command> cannot find this directory it will act as if
+you have no Cygwin installation.  If <command>setup</command>
 finds a newer version of an installed package available, it will automatically 
 mark it to be upgraded. 
 To <literal>Uninstall</literal>, <literal>Reinstall</literal>, or get the
@@ -202,7 +188,7 @@ To <literal>Uninstall</literal>, <literal>Reinstall</literal>, or get the
 <literal>Keep</literal> to toggle it. 
 Also, to avoid the need to reboot after upgrading, make sure
 to close all Cygwin windows and stop all Cygwin processes before 
-<command>setup.exe</command> begins to install the upgraded package.
+<command>setup</command> begins to install the upgraded package.
 </para>
 <para>
 To avoid unintentionally upgrading, use the <literal>Pending</literal>
@@ -222,7 +208,7 @@ Previous and experimental versions can be chosen by clicking on the package's
 <para>
 All available experimental packages can be selected by pressing the
 <literal>Exp</literal> in the top right part of the chooser window.
-Be warned, however, that the next time you run <command>setup.exe</command>
+Be warned, however, that the next time you run <command>setup</command>
 it will try to replace all old or experimental versions with the current
 version, unless told otherwise.
 </para>
@@ -230,11 +216,11 @@ version, unless told otherwise.
 
 <sect2 id="setup-progress"><title>Download and Installation Progress</title>
 <para>
-First, <command>setup.exe</command> will download all selected packages
+First, <command>setup</command> will download all selected packages
 to the local directory chosen earlier. Before installing, 
-<command>setup.exe</command> performs a checksum on each package. If the
+<command>setup</command> performs a checksum on each package. If the
 local directory is a slow medium (such as a network drive) this can take
-a long time. During the download and installation, <command>setup.exe</command>
+a long time. During the download and installation, <command>setup</command>
 shows progress bars for the current task and total remaining disk space.
 </para>
 </sect2>
@@ -250,9 +236,9 @@ in <filename>/etc/passwd</filename>.
 
 <sect2 id="setup-postinstall"><title>Post-Install Scripts</title>
 <para>
-Last of all, <command>setup.exe</command> will run any post-install
+Last of all, <command>setup</command> will run any post-install
 scripts to finish correctly setting up installed packages.
-When the last post-install script is completed, <command>setup.exe</command> 
+When the last post-install script is completed, <command>setup</command>
 will display a box announcing the completion. A few packages, such as
 the OpenSSH server, require some manual site-specific configuration. 
 Relevant documentation can be found in the <literal>/usr/doc/Cygwin/</literal> 
@@ -265,9 +251,9 @@ Unfortunately, the complex setup process means that odd problems can
 occur. If you're having trouble downloading packages, it may be network
 congestion, so try a different mirror and/or a different protocol (i.e.,
 HTTP instead of FTP).  If you notice something is not working after
-running setup, you can check the <command>setup.exe</command> log file
+running setup, you can check the <command>setup</command> log file
 at <literal>/var/log/setup.log.full</literal>. Make a backup of this
-file before running <command>setup.exe</command> again, and follow the
+file before running <command>setup</command> again, and follow the
 steps for <ulink url="https://cygwin.com/problems.html">Reporting
 Problems with Cygwin</ulink>.
 </para>
-- 
2.34.1

