Return-Path: <cygwin-patches-return-6313-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31242 invoked by alias); 19 Mar 2008 15:57:22 -0000
Received: (qmail 31230 invoked by uid 22791); 19 Mar 2008 15:57:20 -0000
X-Spam-Check-By: sourceware.org
Received: from dessent.net (HELO dessent.net) (69.60.119.225)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Wed, 19 Mar 2008 15:56:56 +0000
Received: from localhost ([127.0.0.1] helo=dessent.net) 	by dessent.net with esmtp (Exim 4.50) 	id 1Jc0es-00042T-OH 	for cygwin-patches@cygwin.com; Wed, 19 Mar 2008 15:56:54 +0000
Message-ID: <47E137C7.8AE02BC4@dessent.net>
Date: Wed, 19 Mar 2008 15:57:00 -0000
From: Brian Dessent <brian@dessent.net>
Reply-To: cygwin-patches@cygwin.com
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] better stackdumps
References: <47E05D34.FCC2E30A@dessent.net> <20080319030027.GC22446@ednor.casa.cgf.cx>
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
X-SW-Source: 2008-q1/txt/msg00087.txt.bz2

Christopher Faylor wrote:

> Sorry, but I don't like this concept.  This bloats the cygwin DLL for a
> condition that would be better served by either using gdb or generating
> a real coredump.

I hear you, but part of the motivation for writing this was a recent
thread the other week on the gdb list where the poster asked how to get
symbols in a Cygwin stackdump file.  I suggested the same thing, setting
error_start=dumper to get a real core dump.  They did, and the result
was completely useless.  Here is what dumper gives you for the same
simple testcase:

$ gdb 
(gdb) core a.exe.core
[New process 1]
[New process 0]
[New process 0]
#0  0x7c90eb94 in ?? ()
(gdb) thr apply all bt

Thread 3 (process 0):
#0  0x7c90eb94 in ?? ()

Thread 2 (process 0):
#0  0x7c90eb94 in ?? ()

Thread 1 (process 1):
#0  0x7c90eb94 in ?? ()

You can't even make out the names of any of the loaded modules from the
core:

