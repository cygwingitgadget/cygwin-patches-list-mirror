Return-Path: <cygwin-patches-return-3871-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11242 invoked by alias); 21 May 2003 17:06:38 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11204 invoked from network); 21 May 2003 17:06:36 -0000
X-Authentication-Warning: slinky.cs.nyu.edu: pechtcha owned process doing -bs
Date: Wed, 21 May 2003 17:06:00 -0000
From: Igor Pechtchanski <pechtcha@cs.nyu.edu>
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
Subject: Re: Patch for line draw characters problem & screen scrolling
In-Reply-To: <20030521162232.GC3096@redhat.com>
Message-ID: <Pine.GSO.4.44.0305211259290.26639-100000@slinky.cs.nyu.edu>
Importance: Normal
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2003-q2/txt/msg00098.txt.bz2

On Wed, 21 May 2003, Christopher Faylor wrote:

> On Wed, May 21, 2003 at 05:32:33PM +0200, Micha Nelissen wrote:
> >Hi,
> >
> >Several problems encountered and tried to fix:
> >
> >1) line draw characters not showing up in combination Command Prompt with
> >bash.
> >2) screen scrolling fixed for termcap entry 'cs' -> screen split is very
> >fast and cool.
> >3) end-of-buffer cursor out of range; see changelog for more details.
> >
> >This is my first patch, so please don't flame ;). I am open to suggestions.
> >
> >Regards,
>
> >2003-05-21  Micha Nelissen  <mdvpost@hotmail.com>
> >[snip]
> >* fhandler_console.cc (write_normal): end of buffer check enables cursor to be
> >out of range; it better emulates *nix terminal behaviour; ie. it is now
> >possible to write a single character at right bottom of console buffer without
> >the console scrolling the buffer.
>
> How is this similar to UNIX?  If I do a:
>
> sleep 5; echo hello
>
> and then scroll my xterm up, xterm scrolls down when hello is printed.  It
> sounds like your patch would not cause this to happen.

Chris,

This behavior is controlled, at least in an xterm, by the "Scroll to
Bottom on Tty Output" resource.  In the Windows console, no such control
is available, and it does scroll to bottom on output (just verified that).
I think that's what Micha is trying to fix...  Please correct me if I'm
wrong.

Micha, if the above is correct, you'll probably want to introduce some
sort of control that will let users switch back and forth, according to
their preferences.
	Igor
-- 
				http://cs.nyu.edu/~pechtcha/
      |\      _,,,---,,_		pechtcha@cs.nyu.edu
ZZZzz /,`.-'`'    -.  ;-;;,_		igor@watson.ibm.com
     |,4-  ) )-,_. ,\ (  `'-'		Igor Pechtchanski
    '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!

"I have since come to realize that being between your mentor and his route
to the bathroom is a major career booster."  -- Patrick Naughton
