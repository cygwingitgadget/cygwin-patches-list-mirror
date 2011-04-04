Return-Path: <cygwin-patches-return-7257-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2706 invoked by alias); 4 Apr 2011 10:09:33 -0000
Received: (qmail 2673 invoked by uid 22791); 4 Apr 2011 10:09:22 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Mon, 04 Apr 2011 10:09:16 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 639F92C0313; Mon,  4 Apr 2011 12:09:13 +0200 (CEST)
Date: Mon, 04 Apr 2011 10:09:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] reorder major-0 devices (was Re: [PATCH] implement /proc/sysvipc/*)
Message-ID: <20110404100913.GM3669@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1301650256.3108.4.camel@YAAKOV04> <20110401100556.GB24008@calimero.vinschen.de> <1301687867.184.10.camel@YAAKOV04> <20110401213330.GI3669@calimero.vinschen.de> <1301867677.3104.5.camel@YAAKOV04>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1301867677.3104.5.camel@YAAKOV04>
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
X-SW-Source: 2011-q2/txt/msg00023.txt.bz2

On Apr  3 16:54, Yaakov (Cygwin/X) wrote:
> On Fri, 2011-04-01 at 23:33 +0200, Corinna Vinschen wrote:
> > On Apr  1 14:57, Yaakov (Cygwin/X) wrote:
> > > For the sake of clarity, I would reorder it a bit further to
> > > make FH_PROC and friends to one side of major-0 and everything else to
> > > the other side:
> > > 
> > >   /* begin /proc directories */
> > >   FH_PROC    = FHDEV (0, 255),
> > >   FH_REGISTRY= FHDEV (0, 254),
> > >   FH_PROCNET = FHDEV (0, 253),
> > >   FH_PROCESSFD = FHDEV (0, 252),
> > >   FH_PROCSYS = FHDEV (0, 251),
> > >   FH_PROCSYSVIPC = FHDEV (0,250),
> > > 
> > >   FH_PROC_MIN_MINOR = FHDEV (0,200),
> > >   /* end /proc directories */
> > > 
> > >   FH_PIPE    = FHDEV (0, 199),
> > >   FH_PIPER   = FHDEV (0, 198),
> > >   FH_PIPEW   = FHDEV (0, 197),
> > >   FH_FIFO    = FHDEV (0, 196),
> > >   FH_PROCESS = FHDEV (0, 195),
> > >   FH_FS      = FHDEV (0, 194),	/* filesystem based device */
> > >   FH_NETDRIVE= FHDEV (0, 193),
> > >   FH_DEV     = FHDEV (0, 192),
> > > 
> > > As either way this should be a separate changeset IMHO, I have committed
> > > my patch as is and will follow this up on Sunday.
> > 
> > Sounds ok to me.
> 
> Patch attached.
> 
> 
> Yaakov
> 

> 2011-03-04  Yaakov Selkowitz  <...>
> 	    Corinna Vinschen  <...>

Bzzz.  Please, don't quote raw email addresses, not even as part of
a patch submission.  Especially don't quote my raw email address.

> 	* devices.h (fh_devices): Define FH_PROC_MIN_MINOR.
> 	Reorder major-0 devices so that all /proc directories fall
> 	between FH_PROC and FH_PROC_MIN_MINOR.
> 	* path.h (isproc_dev): Redefine accordingly.

Looks good.  Please apply.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
