Return-Path: <cygwin-patches-return-5698-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6184 invoked by alias); 5 Jan 2006 15:31:40 -0000
Received: (qmail 6174 invoked by uid 22791); 5 Jan 2006 15:31:40 -0000
X-Spam-Check-By: sourceware.org
Received: from SLINKY.CS.NYU.EDU (HELO slinky.cs.nyu.edu) (128.122.20.14)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 05 Jan 2006 15:31:38 +0000
Received: from localhost (localhost [127.0.0.1]) 	by slinky.cs.nyu.edu (8.12.10+Sun/8.12.10) with ESMTP id k05FVac9010280 	for <cygwin-patches@cygwin.com>; Thu, 5 Jan 2006 10:31:36 -0500 (EST)
Date: Thu, 05 Jan 2006 15:31:00 -0000
From: Igor Peshansky <pechtcha@cs.nyu.edu>
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
Subject: Re: Correctly compute whether the process is a non-Cygwin process  in spawn_guts
In-Reply-To: <20060105151226.GC32362@trixie.casa.cgf.cx>
Message-ID: <Pine.GSO.4.63.0601051028370.1754@slinky.cs.nyu.edu>
References: <Pine.GSO.4.63.0601050944160.1754@slinky.cs.nyu.edu>  <20060105151226.GC32362@trixie.casa.cgf.cx>
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
X-SW-Source: 2006-q1/txt/msg00007.txt.bz2

On Thu, 5 Jan 2006, Christopher Faylor wrote:

> On Thu, Jan 05, 2006 at 09:46:46AM -0500, Igor Peshansky wrote:
> >The attached patch fixes the "no output from commands invoked through
> >ssh" for me.  The ChangeLog is below.
> >	Igor
> >==============================================================================
> >2006-01-05  Igor Peshansky  <pechtcha@cs.nyu.edu>
> >
> >	* spawn.cc (spawn_guts): Invert the argument to
> >	set_console_state_for_spawn.
>
> Did you happen to notice the name of the argument to
> "set_console_state_for_spawn"?

Yes, I did.  It's supposed to be true for a non-Cygwin process and false
for a Cygwin process.  IIUC, my patch makes it so.

> Sorry, but this seems to be a "fix the symptom" patch.
>
> Apparently iscygexec is getting set incorrectly.  That is probably the
> problem.

I may be misunderstanding what iscygexec() does.  I thought it was true if
the process was a Cygwin process, in which case my patch actually fixes
the problem, not the symptom...
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
