Return-Path: <cygwin-patches-return-6159-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23134 invoked by alias); 5 Nov 2007 12:04:48 -0000
Received: (qmail 23112 invoked by uid 22791); 5 Nov 2007 12:04:44 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Mon, 05 Nov 2007 12:04:41 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 8E20A6D4805; Mon,  5 Nov 2007 13:04:38 +0100 (CET)
Date: Mon, 05 Nov 2007 12:04:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Rewrite/fix cygwin1.dbg generation
Message-ID: <20071105120438.GM31224@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <472CB021.5040806@portugalmail.pt> <472CB37A.407FAE34@dessent.net> <20071104022028.GA6236@ednor.casa.cgf.cx> <472D43F5.4090700@portugalmail.pt> <20071105084130.GH31224@calimero.vinschen.de> <4053daab0711050219wa4a7e0fvce4a438242d05ebc@mail.gmail.com> <20071105112048.GA17996@calimero.vinschen.de> <20071105115705.GA2172@ednor.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071105115705.GA2172@ednor.casa.cgf.cx>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q4/txt/msg00011.txt.bz2

On Nov  5 06:57, Christopher Faylor wrote:
> On Mon, Nov 05, 2007 at 12:20:48PM +0100, Corinna Vinschen wrote:
> >On Nov  5 10:19, Pedro Alves wrote:
> >> It occurred me that the problem may be that
> >> ld is accounting for the virtual address and virtual size of the last section
> >> to write the SizeOfImage field in the PE headers, in
> >> bfd/peXXigen.c:_bfd_XXi_swap_aouthdr_out.
> >> We can change it to not include non ALLOC, DEBUG sections.
> >> 
> >> Anyone tried that already?
> >
> >Not me.  It never occurred to me that this could be a problem in ld,
> >actually.  If that's the problem and we can fix it, that would be really
> >cool.  IIUTC, it would remove the necessity to create a cygwin1.dbg file
> >at all.
> 
> The real question is if the above is actually doing the right thing wrt
> LINK.EXE.  When I was playing with this, I could duplicate the behavior
> I didn't want by fiddling with the bits in the sections with Microsoft
> tools, bypassing ld entirely.  So, I'm not sure that this is an ld.exe
> problem.

Too bad.  It would have been nice, though.  Ld can be fixed, in contrast
to the Windows loader.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
