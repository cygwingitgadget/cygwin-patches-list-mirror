Return-Path: <cygwin-patches-return-5249-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15883 invoked by alias); 18 Dec 2004 21:48:55 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 15858 invoked from network); 18 Dec 2004 21:48:51 -0000
Received: from unknown (HELO slinky.cs.nyu.edu) (128.122.20.14)
  by sourceware.org with SMTP; 18 Dec 2004 21:48:51 -0000
Received: from localhost (localhost [127.0.0.1])
	by slinky.cs.nyu.edu (8.12.10+Sun/8.12.10) with ESMTP id iBILmoW3003361;
	Sat, 18 Dec 2004 16:48:50 -0500 (EST)
Date: Sat, 18 Dec 2004 21:48:00 -0000
From: Igor Pechtchanski <pechtcha@cs.nyu.edu>
Reply-To: cygwin-patches@cygwin.com
To: Brian Dessent <brian@dessent.net>
cc: cygwin-patches@cygwin.com
Subject: Re: Patch to allow trailing dots on managed mounts
In-Reply-To: <41C49377.57107AA9@dessent.net>
Message-ID: <Pine.GSO.4.61.0412181645420.2298@slinky.cs.nyu.edu>
References: <20041216155707.GG23488@trixie.casa.cgf.cx>
 <20041216160322.GC16474@cygbert.vinschen.de> <3.0.5.32.20041216220441.0082a400@incoming.verizon.net>
 <20041217032627.GF26712@trixie.casa.cgf.cx> <3.0.5.32.20041216224347.0082d210@incoming.verizon.net>
 <20041217061741.GG26712@trixie.casa.cgf.cx> <41C31496.4D9140C7@phumblet.no-ip.org>
 <20041217175649.GA1237@trixie.casa.cgf.cx> <41C36530.89F5A621@phumblet.no-ip.org>
 <20041218003615.GB3068@trixie.casa.cgf.cx> <20041218172053.GA9932@trixie.casa.cgf.cx>
 <41C476F1.6060700@x-ray.at> <41C49377.57107AA9@dessent.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2004-q4/txt/msg00250.txt.bz2

On Sat, 18 Dec 2004, Brian Dessent wrote:

> Reini Urban wrote:
>
> > > Thinking some more about this, there are really some inconsistencies with
> > > the current and proposed behavior that I don't like.
> > > [...]
> > I have no strong opinion in these issues (yet), but please look also at
> > the related ending-colon ':extension' problem on NTFS.
> > Such files are also not listed, but probably should be.
>
> Why are you hijacking this thread for something unrelated?  The
> alternate streams are not seperate files, they are just additional file
> data.  If the need arises then standalone tools should be made to access
> them, just like getfacl and friends.  They should not be treated as
> seperate files because they're not.
>
> Brian

There are two possible interpretations here.  One is that Reini is
proposing to have Cygwin tools always list alternate streams, in which
case you're correct, and it's unrelated to the thread.  Another is that
colons in filenames on certain Cygwin mounts should not represent
alternate streams, but should be different files altogether, and thus
should be listed normally.

That said, I think Reini's wording implies your interpretation, and thus
his suggestion should be in a different thread.
	Igor
-- 
				http://cs.nyu.edu/~pechtcha/
      |\      _,,,---,,_		pechtcha@cs.nyu.edu
ZZZzz /,`.-'`'    -.  ;-;;,_		igor@watson.ibm.com
     |,4-  ) )-,_. ,\ (  `'-'		Igor Pechtchanski, Ph.D.
    '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!

"The Sun will pass between the Earth and the Moon tonight for a total
Lunar eclipse..." -- WCBS Radio Newsbrief, Oct 27 2004, 12:01 pm EDT
