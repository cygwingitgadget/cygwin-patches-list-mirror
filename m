Return-Path: <cygwin-patches-return-7457-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11821 invoked by alias); 31 Jul 2011 08:25:08 -0000
Received: (qmail 11634 invoked by uid 22791); 31 Jul 2011 08:24:48 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Sun, 31 Jul 2011 08:24:33 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id F0F5B2C0634; Sun, 31 Jul 2011 10:24:30 +0200 (CEST)
Date: Sun, 31 Jul 2011 08:25:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] clock_nanosleep(2)
Message-ID: <20110731082430.GA23564@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1311126880.7796.9.camel@YAAKOV04> <20110721103735.GJ15150@calimero.vinschen.de> <1311274281.6192.3.camel@YAAKOV04>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1311274281.6192.3.camel@YAAKOV04>
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
X-SW-Source: 2011-q3/txt/msg00033.txt.bz2

Hi Yaakov,

anything new from the clock_nanosleep frontier?

On Jul 21 13:51, Yaakov (Cygwin/X) wrote:
> On Thu, 2011-07-21 at 12:37 +0200, Corinna Vinschen wrote:
> > Given our current discussion to change cancelable_wait, does it make
> > sense to review this patch?  
> 
> No, the cancelable_wait changes need to go first.
> 
> > AFAICs the clock_nanosleep function will have to be changes quite a bit, right?
> 
> Definitely.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
