Return-Path: <cygwin-patches-return-6480-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5095 invoked by alias); 4 Apr 2009 15:17:57 -0000
Received: (qmail 5084 invoked by uid 22791); 4 Apr 2009 15:17:56 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sat, 04 Apr 2009 15:17:51 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 0A21E6D5521; Sat,  4 Apr 2009 17:17:40 +0200 (CEST)
Date: Sat, 04 Apr 2009 15:17:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Add uchar.h
Message-ID: <20090404151739.GG852@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <49D60CC2.8090205@gmail.com> <20090403143528.GA468@calimero.vinschen.de> <49D69271.7040805@gmail.com> <20090404094450.GA7844@calimero.vinschen.de> <49D75253.4030506@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49D75253.4030506@gmail.com>
User-Agent: Mutt/1.5.19 (2009-02-20)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q2/txt/msg00022.txt.bz2

On Apr  4 13:28, Dave Korn wrote:
> Corinna Vinschen wrote:
> > I also think this would better fit into newlib.
> 
>   I'm not sure.  My reasoning was that since we override newlib's types system
> by providing our own stdint.h, it made sense to provide our own uchar.h as well.

When I first wrote stdint.h for Cygwin, newlib hadn't one.  At the time
I didn't feel comfortable to write a header which fits the need of all
targets.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
