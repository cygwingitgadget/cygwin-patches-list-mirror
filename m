Return-Path: <cygwin-patches-return-4278-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10601 invoked by alias); 30 Sep 2003 17:20:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 10591 invoked from network); 30 Sep 2003 17:20:45 -0000
X-Authentication-Warning: slinky.cs.nyu.edu: pechtcha owned process doing -bs
Date: Tue, 30 Sep 2003 17:20:00 -0000
From: Igor Pechtchanski <pechtcha@cs.nyu.edu>
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
Subject: Re: New program: cygtweak
In-Reply-To: <20030930170717.GC29428@redhat.com>
Message-ID: <Pine.GSO.4.56.0309301313410.3193@slinky.cs.nyu.edu>
References: <20030927034235.GA18807@redhat.com> <Pine.GSO.4.56.0309271124210.3193@slinky.cs.nyu.edu>
 <20030930121609.GA2022@cygbert.vinschen.de> <Pine.GSO.4.56.0309301058290.3193@slinky.cs.nyu.edu>
 <20030930150956.GE20635@redhat.com> <Pine.GSO.4.56.0309301112320.3193@slinky.cs.nyu.edu>
 <20030930154434.GK20635@redhat.com> <Pine.GSO.4.56.0309301146400.3193@slinky.cs.nyu.edu>
 <20030930155833.GA29428@redhat.com> <Pine.GSO.4.56.0309301238100.3193@slinky.cs.nyu.edu>
 <20030930170717.GC29428@redhat.com>
Importance: Normal
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2003-q3/txt/msg00294.txt.bz2

On Tue, 30 Sep 2003, Christopher Faylor wrote:

> On Tue, Sep 30, 2003 at 12:40:58PM -0400, Igor Pechtchanski wrote:
> >Close enough.
> >So, are we jump-starting the car, or replacing the battery? ;-)
>
> I'm just hoping for someone to come up with a creative name for
> the car.
>
> cgf

"cygferrari"? ;-)

Seriously, though...  "cygprogopts"?  "cygoverride"?  Come to think of it,
"cygoptions" works pretty well, especially if we plan to add other
functionality, such as setting heap_chunk_in_mb & co.  Are there other
(undocumented) options that need this kind of control?  Do we want them
all controlled from one script, or from a set of scripts?  Would it make
sense for the script to act based on a name through which it was invoked,
as well as command line parameters (and provide symlinks with these
names)?

Also, should this script be in /usr/sbin instead?
	Igor
-- 
				http://cs.nyu.edu/~pechtcha/
      |\      _,,,---,,_		pechtcha@cs.nyu.edu
ZZZzz /,`.-'`'    -.  ;-;;,_		igor@watson.ibm.com
     |,4-  ) )-,_. ,\ (  `'-'		Igor Pechtchanski, Ph.D.
    '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!

"I have since come to realize that being between your mentor and his route
to the bathroom is a major career booster."  -- Patrick Naughton
