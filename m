Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 1F2253857C45; Mon, 21 Aug 2023 09:03:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 1F2253857C45
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1692608609;
	bh=GUop8i9eTvQVP7drUYm7xjnCE14gTgvwVxQXjAJanE8=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=kafJTGVpYUJKijSMpwm/Rf+79uj7eDzhGeqenQxYd2RZCPIZpMSsj29e6I3ksXxDe
	 eAmTeSUU3jX8ywn8CnzdjR2RHo4c+AC/ylsTI/gc1bui4W7fISJZe8nd9A3mcT1Mwk
	 KQsYSIOnTLCu/ny5ZOj5lPGh+4bkGQSnzdtBWLN4=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id C8642A80BD1; Mon, 21 Aug 2023 11:03:25 +0200 (CEST)
Date: Mon, 21 Aug 2023 11:03:25 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Fix failure to clear switch_to_nat_pipe
 flag.
Message-ID: <ZOMoXUCvbhmGmWtN@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20230819060739.898-1-takashi.yano@nifty.ne.jp>
 <ZOMeTorrvdScqcZ2@calimero.vinschen.de>
 <20230821175325.30ceb6a94f0ecc4157e3f1ba@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230821175325.30ceb6a94f0ecc4157e3f1ba@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Aug 21 17:53, Takashi Yano wrote:
> Hi Corinna,
> 
> On Mon, 21 Aug 2023 10:20:30 +0200
> Corinna Vinschen wrote:
> > Hi Takashi,
> > 
> > On Aug 19 15:07, Takashi Yano wrote:
> > > After the commit fbfea31dd9b9, switch_to_nat_pipe is not cleared
> > > properly when non-cygwin app is terminated in the case where the
> > > pseudo console is disabled. This is because get_winpid_to_hand_over()
> > > sometimes returns PID of cygwin process even though it should return
> > > only PID of non-cygwin process. This patch fixes the issue by adding
> > > a new argument which requests only PID of non-cygwin process to
> > > get_console_process_id().
> > 
> > How critical is that? Do we need a 3.4.9 asap, or can we wait and
> > collect a few more bugfixes first?
> 
> This problem is affected only when pseudo console is not
> activated. So, most of Win10 users do not have this issue.
> However, Win7/8 users may notice some small gritch after
> non-cygwin app is executed.
> 
> BTW, are you noticed that dumper.exe is missing in 3.4.8?

No, I didn't, thanks for notifying me.

> When you release new cygwin to fix that, I would be happy
> if above patch will applied as well.

Yeah, it will certainly be a 3.4.9 soon :}


Corinna
