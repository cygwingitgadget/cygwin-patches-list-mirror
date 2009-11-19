Return-Path: <cygwin-patches-return-6846-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29347 invoked by alias); 19 Nov 2009 16:10:53 -0000
Received: (qmail 29329 invoked by uid 22791); 19 Nov 2009 16:10:51 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 19 Nov 2009 16:09:59 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id A95C06D41A0; Thu, 19 Nov 2009 17:09:48 +0100 (CET)
Date: Thu, 19 Nov 2009 16:10:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: console enhancements: mouse events
Message-ID: <20091119160948.GA1883@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <0M7Ual-1MBB3j1CFD-00whzl@mrelayeu.kundenserver.de>  <20091106101448.GA2568@calimero.vinschen.de>  <4AF73FEC.2050300@towo.net>  <20091119152632.GJ29173@calimero.vinschen.de>  <20091119160054.GB8185@ednor.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20091119160054.GB8185@ednor.casa.cgf.cx>
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
X-SW-Source: 2009-q4/txt/msg00177.txt.bz2

On Nov 19 11:00, Christopher Faylor wrote:
> On Thu, Nov 19, 2009 at 04:26:32PM +0100, Corinna Vinschen wrote:
> >Tom,
> >
> >On Nov  8 23:02, towo@towo.net wrote:
> >> Corinna Vinschen schrieb:
> >> >On Nov  6 09:20, Thomas Wolff wrote:
> >> >>Hi,
> >> >>About enhancements of cygwin console features, I've now worked
> >> >>out a patch which does the following:
> >> >
> >> >Thanks for the patch, it looks like a nice addition.
> >> >
> >> >However, there's the problem of the copyright assignment.  As described
> >> >on the http://cygwin.com/contrib.html page, in the "Before you get
> >> >started" section, we can't take non-trivial patches without have a
> >> >signed copyright assignment form (http://cygwin.com/assign.txt) in place.
> >> It's in the envelope.
> >
> >Your copyright assignment has been countersigned and we're ready to
> >go.  Could you please resend the latest version of your patch so we
> >can have another look into it?
> 
> Can we hold of on applying this until after 1.7 is released?

Yeah, maybe we really should do that for now.  Except for the
ESC9m -> ESC2m change, maybe...


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
