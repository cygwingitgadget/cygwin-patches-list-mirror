Return-Path: <cygwin-patches-return-6293-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5561 invoked by alias); 14 Mar 2008 11:09:10 -0000
Received: (qmail 5551 invoked by uid 22791); 14 Mar 2008 11:09:10 -0000
X-Spam-Check-By: sourceware.org
Received: from dessent.net (HELO dessent.net) (69.60.119.225)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 14 Mar 2008 11:08:45 +0000
Received: from localhost ([127.0.0.1] helo=dessent.net) 	by dessent.net with esmtp (Exim 4.50) 	id 1Ja7mF-0001bF-EJ 	for cygwin-patches@cygwin.com; Fri, 14 Mar 2008 11:08:43 +0000
Message-ID: <47DA5CBE.75A475CB@dessent.net>
Date: Fri, 14 Mar 2008 11:09:00 -0000
From: Brian Dessent <brian@dessent.net>
Reply-To: cygwin-patches@cygwin.com
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [patch] recognise when an exec()d process terminates due to   unhandled   exception
References: <47D9D8D3.17BC1E3B@dessent.net>
Content-Type: text/plain; charset=us-ascii
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
X-SW-Source: 2008-q1/txt/msg00067.txt.bz2

Brian Dessent wrote:

> isn't present, etc.  I was really hoping to figure out a cool way to get
> that info, perhaps by poking around in the TEB or PEB somewhere, but I
> haven't gotten that far.  If anyone has any general ideas where to look
> for NTLDR's internal state, I'm all ears.  I have a hunch it would be
> possible to get if we were running the exec'd process in a debugger loop
> and pumping WaitForDebugEvent() messages, since those can have
> parameters attached to exception codes.  But that's a little too
> extreme.

For anyone curious, it's absolutely possible to do the above.  For the
C0000139 fault (missing procedure point entry), %ebx at the time of the
fault points right at the AsciiZ name of the missing import in the
.idata section, -8(%ebp) points to the import name in UNICODE, and
-10(%ebp) points to the DLL name in UNICODE.

For the C0000135 fault (the "unable to locate component popup"), %esi at
the time of the fault points right to the missing library name in
UNICODE.

For the C0000005 fault (the LDR hits an access violation trying to fixup
a reloc .rdata), %ebx points to an AsciiZ name of the symbol it was
relocating and 24(%ebp) points to an AsciiZ filename of the module which
that symbol is supposed to be pointing into.

Now I'm sure a lot of those above offsets are just coincidental, as I
haven't done much testing to see if it's reliably set as above.  However
it does mean that it would be relatively easy to use the debug API to
step a process through its initialization and find out exactly why it's
faulting.  I've been working on something along those lines for cygcheck
which will also give dynamic process tracing, i.e. runtime LoadLibrary
stuff.  Combined with enabling the LDR snaps debug output, there is a
tremendous amount of debug capability hidden here.

Brian
