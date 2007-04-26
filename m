Return-Path: <cygwin-patches-return-6075-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5369 invoked by alias); 26 Apr 2007 20:37:52 -0000
Received: (qmail 5345 invoked by uid 22791); 26 Apr 2007 20:37:50 -0000
X-Spam-Check-By: sourceware.org
Received: from ug-out-1314.google.com (HELO ug-out-1314.google.com) (66.249.92.172)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 26 Apr 2007 21:37:46 +0100
Received: by ug-out-1314.google.com with SMTP id j40so602256ugd         for <cygwin-patches@cygwin.com>; Thu, 26 Apr 2007 13:37:41 -0700 (PDT)
Received: by 10.66.249.16 with SMTP id w16mr2093131ugh.1177619861816;         Thu, 26 Apr 2007 13:37:41 -0700 (PDT)
Received: from ?88.210.68.18? ( [88.210.68.18])         by mx.google.com with ESMTP id 54sm5769509ugp.2007.04.26.13.37.38;         Thu, 26 Apr 2007 13:37:40 -0700 (PDT)
Message-ID: <46310D90.8050703@portugalmail.pt>
Date: Thu, 26 Apr 2007 20:37:00 -0000
From: Pedro Alves <pedro_alves@portugalmail.pt>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; pt-BR; rv:1.8.0.10) Gecko/20070221 Thunderbird/1.5.0.10 Mnenhy/0.7.4.0
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Dumper produces unuseable dumps (fix).
Content-Type: multipart/mixed;  boundary="------------030406050203000908060603"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q2/txt/msg00021.txt.bz2

This is a multi-part message in MIME format.
--------------030406050203000908060603
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 4911

Hi guys,

I noticed that dumper isn't working for me, silently exiting
without producing a dump, so I tried building it from source.
The problem was that the bfd_set_arch_mach (core_bfd, bfd_arch_i386, 0)
call was failing.  I couldn't debug it, since it was linked
into the system /usr/lib/libbfd.a, which doesn't come with
debug info.  I then tried to link with with a cvs bfd, and that
problem goes away.

But, I then found out that gdb wasn't reading the dumps.  After
some investigation, I found that the core file is built with
section headers, and no program headers.  Since it is
bfd_make_section_from_phdr that makes the magic sections that
gdb reads from, the current dumper makes useless core dumps.

eg:

   >cat main.c
int asdf = 1;

int main ()
{
     asdf = 30;
     abort ();
}

./main.exe

dumper.exe pops up a console with a bunch of warnings like:

   >./dumper.exe main.exe 5700
BFD: main.exe.core: warning: allocated section `.mem/10' not in segment
BFD: main.exe.core: warning: allocated section `.mem/11' not in segment
(...)

and gdb complains like so:

   >/usr/local/bin/gdb --core=main.exe.core
GNU gdb 6.6.50.20070416-cvs
Copyright (C) 2007 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "i686-pc-cygwin".

warning: Couldn't find general-purpose registers in core file.

warning: Couldn't find general-purpose registers in core file.
#0  0x00000000 in ?? ()
(gdb) symbol-file main.exe
Reading symbols from
/cygdrive/d/cygwin-src/build/i686-pc-cygwin/winsup/utils/main.exe...done.
(gdb) p asdf
Cannot access memory at address 0x402000
(gdb)

, and, readelf shows that:
   >readelf -l  main.exe.core

There are no program headers in this file.

At least linux and solaris generate dumps with
program headers, and no section headers.  In gdb/bfd I
could only find support for reading the magic core
sections from phdrs, so I guess that at some point bfd
automatically generated these phdrs, but nowadays it
doesn't.

The attached patch fixes it by programatically making a
phdr for each section.  I now get readable dumps.

readelf -l main.exe.core

Elf file type is CORE (Core file)
Entry point 0x0
There are 50 program headers, starting at offset 52

Program Headers:
     Type           Offset   VirtAddr   PhysAddr   FileSiz MemSiz  Flg Align
     NOTE           0x000674 0x00000000 0x00000000 0x0032c 0x00000     0x1
     NOTE           0x0009a0 0x00000000 0x00000000 0x002f4 0x00000     0x1
     NOTE           0x000c94 0x00000000 0x00000000 0x002f4 0x00000     0x1
     NOTE           0x000f88 0x00000000 0x00000000 0x00311 0x00000     0x1
     NOTE           0x001299 0x00000000 0x00000000 0x00314 0x00000     0x1
     NOTE           0x0015ad 0x00000000 0x00000000 0x0030d 0x00000     0x1
     NOTE           0x0018ba 0x00000000 0x00000000 0x00314 0x00000     0x1
     NOTE           0x001bce 0x00000000 0x00000000 0x00312 0x00000     0x1
     NOTE           0x001ee0 0x00000000 0x00000000 0x00313 0x00000     0x1
     NOTE           0x0021f3 0x00000000 0x00000000 0x002f4 0x00000     0x1
     LOAD           0x0024e7 0x00010000 0x00010000 0x01000 0x01000 RW  0x1
     LOAD           0x0034e7 0x00020000 0x00020000 0x01000 0x01000 RW  0x1
     LOAD           0x0044e7 0x0022c000 0x0022c000 0x07000 0x07000 RW  0x1
     LOAD           0x00b4e7 0x00240000 0x00240000 0x08000 0x08000 RW  0x1
     LOAD           0x0134e7 0x00340000 0x00340000 0x06000 0x06000 RW  0x1
     LOAD           0x0194e7 0x00350000 0x00350000 0x03000 0x03000 RW  0x1
(...)