(gdb) i tar
Local core dump file:
        `/home/brian/testcases/backtrace/a.exe.core', file type
elf32-i386.
        0x00010000 - 0x00011000 is load11
        0x00020000 - 0x00021000 is load12
        0x001ff000 - 0x00233000 is load13
        0x00240000 - 0x00248000 is load14
        0x00253000 - 0x00254000 is load15
        0x00340000 - 0x00346000 is load16
        0x00350000 - 0x00353000 is load17
        0x00360000 - 0x00376000 is load18
        0x00380000 - 0x003bd000 is load19
        0x003c0000 - 0x003c6000 is load20
        0x003d0000 - 0x003d1000 is load21
        0x003e0000 - 0x003ee000 is load22
        0x003f0000 - 0x003f1000 is load23
        0x00400000 - 0x00401000 is load24
        0x004013d0 - 0x00405000 is load25
        0x00420000 - 0x00461000 is load26
        0x0066c000 - 0x006a0000 is load27
        0x1867f000 - 0x18680000 is load28
        0x60fd0000 - 0x60fd5000 is load29
        0x60ff0000 - 0x60ff9000 is load30
        0x61000000 - 0x61001000 is load31
        0x61118994 - 0x61119000 is load32
        0x6111a3d8 - 0x611fa000 is load33
        0x611fb000 - 0x612a0000 is load34
        0x77b40000 - 0x77b41000 is load35
        0x77b5d60c - 0x77b62000 is load36
        0x77dd0000 - 0x77dd1000 is load37
        0x77e452d9 - 0x77e6b000 is load38
        0x77e70000 - 0x77e71000 is load39
        0x77ef3353 - 0x77ef4000 is load40
        0x77efa90d - 0x77f02000 is load41
        0x77fe0000 - 0x77fe1000 is load42
        0x77fed1dc - 0x77ff1000 is load43
        0x7c800000 - 0x7c801000 is load44
        0x7c883111 - 0x7c8f5000 is load45
        0x7c900000 - 0x7c901000 is load46
        0x7c97b6fe - 0x7c9b0000 is load47
        0x7f6f0000 - 0x7f6f7000 is load48
        0x7ffb0000 - 0x7ffd4000 is load49
        0x7ffdc000 - 0x7ffe1000 is load50

addr2line also seems to be totally unequipped to deal with separate .dbg
information, as I can't get it to output a thing even though both a.exe
and cygwin1.dll have full debug symbols:

$ addr2line -e a.exe 0x610F74B1
??:0

$ addr2line -e a.exe 0x610FDD3B
??:0

$ addr2line -e a.exe 0x6110A310
??:0

$ addr2line -e a.exe 0x610AA4A8
??:0

The situation with error_start=gdb isn't really all that better:

(gdb) thr apply all bt

Thread 3 (thread 4552.0x16a8):
#0  0x7c901231 in ntdll!DbgUiConnectToDbg () from
/winxp/system32/ntdll.dll
#1  0x7c9507a8 in ntdll!KiIntSystemCall () from
/winxp/system32/ntdll.dll
#2  0x00000005 in ~cygheap_fdget (this=0x1) at
/usr/src/sourceware/winsup/cygwin/times.cc:518
#3  0x00000000 in ?? ()

Thread 2 (thread 4552.0x132c):
#0  0x7c90eb94 in ntdll!LdrAccessResource () from
/winxp/system32/ntdll.dll
#1  0x7c90e288 in ntdll!ZwReadFile () from /winxp/system32/ntdll.dll
#2  0x7c801875 in ReadFile () from /winxp/system32/kernel32.dll
#3  0x00000754 in ?? () at /usr/src/sourceware/winsup/cygwin/dtable.h:33
#4  0x00000000 in ?? ()

Thread 1 (thread 4552.0x18b0):
#0  0x7c90eb94 in ntdll!LdrAccessResource () from
/winxp/system32/ntdll.dll
#1  0x7c90e21f in ntdll!ZwQueryVirtualMemory () from
/winxp/system32/ntdll.dll
#2  0x7c937b93 in ntdll!RtlUpcaseUnicodeChar () from
/winxp/system32/ntdll.dll
#3  0xffffffff in ?? ()
#4  0x61027c20 in sigpacket::process () at
/usr/src/sourceware/winsup/cygwin/exceptions.cc:1444
#5  0x7c93783a in ntdll!LdrFindCreateProcessManifest () from
/winxp/system32/ntdll.dll
#6  0x61027c20 in sigpacket::process () at
/usr/src/sourceware/winsup/cygwin/exceptions.cc:1444
#7  0x7c90eafa in ntdll!LdrDisableThreadCalloutsForDll () from
/winxp/system32/ntdll.dll
#8  0x00000000 in ?? ()
#0  0x7c901231 in ntdll!DbgUiConnectToDbg () from
/winxp/system32/ntdll.dll

None of this has anything to do with the actual call chain that
triggered the fault which was printf->fputc->strlen.  Yes, you usually
have to "continue" to get the fault re-triggered, but for some reason
when I type continue in this simple testcase gdb just hangs completely. 
Even if the user gets this far they will still need to have debug
symbols installed for cygwin1.dll which in of itself is a whole other
task that most users cringe at taking on.

On contrast, the approach in this patch:
- doesn't require debug symbols installed
- doesn't require gdb installed
- doesn't require of the the user to know about and set error_start
- doesn't confuse with an irrelevant backtrace into ntdll
- doesn't require knowing to "cont" to retrigger
- works by default without installing or setting anything
- would potentially allow us to provide a glibc-like backtrace API for
user programs

As far as bloat goes the .text section of exceptions.o increases by 720
bytes with this patch which for a DLL that is already 2.2M stripped is
practically indistinguishable.

> OTOH, adding a list of loaded dlls to a stackdump might not be a bad
> idea so that some postprocessing program could generate the same output
> as long as that didn't add too much code to cygwin.

In order to be do the processing with an external tool, it would be
necessary to output to the stackdump file the complete list of all
loaded modules as well as their base addresses in case they were
relocated.  That alone would represent a significant portion of the code
that this patch introduces.  Plus without being able to recognise that
signal wrappers obscure the location of the real entrypoints to
many/most Cygwin functions, the backtrace used by this method looks very
bad and doesn't give useful information for routines in Cygwin -- and
being able to do that processing is much easier when you're in the
actual module that has the wrappers as you can simply test against
&_sigfe.

Brian
