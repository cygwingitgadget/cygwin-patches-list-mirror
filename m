Return-Path: <cygwin-patches-return-2226-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 27019 invoked by alias); 27 May 2002 01:10:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 26977 invoked from network); 27 May 2002 01:10:22 -0000
Date: Sun, 26 May 2002 18:10:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] improve performance of stat() operations (e.g. ls -lR )
Message-ID: <20020527011013.GA15710@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <FE045D4D9F7AED4CBFF1B3B813C85337676295@mail.sandvine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FE045D4D9F7AED4CBFF1B3B813C85337676295@mail.sandvine.com>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q2/txt/msg00210.txt.bz2

On Sun, May 26, 2002 at 08:08:02PM -0400, Don Bowman wrote:
>Christopher Faylor wrote:
>>On Sun, May 26, 2002 at 05:50:13PM -0400, Don Bowman wrote:
>>>
>>>The attached patch adds a new CYGWIN environment variable, statquery. 
>...
>
>>You should get the same effect by mounting directories or files with
>>either the -E or -X option.  And, the control is more pinpoint than an
>>environment variable.
>
>Nope. The behaviour comes from the NT CreateFile() operation, as
>observed with ntfilemon (from www.sysinternals.com). That single
>system call opens the file, reads a bunch of (random) data from
>different offsets. Neither the -E nor the -X to mount has 
>any affect on this.
>
>For interests sake, here's a (non-scientific :) benchmark:
>The cygwin source code (cvs co winsup) ls -lR takes:
>
>57.171s (default options)
> 4.462s (new 'statquery' option)
>44.002s (mount -E option)
>45.171s (mount -X option)
>
>each run was done twice, and the 2nd number taken (to avoid system 
>issues)
>
>You are perhaps correct that making this a mount option rather than
>an env variable would be a good way to go. Its not clear to me why 
>the file is being opened for read during that stat anyway.

Hmm.  Interesting.  It seems like -E and -X should just be defaulting
to doing query_open.  I think that the only reason that query_open
is not the default is that the file has to be opened for reading if
the executable state is not known.

Or, maybe it's actually possible not to do an open at all in those
cases.

Hmm, again.

cgf
