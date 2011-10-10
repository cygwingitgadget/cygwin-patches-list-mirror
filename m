Return-Path: <cygwin-patches-return-7523-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10641 invoked by alias); 10 Oct 2011 15:05:32 -0000
Received: (qmail 10260 invoked by uid 22791); 10 Oct 2011 15:05:06 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Mon, 10 Oct 2011 15:04:46 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 4F8342CBDB0; Mon, 10 Oct 2011 17:04:43 +0200 (CEST)
Date: Mon, 10 Oct 2011 15:05:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] add getconf(1)
Message-ID: <20111010150443.GB30156@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1311042021.7348.26.camel@YAAKOV04> <20110719074343.GA15263@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20110719074343.GA15263@calimero.vinschen.de>
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
X-SW-Source: 2011-q4/txt/msg00013.txt.bz2

Hi Yaakov,

On Jul 19 09:43, Corinna Vinschen wrote:
> On Jul 18 21:20, Yaakov (Cygwin/X) wrote:
> > This patch adds getconf(1) as required by POSIX:
> 
> This looks good.  I'm just wondering... on one hand the code seems to
> have nothing Cygwin-specifc and could be packed as an external package
> like any other POSIX tool, on the other hand I can see how it belongs to
> the Cygwin utils given that getconf on Linux is part of glibc.  I'm
> inclined to stick it into utils for the latter reason.  Chris?  What's
> your stance?

what I didn't realize at the time was the fact that you didn't provide a
documentation patch, too.  My latest patch to utils.sgml adds a short
description for the getconf tool.  It's rather tight-lipped, so I'd
appreciate if you could have a look and, perhaps, improve the text.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
