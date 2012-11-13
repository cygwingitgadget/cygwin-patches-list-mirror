Return-Path: <cygwin-patches-return-7774-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29027 invoked by alias); 13 Nov 2012 09:33:22 -0000
Received: (qmail 28977 invoked by uid 22791); 13 Nov 2012 09:33:09 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Tue, 13 Nov 2012 09:33:04 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id C044B2C00F7; Tue, 13 Nov 2012 10:33:01 +0100 (CET)
Date: Tue, 13 Nov 2012 09:33:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [WIP] mingw64 related changes to Cygwin configure and other assorted files with departed w32api/mingw
Message-ID: <20121113093301.GA23491@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20121112200223.GA16672@ednor.casa.cgf.cx> <20121112215023.GA1436@calimero.vinschen.de> <20121113000257.GA13261@ednor.casa.cgf.cx> <20121113033105.GA24866@ednor.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20121113033105.GA24866@ednor.casa.cgf.cx>
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
X-SW-Source: 2012-q4/txt/msg00051.txt.bz2

On Nov 12 22:31, Christopher Faylor wrote:
> On Mon, Nov 12, 2012 at 07:02:57PM -0500, Christopher Faylor wrote:
> >On Mon, Nov 12, 2012 at 10:50:23PM +0100, Corinna Vinschen wrote:
> >>I'm a bit puzzled about the necessity of some of the changes to source
> >>files.  Yaakov's Fedora 17 version of the headers is supposedly cut from
> >>the mingw64 trunk on 2012-10-16, while JonY's official headers have an
> >>upload date of 2012-10-18.  They should be practically identical.  Why
> >>do I not see any problems to build CVS HEAD?!?
> >
> >You can keep asking me this question but I don't really have an answer.
> >Since I don't run Fedora, I'm not going to install it to figure it out.

I just checked and there's no difference in the header files at all.
Yaakov's version == JonY's version.

> Actually, an idea came to me in the thinking room that this might be due
> to the fact that my windows headers may not be considered to be system
> headers since they aren't in a preinstalled location.  I know that gcc
> can be more lax about redefine symbols in some situations when dealing
> with system headers.  Maybe that's it.

Looks like it.  The w32api headers are system headers so -isystem rather
than -idirafter should show a better result without requiring any of the
source file changes.

Especially having to define _WIN32 in winlean.h and winsup.h looks
pretty wrong.  I would also like to keep the ifndef/define brackets in
the headers since

  #ifndef _CYGWIN_IF_H_
  #define _CYGWIN_IF_H_

can be tested for in other headers while #pragma once can not.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
