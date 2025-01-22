Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id CEECD3857C68; Wed, 22 Jan 2025 10:11:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org CEECD3857C68
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1737540672;
	bh=K6mvJAIo+5WF3wjLiix9R9oP/ti/Z+UbhUYuHY3hEgA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=dJlGB/HcixFXdyqHG9ifCz4mc8e7cusyIfeskulncqMNprywGgkynuNGBqyzHLh0l
	 zeGsacUqLvZVQQuIlgI+mX/0EXeXbrRXmOdhXsjWVPuH4mzo9R449Ny0V01SA509al
	 yPYciAwvsXqf0yqX12Oy4Flk8/PtKZHAfYfoFIWQ=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 0A782A80D1D; Wed, 22 Jan 2025 11:11:11 +0100 (CET)
Date: Wed, 22 Jan 2025 11:11:10 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: signal: Avoid frequent TLS lock/unlock for
 SIGCONT processing
Message-ID: <Z5DEPin8vKxEOAeY@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Takashi Yano <takashi.yano@nifty.ne.jp>,
	cygwin-patches@cygwin.com
References: <20250120142316.3606760-1-takashi.yano@nifty.ne.jp>
 <9223d8f6-bc85-a2cb-d1d3-9517041f0034@jdrake.com>
 <20250122075820.47f0b776c0fdfd63437cef09@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250122075820.47f0b776c0fdfd63437cef09@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Jan 22 07:58, Takashi Yano wrote:
> On Tue, 21 Jan 2025 13:20:46 -0800 (PST)
> Jeremy Drake wrote:
> > dscho hooked me up with a workflow to run Git for Windows' test suite on
> > an msys2-runtime pull request's CI artifacts. With this patch and the
> > three you pushed (reverting the v2 patch we had applied already, and
> > applying the two from the cygwin-3_5-branch), the test suite no longer
> > hangs.
> 
> Thanks for testing! I'm happy to hear that.

Me too.  Please push.

Thanks,
Corinna
