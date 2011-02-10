Return-Path: <cygwin-patches-return-7191-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27075 invoked by alias); 10 Feb 2011 16:02:06 -0000
Received: (qmail 27027 invoked by uid 22791); 10 Feb 2011 16:01:53 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Thu, 10 Feb 2011 16:01:49 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 734552CA2C0; Thu, 10 Feb 2011 17:01:46 +0100 (CET)
Date: Thu, 10 Feb 2011 16:02:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] for SIGSEGV, compilation error in gcc 4.6
Message-ID: <20110210160146.GA4113@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <AANLkTinBrYcRrRBztY5eKWzon02GtB4t3S5BcLVoA_+D@mail.gmail.com> <20110210100236.GD2305@calimero.vinschen.de> <4D53DE66.2080805@gmail.com> <20110210141515.GB25992@calimero.vinschen.de> <20110210152957.GB26842@ednor.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20110210152957.GB26842@ednor.casa.cgf.cx>
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
X-SW-Source: 2011-q1/txt/msg00046.txt.bz2

On Feb 10 10:29, Christopher Faylor wrote:
> On Thu, Feb 10, 2011 at 03:15:15PM +0100, Corinna Vinschen wrote:
> >Ok, I have just a problem.  Your patch doesn't apply because your
> >mail client appears to insert line breaks if the lines get too long.
> >Please send the patch again without the line breaks.  Maybe you could
> >just attach it to your mail rather than inlining it.
> 
> Please don't just apply it.  Some of the changes suffered from a cut/paste
> mentality, where the right solution was not always to just add a __stdcall.
> 
> The patch needs to actually be studied and probably applied piecemeal.

Ok, no worries.  If you're looking into that anyway I just drop off from
this thread.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
