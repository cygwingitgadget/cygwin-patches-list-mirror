Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from smtp-out-so.shaw.ca (smtp-out-so.shaw.ca [64.59.136.138])
 by sourceware.org (Postfix) with ESMTPS id 75E503861000
 for <cygwin-patches@cygwin.com>; Mon, 24 Aug 2020 20:11:43 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 75E503861000
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=brian.inglis@systematicsw.ab.ca
Received: from BWINGLISD.cg.shawcable.net ([24.64.172.44])
 by shaw.ca with ESMTP
 id AIoDkEgGn695cAIohkGDu0; Mon, 24 Aug 2020 14:11:43 -0600
X-Authority-Analysis: v=2.3 cv=fZA2N3YF c=1 sm=1 tr=0
 a=kiZT5GMN3KAWqtYcXc+/4Q==:117 a=kiZT5GMN3KAWqtYcXc+/4Q==:17 a=w_pzkKWiAAAA:8
 a=2oS-sqozAAAA:8 a=CCpqsmhAAAAA:8 a=hGzw-44bAAAA:8 a=mDV3o1hIAAAA:8
 a=wkubmWGtufO_YaaQ0UsA:9 a=oZGFrvLmE4Z7wQ9N:21 a=hLnIrnvZvAjWG4tQ:21
 a=uvLZkzHzGa8A:10 a=OWQaqklJ0g0A:10 a=9c8rtzwoRDUA:10 a=WK-i71OpKu4A:10
 a=rFA1MAFG28cA:10 a=sRI3_1zDfAgwuvI8zelB:22 a=WiNvAwpe8B6hZcWahKGt:22
 a=ul9cdbp4aOFLsgKbc677:22 a=HvKuF1_PTVFglORKqfwH:22 a=_FVE-zBwftR9WsbkzFJk:22
 a=pHzHmUro8NiASowvMSCR:22 a=nt3jZW36AmriUCFCBwmW:22
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: cygwin-patches@cygwin.com
Subject: [PATCH 3/3] winsup/doc/faq-setup.xml: update setup FAQ
Date: Mon, 24 Aug 2020 14:11:02 -0600
Message-Id: <20200824201058.4916-4-Brian.Inglis@SystematicSW.ab.ca>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824201058.4916-1-Brian.Inglis@SystematicSW.ab.ca>
References: <20200824201058.4916-1-Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Reply-To: cygwin-patches@cygwin.com
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfPMJHaCl8yUfqZ3KSiZYqfRsKfy7Sy5RvmeFCjATXy2g5kdA8u/vbZug6TZuFyssuB8G+q6PwBBNhSdjhwPNxAdacSg1RCGmRKlu4KxzkQJLEpl+UDej
 vt/5PN1FPkE1G2W7zD2BqIkjEj5sVxUhCIKyV4aeUBb1n1d7B6BHYsr80oaeV8f0IMPF5RnzeiGfJjnjdhrH0/kZqPq72GIdagpEoeWYLj3CkOdlIOqXmFIR
 UgNheLGpDtswIRRqO/CeAg==
X-Spam-Status: No, score=-12.3 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, KAM_SHORT, RCVD_IN_DNSWL_LOW,
 SPF_HELO_NONE, SPF_NONE, TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Mon, 24 Aug 2020 20:11:46 -0000

change all kinds of setup references to "the Cygwin Setup program";
emphasize 64 bit and deemphasize 32 bit;
update options list;
explain why installing everything is now extremely inadvisable, with stats
---
 winsup/doc/faq-setup.xml | 229 ++++++++++++++++++---------------------
 1 file changed, 104 insertions(+), 125 deletions(-)

diff --git a/winsup/doc/faq-setup.xml b/winsup/doc/faq-setup.xml
index b242fbae422c..c04ffe9a56e7 100644
--- a/winsup/doc/faq-setup.xml
+++ b/winsup/doc/faq-setup.xml
@@ -10,12 +10,16 @@
 <question><para>What is the recommended installation procedure?</para></question>
 <answer>
 
