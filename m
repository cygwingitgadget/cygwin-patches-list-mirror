Return-Path: <cygwin-patches-return-7746-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27137 invoked by alias); 22 Oct 2012 12:25:45 -0000
Received: (qmail 27078 invoked by uid 22791); 22 Oct 2012 12:25:31 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Mon, 22 Oct 2012 12:25:26 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 107E32C02AB; Mon, 22 Oct 2012 14:25:24 +0200 (CEST)
Date: Mon, 22 Oct 2012 12:25:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch]: Decouple cygwin building from in-tree mingw/w32api building
Message-ID: <20121022122524.GD2469@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1350580828.3492.73.camel@YAAKOV04> <20121019092135.GA22432@calimero.vinschen.de> <1350664438.3492.114.camel@YAAKOV04> <20121019184636.GZ25877@calimero.vinschen.de> <20121021113320.GA2469@calimero.vinschen.de> <20121021171053.GA24725@ednor.casa.cgf.cx> <1350844361.1244.54.camel@YAAKOV04> <20121022040942.GA9515@ednor.casa.cgf.cx> <20121022082913.GB2469@calimero.vinschen.de> <20121022120035.GA15284@ednor.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20121022120035.GA15284@ednor.casa.cgf.cx>
User-Agent: Mutt/1.5.21 (2010-09-15)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2012-q4/txt/msg00023.txt.bz2

On Oct 22 08:00, Christopher Faylor wrote:
> On Mon, Oct 22, 2012 at 10:29:13AM +0200, Corinna Vinschen wrote:
> >On Oct 22 00:09, Christopher Faylor wrote:
> >Yeah, since the changes to the configury separate Cygwin from mingw and
> >w32api, staying in src/winsup is no problem at all.  I always thought
> >mingw is part of the src tree for gcc bootstrap reasons.
> 
> winsup is not part of the gcc source tree in SVN.  So, if it is
> necessary for bootstrapping it must have to be pulled in separately
> anyway.
> 
> And, if we're talking about moving cygwin entirely to w64api then I
> don't see how it could be part of the gcc bootstrap.

I meant bootstrap of a mingw toolchain.  I don't know.  I just thought
this was the original reason.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
