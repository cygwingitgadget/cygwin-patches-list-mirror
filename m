Return-Path: <cygwin-patches-return-5788-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15762 invoked by alias); 3 Mar 2006 16:10:07 -0000
Received: (qmail 15751 invoked by uid 22791); 3 Mar 2006 16:10:07 -0000
X-Spam-Check-By: sourceware.org
Received: from ACCESS1.CIMS.NYU.EDU (HELO access1.cims.nyu.edu) (128.122.81.155)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 03 Mar 2006 16:10:02 +0000
Received: from localhost (localhost [127.0.0.1]) 	by access1.cims.nyu.edu (8.12.10+Sun/8.12.10) with ESMTP id k23G9xfo011413; 	Fri, 3 Mar 2006 11:09:59 -0500 (EST)
Date: Fri, 03 Mar 2006 16:10:00 -0000
From: Igor Peshansky <pechtcha@cs.nyu.edu>
Reply-To: cygwin-patches@cygwin.com
To: Dave Korn <dave.korn@artimi.com>
cc: cygwin-patches@cygwin.com
Subject: RE: [Patch] regtool: Add load/unload commands and --binary option
In-Reply-To: <041901c63ed8$d10bb020$a501a8c0@CAM.ARTIMI.COM>
Message-ID: <Pine.GSO.4.63.0603031106010.9494@access1.cims.nyu.edu>
References: <041901c63ed8$d10bb020$a501a8c0@CAM.ARTIMI.COM>
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
X-SW-Source: 2006-q1/txt/msg00097.txt.bz2

On Fri, 3 Mar 2006, Dave Korn wrote:

> > That's actually an interesting idea.  I was always thinking along
> > the lines of using POSIX file types (plain,socket,pipe,...).
> >
> > What if a key "foo.sz" really exists and somebody wants to create
> > a registry key "foo"?
>
>   No problem.  If you want to create foo, you write to "foo.sz".  If you
> want to create foo.sz, you have to write to "foo.sz.sz".  Unless of
> course foo.sz is a dword, in which case you'd write to "foo.sz.dw", etc
> etc.
>
> > When reading "foo", which file is meant?
>
>   There can only be one at a time, because in the registry there can
> only be one value with the name foo, regardless of what type it has.
>
> > What's the order of checking suffixes?
>
>   I'm proposing that the suffix is only used when creating or writing to
> the file, to determine the type, but the suffix is stripped off for
> generating the actual name, and is not shown in dir listings, and is not
> required to open the file for read.
>
> > When somebody writes to a key "foo", what's the default suffix, er...,
> > key type?  Or does that fail with an error message?
>
>   Either; I haven't a strong opinion on the matter.

Now, what if you write a file as foo.sz, and then write it as foo.dw.  Do
we change the key type?  Do we fail with ENOENT?  What is the semantics
there?

Also, this suffix idea reminds me more of versions on VMS or streams on
NT, rather than real extensions.  I wonder if we could/should use "foo:dw"
or "foo:sz", rather than using the extension...  IOW, "foo.sz" might be a
valid filename, but "foo:sz" already cannot be on certain filesystems...
The question about using two different filetypes in a row still applies,
though.
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
