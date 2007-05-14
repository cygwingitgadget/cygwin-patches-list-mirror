Return-Path: <cygwin-patches-return-6080-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8488 invoked by alias); 14 May 2007 10:56:32 -0000
Received: (qmail 8476 invoked by uid 22791); 14 May 2007 10:56:30 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Mon, 14 May 2007 10:56:25 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 1C2BF6D4801; Mon, 14 May 2007 12:56:23 +0200 (CEST)
Date: Mon, 14 May 2007 10:56:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Bug fix and enchantment in cygpath.cc
Message-ID: <20070514105623.GA12681@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <44CB2A70.9020807@po4ta.com> <20060730124524.GC8152@calimero.vinschen.de> <44CCB327.6010607@po4ta.com> <20060731073251.GE8152@calimero.vinschen.de> <4645B776.6000708@po4ta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4645B776.6000708@po4ta.com>
User-Agent: Mutt/1.4.2.2i
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q2/txt/msg00026.txt.bz2

On May 12 15:47, Ilya Bobir wrote:
> >>[...]
> >>	* cygpath.cc (get_long_name): Fallback to get_long_path_name_w32impl.
> >>	Properly null-terminate 'buf'.
> [...]
> I've submitted this patch on 30.07.2006, but it seems that the bug still 
> exists in cygwin-1.5.24-2 that was released on 31.01.2007.
> I can see that HEAD CVS brunch contains the fix.
> 
> Why is that so?  Is it some kind of mistake?

No, the patch has gone into CVS HEAD, but the current releases are
taken from the cr-0x5f1 branch.  CVS HEAD is not yet ready for prime
time.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
