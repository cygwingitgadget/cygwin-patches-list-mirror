Return-Path: <cygwin-patches-return-6990-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13193 invoked by alias); 26 Feb 2010 15:52:58 -0000
Received: (qmail 13154 invoked by uid 22791); 26 Feb 2010 15:52:56 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Fri, 26 Feb 2010 15:52:52 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id F30D46D42F5; Fri, 26 Feb 2010 16:52:49 +0100 (CET)
Date: Fri, 26 Feb 2010 15:52:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] define SIGPWR
Message-ID: <20100226155249.GA5683@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4B875901.6010906@users.sourceforge.net>  <20100226052655.GA22741@ednor.casa.cgf.cx>  <4B87616D.7050602@users.sourceforge.net>  <4B876413.8040800@users.sourceforge.net>  <20100226092035.GB8489@calimero.vinschen.de>  <4B8796E6.5010202@users.sourceforge.net>  <20100226100417.GY5683@calimero.vinschen.de>  <4B87A77B.2010704@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4B87A77B.2010704@users.sourceforge.net>
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
X-SW-Source: 2010-q1/txt/msg00106.txt.bz2

On Feb 26 04:50, Yaakov S wrote:
> On 2010-02-26 04:04, Corinna Vinschen wrote:
> >Replace SIGLOST with SIGPWR, add SIGLOST as parenthetical note to SIGPWR,
> >add SIGIO an SIGCLD.
> >
> >No, really, whatever you think is best.  Documentation is hell and
> >there can never be enough anyway.
> 
> Yeah, I know the feeling.  I went ahead and added all three.

Thank you!

Btw., I fixed the copyright date and a minor formatting issue in
strsig.cc.  The copyright date is one of those pesky things you almost
never think of in time.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