-<para>There is only one recommended way to install Cygwin, which is to use the GUI
-installer <command>setup-*.exe</command>.  It is flexible and easy to use.  
+<para>
+There is only one recommended way to install Cygwin, which is to use the
+Cygwin Setup program, a GUI installer named
+<command>setup-x86_64.exe</command> for 64 bit Windows, or
+<command>setup-x86.exe</command> for 32 bit Windows. It is flexible and easy to use.
 You can pick and choose the packages you wish to install, and update
 them individually.  Full source code is available for all packages and
-tools.  More information on using Cygwin Setup may be found at
-<ulink url="https://cygwin.com/cygwin-ug-net/setup-net.html"/>.
+tools.
+<ulink url="https://cygwin.com/cygwin-ug-net/setup-net.html">More information</ulink>
+is available on using the Cygwin Setup program.
 </para>
 <para>If you do it any other way, you're on your own!
 If something doesn't work right for you, and
@@ -35,8 +39,8 @@ see <ulink url="https://cygwin.com/packages/"/>.
 <para>The Cygwin Setup program is designed to be interactive, but there are
 a few different ways to automate it. If you are deploying to multiple systems,
 the best way is to run through a full installation once, saving the entire 
-downloaded package tree. Then, on target systems, run Cygwin Setup as a
-"Local Install" pointed at your downloaded package tree. You could do this 
+downloaded package tree. Then, on target systems, run the Cygwin Setup program as a
+"Local Install" pointed at your downloaded package tree. You could do this
 non-interactively with the command line options
 <literal>-q -L -l x:\cygwin-local\</literal>, where your downloaded 
 package tree is in <literal>x:\cygwin-local\</literal> (see the next FAQ for
@@ -50,32 +54,33 @@ For other options, search the mailing lists with terms such as
 </answer></qandaentry>
 
 <qandaentry id="faq.setup.cli">
-<question><para>Does Setup accept command-line arguments?</para></question>
+<question><para>Does the Cygwin Setup program accept command-line arguments?</para></question>
 <answer>
 
-<para>Yes, run <literal>setup-x86.exe --help</literal> or
-<literal>setup-x86_64.exe --help</literal> for a list.
+<para>Yes, run the Cygwin Setup program with option
+<literal>--help</literal> for an up to date list:
 </para>
 
 <screen>
     --allow-unsupported-windows    Allow old, unsupported Windows versions
- -a --arch                         architecture to install (x86_64 or x86)
+ -a --arch                         Architecture to install (x86_64 or x86)
  -C --categories                   Specify entire categories to install
- -o --delete-orphans               remove orphaned packages
+ -o --delete-orphans               Remove orphaned packages
  -A --disable-buggy-antivirus      Disable known or suspected buggy anti virus
                                    software packages during execution.
- -D --download                     Download from internet
- -f --force-current                select the current version for all packages
- -h --help                         print help
- -I --include-source               Automatically include source download
+ -D --download                     Download packages from internet only
+ -f --force-current                Select the current version for all packages
+ -h --help                         Print help
+ -I --include-source               Automatically install source for every
+                                   package installed
  -i --ini-basename                 Use a different basename, e.g. "foo",
                                    instead of "setup"
  -U --keep-untrusted-keys          Use untrusted keys and retain all
- -L --local-install                Install from local directory
+ -L --local-install                Install packages from local directory only
  -l --local-package-dir            Local package directory
- -m --mirror-mode                  Skip availability check when installing from
-                                   local directory (requires local directory to
-                                   be clean mirror!)
+ -m --mirror-mode                  Skip package availability check when
+                                   installing from local directory (requires
+                                   local directory to be clean mirror!)
  -B --no-admin                     Do not check for and enforce running as
                                    Administrator
  -d --no-desktop                   Disable creation of desktop shortcut
@@ -85,23 +90,29 @@ For other options, search the mailing lists with terms such as
                                    shortcuts
  -N --no-startmenu                 Disable creation of start menu shortcut
  -X --no-verify                    Don't verify setup.ini signatures
- -O --only-site                    Ignore all sites except for -s
+    --no-version-check             Suppress checking if a newer version of
+                                   setup is available
+    --old-keys                     Enable old cygwin.com keys
+ -O --only-site                    Do not download mirror list.  Only use sites
+                                   specified with -s.
  -M --package-manager              Semi-attended chooser-only mode
  -P --packages                     Specify packages to install
  -p --proxy                        HTTP/FTP proxy (host:port)
- -Y --prune-install                prune the installation to only the requested
+ -Y --prune-install                Prune the installation to only the requested
                                    packages
- -K --pubkey                       URL of extra public key file (gpg format)
+ -K --pubkey                       URL or absolute path of extra public key
+                                   file (RFC4880 format)
  -q --quiet-mode                   Unattended setup mode
  -c --remove-categories            Specify categories to uninstall
  -x --remove-packages              Specify packages to uninstall
  -R --root                         Root installation directory
- -S --sexpr-pubkey                 Extra public key in s-expr format
- -s --site                         Download site
- -u --untrusted-keys               Use untrusted keys from last-extrakeys
- -g --upgrade-also                 also upgrade installed packages
+ -S --sexpr-pubkey                 Extra DSA public key in s-expr format
+ -s --site                         Download site URL
+ -u --untrusted-keys               Use untrusted saved extra keys
+ -g --upgrade-also                 Also upgrade installed packages
     --user-agent                   User agent string for HTTP requests
  -v --verbose                      Verbose output
+ -V --version                      Show version
  -W --wait                         When elevating, wait for elevated child
                                    process
 </screen>
@@ -116,15 +127,14 @@ For other options, search the mailing lists with terms such as
 this allows to set up the Cygwin environment so that all users can start
 a Cygwin shell out of the box.  However, if you don't have administrator
 rights for your machine, and the admins don't want to install it for you,
-you can install Cygwin just for yourself by downloading
-<command>setup-x86.exe</command> (for a 32 bit install) or
-<command>setup-x86_64.exe</command> (for a 64 bit install) and then start
+you can install Cygwin just for yourself by downloading the Cygwin Setup
+program, and then start
 it from the command line or via the "Run..." dialog from the start menu
 using the <literal>--no-admin</literal> option, for instance:</para>
 
 <para>
 <screen>
-  setup-x86.exe --no-admin
+  setup-x86_64.exe --no-admin
 </screen>
 </para>
 </answer></qandaentry>
@@ -151,11 +161,11 @@ now.)
 </answer></qandaentry>
 
 <qandaentry id="faq.setup.old-versions">
