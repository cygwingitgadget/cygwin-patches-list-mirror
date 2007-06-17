Return-Path: <cygwin-patches-return-6119-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11149 invoked by alias); 17 Jun 2007 09:03:09 -0000
Received: (qmail 11138 invoked by uid 22791); 17 Jun 2007 09:03:08 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Sun, 17 Jun 2007 09:03:07 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id CF1CD6D47FD; Sun, 17 Jun 2007 11:03:04 +0200 (CEST)
Date: Sun, 17 Jun 2007 09:03:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Failure in rebuilding Cygwin-1.5.24-2 with recent newlib
Message-ID: <20070617090304.GA29805@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.OSF.4.21.0706161607350.22962-100000@ax0rm1.roma1.infn.it> <467403F8.FDD06745@dessent.net> <20070616194741.GB4179@calimero.vinschen.de> <20070617003306.GA26494@ednor.casa1.cgf.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070617003306.GA26494@ednor.casa1.cgf.cx>
User-Agent: Mutt/1.4.2.2i
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q2/txt/msg00065.txt.bz2

On Jun 16 20:33, Christopher Faylor wrote:
> On Sat, Jun 16, 2007 at 09:47:41PM +0200, Corinna Vinschen wrote:
> >Chris, do you know why we maintain our own sys.cdefs.h?  It looks
> >like we could just delete it.
> 
> Cygwin's cdefs.h predates the newlib version.  I've removed Cygwin's version.

Thanks.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
