Return-Path: <cygwin-patches-return-5795-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30445 invoked by alias); 3 Mar 2006 22:09:56 -0000
Received: (qmail 30431 invoked by uid 22791); 3 Mar 2006 22:09:55 -0000
X-Spam-Check-By: sourceware.org
Received: from ACCESS1.CIMS.NYU.EDU (HELO access1.cims.nyu.edu) (128.122.81.155)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 03 Mar 2006 22:09:53 +0000
Received: from localhost (localhost [127.0.0.1]) 	by access1.cims.nyu.edu (8.12.10+Sun/8.12.10) with ESMTP id k23M9nfo017489; 	Fri, 3 Mar 2006 17:09:50 -0500 (EST)
Date: Fri, 03 Mar 2006 22:09:00 -0000
From: Igor Peshansky <pechtcha@cs.nyu.edu>
Reply-To: cygwin-patches@cygwin.com
To: Dave Korn <dave.korn@artimi.com>
cc: cygwin-patches@cygwin.com
Subject: RE: [Patch] regtool: Add load/unload commands and --binary option
In-Reply-To: <042501c63ee0$b990d170$a501a8c0@CAM.ARTIMI.COM>
Message-ID: <Pine.GSO.4.63.0603031642240.11990@access1.cims.nyu.edu>
References: <042501c63ee0$b990d170$a501a8c0@CAM.ARTIMI.COM>
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
X-SW-Source: 2006-q1/txt/msg00104.txt.bz2

On Fri, 3 Mar 2006, Dave Korn wrote:

> On 03 March 2006 16:02, Igor Peshansky wrote:
>
> >> I'm not quite sure how to handle the mapping from file types to
> >> registry key types, but there might be some simple way which I'm just
> >> too blind to see.
> >
> > Hmm, there is currently no way for the programs to find out the
> > registry key type, unless we introduce new functionality into stat()
> > or something.
> >
> > As it is, why would the programs need to know the key type, anyway?
>
>   Because they aren't writing it for their own benefit, but in order for
> it to be read by some other app that requires it to be of a specific
> type.
>
> > They just write the data, and fhandler_registry takes care of
> > converting it to the right format (using arbirtary conventions of some
> > sort).  The only potential problems are REG_MULTI_SZ and REG_EXPAND_SZ
> > (in the former case it's a question of picking a string delimiter, and
> > in the latter it's about annotating expandable values).
> >
> > Am I missing something?
>
>   You're thinking of the registry as some place where a program puts its
> own private data and reads it back and therefore assuming that it
> doesn't matter what actually is /in/ the registry as long as the program
> gets back the exact same stuff it put in there, but sometimes programs
> want to alter or set registry values for external apps that require a
> specific type.  If cygwin chose a type and didn't provide a way to
> specify, this feature would be of much more limited use as you couldn't
> use it to modify an existing value because cygwin might decide to write
> it back as a different type and break whatever-it-was that depended on
> it.

Actually, I did think of registry as shared data, but I also assumed that
the creation of value files would be separate from writing to them, and
that the actual writing would not change the type.

That still might not be a bad approach -- maybe introduce extra,
registry-specific, flags for open() that reflect the file (i.e, key) type,
and then implement writes to the files based on those flags...  Just
another alternative to consider...
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
