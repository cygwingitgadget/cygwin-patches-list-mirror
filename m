Return-Path: <cygwin-patches-return-7889-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19512 invoked by alias); 23 May 2013 19:50:04 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 19497 invoked by uid 89); 23 May 2013 19:50:04 -0000
X-Spam-SWARE-Status: No, score=-1.8 required=5.0 tests=AWL,BAYES_00 autolearn=ham version=3.3.1
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.84/v0.84-167-ge50287c) with ESMTP; Thu, 23 May 2013 19:50:03 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id E319D5201EB; Thu, 23 May 2013 21:50:00 +0200 (CEST)
Date: Thu, 23 May 2013 19:50:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] DocBook XML toolchain modernization
Message-ID: <20130523195000.GC25295@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <51783EBC.30409@etr-usa.com> <20130425084305.GA29270@calimero.vinschen.de> <517F15AF.5080307@etr-usa.com> <20130430184703.GB6865@ednor.casa.cgf.cx> <51801469.9070606@etr-usa.com> <20130430190706.GC6865@ednor.casa.cgf.cx> <5181AF17.2090409@etr-usa.com> <20130523140211.GA5525@calimero.vinschen.de> <20130523141140.GB5525@calimero.vinschen.de> <519E680A.8010308@etr-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <519E680A.8010308@etr-usa.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-SW-Source: 2013-q2/txt/msg00027.txt.bz2

On May 23 13:03, Warren Young wrote:
> On 5/23/2013 08:11, Corinna Vinschen wrote:
> >On May 23 16:02, Corinna Vinschen wrote:
> >>For some reason doc/Makefile.in has lost all dependencies
> 
> I noted that in the original proposal: one of the things you got
> from doctool is automatic dependency generation.  I'd put an item on
> the Wishlist to this effect, saying I needed to replace it.
> 
> At your prompting, I now have.  There is a new script called
> xidepend which generates Makefile.dep, which is included (and
> cleaned, if asked) by Makefile.in.
> 
> It's not perfect.  Because of the time it takes to run the
> dependency chaser, I've elected to make it dependent on only changes
> to the top-level XML files.  This means that if you add an XInclude
> to one of the leaf files, the referenced file won't get added to the
> dependency list for the top-level file that indirectly depends on it
> until you remove Makefile.dep, forcing its re-generation.

That should be sufficient.  We're only adding files pretty seldom
anyway.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat
