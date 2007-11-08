Return-Path: <cygwin-patches-return-6160-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23519 invoked by alias); 8 Nov 2007 00:05:17 -0000
Received: (qmail 23382 invoked by uid 22791); 8 Nov 2007 00:05:14 -0000
X-Spam-Check-By: sourceware.org
Received: from fk-out-0910.google.com (HELO fk-out-0910.google.com) (209.85.128.190)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 08 Nov 2007 00:05:10 +0000
Received: by fk-out-0910.google.com with SMTP id 19so4699149fkr         for <cygwin-patches@cygwin.com>; Wed, 07 Nov 2007 16:05:07 -0800 (PST)
Received: by 10.82.134.12 with SMTP id h12mr16426796bud.1194480307364;         Wed, 07 Nov 2007 16:05:07 -0800 (PST)
Received: from ?78.130.31.155? ( [78.130.31.155])         by mx.google.com with ESMTPS id d23sm357065nfh.2007.11.07.16.05.04         (version=TLSv1/SSLv3 cipher=RC4-MD5);         Wed, 07 Nov 2007 16:05:05 -0800 (PST)
Message-ID: <4732525D.6090809@portugalmail.pt>
Date: Thu, 08 Nov 2007 00:05:00 -0000
From: Pedro Alves <pedro_alves@portugalmail.pt>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; pt-BR; rv:1.8.1.6) Gecko/20070728 Thunderbird/2.0.0.6 Mnenhy/0.7.5.0
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Rewrite/fix cygwin1.dbg generation
References: <472CB021.5040806@portugalmail.pt> <472CB37A.407FAE34@dessent.net> <20071104022028.GA6236@ednor.casa.cgf.cx> <472D43F5.4090700@portugalmail.pt> <20071105084130.GH31224@calimero.vinschen.de> <4053daab0711050219wa4a7e0fvce4a438242d05ebc@mail.gmail.com> <20071105112048.GA17996@calimero.vinschen.de> <20071105115705.GA2172@ednor.casa.cgf.cx>
In-Reply-To: <20071105115705.GA2172@ednor.casa.cgf.cx>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
X-SW-Source: 2007-q4/txt/msg00012.txt.bz2

Christopher Faylor wrote:
> On Mon, Nov 05, 2007 at 12:20:48PM +0100, Corinna Vinschen wrote:
>> On Nov  5 10:19, Pedro Alves wrote:
>>> It occurred me that the problem may be that
>>> ld is accounting for the virtual address and virtual size of the last section
>>> to write the SizeOfImage field in the PE headers, in
>>> bfd/peXXigen.c:_bfd_XXi_swap_aouthdr_out.
>>> We can change it to not include non ALLOC, DEBUG sections.
>>>
>>> Anyone tried that already?
>> Not me.  It never occurred to me that this could be a problem in ld,
>> actually.  If that's the problem and we can fix it, that would be really
>> cool.  IIUTC, it would remove the necessity to create a cygwin1.dbg file
>> at all.
> 

Uuups, I wrote ld, when I meant binutils/bfd/'the pe output mechanism'.

The .gnu_debuglink is added by objcopy, as you know, so fixing this
in bfd/* fixes every binutils tool that outputs a PE file.

> The real question is if the above is actually doing the right thing wrt
> LINK.EXE.  When I was playing with this, I could duplicate the behavior
> I didn't want by fiddling with the bits in the sections with Microsoft
> tools, bypassing ld entirely.  So, I'm not sure that this is an ld.exe
> problem.
> 

Not sure if we're talking about the same thing.

The idea would be that when calculating the size of the image
(SizeOfImage == memory the loader will allocate), we don't
account for the top sections that aren't supposed to be
allocated in the first place, in an attempt that
the loader doesn't include them in the single
VirtualAlloc it is doing to allocate the
whole contigous memory range where the image is fit in.

That is:

+---------------------------------------+-
| 0 .text                               |
|   (CONTENTS|ALLOC|LOAD|READONLY|CODE) | These should accounted
| 1 .data                               | for the size of the
|   (CONTENTS|ALLOC|LOAD|DATA)          | image (minus PE headers)
| 2 .nmastcbaas (*)                     |
|   (DEBUG)                             |
| 3 .bss                                |
|   (ALLOC)                             |
| 4 .cygheap (last alloced section)     |
|   (ALLOC)                             |
+---------------------------------------+-
| 5 .stabs                              |
|   (CONTENTS|READONLY|DEBUG|EXCLUDE)   |  These should not
| 6 .gnu_debuglink                      |
|   (CONTENTS|READONLY|DEBUG)           |
+---------------------------------------+-

    * My Non ALLOC Section That Comes Before An ALLOC Section

... but unfortunatelly, the loader does some validations,
which seem to make this impossible (invalid PE).  Bummer.  This
must be one of the reasons MSFT came up with
IMAGE_DEBUG_DIRECTORY.

Oh, well, can't say I didn't try :-)

Cheers,
Pedro Alves

