Return-Path: <cygwin-patches-return-6970-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6369 invoked by alias); 15 Feb 2010 09:31:53 -0000
Received: (qmail 6359 invoked by uid 22791); 15 Feb 2010 09:31:53 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 15 Feb 2010 09:31:49 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 6D4A16D42F5; Mon, 15 Feb 2010 10:31:39 +0100 (CET)
Date: Mon, 15 Feb 2010 09:31:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Add xdr support
Message-ID: <20100215093139.GV5683@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4B764A1F.6060003@cwilson.fastmail.fm>  <20100213113509.GJ5683@calimero.vinschen.de>  <4B76C334.8080101@cwilson.fastmail.fm>  <20100213210122.GA20649@ednor.casa.cgf.cx>  <4B773B70.8040208@cwilson.fastmail.fm>  <4B778315.9090300@gmail.com>  <4B778E43.5020701@cwilson.fastmail.fm>  <4B7834AD.3040606@gmail.com>  <20100214190623.GB19242@ednor.casa.cgf.cx>  <4B78E01F.8050007@cwilson.fastmail.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4B78E01F.8050007@cwilson.fastmail.fm>
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
X-SW-Source: 2010-q1/txt/msg00086.txt.bz2

On Feb 15 00:48, Charles Wilson wrote:
> Christopher Faylor wrote:
> > You could make the same argument for much of the functionality we've
> > added to cygwin.  I'm sure a significant number of functions could be
> > added to newlib if we were so inclined.  Just take a look at the libc
> > directory or the regex directory.
> 
> Good points.  regex functions are also typically provided by libc.so,
> yet cygwin has its own versions not provided by newlib...

Regex has some history.  For the last set from 2 weeks ago (which has
apparently some well-hidden bug) I felt rather sick when thinking about
having to add all that _MB_CAPABLE stuff.  I never actually contemplated
to add it to newlib :}

> > (And I hate having to use _DEFUN in the year 2010)
> 
> Yeah, that was...icky.

ACK.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
