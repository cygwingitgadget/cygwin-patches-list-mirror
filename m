Return-Path: <cygwin-patches-return-5519-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17094 invoked by alias); 6 Jun 2005 20:09:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 17052 invoked by uid 22791); 6 Jun 2005 20:09:15 -0000
Received: from slinky.cs.nyu.edu (HELO slinky.cs.nyu.edu) (128.122.20.14)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Mon, 06 Jun 2005 20:09:15 +0000
Received: from localhost (localhost [127.0.0.1])
	by slinky.cs.nyu.edu (8.12.10+Sun/8.12.10) with ESMTP id j56K9DW3001989
	for <cygwin-patches@cygwin.com>; Mon, 6 Jun 2005 16:09:13 -0400 (EDT)
Date: Mon, 06 Jun 2005 20:09:00 -0000
From: Igor Pechtchanski <pechtcha@cs.nyu.edu>
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Loading cygwin1.dll from MinGW and MSVC
In-Reply-To: <20050606195234.GA13442@trixie.casa.cgf.cx>
Message-ID: <Pine.GSO.4.61.0506061556260.15703@slinky.cs.nyu.edu>
References: <20050606193232.GA12606@trixie.casa.cgf.cx>
 <Pine.GSO.4.61.0506061536381.15703@slinky.cs.nyu.edu>
 <20050606195234.GA13442@trixie.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2005-q2/txt/msg00115.txt.bz2

On Mon, 6 Jun 2005, Christopher Faylor wrote:

> On Mon, Jun 06, 2005 at 03:40:10PM -0400, Igor Pechtchanski wrote:
> >On Mon, 6 Jun 2005, Christopher Faylor wrote:
> >
> >> I fat fingered my response to Max, ended up sending a personal message
> >> and never noticed until I received a personal reply from him.  I, of
> >> course, asked him not to send me personal email which was pretty
> >> confusing since I'd previously just sent him a personal reply.
> >>
> >> Translation:  I am a maroon.
> >>
> >> Anywhay this is what should have gone out days ago.
> >>
> >> On Fri, Jun 03, 2005 at 03:58:09PM -0700, Max Kaehn wrote:
> >> >This patch contains the changes to make it possible to dynamically load
> >> >cygwin1.dll from MinGW and MSVC applications.  The changes to dcrt0.cc are
> >> >minimal and only affect cygwin_dll_init().  I've also added a MinGW test
> >> >program to testsuite and a FAQ so people will be able to locate the
> >> >test program easily.
> >> >
> >> >I wrote how-cygtls-works.txt because it took me a while to figure out how it
> >> >was storing the information, and I hope I can save someone else the effort in
> >> >the future.  (I had no idea Windows was still using segment registers!)
> >> >I hope I got the copyright message right for it.
> >>
> >> Wow! That's great! Thanks for doing this.  It is much appreciated.  This
> >> is something that I had been meaning to do and you did a better job than
> >> I would have.  This truly deserves a gold star.  I know that understanding
> >> the cygtls stuff could not have been easy.
> >>
> >> Can I get a gold star over here for this truly heroic effort?
> >
> >One(?) gold star coming up.  What's it for, though -- the changes that
> >enable dynamically loading cygwin1.dll, or how-cygtls-works.txt?
>
> For now:  how-cygtls-works.txt.

Ok, done.  One gold star, freshly minted.

> >>[snip]
> >> Having an interface which requires a "main" function name so that you'd
> >> do something like:
> >>
> >> int
> >> main (int argc, char **argv)
> >> {
> >>   initialize_cygwin (rest_of_main, argc, argv);
> >>   /* never returns */
> >> }
> >>
> >> int
> >> rest_of_main (argc, argv)
> >> {
> >>   /* do main stuff */
> >>   .
> >>   .
> >>   .
> >>   exit or return here
> >> }
> >>
> >> And in cygwin initialize_cygwin would look something like:
> >>
> >> void
> >> initialize_cygwin (int (*) main, int argc, char **argv)
> >> {
> >>   struct _cygtls dummy_tls;
> >>   initialize_main_tls (&dummy_tls);
> >>   cygwin_dll_init ();
> >>   exit (main (argc, argv));
> >
> >Did you mean "exit (rest_of_main (argc, argv));" here?
>
> No.  I meant to use the function that was passed in, i.e.  main,
> although maybe it would be safer not to call it "main".  This is a DLL
> routine that wouldn't know about rest_of_main.

Ug, that'd teach me to actually read the messages I'm replying to. :-)

> As Max points out, though, this does stand the chance of nuking argv,
> though, so that would have to be copied before before initialize_main_tls was
> called:
>
> i.e., something like (modulo typos):
>
>   void
>   initialize_cygwin (int (*main) (int argc, char **argv), int argc, char **argv)
>   {
>     struct _cygtls dummy_tls;
>     char *newargv = alloca (argc * sizeof (argv[0]));
>     for (char **av = newargv; *av; av++)
>       *av = *argv++;
>     *av = NULL;
>     initialize_main_tls (&dummy_tls);
>     cygwin_dll_init ();
>     exit (main (argc, newargv));
>   }
>
> cgf

I wonder if this could, perhaps, be made more transparent to the
programmer, by introducing a static marker, for example.  Something like
(again, modulo typos):

  void
  initialize_cygwin (int (*main) (int argc, char **argv), int argc, char **argv)
  {
    static int was_here = 0;
    if (was_here) return;
    was_here = 1;
    struct _cygtls dummy_tls;
    char *newargv = alloca (argc * sizeof (argv[0]));
    for (char **av = newargv; *av; av++)
      *av = *argv++;
    *av = NULL;
    initialize_main_tls (&dummy_tls);
    cygwin_dll_init ();
    exit (main (argc, newargv));
  }

Then main() could look like this:

  int
  main (int argc, char **argv)
  {
    initialize_cygwin (main, argc, argv);  /* could return */

    /* do main stuff */
    .
    .
    .
    exit or return here
  }

Or is there a reason for main() to be thread-safe or for
initialize_cygwin() to be called twice?
	Igor
-- 
				http://cs.nyu.edu/~pechtcha/
      |\      _,,,---,,_		pechtcha@cs.nyu.edu
ZZZzz /,`.-'`'    -.  ;-;;,_		igor@watson.ibm.com
     |,4-  ) )-,_. ,\ (  `'-'		Igor Pechtchanski, Ph.D.
    '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!

"The Sun will pass between the Earth and the Moon tonight for a total
Lunar eclipse..." -- WCBS Radio Newsbrief, Oct 27 2004, 12:01 pm EDT
