Return-Path: <cygwin-patches-return-3010-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 6223 invoked by alias); 20 Sep 2002 13:06:40 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 6205 invoked from network); 20 Sep 2002 13:06:38 -0000
X-Authentication-Warning: atacama.four-d.de: mail set sender to <tpfaff@gmx.net> using -f
Date: Fri, 20 Sep 2002 06:06:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
To: Robert Collins <rbcollins@cygwin.com>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] pthread_fork Part 3
In-Reply-To: <1032526255.9135.61.camel@lifelesswks>
Message-ID: <Pine.WNT.4.44.0209201453550.344-100000@algeria.intern.net>
X-X-Sender: pfaff@antarctica.intern.net
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2002-q3/txt/msg00458.txt.bz2



On Fri, 20 Sep 2002, Robert Collins wrote:

> On Sat, 2002-08-17 at 06:55, Thomas Pfaff wrote:
> >
> > Pthread key destructor handling revised. IMHO it does not make sense to
> > handle two lists with keys, one with all keys, one with its destructors.
> > The destructors are now part of the key class.
>
> I agree with the duplication of code. This is one area I'd really really
> really like to use templates.
>
> Chris, Corinna, if we ever get the chance to use templates please tell
> me so! It makes code clarity and size so much better.
>
> Anyway, yes, we should only have one list. So yes, please do refactor
> the two together in the way I've arranged the pthread_keys::keys list.
>
> Note that you have a comment on non thread safeness in the new
> pthread_keys code. I thought I had addressed that in my list code, could
> you either tell me I was also not thread safe, or correct that at the
> same time?

While the list has thread safe inserts and deletes via Interlocked
functions it can be theoretically possible that a thread deletes a key
while another run the destructor function of exactly this key which will
lead to an segfault. IMHO the possibility that this will ever happen is 0,
because keys are normally created at program start and deleted at the end
and not dynamically created and destroyd.

If you want to work around this you must use a mutex to protect the entire
list.

Thomas
