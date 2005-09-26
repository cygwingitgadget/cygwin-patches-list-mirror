Return-Path: <cygwin-patches-return-5656-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31946 invoked by alias); 26 Sep 2005 15:00:18 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 31121 invoked by uid 22791); 26 Sep 2005 14:59:22 -0000
Received: from c-24-61-23-223.hsd1.ma.comcast.net (HELO cgf.cx) (24.61.23.223)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Mon, 26 Sep 2005 14:59:22 +0000
Received: by cgf.cx (Postfix, from userid 201)
	id AECDC13C1BD; Mon, 26 Sep 2005 14:59:20 +0000 (UTC)
Date: Mon, 26 Sep 2005 15:00:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: use 3-arg signal handlers when SA_SIGINFO flag is set
Message-ID: <20050926145920.GC18269@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20050926042653.GA6080@efn.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050926042653.GA6080@efn.org>
User-Agent: Mutt/1.5.8i
X-SW-Source: 2005-q3/txt/msg00111.txt.bz2

On Sun, Sep 25, 2005 at 09:26:53PM -0700, Yitzchak Scott-Thoennes wrote:
>I've done some but not a lot of testing with this patch.  In
>particular, I'm not sure that the tls field infodata always is set for
>all kinds of signals.

I've applied this patch.  Thanks.

>In exceptions.cc handle_exceptions, si_sigval is being set to various
>things that should be put in si_code instead (and si_code is set to
>SI_KERNEL).  I haven't changed this yet, and would appreciate someone
>else confirming that it should change (or explaining why it shouldn't).

Yes, this was wrong.  I think I've changed the si_sigval's to si_code's
where appropriate now, in CVS.

cgf
