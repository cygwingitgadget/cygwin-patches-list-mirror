Return-Path: <cygwin-patches-return-3725-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23717 invoked by alias); 20 Mar 2003 01:31:32 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 23659 invoked from network); 20 Mar 2003 01:31:31 -0000
Date: Thu, 20 Mar 2003 01:31:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Add unsigned long Interlocked functions
Message-ID: <20030320013139.GA32580@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.WNT.4.44.0303191441120.257-200000@algeria.intern.net> <1048116013.5689.188.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1048116013.5689.188.camel@localhost>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2003-q1/txt/msg00374.txt.bz2

On Thu, Mar 20, 2003 at 10:20:14AM +1100, Robert Collins wrote:
>Looks good to me. Chris, you happy with the winbase stuff?

I am not sure I understand the need for the UL uses since they are
just wrappers around InterlockedIncrement.  Why lie about this by
removing the typecasts?

Also, although it has nothing to do with this particular patch, I can
see that some (1 == foo) style conditional tests have crept in.  While I
understand why some people like this, this usage is counter to the rest
of cygwin which uses foo == 1.

cgf

>On Thu, 2003-03-20 at 00:49, Thomas Pfaff wrote:
>> 2003-03-19  Thomas Pfaff  <tpfaff@gmx.net>
>> 
>> 	* thread.cc (pthread_cond::Wait): Remove typecasts for unsigned
>> 	long values when calling Interlocked functions. Use new UL functions
>> 	instead.
>> 	(pthread_mutex::_Lock): Ditto.
>> 	(pthread_mutex::_TryLock): Ditto.
>> 	* winbase.h (InterlockedIncrementUL): New inline function for type
>> 	safety with unsigned parameters.
>> 	(InterlockedDecrementUL): Ditto.
>> 	(InterlockedExchangeUL): Ditto.
>> 	(InterlockedCompareExchangeUL): Ditto.
