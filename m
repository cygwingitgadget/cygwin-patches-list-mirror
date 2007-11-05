Return-Path: <cygwin-patches-return-6155-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1982 invoked by alias); 5 Nov 2007 08:41:36 -0000
Received: (qmail 1971 invoked by uid 22791); 5 Nov 2007 08:41:36 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Mon, 05 Nov 2007 08:41:33 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id C967D6D4805; Mon,  5 Nov 2007 09:41:30 +0100 (CET)
Date: Mon, 05 Nov 2007 08:41:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Rewrite/fix cygwin1.dbg generation
Message-ID: <20071105084130.GH31224@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <472CB021.5040806@portugalmail.pt> <472CB37A.407FAE34@dessent.net> <20071104022028.GA6236@ednor.casa.cgf.cx> <472D43F5.4090700@portugalmail.pt>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <472D43F5.4090700@portugalmail.pt>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q4/txt/msg00007.txt.bz2

On Nov  4 04:00, Pedro Alves wrote:
> Christopher Faylor wrote:
>
>> If that is the case, then this is a welcome change but I'm wondering if
>> it really is true.  Since the debug stripping is linked to the way that
>> cygwin manages the cygwin heap, it is possible that things only appear
>> to work until you allocate more space in the heap.  Has anyone tried the
>> above with a program that, say, opens a lot of file handles?
>
> Ah, got it.  VirtualAlloc fails on the first _csbrk, since it
> is tripping on the VMA of .gnu_debuglink ...  I assumed it would
> not be a problem, since it isn't ALLOCced, but oh well...
> I tried adding an EXCLUDE/NOLOAD flag to .gnu_debuglink, but no
> can do.

That was the reason for creating the .dbg file in the first place,
wasn't it?  The Windows loader appears to allocate the full size of all
sections of the image, including the NOLOAD and DEBUG sections.  Sort of
counterproductive but there seem to be no way around it.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
