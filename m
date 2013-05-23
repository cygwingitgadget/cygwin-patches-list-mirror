Return-Path: <cygwin-patches-return-7886-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26691 invoked by alias); 23 May 2013 14:02:16 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 26328 invoked by uid 89); 23 May 2013 14:02:14 -0000
X-Spam-SWARE-Status: No, score=-1.8 required=5.0 tests=AWL,BAYES_00 autolearn=ham version=3.3.1
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.84/v0.84-167-ge50287c) with ESMTP; Thu, 23 May 2013 14:02:13 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 3CECB5201EB; Thu, 23 May 2013 16:02:11 +0200 (CEST)
Date: Thu, 23 May 2013 14:02:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] DocBook XML toolchain modernization
Message-ID: <20130523140211.GA5525@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20130424172039.GA27256@calimero.vinschen.de> <51782505.5020502@etr-usa.com> <20130424185210.GE26397@calimero.vinschen.de> <51783EBC.30409@etr-usa.com> <20130425084305.GA29270@calimero.vinschen.de> <517F15AF.5080307@etr-usa.com> <20130430184703.GB6865@ednor.casa.cgf.cx> <51801469.9070606@etr-usa.com> <20130430190706.GC6865@ednor.casa.cgf.cx> <5181AF17.2090409@etr-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5181AF17.2090409@etr-usa.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-SW-Source: 2013-q2/txt/msg00024.txt.bz2

Hi Warren,

On May  1 18:11, Warren Young wrote:
> On 4/30/2013 13:07, Christopher Faylor wrote:
> >On Tue, Apr 30, 2013 at 12:58:49PM -0600, Warren Young wrote:
> >
> >>Do you mean for me to check these changes in when I get my sourceware
> >>account?
> >
> >Yes, with the implied assumption that you won't be breaking anything.
> 
> Applied.
> 
> It all seems to build the same as before, even after 'make clean'.

Note quite, as I just found while writing new documentation.  For some
reason doc/Makefile.in has lost all dependencies to the .xml source
files as far as cygwin-ug-net and cygwin-api is concerned.  There's a

  faq/faq.html : $(FAQ_SOURCES)

dependency but no such depedency for the other files.  So, if I just
built the docs, then change, say, pathnames.xml, or cygwinenv.xml,
another `make' will do nothing:

  $ make
  make: Nothing to be done for `all'.

Can you fix that, please?


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat
