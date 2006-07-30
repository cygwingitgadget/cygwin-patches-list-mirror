Return-Path: <cygwin-patches-return-5949-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21411 invoked by alias); 30 Jul 2006 12:45:29 -0000
Received: (qmail 21399 invoked by uid 22791); 30 Jul 2006 12:45:28 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Sun, 30 Jul 2006 12:45:26 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 883CF54C007; Sun, 30 Jul 2006 14:45:24 +0200 (CEST)
Date: Sun, 30 Jul 2006 12:45:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Bug fix and enchantment in cygpath.cc
Message-ID: <20060730124524.GC8152@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <44CB2A70.9020807@po4ta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44CB2A70.9020807@po4ta.com>
User-Agent: Mutt/1.4.2i
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q3/txt/msg00044.txt.bz2

On Jul 29 12:29, Ilya wrote:
> This patch is against cygpath.cc 1.42.
> In 1.43 addressed bug was already fixed, but I believe my fix is a bit 
> better.
> 
> Current fix just returns filename, in case filename is for a nonexistent 
> file.  I think that internal short to long file name conversion routine 
> could be used in this case, because it deals ok with nonexistent files.

If you could regenerate your patch so that it's against current CVS, I
will take it, since its size will then be below the "trivial fix" rule.
Please see http://cygwin.com/contrib.html, "Before you get started",
second paragraph.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
