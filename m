Return-Path: <cygwin-patches-return-5567-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11368 invoked by alias); 15 Jul 2005 18:30:30 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11354 invoked by uid 22791); 15 Jul 2005 18:30:28 -0000
Received: from c-24-61-23-223.hsd1.ma.comcast.net (HELO cgf.cx) (24.61.23.223)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Fri, 15 Jul 2005 18:30:28 +0000
Received: by cgf.cx (Postfix, from userid 201)
	id E611113C12A; Fri, 15 Jul 2005 14:30:12 -0400 (EDT)
Date: Fri, 15 Jul 2005 18:30:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: Changes to how-programming.texinfo
Message-ID: <20050715183012.GG13238@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1121451065.13490.13.camel@fulgurite>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1121451065.13490.13.camel@fulgurite>
User-Agent: Mutt/1.5.8i
X-SW-Source: 2005-q3/txt/msg00022.txt.bz2

On Fri, Jul 15, 2005 at 11:11:05AM -0700, Max Kaehn wrote:
>Because this patch includes details addressing the Cygwin license,
>I've included my conversation with Rebecca Ward (rward[at]redhat.com)
>verifying the propriety of language of the patch at the end of this
>message.

As nice as it is for the Red Hat "engineering team" to bless this,
AFAIK, there isn't anyone inside Red Hat who actually understands cygwin
other than Corinna.  And, I'll bet that she didn't look at it.

The wording that is currently on the web site was approved by Red
Hat's *legal* team and they should be the final authority on this.

IMO, if we need additional wording about licensing, it should reference
the web site.

The description of the --enable-debugging (no =yes required) describes
only a subset of what gets turned on when you use that option.  A grep
of the DEBUGGING symbol in the cygwin sources should unearth a lot more
uses than just this.

So, I don't think this patch is ready for prime time.  Sorry.

cgf
