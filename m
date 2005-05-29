Return-Path: <cygwin-patches-return-5488-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25014 invoked by alias); 29 May 2005 10:07:11 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24629 invoked by uid 22791); 29 May 2005 10:07:02 -0000
Received: from p54940011.dip0.t-ipconnect.de (HELO calimero.vinschen.de) (84.148.0.17)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Sun, 29 May 2005 10:07:02 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 1ED74544122; Sun, 29 May 2005 12:07:00 +0200 (CEST)
Date: Sun, 29 May 2005 10:07:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: question on limits.h
Message-ID: <20050529100700.GA930@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <loom.20050527T160835-619@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <loom.20050527T160835-619@post.gmane.org>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2005-q2/txt/msg00084.txt.bz2

On May 27 14:15, Eric Blake wrote:
> My reading of POSIX says that LLONG_MIN and friends must always be defined, and 
> not just when the version of C is new enough: 
> http://www.opengroup.org/onlinepubs/009695399/basedefs/limits.h.html
> At any rate, I was surprised when I noticed that coreutils was redefining 
> ULLONG_MAX because it couldn't find it in limits.h.

Yup, your observation looks correct to me...

> 
> 2005-05-27  Eric Blake  <ebb9@byu.net>
> 
> 	(LLONG_MIN, LLONG_MAX, ULLONG_MAX): Always define.

...in contrast to your ChangeLog entry.  Applied, though.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
