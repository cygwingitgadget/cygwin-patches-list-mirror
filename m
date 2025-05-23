Return-Path: <SRS0=TDm/=YH=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo005.btinternet.com (btprdrgo005.btinternet.com [65.20.50.218])
	by sourceware.org (Postfix) with ESMTP id 6DAAF3858C60
	for <cygwin-patches@cygwin.com>; Fri, 23 May 2025 16:41:27 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 6DAAF3858C60
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 6DAAF3858C60
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.218
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1748018487; cv=none;
	b=WvhPohOCrXHvOFN2lKMV7eFwprRP2QWyOSb3uYU8jWBz0XK/ATvwoAn8sajY+OONnU9CJvlWPwW5hh3dBvUztb1gT6wZktifo018yA7LqcNTdStD+5Dkdw0JSSGeVelpZ7bUsmGUkS1VYBJS5w5A1Oc0vhPryN9zkY2AvBg/G8g=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1748018487; c=relaxed/simple;
	bh=JOSgGFr8vGlcrtPHZEvu72VyfS9LdVgj/RST5xpMGwc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=LXEwuRkJLvFjCUKJCqRcIGwCvfhek+PITEE7i0B0r0VvzQ+WTDdu357TGWyrLDnRzmvLehO8WCsMqxnOSZ4yTLzA6NUPhLVo8x+oKHNGocTDJYoHHHmbDUp2cajN+L98CneNw9sgVq2kGPXgtJZ0/Ad396fyvrSEXP4OwdKvvHs=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 6DAAF3858C60
Authentication-Results: btinternet.com;
    auth=pass (LOGIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 67D89CDB0778431E
X-Originating-IP: [81.129.146.154]
X-OWM-Source-IP: 81.129.146.154
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdelfeeiucdltddurdegfedvrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepfffgtdeuteetleegvdelfefftedtlefggeeffedtudehgeefudelffehieeuvdeunecuffhomhgrihhnpehgnhhurdhorhhgpdhmihhnghifrdhorhhgnecukfhppeekuddruddvledrudegiedrudehgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkedurdduvdelrddugeeirdduheegpdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdprhgvvhfkrfephhhoshhtkeduqdduvdelqddugeeiqdduheegrdhrrghnghgvkeduqdduvdelrdgsthgtvghnthhrrghlphhluhhsrdgtohhmpdgruhhthhgpuhhsvghrpehjohhnthhurhhnvgihsegsthhinhhtvghrnhgvthdrtghomhdpghgvohfkrfepifeupdfovfetjfhoshhtpegsthhprhgurhhgohdttdehpdhnsggprhgtphhtthhopedvpdhr
	tghpthhtoheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomhdprhgtphhtthhopehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhk
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (81.129.146.154) by btprdrgo005.btinternet.com (authenticated as jonturney@btinternet.com)
        id 67D89CDB0778431E; Fri, 23 May 2025 17:41:26 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH] Cygwin: doc: Update "building DLL"
Date: Fri, 23 May 2025 17:41:02 +0100
Message-ID: <20250523164102.16035-1-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,KAM_SHORT,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This hasn't substantially been revised since (at least) 2004, and
doesn't really represent normal usage of modern gcc and binutils.
---
 winsup/doc/dll.xml | 168 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 127 insertions(+), 41 deletions(-)

diff --git a/winsup/doc/dll.xml b/winsup/doc/dll.xml
index f0369760f..7117b65bd 100644
--- a/winsup/doc/dll.xml
+++ b/winsup/doc/dll.xml
@@ -19,26 +19,47 @@ variables, etc.  All these are merged together, like if you were
 building one big object files, and put into the dll.  They are not
 put into your .exe at all.</para>
 
-<para>The exports contains a list of functions and variables that the
+<para>The exports is a list of functions and variables that the
 dll makes available to other programs.  Think of this as the list of
