Return-Path: <cygwin-patches-return-4872-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17836 invoked by alias); 22 Jul 2004 14:47:18 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 17767 invoked from network); 22 Jul 2004 14:47:15 -0000
X-Authentication-Warning: slinky.cs.nyu.edu: pechtcha owned process doing -bs
Date: Thu, 22 Jul 2004 14:47:00 -0000
From: Igor Pechtchanski <pechtcha@cs.nyu.edu>
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
Subject: Re: Fix dup for /dev/dsp
In-Reply-To: <20040722041721.GA29883@trixie.casa.cgf.cx>
Message-ID: <Pine.GSO.4.58.0407221043180.29040@slinky.cs.nyu.edu>
References: <40FE87D6.3C89AE1F@phumblet.no-ip.org> <40FE87D6.3C89AE1F@phumblet.no-ip.org>
 <3.0.5.32.20040721232519.00810350@incoming.verizon.net>
 <20040722041721.GA29883@trixie.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.39
X-SW-Source: 2004-q3/txt/msg00024.txt.bz2

On Thu, 22 Jul 2004, Christopher Faylor wrote:

> On Wed, Jul 21, 2004 at 11:25:19PM -0400, Pierre A. Humblet wrote:
> >Is it worth to delay 1.5.11 until those issues are sorted out?
>
> No, I don't think so.
>
> We do have people reporting problems with MapViewOfFileEx and with
> threads in perl, now, though.  So, 1.5.11 is not quite cooked.
>
> cgf

Chris,

Unfortunately, the problems with MapViewOfFileEx are elusive and hard to
reproduce, even for some of those people reporting them (i.e., me :-}).
Since they aren't critical for me (I can just re-run the command if I get
one of those), I personally don't mind if 1.5.11 is released without a fix
(unless there's something I can do to help track them down sooner).  I
don't speak for Volker, though.
	Igor
-- 
				http://cs.nyu.edu/~pechtcha/
      |\      _,,,---,,_		pechtcha@cs.nyu.edu
ZZZzz /,`.-'`'    -.  ;-;;,_		igor@watson.ibm.com
     |,4-  ) )-,_. ,\ (  `'-'		Igor Pechtchanski, Ph.D.
    '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!

"I have since come to realize that being between your mentor and his route
to the bathroom is a major career booster."  -- Patrick Naughton
