Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 1016B3840C10; Tue,  1 Apr 2025 08:55:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 1016B3840C10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1743497708;
	bh=j9ONYldoudcm3dqun2dCZEV9O7bAKmQBHVlSCYbnk+8=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=K9XoMxG3AXCtc2r4mlpHzJLUqQOE3QCr83iUNU5ONry5SBcgl5CgOelTJhsxY2G43
	 gGWFUFiaotZ4A3ixpaaqngUbI0xG2s3UBBMcqovBnjfv4qCNOeyECoOSZnsBoILBKX
	 YRDJsrZFl4sXb7fd8fqbnBj3mpHA8v0YaPHEkzX4=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id E8403A80C9C; Tue, 01 Apr 2025 10:55:05 +0200 (CEST)
Date: Tue, 1 Apr 2025 10:55:05 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v4 0/5] find_fast_cwd_pointer rewrite
Message-ID: <Z-up6Q9eFQ6ir35Z@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <56da8997-5d48-dfb7-8a41-b3fa6ccfbecc@jdrake.com>
 <bd7bc794-7a50-228f-4f9e-a34a02fd12f6@jdrake.com>
 <Z-pQB1d2It9jkuFS@calimero.vinschen.de>
 <Z-r0vQTnzdkrCIsq@calimero.vinschen.de>
 <ed148947-2ebb-6c44-6b90-acb018b85008@jdrake.com>
 <Z-sD0CGk4L-zuyzH@calimero.vinschen.de>
 <236d3480-bda4-08cc-9ef5-e83ff9f668d3@jdrake.com>
 <Z-ugBR-lzNL7WxHT@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z-ugBR-lzNL7WxHT@calimero.vinschen.de>
List-Id: <cygwin-patches.cygwin.com>

On Apr  1 10:12, Corinna Vinschen wrote:
> On Mar 31 15:48, Jeremy Drake via Cygwin-patches wrote:
> > On Mon, 31 Mar 2025, Corinna Vinschen wrote:
> > 
> > > On Mar 31 13:58, Jeremy Drake via Cygwin-patches wrote:
> > > > On Mon, 31 Mar 2025, Corinna Vinschen wrote:
> > > >
> > > > > Hi Jeremy,
> > > > >
> > > > > Thank you, I approved your request on sware.  You now have
> > > > > write-after-approval permissions, so please continue to send patches to
> > > > > cygwin-patches first and wait for approval from Takashi, Jon or me.
> > > >
> > > > I tried to push this patchset but I'm getting Permission denied
> > > > (publickey) from ssh.  I assume this is still waiting on overseers.
> > > > Should I expect an email from them when things are ready?
> > >
> > > Usually you should get a mail from overseers.  I CCed them, just to
> > > be sure.
> > 
> > Got the mail, patch series pushed.
> 
> :+1:

Oh, Jeremy, here's a question.  We only add udis86 to the main branch.
What about the 3.6 branch, does it still need a patch to accommodate
the fast_cwd magic for a newer, upcoming Windows version?

And btw., I checked the file size again, and it turns out that after
stripping the debug symbols the DLL takes ~30 pages or 120 K more memory
than before udis86.  I hope that's ok.  But if you see ways to shave a
few pages off by dropping code from udis86, I wouldn't be too unhappy :}


Thanks,
Corinna
