Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
 by sourceware.org (Postfix) with ESMTPS id 7579838930D7
 for <cygwin-patches@cygwin.com>; Wed, 19 May 2021 09:49:32 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 7579838930D7
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MFK8H-1lhNwm08XR-00FjmR; Wed, 19 May 2021 11:49:29 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id D977BA82BF8; Wed, 19 May 2021 11:49:27 +0200 (CEST)
Date: Wed, 19 May 2021 11:49:27 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Jeremy Drake <cygwin@jdrake.com>
Cc: cygwin-patches@cygwin.com
Subject: Re: [RFC] FAST_CWD warnings on ARM64 insider preview
Message-ID: <YKTfJ2kVCsV+yT3g@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Jeremy Drake <cygwin@jdrake.com>, cygwin-patches@cygwin.com
References: <alpine.BSO.2.21.2105181151200.14962@resin.csoft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.BSO.2.21.2105181151200.14962@resin.csoft.net>
X-Provags-ID: V03:K1:hyWKBDPvV3qYJ+JLk7TnCysDWFQX2cnmwDOp78WN5fwtrQELQ21
 Qsz7NDkxJdXtHdClHCJHBXpJe4W9nBNENYDlav7STbTVUDR3en3iz8bLqSYXmKggHOoLamS
 LzQ4MOfQLKigcozPn4ZMtN6Ea2IjUSf3utUNaKhqLmvOfgOhWfEqVrIm9sPwnLDY9W4HQOk
 7b0Dq+MNXfWmUzq6oznKQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mXYZ5lEnbRM=:jm7MYkmMFjtUvDQNb6V1w9
 z4EzYE0pgh+Mb3/LbzvVBPliiRaCoenchvb6E1Q/ATUu57ZO/5/vDnTgQmxov1lEqodcbzZzA
 6Hi6ozPKArImi7/dtFgsL7aP7di9O19FjVfkZFYZhwNYYfMPYn3qgA92UKgwi1bMdjVtpaKeS
 uxof0rECAZjWYJsLgIPF+NQhhesAn9wc2zhocsVvMAEko4Tv2Hs/+AFQBHm1GVYhkNilEAEmi
 Bomo+TNVSxaoExpG0leCK6rKQJyq2kgX3JRtCFxiF+RqE3pJbG/5W5FqA6Scv5dpbK05TSaIE
 drnxsx8frGHTVEKQO9CoX4IqWpOL34peCpYPuacDqqY9lRT/T93cb5cCkscNZ16j/S7MFm+na
 nCW4UTnHCnyxa0/W0z/eoyu/nn+QhGT36pcKASG09E/WetPfi0cA94szkmIzJxm/yUkfDBQw5
 bYngkI+KG+ztDmU418jCGkU1ayMqIo+wJ2cjrBiMP5Znak+Ed6ka0nJyNPfEbrz7lv3uLuhQR
 /iPD1X4g8yE43Ncq8becNE=
X-Spam-Status: No, score=-106.1 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_NONE, KAM_DMARC_STATUS,
 RCVD_IN_DNSWL_NONE, SPF_HELO_NONE, SPF_NEUTRAL,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Wed, 19 May 2021 09:49:34 -0000

Hi Jeremy,

On May 18 11:56, Jeremy Drake via Cygwin-patches wrote:
> I have been trying out x86_64 msys2 (a fork of cygwin) on Windows insider
> preview builds on ARM64, which added support for x86_64 emulation.  I was
> getting the notorious FAST_CWD warnings, which were interfering with
> MINGW CMake.  Last night late, I went looking at the cause, and found some
> code that attempted to disable FAST_CWD warnings, but only on i686, and
> trying to look at GetNativeSystemInfo, which was lying.  I quickly put
> together this patch, and it seems to work.
> 
> Note I did this late at night, with no real regard to investigating or
> matching code style.  This patch is currently more in an RFC state, if the
> approach looks OK, and I'd be grateful for any pointers on getting it into
> shape for evental acceptance.

> +#ifndef IMAGE_FILE_MACHINE_ARM64
> +#define IMAGE_FILE_MACHINE_ARM64 0xAA64
> +#endif

IMAGE_FILE_MACHINE_ARM64 is already defined for some time in winnt.h
so we won't need the ifdef.

> +      typedef BOOL (WINAPI * IsWow64Process2_t)(HANDLE hProcess, USHORT *pProcessMachine, USHORT *pNativeMachine);
> +      IsWow64Process2_t pfnIsWow64Process2 = (IsWow64Process2_t)GetProcAddress(GetModuleHandle("kernel32.dll"), "IsWow64Process2");
> +      if (pfnIsWow64Process2 && pfnIsWow64Process2(GetCurrentProcess(), &procmachine, &nativemachine) && nativemachine == IMAGE_FILE_MACHINE_ARM64)

