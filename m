Return-Path: <cygwin-patches-return-6555-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24208 invoked by alias); 6 Jul 2009 10:38:47 -0000
Received: (qmail 24197 invoked by uid 22791); 6 Jul 2009 10:38:47 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 06 Jul 2009 10:38:40 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 4F1156D5598; Mon,  6 Jul 2009 12:38:29 +0200 (CEST)
Date: Mon, 06 Jul 2009 10:38:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: AttachConsole broken autoload
Message-ID: <20090706103829.GI12258@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4A4F4F5B.8090806@gmail.com> <20090704141721.GA11034@ednor.casa.cgf.cx> <4A4F70D0.3060107@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4A4F70D0.3060107@gmail.com>
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
X-SW-Source: 2009-q3/txt/msg00009.txt.bz2

Hi Dave,

On Jul  4 16:10, Dave Korn wrote:
> Christopher Faylor wrote:
> > On Sat, Jul 04, 2009 at 01:47:23PM +0100, Dave Korn wrote:
> 
> >>
> >> 	* autoload.cc (AttachConsole):  Correct size of args.
> > 
> > Yes, I think that's an obvious fix.
> 
>   Ta, committed.

Thanks for catching this.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
