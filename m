Return-Path: <cygwin-patches-return-6105-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3953 invoked by alias); 26 May 2007 22:43:48 -0000
Received: (qmail 3942 invoked by uid 22791); 26 May 2007 22:43:47 -0000
X-Spam-Check-By: sourceware.org
Received: from mu-out-0910.google.com (HELO mu-out-0910.google.com) (209.85.134.189)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Sat, 26 May 2007 22:43:45 +0000
Received: by mu-out-0910.google.com with SMTP id i2so1220746mue         for <cygwin-patches@cygwin.com>; Sat, 26 May 2007 15:43:42 -0700 (PDT)
Received: by 10.82.163.13 with SMTP id l13mr8236592bue.1180219421748;         Sat, 26 May 2007 15:43:41 -0700 (PDT)
Received: from ?88.210.64.59? ( [88.210.64.59])         by mx.google.com with ESMTP id 2sm2047273nfv.2007.05.26.15.43.37;         Sat, 26 May 2007 15:43:39 -0700 (PDT)
Message-ID: <4658B7CB.9020107@portugalmail.pt>
Date: Sat, 26 May 2007 22:43:00 -0000
From: Pedro Alves <pedro_alves@portugalmail.pt>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; pt-BR; rv:1.8.0.10) Gecko/20070221 Thunderbird/1.5.0.10 Mnenhy/0.7.4.0
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Dumper produces unuseable dumps (fix).
References: <46310D90.8050703@portugalmail.pt> <20070427062022.GC4978@calimero.vinschen.de> <4053daab0704270801i5c198166n343f8f7f76edc435@mail.gmail.com> <20070515164607.GL4310@calimero.vinschen.de> <4053daab0705170529q60767bb7mf19c2643a6ef79eb@mail.gmail.com> <4652101E.3010706@portugalmail.pt> <20070522071652.GH6003@calimero.vinschen.de> <20070525095002.GA23530@calimero.vinschen.de>
In-Reply-To: <20070525095002.GA23530@calimero.vinschen.de>
Content-Type: multipart/mixed;  boundary="------------040109020609080402030902"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q2/txt/msg00051.txt.bz2

This is a multi-part message in MIME format.
--------------040109020609080402030902
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 313

Corinna Vinschen wrote:
> 
> Ping!  The papers have found their way to our office and are already
> signed.
> 

Great!  That's a relief.

> You said you have an updated patch?

Yep.  Here it is.

human-made-inter-diff:
- set lma == 0
- fixed buglet in the windows->elf protection mappings.

Cheers,
Pedro Alves



--------------040109020609080402030902
Content-Type: text/x-diff;
 name="prog_headers2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="prog_headers2.diff"
Content-length: 3368

2007-05-26  Pedro Alves  <pedro_alves@portugalmail.pt>

        * dumper.cc (version): Bump to 1.15.
        (dumper::prepare_core_dump): Record a phdr for
	each section.

---
 dumper.cc |   63 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 59 insertions(+), 4 deletions(-)

Index: utils/dumper.cc
===================================================================
--- utils.orig/dumper.cc	2007-05-26 23:21:12.000000000 +0100
+++ utils/dumper.cc	2007-05-26 23:40:34.000000000 +0100
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
+      new_section->lma = 0;
       new_section->output_section = new_section;
       new_section->output_offset = 0;
       p->section = new_section;
-    }
+      int section_count = 1;
+
+      bfd_boolean filehdr = 0;
+      bfd_boolean phdrs = 0;
+
+      bfd_vma at = 0;
+      bfd_boolean valid_at = 0;
+
+      flagword flags = 0;
+      bfd_boolean valid_flags = 1;
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
+	      { PAGE_EXECUTE_WRITECOPY, PF_X | PF_W }
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

--------------040109020609080402030902--