-<question><para>Can I use Cygwin Setup to get old versions of packages (like gcc-2.95)?</para></question>
+<question><para>Can I use the Cygwin Setup program to get old versions of packages (like gcc-2.95)?</para></question>
 <answer>
 
-<para>Cygwin Setup can be used to install any packages that are on a
-Cygwin mirror, which usually includes one version previous to the
+<para>The Cygwin Setup program can be used to install any packages that are on a
+Cygwin mirror, which usually includes at least one version previous to the
 current one. The complete list may be searched at 
 <ulink url="https://cygwin.com/packages/"/>.  There is no complete archive of
 older packages. If you have a problem with the current version of
@@ -180,12 +190,12 @@ Here is how Cygwin secures the installation and update process to counter
 </para>
 
 <orderedlist>
-<listitem><para>The Cygwin website provides the setup program
+<listitem><para>The Cygwin website provides the Cygwin Setup program
 (<literal>setup-x86.exe</literal> or <literal>setup-x86_64.exe</literal>)
 using HTTPS (SSL/TLS).
-This authenticates that the setup program
+This authenticates that the Cygwin Setup program
 came from the Cygwin website
-(users simply use their web browsers to download the setup program).
+(users simply use their web browsers to download the Cygwin Setup program).
 You can use tools like Qualsys' SSL Server Test,
 <ulink url="https://www.ssllabs.com/ssltest/"/>,
 to check the HTTPS configuration of Cygwin.
