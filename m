Return-Path: <cygwin-patches-return-6148-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11139 invoked by alias); 3 Nov 2007 17:32:02 -0000
Received: (qmail 11091 invoked by uid 22791); 3 Nov 2007 17:32:00 -0000
X-Spam-Check-By: sourceware.org
Received: from ug-out-1314.google.com (HELO ug-out-1314.google.com) (66.249.92.172)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Sat, 03 Nov 2007 17:31:55 +0000
Received: by ug-out-1314.google.com with SMTP id z34so881199ugc         for <cygwin-patches@cygwin.com>; Sat, 03 Nov 2007 10:31:52 -0700 (PDT)
Received: by 10.67.103.12 with SMTP id f12mr59424ugm.1194111112226;         Sat, 03 Nov 2007 10:31:52 -0700 (PDT)
Received: from ?88.210.72.251? ( [88.210.72.251])         by mx.google.com with ESMTPS id 34sm4001173uga.2007.11.03.10.31.46         (version=TLSv1/SSLv3 cipher=RC4-MD5);         Sat, 03 Nov 2007 10:31:49 -0700 (PDT)
Message-ID: <472CB021.5040806@portugalmail.pt>
Date: Sat, 03 Nov 2007 17:32:00 -0000
From: Pedro Alves <pedro_alves@portugalmail.pt>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; pt-BR; rv:1.8.1.6) Gecko/20070728 Thunderbird/2.0.0.6 Mnenhy/0.7.5.0
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Rewrite/fix cygwin1.dbg generation
Content-Type: multipart/mixed;  boundary="------------050200030005010200090705"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q4/txt/msg00000.txt.bz2

This is a multi-part message in MIME format.
--------------050200030005010200090705
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 7353

Hi guys,

As was being discussed at gdb-patches@ [1], the cygwin1.dbg
(the debug info of cygwin1.dll) file misses the section
info of the non-debug sections.  Gdb doesn't like that
so much, and issues a few annoying warnings.  Previous
versions of gdb had those warnings suppressed at all
times, but since current gdb had its dll support
rewritten, those warnings resurfaced again.

[1] http://sourceware.org/ml/gdb-patches/2007-10/msg00325.html

This patch simplifies/standardises the cygwin1.dbg generation
by using the --strip-debug/--only-keep-debug facilities of
gnu strip, which already know how to keep the section info,
and remove the contents of non-debug sections.

Old/current version:
    >objdump.exe -h oldver/cygwin1.dbg

oldver/cygwin1.dbg:     file format pei-i386

Sections:
Idx Name          Size      VMA       LMA       File off  Algn
      0 .stab         00212cd0  61280000  61280000  000001c8  2**2
                      CONTENTS, READONLY, DEBUGGING, EXCLUDE
      1 .stabstr      006b00a4  61493000  61493000  00212fc8  2**0
                      CONTENTS, READONLY, DEBUGGING, EXCLUDE
New version:

    >objdump.exe -h newver/cygwin1.dbg

newver/cygwin1.dbg:     file format pei-i386

Sections:
Idx Name          Size      VMA       LMA       File off  Algn
      0 .text         001350c4  61001000  61001000  00000000  2**4
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
      7 .reloc        00013424  611a9000  611a9000  00000000  2**2
                      ALLOC, LOAD, READONLY, DATA
      8 .cygwin_dll_common 00017ae4  611bd000  611bd000  00000000  2**2
                      ALLOC, LOAD, DATA, SHARED
      9 .idata        0000b000  611d5000  611d5000  00000000  2**2
                      ALLOC, LOAD, DATA
     10 .cygheap      000a0000  611e0000  611e0000  00000000  2**2
                      ALLOC
     11 .stab         00212cd0  61280000  61280000  00000380  2**2
                      CONTENTS, READONLY, DEBUGGING, EXCLUDE
     12 .stabstr      006b00a4  61493000  61493000  00213180  2**0
                      CONTENTS, READONLY, DEBUGGING, EXCLUDE

---------------------------------------------------------

Since the .gnu_debuglink_overlay matching is now done,
this produces one difference in cygwin1.dll.  The
.gnu_debuglink section is now the last section,
after .cygheap.  This is not a problem, since
.gnu_debuglink is not mapped into memory by the OS loader.

The patch also removed __cygwin_debug_size, which
seems was a leftover from earlier experiences (?).

For reference, the old and new section info of cygwin1.dll.

    >objdump.exe -h oldver/new-cygwin1.dll

oldver/new-cygwin1.dll:     file format pei-i386

Sections:
Idx Name          Size      VMA       LMA       File off  Algn
      0 .text         001350c4  61001000  61001000  00000400  2**4
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
      7 .reloc        00013424  611a9000  611a9000  0019a800  2**2
                      CONTENTS, ALLOC, LOAD, READONLY, DATA
      8 .cygwin_dll_common 00017ae4  611bd000  611bd000  001ade00  2**2
                      CONTENTS, ALLOC, LOAD, DATA, SHARED
      9 .gnu_debuglink 00000010  611d5000  611d5000  001c5a00  2**2
                      CONTENTS, READONLY, DEBUGGING, EXCLUDE
     10 .idata        0000a000  611d6000  611d6000  001c5c00  2**2
                      CONTENTS, ALLOC, LOAD, DATA
     11 .cygheap      000a0000  611e0000  611e0000  00000000  2**2
                      ALLOC

    >objdump.exe -h newver/new-cygwin1.dll

