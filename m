Return-Path: <jon.turney@dronecode.org.uk>
Received: from re-prd-fep-048.btinternet.com (mailomta32-re.btinternet.com [213.120.69.125])
	by sourceware.org (Postfix) with ESMTPS id 810A03846431
	for <cygwin-patches@cygwin.com>; Fri, 28 Oct 2022 15:06:18 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 810A03846431
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=dronecode.org.uk
Received: from re-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.54.8])
          by re-prd-fep-048.btinternet.com with ESMTP
          id <20221028150617.YOZY3057.re-prd-fep-048.btinternet.com@re-prd-rgout-005.btmx-prd.synchronoss.net>;
          Fri, 28 Oct 2022 16:06:17 +0100
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 613A91243FFB12CD
X-Originating-IP: [86.139.199.187]
X-OWM-Source-IP: 86.139.199.187 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvgedrtdeigdekfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeeliedtjefhtdevkeehueegffegveeftdejjeevfefhiefffeektddvteehheeijeenucfkphepkeeirddufeelrdduleelrddukeejnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudefledrudelledrudekjedpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomhdprhgtphhtthhopehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhk
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.139.199.187) by re-prd-rgout-005.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as jonturney@btinternet.com)
        id 613A91243FFB12CD; Fri, 28 Oct 2022 16:06:17 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 3/3] Cygwin: Add loaded module base address list to stackdump
Date: Fri, 28 Oct 2022 16:05:58 +0100
Message-Id: <20221028150558.2300-4-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221028150558.2300-1-jon.turney@dronecode.org.uk>
References: <20221028150558.2300-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1199.0 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,GIT_PATCH_0,KAM_DMARC_STATUS,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This adds an extra section to the stackdump, which lists the loaded
modules and their base address.  This is perhaps useful as it makes it
immediately clear if RandomCrashInjectedDll.dll is loaded...

XXX: It seems like the 'InMemoryOrder' part of 'InMemoryOrderModuleList' is a lie?

> Loaded modules
> 000100400000 segv-test.exe
> 7FFF2AC30000 ntdll.dll
> 7FFF29050000 KERNEL32.DLL
> 7FFF28800000 KERNELBASE.dll
> 000180040000 cygwin1.dll
> 7FFF28FA0000 advapi32.dll
> 7FFF29F20000 msvcrt.dll
> 7FFF299E0000 sechost.dll
> 7FFF29B30000 RPCRT4.dll
> 7FFF27C10000 CRYPTBASE.DLL
> 7FFF28770000 bcryptPrimitives.dll
---
 winsup/cygwin/exceptions.cc | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
index 1e9ea26bf..7dde44140 100644
--- a/winsup/cygwin/exceptions.cc
+++ b/winsup/cygwin/exceptions.cc
@@ -383,6 +383,16 @@ cygwin_exception::dumpstack ()
       small_printf ("End of stack trace%s\r\n",
 		    i == DUMPSTACK_FRAME_LIMIT ?
 		    " (more stack frames may be present)" : "");
+
+      small_printf ("Loaded modules\r\n");
+      PLIST_ENTRY head = &NtCurrentTeb()->Peb->Ldr->InMemoryOrderModuleList;
+      for (PLIST_ENTRY x = head->Flink; x != head; x = x->Flink)
+	{
+	  PLDR_DATA_TABLE_ENTRY mod = CONTAINING_RECORD (x, LDR_DATA_TABLE_ENTRY,
+							 InMemoryOrderLinks);
+	  small_printf ("%012X %S\r\n", mod->DllBase, &mod->BaseDllName);
+	}
+
       if (h)
 	NtClose (h);
     }
-- 
2.38.1

