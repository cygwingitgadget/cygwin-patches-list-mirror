Return-Path: <cygwin-patches-return-8257-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18345 invoked by alias); 22 Oct 2015 12:45:51 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 18329 invoked by uid 89); 22 Oct 2015 12:45:50 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.4 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 22 Oct 2015 12:45:49 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 1BA6DA807C8; Thu, 22 Oct 2015 14:45:47 +0200 (CEST)
Date: Thu, 22 Oct 2015 12:45:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Introduce the 'usertemp' filesystem type
Message-ID: <20151022124547.GA5319@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <0MIuft-1ZZdDB2IaP-002Y2r@mail.gmx.com> <20151020093741.GA17374@calimero.vinschen.de> <alpine.DEB.1.00.1510201251140.31610@s15462909.onlinehome-server.info> <20151021182346.GE17374@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20151021182346.GE17374@calimero.vinschen.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q4/txt/msg00010.txt.bz2

On Oct 21 20:23, Corinna Vinschen wrote:
> On Oct 20 13:47, Johannes Schindelin wrote:
> > On Tue, 20 Oct 2015, Corinna Vinschen wrote:
> > > On Sep 16 09:35, Johannes Schindelin wrote:
> > [...]
> > > > +          char mb_tmp[len = sys_wcstombs (NULL, 0, tmp)];
> > > 
> > > - len = sys_wcstombs() + 1
> > 
> > Whoops. I always get that wrong.
> > 
> > But... actually... Did you know that `sys_wcstombs()` returns something
> > different than advertised? The documentation says:
> > 
> > 	- dst == NULL; len is ignored, the return value is the number
> > 	  of bytes required for the string without the trailing NUL, just
> > 	  like the return value of the wcstombs function.
> > 
> > But when I call
> > 
> > 	small_printf("len of 1: %d\n", sys_wcstombs(NULL, 0, L"1"));
> > 
> > it prints "len of 1: 2", i.e. the number of bytes requires for the string
> > *with* the trailing NUL, disagreeing with the comment in strfuncs.cc.
> 
> Drat.  You're right.  As usual I wonder why nobody ever noticed this.
> As soon as the nwc parameter is larger than the number of non-0 wchars
> in the source string, sys_cp_wcstombs returns the length including the
> trailing NUL.
> 
> And looking through the Cygwin sources the usage is rather erratic,
> sometimes with, sometimes without + 1 :(
> 
> > How do you want to proceed from here? Should I fix sys_wcstombs() when the
> > fourth parameter is -1? Or is this not a fix, but I would rather break
> > things?
> 
> No, this needs fixing, but it also would break things.  I have to take
> a stab at fixing this throughout Cygwin first.

I just pushed a patch to the git repo supposed to fix sys_cp_wcstombs
return value inconsistency.  It should now always return the length of
the string without the trailing NUL.  Please give it a try.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat
