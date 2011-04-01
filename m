Return-Path: <cygwin-patches-return-7239-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 762 invoked by alias); 1 Apr 2011 15:59:34 -0000
Received: (qmail 724 invoked by uid 22791); 1 Apr 2011 15:59:22 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Fri, 01 Apr 2011 15:59:16 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id D09162C0302; Fri,  1 Apr 2011 17:59:13 +0200 (CEST)
Date: Fri, 01 Apr 2011 15:59:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] implement /proc/sysvipc/*
Message-ID: <20110401155913.GD3669@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1301650256.3108.4.camel@YAAKOV04> <20110401100556.GB24008@calimero.vinschen.de> <20110401153413.GB6604@ednor.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20110401153413.GB6604@ednor.casa.cgf.cx>
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
X-SW-Source: 2011-q2/txt/msg00005.txt.bz2

On Apr  1 11:34, Christopher Faylor wrote:
> On Fri, Apr 01, 2011 at 12:05:56PM +0200, Corinna Vinschen wrote:
> >Chris, do you think there's anything speaking against rearranging this
> >so that the FH_FS and FH_NETDRIVE definitions are separate from the
> >stuff under /proc?  Or, hang on, we should change all PROC values,
> >along these lines:
> >
> >  FH_FS      = FHDEV (0, 247),  /* filesystem based device */
> >  FH_NETDRIVE= FHDEV (0, 246),
> >  FH_DEV     = FHDEV (0, 245),
> >
> >  FH_PROC    = FHDEV (0, 244),
> >  FH_REGISTRY= FHDEV (0, 243),
> >  FH_PROCESS = FHDEV (0, 242),
> >  FH_PROCNET = FHDEV (0, 241),
> >  FH_PROCESSFD = FHDEV (0, 240),
> >  FH_PROCSYS = FHDEV (0, 239),
> >  FH_PROCSYSVIPC = FHDEV (0, 238),
> >
> >  FH_PROC_MIN_MINOR = FHDEV (0, 200),	/* Arbitrary value */
> >
> >Then we can simplify the isproc_dev definition like this:
> >
> >#define isproc_dev(devn) \
> >	(devn >= FH_PROC_MIN_MINOR && devn <= FH_PROC)
> >
> >Does that sound ok?
> 
> Yes.  I was, for a while, trying to keep the device numbers the same as
> Linux but I don't think that even applies in this case.

Cool, thanks.

Yaakov, would you mind to apply youir patch with this change?


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
