From: Robert Collins <robert.collins@itdomain.com.au>
To: Trevor Forbes <trevorforbes@ozemail.com.au>
Cc: Cygwin-patches <cygwin-patches@sources.redhat.com>
Subject: Re: Exception using GDB
Date: Wed, 25 Jul 2001 14:27:00 -0000
Message-id: <996096632.17154.7.camel@lifelesswks>
References: <047f01c114ee$38e66600$0300a8c0@ufo>
X-SW-Source: 2001-q3/msg00033.html

On 25 Jul 2001 19:12:05 +0930, Trevor Forbes wrote:
> A fix for the bad pointer exception when a debugger is attached. 
> 
>  * thread.cc (verifyable_object_isvalid): Don't validate
> PTHREAD_MUTEX_INITIALIZER pointer as it will cause an exception in
> IsBadWritePtr() when running GDB.
> 
> Note, Insight has a bug and it will not work without this patch.... 
> 
> Trevor
> 
Thanks Trevor, that looks good.

Chris - can you do the honours, or would you like me to?

Rob
