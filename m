Return-Path: <cygwin-patches-return-7834-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19218 invoked by alias); 22 Feb 2013 10:03:33 -0000
Received: (qmail 18968 invoked by uid 22791); 22 Feb 2013 10:03:13 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Fri, 22 Feb 2013 10:02:57 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 41D7052030D; Fri, 22 Feb 2013 11:02:55 +0100 (CET)
Date: Fri, 22 Feb 2013 10:03:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 64bit] Export <io.h> symbols with underscore
Message-ID: <20130222100255.GA32597@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20130220151600.5983c15a@YAAKOV04> <20130221011432.GA2786@ednor.casa.cgf.cx> <20130221111545.GA24054@calimero.vinschen.de> <20130221194236.GA1163@ednor.casa.cgf.cx> <20130222001848.7049805a@YAAKOV04> <20130222065110.GA7834@ednor.casa.cgf.cx> <20130222080025.GI28458@calimero.vinschen.de> <20130222084951.GJ28458@calimero.vinschen.de> <20130222034047.778e1e12@YAAKOV04> <20130222095128.GF21700@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20130222095128.GF21700@calimero.vinschen.de>
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
X-SW-Source: 2013-q1/txt/msg00045.txt.bz2

On Feb 22 10:51, Corinna Vinschen wrote:
> On Feb 22 03:40, Yaakov wrote:
> > On Fri, 22 Feb 2013 09:49:51 +0100, Corinna Vinschen wrote:
> > > > access should go, no doubt about it.
> > > > 
> > > > For get_osfhandle and setmode I would prefer maintaining backward
> > > > compatibility with existing applications.  Both variations, with and
> > > > without underscore are definitely in use.
> > > > 
> > > > What about exporting the underscored variants only, but define the
> > > > non-underscored ones:
> > > > 
> > > >   extern long _get_osfhandle(int);
> > > >   #define get_osfhandle(i) _get_osfhandle(i)
> > > > 
> > > >   extern int _setmode (int __fd, int __mode);
> > > >   #define setmode(f,m) _setmode((f),(m))
> > > 
> > > Just to be clear:  On 32 bit we should keep the exported symbols, too.
> > > On 64 bit we can drop the non-underscored ones (which just requires
> > > to rebuild gawk for me) and only keep the defines for backward
> > > compatibility.
> > 
> > Like this?
> 
> Almost.  The _setmode needs a tweak, too.  I also think it makes
> sense to rename the functions inside of syscalls.cc:
> [...]

I applied this patch to the 64 bit branch for now.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat
