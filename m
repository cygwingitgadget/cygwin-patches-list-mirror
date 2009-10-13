Return-Path: <cygwin-patches-return-6763-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3355 invoked by alias); 13 Oct 2009 12:18:07 -0000
Received: (qmail 3344 invoked by uid 22791); 13 Oct 2009 12:18:06 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 13 Oct 2009 12:18:03 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 334066D55B9; Tue, 13 Oct 2009 14:17:52 +0200 (CEST)
Date: Tue, 13 Oct 2009 12:18:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Allow to disable root privileges with CYGWIN=noroot
Message-ID: <20091013121752.GA9571@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20090901183209.GA14650@calimero.vinschen.de> <20091004123006.GF4563@calimero.vinschen.de> <20091004125455.GG4563@calimero.vinschen.de> <4AC8F299.1020303@t-online.de> <20091004195723.GH4563@calimero.vinschen.de> <20091004200843.GK4563@calimero.vinschen.de> <4ACFAE4D.90502@t-online.de> <20091010100831.GA13581@calimero.vinschen.de> <4AD243ED.6080505@t-online.de> <4AD46C1F.7080902@byu.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4AD46C1F.7080902@byu.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q4/txt/msg00094.txt.bz2

On Oct 13 06:01, Eric Blake wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> According to Christian Franke on 10/11/2009 2:45 PM:
> > 2009-10-11  Christian Franke  <franke@computer.org>
> >            Corinna Vinschen  <corinna@vinschen.de>
> > 
> >     * include/sys/cygwin.h: Add new cygwin_getinfo_type
> >     CW_SET_EXTERNAL_TOKEN.
> >     Add new enum CW_TOKEN_IMPERSONATION, CW_TOKEN_RESTRICTED.
> 
> Shouldn't we also bump version.h when adding new CW_ flags?

You're right.  Done in CVS.

> > +      case CW_SET_EXTERNAL_TOKEN:
> > +	{
> > +	  HANDLE token = va_arg (arg, HANDLE);
> > +	  int type = va_arg (arg, int);
> > +	  set_imp_token (token, type);
> > +	  return 0;
> > +	}
> 
> Not the first time this is done in this function.  But generally,
> shouldn't we follow the good practice of using va_end any time we used
> va_arg, in case cygwin is ever ported to a system where va_end is more
> than a no-op?  [At least, I'm assuming that __builtin_va_end() is a no-op
> for x86?]

That's probably a good idea, given that POSIX requires the usage of
va_end.  PTC?


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