newver/new-cygwin1.dll:     file format pei-i386

Sections:
Idx Name          Size      VMA       LMA       File off  Algn
      0 .text         001350c4  61001000  61001000  00000400  2**4
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
      7 .reloc        00013424  611a9000  611a9000  0019a800  2**2
                      CONTENTS, ALLOC, LOAD, READONLY, DATA
      8 .cygwin_dll_common 00017ae4  611bd000  611bd000  001ade00  2**2
                      CONTENTS, ALLOC, LOAD, DATA, SHARED
      9 .idata        0000b000  611d5000  611d5000  001c5a00  2**2
                      CONTENTS, ALLOC, LOAD, DATA
     10 .cygheap      000a0000  611e0000  611e0000  00000000  2**2
                      ALLOC
     11 .gnu_debuglink 00000010  61280000  61280000  001d0a00  2**2
                      CONTENTS, READONLY, DEBUGGING

The winsup testsuite shows no changes.
I've bootstrapped winsup with gcc 3.4.4 and this
new cygwin1.dll.  I can step into cygwin1.dll code just
fine with both gdb head, and with the gdb from the distro.

This change should also make it possible to debug
cygwin1.dll correctly if it wasn't loaded at its
prefered load base - although I haven't tested that.

The dllfixdbg hunk looks hard to read.  Here's what is looks
like after patching:

#!/bin/sh

# Copyright 2007 Red Hat, Inc.
#
# This file is part of Cygwin.
#
# This software is a copyrighted work licensed under the terms of the
# Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
# details.
#

set -x

STRIP=$1
OBJCOPY=$2
DLL=$3
DBG=$4

${STRIP} --strip-debug ${DLL} -o stripped-${DLL}
${STRIP} --only-keep-debug ${DLL} -o ${DBG}
${OBJCOPY} --add-gnu-debuglink=${DBG} stripped-${DLL} ${DLL}
rm -f stripped-${DLL}

Is the patch OK?

Cheers,
Pedro Alves




--------------050200030005010200090705
Content-Type: text/x-diff;
 name="sepdebug.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sepdebug.diff"
Content-length: 5288

2007-11-03  Pedro Alves  <pedro_alves@portugalmail.pt>

        * Makefile.in ($(TEST_DLL_NAME)): Pass $(STRIP) instead of
	$(OBJDUMP) to dllfixdbg.
	* dllfixdbg: Rewrite as a shell script using strip's --strip-debug
	and --only-keep-debug facilities.
	* cygwin.sc (.gnu_debuglink_overlay, __cygwin_debug_size): Remove.

---
 winsup/cygwin/Makefile.in |    2 -
 winsup/cygwin/cygwin.sc   |   17 ---------
 winsup/cygwin/dllfixdbg   |   82 +++++++---------------------------------------
 3 files changed, 14 insertions(+), 87 deletions(-)

Index: src/winsup/cygwin/Makefile.in
===================================================================
--- src.orig/winsup/cygwin/Makefile.in	2007-11-03 11:06:02.000000000 +0000
+++ src/winsup/cygwin/Makefile.in	2007-11-03 11:36:02.000000000 +0000
@@ -384,7 +384,7 @@ $(TEST_DLL_NAME): $(LDSCRIPT) dllfixdbg 
 	-e $(DLL_ENTRY) $(DEF_FILE) $(DLL_OFILES) version.o winver.o \
 	$(MALLOC_OBJ) $(LIBSERVER) $(LIBM) $(LIBC) \
 	-lgcc $(DLL_IMPORTS)
-	@$(word 2,$^) $(OBJDUMP) $(OBJCOPY) $@ ${patsubst %0.dll,%1.dbg,$@}
+	@$(word 2,$^) $(STRIP) $(OBJCOPY) $@ ${patsubst %0.dll,%1.dbg,$@}
 	@ln -f $@ new-$(DLL_NAME)
 
 # Rule to build libcygwin.a
Index: src/winsup/cygwin/dllfixdbg
===================================================================
--- src.orig/winsup/cygwin/dllfixdbg	2007-11-03 11:06:02.000000000 +0000
+++ src/winsup/cygwin/dllfixdbg	2007-11-03 16:33:16.000000000 +0000
@@ -1,5 +1,6 @@
-#!/usr/bin/perl
-# Copyright 2006 Red Hat, Inc.
+#!/bin/sh
+
+# Copyright 2007 Red Hat, Inc.
 #
 # This file is part of Cygwin.
 #
@@ -7,72 +8,15 @@
 # Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
 # details.
 #
