Return-Path: <cygwin-patches-return-7261-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32494 invoked by alias); 4 Apr 2011 12:27:12 -0000
Received: (qmail 32427 invoked by uid 22791); 4 Apr 2011 12:26:56 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Mon, 04 Apr 2011 12:26:50 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 6A2752C0313; Mon,  4 Apr 2011 14:26:47 +0200 (CEST)
Date: Mon, 04 Apr 2011 12:27:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] make <sys/sysmacros.h> compatible with glibc
Message-ID: <20110404122647.GQ3669@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1301873845.3104.26.camel@YAAKOV04> <20110403235557.GA15529@ednor.casa.cgf.cx> <1301875911.3104.39.camel@YAAKOV04> <20110404051942.GA30475@ednor.casa.cgf.cx> <20110404105430.GN3669@calimero.vinschen.de> <1301916432.3104.76.camel@YAAKOV04>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1301916432.3104.76.camel@YAAKOV04>
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
X-SW-Source: 2011-q2/txt/msg00027.txt.bz2

On Apr  4 06:27, Yaakov (Cygwin/X) wrote:
> On Mon, 2011-04-04 at 12:54 +0200, Corinna Vinschen wrote:
> > On Apr  4 01:19, Christopher Faylor wrote:
> > > I'll leave it to Corinna but I'd prefer not adding YA export if we can
> > > avoid it.
> > 
> > This is very simple code, so I, too, would prefer to keep it inline.
> 
> Alright, do I still bump CYGWIN_VERSION_API_MINOR for only inline
> functions?

No, that's not necessary.

> What about posix.sgml?

You can skip it as well.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
