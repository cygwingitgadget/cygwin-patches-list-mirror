Return-Path: <cygwin-patches-return-5393-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8605 invoked by alias); 29 Mar 2005 18:53:04 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8546 invoked from network); 29 Mar 2005 18:52:57 -0000
Received: from unknown (HELO CLEMSON.EDU) (130.127.28.87)
  by sourceware.org with SMTP; 29 Mar 2005 18:52:57 -0000
Received: from [130.127.121.232] (130-127-121-232.generic.clemson.edu [130.127.121.232])
	(authenticated bits=0)
	by CLEMSON.EDU (8.13.1/8.13.1) with ESMTP id j2TIqerk006889
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <cygwin-patches@cygwin.com>; Tue, 29 Mar 2005 13:52:49 -0500 (EST)
Message-ID: <4249A3F0.6020007@gawab.com>
Date: Tue, 29 Mar 2005 18:53:00 -0000
From: Nicholas Wourms <nwourms@gawab.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.2) Gecko/20040804 MultiZilla/1.7.0.2b (ax) Mnenhy/0.7.1
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH]: "decorate" gcc extensions with __extension__
References: <20050327065657.21624.qmail@gawab.com> <20050329104322.GB28534@cygbert.vinschen.de>
In-Reply-To: <20050329104322.GB28534@cygbert.vinschen.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Level: x
X-SW-Source: 2005-q1/txt/msg00096.txt.bz2

Corinna Vinschen wrote:
> I don't quite understand why it's necessary to build Cygwin using pedantic
> mode.

In order to catch thinko's and other silly mistakes which might not 
otherwise show up at regular warning levels.  Even little warnings, like 
comparing signed with unsigned, can lead to trouble.  Being able to 
identify potential problem areas is important.  Catching the smaller 
bugs just isn't possible at the current warning level.  The difference 
between the current warning level and pedantic are not just warnings for 
gcc extensions alone.  Since I assume you and Chris are quite familiar 
with gcc, I will not waste your time by going into detail regarding what 
all pedantic covers.  The bottom line is that giving the developer the 
ability to compile at that level can provide one more opportunity to 
catch a bug before it manifests itself.

> Cygwin is certainly never meant to be built in pedantic mode

I'm sorry you feel this way, but I think that it is a bad attitude. 
Pedantic mode exposes many warnings which are useful, but not present in 
-Wall.  The only reason it isn't meant to build at that level is because 
  nobody has taken the time to go through and address the minor issues 
which cause it to fail building at that level.

> and it's an annoying mess to have to care for this all the time instead of fixing the
> real problems.

Give me a break, the work is already done (by me).  This is no more 
difficult to maintain then any other attribute flags.  You set it and 
forget it.  Remove it when you remove the statement, it doesn't get 
easier then that.  I'm not asking you to do the work of identifying 
issues which do not allow compiling at pedantic mode, I've already done 
that.  I know there is much to be done in terms of work on Cygwin, but 
as I've mentioned before, I think allowing a higher warning level is 
useful for catching minor bugs which might otherwise go unnoticed.  You 
make it seem as if the warnings produced are irrelevant, which is a 
rather dangerous assumption.

I might point out that GCC extensions aren't necessarily bad, which is 
why I opted to tag and not to change them.  I do not consider them 
"bugs" which I do not want to fix.  My point was that they weren't 
standard and had potential for abuse if not used correctly and that 
later on down the line, alternatives should be considered.

> If you personally have fun to build Cygwin in pedantic mode,
> go ahead,

It isn't a matter of "fun", it's a matter of correctness.  I'll admit 
that fixing whitespace and code style isn't glamorous, but it has to be 
done sooner or later.  Many other projects have janitors, such as the 
Linux Kernel, so why not Cygwin?

> but don't expect that the whole code will be changed to support
> it.

I'm note trying to be inflammatory, but that is a totally asinine 
statement.  My changes are:

1) Very low maintenance.
2) Non-invasive.
3) Average 1 - 2 lines in most cases.

I hardly think that constitutes "changing" the entire code.  In fact it 
only changes like 1/10000 of the code base.

 > If you find real bugs by using pedantic mode, then better send fixes
> for those bugs.

Well it seems to me that one cannot identify bugs using pedantic mode if 
one cannot compile at that mode.  My objective it to take care of the 
outstanding issues which currently cause it to fail.  After that, it 
will be easier to identify relevant warnings.  In the process of this, I 
will be submitting changes which fix potential bugs, but I had to start 
somewhere, so I started with getting the extensions out of the way.

To give you a taste of what other changes I plan to submit:

1) Squashing "unused" parameter warnings
2) Squashing warnings cause by "a ?:c" (the correct GNU approved way of 
writing that is "a ? a : c").
3) Squashing instances of illegal comparisons without proper casts.

Quite frankly, I'm a bit surprised by the hostility you have towards 
this patch.  If anything, I thought you'd be pleased to see someone 
tackle the minor stuff which no one else wants to.

I hope this improves your understanding of my motives and why this patch 
is worthwhile.

Cheers,
Nicholas
