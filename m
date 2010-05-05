Return-Path: <cygwin-patches-return-7024-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24968 invoked by alias); 5 May 2010 19:13:36 -0000
Received: (qmail 24722 invoked by uid 22791); 5 May 2010 19:13:30 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-173-76-55-5.bstnma.fios.verizon.net (HELO cgf.cx) (173.76.55.5)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Wed, 05 May 2010 19:13:19 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 68B7813C068	for <cygwin-patches@cygwin.com>; Wed,  5 May 2010 15:13:17 -0400 (EDT)
Received: by ednor.cgf.cx (Postfix, from userid 201)	id 65D332B352; Wed,  5 May 2010 15:13:17 -0400 (EDT)
Date: Wed, 05 May 2010 19:13:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: CFA: pseudo-reloc v2
Message-ID: <20100505191317.GA14692@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4AC7910E.1010900@cwilson.fastmail.fm> <4AC82056.7060308@cwilson.fastmail.fm> <4BE1A2C5.4090604@gmail.com> <20100505175614.GA6651@ednor.casa.cgf.cx> <4BE1BFCC.6060703@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4BE1BFCC.6060703@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2010-q2/txt/msg00007.txt.bz2

On Wed, May 05, 2010 at 07:58:20PM +0100, Dave Korn wrote:
>On 05/05/2010 18:56, Christopher Faylor wrote:
>
>> I like the idea but I have a few problems with this, some stylistic and
>> some implementation.
>> 
>> Stylistic:
>
>  Those all make sense to me, but I won't rework it yet until we've seen your
>PoC/discussed further.
>
>> Implementation:
>> 
>> I don't like keeping a list of "places we know we need to ignore" separate from
>> the Cygwin DLL.  That means that if there is something new added besides data/bss
>> this function becomes obsolete.
>> 
>> I think this argues for most of this functionality being moved to the
>> Cygwin DLL itself so that an application gets improvements for free.  I
>> should have suggested that when this function first made its way into
>> the libcygwin.a (or maybe I did and someone will enlighten me about why that
>> won't work).
>> 
>> I'll see I can come up with a proof-of-concept of what I'm talking about soon.
>> 
>> Btw, don't we have to worry about data/bss for DLLs too?  Is that
>> handled by this change or is that not an issue?
>
>  We do have to worry and it is handled.  This code gets linked statically
>into each DLL and EXE, each instance referring just to its own pseudo-reloc
>tables.  The Cygwin DLL copies all the data and bss for both DLLs and EXEs (at
>process attach time), then they all run their own pseudo-relocs (at first
>thread attach time).

Yeah, I realized that two seconds after sending the message.  However,
is this particular problem really an issue for DLLs?  DLLs should get
their data/bss updated after _pei386_runtime_relocator() is called.  So
it seems like you'd get the same thing being written twice.  It's not
optimal but it shouldn't be fatal.

The program's data/bss is different since that gets copied during DLL
initialization and before _pei386_runtime_relocator() is (was) called.  So
I could see how it could be screwed up.

>  So we could move the core __write_memory and do_pseudo_relocs routines into
>the DLL, and adjust the code in _cygwin_crt0_common to pass the per_process
>struct to _pei386_runtime_relocator which could pass it and the reloc list
>start/end pointers through to the code in the DLL, and it could then be code
>in the DLL that knows which memory ranges it copied and should avoid
>re-relocating.

That's basically it and I have it more-or-less coded but I haven't
finished thinking about DLLs.  Maybe that's more complication than is
warranted.  I have to do more research there.  We could, and I think
should, put most of the code in pseudo_reloc.c in cygwin1.dll, though,
rather than duplicate it in every source file.

>Is that the kind of structure you were thinking of?  The problem I saw
>with any kind of approach based on actually knowing which ranges were
>actually copied (as opposed to simply inferring that it was the data
>and bss sections between their start and end labels) is that that all
>takes place in the parent rather than the child, so how to communicate
>it to the child where the relocating is taking place would be pretty
>tricky, I thought.

This information is all recorded for fork() so it should be doable.  It is
more complicated to do it outside of the program but, like I said, it allows
us to fix problems by a new release of the DLL rather than telling people
"You must relink your program".

cgf
