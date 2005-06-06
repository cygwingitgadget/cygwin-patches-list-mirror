Return-Path: <cygwin-patches-return-5515-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24748 invoked by alias); 6 Jun 2005 19:40:17 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24706 invoked by uid 22791); 6 Jun 2005 19:40:11 -0000
Received: from slinky.cs.nyu.edu (HELO slinky.cs.nyu.edu) (128.122.20.14)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Mon, 06 Jun 2005 19:40:11 +0000
Received: from localhost (localhost [127.0.0.1])
	by slinky.cs.nyu.edu (8.12.10+Sun/8.12.10) with ESMTP id j56JeAW3029535
	for <cygwin-patches@cygwin.com>; Mon, 6 Jun 2005 15:40:10 -0400 (EDT)
Date: Mon, 06 Jun 2005 19:40:00 -0000
From: Igor Pechtchanski <pechtcha@cs.nyu.edu>
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Loading cygwin1.dll from MinGW and MSVC
In-Reply-To: <20050606193232.GA12606@trixie.casa.cgf.cx>
Message-ID: <Pine.GSO.4.61.0506061536381.15703@slinky.cs.nyu.edu>
References: <20050606193232.GA12606@trixie.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2005-q2/txt/msg00111.txt.bz2

On Mon, 6 Jun 2005, Christopher Faylor wrote:

> I fat fingered my response to Max, ended up sending a personal message
> and never noticed until I received a personal reply from him.  I, of
> course, asked him not to send me personal email which was pretty
> confusing since I'd previously just sent him a personal reply.
>
> Translation:  I am a maroon.
>
> Anywhay this is what should have gone out days ago.
>
> On Fri, Jun 03, 2005 at 03:58:09PM -0700, Max Kaehn wrote:
> >This patch contains the changes to make it possible to dynamically load
> >cygwin1.dll from MinGW and MSVC applications.  The changes to dcrt0.cc are
> >minimal and only affect cygwin_dll_init().  I've also added a MinGW test
> >program to testsuite and a FAQ so people will be able to locate the
> >test program easily.
> >
> >I wrote how-cygtls-works.txt because it took me a while to figure out how it
> >was storing the information, and I hope I can save someone else the effort in
> >the future.  (I had no idea Windows was still using segment registers!)
> >I hope I got the copyright message right for it.
>
> Wow! That's great! Thanks for doing this.  It is much appreciated.  This
> is something that I had been meaning to do and you did a better job than
> I would have.  This truly deserves a gold star.  I know that understanding
> the cygtls stuff could not have been easy.
>
> Can I get a gold star over here for this truly heroic effort?

One(?) gold star coming up.  What's it for, though -- the changes that
enable dynamically loading cygwin1.dll, or how-cygtls-works.txt?

> I have checked in everything but the test suite stuff.  I would like to
> see some changes there:
>
> 1) Use '.cc' rather than '.cpp' for the extension to be consistent with
> the rest of winsup.
>
> 2) Use the same formatting that is used throughout cygwin for brace
> placement, etc.
>
> 3) Submit the new files as diffs against /dev/null so that I can apply
> like a normal patch.
>
> Did you consider other ways of dealing with the need for space at the
> bottom of the stack?
>
> Having an interface which requires a "main" function name so that you'd
> do something like:
>
> int
> main (int argc, char **argv)
> {
>   initialize_cygwin (rest_of_main, argc, argv);
>   /* never returns */
> }
>
> int
> rest_of_main (argc, argv)
> {
>   /* do main stuff */
>   .
>   .
>   .
>   exit or return here
> }
>
> And in cygwin initialize_cygwin would look something like:
>
> void
> initialize_cygwin (int (*) main, int argc, char **argv)
> {
>   struct _cygtls dummy_tls;
>   initialize_main_tls (&dummy_tls);
>   cygwin_dll_init ();
>   exit (main (argc, argv));

Did you mean "exit (rest_of_main (argc, argv));" here?

> }
>
> And declaring initialize_cygwin as a "__attribute__ ((noreturn))" in an
> appropriate header file.
>
> This has the downside of maybe causing more code disruption, though...
>
> cgf

	Igor
-- 
				http://cs.nyu.edu/~pechtcha/
      |\      _,,,---,,_		pechtcha@cs.nyu.edu
ZZZzz /,`.-'`'    -.  ;-;;,_		igor@watson.ibm.com
     |,4-  ) )-,_. ,\ (  `'-'		Igor Pechtchanski, Ph.D.
    '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!

"The Sun will pass between the Earth and the Moon tonight for a total
Lunar eclipse..." -- WCBS Radio Newsbrief, Oct 27 2004, 12:01 pm EDT
