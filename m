Return-Path: <cygwin-patches-return-4615-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17028 invoked by alias); 22 Mar 2004 18:54:08 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 16636 invoked from network); 22 Mar 2004 18:54:07 -0000
Date: Mon, 22 Mar 2004 18:54:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: Win95
Message-ID: <20040322185405.GA3266@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <405EF9F4.A97FF863@phumblet.no-ip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <405EF9F4.A97FF863@phumblet.no-ip.org>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q1/txt/msg00105.txt.bz2

On Mon, Mar 22, 2004 at 09:36:36AM -0500, Pierre A. Humblet wrote:
>This fixes gnuchess on Win95.
>There is still a compiler warning, will look at it tonight.
>Tested on ME, 95 and NT4.0
>
>2004-03-22  Pierre Humblet <pierre.humblet@ieee.org>
>
>	* init.cc (munge_threadfunc): Handle all instances of search_for.
>	(prime_threads): Test threadfunc_ix[0].

Hmm.  So that's what it was.  Thanks for tracking this down.

I've checked in a variation of this patch.  It fixes the compiler
warning.  Can you verify that it still works?  I'm also building a
snapshot.

I guess I might just extend the time until the release of 1.5.10 since
this is an important fix.

cgf
