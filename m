Return-Path: <cygwin-patches-return-2625-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 7430 invoked by alias); 11 Jul 2002 02:06:05 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 7415 invoked from network); 11 Jul 2002 02:06:05 -0000
Date: Wed, 10 Jul 2002 19:06:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] pthread_key patch
Message-ID: <20020711020610.GA17490@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20020705171052.GF30783@redhat.com> <Pine.WNT.4.44.0207080926450.118-100000@algeria.intern.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.WNT.4.44.0207080926450.118-100000@algeria.intern.net>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q3/txt/msg00073.txt.bz2

On Mon, Jul 08, 2002 at 09:38:07AM +0200, Thomas Pfaff wrote:
>
>
>On Fri, 5 Jul 2002, Christopher Faylor wrote:
>
>> On Fri, Jul 05, 2002 at 08:50:21AM +0200, Thomas Pfaff wrote:
>> >If somebody is interested why if find this patch neccessary with a posix
>> >threaded gcc could read
>> >http://cygwin.com/ml/cygwin-patches/2002-q2/msg00214.html
>>
>> Can you summarize why you need to explicitly run destructors on process
>> detach?  It seems like this should happen automatically anyway.  I assume
>> that you're accessing thread-local storage on thread detach, so that's
>> why you need to do things then.  Process detach on the other hand...
>>
>
>This is pthread feature, i am not calling any of my own destructors.
>
>Pthread keys can have an additional destructor function that is called
>when the thread is terminated. The 2.95.3 gcc use this feature to free the
>thread specific exception context.
>In the actual pthread code these destructor functions are called in
>pthread_exit, but this works only for threads that have been created
>pthread_create, but not with CreateThread. IMHO cygwin should support both
>ways.
>
>The reason why i have added it to PROCESS_DETACH too is that the last
>terminating thread is detached in PROCESS_DETACH, not in THREAD_DETACH.

Ok.  Got it.  I thought that you were using standard c++ constructors.
I apologize for not checking more closely.

I'll let Robert comment on the efficacy of this patch.

cgf
