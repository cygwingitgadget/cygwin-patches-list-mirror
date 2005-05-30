Return-Path: <cygwin-patches-return-5492-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28604 invoked by alias); 30 May 2005 18:33:35 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 28593 invoked by uid 22791); 30 May 2005 18:33:32 -0000
Received: from c-66-30-17-189.hsd1.ma.comcast.net (HELO cgf.cx) (66.30.17.189)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Mon, 30 May 2005 18:33:32 +0000
Received: by cgf.cx (Postfix, from userid 201)
	id 8574813CA7E; Mon, 30 May 2005 14:33:30 -0400 (EDT)
Date: Mon, 30 May 2005 18:33:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Probably unnecessary InterlockedCompareExchangePointer in List_remove in thread.h
Message-ID: <20050530183330.GA15421@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20050529165435.H81503@logout.sh.cvut.cz> <20050530105312.GA9933@calimero.vinschen.de> <20050530193427.C19887@logout.sh.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050530193427.C19887@logout.sh.cvut.cz>
User-Agent: Mutt/1.5.8i
X-SW-Source: 2005-q2/txt/msg00088.txt.bz2

On Mon, May 30, 2005 at 08:00:52PM +0200, Vaclav Haisman wrote:
>I am not sure, that is why I wrote "probably". But from what I see there is
>already exclusive access guaranteed by the mx.lock() call, unless of course I
>am completely misunderstanding something.

I don't think you are.  I missed this too when I saw your patch and had
the same reaction that Corinna did.

I think this patch should be ok to apply.

>I can tell you that "lock; cmpxchg" pair of instruction is really not as cheap
>as it looks. Especially on SMP systems. It takes above 100 of cycles on
>contemporary CPUs.

Do you have a reference which states this?  100s of cycles sounds like an
incredible amount of overhead.

cgf
