Return-Path: <cygwin-patches-return-6161-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23982 invoked by alias); 8 Nov 2007 00:05:26 -0000
Received: (qmail 23966 invoked by uid 22791); 8 Nov 2007 00:05:24 -0000
X-Spam-Check-By: sourceware.org
Received: from fk-out-0910.google.com (HELO fk-out-0910.google.com) (209.85.128.190)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 08 Nov 2007 00:05:17 +0000
Received: by fk-out-0910.google.com with SMTP id 19so4699149fkr         for <cygwin-patches@cygwin.com>; Wed, 07 Nov 2007 16:05:16 -0800 (PST)
Received: by 10.82.182.1 with SMTP id e1mr14903781buf.1194480316079;         Wed, 07 Nov 2007 16:05:16 -0800 (PST)
Received: from ?78.130.31.155? ( [78.130.31.155])         by mx.google.com with ESMTPS id k9sm609758nfh.2007.11.07.16.05.13         (version=TLSv1/SSLv3 cipher=RC4-MD5);         Wed, 07 Nov 2007 16:05:15 -0800 (PST)
Message-ID: <4732526F.4080501@portugalmail.pt>
Date: Thu, 08 Nov 2007 00:05:00 -0000
From: Pedro Alves <pedro_alves@portugalmail.pt>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; pt-BR; rv:1.8.1.6) Gecko/20070728 Thunderbird/2.0.0.6 Mnenhy/0.7.5.0
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Rewrite/fix cygwin1.dbg generation
References: <472CB021.5040806@portugalmail.pt> <472CB37A.407FAE34@dessent.net> <20071104022028.GA6236@ednor.casa.cgf.cx> <472D43F5.4090700@portugalmail.pt> <472D7956.28174D88@dessent.net> <20071104175738.GA21828@ednor.casa.cgf.cx>
In-Reply-To: <20071104175738.GA21828@ednor.casa.cgf.cx>
Content-Type: multipart/mixed;  boundary="------------050202060006080405000701"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q4/txt/msg00013.txt.bz2

This is a multi-part message in MIME format.
--------------050202060006080405000701
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 3516

Christopher Faylor wrote:

> That would be fine with me.  OTOH, if the dllfixdbg isn't doing the
> right thing for gdb couldn't it be adapted to include the required
> sections?
> 

Yep.  Here is a patch that does that.

Testsuite shows no changes, I could build cygwin in cygwin with
this, and gdb doesn't complain anymore.

Also tested that the cygheap can grow as much as the previous
version.

  >objdump.exe -h new-cygwin1.dll

new-cygwin1.dll:     file format pei-i386

Sections:
Idx Name          Size      VMA       LMA       File off  Algn
    0 .text         001350d4  61001000  61001000  00000400  2**4
                    CONTENTS, ALLOC, LOAD, READONLY, CODE, DATA
    1 .autoload_text 000013d8  61137000  61137000  00135600  2**2
                    CONTENTS, ALLOC, LOAD, CODE
    2 .data         0000b51c  61139000  61139000  00136a00  2**4
                    CONTENTS, ALLOC, LOAD, DATA
    3 .rdata        0004fb80  61145000  61145000  00142000  2**4
                    CONTENTS, ALLOC, LOAD, READONLY, DATA
    4 .bss          00009530  61195000  61195000  00000000  2**4
                    ALLOC
    5 .edata        00008487  6119f000  6119f000  00191c00  2**2
                    CONTENTS, ALLOC, LOAD, READONLY, DATA
    6 .rsrc         00000420  611a8000  611a8000  0019a200  2**2
                    CONTENTS, ALLOC, LOAD, DATA
    7 .reloc        00013434  611a9000  611a9000  0019a800  2**2
                    CONTENTS, ALLOC, LOAD, READONLY, DATA
    8 .cygwin_dll_common 00017ae4  611bd000  611bd000  001ade00  2**2
                    CONTENTS, ALLOC, LOAD, DATA, SHARED
    9 .gnu_debuglink 00000010  611d5000  611d5000  001c5a00  2**2
                    CONTENTS, READONLY, DEBUGGING, EXCLUDE
   10 .idata        0000a000  611d6000  611d6000  001c5c00  2**2
                    CONTENTS, ALLOC, LOAD, DATA
   11 .cygheap      000a0000  611e0000  611e0000  00000000  2**2
                    ALLOC

  >objdump.exe -h cygwin1.dbg

