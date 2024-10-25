Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 159A83858C2B; Fri, 25 Oct 2024 08:49:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 159A83858C2B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1729846194;
	bh=tQYS4E4p2s7bmZpWv4GJn2HApCw4OOvP5PdHTiiw9uc=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=rDxvEuomLPlnRNUF/qvklit1jmM5a/d9rfu+/gv5wATlq1xYWBKBF28UUpa+HSVn4
	 e6RCBggQUlUR4xY6l0OtF8cCEGLGJlHAveKszjT889G7aZYzK5ATcvDp2AWH2Mn7Ze
	 6qSfiy8HT7zZ8KrYVpjzedYNYq/Zq0rmp6a4BiHM=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id AF346A8094B; Fri, 25 Oct 2024 10:49:51 +0200 (CEST)
Date: Fri, 25 Oct 2024 10:49:51 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3] Cygwin: sigfe: Fix a bug that signal handler destroys
 fpu states
Message-ID: <Zxtbry_Qb70ouRw-@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20241014063914.6061-1-takashi.yano@nifty.ne.jp>
 <ZxfLig9716RXtWLu@calimero.vinschen.de>
 <20241024175802.a7d18a8e604ff2d18221cfcb@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241024175802.a7d18a8e604ff2d18221cfcb@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Oct 24 17:58, Takashi Yano wrote:
> On Tue, 22 Oct 2024 17:58:02 +0200
> Corinna Vinschen <corinna-cygwin@cygwin.com> wrote:
> > Hi Takashi,
> > 
> > big change, so, honest question: Do you think this is safe for 3.5.5?
> > 
> > This certainly also requires an entry in the release text and there
> > are just a few minor typos in comments, see below.
> 
> What about adopting my first idea to 3.5.5
> https://cygwin.com/pipermail/cygwin/2024-October/256506.html
> and applying this patch to 3.6.0 branch?

Admittedly, I'm also not deep in FPU stuff.

fnstenv/fldenv and dropping fninit look like a simple approach to fix
the worst problem.  Did you just discuss this on the mailing list or did
you check that it actually fixes the reported problem?

But either way, I wonder if it's worth the effort to have two different
solutions.  This isn't a regression, so we don't have to fix this ASAP
in 3.5.5.  It could easily wait a version.

So I'm thinking we should go with your sleek new code in 3.6 and let
this simmer for a while, so it's put to use by people running 3.6
versions.

Does that sound right?


Corinna
