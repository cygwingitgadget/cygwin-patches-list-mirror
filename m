Return-Path: <SRS0=wCit=FC=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e10.mail.nifty.com (mta-snd-e10.mail.nifty.com [106.153.226.42])
	by sourceware.org (Postfix) with ESMTPS id 60E344BA5439
	for <cygwin-patches@cygwin.com>; Wed,  8 Jul 2026 17:04:21 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 60E344BA5439
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 60E344BA5439
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.226.42
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1783530263; cv=none;
	b=DjDTf1uUdEjV2aa99eJwULOZFDuTWmaGYceMfG5btpa/uLqEJUEBOlfigD0dFES3hUQjRklsZUD+kVStlH4vSCrXUbDtacHU5/oiBnDpFN1iaYUZ+m8hKxz4B4rA/7BlKmhCkZViJi6447jWoVf4ChVylunQse9oyKu75yP2n/M=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1783530263; c=relaxed/simple;
	bh=Nm8Y2GKIrs1kjysWaRwziOklk/VEJgF+Bfyk+LN/JoU=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=mdL5aKK0gsjwyqJoQgxMdzObNNTGiyEalxG2nHFuw8dFPnZZZdivnmTOc5C/ZGkIdEuOT372lfxTk7Mn3TETRCQahr4ANKh43fjK1XWaR3piNME+Jpe6PMhaJSezvuE4TFQBdOj3tOu0idsf5stqXLMihOpJoEa98r5vn0ZyIhk=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=q2O4OOK4
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 60E344BA5439
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=q2O4OOK4
Received: from HP-Z230 by mta-snd-e10.mail.nifty.com with ESMTP
          id <20260708170417426.ZSPD.3198.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Thu, 9 Jul 2026 02:04:17 +0900
Date: Thu, 9 Jul 2026 02:04:16 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3] Cygwin: console: Correct previous NOFLSH fix
Message-Id: <20260709020416.d1bb5e52622ac5336ab98b6f@nifty.ne.jp>
In-Reply-To: <6ac18250-e205-89ff-3913-92c4f8f86606@gmx.de>
References: <20260708040323.905-1-takashi.yano@nifty.ne.jp>
	<6ac18250-e205-89ff-3913-92c4f8f86606@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1783530257;
 bh=1s/MvcF0zltQduppbwv8eUHHiJ1C+icu7AzcQBVromE=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=q2O4OOK4KLoLsJ0TXo1UWaFT+R2/8nUikCSAHLrFaainhaC5biPDYnYe2S17GpyYBUxCZU2L
 R7mwmJ6a429IG4EL/6QLj4FZNckGfp0HYsdNTt9QK9BBHW5LQRDBv/bgRgH/KAQYm5fD5eDsq/
 MTM3Hx138iSiz27galAC0Sqa+5eKcyJKaEGWBoSAmd07//VQGmsN7WN4uePEZrDUUYyKOwkzax
 lzn9A2gurzyit5aTDad3QQnPOUI4dOmNrko5NJjOx0uD+sK1YF9pg8wYbBmVDxRL+69KSer2tf
 22M+F9RUNQ/MJrTgYtF1rRpdrbxZ9oQiU0CXZraYAA49aw3w==
X-Spam-Status: No, score=-12.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Johannes,

On Wed, 8 Jul 2026 16:58:57 +0200 (CEST)
Johannes Schindelin wrote:
> Hi Takashi,
> 
> Thank you for v3. Both concerns from v2 are addressed, and the "stty intr
> ^x; cat | non-cygwin-app" case now behaves as expected.
> 
> I have two non-blocking observations further below, and a question: Out of
> curiosity, not a blocker: how does the `with_debugger_nat` branch actually
> get reached in practice? gdb normally reads the console only at its own
> prompt, i.e. when the inferior is stopped and thus not foreground, so the
> pre-conditions do not obviously line up.

In console, this never happen. In pty, process_sigs() is called from
pty master, so this is reached when non-cygwin inferior is foreground
in gdb.

>   Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

Thanks!

> > diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
> > index 730bb0b45..cc4591c14 100644
> > --- a/winsup/cygwin/fhandler/console.cc
> > +++ b/winsup/cygwin/fhandler/console.cc
> > @@ -1718,6 +1718,7 @@ fhandler_console::process_input_message (size_t len)
> >  	  continue;
> >  	}
> >  
> > +      num_input_events_processed = i + 1;
> 
> The new counter member is missing from the constructor's init list. It is
> safe in practice because `cnew()` zero-fills, but adding it explicitly
> would match the surrounding style.

Initializer added to constructor.

> > @@ -525,11 +532,12 @@ fhandler_termios::line_edit (const char *rptr, size_t nread, termios& ti,
> >        switch (process_sigs (c, get_ttyp (), this))
> >  	{
> >  	case signalled:
> > -	case not_signalled_but_done:
> >  	case done_with_debugger:
> >  	  sawsig = true;
> >  	  get_ttyp ()->output_stopped &= ~BY_VSTOP;
> >  	  continue;
> > +	case not_signalled_but_done:
> > +	  break;
> 
> Dropping `not_signalled_but_done` from the shared switch case also drops
> the clearing of `BY_VSTOP` on this path. Probably fine, since no cygwin
> signal is delivered here, but a sentence in the commit message would save
> future git-blame archaeology.

Your expectation is correct. I'll add the explanation to the commit message.
In addition, the naming of return value 'not_signalled_but_done' means
not_signalled && the processing for the key has been done. However, with
this patch, the processing for the key is continued in the code below.

So, I'd change here a bit:
@@ -525,10 +532,11 @@ fhandler_termios::line_edit (const char *rptr, size_t nrea
d, termios& ti,
       switch (process_sigs (c, get_ttyp (), this))
        {
        case signalled:
-       case not_signalled_but_done:
        case done_with_debugger:
          sawsig = true;
          get_ttyp ()->output_stopped &= ~BY_VSTOP;
+         fallthrough;
+       case not_signalled_but_done:
          continue;
        case not_signalled_with_nat_reader:
          disable_eof_key = true;

and also change here:
@@ -466,7 +473,7 @@ not_a_sig:
          fh->discard_input ();
        }
       ti.c_lflag &= ~FLUSHO;
-      return not_signalled_but_done;
+      return need_send_sig ? not_signalled : not_signalled_but_done;
     }
   bool to_nat = !cyg_reader && pg_with_nat;
   return to_nat ? not_signalled_with_nat_reader : not_signalled;

I think this is more appropriate.

With the minor fixes above, I'd push this patch to master and
cygwin-3_6-branch.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
