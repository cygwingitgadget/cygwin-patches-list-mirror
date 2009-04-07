Return-Path: <cygwin-patches-return-6499-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12706 invoked by alias); 7 Apr 2009 19:44:38 -0000
Received: (qmail 12696 invoked by uid 22791); 7 Apr 2009 19:44:37 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 07 Apr 2009 19:44:30 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 14D2A6D5597; Tue,  7 Apr 2009 21:44:02 +0200 (CEST)
Date: Tue, 07 Apr 2009 19:44:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix type inconsistencies in stdint.h
Message-ID: <20090407194402.GE852@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <49D6B8D7.4020907@gmail.com> <20090404033545.GA3386@ednor.casa.cgf.cx> <49D6DDDD.4030504@gmail.com> <20090404062459.GB22452@ednor.casa.cgf.cx> <49DB4D95.7000903@byu.net> <49DB4FC4.7020903@cwilson.fastmail.fm> <20090407131534.GY852@calimero.vinschen.de> <49DBA417.1030707@byu.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49DBA417.1030707@byu.net>
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
X-SW-Source: 2009-q2/txt/msg00041.txt.bz2

On Apr  7 13:05, Eric Blake wrote:
> According to Corinna Vinschen on 4/7/2009 7:15 AM:
> > 	* include/stdint.h (int_least32_t): Define as int.
> 
> Are there any corresponding patches needed to <inttypes.h>?  I haven't
> checked yet, but we should make absolutely sure that we are consistent
> across all uses of these types.

No.  Funny(?) enough, inttypes.h is already using printf strings
for the `int' type.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
