Return-Path: <cygwin-patches-return-6437-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5500 invoked by alias); 13 Mar 2009 10:31:25 -0000
Received: (qmail 5490 invoked by uid 22791); 13 Mar 2009 10:31:25 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 13 Mar 2009 10:30:47 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id C57AD6D4194; Fri, 13 Mar 2009 11:30:36 +0100 (CET)
Date: Fri, 13 Mar 2009 10:31:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: errno.h: ESTRPIPE
Message-ID: <20090313103036.GA13010@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <49B8A1F8.1030306@users.sourceforge.net> <20090312085748.GE14431@calimero.vinschen.de> <49B98AC4.1040202@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49B98AC4.1040202@users.sourceforge.net>
User-Agent: Mutt/1.5.19 (2009-02-20)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q1/txt/msg00035.txt.bz2

On Mar 12 17:20, Yaakov S wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA256
> 
> Corinna Vinschen wrote:
> > What exactly is this patch fixing?  Ok, we get a new error code, but
> > what for?  It's not generated from within Cygwin, so...?
> 
> I came across a few packages that used it.  This gets us just a little
> more compatible with Linux's errno.

ESTRPIPE is returned by the Linux kernel in only one case:  If you try
to read from or write to a PCM sound device which is in suspended state.
This is very Linux device specific and this never occurs on Cygwin.
What about just defining this error code to some arbitrary value like

  #ifdef __CYGWIN__
  #define ESTRPIPE 9999
  #endif


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
