Return-Path: <cygwin-patches-return-7241-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26687 invoked by alias); 1 Apr 2011 21:33:52 -0000
Received: (qmail 26669 invoked by uid 22791); 1 Apr 2011 21:33:40 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Fri, 01 Apr 2011 21:33:33 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 9095E2C0303; Fri,  1 Apr 2011 23:33:30 +0200 (CEST)
Date: Fri, 01 Apr 2011 21:33:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] implement /proc/sysvipc/*
Message-ID: <20110401213330.GI3669@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1301650256.3108.4.camel@YAAKOV04> <20110401100556.GB24008@calimero.vinschen.de> <1301687867.184.10.camel@YAAKOV04>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1301687867.184.10.camel@YAAKOV04>
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
X-SW-Source: 2011-q2/txt/msg00007.txt.bz2

On Apr  1 14:57, Yaakov (Cygwin/X) wrote:
> On Fri, 2011-04-01 at 12:05 +0200, Corinna Vinschen wrote:
> > Chris, do you think there's anything speaking against rearranging this
> > so that the FH_FS and FH_NETDRIVE definitions are separate from the
> > stuff under /proc?  Or, hang on, we should change all PROC values,
> > along these lines:
> > 
> >   FH_FS      = FHDEV (0, 247),  /* filesystem based device */
> >   FH_NETDRIVE= FHDEV (0, 246),
> >   FH_DEV     = FHDEV (0, 245),
> > 
> >   FH_PROC    = FHDEV (0, 244),
> >   FH_REGISTRY= FHDEV (0, 243),
> >   FH_PROCESS = FHDEV (0, 242),
> >   FH_PROCNET = FHDEV (0, 241),
> >   FH_PROCESSFD = FHDEV (0, 240),
> >   FH_PROCSYS = FHDEV (0, 239),
> >   FH_PROCSYSVIPC = FHDEV (0, 238),
> > 
> >   FH_PROC_MIN_MINOR = FHDEV (0, 200),	/* Arbitrary value */
> > 
> > Then we can simplify the isproc_dev definition like this:
> > 
> > #define isproc_dev(devn) \
> > 	(devn >= FH_PROC_MIN_MINOR && devn <= FH_PROC)
> > 
> > Does that sound ok?
> 
> That would mean that the /proc directories range would be right in the
> middle of the major-device-0 range, with non-/proc stuff before and
> after.  For the sake of clarity, I would reorder it a bit further to
> make FH_PROC and friends to one side of major-0 and everything else to
> the other side:
> 
>   /* begin /proc directories */
>   FH_PROC    = FHDEV (0, 255),
>   FH_REGISTRY= FHDEV (0, 254),
>   FH_PROCNET = FHDEV (0, 253),
>   FH_PROCESSFD = FHDEV (0, 252),
>   FH_PROCSYS = FHDEV (0, 251),
>   FH_PROCSYSVIPC = FHDEV (0,250),
> 
>   FH_PROC_MIN_MINOR = FHDEV (0,200),
>   /* end /proc directories */
> 
>   FH_PIPE    = FHDEV (0, 199),
>   FH_PIPER   = FHDEV (0, 198),
>   FH_PIPEW   = FHDEV (0, 197),
>   FH_FIFO    = FHDEV (0, 196),
>   FH_PROCESS = FHDEV (0, 195),
>   FH_FS      = FHDEV (0, 194),	/* filesystem based device */
>   FH_NETDRIVE= FHDEV (0, 193),
>   FH_DEV     = FHDEV (0, 192),
> 
> As either way this should be a separate changeset IMHO, I have committed
> my patch as is and will follow this up on Sunday.

Sounds ok to me.

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
