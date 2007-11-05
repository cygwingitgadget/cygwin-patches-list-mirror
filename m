Return-Path: <cygwin-patches-return-6157-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3563 invoked by alias); 5 Nov 2007 11:20:58 -0000
Received: (qmail 3544 invoked by uid 22791); 5 Nov 2007 11:20:56 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Mon, 05 Nov 2007 11:20:51 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 6031F6D4805; Mon,  5 Nov 2007 12:20:48 +0100 (CET)
Date: Mon, 05 Nov 2007 11:20:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Rewrite/fix cygwin1.dbg generation
Message-ID: <20071105112048.GA17996@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <472CB021.5040806@portugalmail.pt> <472CB37A.407FAE34@dessent.net> <20071104022028.GA6236@ednor.casa.cgf.cx> <472D43F5.4090700@portugalmail.pt> <20071105084130.GH31224@calimero.vinschen.de> <4053daab0711050219wa4a7e0fvce4a438242d05ebc@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4053daab0711050219wa4a7e0fvce4a438242d05ebc@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q4/txt/msg00009.txt.bz2

On Nov  5 10:19, Pedro Alves wrote:
> Corinna Vinschen wrote:
> > On Nov  4 04:00, Pedro Alves wrote:
> > >
> > > Ah, got it.  VirtualAlloc fails on the first _csbrk, since it
> > > is tripping on the VMA of .gnu_debuglink ...  I assumed it would
> > > not be a problem, since it isn't ALLOCced, but oh well...
> > > I tried adding an EXCLUDE/NOLOAD flag to .gnu_debuglink, but no
> > > can do.
> >
> > That was the reason for creating the .dbg file in the first place,
> > wasn't it?  The Windows loader appears to allocate the full size of all
> > sections of the image, including the NOLOAD and DEBUG sections.  Sort of
> > counterproductive but there seem to be no way around it.
> >
> 
> It occurred me that the problem may be that
> ld is accounting for the virtual address and virtual size of the last section
> to write the SizeOfImage field in the PE headers, in
> bfd/peXXigen.c:_bfd_XXi_swap_aouthdr_out.
> We can change it to not include non ALLOC, DEBUG sections.
> 
> Anyone tried that already?

Not me.  It never occurred to me that this could be a problem in ld,
actually.  If that's the problem and we can fix it, that would be really
cool.  IIUTC, it would remove the necessity to create a cygwin1.dbg file
at all.

> I'll see if I can give it a try tonight.

Yes, please!


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
