Return-Path: <cygwin-patches-return-3708-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22677 invoked by alias); 17 Mar 2003 08:17:14 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 22598 invoked from network); 17 Mar 2003 08:17:13 -0000
X-Authentication-Warning: atacama.four-d.de: mail set sender to <tpfaff@gmx.net> using -f
Date: Mon, 17 Mar 2003 08:17:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
To: "Cygwin (Robert Collins)" <rbcollins@cygwin.com>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] add support for PTHREAD_MUTEX_NORMAL
In-Reply-To: <003201c2e924$e6077ca0$0400a8c0@robertcollins.net>
Message-ID: <Pine.WNT.4.44.0303170853450.77-100000@algeria.intern.net>
X-X-Sender: pfaff@antarctica.intern.net
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2003-q1/txt/msg00357.txt.bz2



On Thu, 13 Mar 2003, Cygwin (Robert Collins) wrote:

> This:
>
>    if (1 == InterlockedIncrement ((long *)&lock_counter))
>
> is not safe. You can only check for equal to 0, less than 0, and greater
> than 0 with InterlockedIncrement | Decrement.
>

The xadd based inline interlocked functions in winbase.h are now enabled
by default, so it is valid to test for 1 at this point.
It looks much cleaner to me to start a counter at 0 not at -1.
And the code now supports UINT_MAX instead of INT_MAX waiting
threads (even if INT_MAX threads are only academicical i see no reason to
add a limit here).

> Secondly, IIRC lock_counter should be long, so the (long *) typecasting
> isn't needed.

IMHO it should be unsigned since it makes no sense to have negative
counter values. In practice it doesn't make any difference because there
are not greater or smaller equations in the code.

Thomas
