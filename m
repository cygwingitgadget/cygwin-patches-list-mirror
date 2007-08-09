Return-Path: <cygwin-patches-return-6133-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25476 invoked by alias); 9 Aug 2007 18:10:37 -0000
Received: (qmail 25293 invoked by uid 22791); 9 Aug 2007 18:10:35 -0000
X-Spam-Check-By: sourceware.org
Received: from ACCESS1.CIMS.NYU.EDU (HELO access1.cims.nyu.edu) (128.122.81.155)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 09 Aug 2007 18:10:31 +0000
Received: from localhost (localhost [127.0.0.1]) 	by access1.cims.nyu.edu (8.13.8+Sun/8.13.8) with ESMTP id l79IATcj014205; 	Thu, 9 Aug 2007 14:10:29 -0400 (EDT)
Date: Thu, 09 Aug 2007 18:10:00 -0000
From: Igor Peshansky <pechtcha@cs.nyu.edu>
Reply-To: cygwin-patches@cygwin.com
To: Ernie Coskrey <Ernie.Coskrey@steeleye.com>
cc: cygwin-patches@cygwin.com
Subject: RE: Signal handler not executed
In-Reply-To: <76087731258D2545B1016BB958F00ADA123A4F@STEELPO.steeleye.com>
Message-ID: <Pine.GSO.4.63.0708091407120.26517@access1.cims.nyu.edu>
References: <76087731258D2545B1016BB958F00ADA123A4F@STEELPO.steeleye.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q3/txt/msg00008.txt.bz2

On Thu, 9 Aug 2007, Ernie Coskrey wrote:

> > -----Original Message-----
> > From: cygwin-patches-owner@XXXXXX.XXX
> > [mailto:cygwin-patches-owner@XXXXXX.XXX] On Behalf Of Christopher Faylor
> > Sent: Thursday, August 09, 2007 1:19 PM
> > To: cygwin-patches@XXXXXX.XXX

<http://cygwin.com/acronyms/#PCYMTNQREAIYR>.  Thanks.

> > Subject: Re: Signal handler not executed
> >
> > On Thu, Aug 09, 2007 at 01:09:48PM -0400, Ernie Coskrey wrote:
> > >There's a very small window of vulnerability in _sigbe,
> > which can lead
> > >to signal handlers not being executed.  In _sigbe, the
> > _cygtls lock is
> > >released before incyg is decremented.  If setup_handler acquires the
> > >lock just after _sigbe releases it, but before incyg is decremented,
> > >setup_handler will mistakenly believe that the thread is in Cygwin
> > >code, and will set up the interrupt using the tls stack.
> > >
> > >_sigbe should decrement incyg before releasing the lock.
> >
> > I'll apply this but are you saying that this actually fixes
> > your problem or that you think it fixes your problem?
> >
> > Thanks for the patch.
>
> It's hard to say definitively that it fixes the problem, since the
> problem is so hard to reproduce.  I've been running stress scripts for
> three days on six different systems, and haven't seen it occur.  But I
> feel pretty sure that this fixes it - it certainly matches the symptoms
> we see when we do happen to encounter the problem.

Ernie, I just wanted to say thanks for tracking this down.  Nice bit of
detective work.  I'm somewhat relieved that the problem was not with pdksh
code.  If it were in my power, I'd give out a gold star for this. :-)
	Igor
-- 
				http://cs.nyu.edu/~pechtcha/
      |\      _,,,---,,_	    pechtcha@cs.nyu.edu | igor@watson.ibm.com
ZZZzz /,`.-'`'    -.  ;-;;,_		Igor Peshansky, Ph.D. (name changed!)
     |,4-  ) )-,_. ,\ (  `'-'		old name: Igor Pechtchanski
    '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!

Belief can be manipulated.  Only knowledge is dangerous.  -- Frank Herbert
