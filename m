Return-Path: <cygwin-patches-return-2945-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 17649 invoked by alias); 7 Sep 2002 02:28:02 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 17632 invoked from network); 7 Sep 2002 02:28:02 -0000
From: "Gary R. Van Sickle" <g.r.vansickle@worldnet.att.net>
To: <mingw-users@lists.sf.net>,
	<cygwin-patches@cygwin.com>,
	<MinGW-users@lists.sourceforge.net>
Subject: RE: [Mingw-users] Re: WINVER constant value [WAS: GetConsoleWindow]
Date: Fri, 06 Sep 2002 19:28:00 -0000
Message-ID: <NCBBIHCHBLCMLBLOBONKIENGDEAA.g.r.vansickle@worldnet.att.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
In-Reply-To: <3D7894BF.F12F3E0A@yahoo.com>
Importance: Normal
X-SW-Source: 2002-q3/txt/msg00393.txt.bz2

[snip]

> > > It seems like there are frequent discussions about how to arrange
> > > things in the header files so that they closely mimic the layout
> > > used by MSVC.  I'm sure I can easily find examples of this in the
> > > email archives.
> >
> > This does not means people want to mimic MSVC on every aspect. Even it
> > doesn't mean that it is convenient to mimic MSVC's header layout on
> > every aspect.
> >
>
> Correct.  And as Chris can find many examples where we want to closely
> mimic, I can find examples where we've agreed not to.  For instance, C99
> compatibility will either be late in coming or never happen with MSVC,
> however, the mingw-runtime supports it.

OK, but that's not going to cause anybody any "why won't this perfectly good VC7
code compile with mingw?"'s, will it?

[snip]

> > > I've used the "for their own good" line of reasoning myself many times
> > > in the cygwin project but I think I have, more often than not,
> > > eventually reverted to fixing things so that they cause the minimal
> > > amount of end-user confusion.
> >
> > Scenario 1: people comes here asking "why that piece of source does
> > not compile?"
> >
> > Scenario 2: people comes here asking "why my app doesn't run on
> > Win9x?".
> >
> > For me, the choice is clear.
> >
>
> Agreed.
>

But hang on: "Scenario 2" is exactly the situation that MSVC folks (indeed
anybody using the official MS headers) have been living with since the beginning
of time.  And they don't "come here", they go to the guy who wrote the code and
he goes "doh! I used a non-Win9x function!" and fixes it or not.  Complaints get
distributed and everybody's cross is a little lighter.

> > > I think the bottom line is not that we should teach people for their own
> > > good as much as not violate the principle of least surprise.  I honestly
> > > don't know what would be the least surprising in this case,
> >
> > I prefer to experience surprises at an early stage of development
> > (read: compile time).
> >
>
> Yep, me too.
>

Those of us that do should then use the "traditional" WINVER functionality, and
all is copacetic, no?

> > > but I suspect that most people would probably be less surprised by
> > > the MSVC behavior.
> >
> > It's my impression that most MinGW programmers doesn't know MSVC so
> > well to expect that MinGW will work on a specific way. It's my
> > impression that most newbies that uses MinGW have no real experience
> > with MSVC at all. (Let's forget about the experienced people, they
> > knows how to deal with WINVER).
> >
>
> My guess is that there are more GCC experienced people using MinGW for
> mingw32-gcc than there are MSVC experienced people using MinGW for any
> reason.

I'm sure you're right.  But they're not immune to being confused when things
work differently than what has gone before.  And there's a lot of folks who
would *love* to drop MSVC.  And they'll be coming mingw's way in ever-increasing
numbers.

>  A drop in replacement for MSVC, surely isn't the desire.
> Wanting to the package to port to all versions of Win32 is the desire.
> Using new Win32 API not supported on older versions of the OS isn't the
> way to go about doing that.  Runtime surprises, is not the place to
> discover that the port doesn't work.
>
> We are flexible enough to listen to reason.  I haven't seen enough
> reason to change the value of WINVER.

But Earnie, you *are* changing the value of WINVER, that's the whole thing here.

I understand what you're trying to do, and in fact I would support it, if there
wasn't so much historical precedent to the contrary.  Like Chris, I'm going to
bow out too, but in closing I strongly suggest that if you insist on doing this,
use a setup like this in the headers:

#ifndef WINVER
#error "MINGW handles things a bit differently from MSVC.  You must explicitly
define which\
Windows API version you wish to use via WINVER.  This will not cause any
incompatibilities with\
MSVC, if that is important to you."
#endif

Then everybody wins, no?

--
Gary R. Van Sickle
Brewer.  Patriot.
