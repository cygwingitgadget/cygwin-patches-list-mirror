Return-Path: <SRS0=R8AU=6X=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e08.mail.nifty.com (mta-snd-e08.mail.nifty.com [106.153.226.40])
	by sourceware.org (Postfix) with ESMTPS id C1A414BA2E07
	for <cygwin-patches@cygwin.com>; Wed, 17 Dec 2025 09:21:50 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C1A414BA2E07
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C1A414BA2E07
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.40
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1765963311; cv=none;
	b=fWPQ7OK1latyq1YxGV6ezalQdAdTn5xxRnukb+v83Dxgq4wx+/ncLGfliwgn6jSSLK7kU052N+fmdcHETmdkM72ljWJojXQYt1JNujKEnPqZQ4ucGqDc9FM/4N4TA94kxuR7eVmu/sjtWx+K1gqvsrDmvgOpQFhQSaVVE7jhkSQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1765963311; c=relaxed/simple;
	bh=ODafOjLVnA+JXbbXiweNzEtox+ws4tWvJxlLbTk6PG8=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=qlJcZX6V7iWWQZKQpHJ7Nc0JNviNyawP+cEnqObaU8D16jxWLD8+4hmU1oL6QDNSMlNVqDAEf0wKMKtwKgV1S3fBAugvJ3TRG2vA8MmOzlqjpdcyOL+vRjXFA8RaDABEblXr+4VyfoUThVlqvcvEQfXhGfDn/DnW4KNNfzupH9k=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C1A414BA2E07
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=aY0dlLjM
Received: from HP-Z230 by mta-snd-e08.mail.nifty.com with ESMTP
          id <20251217092148800.QBIF.23755.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Wed, 17 Dec 2025 18:21:48 +0900
Date: Wed, 17 Dec 2025 18:21:47 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: termios: Follow symlink in is_console_app()
Message-Id: <20251217182147.9ee48865367a801097785c24@nifty.ne.jp>
In-Reply-To: <ebc2c64d-55c4-98f5-573f-bebadf3e3979@gmx.de>
References: <20251216083945.235-1-takashi.yano@nifty.ne.jp>
	<ebc2c64d-55c4-98f5-573f-bebadf3e3979@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1765963308;
 bh=NWa2efXg8YYRmLzcl4JpmRXJFQTefShGNpSGphBkmUY=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=aY0dlLjMVvenYkR3LFW1sY6ezIiwBJktuGsNichRf6PoJUboIkzjYG8OQWQ5Zi5wKdvTomOW
 m8Evrd+vQ5bywc79Cp3XCLb/FlIk2QnKyYHMLudJALleA1dR1o2+Wf9MA3iCjsvh3Gm2T2vGnh
 bxAWWiJJb4j1fk2VWruxZmLNjhirhY8br3E8pCtaSPajkZwb5U3RI+kXXMEJIbEXgCTmxPscwH
 ZtiK7BIupuezhsH+eEQriJfnIQy7ikjVrONvD+5Xcr+1Pyas7NJHWhy2169jdLQrg3CYu8tqd7
 B/yAqhiPYFK6g6zI9V9tVsYgpp7UurmUrt6yL1M0RrU7qhrQ==
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Tue, 16 Dec 2025 10:17:08 +0100 (CET)
Johannes Schindelin rote:
> Hi Takashi,
> 
> On Tue, 16 Dec 2025, Takashi Yano wrote:
> 
> > After the commit f74dc93c6359, WSL cannot start by distribution name
> > such as debian.exe, which has '.exe' extention but actually is a symlink.
> > This is because is_console_app () returns false for that symlink due
> > to open-failure. This patch fixes the issue using PC_SYM_FOLLOW option
> > in path_conv.
> 
> The commit message still does not clarify that this has pretty nothing to
> do with symlinks, but everything with app execution aliases.

OK. I'll revise the commit message.

> In fact, the commit message still misleads the reader to think that
> executing each any every symlink is broken, which could easily lead to a
> lot of time wasted wondering why this bug hasn't been detected for a very,
> very long time. Let's avoid being this inconsiderate of reviewers' time.

In fact, it's not 'very very long time', i.e. since Mar 2025. Before the
commit f74dc93c6359, spawn resolve the app execution alias as a symlink
and is_console_app() was working well.

> Speaking of reviewers' time: I implore you to rethink the practice of
> tossing a v2 over the fence without saying what was wrong with v1 and how
> v2 addresses that. If you truly care for the craft of software
> engineering, you will realize that explaining your thought process is a
> vital part of any contribution, and that is was I am missing here.
> 
> > Fixes: f74dc93c6359 ("fix native symlink spawn passing wrong arg0")
> 
> Hmm. Since this patch likely fixes the problem reported in
> https://inbox.sourceware.org/cygwin/CAAM_cieBo_M76sqZMGgF+tXxswvT=jUHL_pShff+aRv9P1Eiug@mail.gmail.com
> (and even **implicitly** talks about app execution aliases, because that's
> what `debian.exe` resolves to), I am unsure that this footer refers to
> **the** most related commit.

