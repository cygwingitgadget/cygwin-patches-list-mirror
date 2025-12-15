Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id C02234BA2E21; Mon, 15 Dec 2025 16:05:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C02234BA2E21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1765814723;
	bh=QDF0xfsdjUgwv2xIw/MbBmoY4zEzvuNEdv7FUk5rJls=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=Ia+W2OtNVTquHmIIWsH3+a0v1NDYt5waJ1JMtY7SUbjLZlWO9Ra3MeDmjgN26Cp7F
	 jnOiEDlFqZBvWJOMd43bxRE8OOCFEsr5MMS4m7wlFC24vQP5cRt3CyhoM4cld+nIOs
	 uiFcS8vM5UeRPECFt/qh/2f+oZ25LusDrtvqAwKU=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id E70AFA80BA1; Mon, 15 Dec 2025 17:05:21 +0100 (CET)
Date: Mon, 15 Dec 2025 17:05:21 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 3/3] Cygwin: is_console_app(): handle app execution
 aliases
Message-ID: <aUAxwTZcfZ9qecW2@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <pull.5.cygwin.1765809440.gitgitgadget@gmail.com>
 <6ae42c5d17102a7805ed6539b9548df437df88a1.1765809440.git.gitgitgadget@gmail.com>
 <aUAoxVEKMpj6xNjM@calimero.vinschen.de>
 <18909F97-1145-4F61-9E23-4E4B9C97CF2E@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <18909F97-1145-4F61-9E23-4E4B9C97CF2E@gmx.de>
List-Id: <cygwin-patches.cygwin.com>

On Dec 15 16:40, Johannes Schindelin wrote:
> Hey Corinna,
> 
> [Sorry for top-posting]

/*rolling eyes*/

> I take it you mean
> <https://cygwin.com/pipermail/cygwin-patches/2025q4/014403.html>?

/*rolling eyes again, multiple times*/

Yes, of course, sorry.

> Then
> yes, it looks as if we're trying to fix the same issue, even if I have
> to admit that I wouldn't have begun to have guessed that from the
> commit message in that mail that the bug is about app execution
> aliases (regular symbolic links don't have a problem, I don't think,
> and therefore the message might be considered misleading to a certain
> extent). For that reason, I _much_ prefer the more verbose description
> of the problem that I offered in the email you quoted.
> 
> Also, it looks as if that other proposed patch will always add
> overhead, not only when the reparse point needs to be handled in a
> special way. Given that this code path imposes already quite a bit of
> overhead, overhead that delays execution noticeably and makes
> debugging less delightful than I'd like, I would much prefer to do it
> in the way that I proposed, where the extra time penalty is imposed
> _only_ in case the special handling is actually needed.

You may want to discuss this with Takashi.  Simplicity vs. Speed ;)

But, if we take your patch, I'd suggest adding a source code comment
why the extra call to CreateFileW is necessary.  It's not obvious when
scanning the code.

And I just noticed another small hiccup...

> -------- Original Message --------
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> > 
> > In 0a9ee3ea23 (Allow executing Windows Store's "app execution aliases",

$ git show 0a9ee3ea23
fatal: ambiguous argument '0a9ee3ea23': unknown revision or path not in the working tree.
Use '--' to separate paths from revisions, like this:
'git <command> [<revision>...] -- [<file>...]'

Oops?


Thanks,
Corinna
