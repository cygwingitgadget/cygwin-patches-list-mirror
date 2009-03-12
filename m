Return-Path: <cygwin-patches-return-6435-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15741 invoked by alias); 12 Mar 2009 12:05:25 -0000
Received: (qmail 15691 invoked by uid 22791); 12 Mar 2009 12:05:24 -0000
X-SWARE-Spam-Status: No, hits=-2.3 required=5.0 	tests=AWL,BAYES_00,J_CHICKENPOX_52,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from qmta04.emeryville.ca.mail.comcast.net (HELO QMTA04.emeryville.ca.mail.comcast.net) (76.96.30.40)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 12 Mar 2009 12:05:11 +0000
Received: from OMTA12.emeryville.ca.mail.comcast.net ([76.96.30.44]) 	by QMTA04.emeryville.ca.mail.comcast.net with comcast 	id SBpZ1b0030x6nqcA4C5B3k; Thu, 12 Mar 2009 12:05:11 +0000
Received: from sz0059.ev.mail.comcast.net ([76.96.26.113]) 	by OMTA12.emeryville.ca.mail.comcast.net with comcast 	id SC5B1b0012SQyKw8YC5Bx9; Thu, 12 Mar 2009 12:05:11 +0000
Date: Thu, 12 Mar 2009 12:05:00 -0000
From: Eric Blake <ericblake@comcast.net>
To: cygwin-patches@cygwin.com
Message-ID: <2090434684.2733271236859510956.JavaMail.root@sz0059a.emeryville.ca.mail.comcast.net>
In-Reply-To: <20090312085748.GE14431@calimero.vinschen.de>
Subject: Re: errno.h: ESTRPIPE
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q1/txt/msg00033.txt.bz2

> > 2009-03-11  Yaakov Selkowitz <yselkowitz@users.sourceforge.net>
> > 
> > 	* errno.cc (_sys_errlist): Add ESTRPIPE.
> 
> Same question as asked by Ralf on the newlib list.
> 
> What exactly is this patch fixing?  Ok, we get a new error code, but
> what for?  It's not generated from within Cygwin, so...?

And it's not standardized, which means portable code shouldn't use it.

-- 
Eric Blake