-use integer;
-use strict;
-sub xit($@);
-my $strip = $ARGV[0] eq '-s';
-shift if $strip;
-my $objdump = shift;
-my @objcopy = ((shift));
-my $dll = shift;
-my $dbg = shift;
-xit 0, @objcopy, '-j', '.stab', '-j', '.stabstr', '-j', '.debug_aranges',
-       '-j', '.debug_pubnames', '-j', '.debug_info', '-j', '.debug_abbrev',
-       '-j', '.debug_line', '-j', '.debug_frame', '-j', '.debug_str', '-j',
-       '.debug_loc', '-j', '.debug_macinfo', '-j', '.debug_ranges', $dll, $dbg;
-xit 0, @objcopy, '-g', '--add-gnu-debuglink=' . $dbg, $dll;
-open(OBJDUMP, '-|', "$objdump --headers $dll");
-my %section;
-while (<OBJDUMP>) {
-    my ($idx, $name, $size, $vma, $lma, $fileoff, $algn) = /^\s*(\d+)\s+(\.\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s*$/;
-    if ($name eq '.gnu_debuglink') {
-	push(@objcopy, '--set-section-flag', '.gnu_debuglink=contents,readonly,debug,noload');
-	$idx = $section{'.gnu_debuglink'}{-idx} if defined($section{'.gnu_debuglink'}{-idx});
-    } elsif ($name eq '.gnu_debuglink_overlay') {
-	push (@objcopy, '-R', '.gnu_debuglink_overlay');
-	$section{'.gnu_debuglink'}{-idx} = $idx;
-	next;
-    }
-    defined($idx) and
-      $section{$name} = {-idx=>int($idx), -size=>hex($size), -vma=>hex($vma), -lma=>hex($lma), -fileoff=>hex($fileoff),
-	  -algn=>0x00001000};
-}
-close OBJDUMP;
-my $vma;
-for my $k (sort {$section{$a}{-idx} <=> $section{$b}{-idx}} keys %section) {
-    if ($strip && $k =~ /\.(?:stab|debug)/o) {
-	push(@objcopy, '-R', $k);
-	next;
-    }
-    if (!defined($vma)) {
-	$vma = $section{$k}{-vma};
-    }
-    if ($vma != $section{$k}{-vma}) {
-        my $newvma = align($vma, $section{$k}{-algn});
-	if ($newvma != $vma) {
-	    printf STDERR "$0: ERROR $k VMA 0x%08x != 0x%08x\n", $vma, $newvma;
-	    exit 1;
-	}
-	push(@objcopy, '--change-section-address', sprintf "$k=0x%08x", $vma);
-    }
-    $vma = align($vma + $section{$k}{-size}, $section{$k}{-algn});
-}
 
-warn "$0: ERROR final VMA (" . sprintf("0x%08x", $vma) . ") not on 64K boundary\n" if $vma != align($vma, 64 * 1024);
-push(@objcopy, $dll, @ARGV);
-xit 1, @objcopy;
-sub align {
-    my $n = $_[0];
-    my $align = $_[1] - 1;
-    return ($n + $align) & ~$align;
-}
+set -x
+
+STRIP=$1
+OBJCOPY=$2
+DLL=$3
+DBG=$4
 
-sub xit($@) {
-    my $execit = shift;
-    print "+ @_\n";
-    if ($execit) {
-	exec @_ or die "$0: couldn't exec $_[0] - $!\n";
-    } else {
-	system @_ and die "$0: couldn't exec $_[0] - $!\n";
-    }
-}
+${STRIP} --strip-debug ${DLL} -o stripped-${DLL}
+${STRIP} --only-keep-debug ${DLL} -o ${DBG}
+${OBJCOPY} --add-gnu-debuglink=${DBG} stripped-${DLL} ${DLL}
+rm -f stripped-${DLL}
Index: src/winsup/cygwin/cygwin.sc
===================================================================
--- src.orig/winsup/cygwin/cygwin.sc	2007-11-03 11:06:02.000000000 +0000
+++ src/winsup/cygwin/cygwin.sc	2007-11-03 12:17:12.000000000 +0000
@@ -70,22 +70,6 @@ SECTIONS
   {
     *(.cygwin_dll_common)
   }
-  .gnu_debuglink_overlay ALIGN(__section_alignment__) (NOLOAD):
-  {
-    BYTE(0)	/* c */
-    BYTE(0)	/* y */
-    BYTE(0)	/* g */
-    BYTE(0)	/* w */
-    BYTE(0)	/* i */
-    BYTE(0)	/* n */
-    BYTE(0)	/* 1 */
-    BYTE(0)	/* . */
-    BYTE(0)	/* d */
-    BYTE(0)	/* b */
-    BYTE(0)	/* g */
-    BYTE(0)	/* \0 */
-    LONG(0)	/* checksum */
-  }
   .idata ALIGN(__section_alignment__) :
   {
     /* This cannot currently be handled with grouped sections.
@@ -111,7 +95,6 @@ SECTIONS
   }
   __cygheap_end = ABSOLUTE(.);
   __cygheap_end1 = __cygheap_mid + SIZEOF(.cygheap);
-  __cygwin_debug_size = SIZEOF(.gnu_debuglink);
   /DISCARD/ :
   {
     *(.debug$S)




--------------050200030005010200090705--
