Return-Path: <cygwin-patches-return-7288-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11259 invoked by alias); 3 May 2011 07:57:12 -0000
Received: (qmail 11143 invoked by uid 22791); 3 May 2011 07:56:53 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Tue, 03 May 2011 07:56:38 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 85E0C2C0578; Tue,  3 May 2011 09:56:35 +0200 (CEST)
Date: Tue, 03 May 2011 07:57:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] pthread_attr_getstack{,addr}, pthread_getattr_np
Message-ID: <20110503075635.GA1451@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1304350389.6972.11.camel@YAAKOV04> <20110502201124.GA13011@ednor.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20110502201124.GA13011@ednor.casa.cgf.cx>
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
X-SW-Source: 2011-q2/txt/msg00054.txt.bz2

On May  2 16:11, Christopher Faylor wrote:
> On Mon, May 02, 2011 at 10:33:09AM -0500, Yaakov (Cygwin/X) wrote:
> >This implements pthread_attr_getstack(), pthread_attr_getstackaddr, and
> >pthread_getattr_np(), which I need for webkitgtk.
> >
> >In essence, I added a stackaddr member to pthread_attr, which is
> >accessed (slightly differently) by pthread_attr_getstack{,attr},
> >behaving just as on Linux.  The bulk of the work is to support
> >pthread_getattr_np, which provides the real attributes of the given
> >thread, including the real stack address and size.
> >
> >The pthread_attr_setstack{,addr} setters are not implemented, as I have
> >yet to find a way to set the thread stack address on Windows.  For that
> >reason I'm not defining _POSIX_THREAD_ATTR_STACKADDR, as the feature is
> >not yet (fully) implemented.
> 
> Cygwin already plays with the stack address.  It has to for situations
> when you call fork() from a thread.

Isn't that what GetThreadContext/SetThreadContext is for?

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
