Return-Path: <cygwin-patches-return-2940-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 708 invoked by alias); 6 Sep 2002 11:42:17 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 690 invoked from network); 6 Sep 2002 11:42:17 -0000
Message-ID: <3D7894BF.F12F3E0A@yahoo.com>
Date: Fri, 06 Sep 2002 04:42:00 -0000
From: Earnie Boyd <earnie_boyd@yahoo.com>
Reply-To: mingw-users@lists.sf.net, cygwin-patches@cygwin.com
X-Accept-Language: en
MIME-Version: 1.0
To: MinGW-users@lists.sourceforge.net
CC: cygwin-patches@cygwin.com
Subject: Re: [Mingw-users] Re: WINVER constant value [WAS: GetConsoleWindow]
References: <NCBBIHCHBLCMLBLOBONKEEMFDEAA.g.r.vansickle@worldnet.att.net>
		<3D780D71.F3F87271@yahoo.com> <7khzvl5r.fsf@wanadoo.es>
		<20020906042522.GD27778@redhat.com> <3csnvfry.fsf@wanadoo.es>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q3/txt/msg00388.txt.bz2

Oscar Fuentes wrote:
> 
> Christopher Faylor <cgf@redhat.com> writes:
> 
> > On Fri, Sep 06, 2002 at 05:42:24AM +0200, Oscar Fuentes wrote:
> > >But I think MinGW must not be a drop-in replacement for MSVC.
> >
> > We aren't talking about just MinGW, though.  Several projects use these
> > header files.
> >

Which is the reason that I'm asking this question to the MinGW user
base.  It should cover all projects using the www.mingw.org
distributions.

> > I'd be interested in hearing your rationale for not making MinGW a
> > drop-in replacement for MSVC, though.
> 
> First: if you want MSVC, get the real MSVC.
> 

Well, first, how did this become a question of whether mingw32-gcc is a
look-a-like for MSVC rather than a discussion of the w32api WINVER
constant value?

> Second: I doubt very much that MinGW's gcc can be at any point on the
> future a real drop-in for MSVC. MSVC has too much extensions and
> standards deviations.
> 
> Third: As a C++ programmer who cares about using real C++ and be able
> to build my projects on other platforms and compilers, I *hope* MinGW
> will not be a drop-in for MSVC. For the same reason I don't use MSVC I
> would not use a "MSVC-compliant" MinGW.
> 

I agree with Oscar on both these points.

> > It seems like there are frequent discussions about how to arrange
> > things in the header files so that they closely mimic the layout
> > used by MSVC.  I'm sure I can easily find examples of this in the
> > email archives.
> 
> This does not means people want to mimic MSVC on every aspect. Even it
> doesn't mean that it is convenient to mimic MSVC's header layout on
> every aspect.
> 

Correct.  And as Chris can find many examples where we want to closely
mimic, I can find examples where we've agreed not to.  For instance, C99
compatibility will either be late in coming or never happen with MSVC,
however, the mingw-runtime supports it.  Another example is the recently
created sys/param.h file, go look for that in your MSVC headers.

> > (maybe that's a discussion just for the mingw mailing list)
> 
> Well, right now we are on MinGW-users mailing list.
> 

And cross posting to a Cygwin list, so in reality the discussion is
happening there.

> > Obviously gcc itself is not a complete drop-in replacement for msvc
> > but we really don't have much control over that.
> 
> Seems that the MinGW maintainers have trouble keeping the pace with
> FSF. I doubt they have time to work on such complex tasks as extending
> g++, for instance. Moreover, AFAIK the FSF people are less interested
> on MSVC compatibility as time passes.
> 
> Let's face it: MinGW will never be a drop-in for MSVC. I bet that it
> will never be able to compile MSF projects dating from 1995, for
> instance.
> 

I doubt that anyone using GCC wants GCC to be a look-a-like for MSVC. 
They want a better product.  The extensions that people want, if they
want it great enough, will be added by the people that want them.  MSVC,
can never have that kind of advantage until it becomes open sourced.

> [snip]
> 
> > I've used the "for their own good" line of reasoning myself many times
> > in the cygwin project but I think I have, more often than not,
> > eventually reverted to fixing things so that they cause the minimal
> > amount of end-user confusion.
> 
> Scenario 1: people comes here asking "why that piece of source does
> not compile?"
> 
> Scenario 2: people comes here asking "why my app doesn't run on
> Win9x?".
> 
> For me, the choice is clear.
> 

Agreed.

> > I think the bottom line is not that we should teach people for their own
> > good as much as not violate the principle of least surprise.  I honestly
> > don't know what would be the least surprising in this case,
> 
> I prefer to experience surprises at an early stage of development
> (read: compile time).
> 

Yep, me too.

> > but I suspect that most people would probably be less surprised by
> > the MSVC behavior.
> 
> It's my impression that most MinGW programmers doesn't know MSVC so
> well to expect that MinGW will work on a specific way. It's my
> impression that most newbies that uses MinGW have no real experience
> with MSVC at all. (Let's forget about the experienced people, they
> knows how to deal with WINVER).
> 

My guess is that there are more GCC experienced people using MinGW for
mingw32-gcc than there are MSVC experienced people using MinGW for any
reason.  A drop in replacement for MSVC, surely isn't the desire. 
Wanting to the package to port to all versions of Win32 is the desire. 
Using new Win32 API not supported on older versions of the OS isn't the
way to go about doing that.  Runtime surprises, is not the place to
discover that the port doesn't work.

We are flexible enough to listen to reason.  I haven't seen enough
reason to change the value of WINVER.

Earnie.
