Return-Path: <cygwin-patches-return-3765-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12125 invoked by alias); 27 Mar 2003 15:58:42 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 12115 invoked from network); 27 Mar 2003 15:58:41 -0000
X-Authentication-Warning: slinky.cs.nyu.edu: pechtcha owned process doing -bs
Date: Thu, 27 Mar 2003 15:58:00 -0000
From: Igor Pechtchanski <pechtcha@cs.nyu.edu>
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] New '--install-type' option for cygcheck?
In-Reply-To: <20030327094634.GE23762@cygbert.vinschen.de>
Message-ID: <Pine.GSO.4.44.0303271056340.561-100000@slinky.cs.nyu.edu>
Importance: Normal
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2003-q1/txt/msg00414.txt.bz2

On Thu, 27 Mar 2003, Corinna Vinschen wrote:

> On Thu, Mar 27, 2003 at 08:00:24AM -0000, Elfyn McBratney wrote:
> > > I've been working on a new option for `cygcheck' that checks who Cygwin
> > > was
> > > installed for. This could be used when users on the mailing list have
> > > problems running services when the installation was done for "Just Me",
> > > executing files in the same situation etc. Would this be a desirable
> > > feature? Yes/no...patch attached :-)
> >
> > Sorry, forgot this...
> >
> > 2003-03-27  Elfyn McBratney  <elfyn@exposure.org.uk>
> >
> > * utils/cygcheck.cc (longopts): Add install-type option.
> > (opts): Add 'i' install-type option.
> > (check_install_type): New function.
> > (main): Accommodate new install_type option.
>
> Well, the problem is that you're checking in HKLM first.  You should
> check the HKCU key first since this would override the existing same
> key in HKLM.  Probably it would be nice(tm) if cygcheck reports
> always both keys if they both exist and print some warning about this
> (hmm, I'm musing if it makes sense to print a suggestion to drop the
> HKCU key in that case...)

No, please.  If Cygwin were installed for All Users, but user mounts were
later created with "mount -u", this would cause the situation you
describe.  Since this is a perfectly legitimate use of mount, no warning
is necessary.
	Igor

> Corinna
>
> PS: Your ChangeLog is incorrect (think "tabs") ;-)

-- 
				http://cs.nyu.edu/~pechtcha/
      |\      _,,,---,,_		pechtcha@cs.nyu.edu
ZZZzz /,`.-'`'    -.  ;-;;,_		igor@watson.ibm.com
     |,4-  ) )-,_. ,\ (  `'-'		Igor Pechtchanski
    '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!

Oh, boy, virtual memory! Now I'm gonna make myself a really *big* RAMdisk!
  -- /usr/games/fortune
