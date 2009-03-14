Return-Path: <cygwin-patches-return-6446-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27927 invoked by alias); 14 Mar 2009 09:26:16 -0000
Received: (qmail 27917 invoked by uid 22791); 14 Mar 2009 09:26:15 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sat, 14 Mar 2009 09:26:10 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 7919A6D42ED; Sat, 14 Mar 2009 10:25:59 +0100 (CET)
Date: Sat, 14 Mar 2009 09:26:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: errno.h: ESTRPIPE
Message-ID: <20090314092559.GG9322@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <49B8A1F8.1030306@users.sourceforge.net> <20090312085748.GE14431@calimero.vinschen.de> <49B98AC4.1040202@users.sourceforge.net> <20090313103036.GA13010@calimero.vinschen.de> <49BA4D48.1030705@etr-usa.com> <20090313145026.GB11253@ednor.casa.cgf.cx> <20090313205949.GE9322@calimero.vinschen.de> <20090313214754.GB12746@ednor.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090313214754.GB12746@ednor.casa.cgf.cx>
User-Agent: Mutt/1.5.19 (2009-02-20)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q1/txt/msg00044.txt.bz2

On Mar 13 17:47, Christopher Faylor wrote:
> On Fri, Mar 13, 2009 at 09:59:49PM +0100, Corinna Vinschen wrote:
> >On Mar 13 10:50, Christopher Faylor wrote:
> >>Defining a unique value means that, if we do decide at some point to
> >>add functionality which utilizes that errno there will be no need to
> >>recompile the application.
> >
> >That's quite a good argument.  If you both think it's a good idea to
> >define this new errno, I'm fine with it, too.
> 
> I was wondering if we should add a conditionalized "#include
> <cygwin/errno.h>" to newlib's errno.h.  Then we could add things without
> littering the file with #ifdef CYGWIN's.

Actually I was going to propose the same idea yesterday when I wrote my
reply.  But then it occured to me that, *if* we add our own errno.h, we
would have to make sure that we start with our own errnos at a value way
above EOWNERDEAD so that we don't get an errno clash when new errnos are
added to newlib.  But in this case we raise the size of _sys_errlist
with empty slots for no good reason.  And the worst case, newlib adds an
errno with another value than what's defined in cygwin/errno.h.

So, if we add this errno, just stick it to newlib's sys/errno.h as in
Yaakovs original patch.

If that's ok with you I'll apply Yaakov's patch on Monday.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
