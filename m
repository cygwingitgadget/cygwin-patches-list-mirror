Return-Path: <cygwin-patches-return-7776-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2005 invoked by alias); 13 Nov 2012 18:19:32 -0000
Received: (qmail 1974 invoked by uid 22791); 13 Nov 2012 18:19:19 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Tue, 13 Nov 2012 18:19:12 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id EC7BA2C00C3; Tue, 13 Nov 2012 19:19:08 +0100 (CET)
Date: Tue, 13 Nov 2012 18:19:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [WIP] mingw64 related changes to Cygwin configure and other assorted files with departed w32api/mingw
Message-ID: <20121113181908.GA27964@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20121112200223.GA16672@ednor.casa.cgf.cx> <20121112215023.GA1436@calimero.vinschen.de> <20121113000257.GA13261@ednor.casa.cgf.cx> <20121113033105.GA24866@ednor.casa.cgf.cx> <20121113093301.GA23491@calimero.vinschen.de> <20121113173900.GA13846@ednor.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20121113173900.GA13846@ednor.casa.cgf.cx>
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
X-SW-Source: 2012-q4/txt/msg00053.txt.bz2

On Nov 13 12:39, Christopher Faylor wrote:
> On Tue, Nov 13, 2012 at 10:33:01AM +0100, Corinna Vinschen wrote:
> >I would also like to keep the ifndef/define brackets in
> >the headers since
> >
> >  #ifndef _CYGWIN_IF_H_
> >  #define _CYGWIN_IF_H_
> >
> >can be tested for in other headers while #pragma once can not.
> 
> I think that testing for "BLAH_DECLARED" for individual definitions is a
> much better way to see if something is defined than relying on an
> implementation detail like "_CYGWIN_IF_H".

Sure.

This might not be of much interest for the headers in the include/cygwin
subdir, but there are applications out there which test for such header
defines, and there are also applications using system-specific headers
liberally.  Out of curiosity I had a look and none of the Linux/glibc
headers seem to use #pragma once either for some reason.

An alternative might be something like

  #pragma once
  #define _CYGWIN_IF_H_

It would introduce the new pragma and keep the definition available.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