cygwin1.dbg:     file format pei-i386

Sections:
Idx Name          Size      VMA       LMA       File off  Algn
    0 .text         001350d4  61001000  61001000  00000000  2**4
                    ALLOC, LOAD, READONLY, CODE, DATA
    1 .autoload_text 000013d8  61137000  61137000  00000000  2**2
                    ALLOC, LOAD, CODE
    2 .data         0000b51c  61139000  61139000  00000000  2**4
                    ALLOC, LOAD, DATA
    3 .rdata        0004fb80  61145000  61145000  00000000  2**4
                    ALLOC, LOAD, READONLY, DATA
    4 .bss          00009530  61195000  61195000  00000000  2**4
                    ALLOC
    5 .edata        00008487  6119f000  6119f000  00000000  2**2
                    ALLOC, LOAD, READONLY, DATA
    6 .rsrc         00000420  611a8000  611a8000  00000000  2**2
                    ALLOC, LOAD, DATA
    7 .reloc        00013434  611a9000  611a9000  00000000  2**2
                    ALLOC, LOAD, READONLY, DATA
    8 .cygwin_dll_common 00017ae4  611bd000  611bd000  00000000  2**2
                    ALLOC, LOAD, DATA, SHARED
    9 .idata        0000a000  611d6000  611d6000  00000000  2**2
                    ALLOC, LOAD, DATA
   10 .cygheap      000a0000  611e0000  611e0000  00000000  2**2
                    ALLOC
   11 .stab         00212ce8  61280000  61280000  00000380  2**2
                    CONTENTS, READONLY, DEBUGGING, EXCLUDE
   12 .stabstr      006b00a6  61493000  61493000  00213180  2**0
                    CONTENTS, READONLY, DEBUGGING, EXCLUDE

Cheers,
Pedro Alves


--------------050202060006080405000701
Content-Type: text/x-diff;
 name="sepdebug.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sepdebug.diff"
Content-length: 1275

2007-11-07  Pedro Alves  <pedro_alves@portugalmail.pt>

	* dllfixdbg: Pass --only-keep-debug to objcopy, instead of
	selecting the sections manually.

---
 winsup/cygwin/dllfixdbg |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

Index: src/winsup/cygwin/dllfixdbg
===================================================================
--- src.orig/winsup/cygwin/dllfixdbg	2007-11-07 23:44:00.000000000 +0000
+++ src/winsup/cygwin/dllfixdbg	2007-11-07 23:44:38.000000000 +0000
@@ -1,5 +1,5 @@
 #!/usr/bin/perl
-# Copyright 2006 Red Hat, Inc.
+# Copyright 2006, 2007 Red Hat, Inc.
 #
 # This file is part of Cygwin.
 #
@@ -16,10 +16,8 @@ my $objdump = shift;
 my @objcopy = ((shift));
 my $dll = shift;
 my $dbg = shift;
-xit 0, @objcopy, '-j', '.stab', '-j', '.stabstr', '-j', '.debug_aranges',
-       '-j', '.debug_pubnames', '-j', '.debug_info', '-j', '.debug_abbrev',
-       '-j', '.debug_line', '-j', '.debug_frame', '-j', '.debug_str', '-j',
-       '.debug_loc', '-j', '.debug_macinfo', '-j', '.debug_ranges', $dll, $dbg;
+xit 0, @objcopy, '--only-keep-debug', $dll, $dbg;
+xit 0, @objcopy, '-R', '.gnu_debuglink_overlay', $dbg;
 xit 0, @objcopy, '-g', '--add-gnu-debuglink=' . $dbg, $dll;
 open(OBJDUMP, '-|', "$objdump --headers $dll");
 my %section;


--------------050202060006080405000701--