-"global" symbols, the rest being hidden.  Normally, you'd create this
-list by hand with a text editor, but it's possible to do it
-automatically from the list of functions in your code.  The
-<filename>dlltool</filename> program creates the exports section of
-the dll from your text file of exported symbols.</para>
-
-<para>The import library is a regular UNIX-like
-<filename>.a</filename> library, but it only contains the tiny bit of
-information needed to tell the OS how your program interacts with
-("imports") the dll.  This information is linked into your
-<filename>.exe</filename>.  This is also generated by
-<filename>dlltool</filename>.</para>
+"public" symbols, the rest being hidden.
+
+<footnote>
+  <para>
+    Note that <filename>ld</filename>'s default behaviour is to export all
+    global symbols, if there otherwise wouldn't be any exported symbols
+    (i.e. because you haven't specified a def file or made any export
+    annotations). (See <code>--export-all-symbols</code> in the
+    <filename>ld</filename> man page for more details.)
+  </para>
+</footnote>
+
+This list can be in a module definition (.def) file, which you can write by hand
+with a text editor, but it's also possible to have it generated automatically
+from the functions and variables in your code, by annotating the declarations
+with <code>__attribute__ ((dllexport))</code>.
+
+<footnote>
+  <para>
+    If you're making these annotations on the declarations in a header which is
+    also installed to be included by users of your library, you probably want to
+    use macros to do the right thing and increase portability.  See <ulink
+    url="https://gcc.gnu.org/wiki/Visibility">this example</ulink> for details.
+  </para>
+</footnote>
+
+</para>
+
+<para>The import library is a regular UNIX-like <filename>.a</filename> library,
+but it only contains the tiny bit of information ("a stub") needed to tell the
+OS how your program interacts with ("imports") the dll.  This information is
+linked into your <filename>.exe</filename>.
+</para>
 
 <sect2 id="dll-build"><title>Building DLLs</title>
 
-<para>This page gives only a few simple examples of gcc's DLL-building 
+<para>This page gives only a few simple examples of gcc's DLL-building
 capabilities. To begin an exploration of the many additional options,
-see the gcc documentation and website, currently at 
+see the gcc documentation and website, currently at
 <ulink url="http://gcc.gnu.org/">http://gcc.gnu.org/</ulink>
 </para>
 
@@ -49,8 +70,8 @@ For this example, we'll use a single file
 <filename>mydll.c</filename> for the contents of the dll
 (<filename>mydll.dll</filename>).</para>
 
-<para>Fortunately, with the latest gcc and binutils the process for building a dll
-is now pretty simple. Say you want to build this minimal function in mydll.c:</para>
+<para>Say you want to build this minimal function in
+<filename>mydll.c</filename>:</para>
 
 <screen>
 #include &lt;stdio.h&gt;
@@ -59,28 +80,44 @@ int
 hello()
 {
   printf ("Hello World!\n");
-}  
+}
 </screen>
 
-<para>First compile mydll.c to object code:</para>
+<para>First compile <filename>mydll.c</filename> to the object
+<filename>mydll.o</filename>:</para>
 
 <screen>gcc -c mydll.c</screen>
 
 <para>Then, tell gcc that it is building a shared library:</para>
 
-<screen>gcc -shared -o mydll.dll mydll.o</screen>
+<screen>gcc -shared -o mydll.dll mydll.o -Wl,--out-implib libmydll.a</screen>
 
 <para>
-That's it! To finish up the example, you can now link to the
-dll with a simple program:
+  That's it! You now have the dll (<filename>mydll.dll</filename>) and the
+  import library (<filename>libmydll.a</filename>).
+
+<footnote>
+  <para>
+    In fact, <code>--out-implib</code> is optional in this simple example,
+    because <filename>ld</filename> can automatically generate import stubs when
+    told to link directly to a .dll.  (See <code>--enable-auto-import</code> in
+    the <filename>ld</filename> man page for more details.)
+  </para>
+</footnote>
+
+</para>
+
+<para>
+To finish up the example, you can now link to the dll with a simple program,
+<filename>myprog.c</filename>:
 </para>
 
 <screen>
