Return-Path: <cygwin-patches-return-6318-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7678 invoked by alias); 20 Mar 2008 18:26:57 -0000
Received: (qmail 7550 invoked by uid 22791); 20 Mar 2008 18:26:56 -0000
X-Spam-Check-By: sourceware.org
Received: from dessent.net (HELO dessent.net) (69.60.119.225)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 20 Mar 2008 18:26:26 +0000
Received: from localhost ([127.0.0.1] helo=dessent.net) 	by dessent.net with esmtp (Exim 4.50) 	id 1JcPT6-00085d-7s 	for cygwin-patches@cygwin.com; Thu, 20 Mar 2008 18:26:24 +0000
Message-ID: <47E2AB89.3CC04D13@dessent.net>
Date: Thu, 20 Mar 2008 18:26:00 -0000
From: Brian Dessent <brian@dessent.net>
Reply-To: cygwin-patches@cygwin.com
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: addr2line [ Was: better stackdumps ]
References: <47E05D34.FCC2E30A@dessent.net> <20080319030027.GC22446@ednor.casa.cgf.cx> <47E137C7.8AE02BC4@dessent.net> <20080320103532.GO19345@calimero.vinschen.de> <20080320142306.GB28241@ednor.casa.cgf.cx>
Content-Type: multipart/mixed;  boundary="------------7744EA91CFAF8A68340C2287"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q1/txt/msg00092.txt.bz2

This is a multi-part message in MIME format.
--------------7744EA91CFAF8A68340C2287
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-length: 8850

Corinna Vinschen wrote:

> Is it a big problem to fix addr2line to deal with .dbg files?
> 
> I like your idea to add names to the stackdump especially because of
> addr2line's brokenness.  But, actually, if addr2line would work with
> .dbg files, there would be no reason to add this to the stackdump file.

I absolutely agree that addr2line and/or dumper and/or gdb should be
fixed, regardless of this patch.  I never meant to imply an either/or
situation, and in fact I have debugged addr2line and here are the
reasons it's broken:

Firstly it's got nothing to do with .gnu_debuglink separate debug file,
that part works just fine.  And secondly addr2line only loads the debug
information for the module that you supply with -e, meaning that if you
give "-e a.exe" it will look at symbols for a.exe, but it doesn't know
that a.exe is dynamically linked to cygwin1.dll and it won't try to load
symbols for cygwin1.dll.  This means to use it you need to know
beforehand which module the address is in, which right there makes it
kind of a pain to use for DLLs, and to me it rather dilutes the argument
that you can just postprocess a stackdump file with it since you need
more information than what's there.

The next problem is that addr2line first tries to read STABS, and if
that fails it falls back to DWARF-2.  I always build Cygwin and most
other things with DWARF-2 debug symbols, mainly to make sure they work
but really aren't we eventually hoping to get rid of STABS?  Anyway,
this exposed another problem in that even if you build all of Newlib and
Cygwin with -gdwarf-2 or -ggdb3, you still get a handful STABS symbols
which are hardcoded in various assembler files:

mktemp.cc:20:  asm (".stabs \"" msg "\",30,0,0,0\n\t" \
mktemp.cc:21:  ".stabs \"_" #symbol "\",1,0,0,0\n");

This is used to insert a linktime warning for using mktemp().

sigfe.s:3:      .stabs  "_sigfe:F(0,1)",36,0,0,__sigfe
sigfe.s:44:     .stabs  "_sigbe:F(0,1)",36,0,0,__sigbe
sigfe.s:70:     .stabs  "sigreturn:F(0,1)",36,0,0,_sigreturn
sigfe.s:108:    .stabs  "sigdelayed:F(0,1)",36,0,0,_sigdelayed

This becomes a problem in that when bfd tries to find an address in the
debug data it sees these minimal STABS and considers them a match --
even though they are mostly irrelevant, they are present and since it's
only got an address to go by it doesn't know that there is a much better
match in the DWARF-2 data.  It just sees that it has gotten a (bad)
match, so it doesn't bother looking in the DWARF-2 data.  And since
those hand-coded .stabs above only give symbol name locations, not line
number information, that means that regardless of what you ask addr2line
it's going to return nothing because it only cares about line number
info.

I see two potential fixes here, the first being that Cygwin could be
adapted to not hardcode .stabs but rather detect whether it's being
built with DWARF-2 or STABS and use the appropriate kind.  The other fix
is to teach BFD to try DWARF-2 first before STABS.  The attached patch
does this, for the purposes of illustration -- I don't really claim this
is correct.

Once that is applied, here is the result of running the patched
addr2line on the addresses in the stackdump of this testcase:

$ for F in 610F74B1 610FDD3B 6110A310 610AA4A8 61006094; do
/build/combined/binutils/.libs/addr2line.exe -e /bin/cygwin1.dll -f
0x$F; done
??
??:0
_vfprintf_r
/usr/src/sourceware/newlib/libc/stdio/vfprintf.c:1197
printf
/usr/src/sourceware/newlib/libc/stdio/printf.c:55
??
??:0
_Z10dll_crt0_1Pv
/usr/src/sourceware/winsup/cygwin/dcrt0.cc:930

It now gets 3 out of 5 correct.  It got tripped up on _sigbe because
again addr2line only cares about line number info, not general address
information, and while there is information for the location of _sigbe,
they don't contain line number info:

(gdb) i ad _sigbe
Symbol "_sigbe" is at 0x610aa4a8 in a file compiled without debugging.

For the top frame (strlen), addr2line could not print anything because
while there is location information, there is no line number
information:

(gdb) i li *0x610F74B1
No line number information available for address 0x610f74b1 <strlen+17>

This is due to the fact that strlen is implemented in newlib as
libc/machine/i386/strlen.S which is a straight assembler version, and
hence no line number debug records.



*** To summarize thus far:

1. addr2line can be made to work again by one of a) dictating the use of
STABS (boo!), b) modifying Cygwin to not emit hardcoded .stabs
directives directly, c) modifying BFD to prefer DWARF-2 to STABS when
reading COFF files.

2. addr2line requires the user to know beforehand which DLL a symbol is
in, because it can't resolve runtime dependencies.

3. addr2line only cares about line number debug records, which means it
will be incapable of representing many symbols.

4. As an implication of 3), addr2line is totally useless on DLLs/EXEs
without debug information available.



I think point number 4 is worth repeating: we as developers take for
granted having debug symbols present, but most users do not have that
luxury.  In that case addr2line becomes much less useful if it means
first having to download the Cygwin source and build it, or know that
it's possible to extract the .dbg file from the -src package.  (Although
this won't work very well for use with gdb since the source files won't
be present and even if they are the path to them in the .dbg file won't
be correct.)  This all assumes that they even figured out that addr2line
is part of binutils and installed that in the first place.

And that is what I think makes this worthwhile, and worth putting in the
DLL itself: the ability to get some useful info about the fault without
requiring any developer tools or setup.  Even if the user has no idea
how to use a debugger, they could still potentially paste the backtrace
in an email to the list and list someone might be able to make sense of
it.  How many times in the past has someone done this only to the
response of "a plain stackdump file without symbols is useless as we
don't know what those hex addresses correspond to in your particular set
of DLLs"?  This would fix that.

Christopher Faylor wrote:

> There's still the issue of dealing with the separate signal stack.  That
> makes stack dumps less than useful.

Yes, it means there is one frame that says "sigbe" instead of the actual
return location somewhere else.  I don't think that's impossible to fix
either: the fault handler gets the context of the faulting thread so it
can look up its tls area through %fs:4 and peek at the top of the signal
stack for the value.  I will investigate if this is workable.

But even if the return from signal wrapper frame is wrong, that doesn't
make the output "less than useful".  Again, for reference, in the
testcase it was:

