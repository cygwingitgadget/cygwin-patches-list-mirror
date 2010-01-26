Return-Path: <cygwin-patches-return-6933-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11316 invoked by alias); 26 Jan 2010 16:10:56 -0000
Received: (qmail 11294 invoked by uid 22791); 26 Jan 2010 16:10:54 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 26 Jan 2010 16:10:47 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 9A92F6D418B; Tue, 26 Jan 2010 17:10:36 +0100 (CET)
Date: Tue, 26 Jan 2010 16:10:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: console enhancements: mouse events etc
Message-ID: <20100126161036.GA31281@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
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
X-SW-Source: 2010-q1/txt/msg00049.txt.bz2

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

> 2010-01-26  Thomas Wolff  <towo@towo.net>
> 
> 	* new-features.sgml (Device related changes): List console enhancements:
> 	Modified function and keypad keys, VT100 line drawing graphics mode, 
> 	Alt-AltGr combinations, enhanced mouse and focus event reporting, 
> 	attribute escape sequences.
> 

Thanks!  I checked in a slighly shortened version and I added it to
the new 1.7.2 feature section.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
