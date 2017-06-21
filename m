Return-Path: <cygwin-patches-return-8794-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25436 invoked by alias); 21 Jun 2017 18:37:01 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 23242 invoked by uid 89); 21 Jun 2017 18:36:59 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-24.2 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2 spammy=para, agent, administrator, HTo:U*cygwin-patches
X-HELO: rgout0805.bt.lon5.cpcloud.co.uk
Received: from rgout0805.bt.lon5.cpcloud.co.uk (HELO rgout0805.bt.lon5.cpcloud.co.uk) (65.20.0.152) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 21 Jun 2017 18:36:58 +0000
X-OWM-Source-IP: 86.158.32.120 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-Junkmail-Premium-Raw: score=8/50,refid=2.7.2:2017.6.8.141815:17:8.707,ip=,rules=NO_URI_FOUND, NO_CTA_URI_FOUND, NO_MESSAGE_ID, NO_URI_HTTPS, TO_MALFORMED
Received: from localhost.localdomain (86.158.32.120) by rgout08.bt.lon5.cpcloud.co.uk (9.0.019.13-1) (authenticated as jonturney@btinternet.com)        id 58BFF0800B82F0EB; Wed, 21 Jun 2017 19:36:55 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH] Update and sort list of cygwin setup command line options.
Date: Wed, 21 Jun 2017 18:37:00 -0000
Message-Id: <20170621183626.209840-1-jon.turney@dronecode.org.uk>
X-SW-Source: 2017-q2/txt/msg00065.txt.bz2

Signed-off-by: Jon Turney <jon.turney@dronecode.org.uk>
---
 winsup/doc/faq-setup.xml | 62 +++++++++++++++++++++++++++++-------------------
 1 file changed, 38 insertions(+), 24 deletions(-)

diff --git a/winsup/doc/faq-setup.xml b/winsup/doc/faq-setup.xml
index 0fc263571..3917f2d30 100644
--- a/winsup/doc/faq-setup.xml
+++ b/winsup/doc/faq-setup.xml
@@ -53,45 +53,59 @@ For other options, search the mailing lists with terms such as
 <question><para>Does Setup accept command-line arguments?</para></question>
 <answer>
 
-<para>Yes, the full listing is written to the <literal>setup.log</literal> file 
-when you run <literal>setup-x86.exe --help</literal> or
-<literal>setup-x86_64.exe --help</literal>. The current options are:
+<para>Yes, run <literal>setup-x86.exe --help</literal> or
+<literal>setup-x86_64.exe --help</literal> for a list.
+</para>
+
 <screen>
-Command Line Options:
+    --allow-unsupported-windows    Allow old, unsupported Windows versions
+ -a --arch                         architecture to install (x86_64 or x86)
+ -C --categories                   Specify entire categories to install
+ -o --delete-orphans               remove orphaned packages
+ -A --disable-buggy-antivirus      Disable known or suspected buggy anti virus
+                                   software packages during execution.
  -D --download                     Download from internet
+ -f --force-current                select the current version for all packages
+ -h --help                         print help
+ -I --include-source               Automatically include source download
+ -i --ini-basename                 Use a different basename, e.g. "foo",
+                                   instead of "setup"
+ -U --keep-untrusted-keys          Use untrusted keys and retain all
  -L --local-install                Install from local directory
- -s --site                         Download site
- -O --only-site                    Ignore all sites except for -s
- -R --root                         Root installation directory
- -x --remove-packages              Specify packages to uninstall
- -c --remove-categories            Specify categories to uninstall
- -P --packages                     Specify packages to install
- -C --categories                   Specify entire categories to install
- -p --proxy                        HTTP/FTP proxy (host:port)
- -a --arch                         architecture to install (x86_64 or x86)
- -q --quiet-mode                   Unattended setup mode
- -M --package-manager              Semi-attended chooser-only mode
+ -l --local-package-dir            Local package directory
+ -m --mirror-mode                  Skip availability check when installing from
+                                   local directory (requires local directory to
+                                   be clean mirror!)
  -B --no-admin                     Do not check for and enforce running as
                                    Administrator
- -h --help                         print help
- -l --local-package-dir            Local package directory
+ -d --no-desktop                   Disable creation of desktop shortcut
  -r --no-replaceonreboot           Disable replacing in-use files on next
                                    reboot.
- -X --no-verify                    Don't verify setup.ini signatures
  -n --no-shortcuts                 Disable creation of desktop and start menu
                                    shortcuts
  -N --no-startmenu                 Disable creation of start menu shortcut
- -d --no-desktop                   Disable creation of desktop shortcut
+ -X --no-verify                    Don't verify setup.ini signatures
+ -O --only-site                    Ignore all sites except for -s
+ -M --package-manager              Semi-attended chooser-only mode
+ -P --packages                     Specify packages to install
+ -p --proxy                        HTTP/FTP proxy (host:port)
+ -Y --prune-install                prune the installation to only the requested
+                                   packages
  -K --pubkey                       URL of extra public key file (gpg format)
+ -q --quiet-mode                   Unattended setup mode
+ -c --remove-categories            Specify categories to uninstall
+ -x --remove-packages              Specify packages to uninstall
+ -R --root                         Root installation directory
  -S --sexpr-pubkey                 Extra public key in s-expr format
+ -s --site                         Download site
  -u --untrusted-keys               Use untrusted keys from last-extrakeys
- -U --keep-untrusted-keys          Use untrusted keys and retain all
  -g --upgrade-also                 also upgrade installed packages
- -o --delete-orphans               remove orphaned packages
- -A --disable-buggy-antivirus      Disable known or suspected buggy anti virus
-                                   software packages during execution.
+    --user-agent                   User agent string for HTTP requests
+ -v --verbose                      Verbose output
+ -W --wait                         When elevating, wait for elevated child
+                                   process
 </screen>
-</para>
+
 </answer></qandaentry>
 
 <qandaentry id="faq.setup.noroot">
-- 
2.12.3
