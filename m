Return-Path: <cygwin-patches-return-1765-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 32509 invoked by alias); 23 Jan 2002 17:21:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 32495 invoked from network); 23 Jan 2002 17:21:46 -0000
Date: Wed, 23 Jan 2002 09:21:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-Patches@cygwin.com
Subject: Re: include/sys/strace.h
Message-ID: <20020123172219.GC6765@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-Patches@cygwin.com
References: <3C4E0C9F.1BEECC02@yahoo.com> <3C4EC73A.B63A8371@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C4EC73A.B63A8371@yahoo.com>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q1/txt/msg00122.txt.bz2

On Wed, Jan 23, 2002 at 09:22:50AM -0500, Earnie Boyd wrote:
>Any objection to this patch?  Can I apply it?

I'm sorry Earnie.  I really don't see any reason for it and can't imagine
that it would be very useful to me.

cgf

>Earnie Boyd wrote:
>> 
>> I've created simple macros to set strace.active ON or OFF when
>> --enable-debugging is enabled.
>> 
>> Comments?
>> 
>> Earnie.
>> 
>>   ------------------------------------------------------------------------
>> 2002.01.22  Earnie Boyd  <earnie@users.sf.net>
>> 
>>         * include/sys/strace.h (_STRACE_ON): Define.
>>         (_STRACE_OFF): Ditto.
>> 
>> Index: strace.h
>> ===================================================================
>> RCS file: /cvs/src/src/winsup/cygwin/include/sys/strace.h,v
>> retrieving revision 1.12
>> diff -u -3 -p -r1.12 strace.h
>> --- strace.h    2001/04/03 02:53:25     1.12
>> +++ strace.h    2002/01/23 01:00:40
>> @@ -77,6 +77,13 @@ extern strace strace;
>>  #define _STRACE_MALLOC  0x20000 // trace malloc calls
>>  #define _STRACE_THREAD  0x40000 // thread-locking calls
>>  #define _STRACE_NOTALL  0x80000 // don't include if _STRACE_ALL
>> +#if defined (DEBUGGING)
>> +# define _STRACE_ON strace.active = 1;
>> +# define _STRACE_OFF strace.active = 0;
>> +#else
>> +# define _STRACE_ON
>> +# define _STRACE_OFF
>> +#endif
>> 
>>  #ifdef __cplusplus
>>  extern "C" {
