Return-Path: <cygwin-patches-return-7494-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18780 invoked by alias); 26 Aug 2011 02:09:02 -0000
Received: (qmail 18661 invoked by uid 22791); 26 Aug 2011 02:08:59 -0000
X-SWARE-Spam-Status: No, hits=-1.1 required=5.0	tests=AWL,BAYES_00,SPF_NEUTRAL,TW_GJ
X-Spam-Check-By: sourceware.org
Received: from smtp3.epfl.ch (HELO smtp3.epfl.ch) (128.178.224.226)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Fri, 26 Aug 2011 02:08:45 +0000
Received: (qmail 10327 invoked by uid 107); 26 Aug 2011 02:08:41 -0000
Received: from 76-10-180-162.dsl.teksavvy.com (HELO discarded) (76.10.180.162) (authenticated)  by smtp3.epfl.ch (AngelmatoPhylax SMTP proxy) with ESMTPA; Fri, 26 Aug 2011 04:08:41 +0200
Message-ID: <4E570027.9050300@cs.utoronto.ca>
Date: Fri, 26 Aug 2011 02:09:00 -0000
From: Ryan Johnson <ryan.johnson@cs.utoronto.ca>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:5.0) Gecko/20110624 Thunderbird/5.0
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Extend faq.using to discuss fork failures
Content-Type: multipart/mixed; boundary="------------010300080504070607040905"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q3/txt/msg00070.txt.bz2

This is a multi-part message in MIME format.
--------------010300080504070607040905
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 413

Hi all,

Based on the feedback on cygwin-dev, I've put together a revised pair of 
faq.using entries: one listing briefly the symptoms of fork failures and 
what to do about it, and the other giving some details about why fork 
fails (sometimes in spite of everything we do to compensate).

         * faq-using.xml (faq.using.fixing-fork-failures): Add.
         (faq.using.why-fork-fails): Add.

Thoughts?
Ryan

--------------010300080504070607040905
Content-Type: text/plain;
 name="faq-fork-patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="faq-fork-patch.txt"
Content-length: 5353

Index: winsup/doc/faq-using.xml
===================================================================
RCS file: /cvs/src/src/winsup/doc/faq-using.xml,v
retrieving revision 1.35
diff -u -r1.35 faq-using.xml
--- winsup/doc/faq-using.xml	4 Aug 2011 18:25:41 -0000	1.35
+++ winsup/doc/faq-using.xml	26 Aug 2011 01:58:44 -0000
@@ -1199,3 +1199,92 @@
 </listitem>
 </itemizedlist></para>
 </answer></qandaentry>
+<qandaentry id='faq.using.fixing-fork-failures'>
+  <question><para>Calls to <literal>fork</literal> fail a lot. How can
+  I fix the problem?</para></question>
+  <answer>
+
+  <para>Unix-like applications make extensive use of
+  <literal>fork</literal>, a function which spawns an exact copy of
+  the running process. Notable fork-using applications include bash
+  (and bash scripts), emacs, gcc, make, perl, python, and
+  ruby. Unfortunately, the Windows ecosystem is quite hostile to a
+  reliable fork implementation, leading to error messages such as:</para>
+  <para><itemizedlist>
+    <listitem>unable to remap <emphasis>$dll</emphasis> to same address as parent</listitem>
+    <listitem>couldn't allocate heap </listitem>
+    <listitem>died waiting for dll loading </listitem>
+    <listitem>child -1 - died waiting for longjmp before initialization</listitem>
+    <listitem>STATUS_ACCESS_VIOLATION </listitem>
+    <listitem>resource temporarily unavailable </listitem>
+  </itemizedlist></para>
+  <para>If you find that frequent fork failures interfere with normal
+  use of cygwin, please try the following: </para>
+  <para><itemizedlist>
+    <listitem>Restart whatever process is trying (and failing) to use
+    <literal>fork</literal>. Sometimes Windows sets up a process
+    environment that is even more hostile to fork than usual.</listitem>
+    <listitem>Ensure that you have eliminated (not just disabled) all
+    software on the BLODA (see <ulink
+    url="http://cygwin.com/faq/faq.using.html#faq.using.bloda"
+    />)</listitem>
+    <listitem>Install the 'rebase' package, read its README in
+    <literal>/usr/share/doc/Cygwin</literal>, and follow the
+    instructions there to run 'rebaseall'.</listitem>
+    </itemizedlist></para>
+  <para>Please note that installing new packages or updating existing
+  ones often undoes the effects of rebaseall and cause fork failures
+  to reappear. If so, just run rebaseall again.
+  </para></answer>
+</qandaentry>
+<qandaentry id='faq.using.why-fork-fails'>
+  <question><para>Why does <literal>fork</literal> fail so much,
+  anyway? (or: Why does <literal>fork</literal> still fail even though
+  I ran rebaseall?)</para></question>
+  <answer>
+  <para>The semantics of <literal>fork</literal> require that a forked
+  child process have <emphasis>exactly</emphasis> the same address
+  space layout as its parent. However, Windows provides no native
+  support for cloning address space between processes and several
+  features actively undermine a reliable <literal>fork</literal>
+  implementation. Three issues are especially prevalent:</para>
+  <para><itemizedlist>
+    <listitem>DLL base address collisions. Unlike *nix shared
+    libraries, which use "position-independent code", Windows shared
+    libraries assume a fixed base address. Whenever the hard-wired
+    address ranges of two DLLs collide (which occurs quite often), the
+    Windows loader must "rebase" one of them to a different
+    address. However, it does not resolve collisions consistently, and
+    may rebase a different dll and/or move it to a different address
+    every time. Cygwin can usually compensate for this effect when it
+    involves libraries opened dynamically, but collisions among
+    statically-linked dlls (dependencies known at compile time) are
+    resolved before <literal>cygwin1.dll</literal> initializes and
+    cannot be fixed afterward. This problem can only be solved by
+    removing the base address conflicts which cause the problem,
+    usually using the <literal>rebaseall</literal> package.</listitem>
+
+    <listitem>Address space layout randomization (ASLR). Starting with
+    Vista, Windows implements ASLR, which means that thread stacks,
+    heap, memory-mapped files, and statically-linked dlls are placed
+    at different (random) locations in each process. This behavior
+    interferes with a proper <literal>fork</literal>, and if an
+    unmovable object (process heap or system dll) ends up at the wrong
+    location, Cygwin can do nothing to compensate (though it will
+    retry a few times automatically). In a 64-bit system, marking
+    executables as large address-ware and rebasing dlls to high
+    addresses has been reported to help, as ASLR affects only the
+    lower 2GB of address space.</listitem>
+
+    <listitem>DLL injection by BLODA. Badly-behaved applications which
+    inject dlls into other processes often manage to clobber important
+    sections of the child's address space, leading to base address
+    collisions which rebasing cannot fix. The only way to resolve this
+    problem is to remove (usually uninstall) the offending
+    app.</listitem></itemizedlist></para>
+    <para>In summary, current Windows implementations make it
+    impossible to implement a perfectly reliable fork, and occasional
+    fork failures are inevitable. PTC.
+    </para>
+  </answer>
+</qandaentry>

--------------010300080504070607040905--
