Return-Path: <mark@maxrnd.com>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
 by sourceware.org (Postfix) with ESMTPS id 9280439AF4CF
 for <cygwin-patches@cygwin.com>; Fri, 16 Jul 2021 04:50:23 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 9280439AF4CF
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=maxrnd.com
Received: (from daemon@localhost)
 by m0.truegem.net (8.12.11/8.12.11) id 16G4oMKk050429;
 Thu, 15 Jul 2021 21:50:22 -0700 (PDT) (envelope-from mark@maxrnd.com)
Received: from 162-235-43-67.lightspeed.irvnca.sbcglobal.net(162.235.43.67),
 claiming to be "localhost.localdomain"
 via SMTP by m0.truegem.net, id smtpduVHy2X; Thu Jul 15 21:50:15 2021
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH 3/3] Cygwin: updates to wire in profiler, gmondump
Date: Thu, 15 Jul 2021 21:49:57 -0700
Message-Id: <20210716044957.5298-3-mark@maxrnd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210716044957.5298-1-mark@maxrnd.com>
References: <20210716044957.5298-1-mark@maxrnd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.1 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, SPF_HELO_NONE, SPF_NONE,
 TXREP autolearn=ham autolearn_force=no version=3.4.4
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
X-List-Received-Date: Fri, 16 Jul 2021 04:50:25 -0000

These are updates to wire into the build tree the new tools profiler and
gmondump, and to supply documentation for the tools.

The documentation for profiler and ssp now mention each other but do not
discuss their similarities or differences.  That will be handled in a
future update to the "Profiling Cygwin Programs" section of the Cygwin
User's Guide, to be supplied.

---
 winsup/cygwin/release/3.2.1 |   7 ++
 winsup/doc/utils.xml        | 123 ++++++++++++++++++++++++++++++++++++
 winsup/utils/Makefile.am    |   5 ++
 3 files changed, 135 insertions(+)

diff --git a/winsup/cygwin/release/3.2.1 b/winsup/cygwin/release/3.2.1
index 99c65ce30..4f4db622a 100644
--- a/winsup/cygwin/release/3.2.1
+++ b/winsup/cygwin/release/3.2.1
@@ -1,6 +1,13 @@
 What's new:
 -----------
 
+- An IP-sampling profiler named 'profiler' has been added.  It can be used
+  to profile any Cygwin program along with any DLLs loaded.
+
+- A new tool 'gmondump' has been added.  It can dump the raw information
+  of any "gmon.out" file created by profiler, ssp, or use of the gcc/g++
+  option '-pg'.  (Continue using gprof to get symbolic profile displays.)
+
 
 What changed:
 -------------
diff --git a/winsup/doc/utils.xml b/winsup/doc/utils.xml
index 1d9b8488c..0b7b5d0ea 100644
--- a/winsup/doc/utils.xml
+++ b/winsup/doc/utils.xml
@@ -793,6 +793,56 @@ line separates the ACLs for each file.
     </refsect1>
   </refentry>
 
+  <refentry id="gmondump">
+    <refmeta>
+      <refentrytitle>gmondump</refentrytitle>
+      <manvolnum>1</manvolnum>
+      <refmiscinfo class="manual">Cygwin Utilities</refmiscinfo>
+    </refmeta>
+
+    <refnamediv>
+      <refname>gmondump</refname>
+      <refpurpose>Display formatted contents of profile data files</refpurpose>
+    </refnamediv>
+
+    <refsynopsisdiv>
+    <screen>
+gmondump [OPTION]... FILENAME...
+    </screen>
+    </refsynopsisdiv>
+
+    <refsect1 id="gmondump-options">
+      <title>Options</title>
+      <screen>
+  -h, --help             Display usage information and exit
+  -v, --verbose          Display more file details (toggle: default false)
+  -V, --version          Display version information and exit
+</screen>
+    </refsect1>
+
+    <refsect1 id="gmondump-desc">
+      <title>Description</title>
+    <para>The <command>gmondump</command> utility displays the contents of
+      one or more profile data files. Such files usually have names starting
+      with "gmon.out" and are created by a profiling program such as
+      <command>profiler</command> or <command>ssp</command>. Compiling your
+      gcc/g++ programs with option <literal>-pg</literal> also works.</para>
+    <para> By default, summary information is shown. You can use the
+      option <literal>-v</literal> to get more detailed displays.</para>
+    <para>Note that <command>gmondump</command> just displays the raw data;
+      one would usually use <command>gprof</command> to display the data in
+      a useful form incorporating symbolic info such as function names and
+      source line numbers.</para>
+    <para>Here is an example of <command>gmondump</command> operation:</para>
+<screen>
+$ gmondump gmon.out.21900.zstd.exe
+file gmon.out.21900.zstd.exe, gmon version 0x51879, sample rate 100
+  address range 0x0x100401000..0x0x1004cc668
+  numbuckets 208282, hitbuckets 1199, hitcount 12124, numrawarcs 0
+</screen>
+    </refsect1>
+  </refentry>
+
   <refentry id="kill">
     <refmeta>
       <refentrytitle>kill</refentrytitle>
@@ -2127,6 +2177,75 @@ specifying an empty password.
     </refsect1>
   </refentry>
 
