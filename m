Return-Path: <jon.turney@dronecode.org.uk>
Received: from sa-prd-fep-042.btinternet.com (mailomta31-sa.btinternet.com
 [213.120.69.37])
 by sourceware.org (Postfix) with ESMTPS id 66D1B3851C13
 for <cygwin-patches@cygwin.com>; Sun, 29 May 2022 14:03:33 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 66D1B3851C13
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=dronecode.org.uk
Received: from sa-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.38.8])
 by sa-prd-fep-042.btinternet.com with ESMTP id
 <20220529140332.GYLT3231.sa-prd-fep-042.btinternet.com@sa-prd-rgout-005.btmx-prd.synchronoss.net>;
 Sun, 29 May 2022 15:03:32 +0100
Authentication-Results: btinternet.com;
 auth=pass (LOGIN) smtp.auth=jonturney@btinternet.com;
 bimi=skipped
X-SNCR-Rigid: 6139452E268FCC52
X-Originating-IP: [86.139.167.41]
X-OWM-Source-IP: 86.139.167.41 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvfedrkeeggdeikecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeejkedtgeekleetueegfeetgeeuveffteffheevgfdtgfdvledtgeegiedtieekffenucffohhmrghinhepshhouhhrtggvfigrrhgvrdhorhhgnecukfhppeekiedrudefledrudeijedrgedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudefledrudeijedrgedupdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdpnhgspghrtghpthhtohepvddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmpdhrtghpthhtohepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.139.167.41) by
 sa-prd-rgout-005.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as
 jonturney@btinternet.com)
 id 6139452E268FCC52; Sun, 29 May 2022 15:03:32 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH] Cygwin: Set threadnames with SetThreadDescription()
Date: Sun, 29 May 2022 15:03:15 +0100
Message-Id: <20220529140315.18306-1-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1199.2 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 GIT_PATCH_0, KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_DNSWL_NONE,
 SPF_HELO_PASS, SPF_NONE, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
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
X-List-Received-Date: Sun, 29 May 2022 14:03:35 -0000

gdb master recently learnt how to use GetThreadDescription() [1], so set
threadnames using SetThreadDescription() [available since Windows
101607] as well.

This is superior to using a special exception to indicate the thread
name to the debugger, because the thread name isn't missed if you don't
have a debugger attached at the time it's set.

It's not clear what the encoding of a thread name string is, we assume
UTF8 for the moment.

For the moment, continue to use the old method as well, for the benefit
of older gdb versions etc.

[1] https://sourceware.org/pipermail/gdb-patches/2022-April/187833.html
---
 winsup/cygwin/autoload.cc  |  1 +
 winsup/cygwin/miscfuncs.cc | 33 +++++++++++++++++++++++++++++++--
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/autoload.cc b/winsup/cygwin/autoload.cc
index 1f52411d8..cb564d173 100644
--- a/winsup/cygwin/autoload.cc
+++ b/winsup/cygwin/autoload.cc
@@ -592,6 +592,7 @@ LoadDLLfuncEx (PrefetchVirtualMemory, 16, kernel32, 1)
 LoadDLLfunc (QueryInterruptTime, 4, KernelBase)
 LoadDLLfunc (QueryInterruptTimePrecise, 4, KernelBase)
 LoadDLLfunc (QueryUnbiasedInterruptTimePrecise, 4, KernelBase)
+LoadDLLfuncEx (SetThreadDescription, 8, KernelBase, 1)
 LoadDLLfunc (VirtualAlloc2, 28, KernelBase)
 
 LoadDLLfunc (NtMapViewOfSectionEx, 36, ntdll)
diff --git a/winsup/cygwin/miscfuncs.cc b/winsup/cygwin/miscfuncs.cc
index 739d9de3b..546df929a 100644
--- a/winsup/cygwin/miscfuncs.cc
+++ b/winsup/cygwin/miscfuncs.cc
@@ -18,6 +18,9 @@ details. */
 #include "tls_pbuf.h"
 #include "mmap_alloc.h"
 
+/* not yet prototyped in w32api */
+extern "C" HRESULT WINAPI SetThreadDescription(HANDLE hThread, PCWSTR lpThreadDescription);
+
 /* Get handle count of an object. */
 ULONG
 get_obj_handle_count (HANDLE h)
@@ -993,8 +996,8 @@ wmempcpy:								\n\
 
 #define MS_VC_EXCEPTION 0x406D1388
 
-void
-SetThreadName(DWORD dwThreadID, const char* threadName)
+static void
+SetThreadNameExc(DWORD dwThreadID, const char* threadName)
 {
   if (!IsDebuggerPresent ())
     return;
@@ -1025,6 +1028,32 @@ SetThreadName(DWORD dwThreadID, const char* threadName)
   __endtry
 }
 
+void
+SetThreadName(DWORD dwThreadID, const char* threadName)
+{
+  HANDLE hThread = OpenThread (THREAD_SET_LIMITED_INFORMATION, FALSE, dwThreadID);
+  if (hThread)
+    {
+      /* SetThreadDescription only exists in a wide-char version, so we must
+	 convert threadname to wide-char.  The encoding of threadName is
+	 unclear, so use UTF8 until we know better. */
+      int bufsize = MultiByteToWideChar (CP_UTF8, 0, threadName, -1, NULL, 0);
+      WCHAR buf[bufsize];
+      bufsize = MultiByteToWideChar (CP_UTF8, 0, threadName, -1, buf, bufsize);
+      HRESULT hr = SetThreadDescription (hThread, buf);
+      if (hr != S_OK)
+	{
+	  debug_printf ("SetThreadDescription() failed. %08x %08x\n",
+			GetLastError (), hr);
+	}
+      CloseHandle (hThread);
+    }
+
+  /* also use the older, exception-based method of setting threadname for the
+     benefit of things which don't known about GetThreadDescription. */
+  SetThreadNameExc(dwThreadID, threadName);
+}
+
 #define add_size(p,s) ((p) = ((__typeof__(p))((PBYTE)(p)+(s))))
 
 static WORD num_cpu_per_group = 0;
-- 
2.36.1