cygwin1.dll!_strlen+0x11
cygwin1.dll!_fputc+0x34EB
cygwin1.dll!_printf+0x30
cygwin1.dll!_sigbe+0x0
cygwin1.dll!_dll_crt0_1+0xC64

Now, given, it's not perfect but it's not significantly worse than the
best that addr2line can muster, and infinitely easier for the user to
generate (i.e. zero effort.)  You can still tell that something called
printf with a bogus string.

> However, I would really love it if gdb was able to decode this information
> automatically.

gdb also gets the sigbe frame wrong, but in general I've found that it
does not have a problem with the frontend wrappers, due to the debug
symbols having the correct info.  However, I think something is amiss in
gdb HEAD because this is what it currently shows for the same testcase:

(gdb) bt
#0  0x610f74b1 in strlen () from /usr/bin/cygwin1.dll
#1  0x7c859dcc in OutputDebugStringA ()
   from /winxp/system32/kernel32.dll
#2  0x40010006 in ?? ()
#3  0x00000000 in ?? ()

I think I see what's going on here though, the Cygwin fault handler took
the first chance exception and wrote the stackdump file, and only then
passed it on to the debugger, so that by the time gdb got notice of the
fault the stack was all fubar.  This could be the reason why dumper is
not working too.  I thought there was a IsBeingDebugged() check in the
cygwin fault handler which would bypass Cygwin fault handling and let
the attached debugger do it.  But maybe it needs ajusting.  Anyway,
that's a different issue.

> The bottom line is that I think that rather than modifying cygwin to
> work around the limitations of the tools we should be fixing the tools.

I understand that desire completely.  It's just that I think we can have
both "free but possibly unreliable" info in the stackdump and "complete
and correct but requiring a developer environment" from the dedicated
debug tools.

> But, then, that puts the problem back on my shoulders as the gdb and
> binutils maintainer.

Don't worry, I have a keen interest in seeing all of this fixed so I
will try to contribute time.

Brian
--------------7744EA91CFAF8A68340C2287
Content-Type: text/plain; charset=us-ascii;
 name="coffgen-favor-dw2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="coffgen-favor-dw2.patch"
Content-length: 1581

Index: coffgen.c
===================================================================
RCS file: /cvs/src/src/bfd/coffgen.c,v
retrieving revision 1.65
diff -u -p -r1.65 coffgen.c
--- coffgen.c	13 Aug 2007 01:45:11 -0000	1.65
+++ coffgen.c	20 Mar 2008 17:33:26 -0000
@@ -2051,22 +2051,22 @@ coff_find_nearest_line (bfd *abfd,
   struct coff_section_tdata *sec_data;
   bfd_size_type amt;
 
-  /* Before looking through the symbol table, try to use a .stab
-     section to find the information.  */
-  if (! _bfd_stab_section_find_nearest_line (abfd, symbols, section, offset,
-					     &found, filename_ptr,
-					     functionname_ptr, line_ptr,
-					     &coff_data(abfd)->line_info))
+  /* Before looking through the symbol table, first try to use DWARF2
+     debugging information to find the location.  */
+  if (! _bfd_dwarf2_find_nearest_line (abfd, section, symbols, offset,
+				      filename_ptr, functionname_ptr,
+				      line_ptr, 0,
+				      &coff_data(abfd)->dwarf2_find_line_info))
     return FALSE;
 
   if (found)
     return TRUE;
 
-  /* Also try examining DWARF2 debugging information.  */
-  if (_bfd_dwarf2_find_nearest_line (abfd, section, symbols, offset,
-				     filename_ptr, functionname_ptr,
-				     line_ptr, 0,
-				     &coff_data(abfd)->dwarf2_find_line_info))
+  /* Fall back to stabs if DWARF2 not present  */
+  if (_bfd_stab_section_find_nearest_line (abfd, symbols, section, offset,
+					   &found, filename_ptr,
+					   functionname_ptr, line_ptr,
+					   &coff_data(abfd)->line_info))
     return TRUE;
 
   *filename_ptr = 0;

--------------7744EA91CFAF8A68340C2287--

