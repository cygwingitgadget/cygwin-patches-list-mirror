Return-Path: <cygwin-patches-return-10002-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 93968 invoked by alias); 25 Jan 2020 10:19:20 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 93959 invoked by uid 89); 25 Jan 2020 10:19:19 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-8.2 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=
X-HELO: conssluserg-03.nifty.com
Received: from conssluserg-03.nifty.com (HELO conssluserg-03.nifty.com) (210.131.2.82) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 25 Jan 2020 10:19:17 +0000
Received: from Express5800-S70 (ntsitm196171.sitm.nt.ngn.ppp.infoweb.ne.jp [125.0.207.171]) (authenticated)	by conssluserg-03.nifty.com with ESMTP id 00PAJ3rK019888	for <cygwin-patches@cygwin.com>; Sat, 25 Jan 2020 19:19:04 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 00PAJ3rK019888
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1579947544;	bh=okQ+ch7vc73T9j93ThnG+Dk4LaGguk19xvgeExYtli8=;	h=Date:From:To:Subject:In-Reply-To:References:From;	b=eOVirNMQB9xgNp5L1YapBnoZ2H+8oKgskexzElJo5giiN0yfIfL7pgffbrq7d80e/	 iwOWQYa7Kw8alca69yOFVwV0XqEF/VD1guDhFd9gQXnT0NKBbpDsdYdLDAEvnF5qTN	 aId4x+s2qbvBeATvKDxcsdDPfAepIVekJ7UIZ/7ZEB4+HdDExTqZ9n396JmPjIlS5B	 tRpD8a8N/z9gxvu/c89Sf35PwZw8+CKVyN3xNXlOP6a3KdrgUvcGfDP5MyZ74fVFOq	 724uEqXI1G1T049Nja36N3uWlAQTmI219Ou7nbJwNzRPwCDYg9GAv6/zQYLpyuVjNm	 RFzdsKgkqEhaw==
Date: Sat, 25 Jan 2020 10:19:00 -0000
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Add missing console API hooks.
Message-Id: <20200125191911.47c91a32af7dea234f233d7e@nifty.ne.jp>
In-Reply-To: <20200124102627.GE263143@calimero.vinschen.de>
References: <20200123043312.529-1-takashi.yano@nifty.ne.jp>	<20200123124813.GC263143@calimero.vinschen.de>	<20200123220531.d6dcf35ce81f4fa17b0788a6@nifty.ne.jp>	<20200124102627.GE263143@calimero.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00108.txt

Hi Corinna,

On Fri, 24 Jan 2020 11:26:27 +0100
Corinna Vinschen wrote:
> On Jan 23 22:05, Takashi Yano wrote:
> > On Thu, 23 Jan 2020 13:48:13 +0100
> > Corinna Vinschen wrote:
> > > On Jan 23 13:33, Takashi Yano wrote:
> > > > - Following console APIs are additionally hooked for cygwin programs
> > > >   which directly call them.
> > > >   * FillConsoleOutputAttribute()
> > > >   * FillConsoleOutputCharacterA()
> > > >   * FillConsoleOutputCharacterW()
> > > >   * ScrollConsoleScreenBufferA()
> > > >   * ScrollConsoleScreenBufferW()
> > > 
> > > Which Cygwin programs are doing that?  They wouldn't work correctly in
> > > ptys anyway, isn't it?  Does it really make sense to make them happy
> > > rather than requesting to change them?
> > 
> > Just a possibility. There is no specific example.
> 
> In that case I'd prefer not to apply this patch.  Using native Windows
> console functions in a Cygwin application just doesn't make sense, and
> we shouldn't support that beyond what's necessary for older, existing
> applications.

I searched in /bin and found that many of cygwin programs calls win32 api
directly. However, the only cygwin programs which calls console APIs are
cygrunsrv.exe, gdb.exe and w3m.exe in my installation.

