Return-Path: <cygwin-patches-return-2832-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 4713 invoked by alias); 15 Aug 2002 20:39:56 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4669 invoked from network); 15 Aug 2002 20:39:55 -0000
Date: Thu, 15 Aug 2002 13:39:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] new mutex implementation
Message-ID: <20020815204008.GD21949@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.WNT.4.44.0208152047310.-376009@thomas.kefrig-pfaff.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.WNT.4.44.0208152047310.-376009@thomas.kefrig-pfaff.de>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q3/txt/msg00280.txt.bz2

On Thu, Aug 15, 2002 at 09:19:52PM +0200, Thomas Pfaff wrote:
>
>This patch contains a new mutex implementation.
>
>The advantages are:
>
>- Same code on Win9x and NT. Actual are critical sections used on NT and
>kernel mutexes on 9x.
>- Posix compliant error codes.
>- State is preserved after fork as it should.
>- Supports both errorchecking and recursive mutexes.
>- Should be at least as fast as critical sections.
>- Will make us all rich and happy.
>
>Unfortunately the pthread_mutex_trylock call requires
>InterlockedCompareExchange that is not available on Win95.
>See my next patch for a workaround.
>
>Just like critical sections it will use a counter and a semaphore to block
>other threads. The semaphore is only used when at least one thread is
>waiting, otherwise a kernel transition is not needed.

This sounds suspiciously like a 'muto'.

I mentioned a while ago that the muto concept might be useful for
generic use in pthreads but that I didn't want to add any overhead to
the existing muto definition, preferring (essentially) a copy + paste
+ augment into the pthread call.

IIRC, Robert then posted a change to the muto implementation which added
existing overhead to the existing implementation, i.e., the opposite of
what I'd asked for.

I may be misremembering this but you should be able to find the discussion
in the cygwin-developers/cygwin-patches archives.  I doubt that the word 'muto'
shows up too often there.

However, I'd be interested in looking at your implementation.  I don't think
you attached the actual patch to your message.

cgf
