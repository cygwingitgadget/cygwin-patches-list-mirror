Return-Path: <cygwin-patches-return-3546-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20614 invoked by alias); 7 Feb 2003 21:37:51 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 20598 invoked from network); 7 Feb 2003 21:37:51 -0000
X-Authentication-Warning: slinky.cs.nyu.edu: pechtcha owned process doing -bs
Date: Fri, 07 Feb 2003 21:37:00 -0000
From: Igor Pechtchanski <pechtcha@cs.nyu.edu>
To: cygwin-patches@cygwin.com
Subject: Re: cygcheck output alignment
In-Reply-To: <20030207213038.GB11495@redhat.com>
Message-ID: <Pine.GSO.4.44.0302071636470.12312-100000@slinky.cs.nyu.edu>
Importance: Normal
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2003-q1/txt/msg00195.txt.bz2

On Fri, 7 Feb 2003, Christopher Faylor wrote:

> On Fri, Feb 07, 2003 at 10:12:05PM +0100, Corinna Vinschen wrote:
> >On Fri, Feb 07, 2003 at 02:55:11PM -0500, Igor Pechtchanski wrote:
> >> 2003-02-07  Igor Pechtchanski <pechtcha@cs.nyu.edu>
> >>
> >> 	* dump_setup.cc (dump_setup): Compute the longest
> >> 	package name and align columns properly.
> >
> >Applied.
>
> Um.  No wait.  I have a much smaller way of fixing this, I think.
> cgf

Oops, you're quite right.  For some reason I thought that the string was
over-allocated conservatively...  Should've changed the printf, as well.
	Igor
-- 
				http://cs.nyu.edu/~pechtcha/
      |\      _,,,---,,_		pechtcha@cs.nyu.edu
ZZZzz /,`.-'`'    -.  ;-;;,_		igor@watson.ibm.com
     |,4-  ) )-,_. ,\ (  `'-'		Igor Pechtchanski
    '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!

Oh, boy, virtual memory! Now I'm gonna make myself a really *big* RAMdisk!
  -- /usr/games/fortune