@@ -193,31 +203,32 @@ The cygwin.com site supports HTTP Strict Transport Security (HSTS),
 which forces the browser to keep using HTTPS once the browser has seen
 it before (this counters many downgrade attacks).
 </para></listitem>
-<listitem><para>The setup program has the
+<listitem><para>The Cygwin Setup program has the
 Cygwin public key embedded in it.
 The Cygwin public key is protected from attacker subversion
 during transmission by the previous step, and this public
 key is then used to protect all later steps.
-You can confirm that the key is in setup by looking at the setup project
+You can confirm that the key is in the Cygwin Setup program by looking at the setup project
 (<ulink url="http://sourceware.org/cygwin-apps/setup.html"/>)
 source code file <literal>cyg-pubkey.h</literal>
 (the key is automatically generated from file <literal>cygwin.pub</literal>).
 </para></listitem>
-<listitem><para>The setup program downloads
+<listitem><para>The Cygwin Setup program downloads
 the package list <literal>setup.ini</literal> from a mirror
 and checks its digital signature.
-The package list is in the file
+The package list is in the files
+<filename>setup.xz</filename>, <filename>setup.zst</filename>,
 <literal>setup.bz2</literal> (compressed) or
 <literal>setup.ini</literal> (uncompressed) on the selected mirror.
 The package list includes for every official Cygwin package
 the package name, cryptographic hash, and length (in bytes).
-The setup program also gets the relevant <literal>.sig</literal>
+The Cygwin Setup program also gets the relevant <literal>.sig</literal>
 (signature) file for that package list, and checks that the package list
-is properly signed with the Cygwin public key embedded in the setup program.
+is properly signed with the Cygwin public key embedded in the Setup program.
 A mirror could corrupt the package list and/or signature, but this
-would be detected by setup program's signature detection
+would be detected by the Cygwin Setup program's signature detection
 (unless you use the <literal>-X</literal> option to disable signature checking).
-The setup program also checks the package list
+The Cygwin Setup program also checks the package list
 timestamp/version and reports to the user if the file
 goes backwards in time; that process detects downgrade attacks
 (e.g., where an attacker subverts a mirror to send a signed package list
@@ -226,7 +237,7 @@ that is older than the currently-downloaded version).
 <listitem><para>The packages to be installed
 (which may be updates) are downloaded and both their
 lengths and cryptographic hashes
-(from the signed <literal>setup.{bz2,ini}</literal> file) are checked.
+(from the signed <filename>setup.xz/.zst/.bz2/.ini</filename> file) are checked.
 Non-matching packages are rejected, countering any attacker's
 attempt to subvert the files on a mirror.
 Cygwin currently uses the cryptographic hash function SHA-512
@@ -250,8 +261,8 @@ widely-used SHA-2 suite of cryptographic hashes).
 
 <para>
 To best secure your installation and update process, download
-the setup program <literal>setup-x86.exe</literal> (32-bit) or
-<literal>setup-x86_64.exe</literal> (64-bit), and then
+the Cygwin Setup program <filename>setup-x86_64.exe</filename> (64-bit) or
+<filename>setup-x86.exe</filename> (32-bit), and then
 check its signature (using a signature-checking tool you trust)
 using the Cygwin public key
 (<ulink url="https://cygwin.com/key/pubring.asc"/>).
@@ -277,22 +288,22 @@ Not everyone will go through this additional effort,
 but we make it possible for those who want that extra confidence.
 We also provide automatic mechanisms
 (such as our use of HTTPS) for those with limited time and
-do not want to perform the signature checking on the setup program itself.
-Once the correct setup program is running, it will counter other attacks
+do not want to perform the signature checking on the Cygwin Setup program itself.
+Once the correct Setup program is running, it will counter other attacks
 as described in
 <ulink url="https://cygwin.com/faq/faq.html#faq.setup.install-security"/>.
 </para>
 </answer></qandaentry>
 
 <qandaentry id="faq.setup.virus">