I think this is **the** most related commit. Before this commit,
spawn could follow the symlink with PC_SYM_FOLLOW flag even for
app execution aliases. The commit f74dc93c6359 added PC_SYM_NOFOLLOW_REP
to the flags, as a result, windows reparse point have been not resoved.

> > Reviewed-by:
> 
> An empty footer? Was that an oversight or intentional?

Intentional. I'll fill this after someone's review.

> > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > ---
> >  winsup/cygwin/fhandler/termios.cc       | 19 ++++++++++++++-----
> >  winsup/cygwin/local_includes/fhandler.h |  2 +-
> >  winsup/cygwin/spawn.cc                  |  2 +-
> >  3 files changed, 16 insertions(+), 7 deletions(-)
> > 
> > diff --git a/winsup/cygwin/fhandler/termios.cc b/winsup/cygwin/fhandler/termios.cc
> > index 19d6220bc..ff6c06015 100644
> > --- a/winsup/cygwin/fhandler/termios.cc
> > +++ b/winsup/cygwin/fhandler/termios.cc
> > @@ -702,10 +702,19 @@ fhandler_termios::fstat (struct stat *buf)
> >  }
> >  
> >  static bool
> > -is_console_app (const WCHAR *filename)
> > +is_console_app (path_conv *pc)
> 
> For the sake of readers who aren't familiar with your v1: This is probably
> the most interesting change between v1 and v2 of this patch.
> 
> Since `NULL` would not make sense in this function, I would deem
> `path_conv &pc` more appropriate.

Good point.

> However, it is said that there are two categories of patches in which no
> obvious bugs reside: those patches that are so clear and elegant that
> there simply cannot be any obvious bug, and those so convoluted or so
> overarching that there are at least no _obvious_ bugs.
> 
> The structure of this patch looks very little like the former, desirable
> category to me. This is worrisome given the extended history of this part
> of Cygwin's source code that has seen way more bugs and regressions than
> I'd like to unleash on my users. Yet it would be so easy to gain more
> confidence in this patch, simply by extracting out the signature change
> (and making it a proper reference instead of a pointer)!


> 
> >  {
> > +  const WCHAR *native_path = pc->get_nt_native_path ()->Buffer;
> > +  if (pc->issymlink ())
> 
> That's probably a bit too overarching. Have you tried whether this patch
> is required to execute programs via regular symbolic links instead of app
> execution aliases?

Normal cygwin symlink has been followed by PC_SYM_FLLOW flag in spawn.cc,
and only windows reparse point is not resoved due to PC_SYM_NOFOLLOW_REP.

However, as you concern, normal Windows symlink can be opened by CreateFile()
without extra path_conv.

I'll add new api path_conv::is_app_execution_alias() in v3 patch.

> > +    {
> > +      UNICODE_STRING upath;
> > +      RtlInitUnicodeString (&upath, native_path);
> > +      path_conv target (&upath, PC_SYM_FOLLOW);
> > +      native_path = target.get_nt_native_path ()->Buffer;
> > +    }
> > +
> >    HANDLE h;
> > -  h = CreateFileW (filename, GENERIC_READ, FILE_SHARE_READ,
> > +  h = CreateFileW (native_path, GENERIC_READ, FILE_SHARE_READ,
> 
> How certain can we be that the `Buffer` of that now out-of-scope `target`
> is still valid at this point? This code pattern is highly indicative of a
> use-after-free problem (if not in the present, then quite likely in the
> future).

Oops! You are right.

> >  		   NULL, OPEN_EXISTING, 0, NULL);
> >    char buf[1024];
> >    DWORD n;
> > @@ -716,7 +725,7 @@ is_console_app (const WCHAR *filename)
> >    IMAGE_NT_HEADERS32 *p = (IMAGE_NT_HEADERS32 *) memmem (buf, n, "PE\0\0", 4);
> >    if (p && (char *) &p->OptionalHeader.DllCharacteristics <= buf + n)
> >      return p->OptionalHeader.Subsystem == IMAGE_SUBSYSTEM_WINDOWS_CUI;
> > -  wchar_t *e = wcsrchr (filename, L'.');
> > +  wchar_t *e = wcsrchr (native_path, L'.');
> >    if (e && (wcscasecmp (e, L".bat") == 0 || wcscasecmp (e, L".cmd") == 0))
> >      return true;
> 
> In my patch series (which tries to target very specifically the problem of
> app execution aliases _without_ risking to cause any regression in only
> vaguely-related scenarios such as canonical symlinks), I move this check
> up so that the comparatively expensive read operation can be avoided if we
> already know that the file extension indicates a console application.
> 
> You can find my v2 (with change log since v1 and range-diff...) here:
> https://inbox.sourceware.org/cygwin-patches/pull.5.v2.cygwin.1765818395.gitgitgadget@gmail.com/
> 
> I understand that it is technically "more correct" to resolve any symlink
> and then look at the target file name instead of looking at `filename`
> always. In practice, I highly doubt that any app execution alias exists
> that has a different file extension than its target.
> 
> It would probably make more sense to collaborate and try to combine the
> best of your patch with the best of my patch series. For example, I could
> easily integrate a patch into my series that changes the signature of
> `is_console_app()` to take a `path_conv &` instead of a `WCHAR *`.

I'd be happy if you could merge my v3 patch into your patch series.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
