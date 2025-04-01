Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id B0F18384147D; Tue,  1 Apr 2025 08:12:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B0F18384147D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1743495175;
	bh=20cX9xL69glYLdULz8u35QbaUtgxwwpZTqBsRqTklUQ=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=bLcSYr20GPVlfKe4k6vvzlY65MRN3YuBmPKsAyIRrq6ioFT/N8L7sHI4AP7Q41gAJ
	 C2KSFvrzzgmxy+i0qwnWXw7r7VmNa8FLvuijlA0qHxsBi15KFSxexoumMBsJcB//xv
	 5gm3lDP02izj42nvfSwOEBlKYqKr6gMV0/bxIkbU=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 34082A80C9C; Tue, 01 Apr 2025 10:12:53 +0200 (CEST)
Date: Tue, 1 Apr 2025 10:12:53 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v4 0/5] find_fast_cwd_pointer rewrite
Message-ID: <Z-ugBR-lzNL7WxHT@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <56da8997-5d48-dfb7-8a41-b3fa6ccfbecc@jdrake.com>
 <bd7bc794-7a50-228f-4f9e-a34a02fd12f6@jdrake.com>
 <Z-pQB1d2It9jkuFS@calimero.vinschen.de>
 <Z-r0vQTnzdkrCIsq@calimero.vinschen.de>
 <ed148947-2ebb-6c44-6b90-acb018b85008@jdrake.com>
 <Z-sD0CGk4L-zuyzH@calimero.vinschen.de>
 <236d3480-bda4-08cc-9ef5-e83ff9f668d3@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <236d3480-bda4-08cc-9ef5-e83ff9f668d3@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

On Mar 31 15:48, Jeremy Drake via Cygwin-patches wrote:
> On Mon, 31 Mar 2025, Corinna Vinschen wrote:
> 
> > On Mar 31 13:58, Jeremy Drake via Cygwin-patches wrote:
> > > On Mon, 31 Mar 2025, Corinna Vinschen wrote:
> > >
> > > > Hi Jeremy,
> > > >
> > > > Thank you, I approved your request on sware.  You now have
> > > > write-after-approval permissions, so please continue to send patches to
> > > > cygwin-patches first and wait for approval from Takashi, Jon or me.
> > >
> > > I tried to push this patchset but I'm getting Permission denied
> > > (publickey) from ssh.  I assume this is still waiting on overseers.
> > > Should I expect an email from them when things are ready?
> >
> > Usually you should get a mail from overseers.  I CCed them, just to
> > be sure.
> 
> Got the mail, patch series pushed.

:+1:

> I guess I need to start worrying about
> getting the "committer" identity right for which project I'm pusing to now
> too ;)

I'm usually only split between my private and my company identity :)


Corinna
