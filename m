Return-Path: <cygwin-patches-return-5647-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25671 invoked by alias); 12 Sep 2005 15:22:55 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 25629 invoked by uid 22791); 12 Sep 2005 15:22:49 -0000
Received: from mail-n.franken.de (HELO ilsa.franken.de) (193.175.24.27)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Mon, 12 Sep 2005 15:22:49 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])
	by ilsa.franken.de (Postfix) with ESMTP id 77474245C4
	for <cygwin-patches@cygwin.com>; Mon, 12 Sep 2005 17:22:46 +0200 (CEST)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])
	by aqua.hirmke.de (Postfix) with ESMTP id A91A3D6503
	for <cygwin-patches@cygwin.com>; Mon, 12 Sep 2005 17:22:45 +0200 (CEST)
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 74E4E544122; Mon, 12 Sep 2005 17:22:45 +0200 (CEST)
Date: Mon, 12 Sep 2005 15:22:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: PING: fix ARG_MAX
Message-ID: <20050912152245.GB29379@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <loom.20050906T172937-420@post.gmane.org> <loom.20050910T164247-175@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <loom.20050910T164247-175@post.gmane.org>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2005-q3/txt/msg00102.txt.bz2

Eric,

On Sep 10 14:55, Eric Blake wrote:
> Eric Blake <ebb9 <at> byu.net> writes:
> 
> Just making sure this patch didn't fall through the cracks...
> 
> > 
> > 2005-09-06  Eric Blake  <ebb9 <at> byu.net>
> > 
> > 	* include/limits.h (ARG_MAX): New limit.
> > 	* sysconf.cc (sysconf): _SC_ARG_MAX: Use it.
> 
> Even with your recent patches to make cygwin programs receive longer command
> lines, whether or not they are not mounted cygexec, ARG_MAX should still reflect
> the worst case limit so that programs (like xargs) that use ARG_MAX will work
> reliably even when invoking non-cygwin programs that are really bound by the 32k
> limit.

I had a short talk with Chris and we both agree that it doesn't make
overly sense to go down to the lowest limit just to accomodate
non-Cygwin applications.  Users of those apps can easily use xargs -s
so why penalize Cygwin apps?


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat, Inc.
