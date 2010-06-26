Return-Path: <cygwin-patches-return-7039-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8879 invoked by alias); 26 Jun 2010 10:53:20 -0000
Received: (qmail 8864 invoked by uid 22791); 26 Jun 2010 10:53:19 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Sat, 26 Jun 2010 10:53:14 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 5070A6D42F4; Sat, 26 Jun 2010 12:53:11 +0200 (CEST)
Date: Sat, 26 Jun 2010 10:53:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: doc: use xmlto pdf
Message-ID: <20100626105311.GA14520@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1277494710.9108.37.camel@YAAKOV04> <20100625211413.GA2341@calimero.vinschen.de> <1277510567.7536.18.camel@YAAKOV04>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1277510567.7536.18.camel@YAAKOV04>
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
X-SW-Source: 2010-q2/txt/msg00022.txt.bz2

On Jun 25 19:02, Yaakov S wrote:
> On Fri, 2010-06-25 at 23:14 +0200, Corinna Vinschen wrote:
> > The reason that I changed that to docbook2pdf at one point was that
> > creating a PDF from the docs never worked for me before.
> > 
> > And with your patch it also doesn't work for me on two different Linux
> > systems with different xmlto versions (0.0.18 and 0.0.23).  Here's what
> > happens on Fedora 13, the result is practically the same on the older
> > system.  Maybe you know a solution?
> 
> I was able to duplicate this on a linux VM; it appears to be a problem
> with the passivetex backend.  If I force the dblatex backend, then it
> works, but requires xmlto >= 0.0.21[1].  Could you try the attached
> patch instead?

Looks good.  I updated the older system (which happens to be my default
Cygwin build system) to xmlto 0.0.23 and everything works fine.

Please apply your patch.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
