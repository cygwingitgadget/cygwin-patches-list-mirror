Return-Path: <cygwin-patches-return-7008-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12653 invoked by alias); 30 Mar 2010 09:59:19 -0000
Received: (qmail 12640 invoked by uid 22791); 30 Mar 2010 09:59:19 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Tue, 30 Mar 2010 09:59:15 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 6F18B6D41A0; Tue, 30 Mar 2010 11:59:12 +0200 (CEST)
Date: Tue, 30 Mar 2010 09:59:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Cc: Thomas Wolff <towo@towo.net>
Subject: Re: console enhancements: mouse events etc
Message-ID: <20100330095912.GZ18364@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com, Thomas Wolff <towo@towo.net>
References: <4B266F9B.6070204@towo.net>  <20091214171323.GS8059@calimero.vinschen.de>  <20091215130036.GA19394@calimero.vinschen.de>  <4B28ACE8.1050305@towo.net>  <20091216145627.GM8059@calimero.vinschen.de>  <4B29934A.80902@towo.net>  <4B2C0715.8090108@towo.net>  <20091221101216.GA5632@calimero.vinschen.de>  <20100125190806.GA9166@calimero.vinschen.de>  <4B5F0585.9070903@towo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4B5F0585.9070903@towo.net>
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
X-SW-Source: 2010-q1/txt/msg00124.txt.bz2

Hi Thomas,

On Jan 26 16:08, Thomas Wolff wrote:
> On 25.01.2010 20:08, Corinna Vinschen wrote:
> >Hi Thomas,
> >...
> >can you please create a patch to add some words to the "What's new and
> >what changed from 1.7.1 to 1.7.2" section in the User's Guide
> >(winsup/doc/new-features.sgml), in terms of your console enhancements?
> Hi, changelog and patch attached. I had already looked for a web or
> man page describing console features to amend that but apparently
> there is none.
> Thomas
> [...]

Since you were looking into the Cygwin console code lately, maybe you
could find out why `stty sane' doesn't reset the character set?

A couple of minutes ago I printed the bytes from an ISO image unfiltered
to the console.  Afterwards, the console was using the alternate
charset.  `stty sane' does not switch back to the default charset for
some reason.

If you have a bit of spare time, do you think you would like to have
a look?


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
