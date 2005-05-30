Return-Path: <cygwin-patches-return-5490-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30836 invoked by alias); 30 May 2005 15:11:50 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30778 invoked by uid 22791); 30 May 2005 15:11:43 -0000
Received: from p5494192b.dip0.t-ipconnect.de (HELO calimero.vinschen.de) (84.148.25.43)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Mon, 30 May 2005 15:11:43 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 11B1A544123; Mon, 30 May 2005 12:53:13 +0200 (CEST)
Date: Mon, 30 May 2005 15:11:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Probably unnecessary InterlockedCompareExchangePointer in List_remove in thread.h
Message-ID: <20050530105312.GA9933@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20050529165435.H81503@logout.sh.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050529165435.H81503@logout.sh.cvut.cz>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2005-q2/txt/msg00086.txt.bz2

On May 29 17:03, Vaclav Haisman wrote:
> 
> I think that the call to InterlockedCompareExchangePointer() can and should be
> replaced by ordinary if and assignment. The synchronization it provides doesn't
> seem to be necessary.

Are you sure the synchronization isn't necessary?  You just say you think
it isn't, but there's not much of a proof.  In any case, the call to
InterlockedCompareExchangePointer is looking quite expensive, but it isn't.
Did you notive there's a local file called winbase.h in the cygwin directory?
If you have a look, you'll see that InterlockedCompareExchangePointer
boils down to exactly one assembler instruction, so it doesn't seem to
be worth the effort, does it?


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
