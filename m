From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Bugfix for pthread_cond_init
Date: Fri, 16 Mar 2001 20:50:00 -0000
Message-id: <20010316235021.B4725@redhat.com>
References: <02b401c0ae9c$d58d43b0$0200a8c0@lifelesswks>
X-SW-Source: 2001-q1/msg00193.html

On Sat, Mar 17, 2001 at 03:43:36PM +1100, Robert Collins wrote:

>Saturday Mar 17 3:45 2001 Robert Collins <rbtcollins@hotmail.com>
>
>	* thread.cc (MTinterface::CreateCond): Check for null attr pointer.

Applied, modulo some ChangeLog surgery.

Thanks.

cgf
