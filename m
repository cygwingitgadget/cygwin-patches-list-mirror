Return-Path: <cygwin-patches-return-6520-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25675 invoked by alias); 4 May 2009 07:43:23 -0000
Received: (qmail 25657 invoked by uid 22791); 4 May 2009 07:43:21 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 04 May 2009 07:43:10 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id D53446D4FBD; Mon,  4 May 2009 09:42:59 +0200 (CEST)
Date: Mon, 04 May 2009 07:43:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: sys/socket.h: define SOL_IPV6?
Message-ID: <20090504074259.GB12561@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <49F524DF.9040107@users.sourceforge.net> <20090427043141.GA20932@ednor.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090427043141.GA20932@ednor.casa.cgf.cx>
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
X-SW-Source: 2009-q2/txt/msg00062.txt.bz2

On Apr 27 00:31, Christopher Faylor wrote:
> On Sun, Apr 26, 2009 at 10:22:07PM -0500, Yaakov (Cygwin/X) wrote:
> >Does it make sense to define SOL_IPV6 now?  Patch attached if so.
> 
> I think it does.  I've checked in this patch.  I'm sure Corinna will
> revert it if I am wrong.

It's not wrong but unfortunately it won't help either.  The only SOL_xxx
option supported by Winsock is SOL_SOCKET.  But since we already have
the other SOL_xxx options defined, it's a good idea to have SOL_IPV6
defined as well.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
