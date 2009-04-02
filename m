Return-Path: <cygwin-patches-return-6459-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24540 invoked by alias); 2 Apr 2009 08:49:47 -0000
Received: (qmail 24525 invoked by uid 22791); 2 Apr 2009 08:49:46 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 02 Apr 2009 08:49:41 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 898D96D551D; Thu,  2 Apr 2009 10:49:30 +0200 (CEST)
Date: Thu, 02 Apr 2009 08:49:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] <netdb.h> SUSv3 compliance
Message-ID: <20090402084930.GS12738@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <49D45162.8020805@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49D45162.8020805@users.sourceforge.net>
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
X-SW-Source: 2009-q2/txt/msg00001.txt.bz2

On Apr  2 00:47, Yaakov S wrote:
> SUSv3&4 state:
> 
> > Inclusion of the <netdb.h> header may also make visible all symbols
> > from <netinet/in.h>, <sys/socket.h>, and <inttypes.h>.
> 
> Having come across packages that assume this (at least in part), I would
> like to make ours compatible.
> 
> <inttypes.h> must #include <stdint.h> per SUSv3, so that should be a
> safe switch.  <cygwin/in.h> already has a #include <cygwin/socket.h>,
> but I don't know if you want to assume that or not.
> 
> Patch attached.

Applied with a tweak.  The inclusion of netinet/in.h clashes with the
inclusion of winsock2.h in case of a couple of datatype.  So this
header must not be included when building Cygwin itself.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
