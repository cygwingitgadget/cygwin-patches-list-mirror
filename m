Return-Path: <cygwin-patches-return-5516-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27268 invoked by alias); 6 Jun 2005 19:45:26 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 27243 invoked by uid 22791); 6 Jun 2005 19:45:20 -0000
Received: from slinky.cs.nyu.edu (HELO slinky.cs.nyu.edu) (128.122.20.14)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Mon, 06 Jun 2005 19:45:20 +0000
Received: from localhost (localhost [127.0.0.1])
	by slinky.cs.nyu.edu (8.12.10+Sun/8.12.10) with ESMTP id j56JjIW3029987;
	Mon, 6 Jun 2005 15:45:18 -0400 (EDT)
Date: Mon, 06 Jun 2005 19:45:00 -0000
From: Igor Pechtchanski <pechtcha@cs.nyu.edu>
Reply-To: cygwin-patches@cygwin.com
To: Max Kaehn <slothman@electric-cloud.com>
cc: cygwin-patches@cygwin.com
Subject: Re: [Patch] Loading cygwin1.dll from MinGW and MSVC
In-Reply-To: <1118086713.5031.139.camel@fulgurite>
Message-ID: <Pine.GSO.4.61.0506061541150.15703@slinky.cs.nyu.edu>
References: <20050606193232.GA12606@trixie.casa.cgf.cx> <1118086713.5031.139.camel@fulgurite>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2005-q2/txt/msg00112.txt.bz2

On Mon, 6 Jun 2005, Max Kaehn wrote:

> Resending to the cygwin list this time...
>
> On Fri, 2005-06-03 at 19:30, Christopher Faylor wrote:
> > Wow! That's great! Thanks for doing this.  It is much appreciated.  This
> > is something that I had been meaning to do and you did a better job than
> > I would have.  This truly deserves a gold star.  I know that understanding
> > the cygtls stuff could not have been easy.
> >
> > Can I get a gold star over here for this truly heroic effort?
>
> *blush*
>
> > I have checked in everything but the test suite stuff.  I would like to
> > see some changes there:
> >
> > 1) Use '.cc' rather than '.cpp' for the extension to be consistent with
> > the rest of winsup.
>
> Oops.  All the other things I was trying to get right and that one
> was staring me in the face. :-)
>
> > 2) Use the same formatting that is used throughout cygwin for brace
> > placement, etc.
>
> Sure.  I tried looking for the appropriate emacs settings for
> the canonical cygwin style, but I can't find out how to get my
> password for access to the cygwin-developers archive to see if
> anyone has already answered that one.  Another couple of good
> things for the cygwin-developers FAQ or maybe a README.coding-style
> in winsup could be:
>         * How do I access the cygwin-developers archives through
>              the Web interface?
>         * What parameters should I set in my source code editor
>           so it automatically does the proper indentation for the
>           canonicaly cygwin style?
>
> Meanwhile, cygload isn't that large, so I just set c-basic-offset
> to 2 and hand-tweaked the braces.  I'll be submitting the revised
> patch for cygload today.

Doesn't GNU indent have a mode that conforms exactly to the GNU code
formatting standards?

> > 3) Submit the new files as diffs against /dev/null so that I can apply
> > like a normal patch.
>
> Aha!  I'd been wondering how that would look in a patch.  That might
> be a good one for the "contributing" page.

Or use "diff -N", which will automatically do the right thing.

> You may have noticed that I'm a compulsive documenter.  If you
> want to leave the effort of turning a brief E-mail reply into a
> FAQ entry or README to me, I'll be happy to submit the patch. :-)

See <http://cygwin.com/acronyms/#CTDW>.
	Igor
-- 
				http://cs.nyu.edu/~pechtcha/
      |\      _,,,---,,_		pechtcha@cs.nyu.edu
ZZZzz /,`.-'`'    -.  ;-;;,_		igor@watson.ibm.com
     |,4-  ) )-,_. ,\ (  `'-'		Igor Pechtchanski, Ph.D.
    '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!

"The Sun will pass between the Earth and the Moon tonight for a total
Lunar eclipse..." -- WCBS Radio Newsbrief, Oct 27 2004, 12:01 pm EDT
