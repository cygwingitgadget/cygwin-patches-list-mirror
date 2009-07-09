Return-Path: <cygwin-patches-return-6569-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12537 invoked by alias); 9 Jul 2009 08:16:59 -0000
Received: (qmail 12517 invoked by uid 22791); 9 Jul 2009 08:16:58 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 09 Jul 2009 08:16:43 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id BB08C6D5598; Thu,  9 Jul 2009 10:16:31 +0200 (CEST)
Date: Thu, 09 Jul 2009 08:16:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Re: 1.7 winbase.h (ilockcmpexch) compile error
Message-ID: <20090709081631.GA28487@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.CYG.4.58.0906241239470.2248@PC1163-8460-XP.flightsafety.com> <4A53BC5D.7010401@gmail.com> <4A53E449.4020504@gmail.com> <20090708090638.GY12258@calimero.vinschen.de> <4A54CB28.1090703@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4A54CB28.1090703@gmail.com>
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
X-SW-Source: 2009-q3/txt/msg00023.txt.bz2

On Jul  8 17:36, Dave Korn wrote:
> Corinna Vinschen wrote:
> > On Jul  8 01:11, Dave Korn wrote:
> 
> > But seriously, I'm still using gcc 4.3.2 20080827 (alpha-testing) 1
> > for building Cygwin.  Is that sufficient for now or should I upgrade?
> 
>   That's 4.3.2-1, no?

Uh, yes.  It's the version I used to build my Linux cross compiler.

>     I've been using nothing but 4.3.2-2 for a while now.
> The problems are known, and none of them affect the Cygwin DLL:

Ok, good to know.

> - redirected gfortran IO when using libgfortran DLL
> - shared lib java completely borked
> - libstdc++ dll operators new/delete not replaceable.
> 
>   I'll have 4.3.3-1 out shortly.  

I guess that's a good time to upgrade my cross compiler as well.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
