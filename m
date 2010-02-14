Return-Path: <cygwin-patches-return-6966-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27819 invoked by alias); 14 Feb 2010 19:06:37 -0000
Received: (qmail 27807 invoked by uid 22791); 14 Feb 2010 19:06:36 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-173-76-58-83.bstnma.fios.verizon.net (HELO cgf.cx) (173.76.58.83)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sun, 14 Feb 2010 19:06:32 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5]) 	by cgf.cx (Postfix) with ESMTP id 210DA3B0002 	for <cygwin-patches@cygwin.com>; Sun, 14 Feb 2010 14:06:23 -0500 (EST)
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id 1EFBB2B35A; Sun, 14 Feb 2010 14:06:23 -0500 (EST)
Date: Sun, 14 Feb 2010 19:06:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Add xdr support
Message-ID: <20100214190623.GB19242@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4B764A1F.6060003@cwilson.fastmail.fm>  <20100213113509.GJ5683@calimero.vinschen.de>  <4B76C334.8080101@cwilson.fastmail.fm>  <20100213210122.GA20649@ednor.casa.cgf.cx>  <4B773B70.8040208@cwilson.fastmail.fm>  <4B778315.9090300@gmail.com>  <4B778E43.5020701@cwilson.fastmail.fm>  <4B7834AD.3040606@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4B7834AD.3040606@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2010-q1/txt/msg00082.txt.bz2

On Sun, Feb 14, 2010 at 05:36:45PM +0000, Dave Korn wrote:
>On 14/02/2010 05:46, Charles Wilson wrote:
>> Dave Korn wrote:
>>> On 13/02/2010 23:53, Charles Wilson wrote:
>>>
>>>> http://cygwin.com/ml/cygwin-developers/2009-10/msg00242.html
>>>> IIRC at that time Corinna suggested that newlib was the appropriate
>>>> place for this, if I wanted to contribute it post-1.7.1. 
>>> http://cygwin.com/ml/cygwin-developers/2009-10/msg00254.html
>>>
>>>> I asked how to
>>>> go about adding something to newlib that might not work for all targets,
>>>> and she said:
>>>> Unfortunately, my google-foo is not strong enough to find that message
>>>> in the cygwin archives, 
>>> http://cygwin.com/ml/cygwin-developers/2009-10/msg00259.html
>> 
>> I bow to your superior google-foo. 
>
>  I just went from the first post you listed to the thread view and read all
>the followups.  More like mechanical turk version of a search algorithm than
>any kind of google-fu on my part!
>
>  ObTopic: I think newlib would be a nice place to put this functionality,
>particularly since you've already gone to the trouble of fitting it into the
>framework.  It's entirely plausible that the newlib linux targets would find
>this code useful as well.  "Small embedded system" doesn't mean "not
>network-connected" any more these days, not by a long way, so I think it is a
>suitable and appropriate thing to propose adding to newlib.

You could make the same argument for much of the functionality we've
added to cygwin.  I'm sure a significant number of functions could be
added to newlib if we were so inclined.  Just take a look at the libc
directory or the regex directory.

One of my problems with newlib is that, once this is added, you'll need
to get permission from Jeff J. for any future modifications - with all of
the bottleneck potential that involves.  The other problem is that you
potentially have to deal with the other truly embedded projects which
use the library.  They sometimes have objections to the way things
are implemented.

(And I hate having to use _DEFUN in the year 2010)

And, although it doesn't apply in this case, if I was Red Hat, I'd be
leery about allowing major new functionality into newlib because it
dilutes their Cygwin ownership.  How can you claim to own something like
Cygwin when a major amount of the code is added and modified without a
license assignment?

I understand why, from a purist's point of view, someone might think
this belongs in newlib.  I just think that adding things to newlib
means more hoops to jump through for the Cygwin project.  I'm more
concerned about that than I am about newlib's project definition.

All of that said, however, I'll leave it up to Chuck.  I assume that
since he's already done the work for newlib it would be a lot of extra
work to get this into Cygwin.  I'm not going to offer any objections
if this gets accepted to newlib.

cgf
