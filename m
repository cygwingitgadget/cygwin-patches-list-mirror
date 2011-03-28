Return-Path: <cygwin-patches-return-7213-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20927 invoked by alias); 28 Mar 2011 19:44:31 -0000
Received: (qmail 20883 invoked by uid 22791); 28 Mar 2011 19:44:17 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Mon, 28 Mar 2011 19:44:09 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 2C4482C03C6; Mon, 28 Mar 2011 21:44:05 +0200 (CEST)
Date: Mon, 28 Mar 2011 19:44:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Export strchrnul (pending newlib patch)
Message-ID: <20110328194405.GC15349@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1301283496.5408.8.camel@YAAKOV04> <20110328144842.GA3774@ednor.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20110328144842.GA3774@ednor.casa.cgf.cx>
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
X-SW-Source: 2011-q1/txt/msg00068.txt.bz2

On Mar 28 10:48, Christopher Faylor wrote:
> On Sun, Mar 27, 2011 at 10:38:16PM -0500, Yaakov (Cygwin/X) wrote:
> >Here's the Cygwin patch to export strchrnul(3) once accepted in newlib.
> 
> Cygwin already has an implementation of this named strechr written in
> assembly language.  Maybe we should be exporting that.

Yeah, we could do that.  We could keep strechr as inline implementation
in string.h and copy it over to strfunc.cc as exportable non-inline
function strchrnul.

Is our strechr really faster than an implementation which uses the
word-wise pattern matching optimization?  At least as far as the
matching case is concerned.  It will likely be faster in the
non-matching case.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
