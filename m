Return-Path: <cygwin-patches-return-7801-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8041 invoked by alias); 17 Feb 2013 11:20:14 -0000
Received: (qmail 7732 invoked by uid 22791); 17 Feb 2013 11:19:58 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Sun, 17 Feb 2013 11:19:52 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 46A1E52034F; Sun, 17 Feb 2013 12:19:50 +0100 (CET)
Date: Sun, 17 Feb 2013 11:20:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 64bit] utils: port dumper to 64bit
Message-ID: <20130217111950.GA11957@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20130215020235.3f769e45@YAAKOV04> <20130215110431.GB27934@calimero.vinschen.de> <20130217044153.5d72306d@YAAKOV04>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20130217044153.5d72306d@YAAKOV04>
User-Agent: Mutt/1.5.21 (2010-09-15)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2013-q1/txt/msg00012.txt.bz2

Hi Yaakov,

On Feb 17 04:41, Yaakov wrote:
> On Fri, 15 Feb 2013 12:04:31 +0100, Corinna Vinschen wrote:
> > On Feb 15 02:02, Yaakov wrote:
> > > I just uploaded cygwin64-libiconv, cygwin64-gettext, and
> > > cygwin64-libbfd to Ports, so that dumper.exe could be built.  It
> > > appears it hasn't been ported yet, so here's a first attempt.  Comments
> > > welcome.
> > 
> > Looks good, I just have a few style nits.
> 
> Revised patch attached.

Looks good.  Please apply.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat
