Return-Path: <cygwin-patches-return-6294-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27409 invoked by alias); 14 Mar 2008 12:40:03 -0000
Received: (qmail 27314 invoked by uid 22791); 14 Mar 2008 12:39:52 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Fri, 14 Mar 2008 12:39:27 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 8E7E86D430A; Fri, 14 Mar 2008 13:39:24 +0100 (CET)
Date: Fri, 14 Mar 2008 12:40:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch] recognise when an exec()d process terminates due to 	unhandled   exception
Message-ID: <20080314123924.GJ5306@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <47D9D8D3.17BC1E3B@dessent.net> <47DA5CBE.75A475CB@dessent.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47DA5CBE.75A475CB@dessent.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q1/txt/msg00068.txt.bz2

On Mar 14 04:08, Brian Dessent wrote:
> Brian Dessent wrote:
> 
> > isn't present, etc.  I was really hoping to figure out a cool way to get
> > that info, perhaps by poking around in the TEB or PEB somewhere, but I
> > haven't gotten that far.  If anyone has any general ideas where to look
> > for NTLDR's internal state, I'm all ears.  I have a hunch it would be
> > possible to get if we were running the exec'd process in a debugger loop
> > and pumping WaitForDebugEvent() messages, since those can have
> > parameters attached to exception codes.  But that's a little too
> > extreme.
> 
> For anyone curious, it's absolutely possible to do the above.  For the
> C0000139 fault (missing procedure point entry), %ebx at the time of the
> fault points right at the AsciiZ name of the missing import in the
> .idata section, -8(%ebp) points to the import name in UNICODE, and
> -10(%ebp) points to the DLL name in UNICODE.
> 
> For the C0000135 fault (the "unable to locate component popup"), %esi at
> the time of the fault points right to the missing library name in
> UNICODE.
> 
> For the C0000005 fault (the LDR hits an access violation trying to fixup
> a reloc .rdata), %ebx points to an AsciiZ name of the symbol it was
> relocating and 24(%ebp) points to an AsciiZ filename of the module which
> that symbol is supposed to be pointing into.
> 
> Now I'm sure a lot of those above offsets are just coincidental, as I
> haven't done much testing to see if it's reliably set as above.  However
> it does mean that it would be relatively easy to use the debug API to
> step a process through its initialization and find out exactly why it's
> faulting.  I've been working on something along those lines for cygcheck
> which will also give dynamic process tracing, i.e. runtime LoadLibrary
> stuff.  Combined with enabling the LDR snaps debug output, there is a
> tremendous amount of debug capability hidden here.

That's really cool.  Your patch looks good, but it's Chris' code so
he will have the final say.

What we also could do instead of adding this to the DLL is to add this
to cygcheck and/or strace only.  If somebody complains on the list that
a process just exits, we can point him to "run it under cygcheck and it
will tell you what's wrong".  That would be already quite nice, imho.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
