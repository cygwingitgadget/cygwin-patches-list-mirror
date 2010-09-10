Return-Path: <cygwin-patches-return-7091-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16652 invoked by alias); 10 Sep 2010 18:40:06 -0000
Received: (qmail 16514 invoked by uid 22791); 10 Sep 2010 18:39:48 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Fri, 10 Sep 2010 18:39:43 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id E8EFE6D435B; Fri, 10 Sep 2010 20:39:40 +0200 (CEST)
Date: Fri, 10 Sep 2010 18:40:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Cygwin Filesystem Performance degradation 1.7.5 vs 1.7.7, and methods for improving performance
Message-ID: <20100910183940.GA14132@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4C84B9EF.9030109@gmail.com> <20100906132409.GB14327@calimero.vinschen.de> <20100910150840.GD16534@calimero.vinschen.de> <20100910172312.GA23015@ednor.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20100910172312.GA23015@ednor.casa.cgf.cx>
User-Agent: Mutt/1.5.20 (2009-06-14)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2010-q3/txt/msg00051.txt.bz2

On Sep 10 13:23, Christopher Faylor wrote:
> On Fri, Sep 10, 2010 at 05:08:40PM +0200, Corinna Vinschen wrote:
> >What I'm still mulling over is a good idea to re-use the results of a
> >former call to readdir in a stat call.  One problem here is to make sure
> >that a subsequent stat call is *really* accessing the same file as the
> >former readdir returned.
> 
> I've considered that before but you really can't cheaply determine that
> the file hasn't changed without going to the OS.  And, then it isn't cheap.

Yes, that's what it always comes down to.  That's why I'm considering to
restrict this speedup to fstatat.  I wrote more about this on the
cygwin-developers list.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
