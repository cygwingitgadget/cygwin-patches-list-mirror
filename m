Return-Path: <cygwin-patches-return-3797-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17560 invoked by alias); 9 Apr 2003 15:11:25 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 17548 invoked from network); 9 Apr 2003 15:11:24 -0000
X-Authentication-Warning: slinky.cs.nyu.edu: pechtcha owned process doing -bs
Date: Wed, 09 Apr 2003 15:11:00 -0000
From: Igor Pechtchanski <pechtcha@cs.nyu.edu>
Reply-To: cygwin-patches@cygwin.com
To: Bob Cassels <bcassels@abinitio.com>
cc: cygwin-patches@cygwin.com
Subject: Re: PATCH: Better handle accented characters from the console
In-Reply-To: <OF4A0E537E.6E0F20B0-ON85256D03.004C0999-85256D03.004C2154@abinitio.com>
Message-ID: <Pine.GSO.4.44.0304091109340.8179-100000@slinky.cs.nyu.edu>
Importance: Normal
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2003-q2/txt/msg00024.txt.bz2

On Wed, 9 Apr 2003, Bob Cassels wrote:

> cygwin-patches-owner@cygwin.com wrote on 04/08/2003 08:35:34 PM:
>
> > On Tue, Apr 08, 2003 at 05:20:27PM -0400, Christopher Faylor wrote:
>
> > Hey, it just occurred to me.  Do you want to take a stab at augmenting
> > the cygwin documentation for this feature?  I'm not sure where it should
> > go.  But that's mainly because I haven't actually looked.  :-)
> >
> > It just seems that since we now allow people to type this stuff in, it
> > should be documented somewhere.
>
> Sure, I'll take a stab at it.  I'm not sure it'll be much more than a
> pointer to the Microsoft doc on which numbers get which characters, and a
> statement that Cygwin supports them, too.
>
> I suppose mention of the code page vs. fonts issue should go there, too.
> Bob

Bob,

There is also a section in the FAQ, "Why don't international (8-bit)
characters work?", that might need updating...
	Igor
-- 
				http://cs.nyu.edu/~pechtcha/
      |\      _,,,---,,_		pechtcha@cs.nyu.edu
ZZZzz /,`.-'`'    -.  ;-;;,_		igor@watson.ibm.com
     |,4-  ) )-,_. ,\ (  `'-'		Igor Pechtchanski
    '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!

Knowledge is an unending adventure at the edge of uncertainty.
  -- Leto II
