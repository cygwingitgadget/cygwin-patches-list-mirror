Return-Path: <cygwin-patches-return-4477-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25775 invoked by alias); 5 Dec 2003 13:03:08 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 25759 invoked from network); 5 Dec 2003 13:03:07 -0000
Message-Id: <3.0.5.32.20031205080236.0082c420@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Fri, 05 Dec 2003 13:03:00 -0000
To: Corinna Vinschen <cygwin-patches@cygwin.com>
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Re: [Patch]: Create Global Privilege
In-Reply-To: <20031205111443.GB2456@cygbert.vinschen.de>
References: <3.0.5.32.20031204221654.0082c250@incoming.verizon.net>
 <3.0.5.32.20031201225546.0082ce20@incoming.verizon.net>
 <20031129230722.GB6964@cygbert.vinschen.de>
 <3.0.5.32.20031125205533.0082b2a0@incoming.verizon.net>
 <3.0.5.32.20031125205533.0082b2a0@incoming.verizon.net>
 <3.0.5.32.20031126104557.00838210@incoming.verizon.net>
 <20031129230722.GB6964@cygbert.vinschen.de>
 <3.0.5.32.20031201225546.0082ce20@incoming.verizon.net>
 <3.0.5.32.20031204221654.0082c250@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2003-q4/txt/msg00196.txt.bz2

At 12:14 PM 12/5/2003 +0100, Corinna Vinschen wrote:
>Two questions:
>
>What is the advantage of using lseek(SEEK_END) and using that value
>for fcntl(F_SETLK, SEEK_SET) over just using fcntl(F_SETLK, SEEK_END)?
>Especially since lseek(SEEK_END) is then called afterwards anyway.

fcntl(F_SETLK, SEEK_END) is extremely risky on Windows because you
don't know what region was actually locked, and an unlock must 
correspond *exactly* to a previous lock.
Somebody else could write to the file between the time fcntl finds
how long it is and the moment it locks it. The unlock you make after
you write will then fail.

>What is the advantage of using a finite loop with fcntl(F_SETLK) over
>using fcntl(F_SETLKW) just once?  This seems potentially less secure
>than F_SETLKW and also less secure than the former Mutex solution.

The only reason is that F_SETLKW doesn't work on 9X so you need
a loop there anyway. But thinking more about it, we should have both
F_SETLKW and a loop. On NT the loop will never kick in. On 9x F_SETLKW 
works like F_SETLK and the loop is useful. The loop could also be made
much longer.

Pierre

