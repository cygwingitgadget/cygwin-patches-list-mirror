Return-Path: <cygwin-patches-return-7841-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2859 invoked by alias); 4 Mar 2013 10:51:55 -0000
Received: (qmail 2828 invoked by uid 22791); 4 Mar 2013 10:51:43 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Mon, 04 Mar 2013 10:51:37 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 99C7D520242; Mon,  4 Mar 2013 11:51:34 +0100 (CET)
Date: Mon, 04 Mar 2013 10:51:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 64bit] Fix ONDEE for 64bit
Message-ID: <20130304105134.GF5468@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20130304021224.381b9ec4@YAAKOV04>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20130304021224.381b9ec4@YAAKOV04>
User-Agent: Mutt/1.5.21 (2010-09-15)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2013-q1/txt/msg00052.txt.bz2

On Mar  4 02:12, Yaakov wrote:
> Corinna,
> 
> More fun from our good friend, size_t:
> 
> Because operator new (in its various forms) takes a size_t argument, it
> is mangled differently on x86_64 above and beyond the common leading
> underscore issue.  Patches for winsup/cygwin and gcc (on top of your
> latest patch) attached.
> 
> 
> Yaakov

> 2013-03-04  Yaakov Selkowitz  <yselkowitz@...>
> 
> 	* cygwin64.din: Fix mangled operator new names for size_t==long.
> 	* libstdcxx_wrapper.cc: Ditto for x86_64.

That looks good, thanks for catching this problem!  Please apply the
Cygwin changes.  I'll rebuild new base packages including the gcc
patches soon.


Thanks again,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat
