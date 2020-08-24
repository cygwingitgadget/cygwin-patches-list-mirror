Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from smtp-out-so.shaw.ca (smtp-out-so.shaw.ca [64.59.136.138])
 by sourceware.org (Postfix) with ESMTPS id 3FB8C3851C23
 for <cygwin-patches@cygwin.com>; Mon, 24 Aug 2020 20:11:24 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 3FB8C3851C23
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=brian.inglis@systematicsw.ab.ca
Received: from BWINGLISD.cg.shawcable.net ([24.64.172.44])
 by shaw.ca with ESMTP
 id AIoDkEgGn695cAIoOkGDqV; Mon, 24 Aug 2020 14:11:24 -0600
X-Authority-Analysis: v=2.3 cv=fZA2N3YF c=1 sm=1 tr=0
 a=kiZT5GMN3KAWqtYcXc+/4Q==:117 a=kiZT5GMN3KAWqtYcXc+/4Q==:17 a=w_pzkKWiAAAA:8
 a=PHortqyt3Qne_rW-jEQA:9 a=VTJOHQwvoJQA:10 a=sRI3_1zDfAgwuvI8zelB:22
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: cygwin-patches@cygwin.com
Subject: [PATCH 1/3] winsup/doc/faq-api,
 programming.xml: change Win32 to Windows
Date: Mon, 24 Aug 2020 14:10:58 -0600
Message-Id: <20200824201058.4916-2-Brian.Inglis@SystematicSW.ab.ca>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824201058.4916-1-Brian.Inglis@SystematicSW.ab.ca>
References: <20200824201058.4916-1-Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Reply-To: cygwin-patches@cygwin.com
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfA3Oc/sdUFVfXqKC+e16T3Ntwk+Xnskf/JX4K/arp9ScgXEhGghUJ18nDuFSfZkKkK2Dv8HjFXRuDLLkSoy7RcX2P3/wXNDsj7tyPZGaBlgVYzmZq9Ht
 Cn18i8Wdn/aRv0IWLl2fL0iw84X+3QUjbC5MC16xw9PuTRAvrj1+2xY416Zi15Ocd3W1VzR2+F7DDJUr8Tk08TnFTqBm6mOEwt/iIAaFBTBQ2cNKT2ddGSAT
 rxuZNLJ/8xLigwli/IH8xQ==
X-Spam-Status: No, score=-12.4 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_DNSWL_LOW, SPF_HELO_NONE,
 SPF_NONE, TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Mon, 24 Aug 2020 20:11:25 -0000

---
 winsup/doc/faq-api.xml         | 10 +++++-----
 winsup/doc/faq-programming.xml | 20 ++++++++++----------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/winsup/doc/faq-api.xml b/winsup/doc/faq-api.xml
index 313f15d37c4d..f51eeac48835 100644
--- a/winsup/doc/faq-api.xml
+++ b/winsup/doc/faq-api.xml
@@ -18,7 +18,7 @@ Windows into the C library.  Then your apps should (ideally) run on POSIX
 systems (Unix/Linux) and Windows with no changes at the source level.
 </para>
 <para>The C library is in a DLL, which makes basic applications quite small.
-And it allows relatively easy upgrades to the Win32/POSIX translation
+And it allows relatively easy upgrades to the Windows/POSIX translation
 layer, providing that DLL changes stay backward-compatible.
 </para>
 <para>For a good overview of Cygwin, you may want to read the Cygwin
@@ -140,7 +140,7 @@ spawn family of calls if possible.
 <para>Here's how it works:
 </para>
 <para>Parent initializes a space in the Cygwin process table for child.
-Parent creates child suspended using Win32 CreateProcess call, giving
+Parent creates child suspended using Windows CreateProcess call, giving
 the same path it was invoked with itself.  Parent calls setjmp to save
 its own context and then sets a pointer to this in the Cygwin shared
 memory area (shared among all Cygwin tasks).  Parent fills in the child's
@@ -326,7 +326,7 @@ name under the API.
 <para>E.g., the POSIX select system call can wait on a standard file handles
 and handles to sockets.  The select call in Winsock can only wait on
 sockets.  Because of this, the Cygwin dll does a lot of nasty stuff behind
-the scenes, trying to persuade various Winsock/Win32 functions to do what
+the scenes, trying to persuade various Winsock/Windows functions to do what
 a Unix select would do.
 </para>
 <para>If you are porting an application which already uses Winsock, then
@@ -337,11 +337,11 @@ direct calls to Winsock functions.  If you use Cygwin, use the POSIX API.
 </answer></qandaentry>
 
 <qandaentry id="faq.api.winsock">
