Return-Path: <cygwin-patches-return-6058-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 390 invoked by alias); 4 Apr 2007 16:03:23 -0000
Received: (qmail 371 invoked by uid 22791); 4 Apr 2007 16:03:22 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Wed, 04 Apr 2007 17:03:11 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 4FDEF6D481D; Wed,  4 Apr 2007 18:03:09 +0200 (CEST)
Date: Wed, 04 Apr 2007 16:03:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] getmntent()->mnt_type values that match Linux...
Message-ID: <20070404160309.GB1672@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <45FE2DF8.40709@icculus.org> <46136153.8030000@icculus.org> <20070404084930.GK20261@calimero.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070404084930.GK20261@calimero.vinschen.de>
User-Agent: Mutt/1.4.2.2i
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q2/txt/msg00004.txt.bz2

Ryan,

On Apr  4 10:49, Corinna Vinschen wrote:
> On Apr  4 04:26, Ryan C. Gordon wrote:
> > 
> > >mnt_type is always "system" or "user" ... this patch changes this to 
> > >make an earnest effort to match what a GNU/Linux system would report, 
> > >and moves the system/user string to mnt_opts.
> > 
> > I sent in the copyright assignment paperwork for this around two weeks 
> > ago...just wanted to follow up to see if that was ever received, and if 
> > so, if this patch can be committed or needs further work.
> 
> Sorry, I didn't get the note from our dept so far.  I'll investigate...

your assignment arrived and has been signed.

Chris, are you going to review the patch?


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
