Return-Path: <cygwin-patches-return-6237-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19520 invoked by alias); 11 Jan 2008 09:48:07 -0000
Received: (qmail 19496 invoked by uid 22791); 11 Jan 2008 09:48:07 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Fri, 11 Jan 2008 09:47:48 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 56DD46D4811; Fri, 11 Jan 2008 10:47:45 +0100 (CET)
Date: Fri, 11 Jan 2008 09:48:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: memmem issues
Message-ID: <20080111094745.GJ5097@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <loom.20071219T210928-910@post.gmane.org> <4769E90D.5090908@byu.net> <20071220101143.GA8291@calimero.vinschen.de> <4786EEA5.1070700@byu.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4786EEA5.1070700@byu.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q1/txt/msg00011.txt.bz2

On Jan 10 21:20, Eric Blake wrote:
> According to Corinna Vinschen on 12/20/2007 3:11 AM:
> | Using one of them is certainly not a licensing violation since all code
> | examples are more or less the published examples from well-known
> | textbooks (Knuth, Sedgewick, et al.).  Given that, I don't think you're
> | actually "tainted".  An actual implementation would be much better than
> | a forlorn comment in an unimpressive file in some subdirectory.
>
> I took you up on that, and submitted an even better implementation to the
> newlib list, shared among memmem, strstr, and strcasestr
> (Knuth-Morris-Pratt and Boyer-Moore both require memory allocation, but
> not Two-Way).  If Jeff gives the go-ahead for newlib, then we'll need to
> delete cygwin's copy of memmem.cc.

Cool, thanks for doing this.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
