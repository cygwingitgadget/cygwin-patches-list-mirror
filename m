Return-Path: <cygwin-patches-return-4209-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30172 invoked by alias); 11 Sep 2003 16:00:56 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30144 invoked from network); 11 Sep 2003 16:00:54 -0000
X-Authentication-Warning: slinky.cs.nyu.edu: pechtcha owned process doing -bs
Date: Thu, 11 Sep 2003 16:00:00 -0000
From: Igor Pechtchanski <pechtcha@cs.nyu.edu>
Reply-To: cygwin-patches@cygwin.com
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] cygcheck: do not check package integrity with a -d flag
In-Reply-To: <20030911155904.GA9981@cygbert.vinschen.de>
Message-ID: <Pine.GSO.4.56.0309111200160.5235@slinky.cs.nyu.edu>
References: <Pine.GSO.4.56.0309111108450.5235@slinky.cs.nyu.edu>
 <20030911155904.GA9981@cygbert.vinschen.de>
Importance: Normal
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2003-q3/txt/msg00225.txt.bz2

On Thu, 11 Sep 2003, Corinna Vinschen wrote:

> On Thu, Sep 11, 2003 at 11:12:36AM -0400, Igor Pechtchanski wrote:
> > Hi,
> >
> > As requested on cygwin-developers@ and cygwin@, this patch adds a flag
> > ("-d", or "--dump-only") that instructs cygcheck to not check for the
>
> Shouldn't that be --dumb-only?

Would you believe I debated with myself on this one?.. ;-)

> SCNR,
> I'm going to check it in,
> Corinna

Thanks,
	Igor
-- 
				http://cs.nyu.edu/~pechtcha/
      |\      _,,,---,,_		pechtcha@cs.nyu.edu
ZZZzz /,`.-'`'    -.  ;-;;,_		igor@watson.ibm.com
     |,4-  ) )-,_. ,\ (  `'-'		Igor Pechtchanski, Ph.D.
    '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!

"I have since come to realize that being between your mentor and his route
to the bathroom is a major career booster."  -- Patrick Naughton
