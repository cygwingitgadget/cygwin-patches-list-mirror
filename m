Return-Path: <cygwin-patches-return-7360-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6800 invoked by alias); 12 May 2011 19:31:00 -0000
Received: (qmail 6462 invoked by uid 22791); 12 May 2011 19:30:36 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Thu, 12 May 2011 19:30:17 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 3DE1B2C0577; Thu, 12 May 2011 21:30:14 +0200 (CEST)
Date: Thu, 12 May 2011 19:31:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Extending /proc/*/maps
Message-ID: <20110512193014.GJ3020@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4DCACB72.6070201@cs.utoronto.ca> <20110511193107.GF11041@calimero.vinschen.de> <20110512121012.GB18135@calimero.vinschen.de> <20110512150910.GE18135@calimero.vinschen.de> <4DCC0B5C.4040901@cs.utoronto.ca> <20110512165520.GB3020@calimero.vinschen.de> <20110512171130.GD3020@calimero.vinschen.de> <4DCC1EB0.7080905@cs.utoronto.ca> <20110512184812.GF3020@calimero.vinschen.de> <4DCC32A9.4050108@cs.utoronto.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4DCC32A9.4050108@cs.utoronto.ca>
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
X-SW-Source: 2011-q2/txt/msg00126.txt.bz2

On May 12 15:19, Ryan Johnson wrote:
> On 12/05/2011 2:48 PM, Corinna Vinschen wrote:
> >Nope.  As I wrote in my previoous mail and as you can still see in my
> >quote above, the two virtual memory areas from 0x20000 to 0x30000 and
> >from 0x30000 to 0x230000 together constitute a single start block in
> >heap 2.  The OS is a great faker in terms of information returned to
> >the application, apparently.
> OK. I finally understand now. I was assuming the heap would not
> report multiple allocations as a single heap region.
> 
> Windows is weird.

Exaclty.  Funnily, in the end it always boils down to that. 


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
