Return-Path: <cygwin-patches-return-4008-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3577 invoked by alias); 12 Jul 2003 19:09:46 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 3568 invoked from network); 12 Jul 2003 19:09:46 -0000
X-Authentication-Warning: slinky.cs.nyu.edu: pechtcha owned process doing -bs
Date: Sat, 12 Jul 2003 19:09:00 -0000
From: Igor Pechtchanski <pechtcha@cs.nyu.edu>
Reply-To: cygwin-patches@cygwin.com
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: Problems on accessing Windows network resources
In-Reply-To: <20030712155608.GP12368@cygbert.vinschen.de>
Message-ID: <Pine.GSO.4.44.0307121509150.6088-100000@slinky.cs.nyu.edu>
Importance: Normal
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2003-q3/txt/msg00024.txt.bz2

On Sat, 12 Jul 2003, Corinna Vinschen wrote:

> On Sat, Jul 12, 2003 at 09:37:37AM -0400, Pierre A. Humblet wrote:
> > At 10:31 AM 7/12/2003 +0200, Corinna Vinschen wrote:
> >
> > >thanks for the patch but it has a problem.  You're comparing tokens against
> > >NULL while the correct "NULL" value for tokens is INVALID_HANDLE_VALUE.
> >
> > Corinna,
> >
> > That's by design, using of Chris' astute observations. As he once
> > pointed out, INVALID_HANDLE_VALUE is the value returned in case of error
> > but NULL is not a legal handle value either, as implied by CreateFile
> > itself. Microsoft is using NULL handle values all the time. For the
> > specific case of a NULL token handle, see SetThreadToken.
>
> What I don't like is that tokens can get both values now.  Most of the
> time they are initialized to INVALID_HANDLE_VALUE, your code introduces
> additionally NULL values.  At one point we will suddenly get a problem
> because a `if (!foo_token)' doesn't handle the INVALID_HANDLE_VALUE case.
>
> Regardless if INVALID_HANDLE_VALUE or NULL is the correct value, I want
> to see only one of them used in Cygwin internally.
>
> Corinna

How about an IS_VALID_TOKEN() macro?
	Igor
-- 
				http://cs.nyu.edu/~pechtcha/
      |\      _,,,---,,_		pechtcha@cs.nyu.edu
ZZZzz /,`.-'`'    -.  ;-;;,_		igor@watson.ibm.com
     |,4-  ) )-,_. ,\ (  `'-'		Igor Pechtchanski, Ph.D.
    '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!

"I have since come to realize that being between your mentor and his route
to the bathroom is a major career booster."  -- Patrick Naughton
