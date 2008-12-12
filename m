Return-Path: <cygwin-patches-return-6387-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13189 invoked by alias); 12 Dec 2008 16:11:16 -0000
Received: (qmail 13176 invoked by uid 22791); 12 Dec 2008 16:11:15 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 12 Dec 2008 16:10:40 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 30D356D4356; Fri, 12 Dec 2008 17:13:04 +0100 (CET)
Date: Fri, 12 Dec 2008 16:11:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Avoid duplicate names in /proc/registry (which may 	crash   find)
Message-ID: <20081212161304.GK32197@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <49384250.7080707@t-online.de> <20081205095742.GP12905@calimero.vinschen.de> <4939A9F7.1000400@t-online.de> <20081207171802.GV12905@calimero.vinschen.de> <493C1DF7.6090905@t-online.de> <20081208114800.GW12905@calimero.vinschen.de> <20081208115433.GX12905@calimero.vinschen.de> <49417625.4030209@t-online.de> <20081212152000.GA32492@calimero.vinschen.de> <494287F4.2080505@byu.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <494287F4.2080505@byu.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q4/txt/msg00031.txt.bz2

On Dec 12 08:49, Eric Blake wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> According to Corinna Vinschen on 12/12/2008 8:20 AM:
> > 
> > Here's a question which occured to me when reading the doc after I had
> > applied it.  There's apparently still a problem which is, how do you
> > read the default value of a key if a value called '@' exists?  Do you
> > have an idea for a simple solution?
> 
> "@" for the named value, and "%.val" for the unnamed default?

Backward compatibility would ask for sticking to @ for the default
value.  Actually there could be a key and a value called @ so you
have three @ items. :-P


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
