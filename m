Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 919DE385AC35; Mon, 31 Mar 2025 21:06:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 919DE385AC35
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1743455186;
	bh=RQSnD4yAeffxL9z6yulAq8cgl0AKDlmfbQv06//mswk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fqqgt/2bzjZ0qDnx6NuziUVwWyg5J4nCTGD4jWCGiwB7Ga04pCFt54IvLOMEb60JV
	 neDup+0syBl9aOGjgHdxeZqAAnRTu0abOvm1Pw0FhxgdzY+MznHogWHAlp81Wjlrv2
	 Uo6Wg7ujYcAGkwt5NVwxvl5s9oLWiyVqYarLbCSE=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 402E6A80CA2; Mon, 31 Mar 2025 23:06:24 +0200 (CEST)
Date: Mon, 31 Mar 2025 23:06:24 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Cc: overseers@sourceware.org
Subject: Re: [PATCH v4 0/5] find_fast_cwd_pointer rewrite
Message-ID: <Z-sD0CGk4L-zuyzH@calimero.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com, overseers@sourceware.org
References: <56da8997-5d48-dfb7-8a41-b3fa6ccfbecc@jdrake.com>
 <bd7bc794-7a50-228f-4f9e-a34a02fd12f6@jdrake.com>
 <Z-pQB1d2It9jkuFS@calimero.vinschen.de>
 <Z-r0vQTnzdkrCIsq@calimero.vinschen.de>
 <ed148947-2ebb-6c44-6b90-acb018b85008@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ed148947-2ebb-6c44-6b90-acb018b85008@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

On Mar 31 13:58, Jeremy Drake via Cygwin-patches wrote:
> On Mon, 31 Mar 2025, Corinna Vinschen wrote:
> 
> > Hi Jeremy,
> >
> > Thank you, I approved your request on sware.  You now have
> > write-after-approval permissions, so please continue to send patches to
> > cygwin-patches first and wait for approval from Takashi, Jon or me.
> 
> I tried to push this patchset but I'm getting Permission denied
> (publickey) from ssh.  I assume this is still waiting on overseers.
> Should I expect an email from them when things are ready?

Usually you should get a mail from overseers.  I CCed them, just to
be sure.


Corinna
