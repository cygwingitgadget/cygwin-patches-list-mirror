Return-Path: <cygwin-patches-return-5528-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32102 invoked by alias); 6 Jun 2005 23:08:04 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 32019 invoked by uid 22791); 6 Jun 2005 23:07:59 -0000
Received: from slinky.cs.nyu.edu (HELO slinky.cs.nyu.edu) (128.122.20.14)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Mon, 06 Jun 2005 23:07:59 +0000
Received: from localhost (localhost [127.0.0.1])
	by slinky.cs.nyu.edu (8.12.10+Sun/8.12.10) with ESMTP id j56N7wW3015031;
	Mon, 6 Jun 2005 19:07:58 -0400 (EDT)
Date: Mon, 06 Jun 2005 23:08:00 -0000
From: Igor Pechtchanski <pechtcha@cs.nyu.edu>
Reply-To: cygwin-patches@cygwin.com
To: Max Kaehn <slothman@electric-cloud.com>
cc: cygwin-patches@cygwin.com
Subject: Re: [Patch] Testing loads of cygwin1.dll from MinGW and MSVC, take
 3
In-Reply-To: <1118098448.5031.157.camel@fulgurite>
Message-ID: <Pine.GSO.4.61.0506061907220.15703@slinky.cs.nyu.edu>
References: <1118084587.5031.128.camel@fulgurite>  <20050606200639.GC13442@trixie.casa.cgf.cx>
  <1118091704.5031.144.camel@fulgurite>  <20050606213339.GC16960@trixie.casa.cgf.cx>
 <1118098448.5031.157.camel@fulgurite>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2005-q2/txt/msg00124.txt.bz2

On Mon, 6 Jun 2005, Max Kaehn wrote:

> On Mon, 2005-06-06 at 14:33, Christopher Faylor wrote:
> > There were still some braces at the end of the line in cygload.h so I
> > changed those.  I also changed the ChangeLog entry "now tests cygload"
> > to "Test cygload".  See http://cygwin.com/contrib.html for some common
> > mistakes in ChangeLog entries.
>
> Got it.  (Still wrapping my brain around using the present tense. :-) )
>
> > So, I checked in the above and, after changing cygload.exp so that it
> > compiles cygload.cc rather than cygload.cpp, I found a more serious
> > error.  I've attached the cygload.log file.  It doesn't look pretty,
> > unfortunately.  You might notice the same thing if you configure your
> > Cygwin DLL with --enable-debugging, like I do.
>
> Aha!  I'll rebuild and investigate.  Thanks.
>
> > Another problem is that since you have separated out the Makefile into
> > two separate invocations of $(RUNTEST) the error return from the Makefile
> > will not be set correctly.  To preserve previous operation, the makefile
> > should do all of the tests and then return with a status of zero if things
> > completed correctly or nonzero otherwise.
>
> My goof.  Like this?
>
> Index: winsup/testsuite/Makefile.in
> ===================================================================
> RCS file: /cvs/src/src/winsup/testsuite/Makefile.in,v
> retrieving revision 1.20
> diff -u -p -r1.20 Makefile.in
> --- winsup/testsuite/Makefile.in        6 Jun 2005 21:13:31 -0000
> 1.20
> +++ winsup/testsuite/Makefile.in        6 Jun 2005 22:49:40 -0000
> @@ -186,7 +186,7 @@ check: $(TESTSUP_LIB_NAME) $(RUNTIME) cy
>            TCL_LIBRARY=`cd .. ; cd ${srcdir}/../../tcl/library ; pwd` ;
> \
>             export TCL_LIBRARY ; fi ; \
>         PATH=$(bupdir)/cygwin:$${PATH} ;\
> -       $(RUNTEST) --tool winsup $(RUNTESTFLAGS) ;\
> +       $(RUNTEST) --tool winsup $(RUNTESTFLAGS) ||\
>         $(RUNTEST) --tool cygload $(RUNTESTFLAGS)

I take it you meant

-       $(RUNTEST) --tool winsup $(RUNTESTFLAGS) ;\
+       $(RUNTEST) --tool winsup $(RUNTESTFLAGS) &&\

	Igor
-- 
				http://cs.nyu.edu/~pechtcha/
      |\      _,,,---,,_		pechtcha@cs.nyu.edu
ZZZzz /,`.-'`'    -.  ;-;;,_		igor@watson.ibm.com
     |,4-  ) )-,_. ,\ (  `'-'		Igor Pechtchanski, Ph.D.
    '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!

"The Sun will pass between the Earth and the Moon tonight for a total
Lunar eclipse..." -- WCBS Radio Newsbrief, Oct 27 2004, 12:01 pm EDT
