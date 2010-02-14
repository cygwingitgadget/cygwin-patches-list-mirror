Return-Path: <cygwin-patches-return-6961-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3063 invoked by alias); 14 Feb 2010 10:21:13 -0000
Received: (qmail 3053 invoked by uid 22791); 14 Feb 2010 10:21:13 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sun, 14 Feb 2010 10:21:09 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 500CF6D42F5; Sun, 14 Feb 2010 11:20:59 +0100 (CET)
Date: Sun, 14 Feb 2010 10:21:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Add xdr support
Message-ID: <20100214102059.GP5683@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4B764A1F.6060003@cwilson.fastmail.fm>  <20100213113509.GJ5683@calimero.vinschen.de>  <4B76C334.8080101@cwilson.fastmail.fm>  <20100213210122.GA20649@ednor.casa.cgf.cx>  <4B773B70.8040208@cwilson.fastmail.fm>  <4B778315.9090300@gmail.com>  <4B778E43.5020701@cwilson.fastmail.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4B778E43.5020701@cwilson.fastmail.fm>
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
X-SW-Source: 2010-q1/txt/msg00077.txt.bz2

On Feb 14 00:46, Charles Wilson wrote:
> Dave Korn wrote:
> > On 13/02/2010 23:53, Charles Wilson wrote:
> > 
> >> http://cygwin.com/ml/cygwin-developers/2009-10/msg00242.html
> > 
> >> IIRC at that time Corinna suggested that newlib was the appropriate
> >> place for this, if I wanted to contribute it post-1.7.1. 
> > 
> > http://cygwin.com/ml/cygwin-developers/2009-10/msg00254.html
> > 
> >> I asked how to
> >> go about adding something to newlib that might not work for all targets,
> >> and she said:
> > 
> >> Unfortunately, my google-foo is not strong enough to find that message
> >> in the cygwin archives, 
> > 
> > http://cygwin.com/ml/cygwin-developers/2009-10/msg00259.html
> 
> I bow to your superior google-foo. Interesting thing from those links,
> apparently *I* was the first person to mention newlib as the appropriate
> home for the XDR implementation, not Corinna.  Weird.

Uh, I should have read all of the thread before replying.

> Well, historical oddities notwithstanding, I think newlib /is/ the
> correct place, simply because I can easily see a demand/need for XDR
> code on other newlib targets.  But obviously the ultimate call is Jeff
> J's -- although I'm not planning on even submitting it over there unless
> this group decides it is the correct thing to do.

Well, ultimately it's your decision where you provide this stuff.  After
all, you're the one who did all the work and if you think that newlib is
a good place, then, so be it.  Personally I never used nor needed XDR,
but that doesn't mean it's useless for others.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