GNU gdb 6.6.50.20070416-cvs
Copyright (C) 2007 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "i686-pc-cygwin".
#0  0x7c91eb94 in ?? ()
(gdb) symbol-file main.exe
Reading symbols from
/cygdrive/d/cygwin-src/build/i686-pc-cygwin/winsup/utils/main.exe...done.
(gdb) p asdf
$1 = 30

Not forcing a higher alignment of the sections doesn't seem to have
any bad effect, so I left it out.

I see a probably unrelated problem.  When using error_start to
start dumper.exe, it seems that the stack trace always starts
in a frameless dll function.  I know that the dump is ok, since
I tested it by manually dumping a program stopped in a 'while (1);'
loop, and that gives an ok trace.  I also confirmed that I could
print local and global variables, and that they came
up with the expected values.

Could this fix be considered for inclusion, please?

Cheers,
Pedro Alves



--------------030406050203000908060603
Content-Type: text/x-diff;
 name="prog_headers.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="prog_headers.diff"
Content-length: 3391

2007-04-26  Pedro Alves  <pedro_alves@portugalmail.pt>

        * dumper.cc (version): Bump to 1.15.
        (dumper::prepare_core_dump): Record a phdr for
	each section.

---
 dumper.cc |   63 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 59 insertions(+), 4 deletions(-)

Index: utils/dumper.cc
===================================================================
--- utils.orig/dumper.cc	2006-12-21 09:59:04.000000000 +0000
+++ utils/dumper.cc	2007-04-26 02:00:42.000000000 +0100
@@ -1,6 +1,6 @@
 /* dumper.cc
 
-   Copyright 1999, 2001, 2002, 2004, 2006 Red Hat Inc.
+   Copyright 1999, 2001, 2002, 2004, 2006, 2007 Red Hat Inc.
 
    Written by Egor Duda <deo@logos-m.ru>
 
@@ -37,7 +37,7 @@ __attribute__ ((packed))
 #endif
   note_header;
 
-static const char version[] = "$Revision: 1.14 $";
+static const char version[] = "$Revision: 1.15 $";
 
 BOOL verbose = FALSE;
 
@@ -657,6 +657,8 @@ dumper::prepare_core_dump ()
     {
       sect_no++;
 
+      unsigned long phdr_type = PT_LOAD;
+
       switch (p->type)
 	{
 	case pr_ent_memory:
@@ -664,7 +666,7 @@ dumper::prepare_core_dump ()
 	  sect_flags = SEC_HAS_CONTENTS | SEC_ALLOC | SEC_LOAD;
 	  sect_size = p->u.memory.size;
 	  sect_vma = (bfd_vma) (p->u.memory.base);
-
+	  phdr_type = PT_LOAD;
 	  break;
 
 	case pr_ent_thread:
@@ -672,6 +674,7 @@ dumper::prepare_core_dump ()
 	  sect_flags = SEC_HAS_CONTENTS | SEC_LOAD;
 	  sect_size = sizeof (note_header) + sizeof (struct win32_pstatus);
 	  sect_vma = 0;
+	  phdr_type = PT_NOTE;
 	  break;
 
 	case pr_ent_module:
@@ -680,6 +683,7 @@ dumper::prepare_core_dump ()
 	  sect_size = sizeof (note_header) + sizeof (struct win32_pstatus) +
 	    (bfd_size_type) (strlen (p->u.module.name));
 	  sect_vma = 0;
+	  phdr_type = PT_NOTE;
 	  break;
 
 	default:
@@ -722,11 +726,62 @@ dumper::prepare_core_dump ()
 	};
 
       new_section->vma = sect_vma;
+      new_section->lma = sect_vma;
       new_section->output_section = new_section;
       new_section->output_offset = 0;
       p->section = new_section;
-    }
+      int section_count = 1;
+
+      bfd_boolean filehdr = false;
+      bfd_boolean phdrs = false;
+
+      bfd_vma at = sect_vma;
+      bfd_boolean valid_at = true;
+
+      flagword flags = 0;
+      bfd_boolean valid_flags = true;
+
+      if (p->type == pr_ent_memory)
+	{
+	  MEMORY_BASIC_INFORMATION mbi;
+	  if (!VirtualQueryEx (hProcess, (LPVOID)sect_vma, &mbi, sizeof (mbi)))
+	    {
+	      bfd_perror ("getting mem region flags");
+	      goto failed;
+	    }
+
+	  static const struct
+	  {
+	    DWORD protect;
+	    flagword flags;
+	  } mappings[] =
+	    {
+	      { PAGE_READONLY, PF_R },
+	      { PAGE_READWRITE, PF_R | PF_W },
+	      { PAGE_WRITECOPY, PF_W },
+	      { PAGE_EXECUTE, PF_X },
+	      { PAGE_EXECUTE_READ, PF_X | PF_R },
+	      { PAGE_EXECUTE_READWRITE, PF_X | PF_R | PF_W },
+	      { PAGE_EXECUTE_WRITECOPY, PF_W }
+	    };
+
+	  for (size_t i = 0;
+	       i < sizeof (mappings) / sizeof (mappings[0]);
+	       i++)
+	    if ((mbi.Protect & mappings[i].protect) != 0)
+	      flags |= mappings[i].flags;
+	}
 
+      if (!bfd_record_phdr (core_bfd, phdr_type,
+			    valid_flags, flags,
+			    valid_at, at,
+			    filehdr, phdrs,
+			    section_count, &new_section))
+	{
+	  bfd_perror ("recording program headers");
+	  goto failed;
+	}
+    }
   return 1;
 
 failed:



--------------030406050203000908060603--
