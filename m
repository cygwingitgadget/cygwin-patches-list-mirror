Return-Path: <cygwin-patches-return-5654-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4108 invoked by alias); 21 Sep 2005 13:35:29 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4062 invoked by uid 22791); 21 Sep 2005 13:35:19 -0000
Received: from c-24-61-23-223.hsd1.ma.comcast.net (HELO cgf.cx) (24.61.23.223)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Wed, 21 Sep 2005 13:35:19 +0000
Received: by cgf.cx (Postfix, from userid 201)
	id B6F6E3B0001; Wed, 21 Sep 2005 13:35:17 +0000 (UTC)
Date: Wed, 21 Sep 2005 13:35:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: PING: fix ARG_MAX
Message-ID: <20050921133517.GE16939@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <loom.20050906T172937-420@post.gmane.org> <loom.20050910T164247-175@post.gmane.org> <20050912152245.GB29379@calimero.vinschen.de> <43265113.3000207@byu.net> <20050919143101.GA16760@trixie.casa.cgf.cx> <433003E8.90701@byu.net> <20050920160542.GA6720@trixie.casa.cgf.cx> <43315F17.9050702@byu.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43315F17.9050702@byu.net>
User-Agent: Mutt/1.5.8i
X-SW-Source: 2005-q3/txt/msg00109.txt.bz2

On Wed, Sep 21, 2005 at 07:24:39AM -0600, Eric Blake wrote:
>According to Christopher Faylor on 9/20/2005 10:05 AM:
>>AFAICT, we're not talking about defaults.  We're talking about the
>>optimum setting.
>>
>>Your change to xargs doesn't permit me to go beyond 32K.  Personally,
>>I'd like to be able to override that.
>
>So would I.  See below.
>
>>I have a similar test which shows noticeable improvement when going
>>from 32K to 64K and miniscule-but-still-there improvements after that:
>
>Was this benchmark run on a modified xargs, or did you still suffer
>from the 32k limit?

It was a modified xargs and a modified cygwin to allow command line
lengths > 1M.  I would think that the fact that you see noticeable
timing differences between 32768 -> 262144 would make that pretty clear
that xargs was actually using these.

An unmodified xargs would have given errors if I attempted to use a
larger limit - hence my request to be allowed to use larger sizes.

cgf
