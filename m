Return-Path: <cygwin-patches-return-4854-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1983 invoked by alias); 15 Jul 2004 20:28:58 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1967 invoked from network); 15 Jul 2004 20:28:57 -0000
X-Authentication-Warning: slinky.cs.nyu.edu: pechtcha owned process doing -bs
Date: Thu, 15 Jul 2004 20:28:00 -0000
From: Igor Pechtchanski <pechtcha@cs.nyu.edu>
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
Subject: Re: [RFC] Reference counting on Audio objects for /dev/dsp
In-Reply-To: <20040715202128.GA12288@trixie.casa.cgf.cx>
Message-ID: <Pine.GSO.4.58.0407151626010.24064@slinky.cs.nyu.edu>
References: <Pine.GSO.4.58.0407150928040.29800@slinky.cs.nyu.edu>
 <20040715183335.GB12149@trixie.casa.cgf.cx> <Pine.GSO.4.58.0407151449040.24064@slinky.cs.nyu.edu>
 <20040715202128.GA12288@trixie.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.39
X-SW-Source: 2004-q3/txt/msg00006.txt.bz2

On Thu, 15 Jul 2004, Christopher Faylor wrote:

> On Thu, Jul 15, 2004 at 02:57:17PM -0400, Igor Pechtchanski wrote:
> >> 2) The other problem is that I find it sort of odd to see the dec()
> >> method performing a deletion.  Couldn't this be handled where, IMO,
> >> it should logically be handled, in the close function, e.g.,
> >>
> >>   if (!audio_out_->dec ())
> >>     delete audio_out_;
> >> ?
> >
> >Umm, that's actually a rather standard construct in reference counting
> >(called "object suicide" -- you should get some references if you Google
> >for "object suicide reference counting").
>
> Yes, I thought that would be your answer, however, I don't like the idea
> of having a method called "inc" which just increments a count and a method
> called "dec" which decrements a count and, oh, hey, it might delete the
> object, too.
>
> It seems more straightforward to delete audio_out_ in the place where
> you'd expect it to be deleted rather than having a "dec" call which,
> if you check, you'll notice that it deletes the buffer.
>
> Or, as a compromise, don't call it 'dec'.  Call it something which
> illustrates what it is doing.
>
> cgf

Right.  I think the compromise is good -- I was thinking of maybe using
registerReference() and releaseReference() (or deregister?).  We could
shorten them by removing "Reference" from the names, too.  In any case,
I'd wait for Gerd's input before deciding on the specific code to go in.
	Igor
-- 
				http://cs.nyu.edu/~pechtcha/
      |\      _,,,---,,_		pechtcha@cs.nyu.edu
ZZZzz /,`.-'`'    -.  ;-;;,_		igor@watson.ibm.com
     |,4-  ) )-,_. ,\ (  `'-'		Igor Pechtchanski, Ph.D.
    '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!

"I have since come to realize that being between your mentor and his route
to the bathroom is a major career booster."  -- Patrick Naughton