-<question><para>Is Cygwin Setup, or one of the packages, infected with a virus?</para></question>
+<question><para>Is the Cygwin Setup program, or one of the packages, infected with a virus?</para></question>
 <answer>
 
 <para>Unlikely.  Unless you can confirm it, please don't report it to the
 mailing list.  Anti-virus products have been known to detect false
 positives when extracting compressed tar archives.  If this causes
 problems for you, consider disabling your anti-virus software when
-running <literal>setup</literal>.  Read the next entry for a fairly safe way to do
+running the Cygwin Setup program.  Read the next entry for a fairly safe way to do
 this.
 </para>
 </answer></qandaentry>
@@ -304,17 +315,18 @@ this.
 <para>Both Network Associates (formerly McAfee) and Norton anti-virus
 products have been reported to "hang" when extracting Cygwin tar
 archives.  If this happens to you, consider disabling your anti-virus
-software when running Cygwin Setup.  The following procedure should be
+software when running the Cygwin Setup program.  The following procedure should be
 a fairly safe way to do that:
 </para>
-<orderedlist><listitem><para>Download <literal>setup-x86.exe</literal> or
-<literal>setup-x86_64.exe</literal> and scan it explicitly.
+<orderedlist><listitem><para>Download <filename>setup-x86_64.exe</filename> or
+<filename>setup-x86.exe</filename> and scan it explicitly.
 </para>
 </listitem>
 <listitem><para>Turn off the anti-virus software.
 </para>
 </listitem>
-<listitem><para>Run setup to download and extract all the tar files.
+<listitem><para>Run the Cygwin Setup program to download and install or upgrade
+all desired packages.
 </para>
 </listitem>
 <listitem><para>Re-activate your anti-virus software and scan everything
@@ -324,7 +336,7 @@ disk if you are paranoid.
 </listitem>
 </orderedlist>
 
-<para>This should be safe, but only if Cygwin Setup is not substituted by
+<para>This should be safe, but only if the Cygwin Setup program is not substituted by
 something malicious.
 See also
 <ulink url="https://cygwin.com/faq/faq.html#faq.setup.install-security"/>
@@ -341,7 +353,7 @@ interfere with the normal functioning of Cygwin.
 <qandaentry id="faq.setup.what-packages">
 <question><para>What packages should I download? Where are 'make', 'gcc', 'vi', etc?  </para></question>
 <answer>
-<para>When using Cygwin Setup for the first time, the default is to install
+<para>When using the Cygwin Setup program for the first time, the default is to install
 a minimal subset of all available packages.  If you want anything beyond that,
 you will have to select it explicitly.  See 
 <ulink url="https://cygwin.com/packages/"/> for a searchable list of available
@@ -361,53 +373,20 @@ User's Guide at
 
 <para>Long ago, the default was to install everything, much to the
 irritation of most users.  Now the default is to install only a basic
-core of packages.  Cygwin Setup is designed to make it easy to browse
+core of packages. The Cygwin Setup program is designed to make it easy to browse
 categories and select what you want to install or omit from those
-categories.  It's also easy to install everything:
-</para>
-<orderedlist>
-<listitem><para>At the ``Select Packages'' screen, in ``Categories'' view, at the line 
-marked ``All'', click on the word ``default'' so that it changes to
-``install''.  (Be patient, there is some computing to do at this step.
-It may take a second or two to register the change.)  This tells Setup
-to install <emphasis>everything</emphasis>, not just what it thinks you should have
-by default.
-</para>
-</listitem>
-<listitem><para>Now click on the ``View'' button (twice) until you get to the
-``Pending'' view.  This shows exactly which packages are about to be
-downloaded and installed.
-</para>
-</listitem>
-</orderedlist>
-
-<para>This procedure only works for packages that are currently available.
-There is no way to tell Cygwin Setup to install all packages by
-default from now on.  As new packages become available that would not
-be installed by default, you have to repeat the above procedure to get
-them.
-</para>
-<para>In general, a better method (in my opinion), is to:
+categories.
+There are now more than 10000 Cygwin packages requiring more than 150GB
+of disk space just to download and hundreds of GB more to install so you
+are strongly advised not to attempt to
+<ulink url="https://cygwin.com/install.html#everything">install everything</ulink>
+at once, unless you have a lot of free disk space, a very high speed network
+connection, and the system will not be required for any other purpose for
+many hours (or days) until installation completes.
+For a 32-bit Cygwin installation, you can not install everything, as the
+installation will fail because the 4GB memory available is insufficient to allow
+all the DLLs required to run along with the programs using them.
 </para>