+  <refentry id="profiler">
+    <refmeta>
+      <refentrytitle>profiler</refentrytitle>
+      <manvolnum>1</manvolnum>
+      <refmiscinfo class="manual">Cygwin Utilities</refmiscinfo>
+    </refmeta>
+
+    <refnamediv>
+      <refname>profiler</refname>
+      <refpurpose>Sampling profiler of Cygwin programs with their DLLs</refpurpose>
+    </refnamediv>
+
+    <refsynopsisdiv>
+    <screen>
+profiler [OPTION]... PROGRAM [ARG]...
+profiler [OPTION]... -p PID
+    </screen>
+    </refsynopsisdiv>
+
+    <refsect1 id="profiler-options">
+      <title>Options</title>
+      <screen>
+  -d, --debug            Display debugging messages (toggle: default false)
+  -e, --events           Display Windows DEBUG_EVENTS (toggle: default false)
+  -f, --fork-profile     Profiles child processes (toggle: default false)
+  -h, --help             Display usage information and exit
+  -o, --output=FILENAME  Write output to file FILENAME rather than stdout
+  -p, --pid=N            Attach to running program with Cygwin pid N
+                         ...                    or with Windows pid -N
+  -s, --sample-rate=N    Set IP sampling rate to N Hz (default 100)
+  -v, --verbose          Display more status messages (toggle: default false)
+  -V, --version          Display version information and exit
+  -w, --new-window       Launch given command in a new window
+</screen>
+    </refsect1>
+
+    <refsect1 id="profiler-desc">
+      <title>Description</title>
+    <para>The <command>profiler</command> utility executes a given program, and
+      optionally the children of that program, collecting the location of the
+      CPU instruction pointer (IP) many times per second. This gives a profile
+      of the program's execution, showing where the most time is being spent.
+      This profiling technique is called "IP sampling".</para>
+
+    <para>A novel feature of <command>profiler</command> is that time spent in
+      DLLs loaded with or by your program is profiled too. You use
+      <command>gprof</command> to process and display the resulting profile
+      information. In this fashion you can determine whether your own code,
+      the Cygwin DLL, or another DLL has "hot spots" that might benefit from
+      tuning.</para>
+
+    <para>(See also <command>ssp</command>, another profiler that
+      operates in a different fashion: stepping by instruction. This can
+      provide a different view on your program's operation.)</para>
+
+    <para>Here is an example of <command>profiler</command> operation:</para>
+<screen>
+$ profiler du -khs .
+22G     .
+97 samples across 83 buckets written to gmon.out.5908.cygwin1.dll
+4 samples across 4 buckets written to gmon.out.5908.KernelBase.dll
+1 sample across 1 bucket written to gmon.out.5908.kernel32.dll
+7318 samples across 42 buckets written to gmon.out.5908.ntdll.dll
+5 samples across 4 buckets written to gmon.out.5908.du.exe
+</screen>
+    </refsect1>
+
+  </refentry>
+
   <refentry id="ps">
     <refmeta>
       <refentrytitle>ps</refentrytitle>
@@ -2775,6 +2894,10 @@ Example: ssp 0x401000 0x403000 hello.exe
       <command>gprof</command> will claim the values are seconds, they really
       are instruction counts. More on that later. </para>
 
+    <para>(See also <command>profiler</command>, another profiler that
+      operates in a different fashion: IP sampling. This can provide a
+      different view on your program's operation.)</para>
+
     <para> Because the SSP was originally designed to profile the Cygwin DLL,
       it does not automatically select a block of code to report statistics on.
       You must specify the range of memory addresses to keep track of manually,
diff --git a/winsup/utils/Makefile.am b/winsup/utils/Makefile.am
index 9a846e39d..135e6143c 100644
--- a/winsup/utils/Makefile.am
+++ b/winsup/utils/Makefile.am
@@ -21,6 +21,7 @@ bin_PROGRAMS = \
 	gencat \
 	getconf \
 	getfacl \
+	gmondump \
 	kill \
 	ldd \
 	locale \
@@ -31,6 +32,7 @@ bin_PROGRAMS = \
 	mount \
 	passwd \
 	pldd \
+	profiler \
 	regtool \
 	setfacl \
 	setmetamode \
@@ -54,6 +56,7 @@ ldd_SOURCES = ldd.cc
 locale_SOURCES = locale.cc
 minidumper_SOURCES = minidumper.cc
 mount_SOURCES = mount.cc path.cc
+profiler_SOURCES = profiler.cc path.cc
 cygps_SOURCES = ps.cc
 regtool_SOURCES = regtool.cc
 umount_SOURCES = umount.cc
@@ -79,6 +82,8 @@ ldd_LDADD = $(LDADD) -lpsapi -lntdll
 mount_CXXFLAGS = -DFSTAB_ONLY $(AM_CXXFLAGS)
 minidumper_LDADD = $(LDADD) -ldbghelp
 pldd_LDADD = $(LDADD) -lpsapi
+profiler_CXXFLAGS = -I$(srcdir) -idirafter ${top_srcdir}/cygwin -idirafter ${top_srcdir}/cygwin/include $(AM_CXXFLAGS)
+profiler_LDADD = $(LDADD) -lntdll
 cygps_LDADD = $(LDADD) -lpsapi -lntdll
 
 if CROSS_BOOTSTRAP
-- 
2.31.1

