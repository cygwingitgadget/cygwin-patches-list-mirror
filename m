Return-Path: <cygwin-patches-return-3769-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15665 invoked by alias); 27 Mar 2003 18:45:17 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 15653 invoked from network); 27 Mar 2003 18:45:16 -0000
X-Authentication-Warning: slinky.cs.nyu.edu: pechtcha owned process doing -bs
Date: Thu, 27 Mar 2003 18:45:00 -0000
From: Igor Pechtchanski <pechtcha@cs.nyu.edu>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] New '--install-type' option for cygcheck?
In-Reply-To: <20030327183835.GM12539@redhat.com>
Message-ID: <Pine.GSO.4.44.0303271344010.561-100000@slinky.cs.nyu.edu>
Importance: Normal
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2003-q1/txt/msg00418.txt.bz2

On Thu, 27 Mar 2003, Christopher Faylor wrote:

> On Thu, Mar 27, 2003 at 07:30:42AM -0000, Elfyn McBratney wrote:
> >I've been working on a new option for `cygcheck' that checks who Cygwin was
> >installed for. This could be used when users on the mailing list have
> >problems running services when the installation was done for "Just Me",
> >executing files in the same situation etc. Would this be a desirable
> >feature? Yes/no...patch attached :-)
>
> Doesn't cygcheck already report the appropriate registry keys from HKLM
> and HKCU?  If not, I think that just reporting the keys from both of those
> is all that we really need to do rather than adding a special option.
> cgf

'cygcheck -svr' already reports both the HKLM and HKCU keys.  It also
displays both user and system mounts.
	Igor
-- 
				http://cs.nyu.edu/~pechtcha/
      |\      _,,,---,,_		pechtcha@cs.nyu.edu
ZZZzz /,`.-'`'    -.  ;-;;,_		igor@watson.ibm.com
     |,4-  ) )-,_. ,\ (  `'-'		Igor Pechtchanski
    '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!

Oh, boy, virtual memory! Now I'm gonna make myself a really *big* RAMdisk!
  -- /usr/games/fortune