-<question><para>I don't want Unix sockets, how do I use normal Win32 winsock?</para></question>
+<question><para>I don't want Unix sockets, how do I use normal Windows winsock?</para></question>
 <answer>
 
 <para>You don't.  Look for the Mingw-w64 project to port applications using
-native Win32/Winsock functions.  Cross compilers packages to build Mingw-w64
+native Windows/Winsock functions.  Cross compilers packages to build Mingw-w64
 targets are available in the Cygwin distro.
 </para>
 </answer></qandaentry>
diff --git a/winsup/doc/faq-programming.xml b/winsup/doc/faq-programming.xml
index 5920ca8c44d5..ccb93130f8fe 100644
--- a/winsup/doc/faq-programming.xml
+++ b/winsup/doc/faq-programming.xml
@@ -76,7 +76,7 @@ sizeof(void*)       4        8        8
 </screen>
 
 <para>This difference can result in interesting problems, especially when
-using Win32 functions, especially when using pointers to Windows
+using Windows functions using pointers to Windows
 datatypes like LONG, ULONG, DWORD.  Given that Windows is LLP64, all of
 the aforementioned types are 4 byte in size, on 32 as well as on 64 bit
 Windows, while `long' on 64 bit Cygwin is 8 bytes.</para>
@@ -189,10 +189,10 @@ string pointer given to printf is missing the upper 4 bytes.
 </para></listitem>
 
 <listitem><para>
-<emphasis>Don't</emphasis> use C base types together with Win32 functions.
+<emphasis>Don't</emphasis> use C base types together with Windows functions.
 Keep in mind that DWORD, LONG, ULONG are <emphasis>not</emphasis> the same
-as long and unsigned long.  Try to use only Win32 datatypes in conjunction
-with Win32 API function calls to avoid type problems.  See the above
+as long and unsigned long.  Try to use only Windows datatypes in conjunction
+with Windows API function calls to avoid type problems.  See the above
 ReadFile example.  Windows functions in printf calls should be treated
 carefully as well.  This code is common for 32 bit code, but probably prints
 the wrong value on 64 bit:
@@ -438,11 +438,11 @@ gcj --main=Hello Hello.java
 </answer></qandaentry>
 
 <qandaentry id="faq.programming.win32-api">
-<question><para>How do I use Win32 API calls?</para></question>
+<question><para>How do I use Windows API calls?</para></question>
 <answer>
 
 <para>Cygwin tools require that you explicitly link the import libraries
-for whatever Win32 API functions that you are going to use, with the exception
+for whatever Windows API functions that you are going to use, with the exception
 of kernel32, which is linked automatically (because the startup and/or
 built-in code uses it).
 </para>
@@ -464,7 +464,7 @@ including user32, gdi32 and comdlg32.
 or at least after all the object files and static libraries that reference them.
 </para>
 
-<note><para>There are a few restrictions for calls to the Win32 API.
+<note><para>There are a few restrictions for calls to the Windows API.
 For details, see the User's Guide section
 <ulink url="https://cygwin.com/cygwin-ug-net/setup-env.html#setup-env-win32">Restricted Win32 environment</ulink>,
 as well as the User's Guide section
@@ -472,7 +472,7 @@ as well as the User's Guide section
 </answer></qandaentry>
 
 <qandaentry id="faq.programming.win32-no-cygwin">
-<question><para>How do I compile a Win32 executable that doesn't use Cygwin?</para></question>
+<question><para>How do I compile a Windows executable that doesn't use Cygwin?</para></question>
 <answer>
 
 <para>The compilers provided by the <literal>mingw64-i686-gcc</literal> and
@@ -528,7 +528,7 @@ lines must start with tabs.  This is not specific to Cygwin.
 </answer></qandaentry>
 
 <qandaentry id="faq.programming.win32-headers">
-<question><para>Why can't we redistribute Microsoft's Win32 headers?</para></question>
+<question><para>Why can't we redistribute Microsoft's Windows headers?</para></question>
 <answer>
 
 <para>Subsection 2.d.f of the `Microsoft Open Tools License agreement' looks
@@ -536,7 +536,7 @@ like it says that one may not "permit further redistribution of the
 Redistributables to their end users".  We take this to mean that we can
 give them to you, but you can't give them to anyone else, which is
 something that we can't agree to.  Fortunately, we
-have our own Win32 headers which are pretty complete.
+have our own Windows headers which are pretty complete.
 </para>
 </answer></qandaentry>
 
-- 
2.28.0

