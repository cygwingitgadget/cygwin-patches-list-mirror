Return-Path: <cygwin-patches-return-2375-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 17073 invoked by alias); 10 Jun 2002 03:52:07 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 17058 invoked from network); 10 Jun 2002 03:52:06 -0000
Date: Sun, 09 Jun 2002 20:52:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Reorganizing internal_getlogin()
Message-ID: <20020610035228.GC6201@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20020609231253.008044d0@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20020609231253.008044d0@mail.attbi.com>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q2/txt/msg00358.txt.bz2

On Sun, Jun 09, 2002 at 11:12:53PM -0400, Pierre A. Humblet wrote:
>Corinna,
>
>internal_getlogin() has evolved over time. Currently it has two 
>purposes:
>1) set Cygwin variables (e.g. cygheap->user, HOME, prgpsid,...)
>2) set traditional Windows environment entries (e.g. HOMEPATH)
>
>It is called in 3 cases:
>a) Entry from Windows
>b) From seteuid()

Yep.

>c) After CreateProcessAsUser()

Where is this?  I only see two calls in cygwin currently.

One is in uinfo_init.  The other is in seteuid32.  I guess you're
separating a and c.

The one in uinfo_init can't go away, can it?  If not, then I don't
see any reason why we can't press it into service for both a and c.

>The purpose in cases a) and c) is 1 above.
>The purpose in case  b) is mainly 2. 
>
>I propose to reorganize the code by breaking internal_getlogin() in two
>functions, one that does 1) and another that does 2).  The main purpose
>is to increase the efficiency, as explained below, as well as fixing
>some nits, e.g.  LOGONSERVER is never updated.
>
>The first function would be called in cases a) and c), although it
>would do very little in case c).  The second one would be called in
>spawn_guts(), just before the CreateProcessAsUser() [when the
>environment is copied to the cygheap].

Wait a minute.  Case c is the CreateProcessAsUser case.  Are you saying
that spawn_guts would need to use both the first function and the second
function?

I don't understand why moving the initialization code from the child to
the parent is a good thing.  Theoretically, the parent can just start
the child and forget about it, letting the child go through its own
initialization.  I don't see how making the parent block, doing more
work before starting the child is a good thing.

This is a basic multi-processing concept so I must be missing something.
Of course, it barely matters because I doubt if anyone is actually using
sexecv*.

>There would be no call to internal_getlogin() from seteuid().  The few
>Cygwin fields that need updating in seteuid() [e.g.user.name] would be
>handled in seteuid() itself, where the info is readily available.
>These changes would improve the performances of servers [such as mail
>servers] that setuid() repeatedly but exec() only rarely, in particular
>avoiding lookups over the network.

This sounds like a good thing.

>As a first step in this process, the attached patches contain the 
>modifications that add function 2). They can already be applied
>although internal_getlogin() is not touched. It will be simplified
>in a second phase. This will allow you to more easily check what's
>going on.  
>
>I worry (because I can't test) that this might break applications 
>using sexecXX calls, although I don't see how it would. Are there 
>any still around? It would be easy to bypass the new code for sexecXX 
>calls, if needed.
>
>2002-06-09  Pierre Humblet <pierre.humblet@ieee.org>
>
>	* environ.cc (addWinDefEnv): New.
>	(inWinDefEnv): New.
>	(writeWinDefEnv): New.
>	* spawn.cc (spawn_guts): Call functions above to set
>	traditional Windows environment variables when copying the
>	environment to the cygheap, before CreateProcessAsUser().
>	Define sec_attribs and call sec_user_nih() only once.
>	* environ.h: Declare inWinDefEnv() and addWinDefEnv(), and 
>	define WINDEFENVC.

I don't know about the sexec question.  Anyone know if there are (or
were) any actual applications out there which use sexecve?  Isn't this
just a cygwin invention?  I wonder if we should just nuke it from cygwin
and see if anyone complains.  It would certainly simplify spawn.cc.

Other minor nits: You made at least one gratuitous formatting change
(moving a '&&' to a previous line) and your choice of function names is
not really in tune with most of the other cygwin function names.  The
function names should at least be consistent with the other function
names in the file.  These are both extremely minor issues, of course.

cgf

>[snip]
