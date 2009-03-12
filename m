Return-Path: <cygwin-patches-return-6434-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25040 invoked by alias); 12 Mar 2009 08:58:07 -0000
Received: (qmail 25029 invoked by uid 22791); 12 Mar 2009 08:58:07 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 12 Mar 2009 08:57:59 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 674E36D42ED; Thu, 12 Mar 2009 09:57:48 +0100 (CET)
Date: Thu, 12 Mar 2009 08:58:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: errno.h: ESTRPIPE
Message-ID: <20090312085748.GE14431@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <49B8A1F8.1030306@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49B8A1F8.1030306@users.sourceforge.net>
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
X-SW-Source: 2009-q1/txt/msg00032.txt.bz2

On Mar 12 00:47, Yaakov S wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA256
> 
> Corresponding patch just sent to newlib@.
> 
> 2009-03-11  Yaakov Selkowitz <yselkowitz@users.sourceforge.net>
> 
> 	* errno.cc (_sys_errlist): Add ESTRPIPE.

Same question as asked by Ralf on the newlib list.

What exactly is this patch fixing?  Ok, we get a new error code, but
what for?  It's not generated from within Cygwin, so...?


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
