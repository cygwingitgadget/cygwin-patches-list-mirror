Return-Path: <cygwin-patches-return-6315-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8851 invoked by alias); 19 Mar 2008 21:39:25 -0000
Received: (qmail 8839 invoked by uid 22791); 19 Mar 2008 21:39:24 -0000
X-Spam-Check-By: sourceware.org
Received: from dessent.net (HELO dessent.net) (69.60.119.225)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Wed, 19 Mar 2008 21:39:07 +0000
Received: from localhost ([127.0.0.1] helo=dessent.net) 	by dessent.net with esmtp (Exim 4.50) 	id 1Jc5zz-00059l-1B; Wed, 19 Mar 2008 21:39:03 +0000
Message-ID: <47E187F7.235A85B7@dessent.net>
Date: Wed, 19 Mar 2008 21:39:00 -0000
From: Brian Dessent <brian@dessent.net>
Reply-To: cygwin-patches@cygwin.com
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
MIME-Version: 1.0
To: Pedro Alves <pedro_alves@portugalmail.pt>
CC: cygwin-patches@cygwin.com
Subject: Re: [PATCH] better stackdumps
References: <47E05D34.FCC2E30A@dessent.net> <20080319030027.GC22446@ednor.casa.cgf.cx> <47E137C7.8AE02BC4@dessent.net> <200803192102.48661.pedro_alves@portugalmail.pt>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q1/txt/msg00089.txt.bz2

Pedro Alves wrote:

> Sorry I missed the discussion at gdb@.  What does info sharelibrary say?
> The last I looked at this, it worked.  Is this broken in gdb head
> and on the cygwin distributed gdb?

With gdb CVS HEAD, it gives:

(gdb) i sh
From        To          Syms Read   Shared Object Library
0x7c901000  0x7c9afe88  No          C:\WINXP\system32\ntdll.dll
0x7c801000  0x7c8f4bec  No          C:\WINXP\system32\kernel32.dll
0x61001000  0x61280000  No          C:\cygwin\bin\cygwin1.dll
0x77dd1000  0x77e6ab38  No          C:\WINXP\system32\ADVAPI32.DLL
0x77e71000  0x77f01464  No          C:\WINXP\system32\RPCRT4.dll
0x77fe1000  0x77ff0884  No          C:\WINXP\system32\Secur32.dll
0x77b41000  0x77b61360  No          C:\WINXP\system32\Apphelp.dll

And after that, the backtrace can at least name the DLL, but is still
otherwise useless:

(gdb) thr apply all bt

Thread 3 (process 0):
#0  0x7c90eb94 in ?? () from C:\WINXP\system32\ntdll.dll

Thread 2 (process 0):
#0  0x7c90eb94 in ?? () from C:\WINXP\system32\ntdll.dll

Thread 1 (process 1):
#0  0x7c90eb94 in ?? () from C:\WINXP\system32\ntdll.dll

"info target" still lists every section as just "loadnn".

With gdb 6.5.50.20060706 as packaged by Cygwin, the result is
approximately the same except with posix paths (and the main .exe module
is present too):

(gdb) i sh
From        To          Syms Read   Shared Object Library
0x00401000  0x004013d0  No         
/home/brian/testcases/backtrace/a.exe
0x7c901000  0x7c97b6fe  No          /winxp/system32/ntdll.dll
0x7c801000  0x7c883111  No          /winxp/system32/kernel32.dll
0x61001000  0x61118994  No          /usr/bin/cygwin1.dll
0x77dd1000  0x77e452d9  No          /winxp/system32/advapi32.dll
0x77e71000  0x77ef3353  No          /winxp/system32/rpcrt4.dll
0x77fe1000  0x77fed1dc  No          /winxp/system32/secur32.dll
0x77b41000  0x77b5d60c  No          /winxp/system32/apphelp.dll

(gdb) thr apply all bt

Thread 3 (process 4992):
#0  0x7c95077b in ntdll!KiIntSystemCall () from
/winxp/system32/ntdll.dll

Thread 2 (process 6304):
#0  0x7c90eb94 in ntdll!LdrAccessResource () from
/winxp/system32/ntdll.dll
Cannot access memory at address 0x7c90eb94

Thread 1 (process 8100):
#0  0x7c90eb94 in ntdll!LdrAccessResource () from
/winxp/system32/ntdll.dll
Cannot access memory at address 0x7c90eb94

In both cases the core was produced by current Cygwin CVS dumper.exe.

> Is this something that would be nice to have in gdb then?

If gdb has debug symbols available then it's irrelevent because the info
there is correct: the address for printf in the symbols is the real
function.  It's just that the thing exported as "printf" by the DLL
actually points to _sigfe_printf, which is of course the whole point of
the wrappers.  So this matters only to code that's not using debug
symbols but just looking at export tables.  Now certainly gdb does that
a lot too so I suppose it would be nice to have there, but the main case
where cygwin1.dbg is present is unaffected.

The problem with adapting it for gdb is that _sigfe is not a public
symbol and so the heuristic for detecting a signal wrapper would have to
either loosely trigger on any entry that starts with the "push/jmp"
sequence, or it would have to somehow otherwise figure out the location
of _sigfe so that it can verify the location of the jmp before calling
it a wrapper.  Realistically if the heuristic is going to be limited to
cygwin1.dll then I suppose it's not such a risk to assume any entrypoint
that starts out that way is in fact a signal wrapper: by my count 1036
of the current 1749 exports of the DLL are wrapped this way.

Brian