cygrunsrv calls:
        DLL Name: ADVAPI32.dll
        vma:  Hint/Ord Member-Name Bound-To
        264ec      87  CloseServiceHandle
        26502      92  ControlService
        26514     128  CreateServiceA
        26526     218  DeleteService
        26536     255  EnumServicesStatusA
        2654c     511  OpenSCManagerA
        2655e     513  OpenServiceA
        2656e     554  QueryServiceConfigA
        26584     559  QueryServiceStatus
        2659a     568  RegCloseKey
        265a8     569  RegConnectRegistryA
        265be     576  RegCreateKeyExA
        265d0     601  RegEnumValueA
        265e0     603  RegFlushKey
        265ee     616  RegOpenKeyExA
        265fe     629  RegQueryValueExA
        26612     645  RegSetValueExA
        26624     654  RegisterServiceCtrlHandlerExA
        26644     712  SetServiceStatus
        26658     718  StartServiceA
        26668     719  StartServiceCtrlDispatcherA

        DLL Name: KERNEL32.dll
        vma:  Hint/Ord Member-Name Bound-To
        26686      16  AllocConsole              <==============
        26696      83  CloseHandle
        266a4     239  EnterCriticalSection
        266bc     351  FormatMessageA
        266ce     353  FreeConsole               <==============
        266dc     356  FreeLibrary
        266ea     482  GetExitCodeProcess
        26700     515  GetLastError
        26710     531  GetModuleFileNameA
        26726     533  GetModuleHandleA
        2673a     581  GetProcAddress
        2674c     663  GetTickCount
        2675c     677  GetVersion
        2676a     747  InitializeCriticalSection
        26786     806  LeaveCriticalSection
        2679e     809  LoadLibraryA
        267ae     879  OpenProcess
        267bc    1035  SetConsoleTitleA          <==============
        267d0    1078  SetLastError
        267e0    1140  Sleep
        267e8    1218  WaitForSingleObject

        DLL Name: USER32.dll
        vma:  Hint/Ord Member-Name Bound-To
        267fe      13  BringWindowToTop
        26812     260  GetForegroundWindow
        26828     335  GetTopWindow
        26838     538  SetForegroundWindow

gdb calls:
        DLL Name: KERNEL32.dll
        vma:  Hint/Ord Member-Name Bound-To
        60a5bc     84  CloseHandle
        60a5ca    106  ContinueDebugEvent
        60a5e0    140  CreateFileA
        60a5ee    172  CreateProcessW
        60a600    201  DebugActiveProcess
        60a616    348  FlushInstructionCache
        60a62e    358  FreeLibrary
        60a63c    364  GenerateConsoleCtrlEvent   <==============
        60a658    440  GetConsoleScreenBufferInfo <==============
        60a676    454  GetCurrentProcess
        60a68a    485  GetExitCodeThread
        60a69e    517  GetLastError
        60a6ae    535  GetModuleHandleA
        60a6c2    538  GetModuleHandleW
        60a6d6    583  GetProcAddress
        60a6e8    628  GetSystemDirectoryW
        60a6fe    651  GetThreadContext
        60a712    661  GetThreadSelectorEntry
        60a72c    811  LoadLibraryA
        60a73c    882  OpenProcess
        60a74a    950  ReadProcessMemory
        60a75e    988  ResumeThread
        60a76e   1015  SetConsoleCtrlHandler     <==============
        60a786   1057  SetEnvironmentVariableW
        60a7a0   1059  SetEvent
        60a7ac   1115  SetThreadContext
        60a7c0   1154  SuspendThread
        60a7d0   1160  TerminateProcess
        60a7e4   1221  WaitForDebugEvent
        60a7f8   1224  WaitForSingleObject
        60a80e   1278  WriteProcessMemory

w3m calls:
        DLL Name: KERNEL32.dll
        vma:  Hint/Ord Member-Name Bound-To
        1384c0     83  CloseHandle
        1384ce    139  CreateFileA
        1384dc    356  FreeLibrary
        1384ea    441  GetConsoleTitleA        <==============
        1384fe    453  GetCurrentProcessId
        138514    533  GetModuleHandleA
        138528    581  GetProcAddress
        13853a    663  GetTickCount
        13854a    678  GetVersionExA
        13855a    809  LoadLibraryA
        13856a    888  PeekConsoleInputA       <==============
        13857e    929  ReadConsoleA            <==============
        13858e    930  ReadConsoleInputA       <==============
        1385a2   1035  SetConsoleTitleA        <==============
        1385b6   1140  Sleep

        DLL Name: USER32.dll
        vma:  Hint/Ord Member-Name Bound-To
        1385be    211  FindWindowA
        1385cc    401  IsWindowVisible
        1385de    644  wsprintfA

None of them calls:
FillConsoleOutputAttribute()
FillConsoleOutputCharacterA()
FillConsoleOutputCharacterW()
ScrollConsoleScreenBufferA()
ScrollConsoleScreenBufferW()

So, I would like to withdraw this patch for now. Thanks.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
