Return-Path: <cygwin-patches-return-4616-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27603 invoked by alias); 22 Mar 2004 19:57:43 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 27409 invoked from network); 22 Mar 2004 19:57:42 -0000
Message-ID: <405F4530.F3188C94@phumblet.no-ip.org>
Date: Mon, 22 Mar 2004 19:57:00 -0000
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Reply-To: Pierre.Humblet@ieee.org
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: Win95
References: <405EF9F4.A97FF863@phumblet.no-ip.org> <20040322185405.GA3266@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2004-q1/txt/msg00106.txt.bz2



Christopher Faylor wrote:
> 
> On Mon, Mar 22, 2004 at 09:36:36AM -0500, Pierre A. Humblet wrote:
> >This fixes gnuchess on Win95.
> >There is still a compiler warning, will look at it tonight.
> >Tested on ME, 95 and NT4.0
> >
> >2004-03-22  Pierre Humblet <pierre.humblet@ieee.org>
> >
> >       * init.cc (munge_threadfunc): Handle all instances of search_for.
> >       (prime_threads): Test threadfunc_ix[0].
> 
> Hmm.  So that's what it was.  Thanks for tracking this down.

Can you believe that the address appears 5 times on the stack on Win95,
twice on ME, once on NT4.0?

Now that the method is stable (after 1.5.10 is released), couldn't we store
the offsets in wincap, keeping the adaptive method as a backup in the
unknown case? Or are there many variations?

> I've checked in a variation of this patch.  It fixes the compiler
> warning.  Can you verify that it still works?  I'm also building a
> snapshot.

It works on NT4.0. Will test on 95 and ME this evening.
Do you recall what caused the warning?

Pierre