-int 
+int
 main ()
 {
   hello ();
-}  
+}
 </screen>
 
 <para>
@@ -89,35 +126,84 @@ Then link to your dll with a command like:
 
 <screen>gcc -o myprog myprog.c -L./ -lmydll</screen>
 
-<para>However, if you are building a dll as an export library,
-you will probably want to use the complete syntax:</para>
+<para>
+  Try it out:
+</para>
+
+<screen>
+$ ./myprog
+Hello World!
+</screen>
+
+<para>However, if you are building a dll for installation,
+you will probably want to use a more complex syntax:</para>
 
 <screen>gcc -shared -o cyg${module}.dll \
     -Wl,--out-implib=lib${module}.dll.a \
-    -Wl,--export-all-symbols \
-    -Wl,--enable-auto-import \
-    -Wl,--whole-archive ${old_libs} \
-    -Wl,--no-whole-archive ${dependency_libs}</screen>
+    -Wl,--whole-archive ${objs_libs} -Wl,--no-whole-archive \
+    ${dependency_libs}</screen>
 
-<para>
+<itemizedlist spacing="compact">
+<listitem>
 The name of your library is <literal>${module}</literal>, prefixed with
 <literal>cyg</literal> for the DLL and <literal>lib</literal> for the
-import library. Cygwin DLLs use the <literal>cyg</literal> prefix to 
-differentiate them from native-Windows MinGW DLLs, see 
-<ulink url="http://mingw.org">the MinGW website</ulink> for more details.
-<literal>${old_libs}</literal> are all
-your object files, bundled together in static libs or single object
-files and the <literal>${dependency_libs}</literal> are import libs you 
-need to link against, e.g 
-<userinput>'-lpng -lz -L/usr/local/special -lmyspeciallib'</userinput>.
+import library. Cygwin DLLs use the <literal>cyg</literal> prefix to
+differentiate them from native-Windows MinGW DLLs.
+</listitem>
+<listitem>
+<literal>${objs_libs}</literal> are all your object files, bundled together in
+static libs or single object files
+</listitem>
+<listitem>
+<literal>${dependency_libs}</literal> are static or import libs you need to link
+against, e.g <userinput>'-lpng -lz -L/usr/local/special -lmyspeciallib'
+</userinput>.
+</listitem>
+</itemizedlist>
+
+<para>
+  When the import library is installed into <filename>/usr/lib</filename>, it
+  can be linked to with just <code>-l${module}</code>. The dll itself is
+  installed into <filename>/usr/bin</filename> so it can be found on
+  <code>PATH</code> by the loader when a linked .exe is run.
+</para>
+
+</sect2>
+
+<sect2 id="dll-tool"><title>dlltool</title>
+
+<para>
+Historically, the process for building a dll with <filename>gcc</filename> and
+<filename>binutils</filename> wasn't so simple, and the
+<filename>dlltool</filename> tool was used:
+</para>
+
+<itemizedlist spacing="compact">
+  <listitem>
+    <para>
+      To create the exports section of the dll, from the module definition file
+      or by scanning object files.
+    </para>
+  </listitem>
+
+  <listitem>
+    <para>
+      To generate the import library.
+    </para>
+  </listitem>
+</itemizedlist>
+
+<para>
+  (See the <filename>dlltool</filename> man page for more details.)
 </para>
+
 </sect2>
 
-<sect2 id="dll-link"><title>Linking Against DLLs</title>
+<sect2 id="dll-link"><title>Linking Against Foreign DLLs</title>
 
 <para>If you have an existing DLL already, you need to build a
 Cygwin-compatible import library.  If you have the source to compile
-the DLL, see <xref linkend="dll-build"></xref> for details on having 
+the DLL, see <xref linkend="dll-build"></xref> for details on having
 <filename>gcc</filename> build one for you.  If you do not have the
 source or a supplied working import library, you can get most of
 the way by creating a .def file with these commands (you might need to
-- 
2.45.1

