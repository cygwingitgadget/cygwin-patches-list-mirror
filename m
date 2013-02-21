Return-Path: <cygwin-patches-return-7825-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30372 invoked by alias); 21 Feb 2013 11:16:18 -0000
Received: (qmail 30338 invoked by uid 22791); 21 Feb 2013 11:16:02 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Thu, 21 Feb 2013 11:15:47 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 13F6952030D; Thu, 21 Feb 2013 12:15:45 +0100 (CET)
Date: Thu, 21 Feb 2013 11:16:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 64bit] Export <io.h> symbols with underscore
Message-ID: <20130221111545.GA24054@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20130220151600.5983c15a@YAAKOV04> <20130221011432.GA2786@ednor.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20130221011432.GA2786@ednor.casa.cgf.cx>
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
X-SW-Source: 2013-q1/txt/msg00036.txt.bz2

On Feb 20 20:14, Christopher Faylor wrote:
> On Wed, Feb 20, 2013 at 03:16:00PM -0600, Yaakov wrote:
> >I have already encountered issues with the lack of leading-underscored
> >exports for symbols declared in <io.h>, as usage thereof often occurs
> >in shared Cygwin/Win32 conditional code, and on Win32 these are
> >underscored.  Patch attached for the two symbols I have seen so far,
> >but I wonder if I should just get it over with and add _access as well.
> >
> >
> >Yaakov
> 
> >2013-02-20  Yaakov Selkowitz  <yselkowitz@...>
> >
> >	* cygwin64.din: Restore _get_osfhandle and _setmode.
> 
> Ugh.  I've been slowly getting rid of some of those inexplicably underscored
> functions now we have to keep the converse around.  I wonder if the non-underscored
> versions can actually be deleted since they are supposed to exist in the userspace
> with an explicit underscore.

We have to make a tradeoff between backward compatibility and getting
rid of the underscored variants of ANSI function added in the early days
to provide a falsely understood compatibility with MSVCRT.

I have no problem to keep the underscored _get_osfhandle and _setmode
since these are non-standard entry points anyway, and we also have to
keep some underscored exports for newlib.  But we should not add the
MSVCRT ANSI calls back (like _access).  That was plainly wrong to begin
with.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat
