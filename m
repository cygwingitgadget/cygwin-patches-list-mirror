Return-Path: <cygwin-patches-return-4859-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23367 invoked by alias); 17 Jul 2004 22:57:46 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 23355 invoked from network); 17 Jul 2004 22:57:45 -0000
X-Authentication-Warning: slinky.cs.nyu.edu: pechtcha owned process doing -bs
Date: Sat, 17 Jul 2004 22:57:00 -0000
From: Igor Pechtchanski <pechtcha@cs.nyu.edu>
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
cc: Gerd Spalink <Gerd.Spalink@t-online.de>
Subject: RE: [RFC] Reference counting on Audio objects for /dev/dsp
In-Reply-To: <Pine.GSO.4.58.0407171847180.19508@slinky.cs.nyu.edu>
Message-ID: <Pine.GSO.4.58.0407171853220.19508@slinky.cs.nyu.edu>
References: <01C46C45.1B9CA350.Gerd.Spalink@t-online.de>
 <Pine.GSO.4.58.0407171847180.19508@slinky.cs.nyu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.39
X-SW-Source: 2004-q3/txt/msg00011.txt.bz2

On Sat, 17 Jul 2004, Igor Pechtchanski wrote:

> On Sat, 17 Jul 2004, Gerd Spalink wrote:
>
> > On Friday, July 16, 2004 4:31 AM, Christopher Faylor [SMTP:cgf-no-personal-reply-please@cygwin.com] wrote:
> > > On Thu, Jul 15, 2004 at 04:28:56PM -0400, Igor Pechtchanski wrote:
> > > >On Thu, 15 Jul 2004, Christopher Faylor wrote:
> > > >
> > > >> On Thu, Jul 15, 2004 at 02:57:17PM -0400, Igor Pechtchanski wrote:
> > > >> >> 2) The other problem is that I find it sort of odd to see the dec()
> > > >> >> method performing a deletion.  Couldn't this be handled where, IMO,
> > > >> >> it should logically be handled, in the close function, e.g.,
> > > >> >>
> > > >> >>   if (!audio_out_->dec ())
> > > >> >>     delete audio_out_;
> > > >> >> ?
> > > >> >
> > > >> >Umm, that's actually a rather standard construct in reference counting
> > > >> >(called "object suicide" -- you should get some references if you Google
> > > >> >for "object suicide reference counting").
> > > >>
> > > >> Yes, I thought that would be your answer, however, I don't like the idea
> > > >> of having a method called "inc" which just increments a count and a method
> > > >> called "dec" which decrements a count and, oh, hey, it might delete the
> > > >> object, too.
> > > >>
> > > >> It seems more straightforward to delete audio_out_ in the place where
> > > >> you'd expect it to be deleted rather than having a "dec" call which,
> > > >> if you check, you'll notice that it deletes the buffer.
> > > >>
> > > >> Or, as a compromise, don't call it 'dec'.  Call it something which
> > > >> illustrates what it is doing.
> > > >
> > > >Right.  I think the compromise is good -- I was thinking of maybe using
> > > >registerReference() and releaseReference() (or deregister?).  We could
> > > >shorten them by removing "Reference" from the names, too.  In any case,
> > > >I'd wait for Gerd's input before deciding on the specific code to go in.
> > >
> > > That sounds good to me.
> > >
> > > Now we just need Gerd's ok.
> > >
> > > cgf
> >
> > The current proposal will not work if someone first dups the device
> > descriptor, and then changes the audio settings with ioctl calls using
> > one of the two device descriptors. The other one will keep the old
> > settings.
> >
> > The patch I am preparing will fix this. However, I also have problems to
> > build the cygwin DLL. I'll try to do it tonight.
> >
> > Gerd
>
> Huh?  I'm most likely misunderstanding something...  Aren't the audio
> settings kept in the Audio objects?  Those are shared, so any changes made
> to one via the first descriptor should be visible via the second
> descriptor, right?
> 	Igor

Replying to myself - a sure sign of schitzophrenia... :-)

I'm wrong.  Some settings *are* kept in the fhandler objects (audiobits_,
audiofreq_, audiochannels_, and audioformat_).  So CGF is right -
archetypes will probably be the right solution here...  However, we still
need reference counting for the Audio objects, since even with archetypes
they'll be shared (unless you completely rewrite the code).
	Igor
-- 
				http://cs.nyu.edu/~pechtcha/
      |\      _,,,---,,_		pechtcha@cs.nyu.edu
ZZZzz /,`.-'`'    -.  ;-;;,_		igor@watson.ibm.com
     |,4-  ) )-,_. ,\ (  `'-'		Igor Pechtchanski, Ph.D.
    '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!

"I have since come to realize that being between your mentor and his route
to the bathroom is a major career booster."  -- Patrick Naughton
