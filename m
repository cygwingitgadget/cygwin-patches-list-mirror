Return-Path: <cygwin-patches-return-7604-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16913 invoked by alias); 24 Feb 2012 12:18:49 -0000
Received: (qmail 16864 invoked by uid 22791); 24 Feb 2012 12:18:24 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Fri, 24 Feb 2012 12:18:11 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 837152C006D; Fri, 24 Feb 2012 13:18:08 +0100 (CET)
Date: Fri, 24 Feb 2012 12:18:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Add pthread_getname_np, pthread_setname_np
Message-ID: <20120224121808.GG17797@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1330054695.6828.15.camel@YAAKOV04> <20120224093809.GA20683@calimero.vinschen.de> <1330081241.6260.3.camel@YAAKOV04>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1330081241.6260.3.camel@YAAKOV04>
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
X-SW-Source: 2012-q1/txt/msg00027.txt.bz2

On Feb 24 05:00, Yaakov (Cygwin/X) wrote:
> On Fri, 2012-02-24 at 10:38 +0100, Corinna Vinschen wrote:
> > On Feb 23 21:38, Yaakov (Cygwin/X) wrote:
> > > This patchset adds pthread_getname_np and pthread_setname_np.  These
> > > were added to glibc in 2.12[1] and are also present in some form on
> > > NetBSD and several UNIXes.  IIUC recent versions of GDB can benefit from
> > > this support.
> > 
> > Thanks for your patch, but I don't think it's the whole thing.
> > 
> > Consider, if you implement pthread_[gs]etname_np as you did, then you
> > have pthread names which are only available to the process in which
> > the threads are running.
> 
> My implementation is based on NetBSD's[1].  So what purpose do these
> functions serve then on that it and the UNIXes?  (Serious question.)

See the source of the pthread_setname_np function.  There's a call to
the kernel:

  thread->pt_name = cp;
  (void)_lwp_setname(thread->pt_lid, cp);

_lwp_setname ultimately calls the kernel function sys__lwp_setname in
http://cvsweb.netbsd.org/bsdweb.cgi/src/sys/kern/sys_lwp.c?rev=1.53
So the kernel knows the name and the sys__lwp_getname entry point
can be used to fetch the name of a thread in another process.  How
exactly this is fetched by which BSD tool, I don't know, but it's
all in the sources :)


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
