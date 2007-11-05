Return-Path: <cygwin-patches-return-6156-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5180 invoked by alias); 5 Nov 2007 10:19:52 -0000
Received: (qmail 5169 invoked by uid 22791); 5 Nov 2007 10:19:52 -0000
X-Spam-Check-By: sourceware.org
Received: from nf-out-0910.google.com (HELO nf-out-0910.google.com) (64.233.182.185)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Mon, 05 Nov 2007 10:19:50 +0000
Received: by nf-out-0910.google.com with SMTP id b2so1029309nfb         for <cygwin-patches@cygwin.com>; Mon, 05 Nov 2007 02:19:47 -0800 (PST)
Received: by 10.86.58.3 with SMTP id g3mr3316312fga.1194257987247;         Mon, 05 Nov 2007 02:19:47 -0800 (PST)
Received: by 10.86.27.20 with HTTP; Mon, 5 Nov 2007 02:19:47 -0800 (PST)
Message-ID: <4053daab0711050219wa4a7e0fvce4a438242d05ebc@mail.gmail.com>
Date: Mon, 05 Nov 2007 10:19:00 -0000
From: "Pedro Alves" <pedro_alves@portugalmail.pt>
To: cygwin-patches@cygwin.com
Subject: Re: Rewrite/fix cygwin1.dbg generation
In-Reply-To: <20071105084130.GH31224@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <472CB021.5040806@portugalmail.pt> <472CB37A.407FAE34@dessent.net> 	 <20071104022028.GA6236@ednor.casa.cgf.cx> 	 <472D43F5.4090700@portugalmail.pt> 	 <20071105084130.GH31224@calimero.vinschen.de>
X-Google-Sender-Auth: bac7cae5128c6eb2
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q4/txt/msg00008.txt.bz2

Corinna Vinschen wrote:
> On Nov  4 04:00, Pedro Alves wrote:
> >
> > Ah, got it.  VirtualAlloc fails on the first _csbrk, since it
> > is tripping on the VMA of .gnu_debuglink ...  I assumed it would
> > not be a problem, since it isn't ALLOCced, but oh well...
> > I tried adding an EXCLUDE/NOLOAD flag to .gnu_debuglink, but no
> > can do.
>
> That was the reason for creating the .dbg file in the first place,
> wasn't it?  The Windows loader appears to allocate the full size of all
> sections of the image, including the NOLOAD and DEBUG sections.  Sort of
> counterproductive but there seem to be no way around it.
>

It occurred me that the problem may be that
ld is accounting for the virtual address and virtual size of the last section
to write the SizeOfImage field in the PE headers, in
bfd/peXXigen.c:_bfd_XXi_swap_aouthdr_out.
We can change it to not include non ALLOC, DEBUG sections.

Anyone tried that already?

I'll see if I can give it a try tonight.

Cheers,
Pedro Alves