-<orderedlist>
-<listitem><para>First download &amp; install all packages that would normally be
-installed by default.  This includes fundamental packages and any
-updates to what you have already installed.  Then...
-</para>
-</listitem>
-<listitem><para>Run Cygwin Setup again, and apply the above technique to get all
-new packages that would not be installed by default.  You can check
-the list in the ``Pending'' view before proceeding, in case there's
-something you really <emphasis>don't</emphasis> want.
-</para>
-</listitem>
-<listitem><para>In the latest version of Cygwin Setup, if you click the ``View''
-button (twice) more, it shows packages not currently installed.  You
-ought to check whether you <emphasis>really</emphasis> want to install everything!
-</para>
-</listitem>
-</orderedlist>
-
 </answer></qandaentry>
 
 <qandaentry id="faq.setup.disk-space">
@@ -415,16 +394,16 @@ ought to check whether you <emphasis>really</emphasis> want to install everythin
 <answer>
 
 <para>That depends, obviously, on what you've chosen to download and
-install.  A full installation today is probably larger than 1 GB
+install.  A full installation today is many hundreds of GB
 installed, not including the package archives themselves nor the source
 code.
 </para>
 <para>After installation, the package archives remain in your ``Local
-Package Directory''.  By default the location of
-<literal>setup-x86{_64}.exe</literal>.  You may conserve disk space by
+Package Directory''.  By default the location of the Cygwin Setup program.
+You may conserve disk space by
 deleting the subdirectories there.  These directories will have very weird
 looking names, being encoded with their URLs
-(named <literal>ftp%3a%2f...</literal>).
+(named <literal>http%3a%2f...cygwin...%2f</literal>).
 </para>
 <para>Of course, you can keep them around in case you want to reinstall a
 package. If you want to clean out only the outdated packages, Michael Chase
@@ -438,42 +417,42 @@ at <filename>unsupported/clean_setup.pl</filename> in a Cygwin mirror.
 <answer>
 
 <para>Detailed logs of the most recent Cygwin Setup session can be found in
-<literal>/var/log/setup.log.full</literal> and less verbose information about
-prior actions is in <literal>/var/log/setup.log</literal>.
+<filename>/var/log/setup.log.full</filename> and less verbose information about
+prior actions is in <filename>/var/log/setup.log</filename>.
 </para>
 
 </answer></qandaentry>
 
 <qandaentry id="faq.setup.setup-fails">
-<question><para>What if setup fails?</para></question>
+<question><para>What if the Cygwin Setup program fails?</para></question>
 <answer>
 
-<para>First, make sure that you are using the latest version of Cygwin Setup.
+<para>First, make sure that you are using the latest version of the Cygwin Setup program.
 The latest version is always available from the Cygwin Home Page at
 <ulink url="https://cygwin.com/"/>.
 </para>
 <para>If you are downloading from the Internet, setup will fail if it cannot
-download the list of mirrors at <ulink url="https://cygwin.com/mirrors.html"/>.
+download the list of mirrors at <ulink url="https://cygwin.com/mirrors.lst"/>.
 It could be that the network is too busy.  Something similar could be the
 cause of a download site not working.  Try another mirror, or try again
 later.
 </para>
-<para>If setup refuses to download a package that you know needs to be
+<para>If the Cygwin Setup program refuses to download a package that you know needs to be
 upgraded, try deleting that package's entry from /etc/setup.  If you are
 reacting quickly to an announcement on the mailing list, it could be
 that the mirror you are using doesn't have the latest copy yet.  Try
 another mirror, or try again tomorrow.
 </para>
