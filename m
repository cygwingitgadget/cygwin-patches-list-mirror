Return-Path: <cygwin-patches-return-5985-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7915 invoked by alias); 5 Oct 2006 17:15:12 -0000
Received: (qmail 7903 invoked by uid 22791); 5 Oct 2006 17:15:11 -0000
X-Spam-Check-By: sourceware.org
Received: from ACCESS1.CIMS.NYU.EDU (HELO access1.cims.nyu.edu) (128.122.81.155)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 05 Oct 2006 17:15:06 +0000
Received: from localhost (localhost [127.0.0.1]) 	by access1.cims.nyu.edu (8.13.6+Sun/8.13.6) with ESMTP id k95HF4qq018022 	for <cygwin-patches@cygwin.com>; Thu, 5 Oct 2006 13:15:04 -0400 (EDT)
Date: Thu, 05 Oct 2006 17:15:00 -0000
From: Igor Peshansky <pechtcha@cs.nyu.edu>
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] cygcheck: follow symbolic links
In-Reply-To: <20061005165831.GA7222@trixie.casa.cgf.cx>
Message-ID: <Pine.GSO.4.63.0610051308010.14039@access1.cims.nyu.edu>
References: <Pine.GSO.4.63.0602161116540.22053@access1.cims.nyu.edu>  <20060217113100.GT26541@calimero.vinschen.de> <Pine.GSO.4.63.0602170900350.1592@access1.cims.nyu.edu>  <Pine.GSO.4.63.0602221335110.4972@access1.cims.nyu.edu>  <20060223112956.GF4294@calimero.vinschen.de> <Pine.GSO.4.63.0602230913440.13565@access1.cims.nyu.edu>  <Pine.GSO.4.63.0607191036580.13093@access1.cims.nyu.edu>  <20060724111402.GG11991@calimero.vinschen.de> <Pine.GSO.4.63.0609280901120.15013@access1.cims.nyu.edu>  <20061005152959.GB24684@calimero.vinschen.de> <20061005165831.GA7222@trixie.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q4/txt/msg00003.txt.bz2

On Thu, 5 Oct 2006, Christopher Faylor wrote:

> On Thu, Oct 05, 2006 at 05:29:59PM +0200, Corinna Vinschen wrote:
> >On Sep 28 09:06, Igor Peshansky wrote:
> >> On Mon, 24 Jul 2006, Corinna Vinschen wrote:
> >> [...]
> >> > The latest fax was about this change, so I think this should still be
> >> > covered, shouldn't it?  Ping the guy nevertheless.  We should stay on
> >> > the safe side in legal questions.
> >> >[...]
> >> Looks like I've been remiss in following up on this, though I regenerated
> >> the patch that same day.  Attached is the new version of the patch.  I
> >> believe "the fax" (the new one) has been sent, but I've received no
> >> notification of that, presumably because Corinna is not around...
> >> 	Igor
> >
> >I didn't receive any notification either, so this somehow got stuck on
> >one side.  I'm going to check my side, would you mind to ping yours?
> >
> >As soon as that's clarified, I'll apply your patch.
>
> Didn't we resolve a while ago not to worry about assignments for
> cygcheck?  I don't see any reason to care since it is not really a core
> cygwin component - it's more of a debugging tool, and I don't see it
> as a big deal for any corporate customers.

The problem is that the copyright assignment (or, rather, the contrib
page) is phrased to cover everything under src/winsup, and thus
corporations have to disclaim copyright on the changes so that we
(individual contributors) can then follow the letter of the copyright
assignment.  If we wanted cygcheck (and other stuff in src/winsup/utils)
to not be subject to the assignment, we'd have to rewrite the assignment
and the web page to explicitly exclude it.

IOW, the assignment is already signed, and cygcheck is still covered by
the current version, so at least my employer feels safer if they disclaim
copyright explicitly.
	Igor
-- 
				http://cs.nyu.edu/~pechtcha/
      |\      _,,,---,,_	    pechtcha@cs.nyu.edu | igor@watson.ibm.com
ZZZzz /,`.-'`'    -.  ;-;;,_		Igor Peshansky, Ph.D. (name changed!)
     |,4-  ) )-,_. ,\ (  `'-'		old name: Igor Pechtchanski
    '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!

"Las! je suis sot... -Mais non, tu ne l'es pas, puisque tu t'en rends compte."
"But no -- you are no fool; you call yourself a fool, there's proof enough in
that!" -- Rostand, "Cyrano de Bergerac"
