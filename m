Return-Path: <cygwin-patches-return-7099-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20616 invoked by alias); 11 Sep 2010 11:18:37 -0000
Received: (qmail 19926 invoked by uid 22791); 11 Sep 2010 11:18:24 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Sat, 11 Sep 2010 11:18:02 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 503E46D435B; Sat, 11 Sep 2010 13:17:59 +0200 (CEST)
Date: Sat, 11 Sep 2010 11:18:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Add fenv.h and support.
Message-ID: <20100911111759.GQ16534@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4C8A9AC8.7070904@gmail.com> <20100910214347.GA23700@ednor.casa.cgf.cx> <4C8AD089.9000605@gmail.com> <20100911051009.GA25209@ednor.casa.cgf.cx> <4C8B2B9B.8060801@gmail.com> <20100911080929.GL16534@calimero.vinschen.de> <4C8B6671.6000200@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4C8B6671.6000200@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2010-q3/txt/msg00059.txt.bz2

On Sep 11 12:22, Dave Korn wrote:
> On 11/09/2010 09:09, Corinna Vinschen wrote:
> > Hi Dave,
> 
>   Morning!
> 
> > On Sep 11 08:11, Dave Korn wrote:
> >> So, I ended up committing it like so:
> > 
> > Can you please add some words to doc/new-features.sgml?
> 
>   How's this look?
> 
> winsup/doc/ChangeLog:
> 
> 	* new-features.sgml: Mention fenv support.

I would remove the opengroup link and just keep the gnu C lib one,
but other than that it looks good.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