-<para>If setup has otherwise behaved strangely, check the files
-<literal>setup.log</literal> and <literal>setup.log.full</literal> in
-<literal>/var/log</literal> (<literal>C:\cygwin\var\log</literal> by
+<para>If the Cygwin Setup program has otherwise behaved strangely, check the files
+<filename>setup.log</filename> and <filename>setup.log.full</filename> in
+<filename>/var/log</filename> (<filename>C:\cygwin\var\log</filename> by
 default).  It may provide some clues as to what went wrong and why.
 </para>
 <para>If you're still baffled, search the Cygwin mailing list for clues.
 Others may have the same problem, and a solution may be posted there.
 If that search proves fruitless, send a query to the Cygwin mailing
 list.  You must provide complete details in your query: version of
-setup, options you selected, contents of setup.log and setup.log.full,
+the Cygwin Setup program, options you selected, contents of setup.log and setup.log.full,
 what happened that wasn't supposed to happen, etc.
 </para>
 </answer></qandaentry>
@@ -542,7 +521,7 @@ getpwnam(3), disregarding <literal>HOME</literal>.
 <question><para>How do I uninstall individual packages?</para></question>
 <answer>
 
-<para>Run Cygwin Setup as you would to install packages.  In the list of
+<para>Run the Cygwin Setup program as you would to install packages.  In the list of
 packages to install, browse the relevant category or click on the
 ``View'' button to get a full listing.  Click on the cycle glyph until
 the action reads ``Uninstall''.  Proceed by clicking ``Next''.
@@ -627,8 +606,8 @@ mount points as well.
 </para>
 </listitem>
 <listitem><para>Delete the Cygwin shortcuts on the Desktop and Start Menu, and
-anything left by setup-x86{_64}.exe in the download directory.  However, if you
-plan to reinstall Cygwin it's a good idea to keep your setup-x86{_64}.exe
+anything left by the Cygwin Setup program in the download directory.  However, if you
+plan to reinstall Cygwin it's a good idea to keep your
 download directory since you can reinstall the packages left in its cache
 without redownloading them.
 </para>
@@ -659,7 +638,7 @@ have not been tested.  Use them <emphasis role='bold'>only</emphasis> if there i
 bugfix that you need to try, and you are willing to deal with any
 problems, or at the request of a Cygwin developer.
 </para>
-<para>You cannot use Cygwin Setup to install a snapshot.
+<para>You cannot use the Cygwin Setup program to install a snapshot.
 </para>
 <para>First, you will need to download the snapshot from the snapshots
 page at <ulink url="https://cygwin.com/snapshots/"/>.  Note the directory where
@@ -699,21 +678,21 @@ DLL, again, close all Cygwin processes, delete
 rename <literal>C:\cygwin\bin\cygwin1-prev.dll</literal> back to
 <literal>C:\cygwin\bin\cygwin1.dll</literal> (again assuming that your "<literal>/</literal>" is
 <literal>C:\cygwin</literal>).  To restore the rest of the snapshot
-files, reinstall the "<literal>cygwin</literal>" package using Setup.
+files, reinstall the "<literal>cygwin</literal>" package using the Cygwin Setup program.
 </para>
 
 </answer></qandaentry>
 
 <qandaentry id="faq.setup.mirror">
-<question><para>Can Cygwin Setup maintain a ``mirror''?</para></question>
+<question><para>Can the Cygwin Setup program maintain a ``mirror''?</para></question>
 <answer>
 
-<para>NO.  Cygwin Setup cannot do this for you.  Use a tool designed for
+<para>NO. The Cygwin Setup program cannot do this for you.  Use a tool designed for
 this purpose.  See <ulink url="http://rsync.samba.org/"/>,
 <ulink url="http://www.gnu.org/software/wget/"/> for utilities that can do this for you.
 For more information on setting up a custom Cygwin package server, see
-the Cygwin Setup homepage at
-<ulink url="https://sourceware.org/cygwin-apps/setup.html"/>.
+the <ulink url="https://sourceware.org/cygwin-apps/setup.html">Cygwin Setup program page</ulink>.
+
 </para>
 </answer></qandaentry>
 
-- 
2.28.0

