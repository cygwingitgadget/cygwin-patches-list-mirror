Return-Path: <cygwin-patches-return-6811-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11693 invoked by alias); 5 Nov 2009 14:03:47 -0000
Received: (qmail 11603 invoked by uid 22791); 5 Nov 2009 14:03:46 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 05 Nov 2009 14:03:43 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 712526D4195; Thu,  5 Nov 2009 15:03:32 +0100 (CET)
Date: Thu, 05 Nov 2009 14:03:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Allow to disable root privileges  with CYGWIN=noroot
Message-ID: <20091105140332.GO26344@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20091004195723.GH4563@calimero.vinschen.de>  <20091004200843.GK4563@calimero.vinschen.de>  <4ACFAE4D.90502@t-online.de>  <20091010100831.GA13581@calimero.vinschen.de>  <4AD243ED.6080505@t-online.de>  <20091013102502.GG11169@calimero.vinschen.de>  <4AD4E38A.2050301@t-online.de>  <20091014104003.GA24593@calimero.vinschen.de>  <1My1yO-0KvdnE0@fwd09.aul.t-online.de>  <20091014120237.GA27964@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20091014120237.GA27964@calimero.vinschen.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q4/txt/msg00142.txt.bz2

Hi Christian,

On Oct 14 14:02, Corinna Vinschen wrote:
> On Oct 14 13:24, Christian Franke wrote:
> > Corinna Vinschen wrote:
> > > 
> > > Cool.  Another interesting option could be to remove the domain admins
> > > group as well, if the user is a domain user and, of course, removing
> > > any single user right, similar to the "capsh" tool under SELinux.
> > > 
> > 
> > Yes, makes sense.
> > 
> > 
> > > I'm just not sure if that tool should be part of the Cygwin package or
> > > a package of its own right.  I'm leaning towards the latter choice.
> > > 
> > > 
> > 
> > ... or add it to the cygutils package ?
> 
> Sure, if Chuck likes the idea.

did you talk to Chuck in the meantime?  Or are you contemplating the
idea to put this in a separate package?


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
