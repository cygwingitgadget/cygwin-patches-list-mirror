Return-Path: <cygwin-patches-return-5764-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5655 invoked by alias); 17 Feb 2006 14:05:33 -0000
Received: (qmail 5635 invoked by uid 22791); 17 Feb 2006 14:05:31 -0000
X-Spam-Check-By: sourceware.org
Received: from ACCESS1.CIMS.NYU.EDU (HELO access1.cims.nyu.edu) (128.122.81.155)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 17 Feb 2006 14:05:28 +0000
Received: from localhost (localhost [127.0.0.1]) 	by access1.cims.nyu.edu (8.12.10+Sun/8.12.10) with ESMTP id k1HE5PA7022417; 	Fri, 17 Feb 2006 09:05:25 -0500 (EST)
Date: Fri, 17 Feb 2006 14:05:00 -0000
From: Igor Peshansky <pechtcha@cs.nyu.edu>
Reply-To: cygwin-patches@cygwin.com
To: Dave Korn <dave.korn@artimi.com>
cc: cygwin-patches@cygwin.com
Subject: RE: [PATCH] cygcheck: follow symbolic links
In-Reply-To: <00e801c633b6$3b529490$a501a8c0@CAM.ARTIMI.COM>
Message-ID: <Pine.GSO.4.63.0602170902090.1592@access1.cims.nyu.edu>
References: <00e801c633b6$3b529490$a501a8c0@CAM.ARTIMI.COM>
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
X-SW-Source: 2006-q1/txt/msg00073.txt.bz2

On Fri, 17 Feb 2006, Dave Korn wrote:

> On 16 February 2006 17:27, Igor Peshansky wrote:
>
> > On Thu, 16 Feb 2006, Corinna Vinschen wrote:
>
> >> - Couldn't you just reuse the readlink implementation in ../cygwin/path.cc
> >>   as is, to avoid having to different implementations?
> >
> > Umm, most of that code is very general purpose, and has too much extra
> > stuff in it.
>
>   I think you may have misoptimised for speed rather than
> maintainability. Cygcheck isn't something that people expect to run a
> million times per second in an inner loop.

No, but I thought ease of understanding implied maintainability...
Besides, I'm sure binutils, for one, has the code for reading chunks of
application code and finding the DLL dependencies -- why aren't we reusing
that?  The answer: too much work to extract the needed bits in the form
that would be usable in both places.

> >  I basically used part of it (symlink_info::check_shortcut)
> > for my implementation.  I wanted something lightweight and easy to
> > understand
>
>   Perhaps you could have just exported it (or a convenient interface to
> it) instead?

Ahem.  You are forgetting that cygcheck is not a Cygwin program, so we
can't introduce a dependency on cygwin1.dll.  We'd have to create an
independent (static?) library that both cygcheck and Cygwin depended on...

> >(also, the code in path.cc doesn't check for PE headers, so I
> > had to write that part anyway).
>
>   None of which affects /that/ bit.

Right, I guess...
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
