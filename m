Return-Path: <cygwin-patches-return-5480-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17236 invoked by alias); 19 May 2005 20:31:13 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 16661 invoked from network); 19 May 2005 20:30:41 -0000
Received: from unknown (HELO calimero.vinschen.de) (84.148.25.180)
  by sourceware.org with SMTP; 19 May 2005 20:30:41 -0000
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 9F720544001; Thu, 19 May 2005 22:30:46 +0200 (CEST)
Date: Thu, 19 May 2005 20:31:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin@cygwin.com
Cc: cygwin-patches@cygwin.com
Subject: Re: [patch] several new features for cygrunsrv
Message-ID: <20050519203046.GH2794@calimero.vinschen.de>
Reply-To: cygwin@cygwin.com
Mail-Followup-To: cygwin@cygwin.com, cygwin-patches@cygwin.com
References: <428CE837.C00E288B@dessent.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <428CE837.C00E288B@dessent.net>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2005-q2/txt/msg00076.txt.bz2

Hi Brian,

I really like this patch, cool stuff.  However, I have two nits.

First, your patch adds new options, so it should also add some wording to
cygrunsrv.README.

On May 19 12:25, Brian Dessent wrote:
> for S in `cygrunsrv -L`; do cygrunsrv -E $S; done
> 
> If a service name contains spaces it will be double-quoted.

I gave the -L option a quick test and to my surprise, no service got
printed.  The problem was apparently that I was not running /bin/cygrunsrv,
but the cygrunsrv I've just built in my builddir.  To recognize the
services as a Cygwin service, the list function uses the full path to
cygrunsrv.  I'm wondering if comparing the basename wouldn't be better
for debugging purposes?  This is also more aligned to the -Q option which
prints services also if it's not the "right" cygrunsrv asking for them.


Thanks,
Corinna


P.S.: I'm redirecting to the cygwin ML.  cygwin-patches is really for
      Cygwin only, not for any Cygwin applications.

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
