Return-Path: <cygwin-patches-return-3013-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 23222 invoked by alias); 20 Sep 2002 15:47:19 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 23208 invoked from network); 20 Sep 2002 15:47:19 -0000
Date: Fri, 20 Sep 2002 08:47:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] new mutex implementation 2. posting
Message-ID: <20020920154735.GF24740@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.WNT.4.44.0209201428100.279-100000@algeria.intern.net> <1032525980.9116.55.camel@lifelesswks>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1032525980.9116.55.camel@lifelesswks>
User-Agent: Mutt/1.4i
X-SW-Source: 2002-q3/txt/msg00461.txt.bz2

On Fri, Sep 20, 2002 at 10:46:15PM +1000, Robert Collins wrote:
>On Fri, 2002-09-20 at 22:43, Thomas Pfaff wrote:
>> 
>> 
>> On Fri, 20 Sep 2002, Robert Collins wrote:
>> 
>> > On Tue, 2002-09-17 at 19:34, Thomas Pfaff wrote:
>> >
>> > Thomas, the patch is incomplete.
>> >
>> > pthread_cond::TimedWait needs updating as well...
>> 
>> Yup, but it seems that this was broken on NT before i made my changes,
>> because it was never updated to use Critical Sections when they are
>> available.
> 
>Uhmm, it was working for me :}. anyway, if you can make that consistent,
>I will apply the semaphore based mutex code. I'm not 100% behind it, I
>think we need to benchmark it, but lacking the facilities, I'm going to
>accept it and tune later.

I haven't been following very closely.  Is the reason why we are not using
critical sections that TryEnterCriticalSection isn't available anywhere?
If so, then we can probably fix that with some assembly programming.

Critical sections are *so* much faster than mutexes or semaphores that
it makes sense to use them if possible.

Or, maybe we're talking about something else entirely...

cgf
