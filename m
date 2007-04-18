Return-Path: <cygwin-patches-return-6067-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20143 invoked by alias); 18 Apr 2007 12:59:05 -0000
Received: (qmail 20114 invoked by uid 22791); 18 Apr 2007 12:59:02 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-72-70-61-13.bstnma.fios.verizon.net (HELO cgf.cx) (72.70.61.13)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Wed, 18 Apr 2007 13:58:59 +0100
Received: by cgf.cx (Postfix, from userid 201) 	id 70A6113C037; Wed, 18 Apr 2007 08:58:57 -0400 (EDT)
Date: Wed, 18 Apr 2007 12:59:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch] support -gdwarf-2 when creating cygwin1.dbg
Message-ID: <20070418125857.GA4589@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <462612A9.20E19FEB@dessent.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <462612A9.20E19FEB@dessent.net>
User-Agent: Mutt/1.5.11
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q2/txt/msg00013.txt.bz2

On Wed, Apr 18, 2007 at 05:44:25AM -0700, Brian Dessent wrote:
>
>The attached patch allows for dllfixdbg to copy DWARF-2 debug sections
>into the .dbg file.  There was also an (accidently?) duplicated section
>in the cygwin.sc linker script that I removed while I was there.
>
>The advantages of being able to build newlib/winsup with -gdwarf-2 in
>C/CXXFLAGS are a ~38% smaller .dbg file, but more importantly a much
>more pleasant debugger experience.  gdb is not nearly as confused about
>the sigfe/sigbe signal wrappers, and can unwind the stack cleanly all
>the way up to mainCRTStartup() even when stepping through deep internal
>cygwin1.dll guts.
>
>Here's an example from a simple hello world exe.  With -gdwarf-2:
>
>(gdb) bt
>#0  fstat64 (fd=1, buf=0x22afd0)
>    at /usr/src/sourceware/winsup/cygwin/syscalls.cc:1102
>#1  0x610b4928 in _fstat64_r (ptr=0x50001, fd=327681, buf=0x50001)
>    at /usr/src/sourceware/winsup/cygwin/syscalls.cc:1115
>#2  0x61107174 in __smakebuf_r (ptr=0x22d008, fp=0x611114f8)
>    at /usr/src/sourceware/newlib/libc/stdio/makebuf.c:53
>#3  0x6110667b in __swsetup_r (ptr=0x50001, fp=0x611114f8)
>    at /usr/src/sourceware/newlib/libc/stdio/wsetup.c:67
>#4  0x610f21a6 in _vfprintf_r (data=0x22d008, fp=0x611114f8, 
>    fmt0=0x402000 "Hello world\n", ap=0x22cca4 "/")
>    at /usr/src/sourceware/newlib/libc/stdio/vfprintf.c:547
>#5  0x610ff208 in printf (
>    fmt=0x22eea8e0 <Address 0x22eea8e0 out of bounds>)
>    at /usr/src/sourceware/newlib/libc/stdio/printf.c:51
>#6  0x610a5498 in _sigfe ()
>    at /usr/src/sourceware/winsup/cygwin/cygserver.h:82
>#7  0x00000009 in ?? ()
>#8  0x61005efa in dll_crt0_1 ()
>    at /usr/src/sourceware/winsup/cygwin/dcrt0.cc:943
>#9  0x61004216 in _cygtls::call2 (this=0x22ce64, 
>    func=0x610052a0 <dll_crt0_1(void*)>, arg=0x0, buf=0x22cdd0)
>    at /usr/src/sourceware/winsup/cygwin/cygtls.cc:74
>#10 0x61004290 in _cygtls::call (func=0x610a5498 <_sigbe>, arg=0x0)
>    at /usr/src/sourceware/winsup/cygwin/cygtls.cc:67
>#11 0x61005171 in _dll_crt0 ()
>    at /usr/src/sourceware/winsup/cygwin/dcrt0.cc:956
>#12 0x004010e3 in cygwin_crt0 (f=0x401040 <main>)
>    at /usr/src/sourceware/winsup/cygwin/lib/cygwin_crt0.c:32
>#13 0x0040103d in mainCRTStartup ()
>    at /usr/src/sourceware/winsup/cygwin/crt0.c:51
>
>Exact same breakpoint, -g (stabs):
>
>(gdb) bt
>#0  fstat64 (fd=1628141592, buf=0x1)
>    at /usr/src/sourceware/winsup/cygwin/syscalls.cc:1102
>#1  0x611b5708 in _libntdll_a_iname () from /bin/cygwin1.dll
>#2  0x00000000 in ?? ()
>
>Brian
>2007-04-18  Brian Dessent  <brian@dessent.net>
>
>	* cygwin.sc: Remove duplicated .debug_macinfo section.
>	* dllfixdbg: Also copy DWARF-2 sections into .dbg file.

Thanks for doing this.  Please check in.  Can we switch to dwarf-2 by
default in the cygwin makefile(s)?

cgf
