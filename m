Return-Path: <jon.turney@dronecode.org.uk>
Received: from re-prd-fep-044.btinternet.com (mailomta28-re.btinternet.com [213.120.69.121])
	by sourceware.org (Postfix) with ESMTPS id 50467384B402
	for <cygwin-patches@cygwin.com>; Fri, 28 Oct 2022 15:06:17 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 50467384B402
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=dronecode.org.uk
Received: from re-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.54.8])
          by re-prd-fep-044.btinternet.com with ESMTP
          id <20221028150615.IWPC3224.re-prd-fep-044.btinternet.com@re-prd-rgout-005.btmx-prd.synchronoss.net>;
          Fri, 28 Oct 2022 16:06:15 +0100
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 613A91243FFB1274
X-Originating-IP: [86.139.199.187]
X-OWM-Source-IP: 86.139.199.187 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvgedrtdeigdekfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpefhgfekfeetheduleehjedvveduvdejjeeftdehieekgfeltdffkeetieduueeileenucffohhmrghinheptgihghifihhnrdgtohhmnecukfhppeekiedrudefledrudelledrudekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddufeelrdduleelrddukeejpdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdpnhgspghrtghpthhtohepvddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmpdhrtghpthhtohepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.139.199.187) by re-prd-rgout-005.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as jonturney@btinternet.com)
        id 613A91243FFB1274; Fri, 28 Oct 2022 16:06:15 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 2/3] Cygwin: Add addresses as module offsets in .stackdump file
Date: Fri, 28 Oct 2022 16:05:57 +0100
Message-Id: <20221028150558.2300-3-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221028150558.2300-1-jon.turney@dronecode.org.uk>
References: <20221028150558.2300-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1199.0 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,GIT_PATCH_0,KAM_DMARC_STATUS,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This adds an additional column to the stack trace in a .stackdump file,
which gives the stack frame return address as a module name+offset. This
makes it a possible to convert the address to a function name without
having to guess what module the address belongs to.

> Stack trace:
> Frame         Function     Args
> 0007FFFFCC30  0001004010E9 (000180048055, 000180046FA0, 000000000002, 00018031E160) segv-test.exe+0x10E9
> 0007FFFFCD30  0001800480C1 (000000000000, 000000000000, 000000000000, 000000000000) cygwin1.dll+0x80C1
> 0007FFFFFFF0  000180045C86 (000000000000, 000000000000, 000000000000, 000000000000) cygwin1.dll+0x5C86
> 0007FFFFFFF0  000180045D34 (000000000000, 000000000000, 000000000000, 000000000000) cygwin1.dll+0x5D34
> End of stack trace

Loosely based on this patch [1] by Brian Dessent.

[1] https://cygwin.com/pipermail/cygwin-patches/2008q1/006306.html
---
 winsup/cygwin/exceptions.cc | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
index a15bc16c5..1e9ea26bf 100644
--- a/winsup/cygwin/exceptions.cc
+++ b/winsup/cygwin/exceptions.cc
@@ -324,6 +324,34 @@ stack_info::walk ()
   return 1;
 }
 
+/*
+  Walk the list of modules in the current process to find the one containing
+   'func_va'.
+
+   This implementation requires no allocation of memory and minimal system
+   calls, so it should be safe in the context of an exception handler.
+*/
+static char *
+prettyprint_va (PVOID func_va)
+{
+  static char buf[256];
+  buf[0] = '\0';
+
+  PLIST_ENTRY head = &NtCurrentTeb()->Peb->Ldr->InMemoryOrderModuleList;
+  for (PLIST_ENTRY x = head->Flink; x != head; x = x->Flink)
+    {
+      PLDR_DATA_TABLE_ENTRY mod = CONTAINING_RECORD (x, LDR_DATA_TABLE_ENTRY,
+						     InMemoryOrderLinks);
+      if (mod->DllBase > func_va)
+	continue;
+
+      __small_sprintf (buf, "%S+0x%x", &mod->BaseDllName,
+		       (DWORD_PTR)func_va - (DWORD_PTR)mod->DllBase);
+    }
+
+  return buf;
+}
+
 void
 cygwin_exception::dumpstack ()
 {
@@ -350,7 +378,7 @@ cygwin_exception::dumpstack ()
 	  for (unsigned j = 0; j < NPARAMS; j++)
 	    small_printf ("%s%012X", j == 0 ? " (" : ", ",
 			  thestack.sf.Params[j]);
-	  small_printf (")\r\n");
+	  small_printf (") %s\r\n", prettyprint_va((PVOID)thestack.sf.AddrPC.Offset));
 	}
       small_printf ("End of stack trace%s\r\n",
 		    i == DUMPSTACK_FRAME_LIMIT ?
-- 
2.38.1

