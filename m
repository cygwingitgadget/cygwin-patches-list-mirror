Return-Path: <cygwin-patches-return-6106-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8952 invoked by alias); 29 May 2007 08:12:22 -0000
Received: (qmail 8942 invoked by uid 22791); 29 May 2007 08:12:22 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Tue, 29 May 2007 08:12:20 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id B2BD66D4803; Tue, 29 May 2007 10:12:17 +0200 (CEST)
Date: Tue, 29 May 2007 08:12:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Dumper produces unuseable dumps (fix).
Message-ID: <20070529081217.GA6392@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <46310D90.8050703@portugalmail.pt> <20070427062022.GC4978@calimero.vinschen.de> <4053daab0704270801i5c198166n343f8f7f76edc435@mail.gmail.com> <20070515164607.GL4310@calimero.vinschen.de> <4053daab0705170529q60767bb7mf19c2643a6ef79eb@mail.gmail.com> <4652101E.3010706@portugalmail.pt> <20070522071652.GH6003@calimero.vinschen.de> <20070525095002.GA23530@calimero.vinschen.de> <4658B7CB.9020107@portugalmail.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4658B7CB.9020107@portugalmail.pt>
User-Agent: Mutt/1.4.2.2i
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q2/txt/msg00052.txt.bz2

On May 26 23:42, Pedro Alves wrote:
> Corinna Vinschen wrote:
> >
> >Ping!  The papers have found their way to our office and are already
> >signed.
> >
> 
> Great!  That's a relief.
> 
> >You said you have an updated patch?
> 
> Yep.  Here it is.
> 
> human-made-inter-diff:
> - set lma == 0
> - fixed buglet in the windows->elf protection mappings.

Thanks, applied.  I simplified the ChangeLog entry slightly.  The
revision number is controlled by CVS anyway, so I don't think it
makes sense to mention it in the ChangeLog.


Thanks again,
Corinna


-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
