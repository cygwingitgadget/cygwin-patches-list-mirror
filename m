Return-Path: <cygwin-patches-return-6235-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4643 invoked by alias); 9 Jan 2008 08:57:26 -0000
Received: (qmail 4629 invoked by uid 22791); 9 Jan 2008 08:57:25 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Wed, 09 Jan 2008 08:57:08 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id BBAC46D4811; Wed,  9 Jan 2008 09:57:05 +0100 (CET)
Date: Wed, 09 Jan 2008 08:57:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: BLODA FAQ entry.
Message-ID: <20080109085705.GB5097@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <074301c84a42$46df85d0$2e08a8c0@CAM.ARTIMI.COM> <20071229180628.GE24999@ednor.casa.cgf.cx> <000b01c84d71$8acf6530$2e08a8c0@CAM.ARTIMI.COM> <20080102190756.GA1178@ednor.casa.cgf.cx> <000f01c84d78$23aaf5c0$2e08a8c0@CAM.ARTIMI.COM> <20080107130921.GN29568@calimero.vinschen.de> <006601c85233$d4ca0c00$2e08a8c0@CAM.ARTIMI.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <006601c85233$d4ca0c00$2e08a8c0@CAM.ARTIMI.COM>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q1/txt/msg00009.txt.bz2

On Jan  8 20:19, Dave Korn wrote:
> On 07 January 2008 13:09, Corinna Vinschen wrote:
> >  Fortunately it's quite simple by using cvs.  I don't know
> > of any hidden gotchas.  If there are any, I'd be as screwed up as
> > anybody :)
> 
>   So as far as you know we just build winsup as normal and commit the
> generated html files as new revisions over the existing ones in wwwdocs, yep?

Yep.  Usually I had to `sudo cvs up` in
/sourceware/www/sourceware/htdocs/cygwin afterwards, but for some reason
the `cvs ci' was enough this time.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
