Return-Path: <cygwin-patches-return-6836-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17774 invoked by alias); 12 Nov 2009 09:44:43 -0000
Received: (qmail 17762 invoked by uid 22791); 12 Nov 2009 09:44:42 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 12 Nov 2009 09:44:35 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 910F86D41A0; Thu, 12 Nov 2009 10:44:24 +0100 (CET)
Date: Thu, 12 Nov 2009 09:44:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] add get_nprocs, get_nprocs_conf
Message-ID: <20091112094424.GA12637@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4AFA6675.6070408@users.sourceforge.net>  <20091111094119.GA3564@calimero.vinschen.de>  <4AFA907E.1050408@users.sourceforge.net>  <4AFAB42C.1020404@byu.net>  <4AFB0042.90602@users.sourceforge.net>  <20091111202106.GA17519@ednor.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20091111202106.GA17519@ednor.casa.cgf.cx>
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
X-SW-Source: 2009-q4/txt/msg00167.txt.bz2

On Nov 11 15:21, Christopher Faylor wrote:
> On Wed, Nov 11, 2009 at 12:19:46PM -0600, Yaakov (Cygwin/X) wrote:
> >On 11/11/2009 06:55, Eric Blake wrote:
> >> +1 on the concept from me, although why does sys/sysinfo.h have to
> >> forward to cygwin/sysinfo.h, rather than directly declaring the two functions?
> >
> >I simply followed the pattern of many of the sys/*.h headers, and by 
> >their copyright dates are relatively newer, which redirected to a 
> >cygwin/*.h equivalent.  If there is supposed to be some rhyme and reason 
> >to which ones redirect and which ones do not, please feel free to clue 
> >me in. :-)
> 
> The only time I add a cygwin/foo.h is when newlib has a version of the
> same file and I don't feel like wildly ifdef'ing it.
> 
> It looks like Corinna has added a few of these so I guess she'll have
> to provide the r&r.

Erm... well... whenever I did that, "it seemed a good idea back then".
No, really, some of them were based on the decision that this is quite
Cygwin specific, like the mtio.h and rdevio.h files, some were the
result of ripping out Cygwin-specific stuff from newlib.  History is
probably as good a description as reason in many cases.  Having
low-level stuff in the cygwin subdirectory is still basically a good
idea, IMHO.

In this case I'm rather surprised that these very GNU/Linux specific
things are *not* in a linux/sysinfo.h file.  But it doesn't hurt to keep
that in line with Linux, right?


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
