From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: exceptions.cc (call_signal_handler_now)
Date: Mon, 09 Apr 2001 09:13:00 -0000
Message-id: <20010409121337.B29944@redhat.com>
References: <3ACC7EFA.D650E2D3@yahoo.com> <20010408204539.A23313@redhat.com> <3AD1AB3E.675C33B6@yahoo.com>
X-SW-Source: 2001-q2/msg00021.html

On Mon, Apr 09, 2001 at 08:29:50AM -0400, Earnie Boyd wrote:
>Christopher Faylor wrote:
>> 
>> I think that I came up with a way to avoid "externalizing" this function.
>> It's a kludge, but as far as I can tell, it seems to work with both the
>> newer (3.1) and older (2.95.3) gcc's.
>> 
>> It's in CVS now.  If this doesn't work for you, I'll break down and
>> pollute the global name space.
>
>It works. :)

Hey, that's good news!  This is truly a horrible kludge but, IMO, it is
marginally better than forcing a function to be global.

cgf
