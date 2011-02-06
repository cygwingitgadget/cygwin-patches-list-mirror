Return-Path: <cygwin-patches-return-7166-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8738 invoked by alias); 6 Feb 2011 09:54:44 -0000
Received: (qmail 8701 invoked by uid 22791); 6 Feb 2011 09:54:34 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Sun, 06 Feb 2011 09:54:30 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id A9BFE2C02B8; Sun,  6 Feb 2011 10:54:23 +0100 (CET)
Date: Sun, 06 Feb 2011 09:54:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: provide __xpg_strerror_r
Message-ID: <20110206095423.GA19356@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4D4DAD40.3060904@redhat.com> <20110205202806.GA11118@ednor.casa.cgf.cx> <4D4DB682.3070601@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4D4DB682.3070601@redhat.com>
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
X-SW-Source: 2011-q1/txt/msg00021.txt.bz2

On Feb  5 13:43, Eric Blake wrote:
> On 02/05/2011 01:28 PM, Christopher Faylor wrote:
> > On Sat, Feb 05, 2011 at 01:04:16PM -0700, Eric Blake wrote:
> >> Our strerror_r is lousy (it doesn't even match glibc's behavior); see my
> >> request to the newlib list.
> > 
> > We really should just implement strerror_r in errno.cc.  It doesn't make
> > sense to have two different implementations
> 
> You mean, implement the POSIX interface for strerror_r in errno.cc, and
> ditch glibc compatibility?  But, backwards compatibility demands that we
> have two interfaces - the glibc one that returns char* for satisfying
> the link demands of existing applications, and the POSIX one that
> returns int, so we really are stuck with providing two forms of
> strerror_r if we intend to comply with POSIX.
> 
> We already provide our own strerror() (it provides a better experience
> for out-of-range values that the newlib interface), but we're currently
> using the newlib strerror_r() (in spite of its truncation flaw).
> 
> How should I rework this patch?

It would be better if we implement strerror_r locally, in two versions,
just as on Linux.  I think the best approach is to implement this in
newlib first (I replied to your mail there) and then, given that we use
the newlib string.h, copy the method over to Cygwin to match our current
strerror more closely.

Does that make sense?


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
