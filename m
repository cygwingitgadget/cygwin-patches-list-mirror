Return-Path: <cygwin-patches-return-7026-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24543 invoked by alias); 5 May 2010 20:30:55 -0000
Received: (qmail 24508 invoked by uid 22791); 5 May 2010 20:30:50 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-173-76-55-5.bstnma.fios.verizon.net (HELO cgf.cx) (173.76.55.5)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Wed, 05 May 2010 20:30:44 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 577A213C061	for <cygwin-patches@cygwin.com>; Wed,  5 May 2010 16:30:42 -0400 (EDT)
Received: by ednor.cgf.cx (Postfix, from userid 201)	id 526A22B352; Wed,  5 May 2010 16:30:42 -0400 (EDT)
Date: Wed, 05 May 2010 20:30:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: CFA: pseudo-reloc v2
Message-ID: <20100505203042.GA15996@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4AC7910E.1010900@cwilson.fastmail.fm> <4AC82056.7060308@cwilson.fastmail.fm> <4BE1A2C5.4090604@gmail.com> <20100505175614.GA6651@ednor.casa.cgf.cx> <4BE1BFCC.6060703@gmail.com> <20100505191317.GA14692@ednor.casa.cgf.cx> <4BE1CB8C.8020301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4BE1CB8C.8020301@gmail.com>
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
X-SW-Source: 2010-q2/txt/msg00009.txt.bz2

On Wed, May 05, 2010 at 08:48:28PM +0100, Dave Korn wrote:
>On 05/05/2010 20:13, Christopher Faylor wrote:
>
>> Yeah, I realized that two seconds after sending the message.  However,
>> is this particular problem really an issue for DLLs?  DLLs should get
>> their data/bss updated after _pei386_runtime_relocator() is called.  So
>> it seems like you'd get the same thing being written twice.  It's not
>> optimal but it shouldn't be fatal.
>> 
>> The program's data/bss is different since that gets copied during DLL
>> initialization and before _pei386_runtime_relocator() is (was) called.  So
>> I could see how it could be screwed up.
>
>  Ah, right; I wasn't looking at how much later the dll sections got copied, I
>just figured the safest and consistent solution was just to treat everything
>the same.
>
>> That's basically it and I have it more-or-less coded but I haven't
>> finished thinking about DLLs.  Maybe that's more complication than is
>> warranted.  I have to do more research there.  We could, and I think
>> should, put most of the code in pseudo_reloc.c in cygwin1.dll, though,
>> rather than duplicate it in every source file.
>
>  Yeh, the only thing we need in the source file is to capture the module's
>idea of its section start/end pointers, as we already do in the per_process;
>we could consider passing pointers to the pseudo-relocs in that as well, but
>horrible backward-compatibility problems could arise.  It would make sense to
>inline the remnants of _pei386_runtime_relocator into _cygwin_crt0_common and
>do away with the pseudo-reloc.c file altogether.
>
>> This information is all recorded for fork() so it should be doable.  It is
>> more complicated to do it outside of the program but, like I said, it allows
>> us to fix problems by a new release of the DLL rather than telling people
>> "You must relink your program".
>
>  Yeh.  Unfortunately it's too late to help with this time, but it would help
>any future problem (so long as it didn't require us to capture additional data
>in the lib/ part of the executable but could be fixed with what we were
>already passing to the Cygwin DLL).

I have something written now.  I'll dig through the cygwin archives to
see if I can find the original message which started this but are there
other test cases that I could use to verify that I caught all of the
code paths in the DLL?

Chuck?  Do you have anything I could use to test what I did?

What I did:

1) Move pseudo-reloc.c out of lib and into the dll (making
it a c++ file in the process).

2) Record the three values needed by _pei386_runtime_relocator in the
per_process structure.

3) Modify _pei386_runtime_relocator() to take a per_process * argument
and to check that the api of the per_process structure supports the
additional three values.

4) For fork call _pei386_runtime_relocator() before the copy of the program's
data/bss in child_info_fork::handle_fork().

5) For non-fork, call _pei386_runtime_relocator() in dll_crt0_1().

6) For dll's, call _pei386_runtime_relocator() in dll_list::alloc().

I haven't added any optimizations to make this implementation avoid
copying the data/bss but that is doable using Dave's technique.  It
just isn't needed now since the fork data copy should always trump
_pei386_runtime_relocator().

cgf
