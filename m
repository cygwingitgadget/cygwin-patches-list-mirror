Return-Path: <cygwin-patches-return-6540-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6608 invoked by alias); 4 Jun 2009 15:11:14 -0000
Received: (qmail 6555 invoked by uid 22791); 4 Jun 2009 15:11:12 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 04 Jun 2009 15:11:04 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id E1DA96D4186; Thu,  4 Jun 2009 17:10:53 +0200 (CEST)
Date: Thu, 04 Jun 2009 15:11:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH?]  Separate pthread patches, #2 take 2.
Message-ID: <20090604151053.GX23519@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4A270656.8090704@gmail.com> <4A2716AF.9070101@gmail.com> <4A2728F8.8020907@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4A2728F8.8020907@gmail.com>
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
X-SW-Source: 2009-q2/txt/msg00082.txt.bz2

On Jun  4 02:52, Dave Korn wrote:
> Dave Korn wrote:
> > Dave Korn wrote:
> >>   The attached patch implements ilockexch and ilockcmpexch, using the inline
> >> asm definition from __arch_compare_and_exchange_val_32_acq in
> >> glibc-2.10.1/sysdeps/i386/i486/bits/atomic.h, trivially expanded inline rather
> >> than in its original preprocessor macro form.
> >>
> >>   It generates incorrect code.
> > 
> >   This much looks like it's probably a compiler bug.  
> 
>   Let's see whether anyone else agrees:
> 
>         http://gcc.gnu.org/ml/gcc/2009-06/msg00053.html

When you checked in this change, I'll create a 1.7.0-49 test release.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
