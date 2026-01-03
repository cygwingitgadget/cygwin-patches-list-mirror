Return-Path: <SRS0=4ELj=7I=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e07.mail.nifty.com (mta-snd-e07.mail.nifty.com [106.153.226.39])
	by sourceware.org (Postfix) with ESMTPS id 8065E4BA2E06
	for <cygwin-patches@cygwin.com>; Sat,  3 Jan 2026 15:30:48 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 8065E4BA2E06
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 8065E4BA2E06
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1767454249; cv=none;
	b=kv7QdqGmbwc+G3nj5fmF37BZfotzDGou4bHK6dQVlJOjNaEplTlHzSQHedLkJVwTHp/wlyzOcd8xg01yQzk2QRrMIu+xAKpJ5k7tjqOFMB0Pa5orr00oZ2xXqYYp7fiaTV+q7D3uHoEk3U5APaMD8VCGfG7i8bB0HZqW5gP8h3c=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1767454249; c=relaxed/simple;
	bh=7sCXLWXvjVnm6wOwmyAIUTOAcG22lpE0OX3NZ2A3awU=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=cLYPLszVteMaBS34yMy4hADUUaDQ5kJditLyHb6bfmuoD0I9xFCJwRjtmy0jpJ8wMw6cVOHPe0AisfEOybAi0zSaCIU6KxfuLMVGvtnjnK1fmJz+KkrtGDcCgYG8xocb63uSCvZqmsWbfC3vp/lm3QIuktsIIEFkvnzemSDD0CE=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 8065E4BA2E06
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=LXUgomzc
Received: from HP-Z230 by mta-snd-e07.mail.nifty.com with ESMTP
          id <20260103153046499.GXZZ.14880.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Sun, 4 Jan 2026 00:30:46 +0900
Date: Sun, 4 Jan 2026 00:30:46 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: thread: Fix stack alignment for
 PTHREAD_CANCEL_ASYNCHRONOUS
Message-Id: <20260104003046.3f74fdee9d86a536584bc8c7@nifty.ne.jp>
In-Reply-To: <ea7ab90b-f7a6-4203-ad62-a66467b155f5@dronecode.org.uk>
References: <20251223184150.1415-1-takashi.yano@nifty.ne.jp>
	<ea7ab90b-f7a6-4203-ad62-a66467b155f5@dronecode.org.uk>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1767454246;
 bh=+w5+u0N75kftvtDtxL1MFG3e+fdP+jG6fo4B6LNVwdw=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=LXUgomzcSpTgd3BeCRgGW83mu7oBWrRSMly/eoLfPrgXN0oQsnlSXPUMjEu4MutJqTFKsVyU
 W/skfqeF6gIyOColT1rAcVd/t7AF5HFLDflIDvNn8pyCoak0GRE/mwxk7LuRmZZEHD5hIW/bCZ
 RfP28b3ctMToMMkftftRbborUtECJdsL7nGIS2xcGg5F24bFsdMgjCiiIQaK/UjduMJZdRynLo
 Gwllp36JCzgdCSFM/N2oGcLdOfP4xsKNQlY9hcycsflpv+qDXfUmpELM9Vpg4SxFU0dkg1qrYa
 Eq59ZXaGMSWJmnVgjKGL5EI8YR7pD+nEwoGn8p4yD3D+nOZA==
X-Spam-Status: No, score=-11.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Jon,

Thanks for reviewing.

On Wed, 24 Dec 2025 15:29:23 +0000
Jon Turney <jon.turney@dronecode.org.uk> wrote:

> On 23/12/2025 18:41, Takashi Yano wrote:
> > The test case winsup/testsuites/winsup.api/pthread/cancel2 fails
> > on Windows 11 and Windows Server 2025, while it works on Windows 10
> > and Windows Server 2022. PTHREAD_CANCEL_ASYNCHRONOUS is implemented
> 
> Awesome piece of detective work tracking this down! Well done!
> 
> > using [GS]etThreadContext() on the target thread and forcibly
> > overrides instruction pointer to pthread::static_cancel_self().
> > Previously, the stack pointer was not trimmed to 16-byte alignment,
> > even though this is required by 64-bit Windows ABI. This appears to
> > have been overlooked when cygwin first added x86_64 support.
> > 
> > This patch fixes this issue by aligning the stack pointer as well as
> > the instruction pointer in the PTHREAD_CANCEL_ASYNCHRONOUS handling.
> 
> To restate the problem a bit more generally:
> 
> * PTHREAD_CANCEL_ASYNCHRONOUS is implemented by forcing the target 
> thread's IP to pthread::static_cancel_self().
> 
> * static_cancel_self() may (will) call Windows API functions during 
> thread shutdown. A misaligned stack will lead to unexpected exceptions.
> 
> * At the start of the function prologue the stack is expected to be at 
> an offset of 8 from a 16-byte boundary (IP % 16 == 8), as the call 
> instruction has just pushed the return IP onto the stack.
> 
> * Therefore, we must also adjust the stack pointer like that to ensure 
> that stack alignment is correct at the end of the function prologue.
> 
> > Addresses: https://cygwin.com/pipermail/cygwin/2025-December/259117.html
> > Fixes: 61522196c715 ("* Merge in cygwin-64bit-branch.")
> 
> Given all that, it's kind of surprising that this ever worked at all!
> 
> > Reported-by: Takashi Yano <takashi.yano@nity.ne.jp>
> > Reviewed-by:
> > Signed-off-by: Takashi Yano <takashi.yano@nity.ne.jp>
> > ---
> >   winsup/cygwin/thread.cc | 19 +++++++++++++++++++
> >   1 file changed, 19 insertions(+)
> > 
> > diff --git a/winsup/cygwin/thread.cc b/winsup/cygwin/thread.cc
> > index 86a00e76e..2270a248b 100644
> > --- a/winsup/cygwin/thread.cc
> > +++ b/winsup/cygwin/thread.cc
> > @@ -630,6 +630,25 @@ pthread::cancel ()
> >         threadlist_t *tl_entry = cygheap->find_tls (cygtls);
> >         if (!cygtls->inside_kernel (&context))
> >   	{
> > +#if defined(__x86_64__)
> > +	  /* Need to trim alignment of stack pointer.
> > +	     https://learn.microsoft.com/en-us/cpp/build/stack-usage?view=msvc-170
> > +	     states,
> > +	       "The stack will always be maintained 16-byte aligned,
> > +	        except within the prolog (for example, after the return
> > +		address is pushed),",
> > +	     that is, we need 16n + 8 byte alignment here. */
> 
> Maybe this should say something like "we don't fully emulate a call 
> instruction, by pushing the current IP onto the stack. But we need to 
> fake the SP adjustment that does, in order for SP to be correctly 
> aligned at the end of the function prologue"?
> 
> Returning from pthread::static_cancel_self() mustn't happen because we 
> haven't fully synthesized the call instruction by storing the return 
> address on the stack (and maybe other things). This is memorialized by 
> the no_return function attribute.
> 
> > +	  context._CX_stackPtr &= 0xfffffffffffffff8UL;
> > +	  if ((context._CX_stackPtr & 8) == 0)
> > +	    context._CX_stackPtr -= 8;
> > +#elif defined(__aarch64__)
> > +	  /* 16 bytes alignment required. Trim stack pointer just in case.
> > +	  https://learn.microsoft.com/en-us/cpp/build/arm64-windows-abi-conventions?view=msvc-170
> > +	  */
> > +	  context._CX_stackPtr &= 0xfffffffffffffff0UL;
> 
> I kind of like (~0x0FUL) as it saves counting if that's the right number 
> of 'F's :)
> 
> > +#else
> > +#error unimplemented for this target
> > +#endif
> >   	  context._CX_instPtr = (ULONG_PTR) pthread::static_cancel_self;
> >   	  SetThreadContext (win32_obj_id, &context);
> >   	}

I pushed the patch after the changes you suggested. Thanks!

> Some future work thoughts:
> 
> * It seems like the force_align_arg_pointer function attribute maybe 
> instructs the compiler to do the appropriate re-alignment, but opinion 
> seems mixed as to if it works correctly.
> 
> * I don't think there are any other, similar uses of SetThreadContext, 
> but if there are, maybe they need similar treatment.

SetThreadContext() is used in also signal handling (callign sigdelayed).
However, the stack is maintained in the assembly code of sigdelayed.

> * As a thought experiment, I'm not sure what the potential for double 
> frees or similar bad things happening, if the target thread is in the 
> middle of exiting already. I think thread class has some guards against 
> that kind of thing?

Maybe.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
