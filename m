Return-Path: <cygwin-patches-return-4617-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3588 invoked by alias); 22 Mar 2004 20:20:09 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 3567 invoked from network); 22 Mar 2004 20:20:05 -0000
Date: Mon, 22 Mar 2004 20:20:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: Win95
Message-ID: <20040322202004.GA522@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <405EF9F4.A97FF863@phumblet.no-ip.org> <20040322185405.GA3266@redhat.com> <405F4530.F3188C94@phumblet.no-ip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <405F4530.F3188C94@phumblet.no-ip.org>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q1/txt/msg00107.txt.bz2

On Mon, Mar 22, 2004 at 02:57:36PM -0500, Pierre A. Humblet wrote:
>
>
>Christopher Faylor wrote:
>> 
>> On Mon, Mar 22, 2004 at 09:36:36AM -0500, Pierre A. Humblet wrote:
>> >This fixes gnuchess on Win95.
>> >There is still a compiler warning, will look at it tonight.
>> >Tested on ME, 95 and NT4.0
>> >
>> >2004-03-22  Pierre Humblet <pierre.humblet@ieee.org>
>> >
>> >       * init.cc (munge_threadfunc): Handle all instances of search_for.
>> >       (prime_threads): Test threadfunc_ix[0].
>> 
>> Hmm.  So that's what it was.  Thanks for tracking this down.
>
>Can you believe that the address appears 5 times on the stack on Win95,
>twice on ME, once on NT4.0?

I noticed that it was twice on ME and always wondered if I would have to
do something like you did.  For some reason, it never occurred to me that
this would be the problem on Win95.

The other thing that always amazed me is the spurious thread creation that
occurs when a process is starting up.  WinME, at least, can start a couple
of threads before ever hitting main.

>Now that the method is stable (after 1.5.10 is released), couldn't we store
>the offsets in wincap, keeping the adaptive method as a backup in the
>unknown case? Or are there many variations?

I guess it's a possibility but the overhead should be pretty low now.

>> I've checked in a variation of this patch.  It fixes the compiler
>> warning.  Can you verify that it still works?  I'm also building a
>> snapshot.
>
>It works on NT4.0. Will test on 95 and ME this evening.
>Do you recall what caused the warning?

The for loop had something like this:

int i;
for (char **peb = ebp, i = 0;

That defined a char **i rather than using the 'int i'.

I also got rid of a goto.

cgf
