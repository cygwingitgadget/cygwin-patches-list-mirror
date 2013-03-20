Return-Path: <cygwin-patches-return-7859-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17480 invoked by alias); 20 Mar 2013 08:46:13 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 17435 invoked by uid 89); 20 Mar 2013 08:46:06 -0000
X-Spam-SWARE-Status: No, score=-1.9 required=5.0 tests=AWL,BAYES_00 autolearn=ham version=3.3.1
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.84/v0.84-167-ge50287c) with ESMTP; Wed, 20 Mar 2013 08:46:04 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id A03F25203F8; Wed, 20 Mar 2013 09:46:01 +0100 (CET)
Date: Wed, 20 Mar 2013 08:46:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 64bit] Fix ONDEE for 64bit, part 2
Message-ID: <20130320084601.GG20727@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <CAGvSfexvjDhbp7sJvoKpF_GYt9t2DmuCD7QmdmFkzdA4=GBeTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGvSfexvjDhbp7sJvoKpF_GYt9t2DmuCD7QmdmFkzdA4=GBeTA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-SW-Source: 2013-q1/txt/msg00070.txt.bz2

On Mar 20 01:22, Yaakov (Cygwin/X) wrote:
> Unfortunately I missed something last time when I tried fixing ONDEE.
> Patch attached.

I checked it in with a small change.  I thought it might look a bit
more clear if all symbols are defined using a REAL_foo define.  Please
have a look if that's ok as I did it.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat
