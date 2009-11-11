Return-Path: <cygwin-patches-return-6832-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17701 invoked by alias); 11 Nov 2009 16:23:43 -0000
Received: (qmail 17687 invoked by uid 22791); 11 Nov 2009 16:23:39 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 11 Nov 2009 16:23:36 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 863966D41A0; Wed, 11 Nov 2009 17:23:25 +0100 (CET)
Date: Wed, 11 Nov 2009 16:23:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] add get_nprocs, get_nprocs_conf
Message-ID: <20091111162325.GA7086@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4AFA6675.6070408@users.sourceforge.net>  <20091111094119.GA3564@calimero.vinschen.de>  <4AFA907E.1050408@users.sourceforge.net>  <4AFAB42C.1020404@byu.net>  <20091111151118.GA8857@ednor.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20091111151118.GA8857@ednor.casa.cgf.cx>
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
X-SW-Source: 2009-q4/txt/msg00163.txt.bz2

On Nov 11 10:11, Christopher Faylor wrote:
> On Wed, Nov 11, 2009 at 05:55:08AM -0700, Eric Blake wrote:
> >-----BEGIN PGP SIGNED MESSAGE-----
> >Hash: SHA1
> >
> >According to Yaakov (Cygwin/X) on 11/11/2009 3:22 AM:
> >> On 11/11/2009 03:41, Corinna Vinschen wrote:
> >>> Thanks, but, wouldn't it be simpler to implement them as macros in
> >>> sys/sysinfo.h?
> >> 
> >> Implementing them as macros won't help an autoconf AC_CHECK_FUNC or
> >> cmake CHECK_FUNCTION_EXISTS test.
> >
> >Also, the upcomining coreutils 8.1 will be adding nproc(1), to make
> >scripting for parallel jobs easier by exposing these functions to shell
> >users.  +1 on the concept from me, although why does sys/sysinfo.h have to
> >forward to cygwin/sysinfo.h, rather than directly declaring the two functions?
> 
> Ditto on the +1 and the question.

Indeed, Linux defines these functions directly in sys/sysinfo.h, too.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
