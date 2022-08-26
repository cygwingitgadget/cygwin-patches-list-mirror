Return-Path: <jon.turney@dronecode.org.uk>
Received: from re-prd-fep-045.btinternet.com (mailomta5-re.btinternet.com [213.120.69.98])
	by sourceware.org (Postfix) with ESMTPS id 827673858427
	for <cygwin-patches@cygwin.com>; Fri, 26 Aug 2022 13:00:16 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 827673858427
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=dronecode.org.uk
Received: from re-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.54.6])
          by re-prd-fep-045.btinternet.com with ESMTP
          id <20220826130014.VXWQ3219.re-prd-fep-045.btinternet.com@re-prd-rgout-003.btmx-prd.synchronoss.net>;
          Fri, 26 Aug 2022 14:00:14 +0100
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 61A69BAC2ADD0987
X-Originating-IP: [86.139.158.127]
X-OWM-Source-IP: 86.139.158.127 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvfedrvdejhedgheejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepleeitdejhfdtveekheeugeffgeevfedtjeejveefhfeiffefkedtvdetheehieejnecukfhppeekiedrudefledrudehkedruddvjeenucevlhhushhtvghrufhiiigvpeehnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddufeelrdduheekrdduvdejpdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdpnhgspghrtghpthhtohepvddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmpdhrtghpthhtohepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.139.158.127) by re-prd-rgout-003.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as jonturney@btinternet.com)
        id 61A69BAC2ADD0987; Fri, 26 Aug 2022 14:00:14 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 6/6] Cygwin: testsuite: Add x86_64 code to "dynamically load cygwin" test
Date: Fri, 26 Aug 2022 13:59:42 +0100
Message-Id: <20220826125943.49-7-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220826125943.49-1-jon.turney@dronecode.org.uk>
References: <20220826125943.49-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1197.3 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,GIT_PATCH_0,KAM_DMARC_STATUS,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This still needs some more voudou to actually work.

Also update how-cygtls-works.txt a bit
---
 winsup/cygwin/DevDocs/how-cygtls-works.txt | 25 ++++++----------------
 winsup/testsuite/winsup.api/cygload.cc     | 22 ++++++++++++++++---
 winsup/testsuite/winsup.api/cygload.exp    |  8 ++++++-
 3 files changed, 32 insertions(+), 23 deletions(-)

diff --git a/winsup/cygwin/DevDocs/how-cygtls-works.txt b/winsup/cygwin/DevDocs/how-cygtls-works.txt
index e4f694118..633c4da96 100644
--- a/winsup/cygwin/DevDocs/how-cygtls-works.txt
+++ b/winsup/cygwin/DevDocs/how-cygtls-works.txt
@@ -4,8 +4,8 @@ All cygwin threads have separate context in an object of class _cygtls.  The
 storage for this object is kept on the stack in the bottom __CYGTLS_PADSIZE__
 bytes.  Each thread references the storage via the Thread Environment Block
 (aka Thread Information Block), which Windows maintains for each user thread
-in the system, with the address in the FS segment register.  The memory
-is laid out as in the NT_TIB structure from <w32api/winnt.h>:
+in the system, with the address in a segment register (FS on x86, GS on x86_64).
+The memory is laid out as in the NT_TIB structure from <w32api/winnt.h>:
 
 typedef struct _NT_TIB {
 	struct _EXCEPTION_REGISTRATION_RECORD *ExceptionList;
@@ -20,16 +20,10 @@ typedef struct _NT_TIB {
 	struct _NT_TIB *Self;
 } NT_TIB,*PNT_TIB;
 
-Cygwin sees it like this:
-
-extern exception_list *_except_list asm ("%fs:0");      // exceptions.cc
-extern char *_tlsbase __asm__ ("%fs:4");                // cygtls.h
-extern char *_tlstop __asm__ ("%fs:8");                 // cygtls.h
-
-And accesses cygtls like this:
-
-#define _my_tls (((_cygtls *) _tlsbase)[-1])            // cygtls.h
+Cygwin accesses cygtls like this (see cygtls.h):
 
+#define _my_tls (*((_cygtls *) ((PBYTE) NtCurrentTeb()->Tib.StackBase \
+		                - __CYGTLS_PADSIZE__)))
 
 Initialization always goes through _cygtls::init_thread().  It works
 in the following ways:
@@ -65,11 +59,4 @@ __CYGTLS_PADSIZE__ bytes down from there are overwritten.
 
 Debugging
 
-You can examine the segment registers in gdb via "info w32 selector $fs"
-(which is using GetThreadSelectorEntry()) to get results like this:
-
-    Selector $fs
-    0x03b: base=0x7ffdd000 limit=0x00000fff 32-bit Data (Read/Write, Exp-up)
-    Priviledge level = 3. Byte granular.
-
-"x/3x 0x7ffdd000" will give you _except_list, _tlsbase, and _tlstop.
+You can examine the TIB in gdb via "info w32 tib"
diff --git a/winsup/testsuite/winsup.api/cygload.cc b/winsup/testsuite/winsup.api/cygload.cc
index faad5ce0e..f5ca8db9a 100644
--- a/winsup/testsuite/winsup.api/cygload.cc
+++ b/winsup/testsuite/winsup.api/cygload.cc
@@ -43,7 +43,10 @@ using std::string;
 cygwin::padding *cygwin::padding::_main = NULL;
 DWORD cygwin::padding::_mainTID = 0;
 
-// A few cygwin constants.
+// Cygwin signal constants
+#undef SIGINT
+#undef SIGTERM
+
 static const int SIGHUP = 1;
 static const int SIGINT = 2;
 static const int SIGTERM = 15;  // Cygwin won't deliver this one to us;
@@ -68,17 +71,30 @@ cygwin::padding::padding ()
 
   _end = _padding + sizeof (_padding);
   char *stackbase;
-#ifdef __GNUC__
+#ifdef __GNUC__ /* GCC */
+# ifdef __x86_64__
+    __asm__ (
+    "mov %%gs:8, %0"
+    :"=r"(stackbase)
+    );
+# elif __X86__
   __asm__ (
     "movl %%fs:4, %0"
     :"=r"(stackbase)
     );
-#else
+# else
+#  error Unknown architecture
+# endif
+#else /* !GCC assumed to be MSVC */
+# ifdef __X86__
   __asm
       {
         mov eax, fs:[4];
         mov stackbase, eax;
       }
+#else
+#  error Unknown architecture
+# endif
 #endif
   _stackbase = stackbase;
 
diff --git a/winsup/testsuite/winsup.api/cygload.exp b/winsup/testsuite/winsup.api/cygload.exp
index e7b439512..8ba8249bb 100644
--- a/winsup/testsuite/winsup.api/cygload.exp
+++ b/winsup/testsuite/winsup.api/cygload.exp
@@ -14,7 +14,13 @@ proc ws_spawn {cmd args} {
     verbose send "catchCode = $rv\n"
 }
 
-ws_spawn "$MINGW_CXX $srcdir/$subdir/cygload.cc -o mingw-cygload.exe -lstdc++ -Wl,-e,_cygloadCRTStartup@0"
+if { [string match "i686" $target_alias] } {
+    set entrypoint "_cygloadCRTStartup@0"
+} else {
+    set entrypoint "cygloadCRTStartup"
+}
+
+ws_spawn "$MINGW_CXX $srcdir/$subdir/cygload.cc -o mingw-cygload.exe -static -Wl,-e,$entrypoint"
 
 if { $rv != {0 {}} } {
     verbose -log "$rv"
-- 
2.37.2

