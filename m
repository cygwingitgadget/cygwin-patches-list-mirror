Return-Path: <cygwin-patches-return-6904-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19163 invoked by alias); 14 Jan 2010 09:40:51 -0000
Received: (qmail 19141 invoked by uid 22791); 14 Jan 2010 09:40:49 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 14 Jan 2010 09:40:38 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 398A26D417D; Thu, 14 Jan 2010 10:40:27 +0100 (CET)
Date: Thu, 14 Jan 2010 09:40:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: dup3/O_CLOEXEC/F_DUPFD_CLOEXEC
Message-ID: <20100114094027.GA3428@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20100113212537.GB14511@calimero.vinschen.de>  <20100113214928.GA2156@ednor.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100113214928.GA2156@ednor.casa.cgf.cx>
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
X-SW-Source: 2010-q1/txt/msg00020.txt.bz2

On Jan 13 16:49, Christopher Faylor wrote:
> On Wed, Jan 13, 2010 at 10:25:37PM +0100, Corinna Vinschen wrote:
> >Hi,
> >
> >the below patch implements the Linux dup3/O_CLOEXEC/F_DUPFD_CLOEXEC
> >extension.  I hope I didn't miss anything important since it affects
> >quite a few fhandlers.  Fortunately most is mechanical change, except
> >for a few places (dtable.cc, pipe.cc, fhandeler_fifo.cc, syscalls.cc).
> >Nevertheless, I'd be glad if somebody could have a second look into
> >this.
> >
> >Eric, you asked for it in the first place, do you have a fine testcase
> >for this functionality?
> 
> The number of times that you typed:
> 
>   sa_buf = close_on_exec ()
>               ? sec_user_nih ((PSECURITY_ATTRIBUTES) char_sa_buf, cygheap->user.sid())
>               : sec_user ((PSECURITY_ATTRIBUTES) char_sa_buf, cygheap->user.sid());
> 
> implies that this should be a macro or a function.

The combination with sec_none_nih/sec_none is used four times in
different fhandler files.  Yes, good idea, I'll create an inline
function in fhandler.h.

The above combination with sec_user_nih/sec_user is only used two times,
both in fhandler_fifo.cc.  What about an inline function in
fhandler_fifo.cc for this one?  I'll add that to the revised patch.

> Could the setting of close_on_exec be handled in the syscalls.cc open()
> so that it doesn't have to be done so many times?  You could have

Yesterday I was sure that it has to be set in the various open methods
since they could be called from elsewhere.  Today, after a nights sleep,
I'm not so sure anymore.  I don't see any call to fh->open outside of
open(2).  And calls to the open_fs() function are covered anyway.
I'll look into simplifying this.

> build_fh_name set the noexec flag so that close_on_exec() would still
> work in the fhandler_*::open functions.

I'm not sure I understand you correctly.  Do you mean build_fh_name
should already set the close_on_exec flag so that later fhandler_*::open
only have to call set_close_on_exec if a set_no_inheritance call is
required?  build_fh_name does not get a flag parameter so far.  That
would have to be added as default parameter.

For now I'll go the road to add the default close_on_exec setting to the
open(2) call.  It's easy to switch to build_fh_name from there.


Thanks for the review,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
