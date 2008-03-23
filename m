Return-Path: <cygwin-patches-return-6325-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1287 invoked by alias); 23 Mar 2008 04:06:46 -0000
Received: (qmail 1277 invoked by uid 22791); 23 Mar 2008 04:06:45 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-72-74-94-32.bstnma.fios.verizon.net (HELO ednor.cgf.cx) (72.74.94.32)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Sun, 23 Mar 2008 04:06:28 +0000
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id 5764838C100; Sun, 23 Mar 2008 00:06:26 -0400 (EDT)
Date: Sun, 23 Mar 2008 04:06:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch] recognise when an exec()d process terminates due to 	unhandled   exception
Message-ID: <20080323040626.GA2589@ednor.casa.cgf.cx>
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
X-SW-Source: 2008-q1/txt/msg00099.txt.bz2

On Fri, Mar 14, 2008 at 04:08:46AM -0700, Brian Dessent wrote:
>Brian Dessent wrote:
>
>> isn't present, etc.  I was really hoping to figure out a cool way to get
>> that info, perhaps by poking around in the TEB or PEB somewhere, but I
>> haven't gotten that far.  If anyone has any general ideas where to look
>> for NTLDR's internal state, I'm all ears.  I have a hunch it would be
>> possible to get if we were running the exec'd process in a debugger loop
>> and pumping WaitForDebugEvent() messages, since those can have
>> parameters attached to exception codes.  But that's a little too
>> extreme.
>
>For anyone curious, it's absolutely possible to do the above.  For the
>C0000139 fault (missing procedure point entry), %ebx at the time of the
>fault points right at the AsciiZ name of the missing import in the
>.idata section, -8(%ebp) points to the import name in UNICODE, and
>-10(%ebp) points to the DLL name in UNICODE.
>
>For the C0000135 fault (the "unable to locate component popup"), %esi at
>the time of the fault points right to the missing library name in
>UNICODE.
>
>For the C0000005 fault (the LDR hits an access violation trying to fixup
>a reloc .rdata), %ebx points to an AsciiZ name of the symbol it was
>relocating and 24(%ebp) points to an AsciiZ filename of the module which
>that symbol is supposed to be pointing into.
>
>Now I'm sure a lot of those above offsets are just coincidental, as I
>haven't done much testing to see if it's reliably set as above.  However
>it does mean that it would be relatively easy to use the debug API to
>step a process through its initialization and find out exactly why it's
>faulting.  I've been working on something along those lines for cygcheck
>which will also give dynamic process tracing, i.e. runtime LoadLibrary
>stuff.  Combined with enabling the LDR snaps debug output, there is a
>tremendous amount of debug capability hidden here.

I took a more low-tech and undoubtedly less foolproof approach and just
stepped through the list of dlls for the failing executable, trying to
load them one at a time, reporting on the first dll to fail.  This is
not necessarily the same scenario as what the Windows "dynamic linker"
is doing but it should report an *a* missing dll if not necessarily the
dll that was causing the problem.  It also won't necessarily get the
search order right if the executable being started isn't in the same
directory as the "parent" executable.  That's fixable, though.

cgf