We're having the autoload mechanism for that, i. e., your patch can get
rid of the GetModuleHandle/GetProcAddress preliminaries entirely.

By using the LoadDLLfuncEx() expression, failure to load the function
will result in a return value of FALSE with GetLastError ==
ERROR_PROC_NOT_FOUND, so this is safe on older systems.

It's easier to understand with a full example, so I took the liberty to
rewrite your patch accordingly.  Since the idea and the basic work is
yours, I'd push this under your name, see below.


Thanks,
Corinna


From ee6dfb3bb0a5d51416d788133f818df0b8c1a207 Mon Sep 17 00:00:00 2001
From: Jeremy Drake <cygwin@jdrake.com>
Date: Wed, 19 May 2021 11:43:48 +0200
Subject: [PATCH] Cygwin: suppress FAST_CWD warnings on ARM64

The old check was insufficient: new insider preview builds of Windows
allow running x86_64 process on ARM64.  The IsWow64Process2 function
seems to be the intended way to figure this situation out.
---
 winsup/cygwin/autoload.cc |  1 +
 winsup/cygwin/path.cc     | 33 +++++++++------------------------
 2 files changed, 10 insertions(+), 24 deletions(-)

diff --git a/winsup/cygwin/autoload.cc b/winsup/cygwin/autoload.cc
index b2de2c3f42ce..0ebe15332013 100644
--- a/winsup/cygwin/autoload.cc
+++ b/winsup/cygwin/autoload.cc
@@ -587,6 +587,7 @@ LoadDLLfuncEx (GetLogicalProcessorInformationEx, 12, kernel32, 1)
 LoadDLLfuncEx (GetProcessGroupAffinity, 12, kernel32, 1)
 LoadDLLfunc (GetSystemTimePreciseAsFileTime, 4, kernel32)
 LoadDLLfuncEx (GetThreadGroupAffinity, 8, kernel32, 1)
+LoadDLLfuncEx (IsWow64Process2, 12, kernel32, 1)
 LoadDLLfuncEx (PrefetchVirtualMemory, 16, kernel32, 1)
 LoadDLLfunc (SetThreadGroupAffinity, 12, kernel32)
 
diff --git a/winsup/cygwin/path.cc b/winsup/cygwin/path.cc
index dd7048486a65..9b38793aa7d9 100644
--- a/winsup/cygwin/path.cc
+++ b/winsup/cygwin/path.cc
@@ -4707,30 +4707,15 @@ find_fast_cwd ()
   if (!f_cwd_ptr)
     {
       bool warn = 1;
-
-#ifndef __x86_64__
-      #ifndef PROCESSOR_ARCHITECTURE_ARM64
-      #define PROCESSOR_ARCHITECTURE_ARM64 12
-      #endif
-
-      SYSTEM_INFO si;
-
-      /* Check if we're running in WOW64 on ARM64.  Skip the warning as long as
-	 there's no solution for finding the FAST_CWD pointer on that system.
-
-	 2018-07-12: Apparently current ARM64 WOW64 has a bug:
-	 It's GetNativeSystemInfo returns PROCESSOR_ARCHITECTURE_INTEL in
-	 wProcessorArchitecture.  Since that's an invalid value (a 32 bit
-	 host system hosting a 32 bit emulator for itself?) we can use this
-	 value as an indicator to skip the message as well. */
-      if (wincap.is_wow64 ())
-	{
-	  GetNativeSystemInfo (&si);
-	  if (si.wProcessorArchitecture == PROCESSOR_ARCHITECTURE_ARM64
-	      || si.wProcessorArchitecture == PROCESSOR_ARCHITECTURE_INTEL)
-	    warn = 0;
-	}
-#endif /* !__x86_64__ */
+      USHORT emulated, hosted;
+
+      /* Check if we're running in WOW64 on ARM64.  Check on 64 bit as well,
+	 given that ARM64 Windows 10 provides a x86_64 emulation soon.  Skip
+	 warning as long as there's no solution for finding the FAST_CWD
+	 pointer on that system. */
+      if (IsWow64Process2 (GetCurrentProcess (), &emulated, &hosted)
+	  && hosted == IMAGE_FILE_MACHINE_ARM64)
+	warn = 0;
 
       if (warn)
 	small_printf ("Cygwin WARNING:\n"
-- 
2.30.2

