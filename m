From: Christopher Faylor <cgf@redhat.com>
To: Cygwin-patches <cygwin-patches@sources.redhat.com>
Subject: Re: Exception using GDB
Date: Wed, 25 Jul 2001 14:32:00 -0000
Message-id: <20010725173223.A11993@redhat.com>
References: <047f01c114ee$38e66600$0300a8c0@ufo> <996096632.17154.7.camel@lifelesswks>
X-SW-Source: 2001-q3/msg00034.html

On Thu, Jul 26, 2001 at 07:30:32AM +1000, Robert Collins wrote:
>On 25 Jul 2001 19:12:05 +0930, Trevor Forbes wrote:
>> A fix for the bad pointer exception when a debugger is attached. 
>> 
>>  * thread.cc (verifyable_object_isvalid): Don't validate
>> PTHREAD_MUTEX_INITIALIZER pointer as it will cause an exception in
>> IsBadWritePtr() when running GDB.
>> 
>> Note, Insight has a bug and it will not work without this patch.... 
>> 
>> Trevor
>> 
>Thanks Trevor, that looks good.
>
>Chris - can you do the honours, or would you like me to?

Go ahead, Rob.

cgf
