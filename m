Return-Path: <cygwin-patches-return-5407-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12823 invoked by alias); 6 Apr 2005 08:42:39 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 12452 invoked from network); 6 Apr 2005 08:42:19 -0000
Received: from unknown (HELO cygbert.vinschen.de) (84.148.29.180)
  by sourceware.org with SMTP; 6 Apr 2005 08:42:19 -0000
Received: by cygbert.vinschen.de (Postfix, from userid 500)
	id 648C657D73; Wed,  6 Apr 2005 10:42:17 +0200 (CEST)
Date: Wed, 06 Apr 2005 08:42:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch] dup_ent does not set dst when src is NULL
Message-ID: <20050406084217.GF1471@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4253768A.8711D94@dessent.net> <20050406055116.GA10047@trixie.casa.cgf.cx> <4253A07B.A527DE74@dessent.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4253A07B.A527DE74@dessent.net>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2005-q2/txt/msg00003.txt.bz2

On Apr  6 01:40, Brian Dessent wrote:
> Christopher Faylor wrote:
> 
> > Thanks for the patch, but I went out of my way to avoid freeing the
> > buffer when I maded changes to dup_ent a couple of weeks ago.  I don't
> > want to revert to doing that again, so I've just used the return value
> > in all cases.
> 
> Thanks for taking care of that.  My original fix did more or less what
> you have done, by checking the return value, but I submitted the other
> way because it was much shorter and I didn't want to send anything
> non-trivial.  Hmm, maybe if my printer had some ink in it I could print
> out that copyright assignment form...

I'm looking forward :-)


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
