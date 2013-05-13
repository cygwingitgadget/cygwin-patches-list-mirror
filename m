Return-Path: <cygwin-patches-return-7884-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25724 invoked by alias); 13 May 2013 14:25:17 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 25698 invoked by uid 89); 13 May 2013 14:25:17 -0000
X-Spam-SWARE-Status: No, score=-1.8 required=5.0 tests=AWL,BAYES_00 autolearn=ham version=3.3.1
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.84/v0.84-167-ge50287c) with ESMTP; Mon, 13 May 2013 14:25:16 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id DC4055201ED; Mon, 13 May 2013 16:25:13 +0200 (CEST)
Date: Mon, 13 May 2013 14:25:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] DocBook XML toolchain modernization
Message-ID: <20130513142513.GA9456@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <51782505.5020502@etr-usa.com> <20130424185210.GE26397@calimero.vinschen.de> <51783EBC.30409@etr-usa.com> <20130425084305.GA29270@calimero.vinschen.de> <517F15AF.5080307@etr-usa.com> <20130430184703.GB6865@ednor.casa.cgf.cx> <51801469.9070606@etr-usa.com> <20130430190706.GC6865@ednor.casa.cgf.cx> <51802510.5000803@etr-usa.com> <20130430202737.GA1858@ednor.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20130430202737.GA1858@ednor.casa.cgf.cx>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-SW-Source: 2013-q2/txt/msg00022.txt.bz2

On Apr 30 16:27, Christopher Faylor wrote:
> On Tue, Apr 30, 2013 at 02:09:52PM -0600, Warren Young wrote:
> >- Do you want me to do the proposed doctool to Doxygen conversion, so we 
> >can get rid of doctool?
> 
> This was something that Corinna wanted so I can't comment but since she
> asked you to be the maintainer, I'd say that whatever you want is
> acceptable as long as we still have a readable FAQ.

...and as long as we still have a writable FAQ ;)

What we have now looks good to me.  It builds fine on Linux outside
the source tree and the files, albeit calld *.xml now, still have this
cosy sgml feeling to them :)


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat
