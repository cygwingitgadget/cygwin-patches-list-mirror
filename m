Return-Path: <cygwin-patches-return-4081-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21154 invoked by alias); 13 Aug 2003 17:04:19 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 21132 invoked from network); 13 Aug 2003 17:04:17 -0000
Date: Wed, 13 Aug 2003 17:04:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Questions and a RFC [was Re: Assignment from Nicholas Wourms arrived]
Message-ID: <20030813170416.GG3101@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20030812191411.GH17051@cygbert.vinschen.de> <3F39704F.6030001@netscape.net> <20030813113509.GA24855@cygbert.vinschen.de> <3F3A5CE4.10004@netscape.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F3A5CE4.10004@netscape.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00097.txt.bz2

On Wed, Aug 13, 2003 at 11:44:36AM -0400, Nicholas Wourms wrote:
> cygwin-patches@cygwin.com wrote:
> >What are you trying to implement?  If you need lstat, you're perhaps better
> >off implementing this in Cygwin instead of newlib.
> 
> ftw/nftw.  Per Gerrit's suggestion on the list, I looked at OpenBSD's 
> version of ftw/nftw they did for the US DOD.  IMHO, it looks the be the 
> most robust compared to the other Non-GPL'ed versions floating around. 
> I suppose one could write it from scratch, but if a reasonable 
> implementation exists, why bother?  Of course to the next point...
> 
> Perhaps it doesn't belong in newlib, as it isn't terribly portable in 
> it's current state.  I basically had to disgorge a bunch of extra code 
> code which was targeted at platforms with a more robust(mature?) 
> opendir().  However, I suppose I could just #if 0 it, and leave it to 
> the linux/ELIX people to fix up the parts which apply to them [1].

Putting ftw into newlib is of course a good way to get rid of the GPL'd
version of ftw and ftw64 in libc/sys/linux.  But it's more work.  You
would have to provide 32 and 64 bit versions as in newlib and I doubt
you will get approval if the function isn't portable enough.

OTOH, I ripped all Cygwin-only code from newlib and moved it into the
cygwin dir a while ago, so if you create a Cygwin-only version of ftw,
you should put it into Cygwin itself.  The advantage would be that you
only have to care for a 64 bit version.

>   Speaking of aliases, about this time last year, 
> Conrad and I were debating the reasoning behind the underscore aliases 
> in cygwin.din.  I speculated that they might be a work around for 
> elf-centric configuration programs which look for weak versions of the 
> symbols (which indeed seems to be the case for argz & the configure 
> found in binutils/gcc/gdb).  He thought that it had something to do with 
> MSVC compatibility.  However, it seems that people have since stopped 
> doing this.  Out of curiosity, what was the history behind doing this? 

Newlib calls all sysfuncs with leading underscore (_open, _close, etc)
since it provides the API versions (open, close) by itself, typically.
Some of the other functions might (dunno, really) be underscored for
msvcrt.dll compatibility.  Actually I guess that most of the other
_foo=foo bla just has been added since "we did it always this way".
In theory it's unnecessary to declare an underscore alias of a function
if newlib never accesses it.  The API defines them w/o underscore so
that should be sufficient.  But we will keep the existing ones in
cygwin.din for backward compatibility, of course.

> For future contributions, what is the official policy on doing it now?

Basically don't add an underscore alias.  Create an underscore alias if
the function is used by newlib.  Or, create an underscore alias if it's
e.g. available in Linux or BSD, which might happen (mempcpy comes to mind).  

> suppose you can be the judge of where it belongs :-D.  I think, though, 
> that I'll wait until post-1.5.x to do this, as it seems to be the 
> consensus that we are in a feature "freeze".

Yeah, and as I said, just create a 64 bit version.  Look into the
implementation of other Cygwin functions like lstat64 for the types
you'll have to use (e.g. _off64_t instead of off_t).

> Speaking of things in the loop, has any further thought been given to 
> David Euresti's patch from last year which enables passing of file 
> descriptors between processes via Unix Domain Sockets?  It'd be a shame 
> not to use it but, alas, David has expressed no further interest in 
> working on it and Conrad (who had intended to pick up the torch) seems 
> to have fallen off the face of the earth.  At one point you said you'd 
> like to see it go in, but it was dependent on David's cooperation.  Is 
> this in the loop or has it been dropped altogether?

The point was this:  David's patch only worked with cygserver and I was
pretty sure that it would be possible to get it also working inside
plain Cygwin.  I began to work on that but I guess I had no fixed concept
so I ran into problems, stopped working on it, were distracted by other
stuff... ye olde story.

I'd still like to see descriptor passing in Cygwin and I still think it's
possible in Cygwin w/o cygserver.  Cygserver intervention should only
be necessary if both processes have nothing to do with each other, which
isn't very likely.  Most of the time it's a parent/child relationship or
at least one of the processes is running under a privileged account.

Unfortunately, while it's no problem to send and receive the handles, it
needs a concept of submitting all fhandler internal information to the
receiving process as well, otherwise the fhandler wouldn't reflect the
actual state of the associated windows handle and the receiving process
would fail to work correctly.  At one point I found out that I'd need
some sort of serializing fhandlers, which was part of Cygwin in older
versions (B20 and friends);  code which doesn't exist anymore :-(  So
we'd have to reinvent the serialization, except somebody else has a
better idea how to get the information to the receiving process.

Bottom line:  I would appreciate any brave attempt to work on that.

>   However, instead of just being angry, I'm going to try 
> to do something about it.  My hope is that, in a small way, I can help 
> bring some parity between ELIX IV and Cygwin.  The current state of 
> newlib just seems terribly unfair, but then again, life is unfair and 
> people are mean :-D.

Hey, isn't it our job to be meaner than ELIX and newlib folks? ;-)


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
